Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD814ABE
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406103; cv=none; b=rO7WX5Q59ofeZTAr5wt9QRHtVrpXUpn1om9iL5XxB17QFU7tFd0Z29YVgEFp/W5goLbu6emgJS6zUl/wRwVsqRS+JtagufyFc4GQicpd3Dn7pKA21A4kPwqvR3fvopRGKU0mBl6gizXSwm0A5GVnPpMrEd2FzP3HdtghBBR4ezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406103; c=relaxed/simple;
	bh=ZjEn6mID8Ix2rysCDNhFcjnpOGw6pZB5Es9DTWWLzSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhBAw9VPPHQRSyB8CjNRYjyNP294wz35IDuKF7QarhH+GzN/dg9Kfg9ndHJsZvnlI0t6HQQTMxioIamQ3yQBFQU+ll0Pxj0ysI1iQPKrKbh321kSDZOBb9xHp3h/SWdlnyOWoREdTCNxa9HnmxIGPyLnchmJeH4ywV+AtYfBcT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3CBpS1V; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3CBpS1V"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3429bca3880so925248eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406102; x=1791010902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvdLUze2sQ9rH6tf9YWuWP18ipAcGMhXKG5e40lFeJk=;
        b=I3CBpS1VG7GJWPQlX9uKEFDCFJHAlHXdvkdXdQlgwv8vbNuTlaivHU3qrKyzlPOLEy
         CfreJnhavqdpGcJipWdp+H02vQpM10a7unkPzhZiU11it50THOgRlnlxBOyl0U/gpb1b
         nBRzYZh0Uy9OdQdw0LkO2zmrwgo+vzqDcTZuzHokQfMMvdzRiu24hDupEGReN1vlguFO
         bJc0Nqb67DGAduP4tc6xju2irzERmptWizUM8VoyUwB0RX6lblJn5eruHabWtYQ7EIzK
         3hu5I4o8CkrgZLID5PYy8j2sGt1j/BTdU/87rgtB9oL5uHXRO6vam31KflHDmdV4IPUa
         EQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406102; x=1791010902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvdLUze2sQ9rH6tf9YWuWP18ipAcGMhXKG5e40lFeJk=;
        b=zpsiYnhNF6r7UtFJymz2MjI0pqK8uiWMoOoSreOuhpKyu8hHIjiDvs8o+akihbD4Li
         4SEna3ByCpkfymryVMo7Ng4JNvn9DPIWdbZhGi8V2dvBM7FiYySsweQDGv793F1lUfsR
         APZ/RwTkyRGQpOsNx1Jl0u3UB5XuYedmBojYZ/IYkZi4KfXD5xRdR7FokZ0xSijSN8Uf
         37e/FE4Ff/PXXyarGGz0/25QABuAuZgibFHjBhyv5rT3Zo5HqwcX1WmUn2QTFf8aXmVL
         DskA0DmuivO/YvNF7us+YKNdZaXFYqj8nvnn2sclWg0jnsGD2FayzYCvHELiG+xjJEBe
         mEaA==
X-Forwarded-Encrypted: i=1; AKwUvBwHZoOY48vfkhmTssCZQpPfAUV4iI9nut0GFAUcQPO1Uf/EWKOjaDQl5gtLfmr7mAVPBrM=@vger.kernel.org
X-Gm-Message-State: AFuF++n7+zX6ni6wBPAFYekUZBicIyutRpdMPBKtyuLFIV2CZlQG1y4X
	KcJS1i7yjSznaYWViE/409fAAqCNQ3kyR0x9XRrShD4c9PPI1A9RG3gZ
