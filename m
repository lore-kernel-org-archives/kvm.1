Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524145;
	b=DxzMMziyhCPLsp9ggRYUCSRlw3zPMapxrBQ1Twl/nyYL97ZrQIXJelemelwUrhfMWvh8
	 Laarw1e0GHmBZ3EZ6a4DCSaDsP+qH5WTHvZx5m/wJvnHmuiImM2qeaq+AZTl96S5F4aEW
	 8ql6dd4cIPWGaE/T1i4xlM8SEO+YzkbpkpNXbzrO2V7xL6AiOU3HMcilrCYJyKwZgyYnT
	 gqQv4QsR0HJIWGKP7ti/LHJcxFqimFToXyiRSAfqCi3oVVX0San8TGS/sQzrzIEQ4WsWe
	 6DHF1z4wSWkbS782Oup9C6C5kuke/pYew/LM9tzJzBVtZetK6eDVsXFXpKvVCUXmDXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524145;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wr7RkffnYvOl3FhNLiB/TEwApGzEcSL4fP61HijSYoE=;
	b=faakCXV0mvtgIZW6xasNK9KIEq9ULP6CjGmrbNNQLnztGFoF6bmckr+fpXHq/KGCeenN
	 cLI6pZ88ErSfxLzDMb6VU/E1mIH3TS8EgNwcQK8nDnqCdl/VeeGuhNL4F5sjeGYdrux2n
	 yuqV4QQlT8NGWFkqbh3QZSCQLTox2ruzLWA3RENmpAx3pyGmdzPBBEiwJUZcwS8n6CMkL
	 5Yclzy22Tyd8i/z2lGsBmJu+OYNjeFhBjSZdTgYab+DAV8ruNE7qR5FNiP+oFMdzfPn3F
	 Pnc+E82+1f7jxTfQEdsovdAuBTUTxl0GgZo5DnDcnSbN9wtnLl5f8hN2pJM4rbEds4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=vTcb4DeJ;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58B606A322;
	Tue, 24 Nov 2026 12:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB58B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=vTcb4DeJ
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D7B861FB20;
	Tue, 24 Nov 2026 13:42:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1795524136;
	bh=wr7RkffnYvOl3FhNLiB/TEwApGzEcSL4fP61HijSYoE=; h=From:To:Subject;
	b=vTcb4DeJttwb6sp4bEBQAEbPu/MiFi5AHxbBpKY3L6mdbNBqNO0mew4K2YU6hCdw0
	 2/x3MchUb+iUG7J/0eFO42Kw5RSrU5oAtB+3RPpCtlicbMRUOz3EepOBQANwKxX8mx
	 UniYikXtukgDhmg6oeiZ9eAsPZjtFFDST3KbSrGc8Tv4AwKDmxhyvPUeVnRDgRQCoL
	 yjiiy9YNGRaqy+rYg8ubzQYMpdv8cVttHHVjOE2ODLKcVx0G9izqNirZ/+RdF8Nqh8
	 gZlDBz3OvVX6y2HGdm/WydtMoDeNwkm0JJNgLR5k50yk2rgQJzd7LoBrngpdmZl+vK
	 NJe8logeqaTtw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: ti: k3-am69-aquila: Add tdx vendor prefix to display overlays
Date: Tue, 24 Nov 2026 13:42:05 +0100
Message-ID: <20261124124207.199382-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124124207.199382-1-francesco@dolcini.it>
References: <20261124124207.199382-1-francesco@dolcini.it>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The Toradex display overlays are named after the accessory product name,
which on its own reads as a generic panel description. Prefix them with
the vendor, "tdx", as already done for third-party accessories (e.g.
"rpi-display-2-7in") and for the Toradex overlays in the NXP i.MX
directories, to have a consistent naming across all Toradex DT files.

The 10.1" LVDS display exists in a V1 and a V2 version, encode it as a
"-v1"/"-v2" suffix. The combined DTBs are renamed accordingly.

