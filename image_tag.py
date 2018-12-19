from subprocess import check_output

import json
import re
import subprocess
import sys
import time


def check_status_code(container_name, image):
    # start and waiting for mysql and frappe web client to start
    subprocess.call([
        'docker', 'run', '-d',
        '-p', '8000:8000',
        '-p', '9000:9000',
        '--name', container_name,
        image
    ])
    time.sleep(120)

    # debug
    docker_logs = check_output([
        'docker', 'logs', container_name
        ]).decode('utf-8')
    print(docker_logs)
    docker_info = check_output([
        'docker', 'inspect', container_name
        ]).decode('utf-8')
    print(docker_info)

    # check server status
    server_status = check_output([
        'docker', 'exec', container_name, 'python', 'test_server.py'
        ]).decode('utf-8')

    # remove container
    subprocess.call(['docker', 'rm', '-f', container_name])

    return server_status.strip()


def get_app_version(image):
    # get app version
    apps_version = check_output([
        'docker', 'run', '--rm', image, 'bench', 'version'
        ]).decode('utf-8')

    # clean app version str & get version list
    apps = {
        'erpnext': {},
        'frappe': {},
        }
    for app in apps:
        app_version = re.search('{}(.+?)\\n'.format(app), apps_version)
        app_version = app_version.group(0)
        app_version = app_version.replace(app, '')
        app_version = app_version.strip()
        apps[app]['version_str'] = app_version
        app_version = re.findall(r"[\w']+", app_version)
        apps[app]['version_list'] = app_version

    e = apps['erpnext']['version_list']
    f = apps['frappe']['version_list']

    # find higher version
    higher_app_version = ''
    for idx, val in enumerate(e):
        if e[idx].isdigit():
            if e[idx] != f[idx]:
                if e[idx] > f[idx]:
                    higher_app_version = e
                    break
                else:
                    higher_app_version = f
                    break

    if higher_app_version == e:
        return apps['erpnext']['version_str']
    else:
        return apps['frappe']['version_str']


def tag_image(app_version, img_name, img_tag):
    # remove first 3 character of tag (mas, dev, sta) &
    # remove last 7 -latest
    img_tag_trailing = img_tag[3:-7]

    # prepare image name 
    app_version_tag = '{app_version}{img_tag_trailing}'.format(
        app_version=app_version,
        img_tag_trailing=img_tag_trailing
    )
    app_version_name = '{img_name}:{app_version_tag}'.format(
        img_name=img_name,
        app_version_tag=app_version_tag
        )
    app_image_name = '{img_name}:{img_tag}'.format(
        img_name=img_name,
        img_tag=img_tag
        )

    # get all tags
    api_url = 'https://registry.hub.docker.com/v1/repositories/{}/tags'.format(
        img_name
    )
    if sys.version_info[0] == 3:
        import urllib.request
        tags = urllib.request.urlopen(api_url)
    else:
        import urllib
        tags = urllib.urlopen(api_url)
    tags = tags.read()
    tags = tags.decode('utf-8')
    tags = json.loads(tags)

    # tag & push if tag exist
    existing_tag = list(filter(lambda a: a['name'] == app_version_tag, tags))
    if not existing_tag:
        # pull tag push
        subprocess.call([
            'docker', 'pull',
            app_image_name
            ])
        subprocess.call([
            'docker', 'tag',
            app_image_name,
            app_version_name,
            ])
        subprocess.call(['docker', 'push', app_version_name])


if __name__ == '__main__':

    # debug
    print('sys.argv')
    print(sys.argv)

    # get args
    container_name = sys.argv[1]
    img_name = sys.argv[2]
    img_tag = sys.argv[3]
    img_wsql_tag = sys.argv[4]

    # build args
    image = '{img_name}:{img_wsql_tag}'.format(
        img_name=img_name,
        img_wsql_tag=img_wsql_tag,
        )

    # run process
    server_status = check_status_code(container_name, image)
    if server_status == '200':
        print('Server status == 200')
        app_version = get_app_version(image)
        print('tag_image > img_tag > {}'.format(
            img_tag
        ))
        tag_image(app_version, img_name, img_tag)
        print('tag_image > img_wsql_tag > {}'.format(
            img_wsql_tag
        ))
        tag_image(app_version, img_name, img_wsql_tag)
    else:
        print('Error: Server status is not 200!')
        print(server_status)
        print(type(server_status))
