Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139148;
	b=csiQpNu1cRAeWXHkpOFksb9W1XkJ2wG3RKwzKax3As+is0Ov4q0X1/56EO0vX1kwbdeq
	 hoTshJwRXKYgTobmJ57es2I2rtNG0xFYvJdYyXQ03bR+ugoPA6iA7OQ8u0DGpzgvTZpaL
	 6bF6kIs+l3Aw6R/FjTNEJVMNlIGX0uFqcAAYDGPiBaDL91PMip8//faLwHC3LkH5+2v4b
	 LdV3BqCXXl8kBFxf8HoIgR3cfuUy8oXTJgDb/U8f+NMY4sjATm3poZ8wQHp5vKzpgvbfs
	 hq8TCb/C0hiBJVIipv3M1J3rJXj8alnuSOYrAEhjrZ1vCWPLadK7XUNBXudHdSib1+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=eF/MVMbJDhLKDA2GRNVDooADE6A9y38RXKzwMieQl+Q=;
	b=Db7oxNy4S99kO6rlDxdsVXZVorTeXN73KlZGHsyXrWyGooNsZQz8SLrHCxIkWmBQaAXd
	 xfTCeWtLYRpAvL9zeN2EBASDuP3KCJrn09hFavlTk3cgkLvHLD2WijKnhojgAxrhaVqra
	 bwN8o08hbHb/LKxkdSbr3OYGGFOItLWafTzqNR0pVrPuX6x9zHeF4wSP15+7Srb3ZT9F/
	 b7+gfZGbfXTZ2kiiQGwfKecHZQB3GLmB+1AllK0fzvE8ZLSx6aSocBmbJ5IwwiVxOk0By
	 bBlobTDtuWrK3U+XSDDfbIByWX6hDeZQAa+6fwb3bC7LRuqFv1tXeBkg1Hp/aNDTv8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nUTBHYYF;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F960A382F
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D32F960A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nUTBHYYF
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ea63087d79so2352995ad.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139147; x=1793743947; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eF/MVMbJDhLKDA2GRNVDooADE6A9y38RXKzwMieQl+Q=;
        b=nUTBHYYFduzq2dvDp+9jFO/tKBxHj3xzcq32vktGYzntGARUmiCOlESTzZHi/K2jSK
         fw9kJr5SXXJmsZjyMPDA8BCfpWSG1Wty5qJmRyeAsljrouyqDTK0EDwsxWHp/DPOsZM3
         sso3NQp5ngbLkWWGf4cmRsQNCDFZlAnrqX9nJ5ok4OeHQx/dJxoFvk3+1yX7qNX2q50N
         N5GQxnPZa501OoyG+ewLgTpWXqWxoloZC9gReoqNUk/r/XvM3bjI4Mf7xlHWdFwO5hxQ
         WLoGrkd3ZUXuaVABEBqy7Y7tkGLeHkjn6EDA27m6A1LFxdGl9gPPWV8nonuc9n92Wamp
         5rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139147; x=1793743947;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eF/MVMbJDhLKDA2GRNVDooADE6A9y38RXKzwMieQl+Q=;
        b=l4KldgbIYDL5h2jblk+bwJWN/dixZTNFi8NT24MYAjz+jKh/qP1ee7H0MZA06+Zj8K
         3SQQPScRm9yqjPFD/e41SaRMSJxvECRFeailN71mF7l0Q9kH1dwQH/4aqLJpvCHaKJRM
         Gmol+2cheyPqAI+Q1gb2oEXMszWd3lx5+9MtIoS4R58PkEFxMylymgZ7pBq1U9z/ELPd
         jDSIoH8GdhQet4842hNzr4Vt1gEoqE0nfWNYlnOjQbPb6bbTSjssfW5IIeIGVNmggWhn
         t30Pw+PKQMDLUzo0Z2z+onAAYcc1DQp87dE9kfwvnI4nMm3N34m1EzLOQ83t6EIoCEXK
         1wFQ==
X-Forwarded-Encrypted: i=1; AKwUvByXI74JLc9na5w24AYji7QYOft2go321c6IcMqCCJ60gWp911k/NVmIyjKgAwIC4JDbxNE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzdTHGTqhhDD571PS4RT3BgDbD/0WGvL+0d1PNMQjeKvCoUstT
	mob84mY5RUCGtu+kcxSb0DKHOoe2dpAP8LFYza6DmbUTZmkY3IUftwGVkXuMNlpbaTXp5hNFfxG
	bVVUszA==
X-Received: from plcr1.prod.google.com ([2002:a17:903:141:b0:2e8:1f84:7c18])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e5:b0:2e9:740c:36c
 with SMTP id d9443c01a7336-2eb0057bbbfmr5608715ad.41.1793139147130; Tue, 27
 Oct 2026 15:12:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:04 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-12-seanjc@google.com>
