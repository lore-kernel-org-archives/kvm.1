Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77E34B66F;
	Tue, 16 Jun 2026 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570555; cv=none; b=TgfbTPS08WeHBcUjbv0dF6Y4Lf4cbIYdqCQULDlS9kHx4uxFQX3JjlcmqGf4P4Qo/Wb6QSrZCjfH3ifcu1O3AyhEZo1ItSRcrFD+5ulkxfX/C6dxO0+b6lv7p29h6XIMpCtN1zEdcbolUKTwIBPnanM7tZ2SoB8sfIfaWu0ODXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570555; c=relaxed/simple;
	bh=Nwv6A2hlawgWjpLl9BFE5FURbQtzL3uyxm5QuxdH2Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbJWhGawEHyX1tszBb4p6ujmwXe3pxQrVEVs+pQ24IuyYfd2hjo7wTTEUxKUPbhJEANM7QiJYI0MZrv8IGfcrDRvpDWxrp4YF1liGYMPQWVXE6v03pfoNwdLY3ClXlgU+lyX2bQ7FSCQ4bo8ZHCk9uv67vW+xWDavppSrrznq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKzeENHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKzeENHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326681F00A3E;
	Tue, 16 Jun 2026 00:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570553;
	bh=8hfhbly4HMg30tK2wZccXzJFpflIozCL4dabX147aSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKzeENHAHJmWM3LKbBauPgQDG/PIMnmYsahhiw4pwvlBqhI4F1a/yn35FzEz+D1VN
	 ISwa+Pq09efET3R9MAlPQYMbY1365f7hFlD+q5gCtxzAv9tO34e9n8SFzbmjNLe0av
	 VKjv+cToIoYxPFXqwYWaYsI9V3hq2nCi58bMo4XTP5z+SGqPBnTxaTnSuaxhDQMEwZ
	 McEIV6fS1fa4F2BkZ2Q3CLSNdQ0bJLTaMy7SIszbns8d7uP/mRcfyFKSzOyDrfjliB
	 +X9OE246ynHvLyjLUDL+79ENHzbh6P5ggrk+dE7gEeXTkc1phetGSirG6djWvpE7Wf
	 4hvzmaZcNtwgA==
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
Subject: [RFC PATCH v2 24/25] KVM: nSVM: Use different ASIDs for L1 and L2
Date: Tue, 16 Jun 2026 00:41:53 +0000
Message-ID: <20260616004155.1435766-25-yosry@kernel.org>
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

Now that TLB flushes are properly handled and tracked for L1 vs L2
ASIDs, allocate a separate new ASID for L2 for each vCPU, similar to how
VMX handles VPIDs. Drop the unconditional flushes and syncs on nested
transitions.

On a Turin CPU, this results in 8-15% performance boost in CPUID rate
microbenchmark [1] and netperf TCP_RR latency/throughput.

[1]https://lore.kernel.org/kvm/20231109180646.2963718-1-khorenko@virtuozzo.com/

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a226aca8f9108..56b769b603ca9 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -718,10 +718,6 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 			kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 	}
-
-	/* TODO: optimize unconditional TLB flush/MMU sync */
-	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
 
 static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
@@ -733,9 +729,6 @@ static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
 	/* Flush L1's own ASID if it request a *full* TLB flush on VMRUN */
 	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
-
-	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
 
 static void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
@@ -1539,7 +1532,7 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 	if (!svm->nested.msrpm)
 		goto err_free_vmcb02;
 
-	svm->nested.asid02 = svm->asid;
+	svm->nested.asid02 = allocate_asid();
 
 	svm->nested.initialized = true;
 	return 0;
@@ -1557,6 +1550,8 @@ void svm_free_nested(struct vcpu_svm *svm)
 	if (WARN_ON_ONCE(svm->vmcb != svm->vmcb01.ptr))
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
+	free_asid(svm->nested.asid02);
+
 	svm_vcpu_free_msrpm(svm->nested.msrpm);
 	svm->nested.msrpm = NULL;
 
-- 
2.54.0.1136.gdb2ca164c4-goog

