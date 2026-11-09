Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239892;
	b=h2b2EhrNwuyg6vzSOedzGbexNfWU/pOd9Zi2KjLgRN9qg2bdS/M0LDYNlGp1N7OVYkFd
	 cH5RJ6ByxIY/afc+cvpLuHq3szhVgjgShfcDyVHd8CEdBeBubccFxh/KnULAmkIDVDrjw
	 nGFwzzNWTeq9GIWttr0+hcqV8uPnWl4JHNBfS54jlLLuuyifVRzRiIifiOMjL9AAevCrp
	 sIWpiULd1YPlTrBbCht08zhE15o8OIHzH3rqhntwgEyaf24bqIc8D2wgighpPqdB3VbfV
	 McC2Znq8Lbc62us4kPiSKzra9ff2g6Xstjv4Aw0jGszux/Q2sGaaxlNH+OBTtup+B2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239892;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W5tIw3pY4xf2AiHrKTA7p2regxxRaERCXmVIzX7a4PI=;
	b=mmvM6Fi3JXqPjnEIs5Pq0Byuqh0qfWGb0aW5BdZDX4YaxE9BwUxHNLdcY+r89+xbrODp
	 QKCtkrCL0+xWJdfjv7EHHffTqhL/HauqdltawQtFAhyY6McY8ZC7qV+bTENZ94WxOLe24
	 ZpnXuxz+8IeDFaX/bEXtZgnKUT4oO4AfkEmDNuRh2afQwBTRRiN3J1XoChwH9iCHQc5Hj
	 KRzUtMrN4WfzdBbRfR+8c/qdokguZwA71ntWs8TBxTYg88z9CfeNyEIy4nr4vX2SytTjH
	 LVqS3LK+bbQ6l8aSJ4wOS7NoFvSSJcG8JpnSscCVj+LYU4pwcEVGsqX0FsXhx0nntUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=Dvn5a4p5;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A331606EEB7;
	Mon,  9 Nov 2026 15:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A331606EEB7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=Dvn5a4p5
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id E03FB26675;
	Mon,  9 Nov 2026 16:58:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1794239885;
	bh=W5tIw3pY4xf2AiHrKTA7p2regxxRaERCXmVIzX7a4PI=; h=From:To:Subject;
	b=Dvn5a4p5G0Y5gz+4Je1sH6cDzjkNTkRwnbfNVu23JxKEwye1IMiJ7P6WgkmBopzo8
	 9Gexv7W3+IiR70KCx/RMw3klqDNTm95LTPb2sYxZhAlol2oJn/dQ81SYyEE2CJpazl
	 LxC80jDEt9MPQqupAk3dabe+zFYcZimtfudFnlyvgu84SrYNQGMeSjUH6AqNjrikCN
	 zreeJhFG/Cz7Fxg77HQzlrOfIZbqI/VBlp/lcHCUUdi5JKu0shLSXHKor3I73mOcUb
	 B9+lXgmdUy9WFRAlXHRGgfnzABthC7ZK2bxl43Kt1y3+xPaUletcY9OvZRhIjeaxEk
	 SNY13ipwgM/HQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-bsp@toradex.com,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v2 8/8] ARM: dts: imx6ull-colibri-emmc: Add VGA overlay
Date: Mon,  9 Nov 2026 16:57:48 +0100
Message-ID: <20261109155751.475875-9-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109155751.475875-1-francesco@dolcini.it>
References: <20261109155751.475875-1-francesco@dolcini.it>
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

Add a device tree overlay for the VGA output on the Colibri iMX6ULL eMMC
parallel RGB LCD interface. The VGA output is driven through a
non-programmable video DAC without VESA DDC I2C signals to a DVI
connector. The DAC power-save input is driven by the BL_ON signal on
SODIMM 71, like on the Colibri iMX7.

The overlay content is identical to the Colibri iMX7 eMMC one, only the
GPIO driving the DAC power-save input is SoC specific. To avoid
duplicating it, rework the Colibri iMX7 eMMC overlay moving the common
part to a new dtsi shared between the two modules, and include it from
both overlays.

The overlay is also combined with the Aster, Evaluation Board v3, Iris
and Iris v2 carrier board device trees to provide ready-to-use DTBs.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 arch/arm/boot/dts/nxp/imx/Makefile            | 21 +++++++
 .../dts/nxp/imx/imx6ull-colibri-emmc-vga.dtso | 24 ++++++++
 .../dts/nxp/imx/imx6ull-imx7-colibri-vga.dtsi | 61 +++++++++++++++++++
 .../dts/nxp/imx/imx7d-colibri-emmc-vga.dtso   | 52 ++--------------
 4 files changed, 112 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-vga.dtso
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-vga.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index 060bb01f9396..4fc8fa5e8c79 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -373,6 +373,22 @@ imx6ull-colibri-emmc-eval-v3-tdx-panel-res-touch-7inch-parallel-dtbs := \
 	imx6ull-colibri-emmc-eval-v3.dtb \
 	imx6ull-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtbo
 
