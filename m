Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619BA22A4F1;
	Thu,  8 Oct 2026 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418491; cv=none; b=qzufIXPT2CaD+g0+X6CTIueEyCtH/6kw0WzKO3s2pDTgT7zhcAYB3YkBA/ay/Es+ZknMs2ptbN+VZwuon17aU1SafzW0mi/jCAdTq1pCifp0plIETQFlxXMktSD0epvGLXMRvw/Klizdu/lRAcLfWhKegQTcWd9W0Vg5ebN4dYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418491; c=relaxed/simple;
	bh=E/4UGOWRSWf7isWli2GFSoCTNA6LhGE8C9TXrVyleZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjEN4vzz5CcSC7YrlAoa6cyP00O9EP7mBKV/1fX+iPWOCG65SB23eHpHXSO77tbf1WQ5pFB+ZJ3DU38PH1fnkBRK8sLilSDVhGEPlF0PXTD4E+n1rV1wFOwu5euXDloibD1LNZqggEYjXr1zic+W6sMPzJjxZng1r5iTcepJuJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqYDeo4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqYDeo4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBF01F000FF;
	Thu,  8 Oct 2026 00:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418490;
	bh=D/JrpwuTbYo1fodgS69GXDrk/zksLYIOyr4jJVnNBgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DqYDeo4R0+V2fMSZs2kO5p5pXc4OwGRb/HpjTvKS5xirNviScH9PQ/sx5tTuwNbhE
	 GBJMUqz6phZlOaKnlZ0XPV/HMe59f89gMOW04r85SkTAf8cSejRDVapWxXV2tHtWkg
	 TzjQZnguO9t6nofQrr9e6w+Cm2mbw3hGloY53SpScOGBAbpMy3np2hIXpe3v7MYwim
	 RHMjMWvOV419Rxz4bnKpuF27wEWh13dsGDDdKGYbZRpRRTYMwj+KHRoeY86JzRcE9V
	 jlwVu4qdsUlndRxkSPt++r8JfWVsPBTu/RH7EUyfZ0o/phAkk0XH7jAxYN46HFDlyT
	 9lHte6YUOK4Og==
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
Subject: [PATCH v2 23/29] KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on nested VM-Enter
Date: Thu,  8 Oct 2026 00:14:19 +0000
Message-ID: <20261008001425.2458927-24-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop clearing TLB_CONTROL when preparing the control area of vmcb02, as
this potentially undoes pending TLB flushes for L2 (e.g. through
KVM_REQ_TLB_FLUSH while L1 is running), and remove the associated TODO
comment.

This is currently harmless, because nested_svm_entry_tlb_flush() always
requests KVM_REQ_TLB_FLUSH_CURRENT on nested VM-Enter, which sets
TLB_CONTROL again before L2 is actually run. However, always flushing
will soon go away with proper TLB handling for L2, at which point always
clearing TLB_CONTROL would be a bug.

Clearing TLB_CONTROL on nested VM-Enter was probably done because
TLB_CONTROL is not cleared by the CPU on VM-Exit. However, KVM always
clears TLB_CONTROL in the active VMCB after a successful VMRUN. Hence,
at nested VM-Enter, TLB_CONTROL in vmcb02 can only be non-zero if a TLB
flush is queued for L2 while L1 is running (i.e. KVM_REQ_TLB_FLUSH), and
that should never be ignored.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 8e4686b0d603a..738ec1f2ec869 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -723,12 +723,7 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
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
@@ -975,9 +970,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 
 	vmcb02->control.asid = svm->nested.asid02;
 
-	/* Overwritten later if necessary.  */
-	vmcb_clr_flush_asid(vmcb02);
-
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
 		vmcb02->control.misc_ctl &= ~SVM_MISC_ENABLE_GMET;
-- 
2.56.0.360.g66cac248cb-goog

