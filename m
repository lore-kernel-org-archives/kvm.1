Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524145;
	b=LmQufh7LEMmsDX1YQoaVScPxpARxy5nXbAD72m/q+eTiUMyTEFIbZztykMSnpMstzEyn
	 7hTu4yYFItMPdjMd//Rr64oO8/O6BfIe7OANOlhdycz97IYaqAQpA+v8fGWhlwGbAt6Kf
	 igXduO2/m2AL+eBqi5PutxerTM0DbH9vWSJ5eS9kvyCZ/WtHmXd2F4xfi3c6n798M9gnu
	 kOyV/bAs/6bt7LTgLUyuH+Fr0bkLI93Hjp3byfXPCnwyqtq94p1Q74VDOAsSHfyePlXEy
	 TEwJQuvRHd2HjY4H26TzDBPz7qh3JJ8q2NN8FMUSrAiC4y7JHvZ7BcL7QvKMgJNduPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524145;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FXHwcBo55fXV6NB/G7yDaAi5wcc/RVjDUECLhPxRCew=;
	b=bA7yNSsjUCcmGgcN+yDLfyxYPIPnGFwtXu8Z/f3U+MdmBxplybwkMgyrh6wBQUGA28by
	 UbRndNjPSslMvpmtkwymy+CrVZ9EFfRYKaUtQYbiZumVd41BTNnCn6dTuL/123iaNDrZu
	 0baS7fob2lESulPmabfj2od1LUYsnUCs4XYMnvrOEOa0ZqFdZZ3ViqMiy9NYxSgWBtX9/
	 zXAmTllg/k2tGeZulom//FHv+5olkxT72Ayx+EiMOic409aJiuxHbneIpZIoYFuMz1anw
	 lfsI81/rPW6EJjbXVLtsXIkr7yWaVE6rZZ8frWzvnz08svHsTstPqxPdcRqri/R5hCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=I9gPpYeg;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B9606A321;
	Tue, 24 Nov 2026 12:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB4B9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=I9gPpYeg
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 28416204EE;
	Tue, 24 Nov 2026 13:42:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1795524135;
	bh=FXHwcBo55fXV6NB/G7yDaAi5wcc/RVjDUECLhPxRCew=; h=From:To:Subject;
	b=I9gPpYegYYcFWSPNMPsH/TDQ5cFhYbWw55w/KqFQTk/9+163UX5KA149aulT5ODc4
	 qKfHJDbvJdxqWXg+D0zzGgEujZcTo3Ld8pdE6bOdr9r0H42TQYUtDqNLkj5tcitphj
	 7IOEAkkAEpaNq8lKUOTumIDUeTPIYTZiZUcQ1GvtigjFqglu+DnnJq72mkFZQBOhEH
	 UMnwNzU1CNYHcc9o9ZpCKavUcjM+3Dl5XPoF88Y52Vq83BJhRFgcIIPIgqXZGY1cN5
	 mF5v27pjdQNqgWwbQza6D1D+2R1X7BHwJ4DOEgWG1ltVRQHEIzUVxCHOXqBMm6CsD4
	 DMLrK+dekQ0CQ==
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
Subject: [PATCH v1 1/2] arm64: dts: ti: k3-am62-verdin: Add tdx vendor prefix to display overlays
Date: Tue, 24 Nov 2026 13:42:04 +0100
Message-ID: <20261124124207.199382-2-francesco@dolcini.it>
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
 arch/arm64/boot/dts/ti/Makefile               | 72 +++++++++----------
 ...e-tdx-panel-cap-touch-10inch-lvds-v1.dtso} |  0
 ...e-tdx-panel-cap-touch-10inch-lvds-v2.dtso} |  0
 ...o-lvds-tdx-panel-cap-touch-10inch-v1.dtso} |  0
 ...o-lvds-tdx-panel-cap-touch-10inch-v2.dtso} |  0
 ...erdin-tdx-panel-cap-touch-10inch-dsi.dtso} |  0
 ...n-tdx-panel-cap-touch-10inch-lvds-v1.dtso} |  0
 ...n-tdx-panel-cap-touch-10inch-lvds-v2.dtso} |  0
 ...verdin-tdx-panel-cap-touch-7inch-dsi.dtso} |  0
 9 files changed, 36 insertions(+), 36 deletions(-)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtso => k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v1.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtso => k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v2.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtso => k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-dsi-to-lvds-v2-panel-cap-touch-10inch.dtso => k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-panel-cap-touch-10inch-dsi.dtso => k3-am625-verdin-tdx-panel-cap-touch-10inch-dsi.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-panel-cap-touch-10inch-lvds.dtso => k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v1.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtso => k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v2.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-panel-cap-touch-7inch-dsi.dtso => k3-am625-verdin-tdx-panel-cap-touch-7inch-dsi.dtso} (100%)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index da654153a35b..4c31fceb6497 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -11,16 +11,16 @@
 # Boards with AM62x SoC
 k3-am625-verdin-nonwifi-dahlia-dsi-to-hdmi-dtbs := k3-am625-verdin-nonwifi-dahlia.dtb \
 	k3-am625-verdin-dsi-to-hdmi.dtbo
