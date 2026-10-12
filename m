Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26B41441A;
	Mon, 12 Oct 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848214; cv=none; b=XhIgqN4FdJ+4FoQgOJaC7SjyFa+fKLcQ1uG+PDUN/K3cAwTJdxnwbKcKQ2ZEqnjuVQxK165ldl+CXb+077jZ3/6vBV7YiL1oySfx2mKXp9agMLuRq6UgJLYhhLkGjNwC5lmCEu2/+fSQaB8K5A8XulxO8x56o1ww6Z8otIgSKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848214; c=relaxed/simple;
	bh=7XZ4nLYCx05tR0NTXnDEsmHWevTjC6V+OQfbt42dP7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzpKOnQuqf3km2jpzSRlRDok3Q6mIM8aim+ZDN+zQXwm6NgPBRoypFlrTdQp98H5J8rJNaZZDXZPcOeWZO3pg5WFld+70lXu266h6QXbKQTWHHIAfrV3hum0QhmXdltSyixdb8q360UcQ69Gv4GObEDgEP7mBF9x0LbLliJPhYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al7Wfswv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al7Wfswv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422261F008A5;
	Mon, 12 Oct 2026 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848212;
	bh=GA3ltZIfmPFoJm4ZnYAngjEvWEJgPVGf2YeSrnYbd48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=al7WfswveZgoYPwOsUXsVPAcjMxvzr8aIhyunxlyYD7ACpG7uR8F246F1+x1RXScP
	 i8W0cgpVX602XLuoPF4uutV69ieNGTpkbVB/NGUCv5qVwg6nBaAc7c2XCr2TslL1/W
	 10oBednqNPpg6R3ePl4CdumNY/o+j7c9rjr4i9n3xyCyD1wngDmI27JG6SPdgRHEi5
	 xDE8KW2Onwsj6uS1YMSpjqjXjJiP1IKXw7xp+RbpH1QRde6yEhYWgJaIwT7GORVPEC
	 ki79yZrgclLhjfJZzQ3zBDkCuaiHJGFYAOB807YQi1UKLE/JxYxxFqlSF0w+Be/HYT
	 DpXgiAcxKbMLg==
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
Subject: [PATCH v3 13/27] KVM: nSVM: Add a placeholder ASID for L2
Date: Mon, 12 Oct 2026 23:36:24 +0000
Message-ID: <20261012233638.2546339-14-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
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

On SEV VM migration, copy the new SEV ASID into asid02 and vmcb02, in
case nested was already initialized on the destination vCPU before
migration.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 5 +++--
 arch/x86/kvm/svm/sev.c    | 9 +++++++++
 arch/x86/kvm/svm/svm.h    | 2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index bfb297b7d71ab..780132725bb79 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -701,7 +701,6 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	 *  - Honor L1's request to flush an ASID on nested VMRUN
 	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
 	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
-	 *  - Flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST
 	 *
 	 * [*] Unlike nested EPT, SVM's ASID management can invalidate nested
 	 *     NPT guest-physical mappings on VMRUN.
@@ -936,7 +935,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	else
 		vmcb02->control.bus_lock_counter = 0;
 
-	vmcb02->control.asid = vmcb01->control.asid;
+	vmcb02->control.asid = svm->nested.asid02;
 
 	/* Overwritten later if necessary.  */
 	vmcb_clr_flush_asid(vmcb02);
@@ -1504,6 +1503,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 	svm->nested.vmcb02.ptr = page_address(vmcb02_page);
 	svm->nested.vmcb02.pa = __sme_set(page_to_pfn(vmcb02_page) << PAGE_SHIFT);
 
+	svm->nested.asid02 = svm->asid;
+
 	return 0;
 
 err_free_vmcb02:
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 99577859e1aab..b2e6acfbb081f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2041,6 +2041,15 @@ static void sev_vcpu_migrate_asid(struct vcpu_svm *dst_svm,
 	 */
 	free_asid(dst_svm->asid);
 	dst_svm->asid = asid;
+
+	/*
+	 * If nested is already initialized on the destination vCPU, also update
+	 * the nested ASID to match the new SEV ASID.
+	 */
+	if (dst_svm->nested.vmcb02.ptr) {
+		dst_svm->nested.asid02 = asid;
+		dst_svm->nested.vmcb02.ptr->control.asid = asid;
+	}
 }
 
 static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2e1b5481ddd92..ed67c18e2b900 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -234,6 +234,8 @@ struct svm_nested_state {
 	 */
 	struct vmcb_save_area_cached save;
 
+	kvm_tlb_tag_t asid02;
+
 	/*
 	 * Indicates whether MSR bitmap for L2 needs to be rebuilt due to
 	 * changes in MSR bitmap for L1 or switching to a different L2. Note,
-- 
2.56.0.385.gd3acb90ef8-goog