+imx6ull-colibri-emmc-aster-vga-dtbs := \
+	imx6ull-colibri-emmc-aster.dtb \
+	imx6ull-colibri-emmc-vga.dtbo
+
+imx6ull-colibri-emmc-eval-v3-vga-dtbs := \
+	imx6ull-colibri-emmc-eval-v3.dtb \
+	imx6ull-colibri-emmc-vga.dtbo
+
+imx6ull-colibri-emmc-iris-vga-dtbs := \
+	imx6ull-colibri-emmc-iris.dtb \
+	imx6ull-colibri-emmc-vga.dtbo
+
+imx6ull-colibri-emmc-iris-v2-vga-dtbs := \
+	imx6ull-colibri-emmc-iris-v2.dtb \
+	imx6ull-colibri-emmc-vga.dtbo
+
 dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-14x14-evk.dtb \
 	imx6ul-ccimx6ulsbcexpress.dtb \
@@ -402,15 +418,20 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-colibri-aster.dtb \
 	imx6ull-colibri-emmc-aster.dtb \
 	imx6ull-colibri-emmc-aster-tdx-panel-cap-touch-7inch-parallel.dtb \
+	imx6ull-colibri-emmc-aster-vga.dtb \
 	imx6ull-colibri-emmc-eval-v3.dtb \
 	imx6ull-colibri-emmc-eval-v3-tdx-panel-cap-touch-7inch-parallel-touch-adapter.dtb \
 	imx6ull-colibri-emmc-eval-v3-tdx-panel-res-touch-7inch-parallel.dtb \
+	imx6ull-colibri-emmc-eval-v3-vga.dtb \
 	imx6ull-colibri-emmc-iris.dtb \
+	imx6ull-colibri-emmc-iris-vga.dtb \
 	imx6ull-colibri-emmc-iris-v2.dtb \
 	imx6ull-colibri-emmc-iris-v2-tdx-panel-cap-touch-7inch-parallel.dtb \
+	imx6ull-colibri-emmc-iris-v2-vga.dtb \
 	imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtbo \
 	imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel-touch-adapter.dtbo \
 	imx6ull-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtbo \
+	imx6ull-colibri-emmc-vga.dtbo \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-iris.dtb \
 	imx6ull-colibri-iris-v2.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-vga.dtso b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-vga.dtso
new file mode 100644
index 000000000000..4ecf221de27e
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-vga.dtso
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * VGA output connected to the Colibri parallel RGB LCD interface through a
+ * non-programmable video DAC with a DVI connector.
+ *
+ * The VGA output is available on multiple carrier boards (including Iris,
+ * Eval, Aster) without VESA DDC I2C signals.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "imx6ull-imx7-colibri-vga.dtsi"
+
+&vga_encoder {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_bl_on>;
+	/* SODIMM 71 / BL_ON */
+	enable-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-vga.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-vga.dtsi
new file mode 100644
index 000000000000..7e323698f338
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-vga.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * VGA output connected to the Colibri parallel RGB LCD interface through a
+ * non-programmable video DAC with a DVI connector, shared by the Colibri
+ * iMX6ULL eMMC and Colibri iMX7 eMMC overlays.
+ *
+ * The VGA output is available on multiple carrier boards (including Iris,
+ * Eval, Aster) without VESA DDC I2C signals.
+ *
+ * The DAC power-save input is driven by the BL_ON signal on SODIMM 71, the
+ * SoC specific pinctrl and GPIO are described by the overlay including this
+ * file.
+ */
+
+&{/} {
+	vga_encoder: vga-encoder {
+		compatible = "dumb-vga-dac";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				vga_enc_in: endpoint {
+					remote-endpoint = <&lcdif_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				vga_enc_out: endpoint {
+					remote-endpoint = <&dvi_connector_in>;
+				};
+			};
+		};
+	};
+
+	dvi-connector {
+		compatible = "dvi-connector";
+		analog;
+
+		port {
+			dvi_connector_in: endpoint {
+				remote-endpoint = <&vga_enc_out>;
+			};
+		};
+	};
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&lcdif_out {
+	remote-endpoint = <&vga_enc_in>;
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-vga.dtso b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-vga.dtso
index 363c0c2cc43e..ae3d8da02e67 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-vga.dtso
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-vga.dtso
@@ -14,51 +14,11 @@
 
 #include <dt-bindings/gpio/gpio.h>
 
-&{/} {
-	vga-encoder {
-		compatible = "dumb-vga-dac";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+#include "imx6ull-imx7-colibri-vga.dtsi"
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				vga_enc_in: endpoint {
-					remote-endpoint = <&lcdif_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				vga_enc_out: endpoint {
-					remote-endpoint = <&dvi_connector_in>;
-				};
-			};
-		};
-	};
-
-	dvi-connector {
-		compatible = "dvi-connector";
-		analog;
-
-		port {
-			dvi_connector_in: endpoint {
-				remote-endpoint = <&vga_enc_out>;
-			};
-		};
-	};
-};
-
-&lcdif {
-	status = "okay";
-};
-
-&lcdif_out {
-	remote-endpoint = <&vga_enc_in>;
+&vga_encoder {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_bl_on>;
+	/* SODIMM 71 / BL_ON */
+	enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 };
-- 
2.47.3

