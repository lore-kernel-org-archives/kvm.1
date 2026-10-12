Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C640EB9C;
	Mon, 12 Oct 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848213; cv=none; b=gyq8l865WVwvNUUIbmDWRx8PNHS2L/SLEWV0D9WxrvP6+mLynpi7zYVQcAaQOpGkW667CXdms6jcj9/GqYDm3LBZzxhtppRJmbxHrmJrIK25e2hlhwLy3EslaCiBZvfubjzi1TY3fqJmx9FewXDdyF2nag5n48qpR+Lyfn8zkpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848213; c=relaxed/simple;
	bh=dbFgaX2AdpR5Fg6ME+wJKVScVJBw5Ee5sZocf5V8cwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3LinXpIe2nQ5V9Cd14rzQZsrvXl2gt76woQ5aO+pPCLA84mcMnWpPNkee3S8BsUxWttjTEblWg0agL+uYpZ/95xnGyEB/mBwQUIQY8HR1nzr9rfuPSxiBWeKLOL6DqLYU65Ae5q5OEow5X3JNEYxbj0rGa21P1YMJjueIc7+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQtg0zW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQtg0zW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3FE1F008A2;
	Mon, 12 Oct 2026 23:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848212;
	bh=ssWMLAr0B+08Gli72Q9bEyXKT+dsEa6dtKvbW8x1qHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZQtg0zW1Qyzehzudpnn2Y8Tj1Xy2OjDw29QKDS+szUlexoQ+LiNhUg/7meGCw78/a
	 0DD42wk8OBbKHnYuxxc0Jq+TgdKWfjbA4QibxF+VG0HVWlVISaePvI1wkmTaOtlUe9
	 ujsqFgRNHNk5UelHbdX5dZ3i/lUCoB3INXCEC+OgbCxkJNIO7gjYlWEDl0dN1NW8kX
	 bbxqF8fTGlTNOzROp2IJgC/VEUfOM3PQGSHWmYHuxDdwWcqaDrNJ1Dg2Y3K6/Geat5
	 /ljYJ8bZ5qLeFlRBjiwNRIS2uBuRsULlr0nxx79uDQTymH750oRGMQG564OT/bb9lt
	 UY84AZh0dvYzA==
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
Subject: [PATCH v3 12/27] KVM: nSVM: Drop svm->nested.initialized
Date: Mon, 12 Oct 2026 23:36:23 +0000
Message-ID: <20261012233638.2546339-13-yosry@kernel.org>
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

Do NULL checks on svm->nested.vmcb02.ptr instead of using a dedicated
proxy 'initialized' field.  Make sure svm->nested.vmcb02.ptr is
correctly set to NULL on initialization failures, as it is currently
left as a dangling pointer.

This makes it possible to directly do a NULL check on
svm->nested.vmcb02.ptr before using it, instead of checking a different
field, which is less error-prone.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 14 ++++++--------
 arch/x86/kvm/svm/svm.h    |  2 --
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5d63ae47ebb6c..bfb297b7d71ab 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1142,7 +1142,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		return ret;
 	}
 
-	if (WARN_ON_ONCE(!svm->nested.initialized))
+	if (WARN_ON_ONCE(!svm->nested.vmcb02.ptr))
 		return -EINVAL;
 
 	vmcb12_gpa = kvm_rax_read(vcpu);
@@ -1489,21 +1489,21 @@ int svm_allocate_nested(struct vcpu_svm *svm)
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
 
 	svm->nested.vmcb02.cpu = -1;
-	svm->nested.initialized = true;
+	svm->nested.vmcb02.ptr = page_address(vmcb02_page);
+	svm->nested.vmcb02.pa = __sme_set(page_to_pfn(vmcb02_page) << PAGE_SHIFT);
+
 	return 0;
 
 err_free_vmcb02:
@@ -1513,7 +1513,7 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 
 void svm_free_nested(struct vcpu_svm *svm)
 {
-	if (!svm->nested.initialized)
+	if (!svm->nested.vmcb02.ptr)
 		return;
 
 	if (WARN_ON_ONCE(svm->vmcb != svm->vmcb01.ptr))
@@ -1533,8 +1533,6 @@ void svm_free_nested(struct vcpu_svm *svm)
 	 * When the vmcb02 is freed, this optimization becomes invalid.
 	 */
 	svm->nested.last_vmcb12_gpa = INVALID_GPA;
-
-	svm->nested.initialized = false;
 }
 
 void svm_leave_nested(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d386f2a4f72d7..2e1b5481ddd92 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -234,8 +234,6 @@ struct svm_nested_state {
 	 */
 	struct vmcb_save_area_cached save;
 
-	bool initialized;
-
 	/*
 	 * Indicates whether MSR bitmap for L2 needs to be rebuilt due to
 	 * changes in MSR bitmap for L1 or switching to a different L2. Note,
-- 
2.56.0.385.gd3acb90ef8-goog

