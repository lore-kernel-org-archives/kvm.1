Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCC52FB969;
	Tue, 16 Jun 2026 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570550; cv=none; b=SQGxUBHqlP7IC+Az8ReAHYlhNeK93Q3XH2dkNLBN+2kT6xIwFunTgYQN+sQvxSNpdpu9Aqvi5MOFjHJgGd3D/Hn9N6VJ29P94oau352aLDA9KLDzuQtPuzUl+hagL0feFAxwLKNalieUXXfHl7RTeNPJYteJkpDZUKV3ZFb47cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570550; c=relaxed/simple;
	bh=WyFs4XvKt63vqlUnwZ5BEgN0eRUJcIE14TMa7w7t90w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llHkzAolv1aoT3GTQcHx9V/A5zv0v8DBkmNFxmqnkGSw280ETsB2UwDEpCf30vH4FqWbUvO8O2y9yDD0DFi51Nzf8LkOVWsm+QTcllM2/9KQzWScTF07C+tBNT1Z9nAwRNGbcLs2MjMJqxC+URppjEDGfVkQgXyPywcQKbg4ACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfN1Q/Ms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfN1Q/Ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318521F00A3E;
	Tue, 16 Jun 2026 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570548;
	bh=FUzfD6RlB8ixdnuiZoUSbc3Q7AAaGZQqvGIeb9508fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AfN1Q/Ms6xM/XB1EAJFLbEywELU8w134YOSYC3abOBR/IXjuKt29E4EaKAWPYf55O
	 OaFFkyqvZCZVPxjMsXEOLCaIWr7EEN4Bli1FjpWm+Svr6euzkpTd75YwpkZ3r4gQNi
	 k1ZbgxZKIC20DBo0SDc+kKJVrKAxla4IhMzQANVZPut7obZiC/8RV7N66dVVOFZl9K
	 V15kRneg2rag0KE9fvxK0lRYYtYMLxYrca0Dslc0l2ZCkvJGKGW9ulW0i3A++Ghq/e
	 lpm3IHCBSeQUnykTkZTkOmA4hFkoaC+/h2xMjadtkdoRPfWwtzmdwZqSvdoiGtrfZi
	 IrJReRpGTYtFw==
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
Subject: [RFC PATCH v2 14/25] KVM: nSVM: Move svm_switch_vmcb() to nested.c
Date: Tue, 16 Jun 2026 00:41:43 +0000
Message-ID: <20260616004155.1435766-15-yosry@kernel.org>
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

svm_switch_vmcb() is only used outside of nested.c to initialize
svm->current_vmcb and svm->vmcb. Open-code the initialization (which is
arguably not a "switch" to begin with) in the vCPU creation path, and
move svm_switch_vmcb() to nested.c in preparation for adding more nested
logic.

No fcuntional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  6 ++++++
 arch/x86/kvm/svm/svm.c    | 10 +++-------
 arch/x86/kvm/svm/svm.h    |  2 --
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index eb56c2fbf2832..24a52aefe94ee 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -705,6 +705,12 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
 
+static void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
+{
+	svm->current_vmcb = target_vmcb;
+	svm->vmcb = target_vmcb->ptr;
+}
+
 /*
  * Load guest's/host's cr3 on nested vmentry or vmexit. @nested_npt is true
  * if we are emulating VM-Entry into a guest with NPT enabled.
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4f13c3456a5d7..14733ff8bcd19 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1300,12 +1300,6 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		__svm_vcpu_reset(vcpu);
 }
 
-void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
-{
-	svm->current_vmcb = target_vmcb;
-	svm->vmcb = target_vmcb->ptr;
-}
-
 static int svm_vcpu_precreate(struct kvm *kvm)
 {
 	return avic_alloc_physical_id_table(kvm);
@@ -1353,7 +1347,9 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 	svm->vmcb01.ptr = page_address(vmcb01_page);
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
-	svm_switch_vmcb(svm, &svm->vmcb01);
+
+	svm->current_vmcb = &svm->vmcb01;
+	svm->vmcb = svm->vmcb01.ptr;
 
 	svm->guest_state_loaded = false;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6e98e02f7b8d5..4dcfd56882da5 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -922,8 +922,6 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_svm *svm,
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
 				    struct vmcb_save_area *save);
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
-void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
-
 
 static inline void __svm_pmu_handle_nested_transition(struct vcpu_svm *svm,
 						      bool defer)
-- 
2.54.0.1136.gdb2ca164c4-goog

