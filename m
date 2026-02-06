Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E5442B72B
	for <kvm@vger.kernel.org>; Fri,  6 Feb 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404979; cv=none; b=fZ1bcYXgWCUlU4eyIOfUA3z/g8BtlzTByPiS1zWbiaavpoQ7bg/DdrOszr6vKR0pzgE/7U9I0djpP2mpPAHpmfmQbBZY+r/+MfsJcMGyhPXC/5mVvAR4sw1R3WOdJYweaxU7WwjGV8POwNg8z+EAVVVJER569zgM5F6YKUJbEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404979; c=relaxed/simple;
	bh=5ctLhR0lS99QfPYOjSZ2IkQWT2BlNOBp2oflUMsiFx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCh036iUQgDt51VjKQI+Xni1i2FFjpswTDWR6csxxLnP5jB54Q4KBMpsy7YiW4zGLtrn/+u18Ovbxq57zavwDsLBks2Lh25N5N6SS/MUpBvS0HuXklMkxTycZ427WsFFSti+NVvdwFbZgNEH7bNY2yRV83VYLCngDUbiPEg+QgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OKw0yfia; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OKw0yfia"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770404977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Man7fEjZ0MIzpTt04AlItBFOGG4+DdWyp2A674rOJMI=;
	b=OKw0yfiatGEkN4wNXvRjT/GnBUjGoe6FpxetSivKffMij18qIFwP87ui88gMQlB0nR5oZq
	mm7D5wZM1hHIPlo+4B2T+NhA4sNJlCdxenO5PrUh7qHHQTPuaEnuBwz27+LWLzjhDNMfkZ
	4zR2uwoMnljEodYf1Rv+wz0XtC6DMUo=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v5 17/26] KVM: nSVM: Add missing consistency check for nCR3 validity
Date: Fri,  6 Feb 2026 19:08:42 +0000
Message-ID: <20260206190851.860662-18-yosry.ahmed@linux.dev>
In-Reply-To: <20260206190851.860662-1-yosry.ahmed@linux.dev>
References: <20260206190851.860662-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From the APM Volume #2, 15.25.4 (24593—Rev. 3.42—March 2024):

	When VMRUN is executed with nested paging enabled
	(NP_ENABLE = 1), the following conditions are considered illegal
	state combinations, in addition to those mentioned in
	“Canonicalization and Consistency Checks”:
	• Any MBZ bit of nCR3 is set.
	• Any G_PAT.PA field has an unsupported type encoding or any
	reserved field in G_PAT has a nonzero value.

Add the consistency check for nCR3 being a legal GPA with no MBZ bits
set. The G_PAT.PA check was proposed separately [*].

[*]https://lore.kernel.org/kvm/20260205214326.1029278-3-jmattson@google.com/

Fixes: 4b16184c1cca ("KVM: SVM: Initialize Nested Nested MMU context on VMRUN")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 61359e64e8ed..a5a5ce060f47 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -350,6 +350,11 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 	if (CC(control->asid == 0))
 		return false;
 
+	if (control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) {
+		if (CC(!kvm_vcpu_is_legal_gpa(vcpu, control->nested_cr3)))
+			return false;
+	}
+
 	if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
 					   MSRPM_SIZE)))
 		return false;
-- 
2.53.0.rc2.204.g2597b5adb4-goog