Link: https://lore.kernel.org/all/20261026111149.GA46946@francesco-nb/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/Makefile               | 48 +++++++++----------
 ...apter-tdx-panel-cap-touch-10inch-dsi.dtso} |  0
 ...dapter-tdx-panel-cap-touch-7inch-dsi.dtso} |  0
 ...o-lvds-tdx-panel-cap-touch-10inch-v1.dtso} |  0
 ...o-lvds-tdx-panel-cap-touch-10inch-v2.dtso} |  0
 ...quila-tdx-panel-cap-touch-10inch-dsi.dtso} |  0
 ...aquila-tdx-panel-cap-touch-7inch-dsi.dtso} |  0
 7 files changed, 24 insertions(+), 24 deletions(-)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-adapter-panel-cap-touch-10inch-dsi.dtso => k3-am69-aquila-adapter-tdx-panel-cap-touch-10inch-dsi.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-adapter-panel-cap-touch-7inch-dsi.dtso => k3-am69-aquila-adapter-tdx-panel-cap-touch-7inch-dsi.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-dsi-to-lvds-panel-cap-touch-10inch.dtso => k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-dsi-to-lvds-v2-panel-cap-touch-10inch.dtso => k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-panel-cap-touch-10inch-dsi.dtso => k3-am69-aquila-tdx-panel-cap-touch-10inch-dsi.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-panel-cap-touch-7inch-dsi.dtso => k3-am69-aquila-tdx-panel-cap-touch-7inch-dsi.dtso} (100%)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 4c31fceb6497..7061e28719f1 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -212,14 +212,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
 
 # Boards with J784s4 SoC
-k3-am69-aquila-clover-panel-cap-touch-10inch-dsi-dtbs := \
+k3-am69-aquila-clover-tdx-panel-cap-touch-10inch-dsi-dtbs := \
 	k3-am69-aquila-clover.dtb \
-	k3-am69-aquila-panel-cap-touch-10inch-dsi.dtbo
+	k3-am69-aquila-tdx-panel-cap-touch-10inch-dsi.dtbo
 k3-am69-aquila-dev-dsi-to-hdmi-dtbs := k3-am69-aquila-dev.dtb \
 	k3-am69-aquila-dsi-to-hdmi.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-adapter-panel-cap-touch-10inch-dsi.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-adapter-panel-cap-touch-7inch-dsi.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-clover-panel-cap-touch-10inch-dsi.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-adapter-tdx-panel-cap-touch-10inch-dsi.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-adapter-tdx-panel-cap-touch-7inch-dsi.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-clover-tdx-panel-cap-touch-10inch-dsi.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-clover.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-csi1-ov5640-24mhz.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-csi1-ov5640.dtbo
@@ -228,10 +228,10 @@ dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-csi2-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dev-dsi-to-hdmi.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dsi-to-hdmi.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dsi-to-lvds-panel-cap-touch-10inch.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dsi-to-lvds-v2-panel-cap-touch-10inch.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-panel-cap-touch-10inch-dsi.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-panel-cap-touch-7inch-dsi.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-tdx-panel-cap-touch-10inch-dsi.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-tdx-panel-cap-touch-7inch-dsi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
@@ -374,15 +374,15 @@ k3-am68-sk-base-board-csi2-dual-imx219-dtbs := k3-am68-sk-base-board.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-am68-sk-base-board-pcie1-ep-dtbs := k3-am68-sk-base-board.dtb \
 	k3-am68-sk-base-board-pcie1-ep.dtbo
-k3-am69-aquila-clover-panel-cap-touch-7inch-dsi-dtbs := \
+k3-am69-aquila-clover-tdx-panel-cap-touch-7inch-dsi-dtbs := \
 	k3-am69-aquila-clover.dtb \
-	k3-am69-aquila-panel-cap-touch-7inch-dsi.dtbo
-k3-am69-aquila-dev-adapter-panel-cap-touch-10inch-dsi-dtbs := \
+	k3-am69-aquila-tdx-panel-cap-touch-7inch-dsi.dtbo
+k3-am69-aquila-dev-adapter-tdx-panel-cap-touch-10inch-dsi-dtbs := \
 	k3-am69-aquila-dev.dtb \
-	k3-am69-aquila-adapter-panel-cap-touch-10inch-dsi.dtbo
-k3-am69-aquila-dev-adapter-panel-cap-touch-7inch-dsi-dtbs := \
+	k3-am69-aquila-adapter-tdx-panel-cap-touch-10inch-dsi.dtbo
+k3-am69-aquila-dev-adapter-tdx-panel-cap-touch-7inch-dsi-dtbs := \
 	k3-am69-aquila-dev.dtb \
-	k3-am69-aquila-adapter-panel-cap-touch-7inch-dsi.dtbo
+	k3-am69-aquila-adapter-tdx-panel-cap-touch-7inch-dsi.dtbo
 k3-am69-aquila-dev-csi-ov5640-24mhz-dtbs := \
 	k3-am69-aquila-dev.dtb \
 	k3-am69-aquila-csi1-ov5640-24mhz.dtbo \
@@ -391,12 +391,12 @@ k3-am69-aquila-dev-csi-ov5640-dtbs := \
 	k3-am69-aquila-dev.dtb \
 	k3-am69-aquila-csi1-ov5640.dtbo \
 	k3-am69-aquila-csi2-ov5640.dtbo