-k3-am625-verdin-nonwifi-dahlia-panel-cap-touch-10inch-dsi-dtbs := \
+k3-am625-verdin-nonwifi-dahlia-tdx-panel-cap-touch-10inch-dsi-dtbs := \
 	k3-am625-verdin-nonwifi-dahlia.dtb \
-	k3-am625-verdin-panel-cap-touch-10inch-dsi.dtbo
+	k3-am625-verdin-tdx-panel-cap-touch-10inch-dsi.dtbo
 k3-am625-verdin-nonwifi-dev-dsi-to-hdmi-dtbs := k3-am625-verdin-nonwifi-dev.dtb \
 	k3-am625-verdin-dsi-to-hdmi.dtbo
 k3-am625-verdin-wifi-dahlia-dsi-to-hdmi-dtbs := k3-am625-verdin-wifi-dahlia.dtb \
 	k3-am625-verdin-dsi-to-hdmi.dtbo
-k3-am625-verdin-wifi-dahlia-panel-cap-touch-10inch-dsi-dtbs := \
+k3-am625-verdin-wifi-dahlia-tdx-panel-cap-touch-10inch-dsi-dtbs := \
 	k3-am625-verdin-wifi-dahlia.dtb \
-	k3-am625-verdin-panel-cap-touch-10inch-dsi.dtbo
+	k3-am625-verdin-tdx-panel-cap-touch-10inch-dsi.dtbo
 k3-am625-verdin-wifi-dev-dsi-to-hdmi-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dsi-to-hdmi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
@@ -33,14 +33,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-sk-microtips-mf101hie-panel.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-tqma62xx-mba62xx.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-can.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v1.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-nau8822-btl.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-hdmi.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-lvds-v2-panel-cap-touch-10inch.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia-dsi-to-hdmi.dtb
-dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia-panel-cap-touch-10inch-dsi.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia-tdx-panel-cap-touch-10inch-dsi.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dev-dsi-to-hdmi.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dev.dtb
@@ -50,13 +50,13 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-zinnia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-ov5640-24mhz.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-ov5640.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-10inch-dsi.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-10inch-lvds.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-7inch-dsi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-rpi-display-2-7in.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-tdx-panel-cap-touch-10inch-dsi.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v1.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v2.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-tdx-panel-cap-touch-7inch-dsi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia-dsi-to-hdmi.dtb
-dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia-panel-cap-touch-10inch-dsi.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia-tdx-panel-cap-touch-10inch-dsi.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev-dsi-to-hdmi.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
@@ -271,40 +271,40 @@ k3-am625-sk-csi2-tevi-ov5640-dtbs := k3-am625-sk.dtb \
 k3-am625-sk-hdmi-audio-dtbs := k3-am625-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am625-sk-microtips-mf101hie-panel-dtbs := k3-am625-sk.dtb \
 	k3-am625-sk-microtips-mf101hie-panel.dtbo
-k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch-dtbs := \
+k3-am625-verdin-wifi-dev-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
-	k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
-k3-am625-verdin-wifi-dev-dsi-to-lvds-v2-panel-cap-touch-10inch-dtbs := \
+	k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtbo
+k3-am625-verdin-wifi-dev-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
-	k3-am625-verdin-dsi-to-lvds-v2-panel-cap-touch-10inch.dtbo
+	k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtbo
 k3-am625-verdin-wifi-dev-mezzanine-can-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dev-mezzanine-can.dtbo
-k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds-dtbs := \
+k3-am625-verdin-wifi-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v1-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
-	k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtbo
-k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds-v2-dtbs := \
+	k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v1.dtbo
+k3-am625-verdin-wifi-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v2-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
-	k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtbo
+	k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v2.dtbo
 k3-am625-verdin-wifi-dev-nau8822-btl-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dev-nau8822-btl.dtbo
 k3-am625-verdin-wifi-dev-ov5640-24mhz-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-ov5640-24mhz.dtbo
 k3-am625-verdin-wifi-dev-ov5640-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-ov5640.dtbo
