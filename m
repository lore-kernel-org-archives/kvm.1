Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239890;
	b=Tw++7KMU3fX3O2s6CWwxjZPqp//UKCvDXy3foGwJOD1TWTIO0EGZHelV7MDGlEbnpQTG
	 9iWeOC/l/qm7WOc+YzJ9X5eWe9OByz+wh0QA1JmgE0ICX0GdTHYdL84ra2PPJ49ZdEKXw
	 eJgf6FPMJ6kkPs3S0YK7YC1TLcQqM5sZ3ylAqQlpRvMuRk0WV59gRFIKWe8d6E07dx+vu
	 4XvGPS6XtBmZMEchA2wlXXy0UKl40u1o6xLrz3fl36OmEpFleeHvbMMSC1HfSwtI8ar6Z
	 sH4FF3v1u+yQfNSUB/pu+Jg20tISmf/bDpRpEhRUB08GlZuecwU7rPgSu1oCkr0IHxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239890;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5eiyLfLU1C/h+uo8NWvQpDmBybxx9guSvIRHTGKQvZY=;
	b=E8vNB6jA47JDtEOW9B9H3TsxfOwZS0O7yabxbIDCdMCtiB3EvstoiuGlBv/9u3yRpi20
	 vTKkrnZWRNE4bVkTmEDwPknbQoR2U4pIfpy2jZxl21PqjtqQrLCxi6xS6SUhxjgTnssBA
	 fqHShpVdmH/q73tCn/zLwsCYnEncrTTMoQ2RNCl0cfFKzd+plgt0bdaXJnPcxyRoTdWqC
	 NpWUqRns4qVb/pl93NQ16j+JSBjResDoJQY/AH2ahEBgM+QjQ2n73Jss8EHAYqhkfxiF1
	 BuGqC7oEMXSnhoUU2Od0oRC1U9SwENmPQr40A8B5SKte9C+cG11um3wxWIEytajilDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=o3rrfrAV;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427B606A33F;
	Mon,  9 Nov 2026 15:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6427B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=o3rrfrAV
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id DBD3C26666;
	Mon,  9 Nov 2026 16:57:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1794239880;
	bh=5eiyLfLU1C/h+uo8NWvQpDmBybxx9guSvIRHTGKQvZY=; h=From:To:Subject;
	b=o3rrfrAVutK4DGQTNT/1JoyZsiFVehOyTq3z9xWExy5RUgP9sllWaTWJq5azGhxP/
	 ibFkcMM7gAVv+eb2Vn4/x1mX+z2AUtTqgmfiHZOIBfx7ncjyI5IzncTz5AhQASA0b6
	 zBULwe3Ga50LpJg0a3KFJks8tNVv5wqt7CHgBf2rdyv98oBRQ73IhPjV13N49Ws7W5
	 TyAu0Mjmx16I0o4Ns5q/uDX0WQAjK4BII0ac54V4jM/UvPAr5dcqiUmIK2ROJo36Ql
	 quXTNNvh+Zyz7xANAaTSdHMhTc2mWvN4q4xNRB1mDdIfl0poWZyRHJRxvF6NN/UFwI
	 oYcK7k8r7M/qQ==
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
Subject: [PATCH v2 2/8] ARM: dts: imx7d-colibri-emmc: Add missing touch display overlays to dtb-y
Date: Mon,  9 Nov 2026 16:57:42 +0100
Message-ID: <20261109155751.475875-3-francesco@dolcini.it>
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

The Capacitive Touch Display 7" Parallel with Touch Adapter and the
Resistive Touch Display 7" Parallel overlays are only built as a
dependency of the combined Eval carrier board DTBs and are not listed in
dtb-y, so the standalone .dtbo files are not installed by dtbs_install.

Add them to dtb-y like the other Colibri iMX7 eMMC overlays.

Fixes: 64e7d6ba2037 ("ARM: dts: imx7d-colibri-emmc: Add Toradex Capacitive Touch Display 7" Parallel with Touch Adapter")
Fixes: 392bbdb0357b ("ARM: dts: imx7d-colibri-emmc: Add Toradex Resistive Touch Display 7" Parallel")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 arch/arm/boot/dts/nxp/imx/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index a0ad7ee583e8..f22abbd01434 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -472,6 +472,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-colibri-emmc-eval-v3-panel-res-touch-7inch-parallel.dtb \
 	imx7d-colibri-emmc-eval-v3-vga.dtb \
 	imx7d-colibri-emmc-panel-cap-touch-7inch-parallel.dtbo \
+	imx7d-colibri-emmc-panel-cap-touch-7inch-parallel-touch-adapter.dtbo \
+	imx7d-colibri-emmc-panel-res-touch-7inch-parallel.dtbo \
 	imx7d-colibri-emmc-vga.dtbo \
 	imx7d-colibri-eval-v3.dtb \
 	imx7d-colibri-iris.dtb \
-- 
2.47.3

