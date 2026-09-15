Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A84BD7A8;
	Tue, 15 Sep 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488149; cv=none; b=etn6LqgH7AxEJss1EGc/kfSzuJyrI8ILwRIbMNZEQtKVzxgLngDBMfWkISyQ7zLh/GTjABfUtOk16kAQdwJL3DQnSOS/d8JwbdT2c48VA2BtW5nZM2Dr91B5yPxYU4hSMXpBFXLeeHkrFF7q6Trgfw8S5h3jEcSoVQ7MBPxYGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488149; c=relaxed/simple;
	bh=O20Il//CEz/+ccfyPp5fc/rnwGtdVWyTBiPY+ldH7Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMyBsk65HxPH0Xy+Cog9qV7guTBNJuf7vsiDbFexcB4rUg8GHCvH0NS8nleafGV1uIWCMkl9/TLFm/ojkSKICLwCPAX9kiP7oH1KepUNPL+/QhbImQz2+I/6B70vJLVga65eunQvNAoT3UczhowBB6K+fX4QFRxM2oqFFrhStlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XqAo4y5x; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XqAo4y5x"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BF6915A1;
	Tue, 15 Sep 2026 09:02:22 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82C8D3F882;
	Tue, 15 Sep 2026 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789488146; bh=O20Il//CEz/+ccfyPp5fc/rnwGtdVWyTBiPY+ldH7Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XqAo4y5xDcLPy/SIM1ag+uNsHiVFPkhOybAkt1H7ifo9uJeJ0ZxAIbaflRaCpAqRY
	 t5ePwLFllZ6a7snHTFb1SfpEBlJorXlNCETpp2gF2FvPrMTDhACTrFW/nUDHVySWEk
	 jy5yHQHBYcVfHhitR71wOHtzml+p5kNu6OERGSKk=
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
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v18 11/23] KVM: arm64: Use kvm_vm_is_unprotected() for !kvm_vm_is_protected()
Date: Tue, 15 Sep 2026 17:01:29 +0100
Message-ID: <20260915160141.3543048-12-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160141.3543048-1-suzuki.poulose@arm.com>
References: <20260915160141.3543048-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have a flavor to check, use the helper to explicitly check
the type for an unprotected PKVM guest. We don't convert all of the
!kvm_vm_is_protected(), but only the ones that target unprotected PKVM
guests.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/kvm_pkvm.h | 2 +-
 arch/arm64/kvm/arm.c              | 2 +-
 arch/arm64/kvm/handle_exit.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index a1f3e05e75dc1..e4ea80711bec6 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -49,7 +49,7 @@ static inline bool kvm_pkvm_ext_allowed(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES:
 		return false;
 	default:
-		return !kvm || !kvm_vm_is_protected(kvm);
+		return !kvm || kvm_vm_is_unprotected_pkvm(kvm);
 	}
 }
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 36bd1c6c04899..42d9385f5e329 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1082,7 +1082,7 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 
 	if (is_protected_kvm_enabled()) {
 		/* Start with the vcpu in a dirty state */
-		if (!kvm_vm_is_protected(vcpu->kvm))
+		if (kvm_vm_is_unprotected_pkvm(vcpu->kvm))
 			vcpu_set_flag(vcpu, PKVM_HOST_STATE_DIRTY);
 		ret = pkvm_create_hyp_vm(kvm);
 		if (ret)
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index db37678dcb05c..384c5d258c7f8 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -490,7 +490,7 @@ static void handle_exit_pkvm_state(struct kvm_vcpu *vcpu, int exception_index)
 {
 	int exception_code = ARM_EXCEPTION_CODE(exception_index);
 
-	if (!is_protected_kvm_enabled() || kvm_vm_is_protected(vcpu->kvm))
+	if (!kvm_vm_is_unprotected_pkvm(vcpu->kvm))
 		return;
 
 	/*
-- 
2.43.0

