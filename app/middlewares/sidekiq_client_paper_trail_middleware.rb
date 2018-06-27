class SidekiqClientPaperTrailMiddleware
  def call(worker, job, queue, redis_pool)
    job["chain_id"] ||= SecureRandom.uuid()
    job["paper_trail"] ||= {
      "whodunnit" => PaperTrail.request.whodunnit,
      "metadata" => PaperTrail.request.controller_info
    }

    yield
  end
end