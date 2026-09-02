Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB589371076
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390580; cv=none; b=NnvGiY36/ayOYKFglBonvaYinVjuAZZGqMy3/7IdJBCwVjaW4fZeNOAU0v4HYbj8HLL35ObxpstiwR6+bTGSQAWMbOywKSe3dUbRrZSjUI2+A25aoPGnR+1iP46SoaGW3IrHI2xAjd8mTJfbWO+rEUjt2D31W+sFn0AQKXUHRg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390580; c=relaxed/simple;
	bh=9/DS7KoqLOTFhvW1RSttUhcgRMGzHvnr7c5Uw1dq7jA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ddRo4us07tlp1ylM2hWusBRQUaza/ynriH7DNSDk7/+ZR+vLJCqoNdVttLYPWGYrZiYRrdeKS06p4dJLkica9aIRhEySX5kBKkhDYt4QPki529s0yfVO8Qw+qWN3bDYv3XDfSW3LBli/IEQKqOsZ/M2FF1W+GQ+iPo7B5nygP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3Rn9Vl3; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3Rn9Vl3"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-396901263b6so2918806a91.2
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788390576; x=1788995376; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9UQCDCfts6GoSl0Amgo0LC5ujeoh/cVjebfow7J4L6c=;
        b=O3Rn9Vl3Ju7KfAu27HQkgwD3sIIzijpqNdolUPQOxs6AjZJR3lQ/buLWRJr39964Ex
         Zw4E71HKL2Rj03pO7ix4E69Q8W2zAmEcl3mwD2se6wu5sYzPnyF5HIcWbrtupxVOeM5C
         rvc3bKdBmMhNzv9oQWCEuhhDo5r1OMgT8mrXNJOgNMfgSaii3TmPEOaydtaY10sSeomq
         FYFa1vzAMND3gMOYdwZsAAF2E/d2hT1rf8oCZipCyEWwIFyqq6FP7tNlEuKX0gH5t8IF
         3mV2x2s7tyqopm6Z61Ja4yQSvkeNnf3PjcYpW+YKyBlmvdsYOaz3LJo39Kx9TM9ovAZ2
         iJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390576; x=1788995376;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9UQCDCfts6GoSl0Amgo0LC5ujeoh/cVjebfow7J4L6c=;
        b=LAlqOvr7+UGnyFQLwNAtF8cXwrOw7usd4Gjp/+yhZ+o3Sie9DWy/pcOp4E4UCjnOUP
         w13stuWhX98x1xn8dsH87mRwaBrGPHTALFN+IXqHrr1630YkZtxSF7ZHkqSs27zpryXu
         SIC7kr08prh8fUjXgbJvxagOawIdYpWPb6MPNlZonLkodPM0LscLBxRASiWl54JWp7fd
         SmQNsr3KqwH2RUpPClfLDTlcdm9aA6MYKYG3fsgI4/iuOufqHUudqdOdsUSWv537gL5y
         3tUyPULdF/MEHD2tQmoFjosIJ4p6D5/iSLc8j8tmeHlN56GFFKQ0NNHmBLIxuIeROnV1
         0ucQ==
X-Gm-Message-State: AFuF++k+fRsyo0/a8Hxlg2U2lDHg4DDBnrbFNBIk2n01zsJJ0fwXZwSr
	noVPUmw8rhXwaJkB73jDuW6P3YuKiRp8l+Kjs31WX/Bl/Y0N1wqEnyAYlapa8bUfZqmHaCc06pF
	XDrvXrA==
