Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFEF3D5676;
	Wed,  8 Jul 2026 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492554; cv=none; b=PD/+2tt6jYOzZawxj3iO7xb1e7W3+QJqtuvtUFrGEKVR7La/vaWTQNkzV5VNFebZ/3t3N7MlGrqqnjr6j4B0ahRJIL1EiPt0ryNH+C3X9fMDJmbBmAK6hXm/VDUeP0N5niCpBEyouj4XP4DjqXx0b5KV0lV3CgcWfIpiHSTy6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492554; c=relaxed/simple;
	bh=sW8+XulrGs6VV0B8VB1gSqBYnYy1PmvI3YcjrJdTCyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxRlaB9IGM2rtOTMhD6fp6cpIH+MWlcxN+7tdOx+hfYKABEzgyWPF4xKQUEic9CpYe/FE2KcmFh1g6B11XXDf+43fnharCk441yVqcKpQWHhYIuPW5XU9fZjG56Z6m+DhDFZ3Z494/JOFHhngGc784AdqUYgqDT4MCP7vDLXmlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWnRQTsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWnRQTsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A901F000E9;
	Wed,  8 Jul 2026 06:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492551;
	bh=3Vq+ZHP54hoseCFOpD9ZdNTRHcMCtEWu9TAX3BvEpq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RWnRQTsQnXm7GCq5QkcmJkpOJLvMqaL9UWwsvh9d2LzTMjBK6xv04Hs3/I2mXU/Rt
	 Rz5A+IUjor5fOugO/ssiXLlnyN/Gu0qH+T/KnUpUh1+Fi/8HJoIfVp3n6uc+6VMviK
	 2sNlCNQcICIBUujt2LIyz4q8MLNs89rWflCKpJGX3Or9mWK+/Uv6qYMzB8fjOMbTmJ
	 DtwyF3eH1wqRCq6AeRbfZQUeI3mhmkhg1RbgOjLsY/GXs8U9jsNsYY8MmvwwrpCFm9
	 lEtKxX7BdgHQ7n1/lTytcr5X0Bhdqi017Q1eBGyLiLLDPjwCAKv/CxUprAyj8hQewT
	 0mQifg5OMA1mA==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 25/27] KVM: SVM: Do not inject exceptions for Secure AVIC
Date: Wed,  8 Jul 2026 12:02:23 +0530
Message-ID: <c1cd9082c081dcf87fd71c68a0554da4fa5231de.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kishon Vijay Abraham I <kvijayab@amd.com>

In Secure AVIC mode, EVENTINJ in the VMCB is ignored which means
there is no way to inject exceptions from KVM. Return early from
svm_inject_exception() for a Secure AVIC enabled guest.

Note that exceptions generated within the guest themselves are still
handled properly if intercepted (e.g., INTR just before a guest
exception), since those are saved in the VMSA EVENTINJ field and
processed by the hardware.

Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Co-developed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2cb38953c0cf..2e32670ff957 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -391,6 +391,10 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 	struct kvm_queued_exception *ex = &vcpu->arch.exception;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	/* Secure AVIC does not support EVENTINJ */
+	if (snp_is_secure_avic_enabled(vcpu->kvm))
+		return;
+
 	kvm_deliver_exception_payload(vcpu, ex);
 
 	if (kvm_exception_is_soft(ex->vector) &&
-- 
2.54.0

