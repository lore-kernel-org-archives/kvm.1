Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E839A076
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787958775; cv=none; b=CgGt8o7aL4p2srvizRxs/ogi9A+MKi+K7Q8M7zNv2QBhCnsQ3B/yUuYAzdntCoCxTh8Q+CfhgZCOcOZ6wxZ1LkLAc2FaZD37uB78M/NyChrpTMqUoKYXlgCGBLQ8yZxkoO4nrZUhPqSARroXTvfnojsBmj2O6Ykv5CaXlYGj4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787958775; c=relaxed/simple;
	bh=ErvEkwW4nkQ8rSOh1YWlExY72JjgRj6x1T9VW+/r2h4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qUu8lKgR32TkcHHSgZmBh/86xGnzs3/G6f3dpt7m4M0zWZJVKJeyHEgrFdkbFA93DoiqMhQv8YHiItFhHosZSsyZQZQuAkgKfdvoBcD9Gx6xUTE3aTIrO7zr+xEEKWeJ3vdRa86z1lzjG4YmIscK6g6lqvHnIkjl5UxTJzOnzKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5vElC8p; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5vElC8p"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso1385974a12.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787958773; x=1788563573; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPg0OE0xBHtWK9BcR1Rk3Q/5ss3lKUWsby0mpwATbOI=;
        b=q5vElC8prKF8++NqQ1OcZnFKsWJ4x4sSPzn9tkgaasENNBEkw3LdMQCfPWAlyEtDZN
         kPxr1KvZzPp9TKbhEoOSjE8rUlFGobZYVsbGsw3Dss6i+nNT9ECt9gFFTNZp17K/oTX4
         9ev5SeO9dkw6FGyVpeEf2EOOd81QMjgDwyCHflJD4TaQdh7pis1hBAGlZF8MHsB/mnXJ
         MC1FWo29ME4OLsfYcpJgS6UhU2j5qkk27sYzj02jpsHveNs4Omzrl17UfVbg375vJ+bT
         1dlTADuFe1MHr91COtEPQj1FpPJaJ7FvXvLd6cU5tnBVI+MQy6U3D21sj/NemfFOmOWo
         8n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787958773; x=1788563573;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KPg0OE0xBHtWK9BcR1Rk3Q/5ss3lKUWsby0mpwATbOI=;
        b=gXP/HuHoC4Md+VMvuwOsV/m7cpCRIHQ0ApDIm6VdiseGqvj5wwzIigSumQcoaMEuKT
         b5fQnvZQJpPTQgK6PHWY0tR+GBsvVnqFe56Yq3C01nwGi3s5SG85Gx9AHvntP5qjD8RB
         qmigPvPFmiRfVrUpalePT9I+6T8aqYgukCrS9iFv/8/5R9DhruluRtTFJq8+mOyQW52V
         HYYi0xk6NswBnf67GtSsrTvJr3+CZbzWo6Ul42BGG4uMcbA2gL5WHYo5/dK3RhxfXJDj
         BHySj/7X1+huJ4osngXz9OTmjUobsk/1PSZM6DsJO50KpQyE+5BwqosXeWVVp9+l2ZP9
         C2fw==
X-Gm-Message-State: AFuF++n0A4D3GbMYo45T9I1nM3Ac1FKLouRH6pZtvHNQNjKrIjGu13zJ
	e4m8j9XZDdFNzCXfLJvuCWM6TmCNUSJNtzVFMKFCNxW1/1Y66ZmYKXYAfV9yRRsQbbZ+Qyox+iM
	7o3LBug==
