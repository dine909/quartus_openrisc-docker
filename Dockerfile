#FROM quartus_lite
FROM chriz2600/quartus-lite

#ENV https_proxy http://192.168.1.19:3128
#ENV http_proxy http://192.168.1.19:3128
#ENV ftp_proxy http://192.168.1.19:3128
ENV num_threads 8

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update ; true


# RUN apt-get update && apt-get clean && apt upgrade -y && apt-get autoremove 
RUN apt-get install -y \
        git \
        perl tcsh nano xvfb x11vnc fluxbox libfreetype6 nano make gtkwave htop gnat build-essential zlib1g zlib1g-dev octave python-dev \
         flex bison curl xz-utils srecord util-linux  bsdmainutils perl-tk libncurses-dev libreadline-gplv2-dev libncursesw5-dev libssl-dev \
        libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev checkinstall libmpfr-dev libgmp-dev libmpc-dev gperf \
        autoconf cpio unzip glib2.0 libpixman-1-dev bc tree libncurses-dev u-boot-tools subversion


RUN cd /tmp && curl -SL https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz | tar xz \
    && cd Python-3.7.3 && ./configure --enable-optimizations && make install -j4

#RUN apt install python3-pip -y

RUN pip3 install --upgrade setuptools pip intelhex



RUN mkdir /mnt/data /mnt/install

#RUN pip3 install numpy jupyter scipy
#RUN pip3 install jupyterthemes

#RUN jupyter notebook --generate-config
#RUN echo c.NotebookApp.password = u\'sha1:352569ee3a12:1e12c953b9af3a50a06996e0c8426f49bb7045ca\' > ~/.jupyter/jupyter_notebook_config.py
#RUN jt -t monokai

#WORKDIR /tmp
#RUN git clone --depth 1 https://github.com/ghdl/ghdl.git
#WORKDIR ghdl

#RUN ./configure --prefix=/usr/local && make -j$num_threads && make install


#WORKDIR /tmp
#RUN git clone --depth 1 --recursive https://github.com/dawsonjon/Chips-2.0.git
#WORKDIR Chips-2.0
#RUN python2 setup.py install


WORKDIR /root
# RUN git clone --depth 1 https://github.com/olofk/fusesoc
# RUN curl -SL http://github.com/olofk/fusesoc/releases/download/1.9/fusesoc-1.9.tar.gz | tar xz && \
        # cd fusesoc-1.9  && \
        # pip install -e .  
        # fusesoc init -y

# RUN curl -SL http://git.buildroot.net/buildroot/snapshot/buildroot-2019.02.4.tar.gz | tar xz && \
#         cd buildroot-2019.02.4  


#WORKDIR /root
#RUN git clone --depth 1 https://github.com/ldoolitt/vhd2vl.git
#WORKDIR vhd2vl
#RUN make

#WORKDIR /root
WORKDIR /root

# RUN cd /tmp && curl -SL http://ftp.gnu.org/gnu/binutils/binutils-2.32.tar.xz | tar xJ && \
#     cd binutils-2.32 && mkdir build && cd build && \
#     ../configure --target=lm32-elf  && \
#     make -j8 && \
#     make install && \
#     cd && rm -rf /tmp/*
#    rm -rf * && \
#    ../configure --target=or1k-elf  && \
#    make -j8 && \
#    make install && rm -rf * && \


# RUN cd /tmp && curl -SL http://ftp.gnu.org/gnu/gcc/gcc-9.1.0/gcc-9.1.0.tar.xz | tar xJ && \
#     cd gcc-9.1.0 && rm -rf libstdc++-v3 && mkdir build && cd build && \
#     ../configure --target=lm32-elf --enable-languages="c,c++" --disable-libssp  && \
#     make -j8 && \
#     make install && \
#     cd && rm -rf /tmp/*

RUN cd /opt && curl -SL http://github.com/openrisc/or1k-gcc/releases/download/or1k-7.2.0-20180317/or1k-elf-7.2.0-20180317.tar.xz | tar xJ
# RUN cd /opt && curl -SL http://github.com/openrisc/or1k-gcc/releases/download/or1k-7.2.0-20180317/or1k-linux-7.2.0-20180317.tar.xz | tar xJ



# RUN cd /root && git clone --recursive --depth=1 https://github.com/m-labs/migen.git && cd migen && ./setup.py install
# RUN cd /root && git clone --depth=1 --recursive https://github.com/m-labs/misoc.git && cd misoc && ./setup.py install


# RUN curl -SL "https://www.ohwr.org/project/wr-cores/uploads/2776ce0ba43503d1486ae205b48fb450/lm32_host_64bit.tar.xz" | tar -xvJ
# ENV PATH=/root/lm32-gcc-4.5.3/bin:$PATH

# COPY install/buildtoolchain.sh /tmp
# RUN  cd /tmp && bash buildtoolchain.sh && rm -rf *
# ENV PATH=/usr/mico32/bin:$PATH



RUN cd /tmp &&  curl -SL http://download.qemu.org/qemu-4.0.0.tar.xz  | tar xJ && \
    cd qemu-4.0.0 && ./configure --target-list='or1k-softmmu or1k-linux-user lm32-softmmu' && make -j8 && \
    make install && \
    cd && rm -rf /tmp/*

RUN cd /opt && curl -SL https://github.com/openrisc/tutorials/releases/download/2016.1/or1ksim.tgz | tar xz


RUN cd /tmp && curl -SL http://github.com/steveicarus/iverilog/archive/v10_2.tar.gz | tar xz && \
    cd iverilog-10_2 && sh autoconf.sh && \
    ./configure && \
    make -j8 && \
    make install && \
    cd && rm -rf /tmp/*

RUN cd /tmp && curl -SL https://www.veripool.org/ftp/verilator-4.016.tgz |tar xz && \
    cd verilator-4.016 && ./configure && \
    make -j8 && \
    make install && \
    cd && rm -rf /tmp/*

COPY install/env-setup.sh /root/

ENV PATH=/opt/intelFPGA_lite/18.1/quartus/sopc_builder/bin/:/opt/intelFPGA_lite/18.1/quartus/bin:$PATH
# ENV PATH=/opt/or1k-elf/bin:/opt/or1k-linux/bin:$PATH
ENV PATH=/opt/or1ksim/bin:$PATH

# RUN curl -SL http://github.com/torvalds/linux/archive/v5.2.tar.gz | tar xz 


#RUN echo "PATH=$PATH" > /etc/environment
ENV BUILD_DIR=/mnt/data/openrisc/dockerbuild

ENV DISPLAY :1
ENTRYPOINT /bin/sh /root/env-setup.sh
