module FixtureHelper
  def fetch_fixture(filename)
    File.read ses_response_fixture_path.join(filename)
  end

  def ses_response_fixture_path
    Rails.root.join('..', 'fixture', 'ses', 'response')
  end
end
