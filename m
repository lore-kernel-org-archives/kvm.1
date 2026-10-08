Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ED92139C9;
	Thu,  8 Oct 2026 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418483; cv=none; b=uXjiY0OX98ckt5DLLV1paRr9ik4/fu8U3MSt9tINI7GkaZ3H6JCtCBEfWulnMm36rh1O5KgJMSOw/EktvTwD61CrcDWVo1AD48Q04eYlj37J+9Q3yMcx9w42c2Zez3afEfdciX/mBChjSEKs9FCbi1HAtIHeuwDmLpkxKJh61uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418483; c=relaxed/simple;
	bh=5PdpEjOxd7nzrpJ1OwxrSZ8jRDSPZfukDUF4WT8lr/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4WM/emIiZfyie0wRA4ds047gTo0zJB1r0tSD2B2gCq40r9/ORGFU4+vhR/VZ3eIUBnjcaw4jXhCk1BgS4yOPmWdgIxHxms7nVHzRFCQUucZOotw6xM+qiWLGvyiuULPV8VetWw79iLZQhgeNON9u6Q3EPLIi7r5nzfHc4kpeqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/mJYaje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/mJYaje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8531F000FF;
	Thu,  8 Oct 2026 00:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418481;
	bh=0m3GwTAJsKXB7sGbRqRHvWUcNe8iQYkhafabYvAguX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R/mJYajeAZC85YKgLQ4lIjLjIDBZfmtiUZAPFelhYSFqYrjB86KAV16cTzcRVhUmx
	 I6+pDHRv7fErBBfNAPQwMbYwgYzsJwuSRk3C3qRqMfC4EBvnOEZ8VUpz8UKEg8Gxm8
	 hwQWZvW4SFheXtYxGqMzW5hVnqgz9NHAxFAgj7YssovQxln/tHrVAw65sDxIM0vAXa
	 irqo02bM6RGMJhKwXuBReV1a488iq4ZyEloqFoUOvZ7nect0EyoI+FjRNFIlSwKscV
	 XHB2PDyubJiScQrF52LZMSEuf2aWufkyEWnRZ5Kv/pj6MwbGI/65yvg3WQx0koNXh9
	 OvFYjqzIv5CnA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 05/29] KVM: SVM: Add helpers to set/clear ASID flush in VMCB
Date: Thu,  8 Oct 2026 00:14:01 +0000
Message-ID: <20261008001425.2458927-6-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce set/clear helpers to set tlb_ctl to
TLB_CONTROL_FLUSH_ASID or TLB_CONTROL_DO_NOTHING. Incoming changes will
eliminate the use of TLB_CONTROL_FLUSH_ALL_ASID except as a fallback
when FLUSHBYASID is not available, so the helpers will create a common
path for this.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  2 +-
 arch/x86/kvm/svm/sev.c    |  2 +-
 arch/x86/kvm/svm/svm.c    |  4 ++--
 arch/x86/kvm/svm/svm.h    | 10 ++++++++++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 2bfc9d2c341b1..c3c12a4d6fe07 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -939,7 +939,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/* Done at vmrun: asid.  */
 
 	/* Also overwritten later if necessary.  */
-	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+	vmcb_clr_flush_asid(vmcb02);
 
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fad72cab76cf4..74c4555a32650 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3637,7 +3637,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 		return 0;
 
 	sd->sev_vmcbs[asid] = svm->vmcb;
-	svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+	vmcb_set_flush_asid(svm->vmcb);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44f..ad4f172f170d9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4327,7 +4327,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * VM-Exit (via kvm_mmu_reset_context()).
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_FLUSHBYASID))
-		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+		vmcb_set_flush_asid(svm->vmcb);
 	else
 		svm->current_vmcb->asid_generation--;
 }
@@ -4746,7 +4746,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	if (!svm_is_vmrun_failure(svm->vmcb->control.exit_code)) {
 		this_cpu_ptr(&svm_data)->flush_all_asids = false;
-		svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+		vmcb_clr_flush_asid(svm->vmcb);
 
 		/*
 		 * Unconditionally mask off the CLEAR_RAP bit, the AND is just
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6d0242966dc87..ba5077b9838c0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -480,6 +480,16 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
 	vmcb_mark_dirty(vmcb, VMCB_NPT);
 }
 
+static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
+{
+	vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+}
+
+static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)
+{
+	vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+}
+
 static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
 {
 	return container_of(vcpu, struct vcpu_svm, vcpu);
-- 
2.56.0.360.g66cac248cb-goog

