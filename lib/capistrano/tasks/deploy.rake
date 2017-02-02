# Deploy related custom tasks
namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'Deploys the front end'
  task :front do
    on roles(:app) do
      execute "#{shared_path}/scripts/deploy_front.sh #{fetch(:front_path)}"
    end
  end

  after  :finishing, :cleanup
end
