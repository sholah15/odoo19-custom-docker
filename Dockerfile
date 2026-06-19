FROM odoo:19.0

# Pindah ke user root untuk install package global
USER root

# Install library OpenTelemetry secara permanen ke dalam image
# Menambahkan flag --ignore-installed untuk mengatasi konflik typing-extensions
RUN pip3 install --break-system-packages --ignore-installed \
    opentelemetry-api \
    opentelemetry-sdk \
    opentelemetry-instrumentation-wsgi \
    opentelemetry-exporter-otlp \
    opentelemetry-instrumentation-requests \
    opentelemetry-instrumentation-psycopg2

# Kembalikan ke user odoo demi keamanan bawaan Odoo
USER odoo
