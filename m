Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C433D4E8;
	Fri,  3 Jul 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056211; cv=none; b=JuxH/SK6wbRExHPhggeZVBaccQqeQzrCojVkgEN2U6MNd5qj4nQgwGb9LWCbY+1EYl4kLhbQUVO+5U9owXRA0/zrG/cawSX0lNkZwRj5VlH2TmojpXkgeTUivP/G6fcx5pv9/XtJlRJjjzegQGEpxHkj7MAcRSTgUryb1FU7SII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056211; c=relaxed/simple;
	bh=rfWCLDHUcpahNgEC3SGqI/nzOlyqMecU43nGCyZYC8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoJzXrygrb71lNgeWKZqU6WXcNxQM5AfQ65+fzb7v6L0FbusdfW1qk9M/x81IwmoJM+I73s/i4Ia8dJWHoNtwcrm61aBR29vHqHnil99INz6NnloOJuMtxJUNamyYziAzjxihLaeMbpRntoLXxStwCtGc5EYGd62rx0Iql80j+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=S20lgzeI reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="S20lgzeI"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635LT8O018373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:21:42 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=SuGsYbGlKlc6b1DT5vt3OpkvoEjMGNIgH0RWbpVGexY=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783056103; v=1;
        b=S20lgzeIrAK4H5mymbVMmwynLidXIEr8fLV0kex6TpzJb5R7oEizYlM/qZE1O+0g
         uFjFcXYzOE14hzhJFWsTFYQdrmv0K6in73PtRufsQ8r/GM5NKIH1s+recQO8juh2
         OaLEHIJBnUFgD+64n49UVucLVF9m+evAEg5zzgel4m7DkbrP1GMHAxna2ees1IG7
         5bZ5m1XfKnCX5ZK+nZtBXgbqRIx9vn+a6hMl6pJd4EDLfwO1HrN2/08um2ZcPz8+
         LyZlj6HTfbSxhxolTgpyMFL4zAzoXqOeexN24QPRCs+XynFBalZt3684DJiym37y
         lwANSpgPCJHO5Vz6eFRBtg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:19:17 +0900
Subject: [PATCH v2 1/7] hw/nvram/fw_cfg: Remove acpi-mr-restore
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-ram-v2-1-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=rfWCLDHUcpahNgEC3SGqI/nzOlyqMecU43nGCyZYC8s=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7292uvb5fvrnm7tp9b5dvJte9v0uYEovO1uddvZ35h
 NFhQtvZjlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgInUXWD4n3Q8Z7FJ9M3+/FlP
 yrWtlv46vnNK17JZ90Nzdlx6dcBGrpWRYeH/uf8fOdSpt8X3Xi7e9oZt790XTTtv/ZL4+X3x6UM
 KvHwA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

The acpi-mr-restore property exists only for migration compatibility
with QEMU 4.2, which is no longer a supported migration source.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/nvram/fw_cfg.h | 1 -
 hw/core/machine.c         | 1 -
 hw/nvram/fw_cfg.c         | 8 +-------
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 56f17a0bdcf7..6aad9aad7694 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -73,7 +73,6 @@ struct FWCfgState {
     MemoryRegion dma_iomem;
 
     /* restore during migration */
-    bool acpi_mr_restore;
     uint64_t table_mr_size;
     uint64_t linker_mr_size;
     uint64_t rsdp_mr_size;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9a10e45aabd5..44803e884140 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -214,7 +214,6 @@ GlobalProperty hw_compat_4_2[] = {
     { "usb-redir", "suppress-remote-wake", "off" },
     { "qxl", "revision", "4" },
     { "qxl-vga", "revision", "4" },
-    { "fw_cfg", "acpi-mr-restore", "false" },
     { "virtio-device", "use-disabled-flag", "false" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 1d7d83542137..f4e3e50224ca 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -612,7 +612,7 @@ static bool fw_cfg_acpi_mr_restore(void *opaque)
     mr_aligned = QEMU_IS_ALIGNED(s->table_mr_size, qemu_real_host_page_size()) &&
                  QEMU_IS_ALIGNED(s->linker_mr_size, qemu_real_host_page_size()) &&
                  QEMU_IS_ALIGNED(s->rsdp_mr_size, qemu_real_host_page_size());
-    return s->acpi_mr_restore && !mr_aligned;
+    return !mr_aligned;
 }
 
 static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
@@ -987,10 +987,6 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
     qemu_register_reset(fw_cfg_machine_reset, s);
 }
 
-static const Property fw_cfg_properties[] = {
-    DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore, true),
-};
-
 static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
 {
     FWCfgState *s = FW_CFG(dev);
@@ -1149,8 +1145,6 @@ static void fw_cfg_class_init(ObjectClass *klass, const void *data)
 
     device_class_set_legacy_reset(dc, fw_cfg_reset);
     dc->vmsd = &vmstate_fw_cfg;
-
-    device_class_set_props(dc, fw_cfg_properties);
 }
 
 static const TypeInfo fw_cfg_info = {

-- 
2.54.0

