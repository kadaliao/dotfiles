#compdef dae
# DAE fish completion file

function __fish_dae_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'dae' ]
    return 0
  end
  return 1
end

function __fish_dae_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

    complete -f -c dae -n "__fish_dae_needs_command" -a pre
        complete -f -c dae -n "__fish_dae_using_command pre" -a switch_shire -d "switch shire repo branch"
        complete -f -c dae -n "__fish_dae_using_command pre" -a log -d "tail pre logs"
        complete -f -c dae -n "__fish_dae_using_command pre" -a edit -d "edit pre"
        complete -f -c dae -n "__fish_dae_using_command pre" -a create -d "create dae app prelase(web, thrift or pidl)"
        complete -f -c dae -n "__fish_dae_using_command pre" -a list -d "list pre"
        complete -f -c dae -n "__fish_dae_using_command pre" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command pre" -a --ldap -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command pre" -a --user -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command pre" -a -u -d "LDAP username"
        complete -f -c dae -n "__fish_dae_using_command pre" -a switch -d "switch branch"
        complete -f -c dae -n "__fish_dae_using_command pre" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command pre" -a ssh -d "ssh pre"
        complete -f -c dae -n "__fish_dae_using_command pre" -a update -d "update pre"
        complete -f -c dae -n "__fish_dae_using_command pre" -a delete -d "delete pre"
    complete -f -c dae -n "__fish_dae_needs_command" -a venv
        complete -f -c dae -n "__fish_dae_using_command venv" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command venv" -a -h -d "show this help message and exit"
    complete -f -c dae -n "__fish_dae_needs_command" -a sync
        complete -f -c dae -n "__fish_dae_using_command sync" -a --no-databases -d "Restore databases or not. [default %(default)s]"
        complete -f -c dae -n "__fish_dae_using_command sync" -a --mysql-host -d "mysql host, default is %(default)s"
        complete -f -c dae -n "__fish_dae_using_command sync" -a --only-init-db -d "only initialize database"
        complete -f -c dae -n "__fish_dae_using_command sync" -a --mysql-passwd -d "mysql password, default is %(default)s"
        complete -f -c dae -n "__fish_dae_using_command sync" -a --mysql-user -d "mysql user, default is %(default)s"
        complete -f -c dae -n "__fish_dae_using_command sync" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command sync" -a --mysql-db -d "default is application name"
        complete -f -c dae -n "__fish_dae_using_command sync" -a --quiet-pip -d "Tell pip to give less output. [default %(default)s]"
        complete -f -c dae -n "__fish_dae_using_command sync" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command sync" -a --use-latest-pip -d "Upgrade venv/bin/pip to latest version[default %(default)s]"
        complete -f -c dae -n "__fish_dae_using_command sync" -a --mysql-port -d "mysql port, default is %(default)s"
        complete -f -c dae -n "__fish_dae_using_command sync" -a --repo-update -d "Update repo version or not. [default %(default)s]"
        complete -f -c dae -n "__fish_dae_using_command sync" -a --only-update-svc -d "only update svc files"
    complete -f -c dae -n "__fish_dae_needs_command" -a freeze
        complete -f -c dae -n "__fish_dae_using_command freeze" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command freeze" -a -h -d "show this help message and exit"
    complete -f -c dae -n "__fish_dae_needs_command" -a runscript
        complete -f -c dae -n "__fish_dae_using_command runscript" -a -a -d "None"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --auto-failed-retry -d "Retry 3 times if failed (Remote only)"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --pre -d "Runscript on dae-pre"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --mem -d "mem limit(MB), default:%(default)s MB, Remote only"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --show-log -d "Show logging in bridge page, default false(only show print), Remote only"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --ldap -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --user -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a -u -d "LDAP username"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a -t -d "Max execution hours before killed"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --cpus -d "cpus limit, default:%(default)s, Remote only"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --parallel -d "Parallel runscripts number, Remote only"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --profile -d "Attach profiler"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --use-dpark -d "use dpark (Remote only)"
        complete -f -c dae -n "__fish_dae_using_command runscript" -a --remote -d "run as kubernetes run-once job remotely, support long running job"
    complete -f -c dae -n "__fish_dae_needs_command" -a syncdb
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a -d -d "Sync data to remote server[default: False]"
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a --dump-mysql -d "Path and filename to store mysql dumping file[default: named syncdb_dumps.bak store in current dir]"
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a --node -d "choose node to syncdb[default: None]"
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a --ldap -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a --user -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a -u -d "LDAP username"
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a -s -d "The AppEngine deploy server [default: dae-deploy.dapps.douban.com]"
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a --dump-with-autoincrement -d "Dumping mysql schema with autoincrement[default: False]"
        complete -f -c dae -n "__fish_dae_using_command syncdb" -a --remote -d "Really sync to production database"
    complete -f -c dae -n "__fish_dae_needs_command" -a upgrade
        complete -f -c dae -n "__fish_dae_using_command upgrade" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command upgrade" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command upgrade" -a --up -d "upgrade sdk [default: false]"
    complete -f -c dae -n "__fish_dae_needs_command" -a log
        complete -f -c dae -n "__fish_dae_using_command log" -a --pre -d "pre number. (prelog type is deprecated, suppose to use `dae pre log`)"
        complete -f -c dae -n "__fish_dae_using_command log" -a --instance -d "Assign instance names if needed. Linux glob is available, and default is *"
        complete -f -c dae -n "__fish_dae_using_command log" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command log" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command log" -a --logtype -d "Choose types of log to show. Allowed types: accesslog, nginxlog, applog, kafka, cron, daemon, mq, service, prelog"
    complete -f -c dae -n "__fish_dae_needs_command" -a service
        complete -f -c dae -n "__fish_dae_using_command service" -a list -d "List services"
        complete -f -c dae -n "__fish_dae_using_command service" -a serve -d "Start service server"
        complete -f -c dae -n "__fish_dae_using_command service" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command service" -a mapping -d "services mapping"
        complete -f -c dae -n "__fish_dae_using_command service" -a gen-client -d "Download client codes by current app thrift idl file"
        complete -f -c dae -n "__fish_dae_using_command service" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command service" -a call -d "Call service"
        complete -f -c dae -n "__fish_dae_using_command service" -a download-client -d "Download client codes"
        complete -f -c dae -n "__fish_dae_using_command service" -a gen -d "Generate interface code"
    complete -f -c dae -n "__fish_dae_needs_command" -a create
        complete -f -c dae -n "__fish_dae_using_command create" -a --dir -d "directory to put the app [default: the current directory]"
        complete -f -c dae -n "__fish_dae_using_command create" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command create" -a -h -d "show this help message and exit"
    complete -f -c dae -n "__fish_dae_needs_command" -a stub
        complete -f -c dae -n "__fish_dae_using_command stub" -a -l -d "show stub module's activation status"
        complete -f -c dae -n "__fish_dae_using_command stub" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command stub" -a -a -d "activate stubs [default]"
        complete -f -c dae -n "__fish_dae_using_command stub" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command stub" -a -d -d "deactivate stubs"
    complete -f -c dae -n "__fish_dae_needs_command" -a dbshell
        complete -f -c dae -n "__fish_dae_using_command dbshell" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command dbshell" -a --ldap -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command dbshell" -a --user -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command dbshell" -a -u -d "LDAP username"
        complete -f -c dae -n "__fish_dae_using_command dbshell" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command dbshell" -a -r -d "connect to the offline database in production environment"
        complete -f -c dae -n "__fish_dae_using_command dbshell" -a --online -d "connect to the **online** database in production environment (DANGEROURS!)"
    complete -f -c dae -n "__fish_dae_needs_command" -a update_pidl_use_svc
        complete -f -c dae -n "__fish_dae_using_command update_pidl_use_svc" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command update_pidl_use_svc" -a --approot -d "directory contains app.yaml [default: current directory]"
        complete -f -c dae -n "__fish_dae_using_command update_pidl_use_svc" -a --user -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command update_pidl_use_svc" -a -u -d "LDAP username"
        complete -f -c dae -n "__fish_dae_using_command update_pidl_use_svc" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command update_pidl_use_svc" -a --ldap -d "Same as -u/--username"
    complete -f -c dae -n "__fish_dae_needs_command" -a test
        complete -f -c dae -n "__fish_dae_using_command test" -a -w -d "test should start dae webserver,                        and use the real memcached, for webtest and apitest"
        complete -f -c dae -n "__fish_dae_using_command test" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command test" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command test" -a -p -d "use pytest as your test framework"
    complete -f -c dae -n "__fish_dae_needs_command" -a permdir
        complete -f -c dae -n "__fish_dae_using_command permdir" -a -f -d "Path of local file to upload/download"
        complete -f -c dae -n "__fish_dae_using_command permdir" -a lists -d "None"
        complete -f -c dae -n "__fish_dae_using_command permdir" -a upload -d "None"
        complete -f -c dae -n "__fish_dae_using_command permdir" -a --ldap -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command permdir" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command permdir" -a -u -d "LDAP username"
        complete -f -c dae -n "__fish_dae_using_command permdir" -a download -d "None"
        complete -f -c dae -n "__fish_dae_using_command permdir" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command permdir" -a remove -d "None"
        complete -f -c dae -n "__fish_dae_using_command permdir" -a --user -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command permdir" -a -p -d "Relative path in remote permdir"
    complete -f -c dae -n "__fish_dae_needs_command" -a remoteshell
        complete -f -c dae -n "__fish_dae_using_command remoteshell" -a --pre -d "Remote shell to dae-pre"
        complete -f -c dae -n "__fish_dae_using_command remoteshell" -a -i -d "Selects a file from which the identity (private key) for public key authentication is read"
        complete -f -c dae -n "__fish_dae_using_command remoteshell" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command remoteshell" -a --ldap -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command remoteshell" -a --user -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command remoteshell" -a -u -d "LDAP username"
        complete -f -c dae -n "__fish_dae_using_command remoteshell" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command remoteshell" -a --sync-key -d "Sync release manager ssh public keys"
    complete -f -c dae -n "__fish_dae_needs_command" -a complete
        complete -f -c dae -n "__fish_dae_using_command complete" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command complete" -a -h -d "show this help message and exit"
    complete -f -c dae -n "__fish_dae_needs_command" -a deploy
        complete -f -c dae -n "__fish_dae_using_command deploy" -a lock -d "Lock or release app deployment"
        complete -f -c dae -n "__fish_dae_using_command deploy" -a app -d "Deploy app in (stage0/1/2)"
        complete -f -c dae -n "__fish_dae_using_command deploy" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command deploy" -a -h -d "show this help message and exit"
    complete -f -c dae -n "__fish_dae_needs_command" -a serve
        complete -f -c dae -n "__fish_dae_using_command serve" -a -b -d "specific scheme for binding: unix socket or ip address with port [default: %(default)s]"
        complete -f -c dae -n "__fish_dae_using_command serve" -a -i -d "instance name [default: %(default)s]"
        complete -f -c dae -n "__fish_dae_using_command serve" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command serve" -a -t -d "request timeout sec [default: %(default)s]"
        complete -f -c dae -n "__fish_dae_using_command serve" -a -w -d "workers number [default: %(default)s]"
        complete -f -c dae -n "__fish_dae_using_command serve" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command serve" -a -p -d "port for the server to run on [default: %(default)s]"
        complete -f -c dae -n "__fish_dae_using_command serve" -a --daemon -d "daemonize the server process [default: false]"
        complete -f -c dae -n "__fish_dae_using_command serve" -a --pidfile -d "file path to put pid in"
    complete -f -c dae -n "__fish_dae_needs_command" -a logout
        complete -f -c dae -n "__fish_dae_using_command logout" -a -u -d "LDAP username"
        complete -f -c dae -n "__fish_dae_using_command logout" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command logout" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command logout" -a --ldap -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command logout" -a --user -d "Same as -u/--username"
    complete -f -c dae -n "__fish_dae_needs_command" -a pidlsvc
        complete -f -c dae -n "__fish_dae_using_command pidlsvc" -a launchdep -d "lanuch dependant service "
        complete -f -c dae -n "__fish_dae_using_command pidlsvc" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command pidlsvc" -a serve -d "Start service server"
        complete -f -c dae -n "__fish_dae_using_command pidlsvc" -a -h -d "show this help message and exit"
    complete -f -c dae -n "__fish_dae_needs_command" -a login
        complete -f -c dae -n "__fish_dae_using_command login" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command login" -a --ldap -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command login" -a --user -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command login" -a -u -d "LDAP username"
        complete -f -c dae -n "__fish_dae_using_command login" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command login" -a -r -d "refresh DAE account login status"
    complete -f -c dae -n "__fish_dae_needs_command" -a info
        complete -f -c dae -n "__fish_dae_using_command info" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command info" -a -h -d "show this help message and exit"
    complete -f -c dae -n "__fish_dae_needs_command" -a daemon
        complete -f -c dae -n "__fish_dae_using_command daemon" -a stat -d "daemon states"
        complete -f -c dae -n "__fish_dae_using_command daemon" -a set -d "set daemon instance number"
        complete -f -c dae -n "__fish_dae_using_command daemon" -a -a -d "app name (default: app from current dir)"
        complete -f -c dae -n "__fish_dae_using_command daemon" -a deploy -d "deploy daemon (Marathon only)"
        complete -f -c dae -n "__fish_dae_using_command daemon" -a realtime-stat -d "realtime daemon states"
        complete -f -c dae -n "__fish_dae_using_command daemon" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command daemon" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command daemon" -a restart -d "restart daemon (Marathon only)"
    complete -f -c dae -n "__fish_dae_needs_command" -a plugin
        complete -f -c dae -n "__fish_dae_using_command plugin" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command plugin" -a list -d "list all installed plugins"
        complete -f -c dae -n "__fish_dae_using_command plugin" -a -h -d "show this help message and exit"
    complete -f -c dae -n "__fish_dae_needs_command" -a sandbox
        complete -f -c dae -n "__fish_dae_using_command sandbox" -a create -d "create dae app sandbox(web)"
        complete -f -c dae -n "__fish_dae_using_command sandbox" -a list -d "list sandbox"
        complete -f -c dae -n "__fish_dae_using_command sandbox" -a -h -d "show this help message and exit"
        complete -f -c dae -n "__fish_dae_using_command sandbox" -a --ldap -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command sandbox" -a --user -d "Same as -u/--username"
        complete -f -c dae -n "__fish_dae_using_command sandbox" -a -u -d "LDAP username"
        complete -f -c dae -n "__fish_dae_using_command sandbox" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command sandbox" -a update -d "update sandbox"
        complete -f -c dae -n "__fish_dae_using_command sandbox" -a delete -d "delete sandbox"
    complete -f -c dae -n "__fish_dae_needs_command" -a install
        complete -f -c dae -n "__fish_dae_using_command install" -a -h -d "show this help message and exit"
    complete -f -c dae -n "__fish_dae_needs_command" -a docker
        complete -f -c dae -n "__fish_dae_using_command docker" -a compose -d "use docker-compose, https://docs.docker.com/compose/"
        complete -f -c dae -n "__fish_dae_using_command docker" -a shell -d "enter docker container shell by service name"
        complete -f -c dae -n "__fish_dae_using_command docker" -a -v -d "enable additional output"
        complete -f -c dae -n "__fish_dae_using_command docker" -a init -d "initialize docker-compose.yaml"
        complete -f -c dae -n "__fish_dae_using_command docker" -a -h -d "show this help message and exit"
    complete -f -c dae -n "__fish_dae_needs_command" -a uninstall
        complete -f -c dae -n "__fish_dae_using_command uninstall" -a -h -d "show this help message and exit"
