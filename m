Received: from mail-dy2-f34.google.com (mail-dy2-f34.google.com [74.125.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B933993
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169533; cv=none; b=s4bEH9dnzYztHnddGOks8fiTeUyZd3UX/FIiO8f/BvN9VSjV5kSefqUzd8RaFQLMT+aCYPPczr85goJBd/AArOa/iRU02zpeqI++BFivr1AjbTOW8247Wia2o3ZlzBqB8+UP0ix8qugR+9RIOr4Vf1ckYb4MtkPQ53nD/Gqkb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169533; c=relaxed/simple;
	bh=ZjEn6mID8Ix2rysCDNhFcjnpOGw6pZB5Es9DTWWLzSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkwQUaJf+7dSraEiOhayuOSKMBMexk0rw0alfCovlrdYAGwdkbNqI/UCLPgrPcRREsW5HJ7WC2vqpK/SIeWRkQoIg6I8pgZwB+ZcvfcD+UOUrj6F5trs0EfygHYUXSvaPVBi77hYzobgECWsk3O8C4RuCKQR27bO5bDZrFVzLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OimRJBxh; arc=none smtp.client-ip=74.125.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OimRJBxh"
Received: by mail-dy2-f34.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so1000367eec.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169523; x=1790774323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvdLUze2sQ9rH6tf9YWuWP18ipAcGMhXKG5e40lFeJk=;
        b=OimRJBxhv7q0KhbAvDgJ2PZU3JRDiOT3RrWbnWqqDyQqkX1bqtAduyh73IAioayF2h
         gCxxnRHyQED+imCN3GqmE8j6rd1fyJ+Q4qa/nPht70by/YaYHUDpsgtx0ng1hFiuxdDY
         Jx6VP79Cly33fzP1NPbf+/tzOtcKvMAcUSLXovSJYHQoShnAxOtbxRW6GFKV0a3ZcmoO
         mGEReCP/bSvd/aBMPNqC2ts7UNck0nvfXTeuaMVRLLC/iRnmky5zrMToKudo+0pznIhD
         0AJVhI2jyTK18SOnA4DDxaGRfFt+ePz3zWLvxfrUMW3LtmA/AgD3/uDvgRIsPBgQeSdQ
         HsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169523; x=1790774323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvdLUze2sQ9rH6tf9YWuWP18ipAcGMhXKG5e40lFeJk=;
        b=VNXvmmmyARvTRpSDXOsf/gyhJkCPGfDL1h5X9VaqQ/vtRwbEscpXDWYtjFP0wTyZGf
         3y7fHc7kylafH2kcDB2aZIDr6iPJ9ASitf88Caxk0LKbC1abwMiJR0eCxYuj5cPoVljd
         K13obJik2KcWM3fEgg1e4fBGvsop+j/2e5WLWBtixONvCXmi6c3EYqosplM1uEKEOoWt
         5MUBF+nMI/og61B6gDZoBjRmo8YzkoHCDHDgo209ALT2nY2RBbILriwPfV1UGtIcAjxm
         /VDxdHywB31yrl9vHltZo84UTbz8hrK67MX+074tj+UFSzeuX3dOv0jEfYJHfY8iNMVO
         y09Q==
X-Forwarded-Encrypted: i=1; AKwUvBwJF/GrRqdW9YXxCvml7tWI+v5RI+eW0fzEommzGfmkDE8RvpHqTN7Mw4m6oEtaANhdu0A=@vger.kernel.org
X-Gm-Message-State: AFuF++m8+K5i9NhDtdpuxg5tX/n9ctDoxPh7bIM+U1g3eY2fTK/qQIcl
	ayE1WbOJzV2rYSRxyp4sdL8orFLOij/M/1BFMVgBGI2r1npQJa5hs1sm
X-Gm-Gg: AYBFou37JDLGOJMludFspg+ONnqBw4+TXp/TwPyQ98CmQ65WEYDbFrSkdHVbEO9E8wx
	7f4sLjiBXN9HTJaaneOkskXCsLrBIfDEIu8CBFbA35t+mBQXxcvIwcVq24x8WmsJx5Tzi+Zscsu
	wEJeM3uIBtzau/68tV72HD/5wPa3jqWy7AAUkMRKBc4g3kkQVy+P6gPkoF9/r1jLGDGs1Avbj5G
	QabNT58iicGkY+tlfOacfjK3MMajMzlsKjm9ZorTdxjJQl19MytLyynVhv1vbYLegQoecPOEZLt
	ouAFnKd7BlG4rs2LksbRXT98iRyx1T6OSNdCH+0wDa/UnADN9zcEbRd4wJ0scFpw/f23MEeQIMX
	6L/0bJSjfp6SfYPszeuPxejNyHTt0vtx30QjKr8+0MF/Cmxwh2WDC04CTWhGv6J+r+NaR+f4aTX
	8lLRbQ4kdK+d8bgYIIx2oRG5y9kK/Vx2K8pwdwpghzXoeTc6efzCDt80vwWTnpv0kbrgE2Q9BM2
	fKB6s4bxlv3RokQHAJTS28PLg+Zlmo=
X-Received: by 2002:a05:7301:3a99:b0:30f:1e28:fb5d with SMTP id 5a478bee46e88-33e8d6d03a4mr2458825eec.20.1790169522434;
        Wed, 23 Sep 2026 06:18:42 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:18:38 -0700 (PDT)
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
Subject: [PATCH v3 011/114] kconfig: rename REGISTER to HW_REGISTER
Date: Wed, 23 Sep 2026 21:14:45 +0800
Message-ID: <20260923131635.1894-12-luoyonggang@gmail.com>
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

