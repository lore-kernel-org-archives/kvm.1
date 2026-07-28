Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5723817E;
	Tue, 28 Jul 2026 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198971; cv=none; b=I/LTMDdfHvCyOfLn0KZRGS5pSK8AyOxWGdCCVFjUw40lB0x4ql7JjPSC6Y5QWtG1yLtwrkzqkaqcXaUNwJwytn6Y6TdvsF8iWVB4to0/YEaMSe0/dRKEoUFJlwt3N8Ib9hbkunwXXx4JQy2tRMUE13wtcirfg+P36omK5XcWULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198971; c=relaxed/simple;
	bh=YmQ9jxHHt7N7E2oMQaC5ZAFbZasrlaLZ4KxQECp3nR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESh9T02YrHRCBP4NB68tBWrLGFaKa6DsytJZ9iue8qWwjjyx80JcvU/v3ZJzAUT18X3GvS1YR+RZUFIYYfTlUGsaq6lOmqR5celZ1Voc0cbzgOP25xI4crl6BAMLqe4ntT/7/UgcCWK43w1+BHcj6Nx/HPYW0xWjihpiY+6XFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGXNUQYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGXNUQYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0521F00AC4;
	Tue, 28 Jul 2026 00:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198969;
	bh=uieRw70euOHcQIJnaq4BxBpgnhTtOXv+TgBFhqvCxRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PGXNUQYvOw/wZ1sQFPz/KGOXygfoloiyiwSkW1/ooBI6aGRRk1DPM7HLTnzE4rm+4
	 mJHLfJv+vIriFvWHxilsFvBofIYc1hUJk171oXzmWIUueOmZY1t6PdKqyaAb6Dnfd3
	 Kt2B5n30/UuHB34BBtGQTfBxG+t1YWIHERaiRI6MCzg/vieSMTLcQs9oUmn/RmVYpf
	 u3HLqHVgiCVlwv1k0Kf4bkob87FnMlysJiONPDAPrHeCPP5LnTvQpzrzzo6CRT/YND
	 j27bhOl+7KSpclyrZllFd6ibd6zl8u1V9TQhMq0Wf6Z5ajNqrTWbMAx4gYPTDHa5g9
	 vXwbap0dGEtNA==
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
Subject: [PATCH v1 12/28] KVM: nSVM: Add a placeholder ASID for L2
Date: Tue, 28 Jul 2026 00:35:41 +0000
Message-ID: <20260728003557.1136583-13-yosry@kernel.org>
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
index ed4af5a08f794..eb60d6b959d86 100644
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
@@ -928,7 +927,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	else
 		vmcb02->control.bus_lock_counter = 0;
 
-	vmcb02->control.asid = vmcb01->control.asid;
+	vmcb02->control.asid = svm->nested.asid02;
 
 	/* Overwritten later if necessary.  */
 	vmcb_clr_flush_asid(vmcb02);
@@ -1498,6 +1497,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 	if (!svm->nested.msrpm)
 		goto err_free_vmcb02;
 
+	svm->nested.asid02 = svm->asid;
+
 	svm->nested.initialized = true;
 	return 0;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 79339ee8a3d56..196fb39ab0ae9 100644
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
2.55.0.229.g6434b31f56-goog

