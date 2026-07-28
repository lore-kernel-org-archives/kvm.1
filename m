Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F570377A9A;
	Tue, 28 Jul 2026 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198976; cv=none; b=oaDi2pO3Z6T4pU3X7N65/dPB7ww5MuofW3Ehs2XuitJMY/KXqAYkzbneZCRZeVN2pJnRdwTK3Z4tQD7cdbti/dMoOmiC06tdwiu/RtBIxFRJtySAcX/HGc1oSmqjJYE8+hdH5Lu0KlzBUsyVB3zX9WJkXWiaOdn/yA69b1yLJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198976; c=relaxed/simple;
	bh=MCvFU56yZVnCOxBbY6mTcY3sDioQwxYX+DhC8atP05Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6unqoK8HkCSHjqHvFXlOX2Cer88ReuDs+FtuRqyZlSkAJzChRFnhJWnerKtm+SW492zrKOW0Vi9Gpam+DzECAIpetek8jUIT2LkRYIGfOT/pDUSO2LblAozmgtvap8Wf2PVpmYdgZs4mx4q5G9FhVoe5mk5exmCYKyNbWsxEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlP/1w1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlP/1w1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276691F00A3D;
	Tue, 28 Jul 2026 00:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198974;
	bh=h2Ysdj0qK8DvRim1C1PzxOxEX/Ksc8yb+shMuBLswnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dlP/1w1AjBRsjEkEdPJCmBqKJCWNaibaykBSJPrSFJV6ek2Vg0O/cTeaUpDoCquEq
	 L89L5hFZAsaBIHi7oCYgjutAhRjyztSvSuQ/p+xEoYefot/K0RjPYXaLGwYSndnfVl
	 IpakIsf33N+PY/8v5vr+2okvs5qi9/iYhXBmAbZBz731UEOOoO05gaVlekYVN6FZBo
	 V3KB6khSp77PnfLdlnvK8TSzxfUrJFCB1cRG1JNPaGhsM5CAj+bFCC/uAWx3UfIB4J
	 WexL0RTJMk64KPmMb2xXEtxIMniQkaqDTEvwh9igRuq13ES6eUmF/bjbIH1rd1qtAf
	 GktMFhBLI14qw==
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
Subject: [PATCH v1 22/28] KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on nested VM-Enter
Date: Tue, 28 Jul 2026 00:35:51 +0000
Message-ID: <20260728003557.1136583-23-yosry@kernel.org>
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

Stop clearing TLB_CONTROL when preparing the control area of vmcb02, as
this potentially undos pending TLB flushes for L2 (e.g. through
KVM_REQ_TLB_FLUSH while L1 is running), and remove the associated TODO
comment.

This is currently harmless, because nested_svm_entry_tlb_flush() always
requests KVM_REQ_TLB_FLUSH_CURRENT on nested VM-Enter, which sets
TLB_CONTROL again before L2 is actually run. However, always flushing
will soon go away with proper TLB handling for L2, at which point always
clearing TLB_CONTROL would be a bug.

Clearing TLB_CONTROL on nested VM-Enter was probably done because
TLB_CONTROL is not cleared by the CPU on VM-Exit. However, KVM always
clears TLB_CONTROL in the active VMCB after VMRUN. Hence, at nested
VM-Enter, TLB_CONTROL in vmcb02 can only be non-zero if a TLB flush is
queued for L2 while L1 is running (i.e. KVM_REQ_TLB_FLUSH), and that
should never be ignored.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f50e21fd363fc..58e7d099c559e 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -719,12 +719,7 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 	}
 
-	/*
-	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
-	 * things to fix before this can be conditional:
-	 *
-	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
-	 */
+	/* TODO: optimize unconditional TLB flush/MMU sync */
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
@@ -966,9 +961,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 
 	vmcb02->control.asid = svm->nested.asid02;
 
-	/* Overwritten later if necessary.  */
-	vmcb_clr_flush_asid(vmcb02);
-
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
 		vmcb02->control.misc_ctl &= ~SVM_MISC_ENABLE_GMET;
-- 
2.55.0.229.g6434b31f56-goog

