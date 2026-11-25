Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619656;
	b=3dYwEADS4G9CYotG4MiUHt8DuWOV0XW2niLl0l2imAya7QUpo3KLai496wagTnHAguYE
	 F2UeKFLO734HDSXh/B5n3AC+bhc2jl4E4Q2l+p1pDtF9TyFiUC3LT3OMEW3OXPVsP2dU3
	 SlCRc7as21jbXaSVQ3TxCeHa418S1HDaQjNQM0BHwgGndlHP/7LbKbasXqiD41JiT1O05
	 Q0QvlRlgpmm6EsbAr3Q6FefaTuL9D+cxjUYDczPXMH95L0/IVoqWraWj5C3XBU4W9c31h
	 z4qyatynHCGZZlZx5A3teW8k7LWOng3jIkICt6SFo/gS4ArCzlvFAIeIp/8gQxjgHoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619656;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WtaFrv8PSZX39CqiTLLDCf+5RiYRLHF4YcowUaq983I=;
	b=aIvO51Yyu/usNOCDzsQ+xS57tIUyEFFsp+wAY/1ZpWVIgW2lY0JB7iNLQXNSzzGnsC+R
	 iFSsuEdUGyTJdx6434NLbfnyh7UogXoUaM1S6fS1x4wkYNACbEhdPXb/c9W3aQU1ngDvA
	 pAh6PdYa/9IgyuUXNjQyLE94fF556kKrzs9vfjSHfpUjOj14zL7SsS7crnGo+5vANMMAY
	 mZ42xPTJNddJonP6wqiKkdmfBbVOVJC3+khays35CRdisuRJMH826kb9/peldeLM79EsG
	 j8R6DPAK6Ylwk1heAqhz3CvDGxCsJ0N9eggqc3C5P9PhKMHEHr5e+6gT9WzGJ4bKA2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HMCDnpGZ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23690606A329
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23690606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HMCDnpGZ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B85A52F;
	Wed, 25 Nov 2026 07:14:11 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79B553F86F;
	Wed, 25 Nov 2026 07:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619654; bh=p/U5tQIycTvuu13q2oqzYuw0WeSLjZ+OrZCPmWGuZEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMCDnpGZhVAaExa+yTLL4hgV7ZVyzqBHWoGWLwTcnTIQ+RO3eSUUA/ZeEs8Vr8Y4r
	 EY4BzYB+n4BIQu5dfTWne8gyXgFKH8GKV9hVXgHLPmUp1zs+uwM1sYbTZsTChLyN1w
	 oDYstcnihPeZLpdsJgf3uzEf19JTQAwxPWC3etAM=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 03/23] arm64: Split GIC device setup
Date: Wed, 25 Nov 2026 15:13:36 +0000
Message-Id: <20261125151356.2875108-4-sascha.bischoff@arm.com>
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

Separate the CPU interface, redistributor and distributor address setup
from GIC device creation. Keep the per-GIC address handling in small
helpers.

Have the existing MSI frame helper use the global MSI base instead of
passing it as an argument.

Use the irqchip enum order to omit the GICv2 PPI CPU mask for GICv3
and later generations.

Suggested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c | 94 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 32 deletions(-)

diff --git a/arm64/gic.c b/arm64/gic.c
index f8371f50..57f3fa02 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -142,52 +142,90 @@ out_close:
 	return err;
 }
 
-static int gic__create_msi_frame(struct kvm *kvm, enum irqchip_type type,
-				 u64 msi_frame_addr)
+static int gic__create_msi_frame(struct kvm *kvm, enum irqchip_type type)
 {
 	switch (type) {
 	case IRQCHIP_GICV2M:
-		return gic__create_gicv2m_frame(kvm, msi_frame_addr);
+		return gic__create_gicv2m_frame(kvm, gic_msi_base);
 	case IRQCHIP_GICV3_ITS:
-		return gic__create_its_frame(kvm, msi_frame_addr);
+		return gic__create_its_frame(kvm, gic_msi_base);
 	default:	/* No MSI frame needed */
 		return 0;
 	}
 }
 
