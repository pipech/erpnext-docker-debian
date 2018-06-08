# Know Bug / Error Traceback

* **bench new-app [app_name]**

    Command "python setup.py egg_info" failed with error code 1 in /home/frappe/bench/apps/[app_name]/

    INFO:bench.app:installing [app_name]

    INFO:bench.utils:./env/bin/pip install -q  -e ./apps/[app_name] --no-cache-dir
    Command "python setup.py egg_info" failed with error code 1 in /home/frappe/bench/apps/[app_name]/

    Traceback (most recent call last):

    File "/usr/local/bin/bench", line 11, in <module>
        load_entry_point('bench', 'console_scripts', 'bench')()

    File "/home/frappe/bench-repo/bench/cli.py", line 40, in cli
        bench_command()

    File "/usr/local/lib/python2.7/dist-packages/click/core.py", line 722, in __call__
        return self.main(*args, **kwargs)

    File "/usr/local/lib/python2.7/dist-packages/click/core.py", line 697, in main
        rv = self.invoke(ctx)

    File "/usr/local/lib/python2.7/dist-packages/click/core.py", line 1066, in invoke
        return _process_result(sub_ctx.command.invoke(sub_ctx))

    File "/usr/local/lib/python2.7/dist-packages/click/core.py", line 895, in invoke
        return ctx.invoke(self.callback, **ctx.params)

    File "/usr/local/lib/python2.7/dist-packages/click/core.py", line 535, in invoke
        return callback(*args, **kwargs)

    File "/home/frappe/bench-repo/bench/commands/make.py", line 48, in new_app
        new_app(app_name)

    File "/home/frappe/bench-repo/bench/app.py", line 156, in new_app
        install_app(app, bench_path=bench_path)

    File "/home/frappe/bench-repo/bench/app.py", line 167, in install_app
        find_links=find_links))

    File "/home/frappe/bench-repo/bench/utils.py", line 153, in exec_cmd
        raise CommandFailedError(cmd)

    bench.utils.CommandFailedError: ./env/bin/pip install -q  -e ./apps/[app_name] --no-cache-dir