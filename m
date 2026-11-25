Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619729;
	b=gZi/aRW5tnxqQ408a6fXJLMmQWp1Eia4th/USJDq1Eb9BGk4h0BsMH35Fg1BFjWRS2d+
	 JKvVxzry9/+CnEviUUXzZFKLkX0ioNyTYyjw5etRiu3dbC3BWGX7mBm4r7i99Kex/7K/a
	 ygA+VkZgDSSbiD7azQ8NK15huHKhKAVCZDXzhDt4eAyAJvPPgZDwzOLZt9N+qV0dAJ3uq
	 Gtvf+kQS7l7RFys+A7vqjrWE8Sq7dKQm+f2sthCKu+t9xkf8uNR5CrN/D31clQN6hg8J9
	 Vjj7S3f5MpSHFotW2y9Y7LbSZmYJdhMgCXv+yGZh/sUioIKi24cx6/TWLC3ufAZrxGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619729;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dhzjtWTxxx9gvHbB3whTNi+6jXCnSVNDnthokQ96IA0=;
	b=ytBq2XqZoCR2CgMNyGuHgXSZINKnfHH+dMmmQn6WiTjNaowytrFW/IWL8h0ULQgux/2H
	 qex66bjaRLO2ybX3Uo+acsuMCshoHz71jhVDe0ZdC5R0squDuDMYdMPTGpAiq2GH2Vdiw
	 kUgFFzayFzdd0YTgB838Vh6FMNXaeQhuzzFADm9btLagyP5eHepUrTi+LiW4Bx8dr3J7D
	 Ae5WKOuAb+1PkQsxnlZlBraYr3V44OzyrDS5vHt/0aCNIUv/2iHsj/Hc4W/6ayjJVbPZL
	 yN+uN+Gmrc6uHyrdO1l9DQjwbYb7Yh1dBCMjVGYw+6pOPS/WAbov7qD1L9oxOyQZgiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EmBf71BV;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51FE606A32C
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51FE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EmBf71BV
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55C622F;
	Wed, 25 Nov 2026 07:15:25 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 157613F86F;
	Wed, 25 Nov 2026 07:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619728; bh=OLvCS+iyUFh+thOl0UyrUKBrAlAejhgQMAiPWRtb0fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmBf71BVwfFVSl1VGX376q/MgR+fNMgY/yXxEKJLS0NIdnISUhToSzK5LkPR/r1tX
	 TwWcNCM+jAv94BWZEpH395V+V1yreCh0sGvjN/YwFjSVcadGo4UpnPdDDYJ0NQC4bk
	 nX5LOh4wX4OBzmTA1qNaMtvp5gpoMd/9bnFqUV9A=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 22/23] arm64: Map PCI MSI requester IDs to the GICv5 ITS
Date: Wed, 25 Nov 2026 15:13:55 +0000
Message-Id: <20261125151356.2875108-23-sascha.bischoff@arm.com>
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

The GICv5 ITS MSI controller requires one MSI cell carrying the
DeviceID. Describe an identity mapping from the 16-bit PCI requester
ID to the ITS DeviceID with msi-map. Keep the existing msi-parent
property for GICv2m and GICv3 ITS.

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/pci.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arm64/pci.c b/arm64/pci.c
index 91265f67..69e180b5 100644
--- a/arm64/pci.c
+++ b/arm64/pci.c
@@ -32,6 +32,12 @@ void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 	unsigned nentries = 0;
 	/* Bus range */
 	u32 bus_range[] = { cpu_to_fdt32(0), cpu_to_fdt32(0), };
+	u32 msi_map[] = {
+		cpu_to_fdt32(0),
+		cpu_to_fdt32(PHANDLE_MSI),
+		cpu_to_fdt32(0),
+		cpu_to_fdt32(0x10000),
+	};
 	/* Configuration Space */
 	u64 cfg_reg_prop[] = { cpu_to_fdt64(KVM_PCI_CFG_AREA),
 			       cpu_to_fdt64(ARM_PCI_CFG_SIZE), };
@@ -70,8 +76,18 @@ void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 	_FDT(fdt_property(fdt, "reg", &cfg_reg_prop, sizeof(cfg_reg_prop)));
 	_FDT(fdt_property(fdt, "ranges", ranges, sizeof(ranges)));
 
-	if (irqchip == IRQCHIP_GICV2M || irqchip == IRQCHIP_GICV3_ITS)
+	switch (irqchip) {
+	case IRQCHIP_GICV2M:
+	case IRQCHIP_GICV3_ITS:
 		_FDT(fdt_property_cell(fdt, "msi-parent", PHANDLE_MSI));
+		break;
+	case IRQCHIP_GICV5_ITS:
+		_FDT(fdt_property(fdt, "msi-map", msi_map, sizeof(msi_map)));
+		break;
+	default:
+		/* No MSI */
+		break;
+	}
 
 	generate_dma_region_prop(fdt);
 
-- 
2.34.1

