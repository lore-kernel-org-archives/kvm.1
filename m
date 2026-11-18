Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024776;
	b=e94OcxjNTY62MtR5jyH0vuwKedviSvA/g7JDgzAHJP4x0YHyU9fYw76G5FauyWBHWyrG
	 ePWiz6kqRU8Xg9+pucYD8hQ+4lJPUAHVauqqEsaEU/tF5IWuX2SJbVduRFMKGAwCyVjkk
	 pWQFLDXluuACJp9XgIdNfWAHm4dHpQ/x9rF+wygVkaj8PZnii7vegfht3aRBYvpFKQBkA
	 sCV/yrCsIPqM5iC2a+p9Xi5Aovyj35sj7padLUqvCl8DO1qv7A7O+YDXgge9UZC58tTf0
	 6O3Dvh7we/HgDh7lrPD+8uDnGEf0Y/R5oLVSTwNBtxvt7DFeo2ztiFhH19nK9f15kUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024776;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dhzjtWTxxx9gvHbB3whTNi+6jXCnSVNDnthokQ96IA0=;
	b=2RlV+6CzCAMsWDouJWS7tjRPEr3agEUmCFbi6ij2KbNJ5RM23BAKM5fnoxfMXLijLZ7R
	 UlWHzvll/CkVPUSm9Mz2zGWwNmTgzJb5O6ql2Yjtyq6SqvXzivn3w4tgYBdVnDVA1uOxN
	 rAR8AUN6FXhcIAAuG2ZTLsxWAIXC3vEOjIbWvTjtFIaZokQ1HqmP2lyZ7gQNaFpk6Ariv
	 03lF488p8Ub7/e4s+H7j1JYbk4/cKF5Iw4NddSle6NnAbKnyMHd1ezMU/ncPGN3hfEP3L
	 UySJEON2Z3idXLZldwWZLkf+MGxGaPWxHkQUOE/nsWtQa2YLOtd2cDzwKmeMN3fJ19g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o3QIFpHd;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000D860A2605
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 000D860A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o3QIFpHd
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 920A91477;
	Wed, 18 Nov 2026 09:59:32 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D3033F632;
	Wed, 18 Nov 2026 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024775; bh=OLvCS+iyUFh+thOl0UyrUKBrAlAejhgQMAiPWRtb0fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3QIFpHdYSYG96evuqkTx7pqDqnr9Bdab5he5ZIqEJJwRmGOljMBfImS6A0ZbaLIL
	 2ni36AKMH/O9AfpgMScwlkRjip4JtRq7jnpaMSis8dqLl2RibJD+PYg0WbPpCfTzbA
	 TSTwgHKihnvV6a01cY0189MON83yJOIMtaFtV6hU=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 22/23] arm64: Map PCI MSI requester IDs to the GICv5 ITS
Date: Wed, 18 Nov 2026 17:57:54 +0000
Message-Id: <20261118175755.1946977-23-sascha.bischoff@arm.com>
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

