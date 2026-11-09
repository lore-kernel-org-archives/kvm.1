Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239890;
	b=09KV8C6bcKjvnHlLiL185SD0wXcRZkKHlsjB/VQTSGo4VC4TaIPFEwKXxIKYlNWdekQT
	 EISDnOMtDncE0iZQ2py6u4xB20wDmGhlJq45XZ+p/MsUAtffIjzKV4dP2Jf3YuR7SlZQ0
	 3o7tBDkKwOJu5jPoMObPk12+3M6zejs/MNATZJU49dWQUN8SPPVc9PZj7HD0kxZFeesI8
	 CIx/rnPZekjprojXHTNmwPrl5AZht+WH+RFWAC6Oxg6cJPikpL5Lb/9Gbe8fai7Yq7jLx
	 CFVpKmS412rfA17xr2N3pcgUru57aqpKcitxnmjIba60EYIV3NrwdMe14Qkf+yKHdzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239890;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=r3N87t7rpgxXMLe+tyGoCO5FBIgPlIswbKigTqDeBMY=;
	b=d8pkCXN04eVDPbOJE2llJageSBflQAalMZU9/1mc0TrPmrrGnem9voGt2RT2b2n2IhDq
	 ig3Qj4x8g1R7uGi9Be9V6Ja7KQFPYgksAiz5j/wzUD/4Jx1ZwPxBaQCvXMK4OJDOdqKcP
	 u2BnwliKIRUv707yo9yfmUZ550RwskqnCBmpmj0Ao7VsFGF2jjDc8CNoJRR8EsHyug83C
	 vffSrXRno7hQgRx4bYVDtgM1yuIQI/Sm+zqBNjSL2KblcjiExjTz3XJ4x+M3tbGvO2xct
	 jCJ3vX1hCwg7qAwfJ8NyJGQq6zlW4UTo0ihwR1ooidWDBAiM2eL0WZbpHasHHUFRaCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=wKvuv12L;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431E606EE90;
	Mon,  9 Nov 2026 15:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1431E606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=wKvuv12L
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id 29B6426662;
	Mon,  9 Nov 2026 16:57:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1794239878;
	bh=r3N87t7rpgxXMLe+tyGoCO5FBIgPlIswbKigTqDeBMY=; h=From:To:Subject;
	b=wKvuv12Lgl0Lp7WVZrkuWV0q+WgXOfjxmJMsjTpLytkKqdbcUl/kMpoVFSyfhxlDd
	 9gtu+weUURdk+Fh8084MwFYRd9oMIaUS0HD/3qiK/Mr02rmRLGfbhLzoWUJwRJjpK4
	 lmY9f6yGi7T9OWGQ/RLiK73WuC7BgKOjFESkd+86Wm8dFImN3B6t03dT9P5HbjwGug
	 RZdDH76en8sDjcg7b3CMAceUGkR/jfnxy0LVH0502kgUK993IRiwddwvXGBU7N7VXC
	 gKKK1DDfR/iVxNj9wxg3Pz2u+1+BbYpKhLdcQQytGDKowFhjns4JDKgsNH6+N7/uEu
	 cgEL6Nxvm5sKw==
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
Subject: [PATCH v2 0/8] ARM: dts: imx6ull-colibri-emmc: Add DPI display and VGA overlays
Date: Mon,  9 Nov 2026 16:57:40 +0100
Message-ID: <20261109155751.475875-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
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

Add device tree overlays for the Toradex display accessories on the
Colibri iMX6ULL eMMC parallel RGB LCD interface, mirroring what was
recently merged for the Colibri iMX7 eMMC:

 - Capacitive Touch Display 7" Parallel, touch on the 10-way Capacitive
   Touch Interface connector (Iris v2, Aster)
 - Capacitive Touch Display 7" Parallel, touch through the Capacitive
   Touch Adapter (Eval v3)
 - Resistive Touch Display 7" Parallel (Eval v3)
 - VGA output through a non-programmable video DAC (Aster, Eval v3,
   Iris, Iris v2)

The panel, backlight and LCDIF part of each overlay is identical between
the two modules, both using the same LCDIF binding and labels. Instead
of duplicating it, each patch moves that part out of the corresponding
Colibri iMX7 eMMC overlay into a dtsi shared by the two modules and
includes it from both. Only the Atmel MaxTouch wiring, the conflicting
PWM channels and the BL_ON pinctrl and GPIO driving the VGA DAC power-save
input stay in the SoC specific overlays. The shared files follow the
imx6ul-imx6ull-*.dtsi naming already used in the same directory.

