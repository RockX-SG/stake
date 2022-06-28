FROM python:3

RUN pip install eth-brownie

# Install linux dependencies
RUN apt-get update \
 && apt-get install -y libssl-dev npm nginx

RUN npm install n -g \
 && npm install -g npm@latest
RUN npm install -g ganache

WORKDIR /app

COPY . .

RUN brownie compile

# ENV WEB3_INFURA_PROJECT_ID

EXPOSE 8545

CMD ["sh","-c","nginx -g 'daemon off;' & ./run.sh"]