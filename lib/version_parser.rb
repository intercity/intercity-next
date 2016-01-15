class VersionParser
  include Comparable

  attr_reader :major, :minor, :patch

  def self.parse(version)
    parsed = version.match(/(\d+).(\d+).(\d+)/)
    VersionParser.new(parsed[1].to_i, parsed[2].to_i, parsed[3].to_i)
  end

  def initialize(major, minor, patch)
    @major = major
    @minor = minor
    @patch = patch
  end

  def <=>(other) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    return unless other.is_a? VersionParser
    return unless valid? && other.valid?

    if other.major < @major
      1
    elsif @major < other.major
      -1
    elsif other.minor < @minor
      1
    elsif @minor < other.minor
      -1
    elsif other.patch < @patch
      1
    elsif @patch < other.patch
      -1
    else
      0
    end
  end

  def valid?
    @major >= 0 && @minor >= 0 && @patch >= 0 && @major + @minor + @patch > 0
  end
end
