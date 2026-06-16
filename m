Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA67284662;
	Tue, 16 Jun 2026 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570551; cv=none; b=sxv7tJg23HdvSR1v1Fj8YuNm9ZC1mqEDLfogGb6p25Iy+nJfQ2FrBbYfIsJuMwggQw1akEwK/Bcke3iJpsFRSnWPF4thDEnt/YbwDTR3CE8m+w6d45Jo9hTfq4BimSy++fszzUlgkDZTtqw7pzvfXw7dbBs0GLn7jwU3Vklh9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570551; c=relaxed/simple;
	bh=4rrjnjZuSN7wO5ytTRHuP1CHGA4LW6yahnBKy5qB200=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9Xr9axaneWGodf9IlfsMDeJJ4QKpqzKJJ52/PdunJMoW/87JMNGRdY3YwWh/MJ2ssagBPtq9V5LurkVwvETLM2OJKn7KjBjebyjvwFOL8G+odpz4BWdIzPb7t3qicIF8FWNLrbCGkEBY8xexedhZSXgGK9866BCD83Y7zle2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2gryD/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2gryD/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C431F00A3F;
	Tue, 16 Jun 2026 00:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570549;
	bh=m0fmHIWHR8tW6UxmMJ1xSJhCtXEmdU4yO+q+jGxzf/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2gryD/Tvb/upJIj1ayq0MYfWY0Dr52xOrkzZ5LYBSrKexhw9Kx3t0mBvubo0fZ3W
	 Ft/pkxcYNN3KFfm+8EMvr3P/zS43Gub8JFrhYXkokooSTJuRnfdY+dXoK+XxaXj3QJ
	 yh1HtTqfI5jAudry/LSV+9iHgUFX82AV42L0CmiUfGZ1q7+3s8Z+8rIYxL854InAH6
	 r+o9GFMJFoPpnNEZW7bfVNuSsWy1l7otS8wPjI8LBgblA8agoJ3LxI2Jzmt5Jf7jRv
	 JoZWvMo8lIWHNWU9jyinBIxHNuZ8yVZMrJrzE0b2o0lxZKCtNTJh44yaR6EJ2E0/Zg
	 RYraCejn/GHxQ==
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
Subject: [RFC PATCH v2 16/25] KVM: nSVM: Split nested_svm_transition_tlb_flush() into entry/exit fns
Date: Tue, 16 Jun 2026 00:41:45 +0000
Message-ID: <20260616004155.1435766-17-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The handling for the entry and exit TLB flushes will diverge
significantly in the following changes. Instead of adding an 'is_vmenter'
argument like nested_vmx_transition_tlb_flush(), just split the function
into two variants for 'entry' and 'exit'.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9a917d057aa8e..234724d8b4c54 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -685,7 +685,7 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
 	vmcb12->control.exit_int_info = exit_int_info;
 }
 
-static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
+static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	/* Handle pending Hyper-V TLB flush requests */
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
@@ -705,6 +705,14 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
 
+static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
+{
+	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
+
+	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
+	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+}
+
 static void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
@@ -712,7 +720,10 @@ static void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_v
 	svm->current_vmcb = target_vmcb;
 	svm->vmcb = target_vmcb->ptr;
 
-	nested_svm_transition_tlb_flush(vcpu);
+	if (target_vmcb == &svm->nested.vmcb02)
+		nested_svm_entry_tlb_flush(vcpu);
+	else
+		nested_svm_exit_tlb_flush(vcpu);
 }
 
 /*
-- 
2.54.0.1136.gdb2ca164c4-goog

