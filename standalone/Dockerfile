FROM redis:8.2.5

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

EXPOSE 6379

ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis"]
