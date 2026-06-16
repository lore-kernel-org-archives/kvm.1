Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07A32B130;
	Tue, 16 Jun 2026 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570553; cv=none; b=cvx26c/5JqTwZIHkXmXeTSyR0bRJaGHlZy2m2pXi6DiCq+zhwbSQQKlEaz0bJJirz/JmoDWtLQsKzpmkolQ7GB61/hHvgn9WtnDMBGa2q+Mhql8OCUCH0Qaei3PNxz2y/PXeVmoD6aiZQS0QaFajSYk6cd5UPgK/GJdDyEpG7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570553; c=relaxed/simple;
	bh=be/i1k4y/PlQ+lWXqPkZOHE95nazfIidNXtMiF8Z+oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHNuGeYvgSm6z6EtYhtyDYLcD3F0XBVGQKBKSC2z5uvHn4XwByaZPv3MU4eTe0j/JY2lYDMF3snXF2UD/G8oMv1o+enP+UiNJp1LTfp1CvaST1em6oJrnVQ19SoNiPUDc6Uw76NhzKYZcZ3biSKpQ0AXa87WgbfgpViI9Aydyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9HmOXgp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9HmOXgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EA51F00A3F;
	Tue, 16 Jun 2026 00:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570551;
	bh=nsZ3gkwmujzISH0RoBFsE/5KYiuBrdwVW09/X/kWErc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j9HmOXgpHfaUgI9YJz0dfcEO8HjBAur+v6Ffr1isx+gSLdtAfSo2T9DRp3lx26fYH
	 61Pk7i4ZdEeBKeFt41nRt+dSZKTkVrf2WwcWOGG604GO8m8mIew9GBhl6oh2RMcngr
	 nWPZxN7EKV09bs+/4k+XZP7MPAMbmT8i6oq4PU+3RHaha9hrUFZ3xVXuSEh0K1LPtL
	 t8L/T/XWZmADIH4qp7xF7KuMCyV527exMz7uBulMyqdlFejoDpznhZg4yfURFwlJ3P
	 igLxFSY5AuEC45EyEyJXqtNAYOy/tU4SwsU8fLPAlNZNX+S0oldnRx9TKKNgp2hh2+
	 sXXNbf1tyMWAQ==
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
Subject: [RFC PATCH v2 20/25] KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on nested VM-Enter
Date: Tue, 16 Jun 2026 00:41:49 +0000
Message-ID: <20260616004155.1435766-21-yosry@kernel.org>
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
index f91c22e72151e..a226aca8f9108 100644
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
@@ -981,9 +976,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 
 	vmcb02->control.asid = svm->nested.asid02;
 
-	/* Overwritten later if necessary.  */
-	vmcb_clr_flush_asid(vmcb02);
-
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
 		vmcb02->control.misc_ctl &= ~SVM_MISC_ENABLE_GMET;
-- 
2.54.0.1136.gdb2ca164c4-goog

