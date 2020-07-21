from datetime import datetime
from subprocess import check_output

import json
import os
import re
import sys


def get_app_version(src_image):
    # get app version
    print('>>> Getting app version')
    apps_version = check_output([
        'docker', 'run', '--rm', src_image, 'bench', 'version'
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
    # loop all version digit
    for idx, val in enumerate(e):
        if e[idx].isdigit():
            # convert str to int
            e[idx] = int(e[idx])
            f[idx] = int(f[idx])

            if e[idx] != f[idx]:
                if e[idx] > f[idx]:
                    higher_app_version = e
                    break
                else:
                    higher_app_version = f
                    break

    print('> App version Dict')
    print(apps)

    if higher_app_version == e:
        return apps['erpnext']['version_str']
    else:
        return apps['frappe']['version_str']


def prepare_tag_image(app_version, img_tag):
    print('>>> Prepare tag image')
    print('> App version')
    print(app_version)
    print('> Image tag')
    print(img_tag)
    # remove first 3 character of tag (mas, dev, sta) &
    # remove last 7 -latest
    img_tag_trailing = img_tag[3:-7]

    # prepare image name
    if img_tag[:3] == 'dev':
        # remove last 7 develop
        app_version = app_version[:-7]
        app_version_tag = '{}{}{}'.format(
            app_version,
            datetime.now().strftime('%y%m%d'),
            img_tag_trailing
        )
    else:
        app_version_tag = '{}{}'.format(
            app_version,
            img_tag_trailing
        )

    print('> App version tag')
    print(app_version_tag)

    return app_version_tag


def existing_tag(app_version_tag, img_name):
    # get all tags
    print('>>> Get all image tag')
    api_url = 'https://registry.hub.docker.com/v1/repositories/{}/tags'.format(
        img_name
    )
    if sys.version_info[0] == 3:
        import urllib.request
        tags = urllib.request.urlopen(api_url)
    else:
        import urllib
        tags = urllib.urlopen(api_url)

    print('> Image tag')
    print(tags)

    tags = tags.read()
    tags = tags.decode('utf-8')
    tags = json.loads(tags)
    
    print('> Image tag json')
    print(tags)

    tag_exist_bool = list(filter(lambda a: a['name'] == app_version_tag, tags))
    print('Tag exist bool')
    print(tag_exist_bool)

    # tag & push if tag exist
    return tag_exist_bool


def main():
    # get args
    img_name = os.environ['docker_img']
    img_tag = os.environ['docker_img_tag']

    # build args
    src_image = '{img_name}:{img_tag}'.format(
        img_name=img_name,
        img_tag=img_tag,
        )

    # debug
    print('img_name: {}'.format(img_name))
    print('img_tag: {}'.format(img_tag))
    print('image: {}'.format(src_image))

    # execute
    app_version = get_app_version(src_image)
    app_version = prepare_tag_image(app_version, img_tag)
    if not existing_tag(app_version, img_name):
        target_image = '{img_name}:{img_tag}'.format(
            img_name=img_name,
            img_tag=app_version,
            )
        print('>>> Tag not exist')
        print('> Target image')
        print(target_image)

        tag_image = check_output([
            'docker', 'tag', src_image, target_image
            ]).decode('utf-8')
        print('> Tag image')
        print(tag_image)

        push_image = check_output([
            'docker', 'push', target_image
            ]).decode('utf-8')
        print('> Push image')
        print(push_image)

    else:
        print('>>> Tag already exist')
        print('> App version')
        print(app_version)
        return 'Tags "{}" already exist'.format(app_version)


if __name__ == '__main__':
    main()
