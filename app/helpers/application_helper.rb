module ApplicationHelper
  def yale_directory_link(upi)
    "http://directory.yale.edu/?queryType=field&upi=#{upi}"
  end
end
