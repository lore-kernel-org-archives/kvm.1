Received: from mail-dl2-f17.google.com (mail-dl2-f17.google.com [74.125.229.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3E5328C5
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169645; cv=none; b=KZWm4Xv9vRNlpQxuRI4UBrBnb1u3pR906ga+tDnfKkaeebwus5E8POSv5O/NBJAHb33F+yTJtCaB0b7nUEVra4UqlWuHV0OEeqPJ4vPdUpkq/EO+WZJUGf0tFPsbXgjPuLxwlp2SisV+JbmYrZAEMsJQgmxVNjaAv7FZMyHXyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169645; c=relaxed/simple;
	bh=jzwPrdFsZ6YrliT2alZlOyQZ1zrWGpXGsfICfl8CRww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOI4uXI0zfe8I0e8kXzwh4D0fnfFvM1Cw9hTiL76bCxp8ridTW0RuDNZgp3VR5jeOjSRByLa8o+3RdKK+/sZ3Rc5yEuBffYh2vFck6BoV0lESv6Eim3AOPx40iO3tF8ADHpIJJb7+wTKpR3Me2/w8/uz9lXcyShLeM+4UzQDj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab1McWZN; arc=none smtp.client-ip=74.125.229.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab1McWZN"
Received: by mail-dl2-f17.google.com with SMTP id a92af1059eb24-143859f5737so1241029c88.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169633; x=1790774433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yfDI7d67qBZp7NF6DoFzOD4nojzBBuGOhVVy0hvKz60=;
        b=Ab1McWZN4IHcYC9N2nucp2aQyERL0vbYlJgIaXzq59GkVZwcWLCVQSssGTPB4RCT2N
         v+MafGJ4yP7e38mqk8uW5sGMgedXeuPCz7MhKDgj9o13axJh1bNvyjtzb1ITmtjuGL0A
         61LUN8ym1jSOSQBeoki1REnp6b42mdW1K4oxDBf3UAzLP8NNpfhoXFyF38L+eLYbOppr
         xC6l3CBEc1kkXZTXnDXsh6exKpbOs3mUT19+jq992pocPIKg2j0LzKIA0numu/BeAXOr
         hNgpUUu4e3wuUBHnEPpLBmwOIsdAMhObSvtHGmwI4Ojy+xymjIex27QwwN8FDeef/fHe
         3/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169633; x=1790774433;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yfDI7d67qBZp7NF6DoFzOD4nojzBBuGOhVVy0hvKz60=;
        b=EAjO1Uv2ZKj2Rr1KCPFpcd5c81w003Qa2+2fL+de+ss/s01XeAnZ5hDTlPhgWxFhDe
         yF1f29Psbu0JsPcz6gdAF1vSynMo1c5Vm2puRcpalHYlEldoDl25fjO+qrsyVRQDvTe+
         vIOtuxWwzqIq7BWw5/NI0oicRKjSeNY+ljN3fOiaPW9/49Bxob8rJGjpIDNPeNNFZ1Dq
         X2PkaGQ8qixzOEMxEXCe5ZM4pMLL2gsdH5Whle9PGQps9yHJofU64Fovn4faQEGH98Ju
         wKWu/EYMd/c5GfCc28HrUY/NQ9VUWc8OkdGgH77lIuEmen9TYXJ7h3uV9dAq4T4HzhZ6
         pbeA==
X-Forwarded-Encrypted: i=1; AKwUvBzG79AMoSiWmc0dnnzPhvAL1BDX/MMqETXBx/L+W3XeNYelDBUByONHE1wCiPnrl0N99QM=@vger.kernel.org
X-Gm-Message-State: AFuF++k3tyjWI8N4k/Fp7ZBB9YWL9novieJbeRRQb57692j4u8zLXPEx
	pZDxXPs//ptudJVf9P7xnChenEIx/6YYC8TiJRD+z1DMT3KUfVcv/u2G
X-Gm-Gg: AYBFou0go++49zJze5MklrjLVfUBD0fDd9bRHwHUblrltp/DccW5KQ+pFsgt/ZCAZAw
	DIf+i2MstVrUdW+EySA3EiF/yIV6tl5pHL49wTIoRIQywvIaMfTSK5R2HOx0ubriLPZnJh8ovhc
	cMUKtswjcSAFRx61bnLTbwu2TKVYIxfojbJ1vWksUs/acMJPcX/ZAaJWqWJfBsOPMBPWjh2sUI8
	NBg6uSPL5M5k8agJzVwU6xMVrXvpF/XRanxPcss/0HxzQ10jGa72n8GHYDj98/40g9lELuHR4vd
	+KK8MJCuGsLVtUbkMajLb0hghhmM/qoOFYKrZz6ppYcL1INXK8Up+42e+c3/u2HA0SRiCygiIdE
	PccAEjPUFEtADxdRVf1TzwvTtQcjZFZ0RQ9wYHVslcX8KIVUdV+SX/hQu+gjwDLXDXKlUPj/jFe
	hN10m1a5hI0BstmTN4KjzLsi/iMr8C8BIMgkbhxO20QnfVedy7na1hHtgFtXT40PS9epVIKDrcS
	UmaJoDVmbns+FslL5okTpRAlrm+eHrgvNz7bhutDA==
X-Received: by 2002:a05:7022:3f81:b0:144:c113:77bb with SMTP id a92af1059eb24-144f9179520mr3177544c88.26.1790169632575;
        Wed, 23 Sep 2026 06:20:32 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:20:31 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 021/114] hw/arm/virt: prefix ACPI helpers with arm_virt_
Date: Wed, 23 Sep 2026 21:14:55 +0800
Message-ID: <20260923131635.1894-22-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- virt_acpi_setup and virt_is_acpi_enabled are generic names also used
  by RISC-V and LoongArch virt. A combined binary cannot export two
  functions with the same C symbol.
- Rename the ARM helpers to arm_virt_acpi_setup and
  arm_virt_is_acpi_enabled. Leave the trace event virt_acpi_setup
  unchanged; it is a separate identifier.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/virt-acpi-build.c |  4 ++--
 hw/arm/virt.c            | 12 ++++++------
 include/hw/arm/virt.h    |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index d368913e766..5737c3a8fa4 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1559,7 +1559,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     },
 };
 
