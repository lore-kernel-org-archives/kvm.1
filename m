Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE839D6CF
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281047; cv=none; b=LFR2HolBXgx0lF4sgKhHxDqWaKLjFPv30eJIvVt2WDG9ut6IvLQgv2llapo1qGBRSiPXYbimbvFC3xTctW+jZxOR+3p+6gqnxK7PRfRAH2Nh9RWz0hZ8ZiYbnCFG1PJYs02PFBrz3JO+dwet1WvDNuSiBkxdAjO9YOy2mL7GLPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281047; c=relaxed/simple;
	bh=PhXkz2bexYeFkd5Iu6TUPlzgb73A7DZO37TdKBxv6+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i5qPbCBwHrbSCu7ks54ApgSa4iE9SSAu7p+z6wIqVpY4J5KlhT6UAoH4Xi+uJdtH66uXCJdEYAH0Uxq6wOYVch72I9ZVVj53nxgaj0mUjqR3gh481w3R0DlGQz/k+rDlAbmoVBecgtXIozltVvPMQXYSGw3LdlwSi/R8uwKpgPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhGGgO3f; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhGGgO3f"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b79f4b35b7so23567275ad.0
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778281045; x=1778885845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjR7D57JfGZ1jeaZVCslZKEDVUUN8a3SBLn05f05nzk=;
        b=LhGGgO3f7rjXpIJHq0kdejDDr3kPcz28d9Yc0uZys+1FryiAYSmVtHzyYj4VZXbEz8
         1SkrA5BKj4I/nbeH0Yp88wYBNIvoqlvhqGv5wDmlzzX7rRn8Oru13lEy/lCQKgRUy+NK
         UTcNtJNXR89RNZr3qdE6EqPC2dlihK8BFUSmGgSMTvHoV34uY7cp5qwoXkly4pHC+6JK
         Ga3WpDL/o+zoy7Y/rqCIN2qP6/Va3f8Xim3OpQkxr9Yt478b5y45AaZfOxJHUoY81o2y
         kyJtxO2FvRROiDt9dOEBR8MNwjg/siFbVRbDjZY8v1rleEU66lPHy/JWNbOpp0idUyiK
         ewaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281045; x=1778885845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjR7D57JfGZ1jeaZVCslZKEDVUUN8a3SBLn05f05nzk=;
        b=itkdoCLvHdBah9fE9BiHRq6yT2aDZsnQl99q97QDiowpNL5d0O5EpTJE14PE1SECSW
         2+rwEhK9t/Wc74S7ol9//6nVD5jq2MVijJDy9JuHt/2kX5syhXGJ34ZKmIbqMAPVpizY
         RI2Xi6P0LTdTS9uIr0lpP5yAAO30mpk/+X3BTZkEkZfQjs1aBlKegLblBpqTYzS+ZaGW
         561Kaokip+CovnI+hK5QHy8+UotaicqJlatMiKAIoZ3fONAoI9ivCsqrnWkHmtg4w71F
         bgL3nvkET2a9Hwl2vCI2kelUsUSeH/3C7aQmVZNfhAHX00RUEMqipIbbhVzIYkSPb6q8
         TQqQ==
X-Gm-Message-State: AOJu0YyJCjAkZKaf4gj+0gtoILBHtG5ZJfgrSSQc/UI8aZ5QunYF49LH
	PJV8tforzRvUAFvpBtjGZaqF+XWzhy9IzK30fB2NsEDEjZsv0S7sqOyYRiykAKEiSbOwDp2M78B
	0JKKKMw==
X-Received: from pga9.prod.google.com ([2002:a05:6a02:4f89:b0:c79:8c98:9814])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3390:b0:398:b95c:51f7
 with SMTP id adf61e73a8af0-3aa5ab27f40mr16463110637.37.1778281045155; Fri, 08
 May 2026 15:57:25 -0700 (PDT)
Date: Fri, 8 May 2026 15:57:24 -0700
In-Reply-To: <20260407063245.2755579-3-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407063245.2755579-1-nikunj@amd.com> <20260407063245.2755579-3-nikunj@amd.com>
Message-ID: <af5qVIXf06WyK4XG@google.com>
Subject: Re: [PATCH v6 2/7] KVM: x86: Move PML page to common vcpu arch structure
From: Sean Christopherson <seanjc@google.com>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, thomas.lendacky@amd.com, 
	bp@alien8.de, joao.m.martins@oracle.com, kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 07, 2026, Nikunj A Dadhania wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b77750a2efc2..909085a5dfb3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4934,7 +4934,8 @@ int vmx_vcpu_precreate(struct kvm *kvm)
