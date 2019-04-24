require 'test_helper'

class Apps::LetsencryptControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(users(:john))
  end

  test "POST create enables LetsEncrypt" do
    server = servers(:example)
    app = apps(:example)

    SshExecution.any_instance.expects(:execute).with(command: "sudo dokku plugin").returns("")
    SshExecution.any_instance.expects(:execute).with(command: "sudo dokku config:get example-app DOKKU_LETSENCRYPT_EMAIL")
    SshExecution.any_instance.expects(:execute).with(command: "sudo dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git")
    SshExecution.any_instance.expects(:execute).with(command: "sudo dokku letsencrypt:cron-job --add")
    SshExecution.any_instance.expects(:execute).with(command: "sudo dokku config:set -no-restart example-app DOKKU_LETSENCRYPT_EMAIL=michiel.sikkes@gmail.com")
    SshExecution.any_instance.expects(:execute).with(command: "sudo dokku letsencrypt example-app")

    post server_app_letsencrypt_url(server,  app), params: { 
      app: {
        letsencrypt_email: "michiel.sikkes@gmail.com"
      }
    }

    app.reload
    assert app.letsencrypt_enabled?
    assert_equal "michiel.sikkes@gmail.com", app.letsencrypt_email

    assert_redirected_to server_app_domains_url(server, app)
  end

  test "DELETE destroy disables LetsEncrypt" do
    server = servers(:example)
    app = apps(:example)
    SshExecution.any_instance.expects(:execute).at_least_once

    delete server_app_letsencrypt_url(server,  app)

    assert_redirected_to server_app_domains_url(server, app)
  end
end
