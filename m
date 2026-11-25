Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619663;
	b=S+WvSbAHSM3FwZdmY4BJGykvvSiWmEM+ReqPPVmOz0bJP+M0ofV1HEgrVER9DngmzkdB
	 1CmyuP6DbbyT3Om7TC8WbV7U26VUBC+SlHuC1heZbnToxbUGPJugSRQ0Y4+6yKirYoYny
	 23shuJGyDsFX7yyc/1FleWmVH3zdhOQ35IPXabkg5B666EwpXyOu+40gZWA/dcqZY3fT+
	 rQ5nnVlZJtlV6yRfOAQ8OntSg20NWlg7engkePbyPz77Qr8beWJ9BpiX9DGXx9+u1TSpG
	 URtYkjPBEBXML7xb+bvTM/XBOo7qsB/ZyzJISfN8+uJdkaY70sueooWZAQr1pLqoCQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619663;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KPxJkSXbgNCwMjexUmFruvkO52wS4HWNgIMrUkpFZyw=;
	b=UNmTOwKpEQNxUvsFC8gFGspCFftsfWlB5JfKUzl116+bY0f+uQYagV+kh1WAgE0JaMdS
	 IZGtC67BYWb4MLmy/tm7ypBIvOIFJSAtphvPFVU0b1P3tbXlCPJVXPRCjDorycmHhrn0g
	 9DeGB6YwOuQkh3EBV0PwPQYbf/i8T2TszBdKpApnd/TGqjWexNenAffZHfP7tIyh8RmFp
	 vT7t1eiJ16ciCPCISwBxnGSTTQvGjviotAWhFGAMZvdLM2PbjL/+PZhNsrvz5YaKtCJbe
	 Pwuv3Ko17DZp1ecwe6R/+inigxOVobYxujZ85aFQwg7WX68AIvMmMutaNQFZz99HDSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DMMed954;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C152A606A335
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C152A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DMMed954
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CAFF2F;
	Wed, 25 Nov 2026 07:14:19 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5AD3F86F;
	Wed, 25 Nov 2026 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619662; bh=561lrRLmUiWpxG8SJgos6yK6je/WVLjQyZln4pVPQYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMMed954YUdp/mJbDjKvyc+RSfnXpIehB5AiO0TKoZ5eyeB2cmNAHbIwV1dDMsyva
	 ndrpTBZ0Qa+wuvVQ0KhelqegsSTyPWlc36pCz9TjJguiYpAkcqRwkc89ubKkXZn4sE
	 IkicNozUXoy3L5YI1TxziIJADluyITl++PfTiJ8k=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 05/23] arm64: Add GICv5 irqchip device support
Date: Wed, 25 Nov 2026 15:13:38 +0000
Message-Id: <20261125151356.2875108-6-sascha.bischoff@arm.com>
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

Add IRQCHIP_GICV5 and create KVM_DEV_TYPE_ARM_VGIC_V5 for it. GICv5
has no distributor or redistributor MMIO frame, so omit those address
attributes.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c             | 5 +++++
 arm64/include/kvm/gic.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arm64/gic.c b/arm64/gic.c
index 57f3fa02..51a32159 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -227,6 +227,9 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
 	case IRQCHIP_GICV3_ITS:
 		gic_device.type = KVM_DEV_TYPE_ARM_VGIC_V3;
 		break;
+	case IRQCHIP_GICV5:
+		gic_device.type = KVM_DEV_TYPE_ARM_VGIC_V5;
+		break;
 	case IRQCHIP_AUTO:
 		return -ENODEV;
 	}
@@ -321,6 +324,8 @@ int gic__create(struct kvm *kvm, enum irqchip_type type)
 		gic_redists_base = ARM_GIC_DIST_BASE - gic_redists_size;
 		gic_msi_base = gic_redists_base - gic_msi_size;
 		break;
+	case IRQCHIP_GICV5:
+		break;
 	default:
 		return -ENODEV;
 	}
diff --git a/arm64/include/kvm/gic.h b/arm64/include/kvm/gic.h
index 8490cca6..630f0bbd 100644
--- a/arm64/include/kvm/gic.h
+++ b/arm64/include/kvm/gic.h
@@ -29,6 +29,7 @@ enum irqchip_type {
 	IRQCHIP_GICV2M,
 	IRQCHIP_GICV3,
 	IRQCHIP_GICV3_ITS,
+	IRQCHIP_GICV5,
 };
 
 struct kvm;
-- 
2.34.1

