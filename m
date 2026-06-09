Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE840D58D
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036699; cv=none; b=HN1GCJsUFvtb+8wNtGtzxAhv0vycLcnUhN9GCevQFPHcJx+ihyMe/xA4n2WWNgyuvmrnSP9HVNIuDth+9cw3FCuRbOSrLRV8aqA3cNLwk6DrG4RTh38BuZk9J6gcYce8K5izPBR0Iknpt0ua+K6aqG3q8Ymm+wi7UxmG8sr3Jao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036699; c=relaxed/simple;
	bh=wX84PiDt/XXfWuiwkPl8OegpIYc3uClocVcOBkdskuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YnyN3eZd4dcn/DbmOd3SckHu1DHf1e4TEs2hns/54GvTEiBpZcAodypiISKo0gC+iMKP+82oeEV9cumu21ijIxfFCZDuZt5QG3XXOIOl7q/OH522u/txHnPtLxC721cIlJNov6Tmn82xvK5r7lN6PC/aWxhVGZm3MMBhdU/Nup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7hFe3Af; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7hFe3Af"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf1845bddfso69896895ad.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781036697; x=1781641497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbxbGBM5w2hC4bkM+ZI5xDNZJpLnINAuxgKecisD+NM=;
        b=f7hFe3AfjuefKnid3jqS3Z4mNBzxi870Mz1RyH67f7viinrg4tx81DyLsxHTHEq5Gm
         i9HAxjQMGsHs/z7z7TdOsFraL2RnbtMd6IuJE1TpRACwO/yl7pIrijWEPu6HEHYgNzGh
         Lm0Gj8eySgRRRNIAk5Jd/vXLclu+E9bQ1P51sFwBCqmRc1e8J7ZbxrrFvFtedczwbkvr
         b0odJvZBKLGyw6qqWxp4ZgZwdmD+A+opKfGqViYlBprk0Dw8HpfdgkGR4/O/6aHkKtqf
         Q+xsz99+TGP1QpZmg37qweCX3STullOZbdG+YGfkJCBFR1jWhbtguOVbLOG4H/0oFMcY
         UtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036697; x=1781641497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbxbGBM5w2hC4bkM+ZI5xDNZJpLnINAuxgKecisD+NM=;
        b=JPDlyLKzVwA6gqdl3q8VLr1NT0mlgEvp3TZkM/ryLW9MlfnKTx+3DPin1OM1uxYobj
         n7JAFS4QiFtoTe23ou4Ol2tQCvoMI+Z1k9b+5u5Uxtg4dM58+/ZwiJ73nZvbDwMhJGnW
         6GghMPg5LWzWTdUTCt/be6nt53xg3DKUORqhm0zzlQ7+ChjmXEDU9Nj2q8sSjVy3lEeC
         ogYxMKVrKUwOVKd2ItFbmot5IRMKpJn2fdm8Zi+781lhak3jU2Fudwe9doYuYY7n0Rup
         GmN2TrFzjhdOxs0/CtnixRySQqF6GXwP5syM/Z2gp/udT6Njb/e2LKH1v5sJeJ0QPe6q
         IfZw==
X-Forwarded-Encrypted: i=1; AFNElJ/A9VRHOd5jgm7enrmR9m+Q92F2zxKjU7vgGqf4NeKP3VvZhmXUJOpgWFqSQ775FKv30Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYiZlhmUTmGzfroFTxS+OVcjanRX5k/eFTLs38VpcF3dJAdVC
	4lwSSwtV8S1OGL5GA3KlrOvxEVe7KZxuzWheCJAF4Is3q1R78NwN420EXk3uCMRAxEoqBjs72Ak
	vVxeWbw==