-k3-am625-verdin-wifi-dev-panel-cap-touch-7inch-dsi-dtbs := \
-	k3-am625-verdin-wifi-dev.dtb \
-	k3-am625-verdin-panel-cap-touch-7inch-dsi.dtbo
 k3-am625-verdin-wifi-dev-rpi-display-2-7in-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-rpi-display-2-7in.dtbo
+k3-am625-verdin-wifi-dev-tdx-panel-cap-touch-7inch-dsi-dtbs := \
+	k3-am625-verdin-wifi-dev.dtb \
+	k3-am625-verdin-tdx-panel-cap-touch-7inch-dsi.dtbo
 k3-am625-verdin-wifi-dev-uart4-mcu-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am62x-verdin-uart4-mcu.dtbo
-k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds-dtbs := \
+k3-am625-verdin-wifi-mallow-tdx-panel-cap-touch-10inch-lvds-v1-dtbs := \
 	k3-am625-verdin-wifi-mallow.dtb \
-	k3-am625-verdin-panel-cap-touch-10inch-lvds.dtbo
-k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds-v2-dtbs := \
+	k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v1.dtbo
+k3-am625-verdin-wifi-mallow-tdx-panel-cap-touch-10inch-lvds-v2-dtbs := \
 	k3-am625-verdin-wifi-mallow.dtb \
-	k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtbo
+	k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v2.dtbo
 k3-am62-lp-sk-hdmi-audio-dtbs := k3-am62-lp-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am62-lp-sk-nand-dtbs := k3-am62-lp-sk.dtb k3-am62-lp-sk-nand.dtbo
 k3-am62a7-phyboard-lyra-disable-eth-phy-dtbs := k3-am62a7-phyboard-lyra-rdk.dtb \
@@ -445,19 +445,19 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-sk-csi2-tevi-ov5640.dtb \
 	k3-am625-sk-hdmi-audio.dtb \
 	k3-am625-sk-microtips-mf101hie-panel.dtb \
-	k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch.dtb \
-	k3-am625-verdin-wifi-dev-dsi-to-lvds-v2-panel-cap-touch-10inch.dtb \
+	k3-am625-verdin-wifi-dev-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtb \
+	k3-am625-verdin-wifi-dev-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtb \
 	k3-am625-verdin-wifi-dev-mezzanine-can.dtb \
-	k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds.dtb \
-	k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtb \
+	k3-am625-verdin-wifi-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v1.dtb \
+	k3-am625-verdin-wifi-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v2.dtb \
 	k3-am625-verdin-wifi-dev-nau8822-btl.dtb \
 	k3-am625-verdin-wifi-dev-ov5640-24mhz.dtb \
 	k3-am625-verdin-wifi-dev-ov5640.dtb \
-	k3-am625-verdin-wifi-dev-panel-cap-touch-7inch-dsi.dtb \
 	k3-am625-verdin-wifi-dev-rpi-display-2-7in.dtb \
+	k3-am625-verdin-wifi-dev-tdx-panel-cap-touch-7inch-dsi.dtb \
 	k3-am625-verdin-wifi-dev-uart4-mcu.dtb \
-	k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds.dtb \
-	k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds-v2.dtb \
+	k3-am625-verdin-wifi-mallow-tdx-panel-cap-touch-10inch-lvds-v1.dtb \
+	k3-am625-verdin-wifi-mallow-tdx-panel-cap-touch-10inch-lvds-v2.dtb \
 	k3-am62-lp-sk-hdmi-audio.dtb \
 	k3-am62-lp-sk-nand.dtb \
 	k3-am62a7-phyboard-lyra-disable-eth-phy.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v1.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtso
rename to arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v1.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v2.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtso
rename to arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v2.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtso
rename to arch/arm64/boot/dts/ti/k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-dsi-to-lvds-v2-panel-cap-touch-10inch.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am625-verdin-dsi-to-lvds-v2-panel-cap-touch-10inch.dtso
rename to arch/arm64/boot/dts/ti/k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-dsi.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-tdx-panel-cap-touch-10inch-dsi.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-dsi.dtso
rename to arch/arm64/boot/dts/ti/k3-am625-verdin-tdx-panel-cap-touch-10inch-dsi.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-lvds.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v1.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-lvds.dtso
rename to arch/arm64/boot/dts/ti/k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v1.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v2.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtso
rename to arch/arm64/boot/dts/ti/k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v2.dtso
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-7inch-dsi.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-tdx-panel-cap-touch-7inch-dsi.dtso
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-7inch-dsi.dtso
rename to arch/arm64/boot/dts/ti/k3-am625-verdin-tdx-panel-cap-touch-7inch-dsi.dtso
-- 
2.47.3

