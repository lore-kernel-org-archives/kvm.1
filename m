Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8852F291
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169663; cv=none; b=XZDSQWoiwIZC4To4RjhAJgnLVpEJ9HGuZT8yA6DMmoUyrPP7d6VLZdFDUCXq2+i8rRFIrb+xCo6AOCmG1Cu9dQALyIsRBJlFpcUGIa74Sf4hO/ZNYxYKV3ZHnNy7dCbP6f7Cx2pFy+HUEFLL2qTCRw0OUC3j2nU0OYhyYTeQ4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169663; c=relaxed/simple;
	bh=8VjaXvUSTXxMFUIGwEyPQRdGs4WGwLXlSsPhqzCrtn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdqssYQil6C1aAgQIII50lNdHuz8iceg4z7jCaDrN2KgXsXBGWOgbkoHRGAWKb6uWl1l09FFBjpzFD3iA9rmTcvHNlfLjrZVLv3i7XkAb39RVTgbQOt9MKcK5lZcQwipWCzcqNGtgTvw0QylhPSysbs9EqDNIzfx9l63EdJxGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keIkNqYZ; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keIkNqYZ"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e6b4e33e4so782186eec.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169642; x=1790774442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F3AfQfrqvQe4UOX8IvAjiJQ3WGlTiTKTbcrqm5A18SE=;
        b=keIkNqYZXwBlyN971Cf+7XzzC4oCIAQTHOf8VTAvKS/MeZQmWdiXDi7gx6Ek5ljRZD
         QRkmE0dPS8Dbc1xoMVX3Den92JrsJHDgAMvBRo42mE9TS6epbqQzjTpJgMPxKBwjRHOE
         nbkUwSZr9mgzuJ04U8NlXNoolUiWIDt/7v7oP43mm+JtXI/VtJMzKV+nC0uwsgSni4cU
         6Ar3R8axCxynjFZYyirFtRPxYl1xUGU9OfBoZk9aMALPX22DfuOW4ExeWj/lLjJOwQws
         NDyOH3KmE7RXUuuuF17YRHnFrmn5ovA+1dLaMHOF78f0iVQIse6T77X2sU532uMI4J0L
         +BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169642; x=1790774442;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F3AfQfrqvQe4UOX8IvAjiJQ3WGlTiTKTbcrqm5A18SE=;
        b=BWk+je+n47QgOyXSHdC5HHgaFDX4gIORSpburZmt5jnX8q/KYKFneS1aNdO/GoAV3K
         TCtXBO2n/DBYSKUk6xJL5ILHOJFTNwou6n9r1/IlSZCEMTGgJvTTC8tqQiEX3EmFZ1Jp
         9EgmwhNbVIkLBkYaGq9N5p836sU2cPuAp8PddQv717EtAF8CnA3mYsArYnkjvTBZfxo6
         kFAoo9sgkIyvQ1zA+f5FxwJl3LGXHWQCqaLVwbmo0FSCgyS8vxEcT05qgq8d2eq7Nr0F
         Nvqm6VNZA9G9Ttu+aiHYpxltYPWx/r5W2cCtdz60YC7VROWXHdmFf5o1IzCcVb4CHY2x
         Y/pA==
X-Forwarded-Encrypted: i=1; AKwUvBxp0SisswmWf58LmgSnSdc8jOixkhjAgbEGUkOgHofUNv/s6Ieox+1NydME/40AWfXtEco=@vger.kernel.org
X-Gm-Message-State: AFuF++nH9L9x84MJwdEKR1XnJLUzUXphUo5le9yeAbqISVK6vwYc7Onz
	Wj4nMhc4N6WOpBOv7Ypt0OXDUnkZo3us3zLjwmWhucKZEWsHcUid9o/l
X-Gm-Gg: AYBFou1uVhjcKzfEGrfg7szU6MhPhKpTKGKoGkykvQknMea1seAu2jTcAm6kPUpeW1i
	VJld4e9kHI+aUY1rSyRDOhpnETZIJERpWa3qukZfR7NnkrtDiTsqewikkb/aLCTITgIB5vPtrGj
	ydMgxP5fAf4PJRkr2jwm6xzQG5TBbYv4INIc+HPauY3ZeJ/Oi9oAZgg7FAdNhGlVcxZaKZivTkN
	sXagwgD6ReOnuqDuEog9gyetwp9cWhCHgNBMs93wwTTYzxcNdIxtcfYnMzrKWdIA5TyxOppIEO9
	kLHPumYAgYxeXYCYLa4xzHJ1Xi120OxPEbZgEoX6ZsbhoxwBWEZj/pkqrkKJ5pjYrDDnFEYdNCo
	PMygxFKzylfPqXelBBzOfL79bkTCUMkHmUiduhrD9WCDyxx1EpXRTAMxDATlf5CuFX99ks92KQF
	tYeaogZU6vW0VJmKECBKmIry+mztGWBGXVV+to2W44wLssfP2NBAQ3Qxxx2HknVY/CFyDKw8oLY
	k+Z5olU1Mmef9HHNRTvv/L6UPPwO0gWj+BbSkRTrQ==
X-Received: by 2002:a05:693c:638c:20b0:339:7da3:a4f8 with SMTP id 5a478bee46e88-33e8d6d1242mr2659932eec.19.1790169641572;
        Wed, 23 Sep 2026 06:20:41 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:20:39 -0700 (PDT)
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
Subject: [PATCH v3 022/114] hw/riscv/virt: prefix ACPI helpers with riscv_virt_
Date: Wed, 23 Sep 2026 21:14:56 +0800
Message-ID: <20260923131635.1894-23-luoyonggang@gmail.com>
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

- virt_acpi_setup and virt_is_acpi_enabled collide with ARM virt when
  both architectures are linked into one qemu-system binary.
- Rename the RISC-V helpers to riscv_virt_acpi_setup and
  riscv_virt_is_acpi_enabled. Leave file-local virt_acpi_build* names
  unchanged.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 hw/riscv/virt.c            | 6 +++---
 include/hw/riscv/virt.h    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 8e516ec1148..de47631852f 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -1021,7 +1021,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     },
 };
 
-void virt_acpi_setup(RISCVVirtState *s)
+void riscv_virt_acpi_setup(RISCVVirtState *s)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 686222fa0da..0edf75fefc3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -706,8 +706,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
     virt_build_smbios(s);
 
-    if (virt_is_acpi_enabled(s)) {
-        virt_acpi_setup(s);
+    if (riscv_virt_is_acpi_enabled(s)) {
+        riscv_virt_acpi_setup(s);
     }
 }
 
@@ -1067,7 +1067,7 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
 }
 
-bool virt_is_acpi_enabled(RISCVVirtState *s)
+bool riscv_virt_is_acpi_enabled(RISCVVirtState *s)
 {
     return s->acpi != ON_OFF_AUTO_OFF;
 }
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 969aa5866ee..1cdc5840b7a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,9 +121,9 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
-bool virt_is_acpi_enabled(RISCVVirtState *s);
+bool riscv_virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
-void virt_acpi_setup(RISCVVirtState *vms);
+void riscv_virt_acpi_setup(RISCVVirtState *vms);
 
 /*
  * The virt machine physical address space used by some of the devices
-- 
2.52.0.windows.1

