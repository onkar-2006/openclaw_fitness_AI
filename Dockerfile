FROM node:20
RUN apt-get update && apt-get install -y python3
WORKDIR /app
COPY . .
RUN npm install -g openclaw
EXPOSE 3000
CMD ["openclaw", "gateway", "start", "--port", "3000"]