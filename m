Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798933;
	b=4K2WELy7aud5qvLbK1jkNbq4e2AV+4Vg1WEmZdqkdg4ZHSct8DLblH9yuqDBBrPK1E7B
	 Ma72FM7eMLzzfsNwmf+HtBkQXSivWITAsOTHjwgQ6fj1LfRr/vcsTpeea6bNlfbOyvAL5
	 TkfI8Iqk6TU15/G1Sabu+vVThNnOLYn9g7Ve/bLtr/6lGbLcEir92CvQSpB8PxiE4T8Lp
	 2ndKbVsROohPySitfP5LE40ocR5rakQri+Te9tEefewoMEQgnPkU+baEHnRQ/jw3mKjEX
	 nE0XIJ3+5jR32GqQbMDTWiZOkHUmKgGHZwa7HO280srwQglojI1QQGNjaH8dr0fkJcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798933;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KPxJkSXbgNCwMjexUmFruvkO52wS4HWNgIMrUkpFZyw=;
	b=HeHBhRCLBYsdn2dfLCeWFgcVzbWAaST7Q5raGuM8MGVJw2A3mkbls/h8r9+xUwYUWXuj
	 IxKCQYkMRxI+PzUu6/mIdcsKKj8cHfi9x+IzxL6pLvP7ncSg2c37AYgeS3zq61fg2d7/N
	 zyVy0/VmeyOi3CAA1IQrtdH2P53NKUN9vZQP5xe04c/WdP0lkmXigRoHzdj0lEU6NKzDB
	 HLaSYgYIAiLaMPRgsaDHoFRlo8+Zkky2gyulYTUcekl3hucXBWrPc8OG6IDbDqa9Otyfi
	 +EYIyjkjt7ndrnq1FdVXhhpa8jyCsCz9KZJajK3wZCJd67DX2qtxMNKeKhaye9jJizw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cOY3qCdJ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912C7606A31F
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 912C7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cOY3qCdJ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 575221575;
	Fri, 27 Nov 2026 09:02:09 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A94C3FB9E;
	Fri, 27 Nov 2026 09:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798932; bh=561lrRLmUiWpxG8SJgos6yK6je/WVLjQyZln4pVPQYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOY3qCdJ2I68zWDjeRpN59a3NkCzz8GYciuevdqbkyjgb7oJ9nQpPS7bBSMq23Dkn
	 Nlbco2BymWBJJfS29ixP11O0Z5f1xghdfJd4QFhQ9vlHXQfjo7Ik7DmtiRR+hegIl5
	 Ix0QbnO6XLP0UwbWOTnXHcpb1zlv/o++U///MJPM=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 05/23] arm64: Add GICv5 irqchip device support
Date: Fri, 27 Nov 2026 17:01:27 +0000
Message-Id: <20261127170145.4138182-6-sascha.bischoff@arm.com>
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

