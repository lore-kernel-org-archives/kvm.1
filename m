Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794949781;
	b=ZyOoUsbAiV73UhyZ8HycRIUlydVFS9/Ho/UW2Ld0E0AjQ7gsnKhhV04PgrlLjhvqanJx
	 mNRjnEM9Yt+WTz6MvftBPkrV+t5T8LSvUwczkxooa5rgk3jAL4g+zOBWWyOBc2O8QTRu1
	 2JC6FwZqcRPJjmWiU81ms47Ov0jxUVCAAScdqttts7+GgPhrmSxJQG2cau5Qt3PawTwzL
	 6s+t2AeEl+UdvU+jonGm7w37xv2gAN3zJC2ZNhB1Oya4hvxhQPBeAHeIYbQXbJYMyZUBi
	 YLO6vLrIvXROtXcTfWVNe6/ebqdz4JKSGYffwjxFHEYug4fSftdwxm6chDWCvjdqurA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=rxzzjh/xIBjlB8WI2uIiiOH9MqLHJlv2/r14cpA94us=;
	b=l41W2oRSIISexOIfAwp0Sla4ekZfeMBYcoksevn3E1+JYOw3jJCrpohbd8ze1E2xv7l/
	 9jggBzO+4pDuUnugMO32ZepZwww3Agf+8dm6SpqZePMYVvSWpZj5bPd0lSonPzk+E4uHv
	 nhXHhxxFGhP/3rJICTV+gLupPX4rc+0ZCefCbjfWnG0dvziV0DJb7q1Oqz0DilcFHr/hs
	 Ywwt+OrMjHEnTWCn4gEYBb3h0dtOpTJD+5mZOYnSi/uWj0PCsYNw3vHujot1qaWdh2YFj
	 /uGJ81wrDJTgImtDMAa0O2R4V9GgQSBkTCsvEo7RtGIigr+2LHwUxh++FhgGKYzgN2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FqDVZQ11;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27948606A89F
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27948606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FqDVZQ11
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2efdb437759so1030855ad.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794949781; x=1795554581; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rxzzjh/xIBjlB8WI2uIiiOH9MqLHJlv2/r14cpA94us=;
        b=FqDVZQ1101sl4pVyPtw7h13H9qlO5MI+GVdLEDQYVAQKAU6WpqMA1BaOf5dzzSyO3p
         +yNWD4QRuB6sxMBjwv6S8j3OvJsSJ7q3MLhOdPO60Lm+63HZSJ0RySNArt19uKZ+yN+E
         XGu2+5uUGcBVJUtgJqv5mEShWY7aJwJKIwo0Qa0+7jrsGAn3mslRofHMY/iKJx7u83/O
         MRnJ3e+Y0aEupJBAG6SD4vY8yK5oGRjn9VDkFLh+8NJugnKz/ErvQyTGQncvemBej0m0
         X9Bzn1x9Jp91qLeHiGSFbRWgt+eK1KMPWvhsUrP5KsRyLaRR/qGhiup+vpg2SAOsb082
         mz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794949781; x=1795554581;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rxzzjh/xIBjlB8WI2uIiiOH9MqLHJlv2/r14cpA94us=;
        b=Izhk45Rd+iRstVP/c1+6AZAnWhVKrcN0Zmd9XzEohPp87CE67G2e6TCA4QlfynI1Ip
         MJ57wZmpdzSiE6/HRAY57X8ZOtziZ5zO79gMGZbI59TzTJVQ7tUzSaOe49bcFRCMInjB
         UwWsp+2BIC0BZMZf8kPTBycXr7yn/bwXVWSb6v2msXsQNNAgNfi9tdbWIu4Ot9ISqpN8
         3FK9PSRpL1AqREXDoQMvlp3jh46ieZonuse7GKvIehXPcA50Fy/kEjjOPf7Y6bg5beYF
         9DxQm+ptP8zRaHlnRmMGMFVqH3DcO+QVQUx/qBf2saiFiFeWxP5vmE3nneTwt6QbJSnd
         6uZQ==
X-Gm-Message-State: APuU4Z+94cO4ivrI35mIzGI/cnwKIsgZ5w0tA2mgHbdgBdV1Uv5YIYw3
	M7gGqVnOlsc/HvWVkcfET9iemi4lS5IdtTGzG21E0Yw94pfz7tw0r5u8lLnPltYCTFNB8tEfdMv
	B5KuqsQ==
