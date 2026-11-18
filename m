Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024764;
	b=O/6wzJy0JC1d6w90wePdioXA3pMA5zQUlSPwMHnxwVxVwSvzVlqlRFBYxk7TIxixDoWa
	 Q+HXNPZOA7o/13zH4FpoCoEjPHrW4gAIPsYAMqdd+OqZp3Wo58Z2F1LMwNtlwLbqZAO5p
	 /Q+/HmlhWhOMnEBZ8h8ej6nE7CBfKGLfdZTsXcdStzbhOZHlCKOFrmzbiUfvsGL7p/d30
	 G5JFzviMaU6PXKMbSZQaWT1CbBBPIzIWuxiGwdl8TJ3LMxaQy9a8f5eZDi1Lql/9MZSvM
	 0505U/9g4lvoqLYLtCrVpFPA3UXaMf+tK8U74sgCsHghZf70H8odVouyXV2evhgoa5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024764;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ph63pIapK/Oi0jQftYWPnDgvG3tpuV/CW0Q/GMRXUhc=;
	b=PDHRjKK+M4UlUXBIOIvV/FLdFItwd3FfkE4blvJABrqEUB4O/kJvAui/yxpO2g8piwjU
	 jkAd2fStCjxaRBlU2MWKyEi7XsY0nt4ySMpZc97F3aLTX6QrbU4cyH0rZWHmWcyXbXaSL
	 I83N1HEOWVTfgjU10FAenYkeTeE4GNQQMs+ryWCfb+hLGRhSOoiAeKhfOh0CvdiASUXNy
	 CiUSUYKpOXren01ZdHQpJdJaVTDfUGVAUnpEnIaDNqgwzjzL2z0fF6gb4jJVGawNk8hGo
	 x7Kw2jN+sfCV5Q6aP6ImlOkv51DRMTPQ8VW2lMs0Zs29mtpsiC4410dFnAYdF6qBwPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i40lV4uS;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C8E606A338
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C8E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i40lV4uS
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6446E1477;
	Wed, 18 Nov 2026 09:59:20 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4F83F632;
	Wed, 18 Nov 2026 09:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024763; bh=yjBWfAzTzu7cyp4c6c4m2tl0EMMFBBETllhL3u+i548=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i40lV4uSfJvo5OKwC0Vrf9D/BDGpSGV3fkpZSI9HkyA4rdhL0VMSjT4jcxzyX6jX/
	 yU4kKIf0L13JGw2IAxZiU24m1fRkVyQyk6YrDNPrKZBc0cI4lfWP4ckwIQCgDpMFnZ
	 44uWYp94I/HQ9O6LODq7CKfgTP3a/778lTSs8PFk=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 19/23] arm64: Add proposed GICv5 ITS UAPI definitions
Date: Wed, 18 Nov 2026 17:57:51 +0000
Message-Id: <20261118175755.1946977-20-sascha.bischoff@arm.com>
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

Mirror the GICv5 ITS device type, address type and size from the posted
KVM GICv5 ITS series. These definitions are not part of the v7.4-rc1
UAPI header sync.

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/include/asm/kvm.h | 2 ++
 include/linux/kvm.h     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arm64/include/asm/kvm.h b/arm64/include/asm/kvm.h
index 65ee09bd..8c701173 100644
--- a/arm64/include/asm/kvm.h
+++ b/arm64/include/asm/kvm.h
@@ -99,8 +99,10 @@ struct kvm_regs {
 
 /* Supported VGICv5 address types  */
 #define KVM_VGIC_V5_ADDR_TYPE_IRS	6
+#define KVM_VGIC_V5_ADDR_TYPE_ITS	7
 
 #define KVM_VGIC_V5_IRS_SIZE		(2 * SZ_64K)
+#define KVM_VGIC_V5_ITS_SIZE		(2 * SZ_64K)
 
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 8dff2fc1..c0e11993 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -1239,6 +1239,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_LOONGARCH_DMSINTC	KVM_DEV_TYPE_LOONGARCH_DMSINTC
 	KVM_DEV_TYPE_ARM_VGIC_V5,
 #define KVM_DEV_TYPE_ARM_VGIC_V5	KVM_DEV_TYPE_ARM_VGIC_V5
+	KVM_DEV_TYPE_ARM_VGIC_V5_ITS,
+#define KVM_DEV_TYPE_ARM_VGIC_V5_ITS	KVM_DEV_TYPE_ARM_VGIC_V5_ITS
 
 	KVM_DEV_TYPE_MAX,
 
-- 
2.34.1

