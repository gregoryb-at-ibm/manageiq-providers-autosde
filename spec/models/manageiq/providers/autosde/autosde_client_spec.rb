describe ManageIQ::Providers::Autosde::PhysicalInfraManager::AutosdeClient do
  it "logs in with right credentials " do
    client = ManageIQ::Providers::Autosde::PhysicalInfraManager::AutosdeClient.new(:host => '9.151.190.224')
    VCR.use_cassette("correct_login_spec") do
      expect(client.login).to be_truthy
    end
  end

  it "raises on login with wrong credentials" do
    client = ManageIQ::Providers::Autosde::PhysicalInfraManager::AutosdeClient.new('asfd', :host => '9.151.190.224')
    VCR.use_cassette("incorrect_login_spec") do
      expect{client.login}.to raise_error(Exception, ManageIQ::Providers::Autosde::PhysicalInfraManager::AutosdeClient::AUTH_ERRR_MSG)
    end
  end

  it "gets a list of storage systems" do
    client = ManageIQ::Providers::Autosde::PhysicalInfraManager::AutosdeClient.new(:host => '9.151.190.224')
    VCR.use_cassette("correct_login_spec") do
      client.login
    end

    VCR.use_cassette("get_storage_systems") do
      expected = [{"management_ip" => "9.151.156.155",
                   "name" => "my_xiv",
                   "storage_array" => nil,
                   "storage_family" => "",
                   "system_type" =>
                       {"name" => "a_line",
                        "short_version" => "4",
                        "uuid" => "c87d3686-6a36-4358-bc8d-7028d24d60d3",
                        "version" => "4"},
                   "uuid" => "f09afcc9-53be-4573-8b6f-1e5787d34d05"}]
      expect(client.get_storage_systems).to eq(expected)
    end
  end

end