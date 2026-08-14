Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD333BBFDB
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747514; cv=none; b=Ox1Eu9sPHxdMnCKKL6huBVoPEN/b7R9G0sfbTDOAvAQ6qdPgp3JUhMWDZf/x0svehj4gIcT7/1rOTo2oMRFbK7aYHqXjoBHJWVqxiHjF0RcVu7wbS3KUSf2p5SahZO69PVJp+2TDvFRec1fJ1cA9vRlMSFLG1DlEeQYA8u/r5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747514; c=relaxed/simple;
	bh=nw5IvSEB5wpVmf4cVUFFz5inbV7Os9oqLOB+NCiN6UI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BDrG7E5ijWNuTRbwJkuu6KaUY+1sgq0HRHz9ipWxohF3AJqqSM/9+8goo1WQ48OYOeLeSLaziNSSN8/Ka5sy7Sn9bvYS35ADP6Vrcn92RR/F6EP/LaDRYZ8iBGIV0J78Qb7NH+83OVqg32CxjdABb0az4FvVGEbKyUobWnpDkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W0neo5jw; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0neo5jw"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d54187d8b0so4582695ad.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 15:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786747511; x=1787352311; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pliuRHo29I6egc2gNeBr49sOpidrbP1eYnD6HzsJLuI=;
        b=W0neo5jwwkqe9ziJTHEULgNVqdfMlADm5E2plaubvJblEKQbXytpufhR1TqCQCLAoW
         Y5VjLztceoTPYGqM4D8IfHK9CSfmDlVpmeXDeouYVgHC1PiXvb5rHgNi8E7vwEVKPHSm
         c2Cd0qnIVZ4XRRK0l9hoA8zyw8weIIlhEUpwDjp6gZBofeK5aZAMDeQ5nQC+DWTTwrrN
         XHARBvSaG7PbRpvhT+0XV+OEjjXZAO7iO8AIuzCMiT57I2UJsrUYpXD1c1tESbP7FARB
         /s97i3M8sCFLz8JGeGkdMLSCOfdK+8rJQLFyhAlc8WNIQ1ubYo9fvfx7VcZdNXwszapt
         5K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786747511; x=1787352311;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pliuRHo29I6egc2gNeBr49sOpidrbP1eYnD6HzsJLuI=;
        b=VVlSTpKOInpsXzh6sjgmJPLCBNpeskXQ1AmH/c6CD1czivgTXZWRMxJCmtJoqKPjPG
         jGgxfeJyFxUyE2ZDiXwEAcy5mb0tmeWoxfi6W+UilA9EiET6idUMHfu1cYW2bHUkCXcc
         KYL4CyezLmRlM0n9LWi2BxnAt4bcA4Zd0f2wjOW18uUQhVF9yO/AlvYa643e/onBPB/d
         p5TXiO5eRiVrHtpIcQWlq4a2wBe91OtJABXPxB/Mzo9L/Lgi4uk8tF7/Wdb9BeXk9erP
         66TPtwqQBaXj1ALNhZPwlDbVBMlDHgP1R6RC9tUladZ1b7llRMZXZ2hGrpB1gf4azxR3
         Ijbg==
X-Forwarded-Encrypted: i=1; AHgh+RrhlItarIgU4+Dg7jSUVzg/XxkwtfbhS0tVvznvfEiT9aBtxi7Yl8bLUPt7nRd94kPVsK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwIVsZXN0qfXeQDRIpoiUoBdwKkSXik1z/Gj9tTwE9+3043KzC
	+IPIOk/GjfxqNNLa6E2sxaYNRVWyAOuV5goCX946kDmv9xwt5UbAeR3L/zgD4G6ZzZ7XENmjDA7
	vrv9kcw==
X-Received: from plhc1.prod.google.com ([2002:a17:903:2341:b0:2d1:1cf0:2039])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18b:b0:2cf:ccc2:6088
 with SMTP id d9443c01a7336-2d3b080be2dmr95854275ad.4.1786747510886; Fri, 14
 Aug 2026 15:45:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Aug 2026 15:45:09 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814224509.2342760-1-seanjc@google.com>
Subject: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead of
 guessing it from CPUID
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
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

