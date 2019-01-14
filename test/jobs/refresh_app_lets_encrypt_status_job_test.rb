require 'test_helper'

class RefreshAppLetsEncryptStatusJobTest < ActiveJob::TestCase
  test "#perform should call out to SshExecution to set enabled LetsEncrypt status" do
    app = apps(:example)
    app.update(letsencrypt_enabled: false, letsencrypt_email: nil)

    FakeSshExecutioner.return_value = "john@example.com"
    RefreshAppLetsEncryptStatusJob.perform_now(app)

    app.reload
    assert app.letsencrypt_enabled?
    assert_equal "john@example.com", app.letsencrypt_email
  end

  test "#perform should call out to SshExecution to disabled LetsEncrypt status" do
    app = apps(:example)

    app.update(letsencrypt_enabled: true, letsencrypt_email: "john@example.com")
    FakeSshExecutioner.return_value = ""

    RefreshAppLetsEncryptStatusJob.perform_now(app)

    app.reload
    refute app.letsencrypt_enabled?
  end
end
