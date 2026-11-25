Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619698;
	b=MqcSuvM8UDLENVj7GsCXeQ0npbjD2wLXfagiu+7NwCTgcLgO662nJxqMw4uRwgWdii8O
	 Y5GP+QwA9SwiQG/DaHdDm8S+Bmyyaw/16Bf49/uXYfiePE7ikKDxRazUjUho1k5kX15rR
	 hwdNSCQS2RGHww3fC9FU9dSwBpiGkAhxnTMjLrmjE7hB9GpfoB2KSOclrSBpx/MKpaE2W
	 qWa8+5cdKbZjbWkOLTumU2xNyMayuI88szdZsfrYrLCsjFJrMMUxDRSQBZA3JTMecKqY3
	 GS2LAGkmdxzEKg04AA1E/5pbgAo8oQbk7ZZ6bBA9PxnpUwlUZLfPyLavOd0KiSTzfYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619698;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0Vh6qjgrB4qBHSHWwGeEBUR8LutRinekpz7r78CiFis=;
	b=NnPd8kHLzeJrjOPm1Dm/i2N1kO9luHIfsnBu6OGX5Cr9BaouCkfHZ9y6LRlfjnD8a7Pr
	 5jUI8qymMf2mNDwvpkIgawHfqIx6ARuBoDikcAFllJjEKgniywsqjgh3CVKXoztJDKPy6
	 Uc6IkvTQZ4YA3B+22Lal+k49HVpPUdR0JY/Y1GedifQhjhvB+QR/CqqDbyUHlBuX/RuWd
	 JTWmPnTz2jrpbyyshQnTopJs3IILVSzjtIrfrmKN8fIQNkQs5UqR8cusd99nf8LHwqA1p
	 9xwvVEIpewoQcKsL3H3jnlyugyUmUv3GS0n+S+m921JHvPGkNBKAC3FE0LaN1V/I0sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="X/pQoZZy";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81F0606A32A
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B81F0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X/pQoZZy
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 669D5175A;
	Wed, 25 Nov 2026 07:14:54 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 180073F86F;
	Wed, 25 Nov 2026 07:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619697; bh=Xmglt/Yg6C5I/Cs+laJXteXwqEDtO4aitLEy1M2ooSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/pQoZZyOrlIaA6lHkGBBnL8bmeP2hS9qU8VDN8R4xtybiTLNU97He1q3bfIf/zgS
	 DaKttBZdPuIp0HEmgHwip3y37NTxUSgMGw6D9y1LAsz0J1erbsSDZHIBhsrN6G+WAO
	 hGdGvSy6+pqCa2sMD4AXjImHwreQvHrSa80DPk1w=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 14/23] arm64: Describe the GICv5 CPU interface in the DT
Date: Wed, 25 Nov 2026 15:13:47 +0000
Message-Id: <20261125151356.2875108-15-sascha.bischoff@arm.com>
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

