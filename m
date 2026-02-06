Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717C438FEA
	for <kvm@vger.kernel.org>; Fri,  6 Feb 2026 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404967; cv=none; b=WAAvnBU1/IyKNz4G6n7s6w9zaNTdPH8m2NUq034V3J6yLRjNEp5OgGwIprSypF44C4IXk90W9vUCbL/SVtdTADJBsvw3VWGpTTCAl/LFusnxuK5k3EVx5uSTyhnHw4dGTCUXnNHehE1n+lygxIdlaOfMwhpgCvdQ5mhSFZTCOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404967; c=relaxed/simple;
	bh=2vnKk/0j7NLk9BjwTNt9Niw69jc7ATz5F/Nd5t15a4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqRHOhpdUdLyHBnJvCqwgrbPI7VFkX4BEDwNNTo3Kj6HV5F3CjDEHGIqlaPoqYY9sEnhwtRfWWV5qpafiaw/ipIJnrpDyNNsq+B5gdvvUnkbIhEFyOb5WFDfMamrKUMGNQHGQt5Driy/wbq1cbhfX4dFVjb2Wfck3qtupN9gwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fm7BGsTf; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fm7BGsTf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770404965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6WQRdiodBhsWPUMc6qwrczfvDz8gYzPH1Tbgvdt5pE=;
	b=Fm7BGsTfRWg1kE4MkhV9dsmaUgDzTexuDMoiPg/81KrQ+WMa0qMQJfYBVSSs1u7fqoPCW/
	GHUZTvFPgN0g2Q6HhWiY90t7Nu9xmUA3+yYu/vJ/QRR96FP/wV2nA0JiQcSY9gOkNbwNTe
	46gbbZUCbLCGDpSW/zypISUEmBQPz98=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v5 10/26] KVM: nSVM: Make nested_svm_merge_msrpm() return an errno
Date: Fri,  6 Feb 2026 19:08:35 +0000
Message-ID: <20260206190851.860662-11-yosry.ahmed@linux.dev>
In-Reply-To: <20260206190851.860662-1-yosry.ahmed@linux.dev>
References: <20260206190851.860662-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In preparation for moving nested_svm_merge_msrpm() within
enter_svm_guest_mode(), which returns an errno, return an errno from
nested_svm_merge_msrpm().

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 607d99172e2b..6e7238fed7ab 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -276,7 +276,7 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
  * is optimized in that it only merges the parts where KVM MSR permission bitmap
  * may contain zero bits.
  */
-static bool nested_svm_merge_msrpm(struct kvm_vcpu *vcpu)
+static int nested_svm_merge_msrpm(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	nsvm_msrpm_merge_t *msrpm02 = svm->nested.msrpm;
@@ -303,17 +303,19 @@ static bool nested_svm_merge_msrpm(struct kvm_vcpu *vcpu)
 #endif
 
 	if (!(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_MSR_PROT)))
-		return true;
+		return 0;
 
 	for (i = 0; i < nested_svm_nr_msrpm_merge_offsets; i++) {
 		const int p = nested_svm_msrpm_merge_offsets[i];
 		nsvm_msrpm_merge_t l1_val;
 		gpa_t gpa;
+		int r;
 
 		gpa = svm->nested.ctl.msrpm_base_pa + (p * sizeof(l1_val));
 
-		if (kvm_vcpu_read_guest(vcpu, gpa, &l1_val, sizeof(l1_val)))
-			return false;
+		r = kvm_vcpu_read_guest(vcpu, gpa, &l1_val, sizeof(l1_val));
+		if (r)
+			return r;
 
 		msrpm02[p] = msrpm01[p] | l1_val;
 	}
@@ -325,7 +327,7 @@ static bool nested_svm_merge_msrpm(struct kvm_vcpu *vcpu)
 #endif
 	svm->vmcb->control.msrpm_base_pa = __sme_set(__pa(svm->nested.msrpm));
 
-	return true;
+	return 0;
 }
 
 /*
@@ -1035,7 +1037,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, true))
 		goto out_exit_err;
 
-	if (nested_svm_merge_msrpm(vcpu))
+	if (!nested_svm_merge_msrpm(vcpu))
 		goto out;
 
 out_exit_err:
@@ -1930,7 +1932,7 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
 			return false;
 
-	if (!nested_svm_merge_msrpm(vcpu)) {
+	if (nested_svm_merge_msrpm(vcpu)) {
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror =
 			KVM_INTERNAL_ERROR_EMULATION;
-- 
2.53.0.rc2.204.g2597b5adb4-goog

