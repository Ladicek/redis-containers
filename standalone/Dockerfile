FROM redis:6.2.21

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

EXPOSE 6379

ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis"]
