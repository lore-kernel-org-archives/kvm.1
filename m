Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4067191F84;
	Tue,  3 Mar 2026 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498072; cv=none; b=oOMfyptdjKeF7p9Hqzm6ogqw/wcAgATYUP45AsQaWTpUcL0xAS8AAO1AIgH71MAj7F3Y4ihTnp1RPta15Dr8qNDBVC6GWyYJWowlK/HC9DxKh6YsJDb3BhMKjTdYPOGLjliJ/y/M2j6NiFkU/3BaQMHRwyfpPRrc8dPAssiDKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498072; c=relaxed/simple;
	bh=r3uyst2XvPutZGbquByoEiZKlWPLg+wME7+Xtx442m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrTL9k9llVJ6Rv/kn66yFvL6pSVhjE2kB0sZ9638p196AMjHj3Bk3DLNeEiwE8Mxne0obtcD5HrR4qVfT1x3hNQQcCSQ/zhjUFbzWvnJV+YYolVMghNB8PcYGMCElG9CsuQ4Pr0KsPSw0ajx7eEDCZoW2ci4wrxinJmRNXz1+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZN0NjD6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZN0NjD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985FDC2BC86;
	Tue,  3 Mar 2026 00:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498071;
	bh=r3uyst2XvPutZGbquByoEiZKlWPLg+wME7+Xtx442m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZN0NjD6Nlv+t54IfI4pkwAjAEdS3Ox4SQtQ8bSFedQuhsyYF1jxmqGKmC6OjrKts
	 CDag9+lMR/1Z+adjsC1KQBZIS7N9FkxIHUEP9gbsXTuCXgCYg+kTJByjoYv0SRXosH
	 sch5pErh0d2L7LjcWvQQjFifGuhsn4iERO85/3sdBujf0AuU9iAr0QVBh5GJy6VVJu
	 NRRyJfDCfcS32T/qemJ+CBNz59+tctBLsDvc7nJogjrEdMIJpeSUh+pPZ2kToUZU3t
	 eaK6sgIr4gUC81tmrNjXF2365USmjh40BPdByg94RpSxs6857npU/jZu6z9Q1P7lgq
	 sKYMNB8XR4fXw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v7 01/26] KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12
Date: Tue,  3 Mar 2026 00:33:55 +0000
Message-ID: <20260303003421.2185681-2-yosry@kernel.org>
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

svm_copy_lbrs() always marks VMCB_LBR dirty in the destination VMCB.
However, nested_svm_vmexit() uses it to copy LBRs to vmcb12, and
clearing clean bits in vmcb12 is not architecturally defined.

Move vmcb_mark_dirty() to callers and drop it for vmcb12.

This also facilitates incoming refactoring that does not pass the entire
VMCB to svm_copy_lbrs().

Fixes: d20c796ca370 ("KVM: x86: nSVM: implement nested LBR virtualization")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 7 +++++--
 arch/x86/kvm/svm/svm.c    | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index de90b104a0dd5..a31f3be1e16ec 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -714,6 +714,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 	} else {
 		svm_copy_lbrs(vmcb02, vmcb01);
 	}
+	vmcb_mark_dirty(vmcb02, VMCB_LBR);
 	svm_update_lbrv(&svm->vcpu);
 }
 
@@ -1232,10 +1233,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
 	if (unlikely(guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK)))
+		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
 		svm_copy_lbrs(vmcb12, vmcb02);
-	else
+	} else {
 		svm_copy_lbrs(vmcb01, vmcb02);
+		vmcb_mark_dirty(vmcb01, VMCB_LBR);
+	}
 
 	svm_update_lbrv(vcpu);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8f8bc863e2143..a2452b8ec49db 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -848,8 +848,6 @@ void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 	to_vmcb->save.br_to		= from_vmcb->save.br_to;
 	to_vmcb->save.last_excp_from	= from_vmcb->save.last_excp_from;
 	to_vmcb->save.last_excp_to	= from_vmcb->save.last_excp_to;
-
-	vmcb_mark_dirty(to_vmcb, VMCB_LBR);
 }
 
 static void __svm_enable_lbrv(struct kvm_vcpu *vcpu)
-- 
2.53.0.473.g4a7958ca14-goog