X-Gm-Gg: AYBFou2XYL3NA92ZipgtmdbIGoto41gezA0XWV9BIxsLseAQ7wqnRUQ7GHymLJj0AB/
	rS0PkD2pf2A/BmB/U0GLfsArFI2EtbcRzT43/KmL629rbec+C7lVbyK2RYkSJMfqfViDLHpqEGy
	HKdJLsNnZAwTpwKcZycacm67mxPKiJNCj+MAakC40tekHaQ6YW1+ijNdDpN4PNgNdURspyE979/
	xbN6ODYJC/P1vfoC+1+0lCe1I6BtAcNBVeRk5lFMajxLF4qVCVLe9Dal49D2xDH343sGOUGRkq/
	4f+A8PW4DK7MbnJSHNhO+Jt8SvjGMItgD6ftcmrShqHWNIcPWPYgBXJ7+p2KjG9uHJicPm8XOSN
	Xb3jDiWTa7OlGnjGy1G3hrMG18uECZ1pGCKSfEb2Mbjhn+fVHSctF61m/ugRppw6S9M5CBegu3U
	KFCOnt2EO23Im+u/Blm+ulyWpjm8Rf+tpdeCPcWwgBwCqU3inAepuRMTTOxbaUYe5eT5EPsy/L6
	0t8q2Edxz7hLBx58QP3PA7wcTVWSEI=
X-Received: by 2002:a05:7301:1506:b0:33b:e529:4446 with SMTP id 5a478bee46e88-3426febb75bmr2199672eec.5.1790406101084;
        Sat, 26 Sep 2026 00:01:41 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 09/55] kconfig: rename REGISTER to HW_REGISTER
Date: Sat, 26 Sep 2026 15:00:08 +0800
Message-ID: <20260926070057.1234-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename config REGISTER to HW_REGISTER. register is a C keyword, and a
later TargetKconfig commit will use it as a struct member.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/Kconfig          | 2 +-
 hw/core/Kconfig     | 2 +-
 hw/core/meson.build | 2 +-
 hw/dma/Kconfig      | 4 ++--
 hw/i2c/Kconfig      | 2 +-
 hw/usb/Kconfig      | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/Kconfig b/hw/Kconfig
index c92ca2b13a3..94f963f2944 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -85,7 +85,7 @@ config XILINX_AXI
 
 config XLNX_ZYNQMP
     bool
-    select REGISTER
+    select HW_REGISTER
     select CAN_BUS
     select PTIMER
     select XLNX_BBRAM
diff --git a/hw/core/Kconfig b/hw/core/Kconfig
index d1bdf765ee8..839e249b9d0 100644
--- a/hw/core/Kconfig
+++ b/hw/core/Kconfig
@@ -29,7 +29,7 @@ config PLATFORM_BUS
     bool
     depends on DEVICE_TREE
 
-config REGISTER
+config HW_REGISTER
     bool
 
 config SPLIT_IRQ
diff --git a/hw/core/meson.build b/hw/core/meson.build
index 8fe776d2c86..1c645d7041d 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -21,7 +21,7 @@ system_ss.add(when: 'CONFIG_GUEST_LOADER', if_true: files('guest-loader.c'))
 system_ss.add(when: 'CONFIG_OR_IRQ', if_true: files('or-irq.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('platform-bus.c'))
 system_ss.add(when: 'CONFIG_PTIMER', if_true: files('ptimer.c'))
-system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
+system_ss.add(when: 'CONFIG_HW_REGISTER', if_true: files('register.c'))
 system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
index 0a23e7d7b87..8f221b20634 100644
--- a/hw/dma/Kconfig
+++ b/hw/dma/Kconfig
@@ -16,7 +16,7 @@ config I8257
 
 config ZYNQ_DEVCFG
     bool
-    select REGISTER
+    select HW_REGISTER
 
 config XLNX_ZDMA
     bool
@@ -29,7 +29,7 @@ config SIFIVE_PDMA
 
 config XLNX_CSU_DMA
     bool
-    select REGISTER
+    select HW_REGISTER
 
 config K230_GSDMA
     bool
\ No newline at end of file
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 0766130b596..3482f475cf9 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -20,7 +20,7 @@ config ARM_SBCON_I2C
 
 config DESIGNWARE_I2C
     bool
-    select REGISTER
+    select HW_REGISTER
     select I2C
 
 config ACPI_SMBUS
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index e8c00f813a6..43771291a06 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -137,7 +137,7 @@ config IMX_USBPHY
 config USB_DWC3
     bool
     select USB_XHCI_SYSBUS
-    select REGISTER
+    select HW_REGISTER
 
 config XLNX_USB_SUBSYS
     bool
-- 
2.52.0.windows.1

