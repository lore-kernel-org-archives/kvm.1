Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024744;
	b=HPiwNAZF4nZ0XCNY0KGMDRhVc5O4GB4pUBCXJDcMRVDu9UnGKGoCj1Pbm6lA2BQQNSdn
	 ZPK1T3DEye4Ga6R8FXFMExDPej1bxAO7nnNmELnKBw2adjcOe1a5OfB1ShdqERaqBWa15
	 KShpVOq6Tnq0NcntPxgBxUhIkDgFebmY/UACUwaQQuHze/duDi3+BJoDxCHAlfptog3vL
	 j8v9ejCo9NlEcLFiZg8UtsXbTMuU3I5TZkdD0MmscELsF37e7NoE+2q+D8RY0hn1Hzj73
	 CdG4+NOdTo+GgFe76Tx0Blt+YtKsyGfnRJR2nAN2S2mxylbSBpBfKXONgvak+NV1s4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024744;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0Vh6qjgrB4qBHSHWwGeEBUR8LutRinekpz7r78CiFis=;
	b=bjT4iWZGhn7795uP6Xk/NUoOSU0PIMXUX8F6ZPhqagjz8bZTrQ7kluhCtvsPRVqF7JZQ
	 VPsqP7L5LWVvpjU14P/75NtOT4k5oKyXnGz5JJKZOxKX95UbNCQPccYSb5tTtNyxQ0XVz
	 Ed+t7VayvrNp6E8JBRzeCQCIb11poptcHZBMH26PWwkC1uMHLqlU23rJ/adMOGTqM2fzq
	 MztcCsjP2z/Z3JQXespNAUY0VUbZllJreNAx5//1md5TsV9Jkle7Duxhz814nu70fXcL8
	 4eLluqQV2Q2TP6F8WfI2VG2mpUrxu8fbBq+JO22NCS7smpexCj5chIf+k2GNGoA5Dug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=m8yrUsBy;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3985F606A335
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3985F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=m8yrUsBy
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C59501477;
	Wed, 18 Nov 2026 09:58:59 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E2CF3F632;
	Wed, 18 Nov 2026 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024742; bh=Xmglt/Yg6C5I/Cs+laJXteXwqEDtO4aitLEy1M2ooSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8yrUsByMiGAalk96jFprcdT8S+iSZf2mCUdWWgjGT0+5jFNSXioMJh/RlAuBc0uv
	 Zu1qbe4/jzlf8JAGEq85z71PhJilF8nBvXy2m4xMtkdprY+f1WSATfeIhZ0BkrztpE
	 QakVEsGGwPFdiuevwmhh3UT7W9lECtm3d0ygdcPs=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 14/23] arm64: Describe the GICv5 CPU interface in the DT
Date: Wed, 18 Nov 2026 17:57:46 +0000
Message-Id: <20261118175755.1946977-15-sascha.bischoff@arm.com>
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

Emit an interrupt-controller node for the GICv5 CPU interface. This
provides the interrupt parent and allows guests to use PPIs.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arm64/gic.c b/arm64/gic.c
index 83b034e3..9a8f9916 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -519,6 +519,8 @@ static int gic__init_gic(struct kvm *kvm)
 }
 late_init(gic__init_gic)
 
+static void gic__generate_gicv5_fdt_nodes(void *fdt, struct kvm *kvm);
+
 void gic__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	const char *compatible, *msi_compatible = NULL;
@@ -549,6 +551,8 @@ void gic__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 		reg_prop[2] = cpu_to_fdt64(gic_redists_base);
 		reg_prop[3] = cpu_to_fdt64(gic_redists_size);
 		break;
+	case IRQCHIP_GICV5:
+		return gic__generate_gicv5_fdt_nodes(fdt, kvm);
 	default:
 		return;
 	}
@@ -582,6 +586,22 @@ void gic__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 	_FDT(fdt_end_node(fdt));
 }
 
+static void gic__generate_gicv5_fdt_nodes(void *fdt, struct kvm *kvm)
+{
+	_FDT(fdt_begin_node(fdt, "gicv5-cpuif"));
+	_FDT(fdt_property_string(fdt, "compatible", "arm,gic-v5"));
+	_FDT(fdt_property_cell(fdt, "#interrupt-cells", GIC_FDT_IRQ_NUM_CELLS));
+	_FDT(fdt_property(fdt, "interrupt-controller", NULL, 0));
+	_FDT(fdt_property_cell(fdt, "#address-cells", 2));
+	_FDT(fdt_property_cell(fdt, "#size-cells", 2));
+	_FDT(fdt_property(fdt, "ranges", NULL, 0));
+
+	/* Use a hard-coded phandle for the GIC to help wire things up */
+	_FDT(fdt_property_cell(fdt, "phandle", PHANDLE_GIC));
+
+	_FDT(fdt_end_node(fdt));
+}
+
 u32 gic__get_fdt_irq_cpumask(struct kvm *kvm)
 {
 	/* Only for GICv2 */
-- 
2.34.1

