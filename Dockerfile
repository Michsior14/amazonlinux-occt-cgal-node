ARG amazonlinux_version=2
ARG node_version=8
ARG occt_version=V7_3_0p3
ARG cgal_version=4.14.1

FROM "amazonlinux:$amazonlinux_version"
ARG node_version
ARG occt_version
ARG cgal_version

RUN yum update -y \
  && curl -sL https://rpm.nodesource.com/setup_$node_version.x | bash - \
  && curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
  && yum install -y gcc-c++ make cmake3 git gmp-devel mpfr-devel nodejs \ 
  boost-devel tcl-devel tk-devel mesa-libGL-devel libXmu-devel libXi-devel yarn \
  && git config --global core.compression 0 \
  && cd / \
  && git clone --depth=1 --branch=releases/CGAL-$cgal_version https://github.com/CGAL/cgal.git \
  && cd /cgal \
  && mkdir -p build/release \
  && cd build/release \
  && cmake3 -DCMAKE_BUILD_TYPE=Release ../.. \
  && make -j4 install \
  && cd / \
  && rm -rf /cgal \
  && git clone --depth=1 --branch=$occt_version https://git.dev.opencascade.org/repos/occt.git \
  && cd /occt \
  && mkdir build \
  && cd build \
  && cmake3 .. \
  && make -j4 install \
  && cd / \
  && rm -rf /occt \
  && yum remove -y gmp-devel mpfr-devel boost-devel \ 
  tcl-devel tk-devel mesa-libGL-devel libXmu-devel libXi-devel \
  && yum autoremove -y
