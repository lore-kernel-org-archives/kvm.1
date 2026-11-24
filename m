Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524145;
	b=bfOHIG11130RBvITUkgVsZ6OIsg+4fyrCSk9YHVPLvZDdKZEF+0PSVReLrcYwebVUvR/
	 Qvl8nH5yL26N3PhsPw9iuV5mEzVHbXO1qTg1Vc8Wz8kr4u7Fcw40YjuZu9LKHVWOZl+5t
	 CRe2DV6Ksw5aIjTk1gpqzlrj+E/298R6v0ZWpRVmxjPkZvC8efcXem/tR/kZnda5WtTbg
	 xiTezaZBkvyZ0fsjwdAr+Zu1ojMlZmKfpBEjPTAn1pQ5guMFQ+dVff34rhfL3gW1BVPZU
	 tRar0RS81AC/roE7JtF0XOb9AFUzhDdx2GVw9Rd+wSjekwmXQZ51fcOwzk72nQSbA1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524145;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Zv+4EZiS26DlNQvyzNgd6gBATMlT9+EPJ9YBCykQ2Tc=;
	b=cxINyJdzmoRBCxXoEuTiq6NKJNzrCs9aivJRNIeh0y2XTp0nLA5zGe1Z7o6gGuVJX+q8
	 3Jx3T8hDWYVGZ49oIXFsf/U0hTg8zEknTJglKQT9Qp3i4D8aZavz4baqWmjfuz44HQJYl
	 iaWyA90wMKGuDpyJL85kt26rBTYnOG2v/G0L3M02tqi9Tb9+VurVUYbbOPk0zgnwXuTu6
	 i5ATWZLsNKCcH1MdJVjCCaGsmckAPjU5HCxPVL/145rh9K8IV3D1cXEOIP3YokssHi33P
	 hm85F9qzuRnZkbi2+QOF8itmfKRVVJ+bzT6aE0XChTmfEmP/z0C+MHX5UvK4dlivFrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=TDnxcTga;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60C606A326;
	Tue, 24 Nov 2026 12:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB60C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=TDnxcTga
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6A8E91F953;
	Tue, 24 Nov 2026 13:42:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1795524134;
	bh=Zv+4EZiS26DlNQvyzNgd6gBATMlT9+EPJ9YBCykQ2Tc=; h=From:To:Subject;
	b=TDnxcTga3xZelYo8999jovrWI15ICGB01YV4Jxpapnz2pw+JaGX7Ibjm7zpAPg8dB
	 7OgyRpVvV3ONvCRWn/pp+RQvrUdTbDxxPsW56Xw5piqvnxAl2b9eP+a2sIa6sNKVqa
	 GrbSWo8/CPX7a0nhlV/fzHSXq82p0HM7OCcw5QYfZNSfBur4ABIAc0L71bX2MP7Aag
	 jz0mQugUIJjgEPlDIakozpAnXqRoI1Xb9J6cMNFpJkDZtcUp2xrS47inSfjEh916Rg
	 msmie2oRTj6ser5VKD7+eqa8XmLbKLzMJ3x5jF0ODR4XpluuxDY5sYkF8ZXylH1chz
	 EzRudXy8FoD3A==
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
Subject: [PATCH v1 0/2] arm64: dts: ti: Add tdx vendor prefix to display overlays
Date: Tue, 24 Nov 2026 13:42:03 +0100
Message-ID: <20261124124207.199382-1-francesco@dolcini.it>
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

Add a "tdx" vendor prefix to the Toradex display accessory overlays of
the Verdin AM62 and Aquila AM69, and a "-v1"/"-v2" suffix to the
Capacitive Touch Display 10.1" LVDS ones.

