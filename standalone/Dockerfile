FROM redis:7.0.15

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

EXPOSE 6379

ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis"]
