Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6E3EE1D3;
	Mon, 12 Oct 2026 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848211; cv=none; b=ieCn77LDtcgWfJ/UQLBQ+JBjhRL99wuAGz9MTWEcpSMk07h18+/1DwQFbUR5UwnvY/FLBxCYWEJdG1hb9xkz40bm6P8nkR3/V7GBmrciu1OsL5AtWJrJakLFq0MreaxCRMmXgGMKDigheB43HqId7+jJGUtuah5NcOQN4UsSqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848211; c=relaxed/simple;
	bh=Xe8bFSZSnci38DVvP4JJTZfaXBBCIS/CIgG+C0ug2Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgShGMcErTdi4gN2KRJakjFghyfzvsCZNlJIoP/ZKylM5sKq17HAttROgTZrQsoH+7KwjksiW65tKWQxstHCdRgAUAUxmC/weKV3V2CBQYe0V7eTUlw5jMf8TfJli9L84mBtuKAY8wBgZ/0fzWHRqQUNChZN+0AjvC2ksrrO8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nopFbPuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nopFbPuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7311F008A1;
	Mon, 12 Oct 2026 23:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848209;
	bh=UY5URZ76dLeB2P33iZ/UYXP+PmWH48vQtOfwnmjnAy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nopFbPuCMriT5CJIeYZ3b9OBM0V1TOcHuF+nko3+UD92y1+AATIJn24aniztYM3nj
	 40IyYZWyb5u0EayamXZiPxykEzjeQQLc/sKAoUi4z9Y3859PRXWQiKI4Lw3J3a/Vsz
	 +JptIHDyEo1OyqNB7lEhZhOfgygOxQdKOUi4wrozTO5Y8Rj0IcY9ROO0Igl0D1pp7e
	 RfWwDCPEmK3uELBbeGuovoXO6Z3irrrx+cCwFZqPwxvDkglUKutCLwrs7zm/H+ovDX
	 yBT4GC65CA1E3pdF5kKW6YaNes8yhivPmovoa/Sbhcts0vf0UTCsGYpc7Bc+3Ru+ks
	 TN0bsH5wcUL1A==
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
Subject: [PATCH v3 07/27] KVM: SEV: Do ASID initialization at VMCB initialization
Date: Mon, 12 Oct 2026 23:36:18 +0000
Message-ID: <20261012233638.2546339-8-yosry@kernel.org>
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

The per-vCPU ASID does not change for SEV guests, so move the per-vCPU
(and per-VMCB) ASID initialization to sev_init_vmcb() to do it once,
instead of setting it before every VMRUN.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74c4555a32650..b58e3831b8f05 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3623,9 +3623,6 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 	if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus))
 		cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus);
 
-	/* Assign the asid allocated with this SEV guest */
-	svm->asid = asid;
-
 	/*
 	 * Flush guest TLB:
 	 *
@@ -4889,6 +4886,10 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
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
2.56.0.385.gd3acb90ef8-goog

