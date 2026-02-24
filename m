Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950F364020;
	Tue, 24 Feb 2026 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972467; cv=none; b=VeeKFchDF38eazJBgSQv6WQQSESls1a5aeLxEsRwg9Rwcv4oe00NQUGbyXJfCtd5lpgtgZVicM8XzS4/nXDO+bUaeDZ2if2WPcsNBici7W9h8ZkAoGtvDYHamZzOR44fJxmX+62fMBXi2lV3Pa/4ZyZBC3UbeU0kRvoyrNWGMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972467; c=relaxed/simple;
	bh=DV+TTPrOLl4mBHZuzEMhsKt2bk9xjJWqiVi/tNeYK8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErssH2zccjiqq5gTAvZLASxSXGC9cpCsli4GNwefrveKnxizQESGOxWa3zxWZpef3PWDQdrGOXwQeUsV7wqF8B1RMpI6WkAFxjBLnEQteqhgBNFKSbJHuP4nlcN4rSFNeWtZbvBXtoekFeuiF81+1BUmLdRLFgAZdvOd9KqSawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVh/QiC2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVh/QiC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A7EC19423;
	Tue, 24 Feb 2026 22:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771972467;
	bh=DV+TTPrOLl4mBHZuzEMhsKt2bk9xjJWqiVi/tNeYK8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVh/QiC2QRNwcGeWiGaw8/nHCoKNufaxsp2IQi9ba2/wXWwwTKkgwSFemkpiAhd5n
	 TrHMvA+fFLHfz2NU8NbddWaNC/fB8+Z4NLxJKUG+HkJwgih0W2MyqKwdbKeuS5OROv
	 EU3Q1IYhr9GilhVfUDTKKMsDRlPZWdNhubGvS9zIH0KUJO+0LNGSanuj3n84zZpGEo
	 VYxwaWbbcBAzjw4vxXgFosLLnqnD0YXvz1QO/gjjacFQZhAWh1lkkF9m7rUAOB/NLU
	 twQMTasEH577aeZC5Br2u6kAra3olyqCjHQ4Yt/Fqzd3TxhOJ4OY1MJT/ho3R4ldlQ
	 w2rXEJIBHO8sQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v6 14/31] KVM: nSVM: Call nested_svm_init_mmu_context() before switching to VMCB02
Date: Tue, 24 Feb 2026 22:33:48 +0000
Message-ID: <20260224223405.3270433-15-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260224223405.3270433-1-yosry@kernel.org>
References: <20260224223405.3270433-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for moving more code that depends on
nested_svm_init_mmu_context() before switching to VMCB02, move the call
outside of nested_vmcb02_prepare_control() into callers, a bit earlier.
nested_svm_init_mmu_context() needs to be called after
enter_guest_mode(), but not after switching to VMCB02.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5276e41605d43..13d1276940330 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -808,10 +808,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	/* Also overwritten later if necessary.  */
 	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
 
-	/* nested_cr3.  */
-	if (nested_npt_enabled(svm))
-		nested_svm_init_mmu_context(vcpu);
-
 	vcpu->arch.tsc_offset = kvm_calc_nested_tsc_offset(
 			vcpu->arch.l1_tsc_offset,
 			svm->nested.ctl.tsc_offset,
@@ -950,6 +946,9 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 
 	enter_guest_mode(vcpu);
 
+	if (nested_npt_enabled(svm))
+		nested_svm_init_mmu_context(vcpu);
+
 	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
@@ -1903,6 +1902,10 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
 	enter_guest_mode(vcpu);
+
+	if (nested_npt_enabled(svm))
+		nested_svm_init_mmu_context(vcpu);
+
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
 	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip, svm->vmcb->save.cs.base);
 
-- 
2.53.0.414.gf7e9f6c205-goog

