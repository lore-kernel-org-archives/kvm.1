Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239894;
	b=Zc815vhLP1qZvz9gvcKEnP3v0jp2hxqySqs58dazYvUR5PJxe/Pgo1vthHU1K8/3QM+L
	 2l7YR7Jy4Sk8JABC4iojJKrmZzFzhA35BZ7Ny4/ah3QrZfM/wQ4vB2p8PcSB2sMO/boG8
	 59PvSAlUUpAGs9FbkbOmOpw6RNfj63iiBZHgKfTGn3KH7FL9zc9e9XUUXoY6J0DcCvk+8
	 32OvL2vFBd+h0stqlR6+abMCfO7VLmXDbGIytKLXSUClDrLjdWhs+quQgq1Atujjmbszw
	 c122ddhyTuQsHxge16g9ow+Rq46sIkhUVaulmFLBFT6/Z0wu3cf8CdUkR5cFnfb2cvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239894;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x7AGsOET450GqGMhY7lv5S1Lu7ewfrdv+H0Q8y9LtsU=;
	b=VIzj0IUR0LF/jIFmPlguK01sjh2jKv1PtFVaup9dSviiqQqFacYtGKSel+5pO+zPmkn+
	 ESRvTtNM651lXs0z1tJHXpd1wHaaS1r6YdhVBKNAamb4wcbjuEHe0oj/yg05fuT0hCcCb
	 bP6bTfH4Li4rELIY9Bj7sp2++j6QYldgQ46Rc7exBTqSmpzZ2hlC7IHKt0wAnfYWj4XXx
	 OgrSjMzJ0nCWrKn+UbRYMv6Kw2IAXnuqKDV/b+wsp28QUM4KzQyo3AVYUykvP2TKPd8zR
	 hlBqxf8M326ixB5mZ+s7G4e1jIDqKMUCGrLY4Kw2jyqxQQhnrULsIxvhc3UH7UnxfhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=bOkWpp6C;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A42A606EEBA;
	Mon,  9 Nov 2026 15:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A42A606EEBA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=bOkWpp6C
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id 521B826673;
	Mon,  9 Nov 2026 16:58:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1794239883;
	bh=x7AGsOET450GqGMhY7lv5S1Lu7ewfrdv+H0Q8y9LtsU=; h=From:To:Subject;
	b=bOkWpp6CD3ayZn8qsB0Vo5ILpZbwIgH1z1cSg1NHc76AvibvYKRVKexj+B3CITpiI
	 ccNVQJ0rkYNyGvvL+9iO2CkkV3fbpLH0T2oq9hgsNGyAjVKtRezSYRtCJmsUD6sttv
	 MWsE5viUxuhK590itgrUNdaJ6GWgVn8nUDIjp75BwWAjkez3CoM9/ZBtMs75rnyZyy
	 lZdfZm/PnuilidSuya+ve6zZgHUVn62yp94kjB3I/8StB2JZKavFhb5qUOfR4M+oTn
	 Ahfk6chdFyp/qmybUHLkJDqWo5VzN5HN2hPacBfOHYWf6Fk7Iqzh/piQUEpvmW8VJ0
	 319c+O25EY92w==
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
Subject: [PATCH v2 5/8] ARM: dts: imx6ull-colibri-emmc: Add Toradex Capacitive Touch Display 7" Parallel
Date: Mon,  9 Nov 2026 16:57:45 +0100
Message-ID: <20261109155751.475875-6-francesco@dolcini.it>
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

Add a device tree overlay for the Capacitive Touch Display 7" Parallel
on the Colibri iMX6ULL eMMC parallel RGB LCD interface.

The panel is a LogicTechno LT161010-2NHC 7" WVGA TFT Transmissive LCD
and the touch input is provided by an Atmel MaxTouch capacitive touch
controller.

The touch controller is connected to the Toradex 10-way Capacitive Touch
Interface connector available on Iris v2 and Aster carrier boards.

The panel, backlight and LCDIF configuration is identical to the Colibri
iMX7 eMMC one, only the Atmel MaxTouch controller wiring is SoC
specific. To avoid duplicating it, rework the Colibri iMX7 eMMC overlay
moving the common part to a new dtsi shared between the two modules,
and include it from both overlays.

The overlay is also combined with the Iris v2 and Aster carrier board
device tree to provide a ready-to-use DTB.