X-Received: from plv2.prod.google.com ([2002:a17:903:bc2:b0:2b2:4611:5de2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce92:b0:2c0:db23:4a4
 with SMTP id d9443c01a7336-2c1e85d210amr240733235ad.36.1781036697035; Tue, 09
 Jun 2026 13:24:57 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:24:54 -0700
In-Reply-To: <20260604160733.12555-3-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604160733.12555-1-pbonzini@redhat.com> <20260604160733.12555-3-pbonzini@redhat.com>
Message-ID: <aih2lgkT9Tmt09uv@google.com>
Subject: Re: [PATCH 2/3] KVM: MMU: unconditionally clear MMIO cache on root rebuild
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Paolo Bonzini wrote:
> Upon changing CR3, the MMIO cache becomes invalid because the
> GVA->GPA mapping has changed.  However, kvm_load_new_pgd() calls

s/kvm_load_new_pgd/kvm_mmu_new_pgd

> vcpu_clear_mmio_info() call only if the fast switch succeeded.
> The early-return path instead leaves the root invalid; the next entry
> then calls kvm_mmu_reload() and from there kvm_mmu_load().
> 
> kvm_mmu_load() calls kvm_mmu_sync_roots(), which clears the MMIO
> cache, but one combination that falls through is root_role.direct==1,
> i.e. CR0.PG=0, for which kvm_mmu_sync_roots() bails before reaching the
> call to vcpu_clear_mmio_info().
> 
> That combination is barely reachable: a valid direct root is pretty much
> always a fast-switch success because it does not check the PGD for a
> match.  The early return for a direct root thus requires the current root
> to already be invalid, and kvm_mmu_unload() itself clears the MMIO cache.
> 
> That said, doing an independent clear in the style of kvm_mmu_new_pgd()
> is more obviously correct and basically free, so harden it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index f8aa7eda661e..6689c9f8ae16 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6138,6 +6138,7 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
>  	if (r)
>  		goto out;
>  
> +	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
>  	kvm_mmu_sync_roots(vcpu);


I don't dislike this change, but I don't really like it either.  MMIO caching as
a whole is a mess of spaghetti.  E.g. handle_mmio_page_fault() will never use or
cache a gva for the CR0.PG=0 case, and so the only way for this to be reachable
in any capacity is if KVM emulates an instruction, in response to something *other*
than a #PF (otherwise KVM will use the GPA), immediately after inserting into the
cache via kvm_handle_noslot_fault().

IMO, flushing cache here, when it's _just_ barely necessary is rather confusing.
E.g. kvm_mmu_sync_roots() obviously handles the shadow paging case, and TDP can't
ever use the GVA-based cache because KVM doesn't track CR3 changes (and it's
*really* hard to see that TDP is safe/fine).  We could "fix" that with a comment,
but rather than go through all that effort to support a path that in all likelihood
never gets a cache hit, or at least never gets enough hits to provide meaningful
value, we actually make direct MMUs completely mutually exclusive with GVA-based
caching?

It's actually a fairly nice cleanup, and would entirely obviate the need to worry
about flushing the cache for CR0.PG=0.

E.g. over a few patches (completely untested):

---
 arch/x86/kvm/mmu/mmu.c | 29 ++++++++++++-----------------
 arch/x86/kvm/x86.h     | 24 +++++++++++++++++-------
 2 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 91843e9224d0..42ac9986d73b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3533,14 +3533,12 @@ static int kvm_handle_noslot_fault(struct kvm_vcpu *vcpu,
 				   struct kvm_page_fault *fault,
 				   unsigned int access)
 {
-	gva_t gva = fault->is_tdp ? 0 : fault->addr;
-
 	if (fault->is_private) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
 		return -EFAULT;
 	}
 
-	vcpu_cache_mmio_info(vcpu, gva, fault->gfn,
+	vcpu_cache_mmio_info(vcpu, fault->addr, fault->gfn,
 			     access & shadow_mmio_access_mask);
 
 	fault->slot = NULL;
@@ -4364,19 +4362,20 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	return kvm_translate_gpa(vcpu, mmu, vaddr, access, exception);
 }
 
-static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
+static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 cr2_or_gpa)
 {
 	/*
-	 * A nested guest cannot use the MMIO cache if it is using nested
-	 * page tables, because cr2 is a nGPA while the cache stores GPAs.
+	 * A nested guest cannot use the software MMIO cache if it is using
+	 * nested TDP, because the address at the time of fault is a nGPA,
+	 * while the cache stores GPAs.
 	 */
 	if (mmu_is_nested(vcpu))
 		return false;
 
-	if (direct)
-		return vcpu_match_mmio_gpa(vcpu, addr);
+	if (vcpu_can_cache_mmio_gva(vcpu))
+		return vcpu_match_mmio_gva(vcpu, cr2_or_gpa);
 
-	return vcpu_match_mmio_gva(vcpu, addr);
+	return vcpu_match_mmio_gpa(vcpu, cr2_or_gpa);
 }
 
 /*
@@ -4462,12 +4461,12 @@ static bool get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 	return reserved;
 }
 
-static int handle_mmio_page_fault(struct kvm_vcpu *vcpu, u64 addr, bool direct)
+static int handle_mmio_page_fault(struct kvm_vcpu *vcpu, u64 addr)
 {
 	u64 spte;
 	bool reserved;
 
-	if (mmio_info_in_cache(vcpu, addr, direct))
+	if (mmio_info_in_cache(vcpu, addr))
 		return RET_PF_EMULATE;
 
 	reserved = get_mmio_spte(vcpu, addr, &spte);
@@ -4481,9 +4480,6 @@ static int handle_mmio_page_fault(struct kvm_vcpu *vcpu, u64 addr, bool direct)
 		if (!check_mmio_spte(vcpu, spte))
 			return RET_PF_INVALID;
 
-		if (direct)
-			addr = 0;
-
 		trace_handle_mmio_page_fault(addr, gfn, access);
 		vcpu_cache_mmio_info(vcpu, addr, gfn, access);
 		return RET_PF_EMULATE;
@@ -6359,7 +6355,7 @@ static int kvm_mmu_write_protect_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	 * and could put the vCPU into an infinite loop because the processor
 	 * will keep faulting on the non-existent MMIO address.
 	 */
