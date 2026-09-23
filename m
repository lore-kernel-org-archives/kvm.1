Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815A5304CE
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169689; cv=none; b=jfaU2tGABTRtnp0MR4ZuJzoXmeBDAu+8iU5DDM4K21h/RWLUSy8JmbX3e0UxQ5ggJhpV2nvyMMk00H/df2LMd/RUstJYhjK3yj1Dz14/9I5PKuAmbBUyzsv0O2bczZybf6uFm0LcGEtyI4FfENhA8J71sy2aZDHNMpnyCPzKhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169689; c=relaxed/simple;
	bh=nqZTFqJ0MGsWv5f56iW3pRg5FKjAf1KGPltpgTRantw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFLyhliftHWJ8+vcJ0whfd2zBUEAt4XPUT8GIRY1sJa6SyqdM+WbkXgBtvK1Hb3Xzn2GNAVIwRhZuSf7yzxEiVfiWTECLYZBCiYbeO6awvAZNTqt564GE4RltEcG4O7icYWZms1a7Hmg+82AeixkoZEFv30L2p/F/drLi8j1cUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPOfMmgx; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPOfMmgx"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32dbbe82e13so794111eec.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169673; x=1790774473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aW7Q/4+ozQSDE0PZQ7E9tHZoVUU6eb45JG6HfJcLS94=;
        b=LPOfMmgx6Afz/ScJdTxk3c6B8iWK9oulkaPSH+FSwDWH/Bc6nQ4TnXoMTMmixAhU9e
         VPPrLsA+H38FSNXkFDKhEYPFh8CqH1pbCKU6crnEYLbCH8yBoJulhs4kjJ+Q5ai2Qw/C
         EV/MBAcfLQCqaAL1qbFbwjZ0Pw63X5oMjXtIvYweNMmVz+ipHjOrO4O5ADG4YC4h6bb6
         uIRLapPCE8Yj0qoKIxkIHn+1iezu4X/p7ZOY/sBLXfOsi+0Ck1Kp08ZbvW62azObLO75
         ZBDO2ZqnbHSW5cj5xQHRtXwQejj8aqTzEyQ8uc7P2j3E7txkgsltpZXgYwGhfcRtfgrU
         L1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169673; x=1790774473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aW7Q/4+ozQSDE0PZQ7E9tHZoVUU6eb45JG6HfJcLS94=;
        b=pZKGYMXJrfVVipfcnh/Q4XBbmjrrc1/FjJKPR9sRHwXyAb1wgdsMzlXAT8eqrh1AoJ
         NNtdRRenA5N3Q83VdDRGnz5yOKlz1LsGTXr2Alr6m1osQMrDSJNqm8fSOpJOPooacdZH
         2M078UWiT2DEZHkAYLBFk35/dKn1ERIhb71yh+7XWP7Vl9BZfF0TUk9QYify4pz3pLkr
         Sh0or5upr/+GNrpX7fP2j0ASVbZw4feGuOwLfcbgDQAACEDErtx7iIVRQ+sdNLzYVSIS
         NLOybw9iY+RGG1a3XNxGJWC/yMoen/4BL7+CBkweWVj8Ej0tqtaacG0+ooZ9c3AUSU1f
         j/Cw==
X-Forwarded-Encrypted: i=1; AKwUvBwv09P7GenPkbiXfOlTXAQVaqiVDTBnq95InCBrWzyVBC+5cJPLdd8wVh1tN4xQDXFrHMg=@vger.kernel.org
X-Gm-Message-State: AFuF++kUY+WqIAj+uUYQq6DrKiV86co9pPykthfu0Qg2AZ0na0DCc2yp
	THVSuyshzHdl63LJON/AVglvyBiJO50kyz8QC2SeLuOPSOJYZUmFHOUD
X-Gm-Gg: AYBFou3607nUMQnBel5ssnGJlysABDkAN/KIn3VemXW77Nn13ECw4CiGDf4kBwSRA1J
	rx9Igkb1jnjWMq8wY5GCyxafcQsDrSI3E2KlqzYlCnieu7hEat1jrOmD6aDhaVc0Aib5aSBOe0j
	Kr7ja1vJ5jRhxMq+W1D75/YiSUu8dD1SDcAe61QedI3wnlUVNpCQgE+CZpnq4m9wLjyZi56kDwC
	w4/FYmt6pvZCAtf/abLZxl8jYalJXVGfu3A8z0PJMpmhY1WUX0rjUzJoaLfb42Y3sHoFMkwJCg2
	vnZNDlntyoRoChpfT0swZH6nOrwSsGqz2YZnRkQjV0So9U39i06dPQFb9OkXC+guFkmvYNDnWxs
	oW/y5hyBWxzTJAqfrveivifI491YhxQ+eUnLCRSznd5Kkh2Ks0Cfzf/7Hhn7kPY+yYXPuf6Xu1A
	ubSyqRFDZcV/hpPDdZmVbHO3DVIYI2Se4BCSCHzGNgoN2D/MeHUXjAuen9oF3QncjDm+EQ9/rwc
	q+Lgfcgs81lJoMeMMHilXLfAyIkMmZrO+O+fkcptkHhgK105sxe/w==
