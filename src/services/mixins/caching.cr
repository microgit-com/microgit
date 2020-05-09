module Caching
  private def caching(key, &block)
    redis = Redis::PooledClient.new(pool_size: 5)
    cached = redis.get("#{@repo.cache_key}/#{key.downcase}")
    return cached unless cached.nil?
    data = yield
    redis.set("#{@repo.cache_key}/#{key.downcase}", data)
    return data
  end
end