-	if (WARN_ON_ONCE(mmio_info_in_cache(vcpu, cr2_or_gpa, direct)))
+	if (WARN_ON_ONCE(mmio_info_in_cache(vcpu, cr2_or_gpa)))
 		return RET_PF_EMULATE;
 
 	/*
@@ -6421,7 +6417,6 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 		       void *insn, int insn_len)
 {
 	int r, emulation_type = EMULTYPE_PF;
-	bool direct = vcpu->arch.mmu->root_role.direct;
 
 	if (WARN_ON_ONCE(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
 		return RET_PF_RETRY;
@@ -6445,7 +6440,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 		if (WARN_ON_ONCE(error_code & PFERR_PRIVATE_ACCESS))
 			return -EFAULT;
 
-		r = handle_mmio_page_fault(vcpu, cr2_or_gpa, direct);
+		r = handle_mmio_page_fault(vcpu, cr2_or_gpa);
 		if (r == RET_PF_EMULATE)
 			goto emulate;
 	}
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 38a905fa86de..64da5ba8539b 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -366,6 +366,19 @@ static inline bool is_noncanonical_invlpg_address(u64 la, struct kvm_vcpu *vcpu)
 	return is_noncanonical_address(la, vcpu, X86EMUL_F_INVLPG);
 }
 
+static inline bool vcpu_can_cache_mmio_gva(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Disable GVA-based caching if TDP is enabled, as GVA is actually a
+	 * GPA or nGPA (if L2 is active), and KVM doesn't track CR3 changes,
+	 * i.e. can't know when to flush the cache.  Similarly, don't track
+	 * GVAs for direct MMUs (CR0.PG=0), as CR2 == GPA, i.e. KVM can simply
+	 * use the GFN cache, so that KVM doesn't have to flush the cache even
+	 * when all other shadow paging update/sync operations can be skipped.
+	 */
+	return !tdp_enabled && is_paging(vcpu);
+}
+
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 					gva_t gva, gfn_t gfn, unsigned access)
 {
@@ -374,11 +387,7 @@ static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 	if (unlikely(gen & KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS))
 		return;
 
-	/*
-	 * If this is a shadow nested page table, the "GVA" is
-	 * actually a nGPA.
-	 */
-	vcpu->arch.mmio_gva = mmu_is_nested(vcpu) ? 0 : gva & PAGE_MASK;
+	vcpu->arch.mmio_gva = vcpu_can_cache_mmio_gva(vcpu) ? gva & PAGE_MASK : 0;
 	vcpu->arch.mmio_access = access;
 	vcpu->arch.mmio_gfn = gfn;
 	vcpu->arch.mmio_gen = gen;
@@ -405,8 +414,9 @@ static inline void vcpu_clear_mmio_info(struct kvm_vcpu *vcpu, gva_t gva)
 
 static inline bool vcpu_match_mmio_gva(struct kvm_vcpu *vcpu, unsigned long gva)
 {
-	if (vcpu_match_mmio_gen(vcpu) && vcpu->arch.mmio_gva &&
-	      vcpu->arch.mmio_gva == (gva & PAGE_MASK))
+	if (vcpu_can_cache_mmio_gva(vcpu) &&
+	    vcpu_match_mmio_gen(vcpu) &&
+	    vcpu->arch.mmio_gva && vcpu->arch.mmio_gva == (gva & PAGE_MASK))
 		return true;
 
 	return false;

base-commit: 03e00f8b41e58b5dd5ceef21940a62e5d8e08766
--
