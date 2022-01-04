ARG amazonlinux_version=2
ARG node_version=16
ARG occt_version=7.6.0
ARG cgal_version=5.3.1

FROM continuumio/miniconda3:latest as conda
ARG cgal_version
ARG occt_version
ENV PATH /opt/conda/bin:$PATH

RUN conda install -y cgal-cpp=$cgal_version occt=$occt_version --channel conda-forge

FROM "amazonlinux:$amazonlinux_version"
ARG node_version
ARG conda_path=/opt/conda

RUN curl -sL https://rpm.nodesource.com/setup_$node_version.x | bash - \
  && curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
  && yum install -y gcc-c++ make nodejs yarn python3

COPY --from=conda $conda_path/include $conda_path/include
COPY --from=conda $conda_path/lib $conda_path/lib
COPY --from=conda $conda_path/share $conda_path/share