Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239889;
	b=pDWb1wsUroKn4TW/2vR3Lkhc9WYm5o3tE4tcKKhVrWPR3kvteh340+cQtNRvm3qAh7Jf
	 WpVEeUBJRS11h/eIAVpg7dK8xI5GmZnglHISl9jccnOLRgUO5MAawD5gXvCQJnO+NHlgT
	 I2QLNYikxQmPizU22PjwFsrv7pdA4f0rf0DpOs1KY5LQtsKK75SlECENraKAVoRQE0fl7
	 Z8ws4gRRfL2wkeih/dlLlPqJhV+77TYmDFxRhA9gWzp6mc5VCHmhq5TQpVCfRU9Y0TkSr
	 LYs4zWyQV+fSMiWNQIJcCvbPZmgsWHxCY0l0URK6alwbchYKpv7zxRfkx0IQ/fWrSfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239889;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iYFxYy4y/RCp8PCPpnknYT8Me8VloobFASIGXdtsvUA=;
	b=C5aUBh94U4Xuh2MAHfMZqp6krai6KroRKBi4/nEoVyHciZIuOCjiFhM7u0wtUlMcxQWw
	 Tb8ZXJiZCCk5rVJ5srafeD13jh4VXWEF6jvUo4z4tUUbIV+1fIETBegPm2+8lIlRnvnBv
	 l2gknkiSZ7FmA/ZFsY4C21WaBFoChxcioDumpUe7jgK3A+oIiml2NvUSOjtm9PzAyP7SW
	 pPw5/kBDVFkgsC6fXiY19S00qdjzpzAaSUmm/NlSax9N1QF6qBwRZCTJ9uWgCIRX27B2Y
	 VtoEfSlWDFwNZiAAvPEybuGuprFDXj6GSgQu56XxYADc2PzmVSrz1wGkfjHK6IF0f9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=BgCACKZd;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A42606A337;
	Mon,  9 Nov 2026 15:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A42606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=BgCACKZd
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id F03CE26665;
	Mon,  9 Nov 2026 16:57:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1794239879;
	bh=iYFxYy4y/RCp8PCPpnknYT8Me8VloobFASIGXdtsvUA=; h=From:To:Subject;
	b=BgCACKZdgA43Rrj5O5wlbP1UTKAKVLnARW1cb4iY0UQ79gZvemqC5K/yua1QBUG0f
	 9yR0+zh4vQIXmGd7WNW3W8IFc+kq0sfR8h/9x0OJGD3rjd/c+vwHYLRjQwz0EF2a6A
	 vjxGEYoqUfuLHIT080/THXyhTMTgwa1KcmQTQmxU9K3PUSCU4JezU+wHUQeYXp0f9l
	 MuuwFfF5cDudhBJyKH7dHLS6cIXa+S4znLPmLBEcIH3sgnJGFiYsr/5K0WEtYL4gu0
	 dL4rJ2Sqw338DL9D98b6G3Am6VRW1XbqHTSaH1DxXUQz9gD52AUubj95gHV/AR6eeP
	 wXMK+Vo4uCiRA==
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
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-bsp@toradex.com,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v2 1/8] ARM: dts: imx7d-colibri-emmc: Enable the VGA DAC
Date: Mon,  9 Nov 2026 16:57:41 +0100
Message-ID: <20261109155751.475875-2-francesco@dolcini.it>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

On the Colibri Evaluation Board and Aster carrier board, the BL_ON signal
on SODIMM 71 controls the active-low power-save input of the ADV7125 VGA
DAC. The VGA overlay does not drive this signal, leaving the DAC disabled.
The monitor receives the sync signals but displays a black image.
On the Iris carrier board, the DAC power-save input is pulled high
so the missing GPIO configuration does not prevent the VGA output from
working.

Add the pinctrl configuration and an active-high enable GPIO to the VGA
bridge so that the simple-bridge driver takes the DAC out of power-save
when enabling the output.

Fixes: cc6c96f0bdd7 ("ARM: dts: imx7d-colibri-emmc: Add VGA overlay")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-vga.dtso | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-vga.dtso b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-vga.dtso
index cda214c13876..363c0c2cc43e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-vga.dtso
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-vga.dtso
@@ -12,9 +12,14 @@
 /dts-v1/;
 /plugin/;
 
+#include <dt-bindings/gpio/gpio.h>
+
 &{/} {
 	vga-encoder {
 		compatible = "dumb-vga-dac";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_bl_on>;
+		enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 
 		ports {
 			#address-cells = <1>;
-- 
2.47.3

