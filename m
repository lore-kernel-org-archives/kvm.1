Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6D44EC648
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165213; cv=none; b=otb8sz7WopIaCBlmkFdGc4W7uyklxoeqC0J7TsHpHSUQgb6XD+km0e9Egdz3fX05kHtMq++rdGVklEu4vHzY2MJm13rHG/gZknqaAfBOIjWp7v4qUywNSHmlZRnQEL1BW+QZk+R2nIgHkL/vK3UqYIF1IL9FEvvY4sHVWAA2/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165213; c=relaxed/simple;
	bh=ncTc6KLO8zGDhaFbVnfipdXOS4dgxQy9ymmaxlP8a+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eMQfOFAAicYnZaKx5kXbkkTXF7EY8mrIM7ShD1Amkxo9F3tORVcB/EpW0E8/B8PNaQR0eyh6OJKcQ1muSeli7DMF2xxyPjEbZ+DyW56zDrjg9An1OGJ9auhCIozlXLGhsUkFDRXGp12abI69LhHlZDPvvLm8GpsJcWjHq7QYOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WGNw4qOd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WGNw4qOd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AA261691;
	Fri, 16 Oct 2026 08:40:08 -0700 (PDT)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBCFE3F8C6;
	Fri, 16 Oct 2026 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792165211; bh=ncTc6KLO8zGDhaFbVnfipdXOS4dgxQy9ymmaxlP8a+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGNw4qOdI1A+NrkbYxtineC8Tg4nhCIb1JxqdCJEORWk0/PRZBRs26aVL4Nfpl9I6
	 qjYD/D6UDQQf+V2ojL6nRFw8k5OTkG/AQ1BaYe+pRkJh2l+IlJDWm+1s2uhg0G4XLW
	 ixFIiBdCWqRfCIbcisa79Sr6rIhCBSdmQ+iSEgBA=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v3 03/21] arm64: Sync KVM UAPI headers for GICv5 IRS
Date: Fri, 16 Oct 2026 16:39:21 +0100
Message-Id: <20261016153939.913764-4-sascha.bischoff@arm.com>
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

Copy the GICv5 IRS address type and size, the IRS register attribute
group, and the IST attribute and descriptor from the Linux headers.

Keep the ITS UAPI out of this sync so the base GICv5 support uses
only the IRS definitions already present in Linux.

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/include/asm/kvm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arm64/include/asm/kvm.h b/arm64/include/asm/kvm.h
index 1c13bfa2..9998252e 100644
--- a/arm64/include/asm/kvm.h
+++ b/arm64/include/asm/kvm.h
@@ -97,6 +97,11 @@ struct kvm_regs {
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
 #define KVM_VGIC_V3_ITS_SIZE		(2 * SZ_64K)
 
+/* Supported VGICv5 address types  */
+#define KVM_VGIC_V5_ADDR_TYPE_IRS	6
+
+#define KVM_VGIC_V5_IRS_SIZE		(2 * SZ_64K)
+
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
@@ -417,6 +422,16 @@ enum {
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
 #define KVM_DEV_ARM_VGIC_GRP_ITS_REGS 8
 #define KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ  9
+#define KVM_DEV_ARM_VGIC_GRP_IRS_REGS	10
+#define KVM_DEV_ARM_VGIC_GRP_IST	11
+
+struct kvm_vgic_v5_ist {
+	__u64	spi_ist_addr;
+	__u64	spi_ist_size;
+	__u64	lpi_ist_addr;
+	__u64	lpi_ist_size;
+};
+
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
-- 
2.34.1

