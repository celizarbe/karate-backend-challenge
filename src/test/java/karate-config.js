function fn() {
  var config = {
    baseUrl: 'https://dummyjson.com'
  };

  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  karate.configure('headers', { 'Content-Type': 'application/json' });

  return config;
}