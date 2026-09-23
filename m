Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C135D53163B
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169667; cv=none; b=CRMXpHBCKEo16em/5mEdKAQbPa9fk20fBwbnrH97tTWzw1thQ1hvTJhutfQLNFhW5r2QI98wZYh+2U6xMbi5OcaUB+to+uzQUqXX6sk7d3g2gOtfe/8Nmp5B3tgVzHEkQ4WxxYFBjgC4YFoqlW4Ga00RYtQc3aherDwWvLu+wl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169667; c=relaxed/simple;
	bh=3gl3v9H3YIjzAoX13jPV9Ijshap4AQnU19UqfeYokZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwklT/5X85nPZgmtPQiSZr2KrqRr1XWBJQ3goZfgvdCeD/LxCt5T4B1nVRlI3ttt+dHTd3IYIu+OXDdvUKVP9mCeP4QEg16ZUxrIVq2EOoEtwaMq2KXDUD+QfUznKXuShguoqquzy6e/JmkTIliX5M+Z+BzmUSch/Q1DSw7bgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjDYwglJ; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjDYwglJ"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-142dd046b85so492431c88.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169652; x=1790774452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eK1WJJTOKN3JQC4zjqi0U64pp0hPplv7AhkYIkHOF98=;
        b=QjDYwglJeTUV1xkl9oRGgor4AlwjPssyBbbjSLmacfZdQB5oCsOGZa/uQtaaeCOgn0
         2gPZHjgiyo2TrFh27250ugQ+Pwmhc9eHF5pN5RTAvZ5IEUWCM56KkFG84gCqa2INeNpf
         5yogD2h8FJbntz/x6TII65NGkdbQJiZ0cZAMezZT1D25n/0AuoTPqz2tmN+3oNS3Yyn9
         CYvMvwPjTHRsK8kUK0VY7jrSiceDmRZLwFkdhP80kwcBWkpCNyhWPO+L2oofraC0iNxx
         qD4bszO/hg+QKXt454Rg6to3nOdZybnFum1VPnWLno3C3vnoQEpemZ6rwrgEoyrp5z3s
         NcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169652; x=1790774452;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eK1WJJTOKN3JQC4zjqi0U64pp0hPplv7AhkYIkHOF98=;
        b=B4uiT8w28pmfKGJDsa/fiKL5JuYbQIvPtZsLXePohMHtGX9w8uor/7n9L30OtXYyeK
         UN13L9INDgwF/sogPKvwN5ID7n3BZN40QM89Q2LoGCu/bh+jNRI/BK58vZWjuReRIWWk
         Wv3kRcA7u+e0HGMKmwSw8wGdYKIapgRMT6cVMZiPk65wjcDhzEJRGSmeCivrBWRt7Svo
         wYC4xwxOEMCeI7J/tilYPrhp+kQjzQO1w7dvYdTGo6ihfxo5OYF/x7xBBkFrZxWMZWPK
         Kd6hRDCIa4/5MlFh6/FF8ce59LU8Oo2cAVHN/2zQ4K7zm7q+4JrkfujW371T3lW6VC7X
         1dLg==
X-Forwarded-Encrypted: i=1; AKwUvBzXQm2lu75nNOpQbKLEw5AxoSd3A7JHoENr/V2yFZcOeZnZPfJLwaoMhw9zaXDeIkdtL2o=@vger.kernel.org
X-Gm-Message-State: AFuF++lw9Jiq5WW5+Wm3mPf2kg92RyysmgxpC6j0CKC/T+IIH3OrYVwM
	KeK7b9VI5DU/wnu1ehcler2Xvk6je/KM2tGZdDRQImy7+vmDVIHCWPR8
X-Gm-Gg: AYBFou27GgNXIkbKO6e5rQKxW6MQFvCCmOGH1gcDftGaPEV8LLLdE0ajLUcBQ603Bvh
	zrReSHpez0Jvdfi1bScRVAg4Gn4w+FX+8s2259pxo4EsaPtifpb+7YfhxV98t7DWakQZu78uXzb
	Mj6N7x37+SHK9F8rKt01ooYIlPiHuE3r9TnGRlkBH5DyXWZCFyV6aYauwC4IQZtryFrKMaYZumL
	V0HyaXLmoqf9DwhLwQ4ohQwY4y/H+li7LeGUW+4yxiHQ+PmGspAUJXLUO52EkVRCdEPrNUpytc5
	uxb/xG8/Jg7fldNko5w8PXBCSc7LJoD6WPL/dqvAR377zl1Pzh2zcQDos12whoFTxG/eDzzmzhK
	vS7M9x9QCvESQzjGayyZtQfZcPbYHiC5IfZu6051rzeKBKzHRvFwECWa7E5w0g7Hb2xxWQhcHnv
	kio7L7kMAzuA0bu10N7Jpdwr+4cWu6NARIP/bcydtTnRluULrQH05P/bXnGS8W7R5fXiUFAteaG
	d4ZfTDnM0sCCvJYT0kLHgdk5xEnMhxkhLB9MXikqQ==
X-Received: by 2002:a05:701b:42d3:10b0:143:5c2a:e488 with SMTP id a92af1059eb24-144f8fc7b95mr2889651c88.0.1790169652322;
        Wed, 23 Sep 2026 06:20:52 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:20:50 -0700 (PDT)
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
Subject: [PATCH v3 023/114] hw/loongarch/virt: prefix ACPI helper with loongarch_virt_
Date: Wed, 23 Sep 2026 21:14:57 +0800
Message-ID: <20260923131635.1894-24-luoyonggang@gmail.com>
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

- virt_acpi_setup is the same C symbol used by ARM and RISC-V virt.
  Rename it now so a later combined binary does not need meson -D
  prefixes for LoongArch.
- Rename the file-local virt_is_acpi_enabled to
  loongarch_virt_is_acpi_enabled to match.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt-acpi-build.c | 6 +++---
 hw/loongarch/virt.c            | 2 +-
 include/hw/loongarch/virt.h    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 600ef60fc58..b9df9b3a127 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -674,7 +674,7 @@ static const VMStateDescription vmstate_acpi_build = {
     },
 };
 
-static bool virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
+static bool loongarch_virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
 {
     if (lvms->acpi == ON_OFF_AUTO_OFF) {
         return false;
@@ -682,7 +682,7 @@ static bool virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
     return true;
 }
 
-void virt_acpi_setup(LoongArchVirtMachineState *lvms)
+void loongarch_virt_acpi_setup(LoongArchVirtMachineState *lvms)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
@@ -692,7 +692,7 @@ void virt_acpi_setup(LoongArchVirtMachineState *lvms)
         return;
     }
 
-    if (!virt_is_acpi_enabled(lvms)) {
+    if (!loongarch_virt_is_acpi_enabled(lvms)) {
         ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
         return;
     }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2b003443eb0..18923500fc2 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -242,7 +242,7 @@ static void virt_done(Notifier *notifier, void *data)
     LoongArchVirtMachineState *lvms = container_of(notifier,
                                       LoongArchVirtMachineState, machine_done);
     virt_build_smbios(lvms);
-    virt_acpi_setup(lvms);
+    loongarch_virt_acpi_setup(lvms);
     virt_fdt_setup(lvms);
 }
 
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 09529de48bd..4316a414f44 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -132,7 +132,7 @@ struct LoongArchVirtMachineState {
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("loongarch-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
-void virt_acpi_setup(LoongArchVirtMachineState *lvms);
+void loongarch_virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
 
 static inline bool virt_has_dmsi(LoongArchVirtMachineState *lvms)
-- 
2.52.0.windows.1