Subject: [PATCH v3 11/15] KVM: nVMX: Don't explicitly VMCLEAR+free() vmcs01's
 shadow VMCS when freeing vCPU
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Explicitly VMCLEAR and free() vmcs01's shadow VMCS only when doing VMXOFF
or forcing the vCPU out of L2, not when freeing the vCPU.  Instead, free
the shadow VMCS as part of free_loaded_vmcs(), i.e. when freeing vmcs01 via
vmx_vcpu_free().  This will allow leaving vmcs02 as the loaded/current VMCS
when freeing a vCPU, i.e. will allow dropping the vmx_switch_vmcs() call as
well as the vcpu_{load,put}() calls, all of which do far too much work when
freeing a vCPU.  E.g. "just" switching to vmcs01 means potentially doing an
extra VCLEAR shootdown, potentially multiple VMPTRLDs (to first load vmcs02
and then vmcs01) and VMWRITEs, and so on and so forth.

Note, shadow VMCSes are rather odd.  They're only ever used when nested
virtualization is live, but a shadow VMCS is provided to L1, not L2, and
more importantly is made "active" (in VMX parlance) when vmcs01 is run (the
shadow VMCS is referenced by a pointer in vmcs01).  Because KVM dynamically
allocates and frees nested state, shadow VMCSes are loosely coupled to the
VMXON/VMXOFF lifecycle, but in practice are more concretely tied to vmcs01,
e.g. a shadow VMCS needs to be VMCLEAR'd if and only if its associated
vmcs01 was launched.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 54 ++++++++++++++++++++++++---------------
 arch/x86/kvm/vmx/vmx.c    |  5 +++-
 2 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 49c4529901c5..1b30ad7731ee 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -330,17 +330,9 @@ static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
 	vmx->nested.pi_desc = NULL;
 }
 
-/*
- * Free whatever needs to be freed from vmx->nested when L1 goes down, or
- * just stops using VMX.
- */
 static void free_nested(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct vmcs *shadow_vmcs;
-
-	if (WARN_ON_ONCE(vmx->loaded_vmcs != &vmx->vmcs01))
-		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 
 	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
 		return;
@@ -353,6 +345,36 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	free_vpid(vmx->nested.vpid02);
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = INVALID_GPA;
+
+	kfree(vmx->nested.cached_vmcs12);
+	vmx->nested.cached_vmcs12 = NULL;
+	kfree(vmx->nested.cached_shadow_vmcs12);
+	vmx->nested.cached_shadow_vmcs12 = NULL;
+
+	nested_put_vmcs12_pages(vcpu);
+
+	kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+
+	nested_release_evmcs(vcpu);
+
+	free_loaded_vmcs(&vmx->nested.vmcs02);
+}
+
+/*
+ * Free whatever needs to be freed from vmx->nested when L1 goes down, or
+ * just stops using VMX.
+ */
+static void nested_vmx_do_vmxoff(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vmcs *shadow_vmcs;
+
+	if (WARN_ON_ONCE(vmx->loaded_vmcs != &vmx->vmcs01))
+		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
+
+	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
+		return;
+
 	if (enable_shadow_vmcs) {
 		vmx_disable_shadow_vmcs(vmx);
 
@@ -365,18 +387,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 		vmx->vmcs01.shadow_vmcs = NULL;
 		free_vmcs(shadow_vmcs);
 	}
-	kfree(vmx->nested.cached_vmcs12);
-	vmx->nested.cached_vmcs12 = NULL;
-	kfree(vmx->nested.cached_shadow_vmcs12);
-	vmx->nested.cached_shadow_vmcs12 = NULL;
 
-	nested_put_vmcs12_pages(vcpu);
-
-	kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
-
-	nested_release_evmcs(vcpu);
-
-	free_loaded_vmcs(&vmx->nested.vmcs02);
+	free_nested(vcpu);
 }
 
 /*
@@ -5606,7 +5618,7 @@ static int handle_vmxoff(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	free_nested(vcpu);
+	nested_vmx_do_vmxoff(vcpu);
 
 	if (kvm_apic_has_pending_init_or_sipi(vcpu))
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
@@ -6898,7 +6910,7 @@ void vmx_leave_nested(struct kvm_vcpu *vcpu)
 		vcpu->arch.nested_run_pending = 0;
 		nested_vmx_vmexit(vcpu, -1, 0, 0);
 	}
-	free_nested(vcpu);
+	nested_vmx_do_vmxoff(vcpu);
 }
 
 int nested_vmx_check_restored_vmcs12(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2ef1f634e7ec..292001bbcbff 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3089,7 +3089,10 @@ void free_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 	loaded_vmcs->vmcs = NULL;
 	if (loaded_vmcs->msr_bitmap)
 		free_page((unsigned long)loaded_vmcs->msr_bitmap);
-	WARN_ON(loaded_vmcs->shadow_vmcs != NULL);
+	if (loaded_vmcs->shadow_vmcs) {
+		free_vmcs(loaded_vmcs->shadow_vmcs);
+		loaded_vmcs->shadow_vmcs = NULL;
+	}
 }
 
 int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
-- 
2.56.0.307.g5fe7bd680c-goog