X-Received: by 2002:a05:7300:cca4:b0:33b:fc68:9790 with SMTP id 5a478bee46e88-33e8d2ebd99mr2512374eec.21.1790169672443;
        Wed, 23 Sep 2026 06:21:12 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:21:09 -0700 (PDT)
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
Subject: [PATCH v3 025/114] hw/riscv: gate boards with target_is_base_riscv
Date: Wed, 23 Sep 2026 21:14:59 +0800
Message-ID: <20260923131635.1894-26-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Set TypeInfo.is_available to target_is_base_riscv on RISC-V machines
  so a combined qemu-system lists them only for riscv32/riscv64.
---
 hw/riscv/k230.c            | 1 +
 hw/riscv/microchip_pfsoc.c | 1 +
 hw/riscv/opentitan.c       | 1 +
 hw/riscv/shakti_c.c        | 1 +
 hw/riscv/sifive_e.c        | 1 +
 hw/riscv/sifive_u.c        | 1 +
 hw/riscv/spike.c           | 1 +
 hw/riscv/tt_atlantis.c     | 1 +
 hw/riscv/virt.c            | 1 +
 hw/riscv/xiangshan_kmh.c   | 1 +
 10 files changed, 10 insertions(+)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 79715265da6..3890cb6357d 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -557,6 +557,7 @@ static void k230_machine_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo k230_machine_typeinfo = {
     .name       = TYPE_RISCV_K230_MACHINE,
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = k230_machine_class_init,
     .instance_init = k230_machine_instance_init,
     .instance_size = sizeof(K230MachineState),
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index cc4b6bc3529..103c0d7f7ca 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -756,6 +756,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
 static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("microchip-icicle-kit"),
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = microchip_icicle_kit_machine_class_init,
     .instance_init = microchip_icicle_kit_machine_instance_init,
     .instance_size = sizeof(MicrochipIcicleKitState),
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 9e3db34eed9..db1fb3e3347 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -337,6 +337,7 @@ static const TypeInfo open_titan_types[] = {
     }, {
         .name           = TYPE_OPENTITAN_MACHINE,
         .parent         = TYPE_MACHINE,
+        .is_available   = target_is_base_riscv,
         .instance_size  = sizeof(OpenTitanState),
         .class_init     = opentitan_machine_class_init,
         .is_available   = target_is_riscv32,
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 0f96258b764..e8ae770f7ca 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -95,6 +95,7 @@ static void shakti_c_machine_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo shakti_c_machine_type_info = {
     .name = TYPE_RISCV_SHAKTI_MACHINE,
     .parent = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = shakti_c_machine_class_init,
     .instance_init = shakti_c_machine_instance_init,
     .instance_size = sizeof(ShaktiCMachineState),
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 1b6f9ab4fee..087d0c48e1e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -165,6 +165,7 @@ static void sifive_e_machine_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo sifive_e_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("sifive_e"),
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = sifive_e_machine_class_init,
     .instance_init = sifive_e_machine_instance_init,
     .instance_size = sizeof(SiFiveEState),
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 344f3d915d7..d5cc9255da6 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -679,6 +679,7 @@ static void sifive_u_machine_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo sifive_u_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("sifive_u"),
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = sifive_u_machine_class_init,
     .instance_init = sifive_u_machine_instance_init,
     .instance_size = sizeof(SiFiveUState),
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 63cf77e1de3..4bb58ec6203 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -292,6 +292,7 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo spike_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("spike"),
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = spike_machine_class_init,
     .instance_init = spike_machine_instance_init,
     .instance_size = sizeof(SpikeState),
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 086e95bd2d1..6e7272d705c 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -699,6 +699,7 @@ static const TypeInfo tt_atlantis_types[] = {
     }, {
         .name       = MACHINE_TYPE_NAME("tt-atlantis"),
         .parent     = TYPE_MACHINE,
+        .is_available = target_is_base_riscv,
         .class_init = tt_atlantis_machine_class_init,
         .instance_size = sizeof(TTAtlantisState),
         .is_available = target_is_riscv64,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0edf75fefc3..2240a516d85 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1202,6 +1202,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo virt_machine_typeinfo = {
     .name       = TYPE_RISCV_VIRT_MACHINE,
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = virt_machine_class_init,
     .instance_init = virt_machine_instance_init,
     .instance_finalize = virt_machine_instance_finalize,
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 6bc669421fe..9578a11aee6 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -220,6 +220,7 @@ static void xiangshan_kmh_machine_class_init(ObjectClass *klass, const void *dat
 static const TypeInfo xiangshan_kmh_machine_info = {
     .name = TYPE_XIANGSHAN_KMH_MACHINE,
     .parent = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .instance_size = sizeof(XiangshanKmhState),
     .class_init = xiangshan_kmh_machine_class_init,
     .is_available = target_is_riscv64,
-- 
2.52.0.windows.1

