# Work around a stamp-sharing bug between externalsrc.bbclass and create-spdx-2.2.bbclass.
#
# externalsrc.bbclass forces STAMP to a MACHINE-independent "work-shared" path
# (STAMP = "${STAMPS_DIR}/work-shared/${PN}/...") whenever EXTERNALSRC is set, which it
# is for external-dt on every stm32mpcommonmx machine (see external-dt_%.bbappend +
# ENABLE_CUBEMX_DTB). do_collect_spdx_deps (create-spdx-2.2.bbclass) has no
# [stamp-extra-info] and its task hash does not vary by MACHINE, so its stamp file
# collides across every machine sharing this recipe. bitbake then skips the task for
# every machine except the first one built, leaving WORKDIR/spdx/deps.json missing on
# the rest and do_create_spdx crashing with:
#   FileNotFoundError: .../external-dt/6.0/spdx/deps.json
#
# Fix: give do_collect_spdx_deps the same per-machine stamp suffix OE-core already
# gives do_packagedata (see meta/classes-global/package.bbclass:
#   do_packagedata[stamp-extra-info] = "${MACHINE_ARCH}"
# ) so its stamp -- and therefore its execution -- is correctly machine-specific again.
do_collect_spdx_deps[stamp-extra-info] = "${MACHINE_ARCH}"
