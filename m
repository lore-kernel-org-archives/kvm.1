Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395295;
	b=GxhcgJbPmS8HoKXOMZsOjcFdrC4Tb5C8imAZIsG5rRVe5XN69J5PO/veTLnIt/6QFIQD
	 kwp9rr2IweWKIEkMy8/xtq16CKUEyoEEbKlnwd/M3GnA2T7wm+VkfaISqip8OMBtCIUSD
	 EC6JgkuqtJOycBiOAPhPHEgQEqnICnf8QLSJgsb8rmLIT+bDhJjP+OZUe8RDIdhT8Tgmo
	 awrBo07rwc16d1Usd5VIIoHQlsGoD7JxLGN/KBmpEKqZZM9JKKevsasq5JreITOdKueDZ
	 QJ/jan8KatG5fVfoIPlUY1bogwCM27vPFz8Y0lDa+4BbRvYMy0JnoP/2pUPS0ocI/JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=zWm75tGn/A4widimTFSWHM28mEbNlDa0wqwtIGGfQ94=;
	b=Yx5fpebXmJyH7VIn5JUt2G+oGfDNR3rlziXRtNdXBJcqMGxEwGqyrxezL0jsKa/x1lFU
	 7ABd87nOJLQ0grLeJu0II4oyx5TO9EgrSenpDcAN6OxUBAf+vtI9y0enOAA5DViGOarWV
	 +lL5Ewla67Tw1TaLUqNH1no9GVex+WV+/tnGMKghJnPC+yHm9D7eYKjoS8ngGTLQf6ylh
	 /FJojbohy3zA7IWn7gK9QqPT1SNqzwMJzd5iANCx+pWak6NOxgzxNgn+p4RYxAaUFok5w
	 HDAC+FIajpnUbxYpQCIy7mlKFYwbSib+b1Af9gpAWAtyyVV36LVOrPjopEcfKl0eh8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CMU4HIji;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F78606D94A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20F78606D94A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CMU4HIji
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so699065a12.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395294; x=1794000094; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zWm75tGn/A4widimTFSWHM28mEbNlDa0wqwtIGGfQ94=;
        b=CMU4HIjidKHhY/+Nf7aYpreXxPQm6KvPM8zCMHiSpEc2KL8tgZgFjGh/XXQfrBC6ow
         QI91Kh+cH4VuRGsEET8CdmRypxbiAbLf3qEyq5aAvuL4X5gDGoo3nD1tgOXyQ3/ZydSO
         P/o+fWapVWlfSKBORm4WQ0c1xZycQ+RGiLTMLyxhMYFpc8p8Gfs8goqCBEd9TzvnRsMf
         2F9v2G+xB7N9UqVbY5GtibhhcdSQWaDQYK9vN+k8ZrUEnY1Hpr2f3pAIN82+bJ+F9osJ
         bxvDXHpMS6mEnxKvgm4qXde8+LLQFVTwptIQqRYsmdnLoQZ8BegaH1hBMUY+Xcnzq0b6
         X8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395294; x=1794000094;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zWm75tGn/A4widimTFSWHM28mEbNlDa0wqwtIGGfQ94=;
        b=TcGmjKF81Lx/dsHYZBxuy2ufvTDw2OjAMBkVofj+lbI9UFvNYCLvq16M1iYpTxiGFL
         woGeqrNIJrv8H3kNymefRltyjk66SowF5zkqpdhTLpZENxMbTISmPFK0IraLFc34U1vm
         b8EwOkp+4nKSt0utThkLunC9Qcoj+K9FqbP7KOIz5ryY7pI1yiYnAwM/5vHzFVvfWCaE
         weIgvWL1zkWS6PG1vZO5A4XqTiWWVAKXkr/utISFescztAzwP4jP8/gg/B2ieLYcAdyl
         e30ERLcGkrg31/WwtzLXqQwAqc1+Wxv4yR4PxlrHOTsA3lNmJ/5YS30NS//Iqrt/k2yl
         4nhA==
X-Forwarded-Encrypted: i=1; AKwUvBydJMehw5yAyjCBqDNc69xssCcyjIm5lYK2A4u9gMs/jcNE1qyVEsKdGg73NrvMtCqXIJI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLTE8zL64vl0VcssDrx1WAxXaAysO45CyRsl8R2okSe9LFMc/M
	MnIdP+nJLR8Ood5GGF6eJscD4vvDDVnQn7NJ55SNBHqy25V1sSXrlaIXQDVb16209j2p5QCSKuw
	xxQ0Ltg==
X-Received: from pgkz28.prod.google.com ([2002:a63:a5c:0:b0:cda:c74c:ca8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3b49:b0:3e1:e757:205e
 with SMTP id adf61e73a8af0-3e9290077e1mr2778969637.42.1793395294419; Fri, 30
 Oct 2026 14:21:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:05 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-18-seanjc@google.com>
Subject: [PATCH v4 17/23] KVM: nVMX: Don't explicitly VMCLEAR+free() vmcs01's
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
2.56.0.385.gac671c819a-goog

