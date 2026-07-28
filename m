Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE23815FD;
	Tue, 28 Jul 2026 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198978; cv=none; b=p8wjVob6nZ6tfDFp7VYYOj3dICEjBVX2ln/rk/0VW7FWvVe9zRvHR2IUYJ8sydMssOO39wyQ5IOFsWeAyf78JGO3tuvAm9K3gQF1y6TL6h0iT02ZB+LATK5k/NCiYXPUt+U8Up9kfwQtPkUgQYOWawvIVA0Hj8T2mXKPktwDeKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198978; c=relaxed/simple;
	bh=RkYUx88fY4zurD1Hbj69O0BKo+VCErzAUp0PO8bDJYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffnWL1Nf1r6YQGgxoQv73mT2US+fWtZKWXJa9SjxlVfty6Ql+ZsvZKBw1tWkgQmmtZVxceB0V4Op7kW/m+yLGdmJqE8JvZzp6qbuqBz+p2KP90Gw69vsYA/pBkXISWMg5cH5nRkyQtAY45sQcNsOsP6TtTthTdUfdCk65cSdo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqK1ubih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqK1ubih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967EF1F00AC4;
	Tue, 28 Jul 2026 00:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198976;
	bh=V33hc6g0aP6g7iKZMXBkDPJb8SfYTn2XAjkmI0NbD1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HqK1ubihWif+np32tt1usSnb9lE0kGGfD3rWjv13Dr8Jn7B2+JGQL05DH4FNZvxHI
	 QY6AxoyfWfKbD5QSpj4gdtUCPbDXytg6hwn5CCFety9jBoAOpXjXD9UaxUqOthji/D
	 Ct9m3scWdkdiQFD5/ud/Yet9LfaZ9tscSqFB4WJ5yqnARkCuFfdYF+MxLORuz3YKEa
	 T9Xfs1FqjeA3KbFfMErTOeqYrenVrTINQnZ1k5Ip+ZglfgOr6yCSGWYD2mb/sDeQY8
	 0qckZKufbWD1KqOlWuEWjWTzTxbyO30/U6L91gndrwAmLx12v/Z3oIT0Nz2BZa7FEv
	 YHfPUEeLhPkgA==
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
Subject: [PATCH v1 27/28] KVM: nSVM: Use different ASIDs for L1 and L2
Date: Tue, 28 Jul 2026 00:35:56 +0000
Message-ID: <20260728003557.1136583-28-yosry@kernel.org>
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

Now that TLB flushes are properly handled and tracked for L1 vs L2
ASIDs, allocate a separate new ASID for L2 for each vCPU, similar to how
VMX handles VPIDs. Drop the unconditional flushes and syncs on nested
transitions.

Initialize last_asid to 0, such that the L2 ASID is always flushed on
first nested VM-Enter after it's allocated.

On a Turin CPU, this results in 8-15% performance boost in CPUID rate
microbenchmark [1] and netperf TCP_RR latency/throughput.

[1]https://lore.kernel.org/kvm/20231109180646.2963718-1-khorenko@virtuozzo.com/

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9ea8f21be9940..659e9da43945a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -707,6 +707,10 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 	 * context is not tagged by the ASID, so the shadow NPTs cannot be
 	 * reused across different L2 ASIDs.
 	 *
+	 * Note, last_asid is initialized as 0, so the first nested VM-Enter
+	 * after setting EFER.SVME will always flush the TLB to avoid using
+	 * stale entries.
+	 *
 	 * If L1 requested a full TLB flush for all ASIDs (including its own),
 	 * L1's own ASID is also flushed on nested VM-Exit, before running L1.
 	 *
@@ -727,10 +731,6 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 		WARN_ON_ONCE(svm->asid != fallback_asid && !is_sev_guest(vcpu));
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 	}
-
-	/* TODO: optimize unconditional TLB flush/MMU sync */
-	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
 
 static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
@@ -745,9 +745,6 @@ static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
 
 	if (svm->asid == svm->nested.asid02)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
-
-	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
 
 /*
@@ -1554,7 +1551,20 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 
 	svm->nested.vmcb02.ptr = page_address(vmcb02_page);
 	svm->nested.vmcb02.pa = __sme_set(page_to_pfn(vmcb02_page) << PAGE_SHIFT);
-	svm->nested.asid02 = svm->asid;
+	svm->nested.asid02 = allocate_asid(&svm->vcpu);
+
+	/*
+	 * KVM uses a fallback ASID when out of ASIDs, and fails vCPU creation
+	 * if there's no fallback ASID. ASID allocation must succeed here.
+	 */
+	KVM_BUG_ON(!svm->nested.asid02, svm->vcpu.kvm);
+
+	/*
+	 * Clear last_asid to ensure that the ASID is flushed on the first
+	 * nested VM-Enter. Otherwise, stale TLB entries from a previous life of
+	 * the VPID (e.g. different vCPU or even different VM) could be used.
+	 */
+	svm->nested.last_asid = 0;
 
 	return 0;
 
@@ -1571,6 +1581,8 @@ void svm_free_nested(struct vcpu_svm *svm)
 	if (WARN_ON_ONCE(svm->vmcb != svm->vmcb01.ptr))
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
+	free_asid(&svm->vcpu, svm->nested.asid02);
+
 	svm_vcpu_free_msrpm(svm->nested.msrpm);
 	svm->nested.msrpm = NULL;
 
-- 
2.55.0.229.g6434b31f56-goog

