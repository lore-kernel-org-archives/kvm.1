Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239890;
	b=5ez/JEOK7eH8T8Fo9pqCd0vunuSZ/NB57hGvBIl6stm/yb5unDpLdUelHNdSVOsGlnbX
	 DM8grcUPtdAYXSsRi+ZGo/xVx41mOzm5vzmKDZ3YJbZsS6VDLPxCt7IWav7oermReXeDj
	 7NBzAwudyvGuJYDI8e0XyLYxTYKwtTKXvVn0cWfzqbwLspjqUJQM89atTdLc8X5esyCUx
	 QaWCth6goD2BtfjUtP/XfDOrtolQksE1uzybaePBDLNQxd/tiMyxoBBKBhaAgWjHb7btK
	 Uh0+xNUx0nqpC4TDnpW29omVLhVfuktOOmWRamhPtxGmc8P0Zw2K8ZTTxAILfLeAfbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239890;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D500kmfJ3Qu7r4nWafyRLbfBk9Mhl+ZKg9JhUW5WufE=;
	b=nuHS3HfEKmMHaGtdv/eAw/RyKjtwkMhOWzluUKvdxCgmbWNqK7nrWkiTbaSsDn6y7Q1u
	 hUNNEGgcuGAuEyQ8SmGpnxI+ca1Yf4ZOxwL/SYKWaur6wm+1ErsAzcnaTYmhwRZhWFgLQ
	 ACe5wTJD1DcrJaZhpxXUoKU1ZJe1MxsRB/62QK8ZdcVByFzs6e7ubw4rODxVZv/TidNvO
	 o0lohvFVCas8dfH1nAO4Xhzrt8iYa1Mb3R6B65buGkT3NhFgG7LdmmcytEkStzUzBF4RW
	 alAzInp3GsYEF/h8f63siozQS6yOn2IuoghDLH25aSVTnKsRu3IcJpHiGxs66jBV4oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=EuBpogJC;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF9606A32A;
	Mon,  9 Nov 2026 15:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2EF9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=EuBpogJC
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id 861742666C;
	Mon,  9 Nov 2026 16:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1794239882;
	bh=D500kmfJ3Qu7r4nWafyRLbfBk9Mhl+ZKg9JhUW5WufE=; h=From:To:Subject;
	b=EuBpogJC9ohUxTmXRjz/d+pgykISbVewiEtm1BEIwUdZlbcqJHhYFiOMswEF0KU4+
	 6EJYcWFvl4zk2iUmdLan+w+ABfuUgHn431PExA9sDDgJPLYD42pfx1Er3YIUoKNhd0
	 +mn0U/jfB6joTMUF7s+9bGY1uCWoZ93oMRob82NNLraTOCAKCkYKWEZTN5XG6qTERt
	 exjZwmDFvVxV7/8VDOe+F7aRbgv2u7sqzj2QV3fzsQ/migOcgHztq0aBIM8F4vphVl
	 TmtgIxhcemdiT7BrgizRtv6rg2ocjDuaEUc8pvn4lOUfPF6pubnF4Um0RSi7xMS/po
	 ZC8KKPibeLGAA==
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
Subject: [PATCH v2 4/8] ARM: dts: imx6ull-colibri: Align backlight brightness levels with Colibri iMX7
Date: Mon,  9 Nov 2026 16:57:44 +0100
Message-ID: <20261109155751.475875-5-francesco@dolcini.it>
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

The LED driver of the Toradex 7" parallel displays turns the backlight
off below roughly 15% PWM duty cycle, with the current brightness levels
only the three highest ones produce a visible image.

Use the same brightness levels as on the Colibri iMX7, which is used with
the same displays, keeping the default brightness at about the same
value.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
index 1eb1cf2d7395..dd2dc23f0cf1 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
@@ -14,8 +14,8 @@ aliases {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
+		brightness-levels = <0 45 63 88 119 158 203 255>;
+		default-brightness-level = <4>;
 		enable-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-- 
2.47.3

