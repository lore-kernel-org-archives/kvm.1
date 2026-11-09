Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239893;
	b=3ARjqdz7MBlGn65D/SrUQ/Cd+zFlMk0mRf5wFXmcQRf01DW6nzcM9SuQlVwjF1HHjlVK
	 7sj2jaTtTLl3jW74zYKbZY/EYOVoz2ebmRl2SqFbAu9eVpZxRhB4PA019or7vdkU1jQih
	 nv93n+RvqZIyKFZJrayI1BJGzEBMFM64QXBZCCF0FhhKx/IABn+rLU/S0tU/K2zUpMbeE
	 Wb+2KQxSmMwGh1Eq1llNId3dgDrxn/a6/Rpy5+7btFKAifNqTSFl0fC8C7bx6BYysxqj1
	 m1HT7iiaHDED5/alO147ESGhKYvsbN8E6Z3+ZsynEmE9J9H438Nm3otRvpm1GmD+V6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239893;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JqselKB5C9r652rsZshkeZbvIVXAm1lDRv9GJvn/rF4=;
	b=eFEepXj8J7IAW3VULUF1Nkn4xAaj6L90Zmnl7OKFIMLEYPH8BlQnYNx/gst+8EIc0exX
	 fZtKKmJeZKtFac5Vnnp8K2uR00pynjIUqgqWjxL3lu8qzewNYB7A0o6+sa3miwtoLxSrQ
	 H0dNn4EjS62C1vMSsmFfQsrRVlFGLQGYe790KNorim7IWrwcyedXyHto+RJS2sy8yeLER
	 vt2KStvzD2F6RWFv05jlM9f9PuzqCOTsVkMeXKCC2LuIdcBAJtdmOWsgql25QkSD4l/b1
	 4vvLbzk/YB/T3Jiww658lcF3gZ0ugvBa3gPjhzDFOzLf4e9imQS9T0GGLa2JJ4kzLqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=D9gJ9cH7;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A315606EEB5;
	Mon,  9 Nov 2026 15:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A315606EEB5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=D9gJ9cH7
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id F3BA826674;
	Mon,  9 Nov 2026 16:58:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1794239884;
	bh=JqselKB5C9r652rsZshkeZbvIVXAm1lDRv9GJvn/rF4=; h=From:To:Subject;
	b=D9gJ9cH7tUnNiVoeP+HyfuzBe6k9dxwaL1Lea0vosnI8jjFkOicrM0SxHS5dkQXyc
	 1QNg3NZhABtz/yH52fK5UxTxaaV96r9+5jGyOXZDpnwEWgFZ0XONVs1dQSOrkviw8o
	 1vTSDInCAiHlaoevFBMwP41pO7sp4Wk1HNvXHpZW3Hfxs59lF7F+0HxIqtzigJotjb
	 gLT8I1FThzmrFwvMCNTLpMQHhTgRQjhm2QErwQfPpyvbvLyRXojQJj29RWq6J+jwMU
	 Vyk22TxTjEKidYa5GQ5M9nOGrdwHOLbcHkSvk01qrCvazBe33+gZuiPVBZgX4QIzj8
	 gY8fhdoH70PCg==
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
Subject: [PATCH v2 7/8] ARM: dts: imx6ull-colibri-emmc: Add Toradex Resistive Touch Display 7" Parallel
Date: Mon,  9 Nov 2026 16:57:47 +0100
Message-ID: <20261109155751.475875-8-francesco@dolcini.it>
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

Add a device tree overlay for the Resistive Touch Display 7" Parallel
on the Colibri iMX6ULL eMMC parallel RGB LCD interface.

The panel is a LogicTechno LT161010-2NHR 7" WVGA TFT Transmissive LCD
with a resistive touch.

The overlay content is identical to the Colibri iMX7 eMMC one. To
avoid duplicating it, rework the Colibri iMX7 eMMC overlay moving its
content to a new dtsi shared between the two modules, and include it
from both overlays.

The overlay is also combined with the Eval carrier board device tree to
provide a ready-to-use DTB.

