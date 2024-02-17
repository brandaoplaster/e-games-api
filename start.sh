#!/usr/bin/env bash

bundle check || bundle install

rails_pid=$(pgrep -f "bin/rails server")

if [ -n "$rails_pid" ]; then
  echo "O processo do servidor Rails está em execução (PID: $rails_pid)."
  echo "Encerrando o processo do servidor Rails..."
  
  kill -TERM $rails_pid

  sleep 2
else
  echo "O processo do servidor Rails não está em execução."
fi

echo "Iniciando o servidor Puma..."
bundle exec puma -C config/puma.rb
