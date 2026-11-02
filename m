Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655336;
	b=zrPbKWUtXSpixRusu5cDDJpqlj2kiOd5UsTrugDC++k8mOI3Ld64RaZHcKBI/n2Ailxq
	 FYC9HGWhLgy4HvNPqQuP73awIWW8mrpiIit8NXt/yYyw0P1ZaZYsl4I0X/OD0oROx5oyU
	 zgU5XDVdADFZSTf6V/O+BctsbElPrEuHl7VBry4y3oX9pYamIxHnqQBC0jbFHe0cJAV4o
	 Hnkq/48VwvGVikATOeMZVpuVlN5F1DNhChyoC6dLvij3MJsvMpuYkwJcMYEHxYHnRgicA
	 uuVVyzZrJkb3OHQimIoL0X7eqy1QBICBSiDcw74QWjRT7Ytb/PB+zghKNk7nOS/6DnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655336;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AvisrEqQElUoHyisCCLCSldLV5z6aMNgp29/YuuIZCA=;
	b=usUZVyfTe3cu9466oaz7IMVAwVKOz764/otjslxIsMwOATEmKvXONIUugF3Wy9C4JdoZ
	 wocA55GRO32FJTMtX9273/4tWy5jbH4cNllUvn08kpCh464QeL+UWkYzUfDlH/VV9f3PC
	 lQJ8FlgmEdAiuUfqU8BW9voCLR70BUWNdU9V0dw/touGFBIHwsbKU1eBiqH2bPvqbmiDA
	 cI7g0nI8hotLt4ZexQClwXyDQZ5ItCXsuAB/S6eJVvIa9+nkt5o3EAH+v7GxkHo/gtsEz
	 dfHRcxtdvzWpS4YZiYGofWV3OZl+clj1zAN6FgR9oqxmXC87Q6VG9Yyg11Vle4wHgxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZnDHxJNQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57EB608360F
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A57EB608360F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZnDHxJNQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01BB81595;
	Mon,  2 Nov 2026 13:35:32 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1A243F673;
	Mon,  2 Nov 2026 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793655335; bh=MUCtExWUSWr34apmoDGdTASZbCVWFvhA7xJCDqrY4rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnDHxJNQxfd865ntegJhmjbiCx7HYzX3XMsJiRZDqyOAB4JruRBhQNM5SWvSkynl3
	 cyCVDO9bDsxVqSRX/WNDNXFGIr8oXV17P/SuTghzbhMkv52CdgngX4AvxaTl0T093z
	 K+NcdSjoR+nUvB+ILYJabszPpwxs8J8Z4i8g0sBM=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v4 18/23] arm64: Expose the GICv5 irqchip option
Date: Mon,  2 Nov 2026 21:34:08 +0000
Message-Id: <20261102213413.4136118-19-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102213413.4136118-1-sascha.bischoff@arm.com>
References: <20261102213413.4136118-1-sascha.bischoff@arm.com>
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
index 91447703..6abd7d44 100644
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
@@ -404,7 +406,7 @@ int gic__create(struct kvm *kvm, enum irqchip_type type)
 
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

