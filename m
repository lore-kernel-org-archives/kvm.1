Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9E27A462;
	Tue, 16 Jun 2026 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570548; cv=none; b=YAZF8IKCeVCzLf/3kWQbpDlHhkI6qtg8nV290uUdJ8hv7WGr47eYEfkmYYGZtxrZIoDQZt+r3MHodlh6BH/Fwk5R8d6La6TeeTk5fKtzfewQgZeeBdUrjSI+MYzHjAgSiof13NJ4JSgx/8SrtHvH6rFcMRkKEtTSOesJem/edQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570548; c=relaxed/simple;
	bh=//giSpm4PF9eQXJ7jEEvomKFax+1x7DP/TyzpdolYDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2Rlp31iZXAqgaSFAhIH7+2tCOLOGjFbRwWftqoS7jhmchOc33cnCOwSz4DRdjSKG4I9TIqehc/lWasKjd9pfhMKmmwSBi+WCfkXTCCGuMk4S5DZ6OWpIlhAFqbCAIh3GDFCYBb8scTR1BC4ZkrVZ9HIT0Wb+Wzm6NWFUtUlhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhW/byDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhW/byDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B811F000E9;
	Tue, 16 Jun 2026 00:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570546;
	bh=Em6M7oMQBqemDXYmUZLyR7uDq9CWwWSb8sU3c4wzlxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YhW/byDBQX4iW5/oAFZxj3KjPEVA7pORqFL9P+1a0x9VUrPThkKVZMMydCK0hxI7l
	 r+zYrr8HTQQ+/aJETAylvWkSpv4WAnUeDnQV4lnHyolmvWfm816/mTrGva26bunIN7
	 1SR57dyVkMw2DVPPpli1JSZ2FlCVIS3GyYKnt59ogHfEEXo4GpUqb7LBwkP8JPagu4
	 poYWybZ3AK1ypsuL0RV83YHjrbEAvD3NKmctHHK55AI2Y9BYJRNKz7NBBAfRa5Fbtz
	 I1f6cVZXD65Uh0/a9LcolUF8yz2VTrwyjpOgE5VYE6Pr+x/UK6NOjPdcistuhPruF+
	 MAizUU8s+w1Tg==
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
Subject: [RFC PATCH v2 10/25] KVM: nSVM: Add a placeholder ASID for L2
Date: Tue, 16 Jun 2026 00:41:39 +0000
Message-ID: <20260616004155.1435766-11-yosry@kernel.org>
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

In preparation for introducing a separate ASID for L2, introduce a
'placeholder' ASID that is still the same as L1's ASID. This will
facilitate future changes that need to distinguish L1 and L2's ASIDs,
before actually using a different ASID for L1 and L2.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 5 +++--
 arch/x86/kvm/svm/svm.h    | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 66c5b5131cbb1..bc8c466a1f821 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -698,7 +698,6 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	 *  - Honor L1's request to flush an ASID on nested VMRUN
 	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
 	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
-	 *  - Flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST
 	 *
 	 * [*] Unlike nested EPT, SVM's ASID management can invalidate nested
 	 *     NPT guest-physical mappings on VMRUN.
@@ -925,7 +924,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	else
 		vmcb02->control.bus_lock_counter = 0;
 
-	vmcb02->control.asid = vmcb01->control.asid;
+	vmcb02->control.asid = svm->nested.asid02;
 
 	/* Overwritten later if necessary.  */
 	vmcb_clr_flush_asid(vmcb02);
@@ -1495,6 +1494,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 	if (!svm->nested.msrpm)
 		goto err_free_vmcb02;
 
+	svm->nested.asid02 = svm->asid;
+
 	svm->nested.initialized = true;
 	return 0;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 4442e9fd4f5d0..6e98e02f7b8d5 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -232,6 +232,8 @@ struct svm_nested_state {
 	 */
 	struct vmcb_save_area_cached save;
 
+	kvm_tlb_tag_t asid02;
+
 	bool initialized;
 
 	/*
-- 
2.54.0.1136.gdb2ca164c4-goog

