Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE92D5925;
	Tue, 28 Jul 2026 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198972; cv=none; b=AltYxC2QWr8b6pQ6YHfYmkmFiJMXqU+XUe8/Y7JH1O0qRCwfZqkcD/SP1zcZ+5a+f16sfq8cAFpGXanClVkMj55+uY28j+IZUSxAdxJycYBt7xRGr4nbjW1wYRSdMnuXDBWtfrE4CwsZNxnKjG0hWRW4P+CP8w5iaEajRkkpfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198972; c=relaxed/simple;
	bh=xYd5kOupy/LPpBimXBe/iRwQ8Ez0fJqy/bj9ByaYnT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKYY9qj8tLtfo8P33oEfwo1IJuEQqa0b0AwFtGg2nJi4YEyXH6WT9n6pps9otwS2SlpRZOos6WNz0dEvsIF63C8dtFkNPapLkPUmio6mSAMzh6N0EXqg/Lm7DN3RvNQXwXkJH8BTLhPsgmVfLotCautOG3Z/andfuHk3bmVNeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFiqBUxu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFiqBUxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD411F00ACA;
	Tue, 28 Jul 2026 00:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198971;
	bh=WEXYcK35gUCnFOkP9xXSihhwCKp3VCGqxXeYH/AToUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bFiqBUxugNK0gJdG6kXf3pTnVwX1tABBGYWzNQAfwfsxclH3VZCnWzhBXtA+/eowF
	 o+VY/xdMFzFbqgsTMWFBVYAsRIZng5AFGr5m5Ti/7bOqWWm8iazaBJ+2W0ralMQQd5
	 C9b8zrTt78fgztx4Y5NlQP0CUUUQrCoqRTEUXBzzrt+oxly6E6SSox2X3AEPKkOdOK
	 LcuuvKX2R/qe9WPzUpioM+vs0Vo0ykTgblpmDSgUpMSgT/PXQnqDkNaoWTiHRbac7S
	 6CBplXx3Rb7L/dcpqdPWOsDGkTudgdIctrp/Kkxa/VLZj5NN6Ecfuu7/stnbusXsB4
	 RN1yovHWjDkFw==
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
Subject: [PATCH v1 15/28] KVM: nSVM: Drop svm->nested.initialized
Date: Tue, 28 Jul 2026 00:35:44 +0000
Message-ID: <20260728003557.1136583-16-yosry@kernel.org>
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

Do NULL checks on svm->nested.vmcb02.ptr instead of using a dedicated
proxy 'initialized' field.  Make sure svm->nested.vmcb02.ptr is
correctly set to NULL on initialization failures, as currently it is
currently left as a dangling pointer.

This makes it possible to directly do a NULL check on
svm->nested.vmcb02.ptr before using it, instead of checking a different
field, which is less error-prone.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 13 +++++--------
 arch/x86/kvm/svm/svm.h    |  2 --
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index eb60d6b959d86..a8bf847209618 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1134,7 +1134,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		return ret;
 	}
 
-	if (WARN_ON_ONCE(!svm->nested.initialized))
+	if (WARN_ON_ONCE(!svm->nested.vmcb02.ptr))
 		return -EINVAL;
 
 	vmcb12_gpa = kvm_rax_read(vcpu);
@@ -1484,22 +1484,21 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 {
 	struct page *vmcb02_page;
 
-	if (svm->nested.initialized)
+	if (svm->nested.vmcb02.ptr)
 		return 0;
 
 	vmcb02_page = snp_safe_alloc_page();
 	if (!vmcb02_page)
 		return -ENOMEM;
-	svm->nested.vmcb02.ptr = page_address(vmcb02_page);
-	svm->nested.vmcb02.pa = __sme_set(page_to_pfn(vmcb02_page) << PAGE_SHIFT);
 
 	svm->nested.msrpm = svm_vcpu_alloc_msrpm();
 	if (!svm->nested.msrpm)
 		goto err_free_vmcb02;
 
+	svm->nested.vmcb02.ptr = page_address(vmcb02_page);
+	svm->nested.vmcb02.pa = __sme_set(page_to_pfn(vmcb02_page) << PAGE_SHIFT);
 	svm->nested.asid02 = svm->asid;
 
-	svm->nested.initialized = true;
 	return 0;
 
 err_free_vmcb02:
@@ -1509,7 +1508,7 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 
 void svm_free_nested(struct vcpu_svm *svm)
 {
-	if (!svm->nested.initialized)
+	if (!svm->nested.vmcb02.ptr)
 		return;
 
 	if (WARN_ON_ONCE(svm->vmcb != svm->vmcb01.ptr))
@@ -1529,8 +1528,6 @@ void svm_free_nested(struct vcpu_svm *svm)
 	 * When the vmcb02 is freed, this optimization becomes invalid.
 	 */
 	svm->nested.last_vmcb12_gpa = INVALID_GPA;
-
-	svm->nested.initialized = false;
 }
 
 void svm_leave_nested(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 196fb39ab0ae9..2e0c9c469ec63 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -234,8 +234,6 @@ struct svm_nested_state {
 
 	kvm_tlb_tag_t asid02;
 
-	bool initialized;
-
 	/*
 	 * Indicates whether MSR bitmap for L2 needs to be rebuilt due to
 	 * changes in MSR bitmap for L1 or switching to a different L2. Note,
-- 
2.55.0.229.g6434b31f56-goog