X-Received: from pjrx15.prod.google.com ([2002:a17:90a:bc8f:b0:38e:8fe4:4ac2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e48:b0:37d:f206:a2ac
 with SMTP id 98e67ed59e1d1-396d0ebd7fbmr20494961a91.7.1787958772552; Fri, 28
 Aug 2026 16:12:52 -0700 (PDT)
Date: Fri, 28 Aug 2026 16:12:51 -0700
In-Reply-To: <20260828193055.59623-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828193055.59623-1-kylebot@openai.com>
Message-ID: <apIV8151LGvValMh@google.com>
Subject: Re: [PATCH] KVM: x86: Restrict saved GPA writes to hardware write faults
From: Sean Christopherson <seanjc@google.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Chris Ayoub <cayoub@openai.com>, Oleg Boiko <oboiko@openai.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 28, 2026, Kyle Zeng wrote:
> A GPA supplied by a hardware page fault describes the access that
> faulted, not an arbitrary instruction decoded afterwards.  A guest can
> change an MMIO read into a store before KVM fetches the instruction.  The
> saved-GPA shortcut then skips the write-aware guest page-table walk and
> can issue a write through a guest-read-only mapping.
> 
> Carry final-write fault information into the emulator and retain it
> alongside the saved GPA.  Only reuse that GPA for a write when hardware
> reported a final data write.  Reads, faults with unknown access direction,
> and implicit guest page-table writes do not authorize an emulated write;
> fall back to the existing permission-aware translation in those cases.

Why not?  As noted above, the GPA is the faulting GPA, not the final GPA.  If the
guest kernel is crazy/broken enough to try and put its page tables in emulated
MMIO space, then IMO it's a-ok to assume the guest has given userspace permission
to generate writes to those addresses.

Then it doesn't matter what protections the final translation has, and so the SEV
problem goes away.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 064ecc33b926..223698cbb9be 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6632,6 +6632,16 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
>  		return r;
>  
>  emulate:
> +	/*
> +	 * A write during a guest page walk does not authorize the instruction
> +	 * itself to write to the faulting GPA.  Require a final write access
> +	 * before allowing the emulator to reuse the GPA for writes.
> +	 */
> +	if (direct && (error_code & PFERR_WRITE_MASK) &&
> +	    (error_code & PFERR_GUEST_FINAL_MASK) &&
> +	    !(error_code & PFERR_GUEST_PAGE_MASK))
> +		emulation_type |= EMULTYPE_PF_WRITE;
> +
>  	return x86_emulate_instruction(vcpu, cr2_or_gpa, emulation_type, insn,
>  				       insn_len);
>  }
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 79468ddfe473..8c46aa3468c2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5088,8 +5088,13 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
>  	 * Note, this cannot be used on string operations since string
>  	 * operation using rep will only have the initial GPA from the NPF
>  	 * occurred.
> +	 *
> +	 * The guest may have changed the instruction since the fault.  Reuse
> +	 * the GPA for writes only if hardware reported a final write access;
> +	 * otherwise, recheck permissions for the decoded access.
>  	 */
> -	if (ctxt->gpa_available && emulator_can_use_gpa(ctxt) &&
> +	if (ctxt->gpa_available && (!write || ctxt->gpa_write) &&

LOL, because I can't help myself.  In the spirit of evil bitwise operations when
doing paging protection checks, what if we do:

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 3e375af15c03..5b74fcd183f5 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -355,7 +355,7 @@ struct x86_emulate_ctxt {
 	struct x86_exception exception;
 
 	/* GPA available */
-	bool gpa_available;
+	u64 gpa_access;
 	gpa_t gpa_val;
 
 	/*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b3681796c75..7470ff762975 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5089,7 +5089,7 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	 * operation using rep will only have the initial GPA from the NPF
 	 * occurred.
 	 */
-	if (ctxt->gpa_available && emulator_can_use_gpa(ctxt) &&
+	if (ctxt->gpa_access & BIT(write) && emulator_can_use_gpa(ctxt) &&
 	    (addr & ~PAGE_MASK) == (ctxt->gpa_val & ~PAGE_MASK)) {
 		gpa = ctxt->gpa_val;
 		ret = vcpu_is_mmio_gpa(vcpu, addr, gpa, write);
@@ -5938,7 +5938,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 
 	kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
 
-	ctxt->gpa_available = false;
+	ctxt->gpa_access = 0;
 	ctxt->eflags = kvm_get_rflags(vcpu);
 	ctxt->tf = (ctxt->eflags & X86_EFLAGS_TF) != 0;
 
@@ -6454,7 +6454,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 		/* With shadow page tables, cr2 contains a GVA or nGPA. */
 		if (vcpu->arch.mmu->root_role.direct) {
-			ctxt->gpa_available = true;
+			if (emulation_type & EMULTYPE_PF_WRITE)
+				ctxt->gpa_access = ACC_WRITE_MASK;
+			else
+				ctxt->gpa_access = ACC_READ_MASK;
 			ctxt->gpa_val = cr2_or_gpa;
 		}
 	} else {

Or a slightly less evil version:

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 3e375af15c03..5b74fcd183f5 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -355,7 +355,7 @@ struct x86_emulate_ctxt {
 	struct x86_exception exception;
 
 	/* GPA available */
-	bool gpa_available;
+	u64 gpa_access;
 	gpa_t gpa_val;
 
 	/*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b3681796c75..d6522e38008a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5089,7 +5089,8 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	 * operation using rep will only have the initial GPA from the NPF
 	 * occurred.
 	 */
-	if (ctxt->gpa_available && emulator_can_use_gpa(ctxt) &&
+	if (ctxt->gpa_access & (write ? ACC_WRITE_MASK : ACC_READ_MASK) &&
+	    emulator_can_use_gpa(ctxt) &&
 	    (addr & ~PAGE_MASK) == (ctxt->gpa_val & ~PAGE_MASK)) {
 		gpa = ctxt->gpa_val;
 		ret = vcpu_is_mmio_gpa(vcpu, addr, gpa, write);
@@ -5938,7 +5939,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 
 	kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
 
-	ctxt->gpa_available = false;
+	ctxt->gpa_access = 0;
 	ctxt->eflags = kvm_get_rflags(vcpu);
 	ctxt->tf = (ctxt->eflags & X86_EFLAGS_TF) != 0;
 
@@ -6454,7 +6455,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 		/* With shadow page tables, cr2 contains a GVA or nGPA. */
 		if (vcpu->arch.mmu->root_role.direct) {
-			ctxt->gpa_available = true;
+			if (emulation_type & EMULTYPE_PF_WRITE)
+				ctxt->gpa_access = ACC_WRITE_MASK;
+			else
+				ctxt->gpa_access = ACC_READ_MASK;
 			ctxt->gpa_val = cr2_or_gpa;
 		}
 	} else {
