class SitemapController < ApplicationController
  layout nil

  def index
    headers['Content-Type'] = 'application/xml'
    last_new_thread = NewThread.last
    if stale?(etag: last_new_thread,
              last_modified: last_new_thread.updated_at.utc)
      respond_to do |format|
        format.xml { @new_threads = NewThread.all } # sitemap is a named scope
      end
    end
  end
end