-static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
+static int gic__set_cpu_if(enum irqchip_type type)
 {
-	int err;
 	u64 cpu_if_addr = ARM_GIC_CPUI_BASE;
-	u64 dist_addr = ARM_GIC_DIST_BASE;
-	struct kvm_create_device gic_device = {
-		.flags	= 0,
-	};
 	struct kvm_device_attr cpu_if_attr = {
 		.group	= KVM_DEV_ARM_VGIC_GRP_ADDR,
 		.attr	= KVM_VGIC_V2_ADDR_TYPE_CPU,
 		.addr	= (u64)(unsigned long)&cpu_if_addr,
 	};
-	struct kvm_device_attr dist_attr = {
-		.group	= KVM_DEV_ARM_VGIC_GRP_ADDR,
-		.addr	= (u64)(unsigned long)&dist_addr,
-	};
+
+	switch (type) {
+	case IRQCHIP_GICV2M:
+	case IRQCHIP_GICV2:
+		return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &cpu_if_attr);
+	default:	/* No CPU interface needed */
+		return 0;
+	}
+}
+
+static int gic__set_redist(enum irqchip_type type)
+{
 	struct kvm_device_attr redist_attr = {
 		.group	= KVM_DEV_ARM_VGIC_GRP_ADDR,
 		.attr	= KVM_VGIC_V3_ADDR_TYPE_REDIST,
 		.addr	= (u64)(unsigned long)&gic_redists_base,
 	};
 
+	switch (type) {
+	case IRQCHIP_GICV3:
+	case IRQCHIP_GICV3_ITS:
+		return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &redist_attr);
+	default:	/* No redistributor needed */
+		return 0;
+	}
+}
+
+static int gic__set_dist(enum irqchip_type type)
+{
+	u64 dist_addr = ARM_GIC_DIST_BASE;
+	struct kvm_device_attr dist_attr = {
+		.group	= KVM_DEV_ARM_VGIC_GRP_ADDR,
+		.addr	= (u64)(unsigned long)&dist_addr,
+	};
+
+	switch (type) {
+	case IRQCHIP_GICV2M:
+	case IRQCHIP_GICV2:
+		dist_attr.attr = KVM_VGIC_V2_ADDR_TYPE_DIST;
+		return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
+	case IRQCHIP_GICV3:
+	case IRQCHIP_GICV3_ITS:
+		dist_attr.attr = KVM_VGIC_V3_ADDR_TYPE_DIST;
+		return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
+	default:	/* No distributor needed */
+		return 0;
+	}
+}
+
+static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
+{
+	int err;
+	struct kvm_create_device gic_device = {
+		.flags	= 0,
+	};
+
 	switch (type) {
 	case IRQCHIP_GICV2M:
 	case IRQCHIP_GICV2:
 		gic_device.type = KVM_DEV_TYPE_ARM_VGIC_V2;
-		dist_attr.attr  = KVM_VGIC_V2_ADDR_TYPE_DIST;
 		break;
 	case IRQCHIP_GICV3:
 	case IRQCHIP_GICV3_ITS:
 		gic_device.type = KVM_DEV_TYPE_ARM_VGIC_V3;
-		dist_attr.attr  = KVM_VGIC_V3_ADDR_TYPE_DIST;
 		break;
 	case IRQCHIP_AUTO:
 		return -ENODEV;
@@ -199,26 +237,19 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
 
 	gic_fd = gic_device.fd;
 
-	switch (type) {
-	case IRQCHIP_GICV2M:
-	case IRQCHIP_GICV2:
-		err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &cpu_if_attr);
-		break;
-	case IRQCHIP_GICV3_ITS:
-	case IRQCHIP_GICV3:
-		err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &redist_attr);
-		break;
-	case IRQCHIP_AUTO:
-		return -ENODEV;
-	}
+	err = gic__set_cpu_if(type);
+	if (err)
+		goto out_err;
+
+	err = gic__set_redist(type);
 	if (err)
 		goto out_err;
 
-	err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
+	err = gic__set_dist(type);
 	if (err)
 		goto out_err;
 
-	err = gic__create_msi_frame(kvm, type, gic_msi_base);
+	err = gic__create_msi_frame(kvm, type);
 	if (err)
 		goto out_err;
 
@@ -439,8 +470,7 @@ void gic__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 u32 gic__get_fdt_irq_cpumask(struct kvm *kvm)
 {
 	/* Only for GICv2 */
-	if (kvm->cfg.arch.irqchip == IRQCHIP_GICV3 ||
-	    kvm->cfg.arch.irqchip == IRQCHIP_GICV3_ITS)
+	if (kvm->cfg.arch.irqchip >= IRQCHIP_GICV3)
 		return 0;
 
 	if (kvm->nrcpus > 8)
-- 
2.34.1

