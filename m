Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB8D51D52B
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165352; cv=none; b=NFsRfwW2lQYpKUGd+yisws8LaAm7fV3RpO6Zcde0vArq04MlEWxL+SJYiOYewSYlEB2lakSrFjS7Oi/XE90TTDwTxm7gnoW+26XPFqNTV0SoYT61wBUv9HP6fIhuwQFoLDqwz+e7FjxaQ+6ggfSFY7u/NY963hrl8I4iO+Wx/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165352; c=relaxed/simple;
	bh=6H/GmcTM2gznqSjS9q/ntzsZTRPIZWmmEDFSYFqUZrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sb/gRcfyZTA8ell6dQSdufsIOodxwkE8KBi1ugiPBQ/IOSzFgquUgpXZtNUF10WBmDY3ioqY8Cpwplue+r2aAj79ZZ/8od+sKYt+6cFmL2TQZkd8Lf9mRf5oq6eMmluCvKhuTl6jXtweABwf3i2BQmtQ2A3fE+8Fc1wPazMvOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=u4siVot7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="u4siVot7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB472143D;
	Fri, 16 Oct 2026 08:42:24 -0700 (PDT)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3EF63F673;
	Fri, 16 Oct 2026 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792165347; bh=6H/GmcTM2gznqSjS9q/ntzsZTRPIZWmmEDFSYFqUZrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4siVot79hdylRlV1ud0xN7BopPOK87RivWWK8EiFv1HwDBbgIwMv3wL3EZQP1ulD
	 nK1wsVUwrpKqu8tP6OJuOwc33okVcNIIoQMz2LIun6se7X/Y6cqGqdwZYLnXjQ4TZT
	 hVGZRsllOGmdcC4DtCBP4MLkOwAmPxTJFstvq0qE=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v3 20/21] arm64: Map PCI MSI requester IDs to the GICv5 ITS
Date: Fri, 16 Oct 2026 16:39:38 +0100
Message-Id: <20261016153939.913764-21-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016153939.913764-1-sascha.bischoff@arm.com>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GICv5 ITS MSI controller requires one MSI cell carrying the
DeviceID. Describe an identity mapping from the 16-bit PCI requester
ID to the ITS DeviceID with msi-map. Keep the existing msi-parent
property for GICv2m and GICv3 ITS.

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/pci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arm64/pci.c b/arm64/pci.c
index 0ba2f9c9..912165ef 100644
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
@@ -70,7 +76,9 @@ void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 	_FDT(fdt_property(fdt, "reg", &cfg_reg_prop, sizeof(cfg_reg_prop)));
 	_FDT(fdt_property(fdt, "ranges", ranges, sizeof(ranges)));
 
-	if (irqchip == IRQCHIP_GICV2M || irqchip == IRQCHIP_GICV3_ITS)
+	if (irqchip == IRQCHIP_GICV5_ITS)
+		_FDT(fdt_property(fdt, "msi-map", msi_map, sizeof(msi_map)));
+	else if (irqchip == IRQCHIP_GICV2M || irqchip == IRQCHIP_GICV3_ITS)
 		_FDT(fdt_property_cell(fdt, "msi-parent", PHANDLE_MSI));
 
 	generate_dma_region_prop(fdt);
-- 
2.34.1

