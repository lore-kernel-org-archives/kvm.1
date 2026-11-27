Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799005;
	b=XFJqm/R83urbbE/V/JjmCktKDSHoi3l3L0+sIUEVzrlPL0WTbgd5Vqbx+h+DWF9iu+f6
	 kP6QhZycvxa6QootvULyJNL+l4w8f24aZrSf0l7AJrN3RjFB5aSYdMmwDkALQkNuNx5fr
	 NQuYLOLysBHilZpxmW3E7Ll1BfXyjuY03ezpWmUM8bB45ctopwEgg/g125baulNVG6djd
	 aN7Chr2IlwcH/Pe/jqXaPsXtVCfDEvn7A/kv5dugTiJC/x1uZIwHKuqQ12SmJaPXjUiAZ
	 87gk8dHjE9QW5qDi6ilYZbGCcGYLNr2PLJad2fbPeU6668TdjQPnyF1ohNHi/Hp35zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799005;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gdBfE6bEts0fvvRXyjQM5soH0cWO8NWZYgy+IW2SU5M=;
	b=0VvIffJrT2uhLUZan/NKAfLtYriQCffs/zAivnkI/PycBI2i2JevhobBex5zLXAT/fsR
	 fB5tlNK01hFcSqtPsMjHit3hHyUQtyfWv6Gq004eeGN/5pAOv8VI5By6Fon6+Nt8f69TW
	 uCDeTj0Wn5M4F17erbCotdNjB4cbpfExdrwHYcdxoOdX4GFDgVIVyBQ8llow5bHZevkS8
	 3EACiNc6qUJR/hZTWs2gh5r6Z51MtCH9UF7ZY0FoOdMDImtADloGvpyAGzq55kF9QrMs9
	 pRfNr9N9lVL2Ar066aFdwc0UqgR6xGOI4jHcbE/UoVwJkYaByC5EN0/lF716E5Kxo7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gZAw5BSz;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF07D606A32A
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF07D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gZAw5BSz
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 851251758;
	Fri, 27 Nov 2026 09:03:21 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D2FF3F632;
	Fri, 27 Nov 2026 09:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795799004; bh=E2cojus6uhZYqsh4kDWK5jCwzJJLVe4rLjYpXm5YWUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZAw5BSzAdm2gLqAO3MNCR25zkBp0Uh23U0nLWJiYxiebaqD1IWcwN4MumrMzTZty
	 65rv/J2bRaXfFccn9Uy/R4ANI17yJTk1teVqOxft0+ZjgvPnKYIFJmpZfyUiatlDNI
	 fQZac4TNaZkjAen5iyNVtxsW7bYhOsru9HjSO/DE=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 23/23] arm64: Expose the GICv5 ITS irqchip option
Date: Fri, 27 Nov 2026 17:01:45 +0000
Message-Id: <20261127170145.4138182-24-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127170145.4138182-1-sascha.bischoff@arm.com>
References: <20261127170145.4138182-1-sascha.bischoff@arm.com>
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
index a1a9336a..15cbd7c4 100644
--- a/arm64/include/kvm/kvm-config-arch.h
+++ b/arm64/include/kvm/kvm-config-arch.h
@@ -54,7 +54,7 @@ int sve_vl_parser(const struct option *opt, const char *arg, int unset);
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