Link: https://developer.toradex.com/hardware/accessories/displays/capacitive-touch-display-7inch-parallel/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: add the tdx vendor prefix to the overlay, shared dtsi and combined DTB names
---
 arch/arm/boot/dts/nxp/imx/Makefile            | 12 +++++++
 ...mc-tdx-panel-cap-touch-7inch-parallel.dtso | 31 +++++++++++++++++++
 ...ri-tdx-panel-cap-touch-7inch-parallel.dtsi | 29 +++++++++++++++++
 ...mc-tdx-panel-cap-touch-7inch-parallel.dtso | 16 ++--------
 4 files changed, 74 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtso
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-tdx-panel-cap-touch-7inch-parallel.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index c05cc9ff782d..a0d22028f20d 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -356,6 +356,15 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-udoo-neo-basic.dtb \
 	imx6sx-udoo-neo-extended.dtb \
 	imx6sx-udoo-neo-full.dtb
+
+imx6ull-colibri-emmc-aster-tdx-panel-cap-touch-7inch-parallel-dtbs := \
+	imx6ull-colibri-emmc-aster.dtb \
+	imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtbo
+
+imx6ull-colibri-emmc-iris-v2-tdx-panel-cap-touch-7inch-parallel-dtbs := \
+	imx6ull-colibri-emmc-iris-v2.dtb \
+	imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtbo
+
 dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-14x14-evk.dtb \
 	imx6ul-ccimx6ulsbcexpress.dtb \
@@ -384,9 +393,12 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-aster.dtb \
 	imx6ull-colibri-emmc-aster.dtb \
+	imx6ull-colibri-emmc-aster-tdx-panel-cap-touch-7inch-parallel.dtb \
 	imx6ull-colibri-emmc-eval-v3.dtb \
 	imx6ull-colibri-emmc-iris.dtb \
 	imx6ull-colibri-emmc-iris-v2.dtb \
+	imx6ull-colibri-emmc-iris-v2-tdx-panel-cap-touch-7inch-parallel.dtb \
+	imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtbo \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-iris.dtb \
 	imx6ull-colibri-iris-v2.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtso b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtso
new file mode 100644
index 000000000000..6d0ad21ae2d7
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtso
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Toradex Capacitive Touch Display 7" Parallel connected through the 40-way
+ * Unified Interface Display and 10-way Capacitive Touch Interface connectors
+ * (as featured on Iris v2 and Aster v1.1 carrier boards).
+ *
+ * https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display-800x480-datasheet.pdf
+ * https://developer.toradex.com/hardware/accessories/displays/capacitive-touch-display-7inch-parallel/
+ * https://www.toradex.com/accessories/capacitive-touch-display-7-inch-parallel
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "imx6ull-imx7-colibri-tdx-panel-cap-touch-7inch-parallel.dtsi"
+
+&atmel_mxt_ts {
+	pinctrl-0 = <&pinctrl_atmel_conn &pinctrl_atmel_snvs_conn>;
+	/* SODIMM 107 / TOUCH_INT# */
+	interrupt-parent = <&gpio5>;
+	interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+	/* SODIMM 106 / TOUCH_RST# */
+	reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-tdx-panel-cap-touch-7inch-parallel.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-tdx-panel-cap-touch-7inch-parallel.dtsi
new file mode 100644
index 000000000000..21688c63d11f
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-tdx-panel-cap-touch-7inch-parallel.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Panel, backlight and LCDIF part of the Toradex Capacitive Touch Display 7"
+ * Parallel overlays, connected through the 40-way Unified Interface Display
+ * connector, shared by the Colibri iMX6ULL eMMC and Colibri iMX7 eMMC overlays.
+ *
+ * The Atmel MaxTouch controller wiring is SoC specific and is described by
+ * the overlay including this file.
+ *
+ * https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display-800x480-datasheet.pdf
+ * https://developer.toradex.com/hardware/accessories/displays/capacitive-touch-display-7inch-parallel/
+ * https://www.toradex.com/accessories/capacitive-touch-display-7-inch-parallel
+ */
+
+&backlight {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	compatible = "logictechno,lt161010-2nhc";
+
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtso b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtso
index f336f7b05a2b..340e772f5c6e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtso
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtso
@@ -17,6 +17,8 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
+#include "imx6ull-imx7-colibri-tdx-panel-cap-touch-7inch-parallel.dtsi"
+
 &atmel_mxt_ts {
 	pinctrl-0 = <&pinctrl_atmel_connector>;
 	/* SODIMM 107 / TOUCH_INT# */
@@ -27,17 +29,3 @@ &atmel_mxt_ts {
 
 	status = "okay";
 };
-
-&backlight {
-	status = "okay";
-};
-
-&lcdif {
-	status = "okay";
-};
-
-&panel_dpi {
-	compatible = "logictechno,lt161010-2nhc";
-
-	status = "okay";
-};
-- 
2.47.3

