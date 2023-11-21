import re


def read_version_from_file(file_path):
    """ Reads the first line of the file and returns it. """
    with open(file_path, 'r') as file:
        return file.readline().strip()


def get_app_version(app_version):
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

    # construct version tag
    # 12-F10.1_E14.3
    version = '{major}-F{frappe_minor}.{frappe_patch}_E{erpnext_minor}.{erpnext_patch}'.format(
        major=f[0],
        frappe_minor=f[1],
        frappe_patch=f[2],
        erpnext_minor=e[1],
        erpnext_patch=e[2],
    )

    return version

def main():
    print('>>> Prepare image tagging')
    raw_app_version = read_version_from_file('version.txt')
    print(f'> Raw app version: {raw_app_version}')
    app_version = get_app_version(raw_app_version)
    print(f'> App version: {app_version}')

    # Print the command to set the new tag in the GitHub Actions environment variable
    print(f"echo \"IMAGE_VERSION_TAG={app_version}\" >> $GITHUB_ENV")


if __name__ == "__main__":
    main()