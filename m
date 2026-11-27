Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798989;
	b=Lg/qYgANlFM4AWRF2apkfRFHJhsJg5vO0TCWTHM/Nfu2bg4foAjvrsagUmugYHU8lvlX
	 DuoKeNvXQoAgo050gMLLrpVxIg/poXkXRHr7QgJwd6OihWq8Jx+qS540qynPOtwNOrTtB
	 /zXT2zJN7Uf21Kl3sF+VFHEXf6egDwf5YANUfrLkdwVcOZCXtXchq8dv3VwIEtOCnbVVR
	 RDuMuBJTx7bOM8CJCq5P8PaWuXX2fsO54ckx6T0JqWm4lorU8PWkzlSg1aVXsJJhwCI3l
	 xEK6+QWWlzBTHOy8kcn/Inz8gzd+KhSn3Wg0nQljRTBf/TEKVmgxpK19iMvGPCQqLzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798989;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ph63pIapK/Oi0jQftYWPnDgvG3tpuV/CW0Q/GMRXUhc=;
	b=f2AzCviOxlNgp+cCmOmzz+V1w/SzjSlWTOoPjIp1wew3gXSUYy2cYdOiLBvpWrWVA0Je
	 t+sceuo91qxhJdpLnMiBWn8w9RAIJVsbBRGHLMXl1t7tPgKaj+f1mzjlrggu/fLxAb/sg
	 WM91sTzrPRjC8JAbnpjDLwBAMs0TSrxLab2a6UZqDyJx2lUCpEDBb2QfadEpwWceVwJrB
	 H9rDKtCqmXy8dPbTcPA6ChYFhiOOdwW3Z3FNn32pLjOKnVqpdlN3Hf/KsSFbh3Kt0aWEA
	 IA+7j5DmZ26BrZ4htoO8PXpeGceaNbcnN7PK4B/z6cUHrI7KYDkehNrTbMRZm1aV/Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jxLvsQQW;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57AF606A31E
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E57AF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jxLvsQQW
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC6011575;
	Fri, 27 Nov 2026 09:03:05 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45A8E3F632;
	Fri, 27 Nov 2026 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798988; bh=yjBWfAzTzu7cyp4c6c4m2tl0EMMFBBETllhL3u+i548=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxLvsQQWZNCVi2TIVKUejol00LFwow+kWZoK/5xVMoflooCM8xh7ZPoP4nldeE+Sy
	 nbwQOxvB8OwnKPnC+olbbhobWxl9ruHJwSgg17jZniM7ac0EnNk2smKjZps5Dhvk6J
	 1LrjzkZ271NbyMZPgH47dKQrpwVNpj/DMv9mE1hU=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 19/23] arm64: Add proposed GICv5 ITS UAPI definitions
Date: Fri, 27 Nov 2026 17:01:41 +0000
Message-Id: <20261127170145.4138182-20-sascha.bischoff@arm.com>
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

