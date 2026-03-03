Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BCA3563FA;
	Tue,  3 Mar 2026 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498076; cv=none; b=MiYY+oyAD127tQnP2PfeFNvZ6oQ99nM+e/DdHPOBNS913fNKLq3vhQfOmjMiN4o5NGcNwD5sUnqhWD26eOdk8S8nUgdtiib+BddrOd81D1npZJYVUatKAf6WZsSnkvBUDm3yXmTc715bpb7yc5Yi5gzRIbsk+fJ9ZPeHan1+YFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498076; c=relaxed/simple;
	bh=JRTh4d4NiavCtUAPMWBR5Q7QKAgkkv2LsY9J4Zvx6kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdYHBIThpSCuuPd/VVjgAAqNmwZXEEVP9p0k/futyf/BqAnFS39yaEX/LXus19G9BXhl+tDOtDSLMslwfiyH4wN7npBewmaCuSbdc6GWP4bXgzrF8hkyzo3hhhVXOscTQiC3rdR773hSn3JmClfh+7KbZ/yOkrnildJOX38WssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU/ZXlHP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU/ZXlHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AD7C2BC9E;
	Tue,  3 Mar 2026 00:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498076;
	bh=JRTh4d4NiavCtUAPMWBR5Q7QKAgkkv2LsY9J4Zvx6kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bU/ZXlHP8nakl9RF1pU1UgGINXnaSRtiFO6wsI8P/v9jqN2yiFiNJxlLm+L/h2lOj
	 txCAo8NbwbZg+G/lM2MCANT2YaJkXIe6HhJ7A73k2/Y6BO3bRrR7hJScnxgNeOhf8Z
	 izvRPr3wfz4ftZVBnBdJyKhtzJTcguT0QttCMpRjZsufEIkKlShRuKT00haP5g2vHi
	 rpdajO4FBtmy3QbPl3LmBLZ3CcQRxf711z50Dl75jnjw+PmBadUruIy+toqiTi1Ldp
	 NcL59UJDkEfYObxJZuNN1XpuccrDvwp6hDEaqzTTCeAx1rvoUzBpXiRyCPhNqAMPJQ
	 HJ3vJ1P1lGBgQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v7 12/26] KVM: nSVM: Clear tracking of L1->L2 NMI and soft IRQ on nested #VMEXIT
Date: Tue,  3 Mar 2026 00:34:06 +0000
Message-ID: <20260303003421.2185681-13-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260303003421.2185681-1-yosry@kernel.org>
References: <20260303003421.2185681-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM clears tracking of L1->L2 injected NMIs (i.e. nmi_l1_to_l2) and soft
IRQs (i.e. soft_int_injected) on a synthesized #VMEXIT(INVALID) due to
failed VMRUN. However, they are not explicitly cleared in other
synthesized #VMEXITs.

soft_int_injected is always cleared after the first VMRUN of L2 when
completing interrupts, as any re-injection is then tracked by KVM
(instead of purely in vmcb02).

nmi_l1_to_l2 is not cleared after the first VMRUN if NMI injection
failed, as KVM still needs to keep track that the NMI originated from L1
to avoid blocking NMIs for L1. It is only cleared when the NMI injection
succeeds.

KVM could synthesize a #VMEXIT to L1 before successfully injecting the
NMI into L2 (e.g. due to a #NPF on L2's NMI handler in L1's NPTs). In
this case, nmi_l1_to_l2 will remain true, and KVM may not correctly mask
NMIs and intercept IRET when injecting an NMI into L1.

Clear both nmi_l1_to_l2 and soft_int_injected in nested_svm_vmexit() to
capture all #VMEXITs, except those that occur due to failed consistency
checks, as those happen before nmi_l1_to_l2 or soft_int_injected are
set.

Fixes: 159fc6fa3b7d ("KVM: nSVM: Transparently handle L1 -> L2 NMI re-injection")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f0ed352a3e901..b66bd9bfce9d8 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1065,8 +1065,6 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 
 out_exit_err:
 	svm->nested.nested_run_pending = 0;
-	svm->nmi_l1_to_l2 = false;
-	svm->soft_int_injected = false;
 
 	svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
 	svm->vmcb->control.exit_info_1  = 0;
@@ -1322,6 +1320,10 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true))
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
+	/* Drop tracking for L1->L2 injected NMIs and soft IRQs */
+	svm->nmi_l1_to_l2 = false;
+	svm->soft_int_injected = false;
+
 	/*
 	 * Drop what we picked up for L2 via svm_complete_interrupts() so it
 	 * doesn't end up in L1.
-- 
2.53.0.473.g4a7958ca14-goog

