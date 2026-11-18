Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024760;
	b=SK3y2VSvAt0pcBAMq5qr9oaanlP2N3hqmowHwC+oJQUNVu9Wm7zJXwdzCkk99fa4u3aE
	 ripBzjisIKdFU7/rrQ6h+CfJEw6P90fa0xmuQV7Tg266aD+FS2XDBAYis6RqNmU7bDtuq
	 x9wpu1KBNDXWIgOKz/ie/bZN31jDpzEvJDjNGzv5AOgdijJ/jU+bM+4FW7rH8FMtNgJeN
	 TA/b+1zsDHz+5sXClB35UQGvAOHSlqbiBHzAfNsBaSURF07TTHMseHdHOlvhwBMtjFOyn
	 95qhcgFZjejuegvIrKDUKu24gUlc8XGOibsfGUsr3m6l0sqO1zx6+Go/HEMSf2O9UeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024760;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E2uOxf0rKJT7HU77NZNT4DkyxJwury1M45enAmemSE0=;
	b=l3CoeG2PRgaz5YAwncQ+67pY8iDveeC46Ix63qM8SrbHk3XqhvsvKUidhx1l2DN0V84D
	 7pvxHhQSFZMHDFdBcHOq4MI2GeovdZIJdfo+uqDfewhsRwg3ZH6VWHiXDGz+XAiX9NtpJ
	 zh77/TI5Yj80igF7PsqddVlLDvO6I3yLjaLqNGlmKTG9WncbWHp6JfTYddeqVmHClyuJP
	 rT9VK3BPzHmCK6ABJXzAPD+/h8KoIq+XxfAe4uaPoE007qjlfzVpZiWwK6lMJaaveOgxA
	 yh0TSBY+bndnd0vWghpKl8E/qJiGN0tcoi06btRw79jP74WQP+2YCfBYCMdV33F8IIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UDWBNWL1;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB83606A325
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB83606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UDWBNWL1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F5541477;
	Wed, 18 Nov 2026 09:59:16 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA8493FA7A;
	Wed, 18 Nov 2026 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024759; bh=osGrLTG+wTWwCZXbgV0cH1lOH7Nt5lHAjlM6498QZbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UDWBNWL1hfLJUVhRR69dd2vCCowM9bq8Ovv0zCqiSIxRWEXGLT1L+tKkzgnUGkyzu
	 NYNu37mB4yfGggMADOkWkeKJBfEFyZ40NksiRPexd7pjrw3fJ5UTyQk/GCmgy8pLC2
	 nKf0ZoKukgrHDv332KUVRxVG8LpNZILUeulJwmEA=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 18/23] arm64: Expose the GICv5 irqchip option
Date: Wed, 18 Nov 2026 17:57:50 +0000
Message-Id: <20261118175755.1946977-19-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118175755.1946977-1-sascha.bischoff@arm.com>
References: <20261118175755.1946977-1-sascha.bischoff@arm.com>
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
index e5a26252..63e0b979 100644
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

