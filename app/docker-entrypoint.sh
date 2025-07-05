#!/bin/sh

echo "⏳ Waiting for MySQL to be ready..."
until nc -z -v -w30 $DB_HOST $DB_PORT
do
  echo "❗ Still waiting for MySQL..."
  sleep 5
done

echo "✅ MySQL is ready. Running migrations..."
php artisan migrate --force

echo "🚀 Starting PHP-FPM..."
exec php-fpm
