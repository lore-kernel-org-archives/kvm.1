Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A32F8E8F;
	Thu,  8 Oct 2026 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418486; cv=none; b=pUWBWiWwpV8UrSVQsCH6505Zr89go1B/rXOH/28w0Aj3huL0TnFM9osqZYR3r60uEmdaSjv1OyfOV/fzeV4Rr1LmZ+WPfiGay4dPoo/W8n1srMILCEYl6T2SxCTns/ByyGkDN739qh53I3yNk1IwcKo/It5x5AArSUh+eotTyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418486; c=relaxed/simple;
	bh=IkauTFcXMJFn7zmj0pSmwP08l5D59Bdnltpff8wExWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNvJJhG9USMg27qCCNEVBpgxIv9p1Wl8XlvysGJ45W4S4hBtCD3TXIut99Jzr2BFy0AE4WJraTh89pTvGcnpolBArEBm1fOsfb5kuQexPjgrL95xhDge1zTLk1IhgTVIE+/PUEwqccNUTMo4z0Zvdu2Fq7geHoUAqL6KtqijUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBxY23cp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBxY23cp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76841F0089A;
	Thu,  8 Oct 2026 00:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418485;
	bh=/3kZ+4TQe6kQuRcrM6kiRDWv2X7dQbKK3orqZ9tn4qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QBxY23cpzAYlvqmaHMDaPpzql5hWw1LawEffaoKGiQ/RF//wwERrSyZa0c7uIIUDo
	 sBijelz6ZOo56l21+UDQzl5QnJqbKWCQK465KoeYmVi8osLlgGSGw2cRv4N8oFpFoH
	 iD/2AnznRMgjV09Dcmh2WHz9gqBJcsGuf3dk/dkRywIh4/eG7HuBmrLQI+SogUbGMv
	 ZKylyrQz/EolvzyG0aiWO17fbAt5tPQ8c0peArRLTkG8cb6lKol93z3cwKkrJjGxbB
	 rySLeKerbLN0GrhKHbmL1dF4wXgdkMnK7RFmzbPKf2PMN6AD8h/XatDAc81lb5GcTd
	 iZk1PFBfN4uuQ==
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
Subject: [PATCH v2 12/29] KVM: nSVM: Drop svm->nested.initialized
Date: Thu,  8 Oct 2026 00:14:08 +0000
Message-ID: <20261008001425.2458927-13-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
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
2.56.0.360.g66cac248cb-goog

