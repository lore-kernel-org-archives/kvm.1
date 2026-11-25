Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619713;
	b=09UGF/90YUpRmy8z2xGwTyKolc6f8elXeip6V5LqLXKNkXmZpkct/Dh2RcWwiFdc+blS
	 nfbrW45X0V0paLlrSLq3WYSSNOQcTWfgvaYKNRmiUgvHwPqnDtKXhRR6yNYwwQNiKiCCz
	 1q6Nfx+q+u3kB0GT2xnt9iRCyHfirmR48P8HV61gusHbAbjmzmmaWUu0P+GFH+hWH3W5y
	 uq2bnSN2ZcjHBzfVUOqyR070BdfYo4ETIEOdAL2g476tfn2dYKfszTs+dWOVlIKqDrXP7
	 3FuGf2fBr8djFj9U4B9HtlD6R+KnI+di+BICzKlEnPxzuoIEuOtfifea/h3+Nz3memw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619713;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JB6rKjtgS7GCtJhRqVtnRh6KiXJmoZWWih+sfY3ClqA=;
	b=Zn6R8U8PSXZyWNa+BPk/CPGNYEtLHq4Q8GMr5rkb9WEGFirahMjm6Cq0NEMBZHE1J710
	 9VdJbzdI2iRSrVXfS5cHL/nNDN8XWaUlIG9vyqxbP9/1395XMfwUYpjjsUqKnzAzLKsFc
	 nerlHkJzQRLfem/PHyI1JXiDoTkZWMLAXTfqaMz2bR85x9q1NXj763YNxN08AZUqtVpfE
	 FwQ3nxk2s6A8EjVR2xpho+wJJTzvsXCql0PLeYi9SoQE04vRIXME+mPN+yacYG35zAWLT
	 QK88yIMXMoXaCdsv70j3fS60sUyl6vYgA9T6ht8GrC8Jlr87PmYjoA9ArXxFqHtCswg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Z/Otg58K";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E9606A32A
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A5E9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Z/Otg58K
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C03D21762;
	Wed, 25 Nov 2026 07:15:09 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DF013FA7A;
	Wed, 25 Nov 2026 07:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619712; bh=CsFqqh1n8afZUR/MIhqwMK/qXUKYHWfg+J5jGa57e88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/Otg58Ksw3vFIVLXWwx5S9NUB2v5SnLjug4pvRtasTiAtbuzrMfV6efc77tqQBEU
	 WC2njSNXhCjwoSbnVkPW09NSGzAgWoZLNXCYhUO3Fu0fD0tOsX4vNB6MGldHE5TL7g
	 hbnqFvcyWFpM41rV9r9AGW6fZBiGuINX4aj1o55w=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 18/23] arm64: Expose the GICv5 irqchip option
Date: Wed, 25 Nov 2026 15:13:51 +0000
Message-Id: <20261125151356.2875108-19-sascha.bischoff@arm.com>
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

Allow --irqchip=gicv5 and prefer GICv5 for automatic irqchip selection
when the kernel supports it. The IRS and guest DT support are now in
place.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c                         | 4 +++-
 arm64/include/kvm/kvm-config-arch.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arm64/gic.c b/arm64/gic.c
index 955eeb5f..c1408502 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -78,6 +78,8 @@ int irqchip_parser(const struct option *opt, const char *arg, int unset)
 		*type = IRQCHIP_GICV3;
 	} else if (!strcmp(arg, "gicv3-its")) {
 		*type = IRQCHIP_GICV3_ITS;
+	} else if (!strcmp(arg, "gicv5")) {
+		*type = IRQCHIP_GICV5;
 	} else {
 		pr_err("irqchip: unknown type \"%s\"\n", arg);
 		return -1;
@@ -405,7 +407,7 @@ int gic__create(struct kvm *kvm, enum irqchip_type type)
 
 	switch (type) {
 	case IRQCHIP_AUTO:
-		for (try = IRQCHIP_GICV3_ITS; try >= IRQCHIP_GICV2; try--) {
+		for (try = IRQCHIP_GICV5; try >= IRQCHIP_GICV2; try--) {
 			err = gic__create(kvm, try);
 			if (!err)
 				break;
diff --git a/arm64/include/kvm/kvm-config-arch.h b/arm64/include/kvm/kvm-config-arch.h
index d8a8ef7f..46130663 100644
--- a/arm64/include/kvm/kvm-config-arch.h
+++ b/arm64/include/kvm/kvm-config-arch.h
@@ -59,7 +59,7 @@ int sve_vl_parser(const struct option *opt, const char *arg, int unset);
 			   "transport (Deprecated: Use --virtio-transport "	\
 			   "option instead)", virtio_transport_parser, kvm),	\
 	OPT_CALLBACK('\0', "irqchip", &(cfg)->irqchip,				\
-		     "[gicv2|gicv2m|gicv3|gicv3-its]",				\
+		     "[gicv2|gicv2m|gicv3|gicv3-its|gicv5]",			\
 		     "Type of interrupt controller to emulate in the guest",	\
 		     irqchip_parser, NULL),					\
 	OPT_U64('\0', "firmware-address", &(cfg)->fw_addr,			\
-- 
2.34.1

