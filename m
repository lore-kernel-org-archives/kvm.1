Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32D246788;
	Tue, 28 Jul 2026 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198969; cv=none; b=OX69RuSXO+uKrczIH41SZzlN/J+A11oDgPYW+fkdnH64ak0ejrRmisD/M3z6WcB0aciOueotqFVJoOQUy4hDQSqLDXCe7LqBbo991wacgYMqg2X+nG06jygWVV+QKIvY1aUgg1ScDoe7QpkMPvRQlpdFSHx8tNO9NObFuReySnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198969; c=relaxed/simple;
	bh=RYm47k+4j+tFFdh5pXrwCt7yinL6g0XSPXtmSRhIvMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuTAkr3cpLy74TvDT1wbxZYii/TnTyo6pbIW5RzglIIzLSr4D5bg9yN6A9k9vMoTHpE6d02uNZ1Lk84anyHzCFIStOjWQD0pAkwi4OA5dFJV+mHkfTXjbdbLXcEcgDtkSj9pXEVnOQkwFq84LNinMN9CTePfodnLXIJfmfnEfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brw3IOAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brw3IOAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C691F00AC4;
	Tue, 28 Jul 2026 00:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198967;
	bh=UpPZx2Gq6h07XZGCUBcdAYo2wxxM0HHZLrxuTZUqoZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=brw3IOArI24qchkwGOBsz8GFsKWmuUKUTpkxrqwg5KCnIb2hcnSOaQxA/dT+RGT1S
	 wS/hHPdnjkfW+oinhDjm/B4nXGVQS88WhgFBQPt3AdLdugeNmt032zy1DlKPDxxMP5
	 RdnLRkYy5UTVECt/OcH1lrFF26XtcO1GSYAeM/894DIGAComGpOMt7X+kV23zeyQqL
	 JkY+1mvqJ6CeYEOo4GaMfmwUJTvNZpkFPf8rrePLmtgNviikoalO8ijrn26uUs2RyA
	 gefgYYzX9Rva1+cnfvty/u3m2nVt+fTYdR94SsaOhHCffkaX+FTbHVwZrPJUEqclS7
	 41r0nw8TsSImg==
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
Subject: [PATCH v1 08/28] KVM: SEV: Do ASID initialization at VMCB initialization
Date: Tue, 28 Jul 2026 00:35:37 +0000
Message-ID: <20260728003557.1136583-9-yosry@kernel.org>
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

The per-vCPU ASID does not change for SEV guests, so move the per-vCPU
(and per-VMCB) ASID initialization to sev_init_vmcb() to do it once,
instead of checking before every VMRUN.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0e5046a12a970..8717da0e9fe8a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3580,14 +3580,6 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 	if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus))
 		cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus);
 
-	/* Assign the asid allocated with this SEV guest */
-	svm->asid = asid;
-
-	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
-		svm->vmcb->control.asid = asid;
-		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
-	}
-
 	/*
 	 * Flush guest TLB:
 	 *
@@ -4829,6 +4821,10 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 	svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV;
 	clr_exception_intercept(svm, UD_VECTOR);
 
+	svm->asid = sev_get_asid(vcpu->kvm);
+	svm->vmcb->control.asid = svm->asid;
+	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+
 	/*
 	 * Don't intercept #GP for SEV guests, e.g. for the VMware backdoor, as
 	 * KVM can't decrypt guest memory to decode the faulting instruction.
-- 
2.55.0.229.g6434b31f56-goog

