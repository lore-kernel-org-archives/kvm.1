Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619732;
	b=MO660xm/immCp39h+fNsed/pUh9li873NmFL2f4XppfJkzJPVd7AnMu+Bk6xI/+z6i8a
	 vLebz8Fn+YsEGy01Us/hZLFtTXeDN65nooECHQ9cM5fmpNftzYwwjlmGB77pWtfzbkV3v
	 E0+BndD8MppL4vrviHteQ1KOXxN81UOztucl+4O7Psi9+ebHheRxpCzemK6pSCO1xxAWq
	 ArlM6ub2cYUU2mL9nQiY5rxjlaJhDXMCAf+pvp4rsVIcp0WAOCckllYAUNA8L7dbjmNOm
	 hFOFMPf5IVfwYGIpbUv6G8FY3QpxkEO7Ko2pNdzDpJuAP3X47K+Rxspz1UErHR2KdqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619732;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5kR+NcMSQ7ykJji3RevBgB6GAVzprMAWarlwVHhwyLQ=;
	b=nWifV06t9xq9mAx01LEZbS+G0GDvxVIqo7d9K7bT6YakBIs8VqSxLDUYC7DWuUVyN2D8
	 y+JIMuSQJtPcbsc2WTsjwGt/Pzq9DMDnQqBKmMiooQ8SIu9n5pYc6b6bWxE2b+gEgTb8K
	 OKCXQbU8jG+uux5+TqXYFD6h0vbnFXFadaf3yM4RNpHMDHWAFrvlZjpuqeCZp2E1NSaH8
	 O7ScMrtA6GSzV9MpthEJJ3/STla8/6dHiYUz4ugVjT0wAzRd3SYHH6Dn8aqWYz8hpUvNn
	 biY2tcn8Xk1V09VRc0dWyO2XKHqJsVR94jRSbLj6QAJUpBZwc/DBUOHpHaSQZ29vPaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=h4ylK1rW;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9DE606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B9DE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=h4ylK1rW
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2446D1596;
	Wed, 25 Nov 2026 07:15:29 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E35353F86F;
	Wed, 25 Nov 2026 07:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619732; bh=rq+ZmJ6FSww4chdItGgGNPA524Q167UVgT/xB7zd+pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4ylK1rW1v47S74BxjlvP3TzGt1p4724xx1Jjz1w9pLCVEB4s056aOyyLz9AGo475
	 +1I0mlyl60jXllYoWHMyCJ8634xn4cWzs6b7NBohh5Zg6eCWOXGyudPllgH8d1bkav
	 xlRKjQN994aDKPdbR0WQb3VJgtDx7mkMD23P/ARo=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 23/23] arm64: Expose the GICv5 ITS irqchip option
Date: Wed, 25 Nov 2026 15:13:56 +0000
Message-Id: <20261125151356.2875108-24-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125151356.2875108-1-sascha.bischoff@arm.com>
References: <20261125151356.2875108-1-sascha.bischoff@arm.com>
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

Allow --irqchip=gicv5-its now that the ITS DT nodes and PCI MSI
requester mapping are in place. Start automatic irqchip selection at
GICv5 ITS so it is preferred ahead of base GICv5 and older models.

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c                         | 4 +++-
 arm64/include/kvm/kvm-config-arch.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arm64/gic.c b/arm64/gic.c
index 2b24f5b6..230448e8 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -81,6 +81,8 @@ int irqchip_parser(const struct option *opt, const char *arg, int unset)
 		*type = IRQCHIP_GICV3_ITS;
 	} else if (!strcmp(arg, "gicv5")) {
 		*type = IRQCHIP_GICV5;
+	} else if (!strcmp(arg, "gicv5-its")) {
+		*type = IRQCHIP_GICV5_ITS;
 	} else {
 		pr_err("irqchip: unknown type \"%s\"\n", arg);
 		return -1;
@@ -415,7 +417,7 @@ int gic__create(struct kvm *kvm, enum irqchip_type type)
 
 	switch (type) {
 	case IRQCHIP_AUTO:
-		for (try = IRQCHIP_GICV5; try >= IRQCHIP_GICV2; try--) {
+		for (try = IRQCHIP_GICV5_ITS; try >= IRQCHIP_GICV2; try--) {
 			err = gic__create(kvm, try);
 			if (!err)
 				break;
diff --git a/arm64/include/kvm/kvm-config-arch.h b/arm64/include/kvm/kvm-config-arch.h
index 46130663..936b142d 100644
--- a/arm64/include/kvm/kvm-config-arch.h
+++ b/arm64/include/kvm/kvm-config-arch.h
@@ -59,7 +59,7 @@ int sve_vl_parser(const struct option *opt, const char *arg, int unset);
 			   "transport (Deprecated: Use --virtio-transport "	\
 			   "option instead)", virtio_transport_parser, kvm),	\
 	OPT_CALLBACK('\0', "irqchip", &(cfg)->irqchip,				\
-		     "[gicv2|gicv2m|gicv3|gicv3-its|gicv5]",			\
+		     "[gicv2|gicv2m|gicv3|gicv3-its|gicv5|gicv5-its]",		\
 		     "Type of interrupt controller to emulate in the guest",	\
 		     irqchip_parser, NULL),					\
 	OPT_U64('\0', "firmware-address", &(cfg)->fw_addr,			\
-- 
2.34.1

