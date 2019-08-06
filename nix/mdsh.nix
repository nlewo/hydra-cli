self: super: {
  # XXX: we use buildPackageSingleStep instead of buildPackage, because the
  # cargo version is too old to benefit from incremental builds.
  mdsh = super.naersk.buildPackageSingleStep super.sources.mdsh {
    doDoc = false;
    name = "mdsh-${super.sources.mdsh.version}";
  };
}