X-Received: from pjbcp24.prod.google.com ([2002:a17:90a:fb98:b0:38e:8fe4:4ac2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:524c:b0:390:8361:a532
 with SMTP id 98e67ed59e1d1-39aedfb8ebcmr12574649a91.7.1788390576106; Wed, 02
 Sep 2026 16:09:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 16:09:31 -0700
In-Reply-To: <20260902230932.2760127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902230932.2760127-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902230932.2760127-3-seanjc@google.com>
Subject: [PATCH v3 2/3] KVM: VMX: Explicitly track TDX VMs' root level instead
 of guessing it from CPUID
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly track the root level for TDX VMs instead of trying to infer the
depth of the paging tree based on an individual vCPU's CPUID information.
Applying KVM's existing logic to select the root level to TDX is flawed as
nothing *requires* userspace to fill in the correct guest.MAXPHYADDR for a
vCPU's CPUID.  Guessing at the correct root level is also ridiculous given
that userspace has already told KVM the root level during TD initialization.

Relying on userspace to set the expected/correct CPUID lets a misbehaving
userspace trip the KVM_BUG_ON() in tdx_load_mmu_pgd() by configuring guest
CPUID to use an "incorrect" guest.MAXPHYADDR.

Don't use kvm_gfn_direct_bits() to infer the mirror root level, as the
connection between TDX's one and only "direct" bit and the predetermined
root level is a TDX implementation detail.  I.e. avoid baking in the
assumption that there is exactly one "direct bits", that the one bit is a
pivot between normal and mirror roots, and that the pivot bit is the most
significant bit of the effective GPA space.  For the same reason, set the
root level and direct bits in TDX code, i.e. don't provide a helper in the
MMU, because from the MMU's perspective, they are two separate concepts.

Keep gfn_direct_bits even though it can be trivially derived from
mirror_root_level as saving a whole eight bytes per VM is meaningless,
keeping the TDX details buried in TDX would require a kvm_x86_ops hook, and
the value is queried fairly often and in hot paths.

And for the moment, keep the S-bit sanity check in tdx_load_mmu_pgd(), even
though it really only needs to ensure the incoming level matches the
preconfigured mirror root level.  Because KVM manually configures the
S-bit location, there's technically a risk that the S-bit location and
mirror root level could get out of sync.  That can be addressed by more
programmatically computing the S-bit, but that doesn't need to be done now.

Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Fixes: 20d913729c11 ("KVM: x86/mmu: Taking guest pa into consideration when calculate tdp level")
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/cpuid.c            | 14 --------------
 arch/x86/kvm/cpuid.h            |  1 -
 arch/x86/kvm/mmu/mmu.c          | 19 +++++++++++--------
 arch/x86/kvm/vmx/tdx.c          | 14 ++++++++++++--
 5 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a9..edd5ad2e5b52 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1406,6 +1406,7 @@ struct kvm_arch {
 	struct kvm_mmu_memory_cache split_desc_cache;
 
 	gfn_t gfn_direct_bits;
+	int mirror_root_level;
 
 	/*
 	 * Size of the CPU's dirty log buffer, i.e. VMX's PML buffer. A Zero
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ddb022cb203a..34c609a60eef 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -483,20 +483,6 @@ int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu)
 	return 36;
 }
 
-int cpuid_query_maxguestphyaddr(struct kvm_vcpu *vcpu)
-{
-	struct kvm_cpuid_entry2 *best;
-
-	best = kvm_find_cpuid_entry(vcpu, 0x80000000);
-	if (!best || best->eax < 0x80000008)
-		goto not_found;
-	best = kvm_find_cpuid_entry(vcpu, 0x80000008);
-	if (best)
-		return (best->eax >> 16) & 0xff;
-not_found:
-	return 0;
-}
-
 /*
  * This "raw" version returns the reserved GPA bits without any adjustments for
  * encryption technologies that usurp bits.  The raw mask should be used if and
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 8d863f45585d..46bfe8699e67 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -68,7 +68,6 @@ void __init kvm_init_xstate_sizes(void);
 u32 xstate_required_size(u64 xstate_bv, bool compacted);
 
 int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu);
-int cpuid_query_maxguestphyaddr(struct kvm_vcpu *vcpu);
 u64 kvm_vcpu_reserved_gpa_bits_raw(struct kvm_vcpu *vcpu);
 
 static inline int cpuid_maxphyaddr(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c9a684151420..d43b8b6c3b17 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5953,19 +5953,22 @@ void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 
 static inline int kvm_mmu_get_tdp_level(struct kvm_vcpu *vcpu)
 {
-	int maxpa;
-
-	if (vcpu->kvm->arch.vm_type == KVM_X86_TDX_VM)
-		maxpa = cpuid_query_maxguestphyaddr(vcpu);
-	else
-		maxpa = cpuid_maxphyaddr(vcpu);
-
 	/* tdp_root_level is architecture forced level, use it if nonzero */
 	if (tdp_root_level)
 		return tdp_root_level;
 
+	/*
+	 * If the VM has mirror roots, then the root level is predefined as the
+	 * mirror root (and by extension the normal root) needs to match the
+	 * root level that was configured for the external page tables that are
+	 * being mirrored by KVM.
+	 */
+	if (kvm_has_mirrored_tdp(vcpu->kvm) &&
+	    !WARN_ON_ONCE(!vcpu->kvm->arch.mirror_root_level))
+		return vcpu->kvm->arch.mirror_root_level;
+
 	/* Use 5-level TDP if and only if it's useful/necessary. */
-	if (max_tdp_level == 5 && maxpa <= 48)
+	if (max_tdp_level == 5 && cpuid_maxphyaddr(vcpu) <= 48)
 		return 4;
 
 	return max_tdp_level;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..e6b7da616817 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2760,6 +2760,13 @@ DEFINE_CLASS(tdx_vm_state_guard, tdx_vm_state_guard_t,
 	     if (!IS_ERR(_T)) tdx_release_vm_state_locks(_T),
 	     tdx_acquire_vm_state_locks(kvm), struct kvm *kvm);
 
+static __always_inline void tdx_set_mirror_root_level(struct kvm *kvm, int level)
+{
+	BUILD_BUG_ON(level != 4 && level != 5);
+
+	kvm->arch.mirror_root_level = level;
+}
+
 static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 {
 	struct kvm_tdx_init_vm __user *user_data = u64_to_user_ptr(cmd->data);
@@ -2822,10 +2829,13 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 	kvm_tdx->attributes = td_params->attributes;
 	kvm_tdx->xfam = td_params->xfam;
 
-	if (td_params->config_flags & TDX_CONFIG_FLAGS_MAX_GPAW)
+	if (td_params->config_flags & TDX_CONFIG_FLAGS_MAX_GPAW) {
 		kvm->arch.gfn_direct_bits = TDX_SHARED_BIT_PWL_5;
-	else
+		tdx_set_mirror_root_level(kvm, 5);
+	} else {
 		kvm->arch.gfn_direct_bits = TDX_SHARED_BIT_PWL_4;
+		tdx_set_mirror_root_level(kvm, 4);
+	}
 
 	kvm_tdx->state = TD_STATE_INITIALIZED;
 out:
-- 
2.55.0.970.g62bdec98f9-goog

