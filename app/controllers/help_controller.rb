class HelpController < ApplicationController
  def index
    @help_index = File.read(Rails.root.join("doc", "README.md"))

    # Prefix Markdown links with `help/` unless they already have been
    # See http://rubular.com/r/nwwhzH6Z8X
    @help_index.gsub!(%r{(\]\()(?!help\/)([^\)\(]+)(\))}, '\1help/\2\3')
  end

  def show
    @category = clean_path_info(path_params[:category])
    @file = path_params[:file]

    respond_to do |format|
      format.any(:md, :html) do
        # Note: We are purposefully NOT using `Rails.root.join`
        path = Rails.root.join("doc", @category, "#{@file}.md")

        if File.exist?(path)
          @markdown = File.read(path)
          render "show.html.erb"
        else
          redirect_to help_path
        end
      end
    end
  end

  private

  def path_params
    params.require(:category)
    params.require(:file)

    params
  end

  PATH_SEPS = Regexp.union(*[::File::SEPARATOR, ::File::ALT_SEPARATOR].compact)

  # Taken from ActionDispatch::FileHandler
  # Cleans up the path, to prevent directory traversal outside the doc folder.
  def clean_path_info(path_info)
    parts = path_info.split(PATH_SEPS)

    clean = []

    # Walk over each part of the path
    parts.each do |part|
      # Turn `one//two` or `one/./two` into `one/two`.
      next if part.empty? || part == "."

      if part == ".."
        # Turn `one/two/../` into `one`
        clean.pop
      else
        # Add simple folder names to the clean path.
        clean << part
      end
    end

    # If the path was an absolute path (i.e. `/` or `/one/two`),
    # add `/` to the front of the clean path.
    clean.unshift "/" if parts.empty? || parts.first.empty?

    # Join all the clean path parts by the path separator.
    ::File.join(*clean)
  end
end
