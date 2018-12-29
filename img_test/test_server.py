import sys


def test_server_py():
    # get site status
    if sys.version_info[0] == 3:
        import urllib.request
        url_status_code = urllib.request.urlopen('http://127.0.0.1:8000').getcode()
    else:
        import urllib
        url_status_code = urllib.urlopen('http://127.0.0.1:8000').getcode()

    # return error if status is not 200
    if url_status_code != 200:
        raise ValueError('Site status is not 200, something might be wrong.')

    print(url_status_code)


if __name__ == '__main__':
    test_server_py()
