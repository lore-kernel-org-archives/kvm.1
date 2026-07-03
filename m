Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E23115BC;
	Fri,  3 Jul 2026 05:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056214; cv=none; b=ld8T7YlebQOX6thLjiqeoPmB0nLc+WaQ8dBz+8/mHv6DfUewD1OGohpcZHvrFhJnSFe+sOE6d8FSBJyT45psra7KdbFrabXw5MUhjnvDUtUN6NkFdYT3qTOCyahlWotkPNHy79WcFCEl/6LL8j4JxH4+Sxo74dpc8ibpCZAF5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056214; c=relaxed/simple;
	bh=ccy6opZLwUXKw1fFsJIq/3ZXHcSwmcArvoTXP9WAi+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=src4dGsfe87Uymn6it+4Sfw4zcERvOHLYD0NT7c7ZHcFlFDQH76A3JRjD4Q1iPENK1G2pEI16TNK/OYqp/RR/fJ3pdICBNmUGbRXvoWhuFrMv+5WCbi43bkMA9gDSOzUspVb6UpR/h/9SANCVVD+F5dzZnCQMIwGHzNKp4wjpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=eA+u+b5P reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="eA+u+b5P"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635LT8P018373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:21:43 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=yI7z983L2jKLplCj01xQZlmdHreHtJMxOkjcK5D3Uhg=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783056104; v=1;
        b=eA+u+b5Pn/F6Fsu4XPL2Fil+YxYg1ZkQ4++IfHV0CZAegdmINv/jec+3gJCku6sS
         1Kgpnin6bB3a3dKwGxXYGzMFW0yn2kSvLDRJhbYW6gNMl45KzgJUA5tKmCHwgCSk
         f+IEKE214HwMehUnBmsvSTUaJXjU9iJmVJ3UYsaxlKNbAnQckH5wIPNhsyk7jwuH
         ufv2SYJDdz1XC7HnPTzFKX/oKmtFL9DMPxfozld5JtnfqYEh5V3JK6epFJQYzkIY
         2Oj/IWFYlmHYiy5KblnCVeIwkAuOfStcpVUtczbk42Y87GNMCuDCMkNBm1h34uA6
         fqVOF77PetcRnkg4/nn5fw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:19:18 +0900
Subject: [PATCH v2 2/7] hw/nvram/fw_cfg: Avoid resizing RAM at runtime
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-ram-v2-2-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
References: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
        =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Reinoud Zandijk <reinoud@netbsd.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Alex Williamson <alex@shazbot.org>,
        =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li <liwei1518@gmail.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Chao Liu <chao.liu.zevorn@gmail.com>, linux-edac@vger.kernel.org,
        qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=19046;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=ccy6opZLwUXKw1fFsJIq/3ZXHcSwmcArvoTXP9WAi+0=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a72z3zK461+97OmDpTvi9l0bklb0+z3bYv1f54sjWfX
 WrvcfHojlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgInEKzD89zaprCy8/LN69qYr
 CxdKmMr9Pi0Xv04h877g7W097KrC0xl+s0tJXjefVnx68x7j59pp5zKvXOdS57/pdO30fYu5vIE
 nGAE=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

There is a chance that migration is aborted when the following
conditions are met:
1. The machine has not booted yet, or devices have been hotplugged since
   the last boot.
2. The machine is (re)booting.
3. Migration is running concurrently.

This is because the size of ACPI data is determined after the firmware
configures the machine at boot time, and that may change the size of
backing RAM. This aborts migration if the RAM is concurrently being
copied. It is rare that all three conditions are met at the same time,
but migrating after device hotplug and migrating during reboot are
supported, so ideally their combination should be supported.

To support this scenario, allocate RAM for the maximum ACPI data size
up front, while exposing only the current ACPI data size through fw_cfg.
This avoids runtime RAMBlock resize during ACPI rebuilds and lets the
memory and migration code handle the RAMBlock like any other fixed-size
RAMBlock.

The ACPI data still uses resizable RAM for migration compatibility. The
destination may resize it while loading migration streams from older
QEMU versions, but it immediately grows the RAM back to the maximum
size. This destination-side resize does not cause migration to abort.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/core/loader.h       |  1 +
 include/hw/nvram/fw_cfg.h      |  4 ++-
 hw/acpi/ghes.c                 |  6 ++--
 hw/acpi/vmgenid.c              |  1 +
 hw/arm/virt-acpi-build.c       |  3 +-
 hw/core/loader.c               | 14 +++++---
 hw/display/ramfb.c             |  2 +-
 hw/i386/acpi-build.c           |  3 +-
 hw/isa/lpc_ich9.c              |  2 ++
 hw/loongarch/virt-acpi-build.c |  3 +-
 hw/misc/vmcoreinfo.c           |  3 +-
 hw/nvram/fw_cfg.c              | 74 ++++++++++++++++++++++++++----------------
 hw/riscv/virt-acpi-build.c     |  3 +-
 13 files changed, 77 insertions(+), 42 deletions(-)

diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index d9431e8a8d12..d563acc1f1dd 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -259,6 +259,7 @@ void pstrcpy_targphys(const char *name,
                       hwaddr dest, int buf_size,
                       const char *source);
 
+void rom_resize(const MemoryRegion *mr, size_t len);
 ssize_t rom_add_file(const char *file, const char *fw_dir,
                      hwaddr addr, int32_t bootindex,
                      bool has_option_rom, MemoryRegion *mr, AddressSpace *as);
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 6aad9aad7694..201b33434a3c 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -240,6 +240,7 @@ void fw_cfg_add_file(FWCfgState *s, const char *filename, void *data,
  * @callback_opaque: argument to be passed into callback function
  * @data: pointer to start of item data
  * @len: size of item data
+ * @max_len: maximum size of item data
  * @read_only: is file read only
  *
  * Add a new NAMED fw_cfg item as a raw "blob" of the given size. The data
@@ -258,7 +259,8 @@ void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
                               FWCfgCallback select_cb,
                               FWCfgWriteCallback write_cb,
                               void *callback_opaque,
-                              void *data, size_t len, bool read_only);
+                              void *data, size_t len, size_t max_len,
+                              bool read_only);
 
 /**
  * fw_cfg_modify_file:
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index b2d5e3499320..9679059100e5 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -415,11 +415,13 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
 
     if (ags->use_hest_addr) {
         fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
-            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+            NULL, &(ags->hest_addr_le),
+            sizeof(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
     } else {
         /* Create a read-write fw_cfg file for Address */
         fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
-            NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
+            NULL, &(ags->hw_error_le),
+            sizeof(ags->hw_error_le), sizeof(ags->hw_error_le), false);
     }
 }
 
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 27cc0128d117..c2a4eb7ac394 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -130,6 +130,7 @@ void vmgenid_add_fw_cfg(VmGenIdState *vms, FWCfgState *s, GArray *guid)
     /* Create a read-write fw_cfg file for Address */
     fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FILE, NULL, NULL, NULL,
                              vms->vmgenid_addr_le,
+                             ARRAY_SIZE(vms->vmgenid_addr_le),
                              ARRAY_SIZE(vms->vmgenid_addr_le), false);
 }
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 99490aa7b1fb..9e3ae08f1f8e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -32,6 +32,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
@@ -1469,7 +1470,7 @@ static void acpi_ram_update(MemoryRegion *mr, GArray *data)
 
     /* Make sure RAM size is correct - in case it got changed
      * e.g. by migration */
-    memory_region_ram_resize(mr, size, &error_abort);
+    rom_resize(mr, size);
 
     memcpy(memory_region_get_ram_ptr(mr), data->data, size);
     memory_region_set_dirty(mr, 0, size);
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d2..14d56f52e4ec 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1051,10 +1051,14 @@ static void rom_insert(Rom *rom)
     QTAILQ_INSERT_TAIL(&roms, rom, next);
 }
 
-static void fw_cfg_resized(const char *id, uint64_t length, void *host)
+void rom_resize(const MemoryRegion *mr, size_t len)
 {
     if (fw_cfg) {
-        fw_cfg_modify_file(fw_cfg, id + strlen("/rom@"), host, length);
+        const char *name = memory_region_name(mr);
+        void *host = memory_region_get_ram_ptr(mr);
+
+        assert(len <= memory_region_size(mr));
+        fw_cfg_modify_file(fw_cfg, name + strlen("/rom@"), host, len);
     }
 }
 
@@ -1064,8 +1068,8 @@ static void *rom_set_mr(Rom *rom, Object *owner, const char *name, bool ro)
 
     rom->mr = g_malloc(sizeof(*rom->mr));
     memory_region_init_resizeable_ram(rom->mr, owner, name,
-                                      rom->datasize, rom->romsize,
-                                      fw_cfg_resized,
+                                      rom->romsize, rom->romsize,
+                                      NULL,
                                       &error_fatal);
     memory_region_set_readonly(rom->mr, ro);
     vmstate_register_ram_global(rom->mr);
@@ -1196,7 +1200,7 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
 
         fw_cfg_add_file_callback(fw_cfg, fw_file_name,
                                  fw_callback, NULL, callback_opaque,
-                                 data, rom->datasize, read_only);
+                                 data, rom->datasize, rom->romsize, read_only);
     }
     return mr;
 }
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index f477bdcc2186..3c4be28072fb 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -154,6 +154,6 @@ RAMFBState *ramfb_setup(bool romfile, Error **errp)
     }
     fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                              NULL, ramfb_fw_cfg_write, s,