Keep gfn_direct_bits even though it can be trivially derived from
mirror_root_level as saving a whole eight bytes per VM is meaningless, and
the value is queried fairly often and in hot paths.

Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Fixes: 20d913729c11 ("KVM: x86/mmu: Taking guest pa into consideration when calculate tdp level")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Compile-tested only, and found by inspection, i.e. I haven't proven that this
works, or that there's actually a bug.  But I'm pretty sure there's a bug.

Came across this when looking at our out-of-tree intrahost migration code, and
wanted to assert that could be at most one mirror root per TDX VM.

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/cpuid.c            | 14 --------------
 arch/x86/kvm/cpuid.h            |  1 -
 arch/x86/kvm/mmu.h              |  9 +++++++++
 arch/x86/kvm/mmu/mmu.c          | 16 ++++++++--------
 arch/x86/kvm/vmx/tdx.c          | 12 +++---------
 6 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 283847619ff8..b2a74c69cc4a 100644
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
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2ae7f9ed4cf8..cc37e210787c 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -389,6 +389,15 @@ static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 						     exception, pte_access);
 }
 
+static __always_inline void kvm_mmu_set_mirror_root_level(struct kvm *kvm,
+							  int level)
+{
+	BUILD_BUG_ON(level != 4 && level != 5);
+
+	kvm->arch.mirror_root_level = level;
+	kvm->arch.gfn_direct_bits = gpa_to_gfn(BIT_ULL(level == 4 ? 47 : 51));
+}
+
 static inline bool kvm_has_mirrored_tdp(const struct kvm *kvm)
 {
 	return kvm->arch.vm_type == KVM_X86_TDX_VM;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c519e8e8d646..a51a852c1bec 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5928,19 +5928,19 @@ void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 
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
+	 * If the VM has mirror roots, then the root level is fixed as the gfn
+	 * used to select between the normal and mirror root must be covered.
+	 */
+	if (vcpu->kvm->arch.mirror_root_level)
+		return vcpu->kvm->arch.mirror_root_level;
+
 	/* Use 5-level TDP if and only if it's useful/necessary. */
-	if (max_tdp_level == 5 && maxpa <= 48)
+	if (max_tdp_level == 5 && cpuid_maxphyaddr(vcpu) <= 48)
 		return 4;
 
 	return max_tdp_level;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..6d8e9befd9e6 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -56,9 +56,6 @@
 bool enable_tdx __ro_after_init;
 module_param_named(tdx, enable_tdx, bool, 0444);
 
-#define TDX_SHARED_BIT_PWL_5 gpa_to_gfn(BIT_ULL(51))
-#define TDX_SHARED_BIT_PWL_4 gpa_to_gfn(BIT_ULL(47))
-
 static const struct tdx_sys_info *tdx_sysinfo;
 
 void tdh_vp_rd_failed(struct vcpu_tdx *tdx, char *uclass, u32 field, u64 err)
@@ -1609,10 +1606,7 @@ static int handle_tdvmcall(struct kvm_vcpu *vcpu)
 
 void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
 {
-	u64 shared_bit = (pgd_level == 5) ? TDX_SHARED_BIT_PWL_5 :
-			  TDX_SHARED_BIT_PWL_4;
-
-	if (KVM_BUG_ON(shared_bit != kvm_gfn_direct_bits(vcpu->kvm), vcpu->kvm))
+	if (KVM_BUG_ON(pgd_level != vcpu->kvm->arch.mirror_root_level, vcpu->kvm))
 		return;
 
 	td_vmcs_write64(to_tdx(vcpu), SHARED_EPT_POINTER, root_hpa);
@@ -2823,9 +2817,9 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 	kvm_tdx->xfam = td_params->xfam;
 
 	if (td_params->config_flags & TDX_CONFIG_FLAGS_MAX_GPAW)
-		kvm->arch.gfn_direct_bits = TDX_SHARED_BIT_PWL_5;
+		kvm_mmu_set_mirror_root_level(kvm, 5);
 	else
-		kvm->arch.gfn_direct_bits = TDX_SHARED_BIT_PWL_4;
+		kvm_mmu_set_mirror_root_level(kvm, 4);
 
 	kvm_tdx->state = TD_STATE_INITIALIZED;
 out:

base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.55.0.691.gc56d675ccc-goog