X-Received: from plco15.prod.google.com ([2002:a17:902:e28f:b0:2eb:3675:626c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e950:b0:2e9:46a9:9b56
 with SMTP id d9443c01a7336-2efd9b75510mr31419505ad.21.1794949780536; Tue, 17
 Nov 2026 13:09:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 17 Nov 2026 13:09:33 -0800
In-Reply-To: <20261117210934.7765-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117210934.7765-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117210934.7765-5-seanjc@google.com>
Subject: [PATCH v2 4/5] KVM: x86: Consolidate nVMX vs. nSVM logic for loading
 CR3 on nested xfer
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	syzbot@syzkaller.appspotmail.com, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dedup nested_{svm,vmx}_load_cr3() into kvm_nested_load_cr3(), and drop
several MMU exports that existed purely to support the related vendor code.
Except for slight differences around PDPTRs, the logic and reasoning for
handling CR3 and PDPTRs on nested transitions is identical between Intel
and AMD.

Add a KVM_BUG_ON() in nested_vmx_load_cr3() to ensure that the new helper
doesn't unexpectedly fail when PDPTRs aren't being reloaded.

No functional change intended (the new KVM_BUG_ON() is unreachable).

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c    |  2 --
 arch/x86/kvm/regs.c       | 24 ++++++++++++++++++++++++
 arch/x86/kvm/regs.h       |  2 ++
 arch/x86/kvm/svm/nested.c | 23 +++--------------------
 arch/x86/kvm/vmx/nested.c | 23 ++---------------------
 5 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f4b12d6aef55..9186e8e2ec10 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5475,7 +5475,6 @@ void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd)
 			__clear_sp_write_flooding_count(sp);
 	}
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_new_pgd);
 
 static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
 			   unsigned int access)
@@ -6275,7 +6274,6 @@ void kvm_init_mmu(struct kvm_vcpu *vcpu)
 			init_kvm_shadow_mmu(vcpu, cpu_role);
 	}
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_mmu);
 
 void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 3621f1a47d37..b43ad11f061c 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -201,6 +201,30 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(load_pdptrs);
 
+int kvm_nested_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
+			bool nested_tdp, bool reload_pdptrs)
+{
+	/*
+	 * If TDP is enabled, then the PDPTRs either come from the VMCS (EPT)
+	 * or are read from memory on-demand (NPT), i.e. aren't loaded here.
+	 */
+	if (reload_pdptrs && !nested_tdp && is_pae_paging(vcpu) &&
+	    !load_pdptrs(vcpu, cr3))
+		return -EINVAL;
+
+	vcpu->arch.cr3 = cr3;
+	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
+
+	/* Re-initialize the MMU, e.g. to pick up CR4 MMU role changes. */
+	kvm_init_mmu(vcpu);
+
+	if (!nested_tdp)
+		kvm_mmu_new_pgd(vcpu, cr3);
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_nested_load_cr3);
+
 static bool kvm_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 97c17b120a57..3c34ca7d8a8e 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -64,6 +64,8 @@ unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu);
 unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
+int kvm_nested_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
+			bool nested_tdp, bool reload_pdptrs);
 
 static inline bool is_long_mode(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 32f95c9d72be..a045cb5ba9ff 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -710,30 +710,13 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
 
-/*
- * Load guest's/host's cr3 on nested vmentry or vmexit. @nested_npt is true
- * if we are emulating VM-Entry into a guest with NPT enabled.
- */
 static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 			       bool nested_npt, bool reload_pdptrs)
 {
-	if (reload_pdptrs && is_pae_paging(vcpu)) {
-		if (nested_npt)
-			kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR);
-		else if (CC(!load_pdptrs(vcpu, cr3)))
-			return -EINVAL;
-	}
+	if (reload_pdptrs && is_pae_paging(vcpu) && nested_npt)
+		kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR);
 
-	vcpu->arch.cr3 = cr3;
-	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
-
-	/* Re-initialize the MMU, e.g. to pick up CR4 MMU role changes. */
-	kvm_init_mmu(vcpu);
-
-	if (!nested_npt)
-		kvm_mmu_new_pgd(vcpu, cr3);
-
-	return 0;
+	return kvm_nested_load_cr3(vcpu, cr3, nested_npt, reload_pdptrs);
 }
 
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ef4ca1906fb0..6adfd1fe7fa6 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1225,35 +1225,16 @@ static bool nested_msr_store_list_has_msr(struct kvm_vcpu *vcpu, u32 msr_index)
 	return false;
 }
 
-/*
- * Load guest's/host's cr3 at nested entry/exit.  @nested_ept is true if we are
- * emulating VM-Entry into a guest with EPT enabled.  On failure, the expected
- * Exit Qualification (for a VM-Entry consistency check VM-Exit) is assigned to
- * @entry_failure_code.
- */
 static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 			       bool nested_ept, bool reload_pdptrs,
 			       enum vm_entry_failure_code *entry_failure_code)
 {
-	/*
-	 * If PAE paging and EPT are both on, CR3 is not used by the CPU and
-	 * must not be dereferenced.
-	 */
-	if (reload_pdptrs && !nested_ept && is_pae_paging(vcpu) &&
-	    CC(!load_pdptrs(vcpu, cr3))) {
+	if (CC(kvm_nested_load_cr3(vcpu, cr3, nested_ept, reload_pdptrs))) {
+		KVM_BUG_ON(!reload_pdptrs, vcpu->kvm);
 		*entry_failure_code = ENTRY_FAIL_PDPTE;
 		return -EINVAL;
 	}
 
-	vcpu->arch.cr3 = cr3;
-	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
-
-	/* Re-initialize the MMU, e.g. to pick up CR4 MMU role changes. */
-	kvm_init_mmu(vcpu);
-
-	if (!nested_ept)
-		kvm_mmu_new_pgd(vcpu, cr3);
-
 	return 0;
 }
 
-- 
2.56.1.703.gf848ed807c-goog

