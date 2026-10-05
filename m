Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCFD4349A1;
	Mon,  5 Oct 2026 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191319; cv=none; b=aYILYXB7P8Lfn9Z1n5vLi7OFQ5UWlbINfIFUGIe7/ucn6Xo4qOAOBt79kaMq4MOccya613LZCJeS5WEFFz3k5mG/uVOJ4pDSp2fGPzdwTS+foc0hNvCtqyL5ZqPeypx5QA8OwJ2/lZIIAquKkO1aI/yr9zQaBzWFEYIHKJ2K+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191319; c=relaxed/simple;
	bh=95tX0g47qDlvblS2Z+zxuL6zEuph5wLOWbRzPVg1CJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmTDQkoRobe6ey/UCQ7cGdDL4sapDYfqBc1gpL+fqIVvJ9b3tT3d4peFkiwIN4s1oYGm9JYFGR7/e0tqx/xB5bn1ucT1bQAgrjDQPHHIfIroTEE6tRUUtNpYCx6Y/YVHJllV4rRak5J3k/Fwfex4o4GTYMd2081pJTg8uNVQQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d/4IR5qM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d/4IR5qM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F8FC152B;
	Mon,  5 Oct 2026 02:08:33 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EF8F3F66F;
	Mon,  5 Oct 2026 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791191316; bh=95tX0g47qDlvblS2Z+zxuL6zEuph5wLOWbRzPVg1CJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/4IR5qMtJ2fEgcQloh6yk2kxJLlKqJ+BsLqBrR9teyHzJGN6z7x4t8qDPmEuiJF+
	 FRvZCkRfJQZpuUQev3fZxDsLna/HHksPsNZEktBza/z3xBBXqGdSln6ubdz4qtFLSy
	 9AqYiuFbJrJErUnVHXmLZsNkE4R46dTLt6e+bsNw=
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: maz@kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	steven.price@arm.com,
	aneesh.kumar@kernel.org,
	oupton@kernel.org,
	gshan@redhat.com,
	joey.gouly@arm.com,
	tabba@google.com,
	yuzenghui@huawei.com,
	linux-coco@lists.linux.dev,
	gankulkarni@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	alpergun@google.com,
	fj0570is@fujitsu.com,
	WeiLin.Chang@arm.com,
	lpieralisi@kernel.org,
	enju.kohei@fujitsu.com,
	sudeep.holla@arm.com,
	jonathan.cameron@oss.qualcomm.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v22 09/23] KVM: arm64: Prevent unsupported vcpu features for VM types
Date: Mon,  5 Oct 2026 10:07:40 +0100
Message-ID: <20261005090754.2140522-10-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005090754.2140522-1-suzuki.poulose@arm.com>
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent unsupported VCPU features for the protected VCPUs. Realms and pVMs
not support 32bit EL1 or NV yet. pKVM doesn't rely on the host vcpu
features and it clears the unsupported features while hyp_vcpu is
initialised. Block the features early in the vcpu init if we detect
incompatible features.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kvm/arm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index f31d31fa27ad9..9c2ef7ca6a961 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1668,11 +1668,12 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 	return -EINVAL;
 }
 
-static unsigned long system_supported_vcpu_features(void)
+static unsigned long system_supported_vcpu_features(struct kvm_vcpu *vcpu)
 {
 	unsigned long features = KVM_VCPU_VALID_FEATURES;
 
-	if (!cpus_have_final_cap(ARM64_HAS_32BIT_EL1))
+	if (vcpu_is_protected(vcpu) ||
+	    !cpus_have_final_cap(ARM64_HAS_32BIT_EL1))
 		clear_bit(KVM_ARM_VCPU_EL1_32BIT, &features);
 
 	if (!kvm_supports_guest_pmuv3()) {
@@ -1688,7 +1689,8 @@ static unsigned long system_supported_vcpu_features(void)
 		clear_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, &features);
 	}
 
-	if (!cpus_have_final_cap(ARM64_HAS_NESTED_VIRT))
+	if (vcpu_is_protected(vcpu) ||
+	    !cpus_have_final_cap(ARM64_HAS_NESTED_VIRT))
 		clear_bit(KVM_ARM_VCPU_HAS_EL2, &features);
 
 	return features;
@@ -1708,7 +1710,7 @@ static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
 			return -ENOENT;
 	}
 
-	if (features & ~system_supported_vcpu_features())
+	if (features & ~system_supported_vcpu_features(vcpu))
 		return -EINVAL;
 
 	/*
-- 
2.43.0

