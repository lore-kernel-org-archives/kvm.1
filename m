Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5862373BE7
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411169; cv=none; b=Xo/vJusIlZ/JvTxi61s7dw4UTdyPAFnmZ8/kaPME9CGvrmrbNeSsb4vmyGr9ytTBSpDIifJ0PUA5ViDSWUjbBPWG6Rsq8aDC0ICPusMfxdR5ayO/0aDRYdvzvuw/EU+oNv5HQbBnz9NkcgCxWDgWrquLgyPxKahL4SsVdUMXXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411169; c=relaxed/simple;
	bh=MfFSvaAVGdXmyCjJ09yOvVZGmlsm6cQnkHx1p50x0uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ou2IvWkUv0i8WYWWB6OAGTLxCA0ZkYA0g8zSxoJNDtY2zCCepYVsLLWiCZzuMXJ0aqjkn4iNBCJb/UQ0C+MZvHFRm/BAHtMMOGHZKsluc28pY863bYe7doTZ7krTEyzsZa49eeqsLa/1aKW/BhEcBZ+QcsAhAjdUOtkHE9ABqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2YMO0N3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2YMO0N3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411169; x=1807947169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MfFSvaAVGdXmyCjJ09yOvVZGmlsm6cQnkHx1p50x0uw=;
  b=O2YMO0N3Pj7kMua+W5j2EM6Y8UFtgJiPvhjK9pImNpXhZl9GNrWhZsAC
   K18qUsiuUnvvmAMxdipniyiFSChcghs/Qz+nYP9xSCiRY/lLF98FxP54I
   EKhxGp7OUs1mO2PRYTPNyLiaQ0dVrk5+tOoedUTD1dtK88sHoQDH0Bwhw
   j0Sim4bxHJHxT0dFTUh4fss94WvS7fhn/2es33CLkNdoaBoLdkXVhw0UM
   F9OdsKZ4p/npOOrP7DECaSZTuSbIzRhzP3jKYaeqtr7qcUCUf6mmBcLM/
   09WgHwNm30bwJNBZBdtAZJIfPUpPnDRL2Tch+qdsh0DAcig+zBrNaOnx7
   w==;
X-CSE-ConnectionGUID: okKTy0A2Q6qijVcy6DKggw==
X-CSE-MsgGUID: 8Jp2t/AhTT6dzKFtl9GEGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070282"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070282"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:49 -0700
X-CSE-ConnectionGUID: ZzRiSWmRRYOZyRPNPp77Mw==
X-CSE-MsgGUID: /D70Qp9jTeueraR8Gwz9yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285050"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:46 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 21/27] KVM: x86: Make kvm_vcpu_after_set_cpuid() return an error code
Date: Fri, 17 Apr 2026 15:36:04 +0800
Message-ID: <20260417073610.3246316-22-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change kvm_vcpu_after_set_cpuid() to return an error code, in
preparation for adding CPUID paranoid verification that will reject
invalid userspace CPUID configurations.

Have kvm_set_cpuid() check the return value and unwind on failure,
utilizing the existing error path that restores the vCPU's previous
CPUID entries and capabilities.

No functional change intended.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 8 ++++++--
 arch/x86/kvm/cpuid.h | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 789ec9eb7aaf..08f5bc1d26b1 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -449,7 +449,7 @@ static bool __maybe_unused is_cpuid_subleaf_common_pattern(u32 func, u32 *index)
 	}
 }
 
-void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
+int kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	u8 cpuid_overlay = get_cpuid_overlay(vcpu->kvm);
 	struct kvm_lapic *apic = vcpu->arch.apic;
@@ -543,6 +543,8 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	kvm_mmu_after_set_cpuid(vcpu);
 
 	kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
+
+	return 0;
 }
 
 int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu)
@@ -649,7 +651,9 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 #ifdef CONFIG_KVM_XEN
 	vcpu->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
 #endif
-	kvm_vcpu_after_set_cpuid(vcpu);
+	r = kvm_vcpu_after_set_cpuid(vcpu);
+	if (r)
+		goto err;
 
 success:
 	kvfree(e2);
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 535377e519b5..cff5e71579ce 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -42,7 +42,7 @@ static inline void kvm_finalize_cpu_caps(void)
 	kvm_is_configuring_cpu_caps = false;
 }
 
-void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
+int kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
 struct kvm_cpuid_entry2 *kvm_find_cpuid_entry2(struct kvm_cpuid_entry2 *entries,
 					       int nent, u32 function, u64 index);
 /*
-- 
2.46.0