-void virt_acpi_setup(VirtMachineState *vms)
+void arm_virt_acpi_setup(VirtMachineState *vms)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
@@ -1570,7 +1570,7 @@ void virt_acpi_setup(VirtMachineState *vms)
         return;
     }
 
-    if (!virt_is_acpi_enabled(vms)) {
+    if (!arm_virt_is_acpi_enabled(vms)) {
         trace_virt_acpi_setup();
         return;
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c8ffa1ceaf4..331fae883c7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -769,7 +769,7 @@ static void fdt_add_cpu_nodes(VirtMachineState *vms)
                     &bottom_node,
                     CPU_TOPOLOGY_LEVEL_SOCKET);
             if (cache_at_topo_level) {
-                if (bottom_node == 1 && !virt_is_acpi_enabled(vms))
+                if (bottom_node == 1 && !arm_virt_is_acpi_enabled(vms))
                     error_setg(
                         &error_fatal,
                         "Cannot share L1 at socket_id %d."
@@ -809,7 +809,7 @@ static void fdt_add_cpu_nodes(VirtMachineState *vms)
                                                         top_cluster,
                                                         bottom_cluster, cpu,
                                                         &cluster_offset);
-                if (bottom_cluster == 1 && !virt_is_acpi_enabled(vms)) {
+                if (bottom_cluster == 1 && !arm_virt_is_acpi_enabled(vms)) {
                     error_setg(&error_fatal,
                         "Cannot share L1 at socket_id %d, cluster_id %d. "
                         "DT limitation on sharing at cache level = 1.",
@@ -2036,7 +2036,7 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms, DeviceState *dev,
     hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
     MachineState *ms = MACHINE(vms);
 
-    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms))) {
+    if (!(vms->bootinfo.firmware_loaded && arm_virt_is_acpi_enabled(vms))) {
         if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
             error_setg(errp, "SMMUv3 with accel=on not supported for DT");
             return;
@@ -2446,7 +2446,7 @@ void virt_machine_done(Notifier *notifier, void *data)
     pci_bus_add_fw_cfg_extra_pci_roots(vms->fw_cfg, vms->bus,
                                        &error_abort);
 
-    virt_acpi_setup(vms);
+    arm_virt_acpi_setup(vms);
     virt_build_smbios(vms);
 }
 
@@ -3210,7 +3210,7 @@ static void machvirt_init(MachineState *machine)
     create_pcie(vms);
     create_cxl_host_reg_region(vms);
 
-    if (aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
+    if (aarch64 && firmware_loaded && arm_virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
         vms->generic_error_notifier.notify = virt_generic_error_req;
         notifier_list_add(&acpi_generic_error_notifiers,
@@ -3560,7 +3560,7 @@ static void virt_set_oem_table_id(Object *obj, const char *value,
 }
 
 
-bool virt_is_acpi_enabled(const VirtMachineState *vms)
+bool arm_virt_is_acpi_enabled(const VirtMachineState *vms)
 {
     if (vms->acpi == ON_OFF_AUTO_OFF) {
         return false;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 383ee320948..2ee61cc5a06 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -218,8 +218,8 @@ struct VirtMachineState {
 #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("arm-virt")
 OBJECT_DECLARE_TYPE(VirtMachineState, VirtMachineClass, VIRT_MACHINE)
 
-void virt_acpi_setup(VirtMachineState *vms);
-bool virt_is_acpi_enabled(const VirtMachineState *vms);
+void arm_virt_acpi_setup(VirtMachineState *vms);
+bool arm_virt_is_acpi_enabled(const VirtMachineState *vms);
 
 #define CLIDR_CTYPE_NO_CACHE 0x00
 #define CLIDR_CTYPE_I_CACHE 0x01
-- 
2.52.0.windows.1

