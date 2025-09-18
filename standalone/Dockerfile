FROM redis:5.0.14

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

EXPOSE 6379

ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis"]