>  
>  static void init_vmcs(struct vcpu_vmx *vmx)
>  {
> -	struct kvm *kvm = vmx->vcpu.kvm;
> +	struct kvm_vcpu *vcpu = &vmx->vcpu;
> +	struct kvm *kvm = vcpu->kvm;

There are 9+ existing uses of "vmx->vcpu" in init_vmcs().  I'd rather insert a
prep patch to pass @vcpu instead of @vmx, do to_vmx() at the top, and switch all
existing vmx->vcpu usage.

From: Sean Christopherson <seanjc@google.com>
Date: Fri, 8 May 2026 15:55:55 -0700
Subject: [PATCH] KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()

Pass @vcpu instead of @vmx to init_vmcs(), and switch all of the vmx->vcpu
usage to a simple vcpu.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c2c33a5f7dc..b8d517b03bb4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4823,10 +4823,11 @@ int vmx_vcpu_precreate(struct kvm *kvm)
 
 #define VMX_XSS_EXIT_BITMAP 0
 
-static void init_vmcs(struct vcpu_vmx *vmx)
+static void init_vmcs(struct kvm_vcpu *vcpu)
 {
-	struct kvm *kvm = vmx->vcpu.kvm;
+	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
 	if (nested)
 		nested_vmx_set_vmcs_shadowing_bitmap();
@@ -4851,7 +4852,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	if (cpu_has_tertiary_exec_ctrls())
 		tertiary_exec_controls_set(vmx, vmx_tertiary_exec_control(vmx));
 
-	if (enable_apicv && lapic_in_kernel(&vmx->vcpu)) {
+	if (enable_apicv && lapic_in_kernel(vcpu)) {
 		vmcs_write64(EOI_EXIT_BITMAP0, 0);
 		vmcs_write64(EOI_EXIT_BITMAP1, 0);
 		vmcs_write64(EOI_EXIT_BITMAP2, 0);
@@ -4863,7 +4864,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 		vmcs_write64(POSTED_INTR_DESC_ADDR, __pa((&vmx->vt.pi_desc)));
 	}
 
-	if (vmx_can_use_ipiv(&vmx->vcpu)) {
+	if (vmx_can_use_ipiv(vcpu)) {
 		vmcs_write64(PID_POINTER_TABLE, __pa(kvm_vmx->pid_table));
 		vmcs_write16(LAST_PID_POINTER_INDEX, kvm->arch.max_vcpu_ids - 1);
 	}
@@ -4898,15 +4899,15 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	vmcs_write64(VM_ENTRY_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.guest.val));
 
 	if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT)
-		vmcs_write64(GUEST_IA32_PAT, vmx->vcpu.arch.pat);
+		vmcs_write64(GUEST_IA32_PAT, vcpu->arch.pat);
 
 	vm_exit_controls_set(vmx, vmx_get_initial_vmexit_ctrl());
 
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_set(vmx, vmx_get_initial_vmentry_ctrl());
 
-	vmx->vcpu.arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~vmx->vcpu.arch.cr0_guest_owned_bits);
+	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
+	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
 
 	set_cr4_guest_host_mask(vmx);
 
@@ -4921,7 +4922,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 		vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
 	}
 
-	vmx_write_encls_bitmap(&vmx->vcpu, NULL);
+	vmx_write_encls_bitmap(vcpu, NULL);
 
 	if (vmx_pt_mode_is_host_guest()) {
 		memset(&vmx->pt_desc, 0, sizeof(vmx->pt_desc));
@@ -4934,13 +4935,13 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	vmcs_writel(GUEST_SYSENTER_ESP, 0);
 	vmcs_writel(GUEST_SYSENTER_EIP, 0);
 
-	vmx_guest_debugctl_write(&vmx->vcpu, 0);
+	vmx_guest_debugctl_write(vcpu, 0);
 
 	if (cpu_has_vmx_tpr_shadow()) {
 		vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, 0);
-		if (cpu_need_tpr_shadow(&vmx->vcpu))
+		if (cpu_need_tpr_shadow(vcpu))
 			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR,
-				     __pa(vmx->vcpu.arch.apic->regs));
+				     __pa(vcpu->arch.apic->regs));
 		vmcs_write32(TPR_THRESHOLD, 0);
 	}
 
@@ -4951,7 +4952,7 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	init_vmcs(vmx);
+	init_vmcs(vcpu);
 
 	if (nested &&
 	    kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_STUFF_FEATURE_MSRS))

base-commit: 4c88d35f51436169884ce87bcf26f31e10106e71
-- 
