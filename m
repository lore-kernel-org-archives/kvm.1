Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5C303C8A;
	Tue, 28 Jul 2026 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198973; cv=none; b=k6/6i7Rs8w6m/5ejvhxrBgkS/MkQ/SdGRtYs/Yt+JNQYGORVRmTnIuYHiNdQ3HY2oVPcCNv28lh+bmYbGElHCaJL5Y3sT7m8SB4DQ11eqZdJ8GMgbsRUpKtE1UFH329OYdJFLPONBlHW7otuGQ1dBKYL2CSim6nlk2iO0VY7Jhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198973; c=relaxed/simple;
	bh=g8te7btCIe7glNb8OtVglvScQQOMB1VWCcox5J4VA2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpGSCR4zHFATfRbsuosQ4vKkLUwQuKzYBYsNrJtUndsPYORY+52DB5FOenM2ZwalfRaCmHqZd13WvPzq+7MoCNtzvabuBWm+LMr1OTX7RBdrZTr65tL1yufZMe6wyAed8RSsYFBQydvHBYVa5O6ywXEtszhlRYmalcI5m9AQt8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAy66cRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAy66cRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3B51F00A3D;
	Tue, 28 Jul 2026 00:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198972;
	bh=DvB9AUsVZjDJfihYd42gLTJOxfYyoiF4fYLnx9iQc2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OAy66cRc3oERgYd1YO4mV8QPamiuPefT3ROlav95eBZWKD16ilMTKKOfPVHCWGvJf
	 TT7OZ/5Dg9tHgcviWtTEbDjUWAH5tCoCEoTCW24RTf1KOqjxTA4xKxyD1sYtNqSbwF
	 NP2Oce0OLsRv9QGqkf7LR1a/bdF3PUeUv6l3GrS0h8zrABix+6xEZKWOu6bGj2uJsh
	 +MYNjCcoe0a5JczKL/b25YqkCojephc6qJqrtb+ODzuZZzMcqNRKm/L2gADZZOSwIr
	 5D7TTNwbbWegZGIrcapGALpzqrvZ7HOFaeNiI9PYzoTif8KfGc9ABZb4QSCx/ZIiqy
	 0ikWaL8S4kIeg==
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
Subject: [PATCH v1 17/28] KVM: nSVM: Always switch VMCB before leaving guest mode
Date: Tue, 28 Jul 2026 00:35:46 +0000
Message-ID: <20260728003557.1136583-18-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move svm_switch_vmcb() calls ahead of leave_guest_mode(), as nothing
between the calls depends on svm->vmcb being set to vmcb01. This makes
the nested VM-Exit path consistent with the nested VM-Enter path, and
having the calls to svm_switch_vmcb() and leave_guest_mode() close makes
it easier to reason about incoming changes that depend on both VMCB and
guest_mode context.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a6a49a5e0d90a..410d0f1aaa63c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1325,7 +1325,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (nested_svm_vmexit_update_vmcb12(vcpu))
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
-	/* Exit Guest-Mode */
+	svm_switch_vmcb(svm, &svm->vmcb01);
 	leave_guest_mode(vcpu);
 	svm_pmu_handle_nested_transition(svm);
 
@@ -1352,8 +1352,6 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
 		vmcb01->control.erap_ctl |= ERAP_CONTROL_CLEAR_RAP;
 
-	svm_switch_vmcb(svm, &svm->vmcb01);
-
 	/*
 	 * Rules for synchronizing int_ctl bits from vmcb02 to vmcb01:
 	 *
@@ -1537,6 +1535,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		vcpu->arch.nested_run_pending = 0;
 		svm->nested.vmcb12_gpa = INVALID_GPA;
 
+		svm_switch_vmcb(svm, &svm->vmcb01);
 		leave_guest_mode(vcpu);
 
 		/*
@@ -1548,8 +1547,6 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		 */
 		__svm_pmu_handle_nested_transition(svm, true);
 
-		svm_switch_vmcb(svm, &svm->vmcb01);
-
 		nested_svm_transition_tlb_flush(vcpu);
 
 		nested_svm_uninit_mmu_context(vcpu);
-- 
2.55.0.229.g6434b31f56-goog