-k3-am69-aquila-dev-dsi-to-lvds-panel-cap-touch-10inch-dtbs := \
+k3-am69-aquila-dev-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1-dtbs := \
 	k3-am69-aquila-dev.dtb \
-	k3-am69-aquila-dsi-to-lvds-panel-cap-touch-10inch.dtbo
-k3-am69-aquila-dev-dsi-to-lvds-v2-panel-cap-touch-10inch-dtbs := \
+	k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtbo
+k3-am69-aquila-dev-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2-dtbs := \
 	k3-am69-aquila-dev.dtb \
-	k3-am69-aquila-dsi-to-lvds-v2-panel-cap-touch-10inch.dtbo
+	k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtbo
 k3-am69-sk-csi2-dual-imx219-dtbs := k3-am69-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-am69-sk-pcie0-ep-dtbs := k3-am69-sk.dtb \
@@ -495,13 +495,13 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am68-phyboard-izar-pwm-fan.dtb \
 	k3-am68-sk-base-board-csi2-dual-imx219.dtb \
 	k3-am68-sk-base-board-pcie1-ep.dtb \
-	k3-am69-aquila-clover-panel-cap-touch-7inch-dsi.dtb \
-	k3-am69-aquila-dev-adapter-panel-cap-touch-10inch-dsi.dtb \
-	k3-am69-aquila-dev-adapter-panel-cap-touch-7inch-dsi.dtb \
+	k3-am69-aquila-clover-tdx-panel-cap-touch-7inch-dsi.dtb \
+	k3-am69-aquila-dev-adapter-tdx-panel-cap-touch-10inch-dsi.dtb \
+	k3-am69-aquila-dev-adapter-tdx-panel-cap-touch-7inch-dsi.dtb \
 	k3-am69-aquila-dev-csi-ov5640-24mhz.dtb \
 	k3-am69-aquila-dev-csi-ov5640.dtb \
-	k3-am69-aquila-dev-dsi-to-lvds-panel-cap-touch-10inch.dtb \
-	k3-am69-aquila-dev-dsi-to-lvds-v2-panel-cap-touch-10inch.dtb \
+	k3-am69-aquila-dev-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtb \
+	k3-am69-aquila-dev-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtb \
 	k3-am69-sk-csi2-dual-imx219.dtb \
 	k3-am69-sk-pcie0-ep.dtb \
 	k3-j7200-evm-pcie1-ep.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-adapter-panel-cap-touch-10inch-dsi.dtso b/arch/arm64/boot/dts/ti/k3-am69-aquila-adapter-tdx-panel-cap-touch-10inch-dsi.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am69-aquila-adapter-panel-cap-touch-10inch-dsi.dtso
rename to arch/arm64/boot/dts/ti/k3-am69-aquila-adapter-tdx-panel-cap-touch-10inch-dsi.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-adapter-panel-cap-touch-7inch-dsi.dtso b/arch/arm64/boot/dts/ti/k3-am69-aquila-adapter-tdx-panel-cap-touch-7inch-dsi.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am69-aquila-adapter-panel-cap-touch-7inch-dsi.dtso
rename to arch/arm64/boot/dts/ti/k3-am69-aquila-adapter-tdx-panel-cap-touch-7inch-dsi.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-dsi-to-lvds-panel-cap-touch-10inch.dtso b/arch/arm64/boot/dts/ti/k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am69-aquila-dsi-to-lvds-panel-cap-touch-10inch.dtso
rename to arch/arm64/boot/dts/ti/k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-dsi-to-lvds-v2-panel-cap-touch-10inch.dtso b/arch/arm64/boot/dts/ti/k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am69-aquila-dsi-to-lvds-v2-panel-cap-touch-10inch.dtso
rename to arch/arm64/boot/dts/ti/k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-panel-cap-touch-10inch-dsi.dtso b/arch/arm64/boot/dts/ti/k3-am69-aquila-tdx-panel-cap-touch-10inch-dsi.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am69-aquila-panel-cap-touch-10inch-dsi.dtso
rename to arch/arm64/boot/dts/ti/k3-am69-aquila-tdx-panel-cap-touch-10inch-dsi.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-panel-cap-touch-7inch-dsi.dtso b/arch/arm64/boot/dts/ti/k3-am69-aquila-tdx-panel-cap-touch-7inch-dsi.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am69-aquila-panel-cap-touch-7inch-dsi.dtso
rename to arch/arm64/boot/dts/ti/k3-am69-aquila-tdx-panel-cap-touch-7inch-dsi.dtso
-- 
2.47.3

