root = "/home/yang/Sites/ansibe"
working_directory root
pid "#{root}/tmp/pids/unicorn_oa.pid"
stderr_path "#{root}/log/unicorn_oa.stderr.log"
stdout_path "#{root}/log/unicorn_oa.log"

listen "/tmp/unicorn_oa.sock"
worker_processes 4
timeout 30
#preload_app true