The overlay names are the Toradex product names of the accessories, and
a product name is unique only together with its vendor. Following the
discussion on the Apalis iMX6 overlays [1], the Toradex accessories get
a "tdx" vendor prefix, the same way third-party accessories on Toradex
boards already carry theirs, e.g. "rpi" in
k3-am625-verdin-rpi-display-2-7in.dtso.

Patches 1 and 2 are fixes and come first, so they can be backported
without the rename. Patch 1 (from Emanuele) drives the VGA DAC power-save
input through the BL_ON signal, without it the Eval and Aster carrier
boards show a black image. Patch 2 adds the Colibri iMX7 eMMC touch
adapter and resistive touch .dtbo to dtb-y, as they were built only as a
dependency of the combined DTBs and never shipped by dtbs_install.
Patch 3 adds the tdx vendor prefix to the existing Colibri iMX7 eMMC
display overlays. Patch 4 aligns the Colibri iMX6ULL backlight
brightness levels with the Colibri iMX7 ones, the LED driver of the 7"
displays turns off below roughly 15% duty cycle and only the three
highest of the current levels produced a visible image.

[1] https://lore.kernel.org/all/20261026111149.GA46946@francesco-nb/

v2:
 - add patch 3, tdx vendor prefix for the Colibri iMX7 eMMC display
   overlays
 - add the tdx vendor prefix to the new Colibri iMX6ULL display
   overlays, the shared dtsi and the combined DTBs
v1: https://lore.kernel.org/all/20261001174924.3831455-1-francesco@dolcini.it/

Emanuele Ghidoli (1):
  ARM: dts: imx7d-colibri-emmc: Enable the VGA DAC

Francesco Dolcini (7):
  ARM: dts: imx7d-colibri-emmc: Add missing touch display overlays to
    dtb-y
  ARM: dts: imx7d-colibri-emmc: Add tdx vendor prefix to display
    overlays
  ARM: dts: imx6ull-colibri: Align backlight brightness levels with
    Colibri iMX7
  ARM: dts: imx6ull-colibri-emmc: Add Toradex Capacitive Touch Display
    7" Parallel
  ARM: dts: imx6ull-colibri-emmc: Add Toradex Capacitive Touch Display
    7" Parallel with Touch Adapter
  ARM: dts: imx6ull-colibri-emmc: Add Toradex Resistive Touch Display 7"
    Parallel
  ARM: dts: imx6ull-colibri-emmc: Add VGA overlay

 arch/arm/boot/dts/nxp/imx/Makefile            | 73 +++++++++++++++----
 ...ap-touch-7inch-parallel-touch-adapter.dtso | 46 ++++++++++++
 ...mc-tdx-panel-cap-touch-7inch-parallel.dtso | 31 ++++++++
 ...mc-tdx-panel-res-touch-7inch-parallel.dtso | 16 ++++
 .../dts/nxp/imx/imx6ull-colibri-emmc-vga.dtso | 24 ++++++
 .../arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi |  4 +-
 ...ri-tdx-panel-cap-touch-7inch-parallel.dtsi | 29 ++++++++
 ...i-tdx-panel-res-touch-7inch-parallel.dtsi} |  8 +-
 .../dts/nxp/imx/imx6ull-imx7-colibri-vga.dtsi | 61 ++++++++++++++++
 ...p-touch-7inch-parallel-touch-adapter.dtso} | 16 +---
 ...c-tdx-panel-cap-touch-7inch-parallel.dtso} | 16 +---
 ...mc-tdx-panel-res-touch-7inch-parallel.dtso | 16 ++++
 .../dts/nxp/imx/imx7d-colibri-emmc-vga.dtso   | 49 ++-----------
 13 files changed, 299 insertions(+), 90 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel-touch-adapter.dtso
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtso
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtso
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-vga.dtso
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-tdx-panel-cap-touch-7inch-parallel.dtsi
 rename arch/arm/boot/dts/nxp/imx/{imx7d-colibri-emmc-panel-res-touch-7inch-parallel.dtso => imx6ull-imx7-colibri-tdx-panel-res-touch-7inch-parallel.dtsi} (77%)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-vga.dtsi
 rename arch/arm/boot/dts/nxp/imx/{imx7d-colibri-emmc-panel-cap-touch-7inch-parallel-touch-adapter.dtso => imx7d-colibri-emmc-tdx-panel-cap-touch-7inch-parallel-touch-adapter.dtso} (90%)
 rename arch/arm/boot/dts/nxp/imx/{imx7d-colibri-emmc-panel-cap-touch-7inch-parallel.dtso => imx7d-colibri-emmc-tdx-panel-cap-touch-7inch-parallel.dtso} (86%)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-tdx-panel-res-touch-7inch-parallel.dtso

-- 
2.47.3

