require 'test_helper'

class Apps::LetsencryptControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(users(:john))
  end

  test "POST create enables LetsEncrypt" do
    server = servers(:example)
    app = apps(:example)
    EnableLetsEncryptJob.any_instance.expects(:perform)

    post server_app_letsencrypt_url(server,  app), params: { 
      app: {
        letsencrypt_email: "michiel.sikkes@gmail.com"
      }
    }

    assert_equal "michiel.sikkes@gmail.com", app.reload.letsencrypt_email

    assert_redirected_to server_app_domains_url(server, app)
  end

  test "DELETE destroy disables LetsEncrypt" do
    server = servers(:example)
    app = apps(:example)
    DisableLetsEncryptJob.any_instance.expects(:perform)

    delete server_app_letsencrypt_url(server,  app)

    assert_redirected_to server_app_domains_url(server, app)
  end
end
