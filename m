Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440B3CBE69;
	Wed,  8 Jul 2026 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492457; cv=none; b=NHoJmqp9cBo038njE6czV0fCMlp+eXI+sz37JRDIpEMIqwliUTfDYR15sqAC9nrLHIuBVeE0s2oO82kIwtyxCEOcKhiRQUhbGAEFsyD0IM1ZA4+bndy22tIfgMlfzomQbIw8Ip7NFxy0npkN9Rxx85CZBeQoItnZVCRW7/01BxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492457; c=relaxed/simple;
	bh=7rbRvX6RI/mRGJRSWQuVTCUb/gJk9s6NTSiMb1pRQFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttFEJ+xJFvyjP+swgTJpYVIR5kQib9K4CfcJlThAZZGia0CfxMKfyVpWtZkvK8k7eXPfIFdTSLNNEx+qq/RNnJFqcywuaGaZP+JJXIOet0uNjZp5qdfL0Kr1PUKo9pbObXSw8+aHqk50HdNN5fWHVU1k6TIE0zo470Y4SumWnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu0PjE7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu0PjE7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3901F00A3A;
	Wed,  8 Jul 2026 06:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492455;
	bh=+rcRrsUhgQHACObSty4HYdCuO8eo6w0Zzp8xCLa4wP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wu0PjE7MyU6Au/w9TEguGFLjFaofcW3aTBTc7dbS6r/0aU1bJf93ZnkTpDJb7QziL
	 OfQO+V44dksPzanw8YtEPZpC76E6rNhWVscAGXtO2FBp+SwXlOVHrac3hckXshbPty
	 CJM9V6i5n0Z6dTw+mp5SLvMQgGqSgHSoDItKfdMZPHNo3at2cFp8D8cqIS1NPXqY0z
	 cGOUllVWxwTBQlbT/FSidDA04kVhVswbjTl7/nySHDGDxmJMIcPY8z2yOT6269vUzm
	 NR7DZ6V0B7xgQVvNs9me8uw3Vk9CDhaFKcOFxWnHll34NFA5LT73RqPTXzNMAY+wI6
	 JFxVMGILggYYg==
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
Subject: [RFC PATCH v3 14/27] KVM: SVM: Do not inhibit AVIC for SEV-SNP guests if Secure AVIC is enabled
Date: Wed,  8 Jul 2026 12:02:12 +0530
Message-ID: <fb72d91bc17d6d1389e6a6bb2216d24db6f4a01c.1783490022.git.naveen@kernel.org>
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

Now that Secure AVIC mode is appropriately handled by the AVIC code, do
not inhibit APICv for SEV-SNP guests that have Secure AVIC enabled.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a12e7e9f9fa1..00cb45ce145f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -569,10 +569,10 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	if (snp_is_secure_avic_enabled(kvm)) {
 		kvm->arch.apicv_has_irq_bypass = false;
 		to_kvm_svm(kvm)->avic_ipiv_is_not_supported = true;
+	} else {
+		kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV);
 	}
 
-	kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV);
-
 	return 0;
 
 e_free:
-- 
2.54.0

