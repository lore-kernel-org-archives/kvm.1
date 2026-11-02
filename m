Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655355;
	b=mQ3v3I8gu5ORT8YmEi4ILkZZ3tcv7jH8lJhCxZ+12WpXE5YlEM4WJ6Mg+ETYlhqP/eKt
	 aG5bGy5bL97dKuUBkiBJpQJSDKWsXm4xolZGQ5C+x6U9ldYWtzI0Zto4/4EsYFn2pahZ9
	 JABMsU5CtdWNBU97JsJS0cmvMpyqXiIhyC9wfTncEykkg0U3oVUrzLTcwOWa/ffRc2bre
	 eQIxtwFTIKVTSGAkM1XhyN4qbNuHSfx/bPytjmDNA+H9La+i/iAeICMMKFxYiV+tmQVmS
	 jaeff897DmD4LwNXRg5rEQmDQWJnUbEeiBJS2KzU4hmT620+QMlO+aNVBhGt/iVZF7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655355;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sc9w89x8N9IYJTR2WUSmznKdiDg2tM+XJf6c7kYafkc=;
	b=mAzTVeFxdkz7q/OzpZC5tV2hY7iAcML4YaW7xEDpFkCVeWrcg75yaBj1cp55poW3ANgQ
	 5vYHYfeSKIxMm1lzqjJISWruVrEFyKUXtcJjY8SjqL5rSxNotPC8oSaIlqxABcxjGN+nF
	 o4LzSl2aUVngRoZfJdofuu9qj3eG70NfHYUYed+GrapVBd0O7UhskzFM6Yk3BbT+CsGku
	 Fa4GHxPLEIW7f3QRddElKGPS/jKb6X3zkQqazt1iqko7dlsnHkLAtAvudQenmDLAzEus7
	 cO0lI83VkWIKv3oN60/TMFccZUdMFxvp3z5k7n0zhx6fpSuAIFe8M2bJ4bCyo3r9cvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TpI0vZjO;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9184560850A6
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9184560850A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TpI0vZjO
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 234021595;
	Mon,  2 Nov 2026 13:35:51 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DC303F673;
	Mon,  2 Nov 2026 13:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793655354; bh=HhkxOhgVtJwpkEfYP9e9RZE1mKFjXW1J2OEReis5kYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpI0vZjO0ieE5yX/A5woLPU6BOV1VAC3Zn7FrtK1/wsCYbUl3iSPDaXmyz6TzLKhc
	 qtKbxzk93Z1WoDR1Zfwo2OOPSeeK+9VvZjTx8d9RXUz1D4SrwzWyiSEkm/RAo2CXhs
	 uGrZKcXd5QYEnQCyAG3H640fJj0+7RGubFhoz4RI=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v4 23/23] arm64: Expose the GICv5 ITS irqchip option
Date: Mon,  2 Nov 2026 21:34:13 +0000
Message-Id: <20261102213413.4136118-24-sascha.bischoff@arm.com>
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

Allow --irqchip=gicv5-its now that the ITS DT nodes and PCI MSI
requester mapping are in place. Start automatic irqchip selection at
GICv5 ITS so it is preferred ahead of base GICv5 and older models.

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c                         | 4 +++-
 arm64/include/kvm/kvm-config-arch.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arm64/gic.c b/arm64/gic.c
index 9a928e23..0a15851f 100644
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
@@ -414,7 +416,7 @@ int gic__create(struct kvm *kvm, enum irqchip_type type)
 
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

