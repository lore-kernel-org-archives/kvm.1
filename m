Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024780;
	b=KSz5l6izjd9kDNHYtAPbYLNG4IU6mokbx//PSfRBfDssMLjROsva41Zw3e2uKJHhfzzQ
	 GUxjKI6YCil+gOugoAEZd8KKB/hBVYAjBsygetPaP1gQcj6UY9sU/p7sjmZPoZxEVy5J7
	 2gRprNd4QMWXq4HxZ0G2upAPZrsZgYJzYv+WfBrMM62velhMns9dM34LET+2sWHZ63sON
	 V6kPzvRawTVw4t0ctvys/bUD8JMz6cVBymAcWL+4olaSplu0/wyQJB7DZbqCY5ypCDGpP
	 AR0eltLzZZsViLbUUs8IxaqhhYbKfy7nTgMGQNljtpEZUWM2PcmzRWE7wgU9LYPkpSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024780;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FGWOfYwVcmMVR/wlYDFuHY+4Vl32fUFqmZceclAp0Fs=;
	b=ir1zBFl4nSjte4tWtMwB7/9NdxfRHT6L4xoJnBUivWA549DRz/qPRoVFM7cxLqCaQKrA
	 Cjn/Qd7/fTwHoLQG9k+EizBTfTdyblV+0ZJBWj/VtqOl1P3aJiG8JPKGgjqqQpEs1uWRl
	 UqxVosV20+tyw1X6iIu57KVSDlVnfjzSvpAsvlERkrkkI4D6ntTpd/LY5L1MPenqRZmpZ
	 ImgzFX0afTkdRBu6iVOLWFsOznlfAqBuK4iVfCw0YP9MTZfxBCFWiKyXXEw9tMvuLJMSZ
	 CKJojYmaW+HTS4hMssrhSFM/2fuzYu+lA22rubU+8eHnd5CiwgwJny3XRK0YgfcfjoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o3wPS081;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EBA606A32A
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4EBA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o3wPS081
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58E5F1596;
	Wed, 18 Nov 2026 09:59:36 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3642C3F632;
	Wed, 18 Nov 2026 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024779; bh=ZzySrxLCRitFJJvJhs98l8CuQeyaY78BvXRM1jH99/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3wPS081Z0jerLCLK7t6nCXeg3J1lDrUHAMvAqFgY3H7aVh/8kkFnhJxC0NQSF94y
	 6EfYKzFUsiD5LFkaXPFPITxII/qyZfeeFrdKtYgU6zghwP03coM1KOvRW3wDs7bp5K
	 9cae4+IkvD6lmlf/Z+7rU0jmc25PnxLGnBmFSyS4=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 23/23] arm64: Expose the GICv5 ITS irqchip option
Date: Wed, 18 Nov 2026 17:57:55 +0000
Message-Id: <20261118175755.1946977-24-sascha.bischoff@arm.com>
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

Allow --irqchip=gicv5-its now that the ITS DT nodes and PCI MSI
requester mapping are in place. Start automatic irqchip selection at
GICv5 ITS so it is preferred ahead of base GICv5 and older models.

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c                         | 4 +++-
 arm64/include/kvm/kvm-config-arch.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arm64/gic.c b/arm64/gic.c
index 1f837049..774a503b 100644
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