-                             &s->cfg, sizeof(s->cfg), false);
+                             &s->cfg, sizeof(s->cfg), sizeof(s->cfg), false);
     return s;
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2ee061558c08..a83a9893a827 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -30,6 +30,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/cxl/cxl.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "target/i386/cpu.h"
 #include "hw/timer/hpet.h"
 #include "hw/acpi/acpi-defs.h"
@@ -2138,7 +2139,7 @@ static void acpi_ram_update(MemoryRegion *mr, GArray *data)
     uint32_t size = acpi_data_len(data);
 
     /* Make sure RAM size is correct - in case it got changed e.g. by migration */
-    memory_region_ram_resize(mr, size, &error_abort);
+    rom_resize(mr, size);
 
     memcpy(memory_region_get_ram_ptr(mr), data->data, size);
     memory_region_set_dirty(mr, 0, size);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 9cec18a378c2..fe5c8d6f44f4 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -449,11 +449,13 @@ static void ich9_lpc_pm_init(ICH9LPCState *lpc)
                                  NULL, NULL, NULL,
                                  lpc->smi_guest_features_le,
                                  sizeof lpc->smi_guest_features_le,
+                                 sizeof lpc->smi_guest_features_le,
                                  false);
         fw_cfg_add_file_callback(fw_cfg, "etc/smi/features-ok",
                                  smi_features_ok_callback, NULL, lpc,
                                  &lpc->smi_features_ok,
                                  sizeof lpc->smi_features_ok,
+                                 sizeof lpc->smi_features_ok,
                                  true);
     }
 }
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index a0b445f297b4..4be390189637 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -11,6 +11,7 @@
 #include "qemu/bitmap.h"
 #include "hw/pci/pci.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "target/loongarch/cpu.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
@@ -630,7 +631,7 @@ static void acpi_ram_update(MemoryRegion *mr, GArray *data)
      * Make sure RAM size is correct - in case it got changed
      * e.g. by migration
      */
