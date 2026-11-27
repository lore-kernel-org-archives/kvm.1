Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798985;
	b=NOTPvY3K5Voun03p38r5wiW+K2WyOG/5PwxmvwlwU8gD3DAdTNevarKX1e0crGG8cHcD
	 7QhPQnAr87jXSrjQKpSBHsLt4hymJFMzu+FF7GVOVVcjH3AYI9qevPKiGYBDVZZjqDewC
	 Lad+h0s1U/92iroviPsPtxjsSHngCeLg3f1Vob9GsEJB3BjxONv2AsSXAojHetYLP3rsk
	 VbwuxwxHsDbaKO3PGyhNWCnG2bCKADIJhmfEDOPMJSYdjB0+Uz9w1YzbfJoPQtcg1/vjq
	 s07YUA5MyItKmID/br34kYWDCtESaFaIJ+w4wAO0AJPKEQsdBTLgFOo23qGLR0BfIVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798985;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kXcNf23EjeX82tKtPOKqKsn322nY30E+/ZXjQHE1EAo=;
	b=yw61wmHW0ZKs+4tRXX4NHqXPzJdK5sr1jLO9w59/E3y15/lpR9YZ4//5bA+dw4e+NQiz
	 uYNN5sI3wtC7z+W9eGXnpskdWLbfMtQmPoYz8DIVRzR7xPSyzT5ICUx09GjbmKj84EL/6
	 jDadcJIwjHkM3Wr4nm4FWIaj1WAE8CizTjazF2VXEjSh3nLn3tCXksWp++80/gEXlQx4k
	 bwbiS2wtJNONzp7Wl9LjnVDhOT3YRzQZ/9Ud1zkA7UIQpU3xiHtTWT42QtdMt4hkj+Oje
	 UBeyuu1uUQmgGJt1NftpAU3bTiwgTdGgRUU3l6FqN+U9Pg5edecNaOAbAzeK81ymMPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=boN4GZFu;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30BD606A31C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E30BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=boN4GZFu
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D5DC1DB5;
	Fri, 27 Nov 2026 09:03:01 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CF283F632;
	Fri, 27 Nov 2026 09:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798984; bh=NjA+aNj+OPFvHEV2Ek7m+cEitX7CdVkRKvWWOhubcw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=boN4GZFuD0FsplCrF9tL5kb9cvkyi5cq6lYSHZJp2KmYKDbU7RxB0GhElf0WeitkA
	 w4pz8X56ykQi1Zir3cZR9LNQZx48VVAPrzHTTW/XP7BZjiw4eVZAahXLC54k4nmYeV
	 4iGVlEZNmMLUfHt/jw1Mi06xRn4IFeMoTVKguY+4=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 18/23] arm64: Expose the GICv5 irqchip option
Date: Fri, 27 Nov 2026 17:01:40 +0000
Message-Id: <20261127170145.4138182-19-sascha.bischoff@arm.com>
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
index adda6403..a1a9336a 100644
--- a/arm64/include/kvm/kvm-config-arch.h
+++ b/arm64/include/kvm/kvm-config-arch.h
@@ -54,7 +54,7 @@ int sve_vl_parser(const struct option *opt, const char *arg, int unset);
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