Link: https://developer.toradex.com/hardware/accessories/displays/resistive-touch-display-7inch-parallel/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: add the tdx vendor prefix to the overlay, shared dtsi and combined DTB names
---
 arch/arm/boot/dts/nxp/imx/Makefile            |  6 ++++
 ...mc-tdx-panel-res-touch-7inch-parallel.dtso | 16 ++++++++++
 ...ri-tdx-panel-res-touch-7inch-parallel.dtsi | 30 +++++++++++++++++++
 ...mc-tdx-panel-res-touch-7inch-parallel.dtso | 18 +----------
 4 files changed, 53 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtso
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-tdx-panel-res-touch-7inch-parallel.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index 7332167aee44..060bb01f9396 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -369,6 +369,10 @@ imx6ull-colibri-emmc-eval-v3-tdx-panel-cap-touch-7inch-parallel-touch-adapter-dt
 	imx6ull-colibri-emmc-eval-v3.dtb \
 	imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel-touch-adapter.dtbo
 
+imx6ull-colibri-emmc-eval-v3-tdx-panel-res-touch-7inch-parallel-dtbs := \
+	imx6ull-colibri-emmc-eval-v3.dtb \
+	imx6ull-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtbo
+
 dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-14x14-evk.dtb \
 	imx6ul-ccimx6ulsbcexpress.dtb \
@@ -400,11 +404,13 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-colibri-emmc-aster-tdx-panel-cap-touch-7inch-parallel.dtb \
 	imx6ull-colibri-emmc-eval-v3.dtb \
 	imx6ull-colibri-emmc-eval-v3-tdx-panel-cap-touch-7inch-parallel-touch-adapter.dtb \
+	imx6ull-colibri-emmc-eval-v3-tdx-panel-res-touch-7inch-parallel.dtb \
 	imx6ull-colibri-emmc-iris.dtb \
 	imx6ull-colibri-emmc-iris-v2.dtb \
 	imx6ull-colibri-emmc-iris-v2-tdx-panel-cap-touch-7inch-parallel.dtb \
 	imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtbo \
 	imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel-touch-adapter.dtbo \
+	imx6ull-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtbo \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-iris.dtb \
 	imx6ull-colibri-iris-v2.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtso b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtso
new file mode 100644
index 000000000000..89800a64b596
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtso
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Toradex Resistive Touch Display 7" Parallel connected through the 40-way
+ * Unified Interface Display connector.
+ *
+ * https://docs.toradex.com/104498-7-inch-parallel-resistive-touch-display-800x480.pdf
+ * https://developer.toradex.com/hardware/accessories/displays/resistive-touch-display-7inch-parallel/
+ * https://www.toradex.com/accessories/resistive-touch-display
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include "imx6ull-imx7-colibri-tdx-panel-res-touch-7inch-parallel.dtsi"
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-tdx-panel-res-touch-7inch-parallel.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-tdx-panel-res-touch-7inch-parallel.dtsi
new file mode 100644
index 000000000000..2159b9788064
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-tdx-panel-res-touch-7inch-parallel.dtsi
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Toradex Resistive Touch Display 7" Parallel connected through the 40-way
+ * Unified Interface Display connector, shared by the Colibri iMX6ULL eMMC and
+ * Colibri iMX7 eMMC overlays.
+ *
+ * https://docs.toradex.com/104498-7-inch-parallel-resistive-touch-display-800x480.pdf
+ * https://developer.toradex.com/hardware/accessories/displays/resistive-touch-display-7inch-parallel/
+ * https://www.toradex.com/accessories/resistive-touch-display
+ */
+
+&ad7879_ts {
+	status = "okay";
+};
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
+	compatible = "logictechno,lt161010-2nhr";
+
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtso b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtso
index b926cc020e62..6748ffa2e89a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtso
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtso
@@ -13,20 +13,4 @@
 /dts-v1/;
 /plugin/;
 
-&ad7879_ts {
-	status = "okay";
-};
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
-	compatible = "logictechno,lt161010-2nhr";
-
-	status = "okay";
-};
+#include "imx6ull-imx7-colibri-tdx-panel-res-touch-7inch-parallel.dtsi"
-- 
2.47.3