-    memory_region_ram_resize(mr, size, &error_abort);
+    rom_resize(mr, size);
 
     memcpy(memory_region_get_ram_ptr(mr), data->data, size);
     memory_region_set_dirty(mr, 0, size);
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 9c2e9005ad32..8cb1763c1a44 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -59,7 +59,8 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
 
     fw_cfg_add_file_callback(fw_cfg, FW_CFG_VMCOREINFO_FILENAME,
                              NULL, fw_cfg_vmci_write, s,
-                             &s->vmcoreinfo, sizeof(s->vmcoreinfo), false);
+                             &s->vmcoreinfo, sizeof(s->vmcoreinfo),
+                             sizeof(s->vmcoreinfo), false);
 
     /*
      * This device requires to register a global reset because it is
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index f4e3e50224ca..03fb4b569fe7 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -60,6 +60,7 @@
 
 struct FWCfgEntry {
     uint32_t len;
+    uint32_t max_len;
     bool allow_write;
     uint8_t *data;
     void *callback_opaque;
@@ -604,20 +605,8 @@ bool fw_cfg_dma_enabled(void *opaque)
     return s->dma_enabled;
 }
 
-static bool fw_cfg_acpi_mr_restore(void *opaque)
+static MemoryRegion *fw_cfg_get_mr(FWCfgState *s, uint16_t key)
 {
-    FWCfgState *s = opaque;
-    bool mr_aligned;
-
-    mr_aligned = QEMU_IS_ALIGNED(s->table_mr_size, qemu_real_host_page_size()) &&
-                 QEMU_IS_ALIGNED(s->linker_mr_size, qemu_real_host_page_size()) &&
-                 QEMU_IS_ALIGNED(s->rsdp_mr_size, qemu_real_host_page_size());
-    return !mr_aligned;
-}
-
-static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
-{
-    MemoryRegion *mr;
     ram_addr_t offset;
     int arch = !!(key & FW_CFG_ARCH_LOCAL);
     void *ptr;
@@ -626,31 +615,57 @@ static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
     assert(key < fw_cfg_max_entry(s));
 
     ptr = s->entries[arch][key].data;
-    mr = memory_region_from_host(ptr, &offset);
+    return memory_region_from_host(ptr, &offset);
+}
+
+static bool fw_cfg_pre_load_errp(void *opaque, Error **errp)
+{
+    FWCfgState *s = opaque;
+
+    s->table_mr_size = UINT64_MAX;
+    s->linker_mr_size = UINT64_MAX;
+    s->rsdp_mr_size = UINT64_MAX;
 
-    memory_region_ram_resize(mr, size, &error_abort);
+    return true;
 }
 
-static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_id)
+static bool fw_cfg_post_load_errp(void *opaque, int version_id, Error **errp)
 {
     FWCfgState *s = opaque;
     int i, index;
+    uint64_t *size;
 
     assert(s->files);
 
     index = be32_to_cpu(s->files->count);
 
     for (i = 0; i < index; i++) {
+        uint16_t key = FW_CFG_FILE_FIRST + i;
+        MemoryRegion *mr;
+        int arch = !!(key & FW_CFG_ARCH_LOCAL);
+
         if (!strcmp(s->files->f[i].name, ACPI_BUILD_TABLE_FILE)) {
-            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->table_mr_size);
+            size = &s->table_mr_size;
         } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_LOADER_FILE)) {
-            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->linker_mr_size);
+            size = &s->linker_mr_size;
         } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_RSDP_FILE)) {
-            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->rsdp_mr_size);
+            size = &s->rsdp_mr_size;
+        } else {
+            continue;
         }
+
+        mr = fw_cfg_get_mr(s, key);
+
+        if (*size == UINT64_MAX) {
+            *size = memory_region_size(mr);
+        }
+
+        rom_resize(mr, *size);
+        memory_region_ram_resize(mr, s->entries[arch][key].max_len,
+                                 &error_abort);
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_fw_cfg_dma = {
@@ -666,8 +681,6 @@ static const VMStateDescription vmstate_fw_cfg_acpi_mr = {
     .name = "fw_cfg/acpi_mr",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = fw_cfg_acpi_mr_restore,
-    .post_load = fw_cfg_acpi_mr_restore_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(table_mr_size, FWCfgState),
         VMSTATE_UINT64(linker_mr_size, FWCfgState),
@@ -680,6 +693,8 @@ static const VMStateDescription vmstate_fw_cfg = {
     .name = "fw_cfg",
     .version_id = 2,
     .minimum_version_id = 1,
+    .pre_load_errp = fw_cfg_pre_load_errp,
+    .post_load_errp = fw_cfg_post_load_errp,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(cur_entry, FWCfgState),
         VMSTATE_UINT16_HACK(cur_offset, FWCfgState, is_version_1),
@@ -697,7 +712,7 @@ static void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
                                       FWCfgCallback select_cb,
                                       FWCfgWriteCallback write_cb,
                                       void *callback_opaque,
-                                      void *data, size_t len,
+                                      void *data, size_t len, size_t max_len,
                                       bool read_only)
 {
     int arch = !!(key & FW_CFG_ARCH_LOCAL);
@@ -709,6 +724,7 @@ static void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
 
     s->entries[arch][key].data = data;
     s->entries[arch][key].len = (uint32_t)len;
+    s->entries[arch][key].max_len = (uint32_t)max_len;
     s->entries[arch][key].select_cb = select_cb;
     s->entries[arch][key].write_cb = write_cb;
     s->entries[arch][key].callback_opaque = callback_opaque;
@@ -737,7 +753,7 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
 void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len)
 {
     trace_fw_cfg_add_bytes(key, trace_key_name(key), len);
-    fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, true);
+    fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, len, true);
 }
 
 void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
@@ -838,7 +854,8 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
                               FWCfgCallback select_cb,
                               FWCfgWriteCallback write_cb,
                               void *callback_opaque,
-                              void *data, size_t len, bool read_only)
+                              void *data, size_t len, size_t max_len,
+                              bool read_only)
 {
     int i, index, count;
     size_t dsize;
@@ -889,7 +906,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
 
     fw_cfg_add_bytes_callback(s, FW_CFG_FILE_FIRST + index,
                               select_cb, write_cb,
-                              callback_opaque, data, len,
+                              callback_opaque, data, len, max_len,
                               read_only);
 
     s->files->f[index].size   = cpu_to_be32(len);
@@ -904,7 +921,8 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
 void fw_cfg_add_file(FWCfgState *s,  const char *filename,
                      void *data, size_t len)
 {
-    fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, true);
+    fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL,
+                             data, len, len, true);
 }
 
 void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
@@ -930,7 +948,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     assert(index < fw_cfg_file_slots(s));
 
     /* add new one */
-    fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, true);
+    fw_cfg_add_file(s, filename, data, len);
     return NULL;
 }
 
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 413d47d70ef1..10825fa37769 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -29,6 +29,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/utils.h"
+#include "hw/core/loader.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/nvram/fw_cfg_acpi.h"
 #include "hw/pci-host/gpex.h"
@@ -961,7 +962,7 @@ static void acpi_ram_update(MemoryRegion *mr, GArray *data)
      * Make sure RAM size is correct - in case it got changed
      * e.g. by migration
      */
-    memory_region_ram_resize(mr, size, &error_abort);
+    rom_resize(mr, size);
 
     memcpy(memory_region_get_ram_ptr(mr), data->data, size);
     memory_region_set_dirty(mr, 0, size);

-- 
2.54.0

