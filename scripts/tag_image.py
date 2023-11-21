# used in .github/workflows/push-docker.yml

import json


def read_version_from_file(file_path):
    """
    Data from file should be some thing like this:
    erpnext 12.10.1
    frappe 12.8.1

    :param file_path: path to file
    :return: dict of app version
        {
            'erpnext': '12.10.1',
            'frappe': '12.8.1',
        }
    """
    values = {}
    with open(file_path, 'r') as file:
        for line in file:
            parts = line.split()
            if len(parts) >= 2:
                key = parts[0]
                value = parts[1]
                values[key] = value
    return values


def get_app_version(apps_version):
    """
    :param apps_version: dict of app version
        {
            'erpnext': '12.10.1',
            'frappe': '12.8.1',
        }
    :return: version tag string
        12-F10.1_E14.3
    """
    e = apps_version['erpnext'].split('.')
    f = apps_version['frappe'].split('.')

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
    version_dict = read_version_from_file('version.txt')
    print(f'> Raw app version: {json.dumps(version_dict)}')
    app_version = get_app_version(version_dict)
    print(f'> App version: {app_version}')

    # Print the command to set the new tag in the GitHub Actions environment variable
    print(f"echo \"IMAGE_VERSION_TAG={app_version}\" >> $GITHUB_ENV")


if __name__ == "__main__":
    main()