The overlay names are the Toradex product names of the accessories, and
a product name is unique only together with its vendor. After a long
discussion with the NXP i.MX maintainer on the Apalis iMX6 overlays [1],
we agreed to add the "tdx" vendor prefix, the same way third-party
accessories on Toradex boards already carry theirs, e.g. "rpi" in
k3-am625-verdin-rpi-display-2-7in.dtso. The Toradex display overlays in
the NXP i.MX directories already use the new names.

The same accessories are used across Toradex SoMs from different SoC
vendors, so renaming the existing overlays is the best way to give
users a consistent experience: one accessory has one name, whatever
the SoM, and the vendor prefix leaves no doubt about the product
supported by the overlay file.

[1] https://lore.kernel.org/all/20261026111149.GA46946@francesco-nb/

Francesco Dolcini (2):
  arm64: dts: ti: k3-am62-verdin: Add tdx vendor prefix to display
    overlays
  arm64: dts: ti: k3-am69-aquila: Add tdx vendor prefix to display
    overlays

 arch/arm64/boot/dts/ti/Makefile               | 120 +++++++++---------
 ...e-tdx-panel-cap-touch-10inch-lvds-v1.dtso} |   0
 ...e-tdx-panel-cap-touch-10inch-lvds-v2.dtso} |   0
 ...o-lvds-tdx-panel-cap-touch-10inch-v1.dtso} |   0
 ...o-lvds-tdx-panel-cap-touch-10inch-v2.dtso} |   0
 ...erdin-tdx-panel-cap-touch-10inch-dsi.dtso} |   0
 ...n-tdx-panel-cap-touch-10inch-lvds-v1.dtso} |   0
 ...n-tdx-panel-cap-touch-10inch-lvds-v2.dtso} |   0
 ...verdin-tdx-panel-cap-touch-7inch-dsi.dtso} |   0
 ...apter-tdx-panel-cap-touch-10inch-dsi.dtso} |   0
 ...dapter-tdx-panel-cap-touch-7inch-dsi.dtso} |   0
 ...o-lvds-tdx-panel-cap-touch-10inch-v1.dtso} |   0
 ...o-lvds-tdx-panel-cap-touch-10inch-v2.dtso} |   0
 ...quila-tdx-panel-cap-touch-10inch-dsi.dtso} |   0
 ...aquila-tdx-panel-cap-touch-7inch-dsi.dtso} |   0
 15 files changed, 60 insertions(+), 60 deletions(-)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtso => k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v1.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtso => k3-am625-verdin-dev-mezzanine-tdx-panel-cap-touch-10inch-lvds-v2.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtso => k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-dsi-to-lvds-v2-panel-cap-touch-10inch.dtso => k3-am625-verdin-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-panel-cap-touch-10inch-dsi.dtso => k3-am625-verdin-tdx-panel-cap-touch-10inch-dsi.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-panel-cap-touch-10inch-lvds.dtso => k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v1.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtso => k3-am625-verdin-tdx-panel-cap-touch-10inch-lvds-v2.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am625-verdin-panel-cap-touch-7inch-dsi.dtso => k3-am625-verdin-tdx-panel-cap-touch-7inch-dsi.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-adapter-panel-cap-touch-10inch-dsi.dtso => k3-am69-aquila-adapter-tdx-panel-cap-touch-10inch-dsi.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-adapter-panel-cap-touch-7inch-dsi.dtso => k3-am69-aquila-adapter-tdx-panel-cap-touch-7inch-dsi.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-dsi-to-lvds-panel-cap-touch-10inch.dtso => k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v1.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-dsi-to-lvds-v2-panel-cap-touch-10inch.dtso => k3-am69-aquila-dsi-to-lvds-tdx-panel-cap-touch-10inch-v2.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-panel-cap-touch-10inch-dsi.dtso => k3-am69-aquila-tdx-panel-cap-touch-10inch-dsi.dtso} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am69-aquila-panel-cap-touch-7inch-dsi.dtso => k3-am69-aquila-tdx-panel-cap-touch-7inch-dsi.dtso} (100%)

-- 
2.47.3

