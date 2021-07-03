FROM myoung34/github-runner:2.278.0

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list

RUN sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN sudo curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

RUN apt-get update \
 && apt-get install -y --no-install-recommends openjdk-8-jdk unzip nodejs yarn \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://mirrors.bfsu.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip -o maven.zip \
 && unzip -o -d /usr/share maven.zip \
 && rm maven.zip \
 && ln -s /usr/share/apache-maven-3.6.3/bin/mvn /usr/bin/mvn \
 && echo "M2_HOME=/usr/share/apache-maven-3.6.3" | tee -a /etc/environment

ADD settings.xml /usr/share/apache-maven-3.6.3/conf/

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME=$JAVA_HOME/jre
ENV CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
ENV PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
