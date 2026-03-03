Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2701222599;
	Tue,  3 Mar 2026 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498072; cv=none; b=YkW9IL9zDDgRblYLiZ4YP18KldI60kBWd3ntFOj5P8/aVYNlFs1IMhhU9x8OAAkdOSbV+EfxtiILsD9a98nxYg63xfLsdUhHW2fis19/Zox8nqwXStFlI7yZZaQrDhwKPeJGVwueZGuW4Dc7p5oqI2hzJZF7BTmbnUu9MpWFAQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498072; c=relaxed/simple;
	bh=bzvY4YRGMLfrodijPDFgV86Y9a5hYWOyqUPTjZ20rsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTBPmT2go8gE/SDsWwG9TyLNKk8yK/evkDKbH2XhDEwsfydzgRtS6a2RJaPv1q6hlTukbt75Bq4eZgRm0ROQhSdaJdxpQO01fJokymYlacaKt6hb9aYs0bWHtD7mG9OLp8fZyOfdWtBfwFGFPXfLvclfKftQOITSet0N69f+zTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l654d4/w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l654d4/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706E7C2BCAF;
	Tue,  3 Mar 2026 00:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498072;
	bh=bzvY4YRGMLfrodijPDFgV86Y9a5hYWOyqUPTjZ20rsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l654d4/wAl5yqVTdMpefI8/iCp5hW3OcSK4fsntbm/XeZQI+4gIFYuNCLq1gpu6eN
	 gjPBRoctTJ3Ag4RjmawL/ZYNJ6wuzkldLzqWRwpYQyXlY6IcKFla92QrDAtBcx6bjX
	 nqaTCt90Aa13gUaaKUNes4hdT5E59OauCEe0oIJFs9BZUjaTGA+fCG0OH53AHXdv9B
	 SOI0/LVIGLzOGXdO5MKezyrk9U2mFibD5Mkj+AVv21DOgzn3AV7qWTVd2hCjJrOz3a
	 /gRH3QJ0+Wq1kmH4SzPdEdaOetqt11lUvxAUqAuS/hEJfakA4z2ZYOn/951aHicxCh
	 eOKLw9if3KvZQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org,
	Jim Mattson <jmattson@google.com>
Subject: [PATCH v7 03/26] KVM: SVM: Add missing save/restore handling of LBR MSRs
Date: Tue,  3 Mar 2026 00:33:57 +0000
Message-ID: <20260303003421.2185681-4-yosry@kernel.org>
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

MSR_IA32_DEBUGCTLMSR and LBR MSRs are currently not enumerated by
KVM_GET_MSR_INDEX_LIST, and LBR MSRs cannot be set with KVM_SET_MSRS. So
save/restore is completely broken.

Fix it by adding the MSRs to msrs_to_save_base, and allowing writes to
LBR MSRs from userspace only (as they are read-only MSRs). Additionally,
to correctly restore L1's LBRs while L2 is running, make sure the LBRs
are copied from the captured VMCB01 save area in svm_copy_vmrun_state().

For VMX, this also adds save/restore handling of KVM_GET_MSR_INDEX_LIST.
For unspported MSR_IA32_LAST* MSRs, kvm_do_msr_access() should 0 these
MSRs on userspace reads, and ignore KVM_MSR_RET_UNSUPPORTED on userspace
writes.

Fixes: 24e09cbf480a ("KVM: SVM: enable LBR virtualization")
Cc: stable@vger.kernel.org
Reported-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  5 +++++
 arch/x86/kvm/svm/svm.c    | 24 ++++++++++++++++++++++++
 arch/x86/kvm/x86.c        |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f7d5db0af69ac..3bf758c9cb85c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1100,6 +1100,11 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 		to_save->isst_addr = from_save->isst_addr;
 		to_save->ssp = from_save->ssp;
 	}
+
+	if (lbrv) {
+		svm_copy_lbrs(to_save, from_save);
+		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
+	}
 }
 
 void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f52e588317fcf..cb53174583a26 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3071,6 +3071,30 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 		svm_update_lbrv(vcpu);
 		break;
+	case MSR_IA32_LASTBRANCHFROMIP:
+		if (!msr->host_initiated)
+			return 1;
+		svm->vmcb->save.br_from = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+		break;
+	case MSR_IA32_LASTBRANCHTOIP:
+		if (!msr->host_initiated)
+			return 1;
+		svm->vmcb->save.br_to = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+		break;
+	case MSR_IA32_LASTINTFROMIP:
+		if (!msr->host_initiated)
+			return 1;
+		svm->vmcb->save.last_excp_from = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+		break;
+	case MSR_IA32_LASTINTTOIP:
+		if (!msr->host_initiated)
+			return 1;
+		svm->vmcb->save.last_excp_to = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+		break;
 	case MSR_VM_HSAVE_PA:
 		/*
 		 * Old kernels did not validate the value written to
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index db3f393192d94..416899b5dbe4d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -351,6 +351,9 @@ static const u32 msrs_to_save_base[] = {
 	MSR_IA32_U_CET, MSR_IA32_S_CET,
 	MSR_IA32_PL0_SSP, MSR_IA32_PL1_SSP, MSR_IA32_PL2_SSP,
 	MSR_IA32_PL3_SSP, MSR_IA32_INT_SSP_TAB,
+	MSR_IA32_DEBUGCTLMSR,
+	MSR_IA32_LASTBRANCHFROMIP, MSR_IA32_LASTBRANCHTOIP,
+	MSR_IA32_LASTINTFROMIP, MSR_IA32_LASTINTTOIP,
 };
 
 static const u32 msrs_to_save_pmu[] = {
-- 
2.53.0.473.g4a7958ca14-goog

