Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09F13DBD5F
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662963; cv=none; b=G0CY68aIKZetbGJaZ2JYufvCIRLJxm4rBiW8gnI6+pxPpwI8x2YQG2eiRZrnhi01nZTcYP/mdnQ69InkYhJueYE3/zYyyr3ZoTzU661LMKpscqLwUA3j6WoE/h37f7M/kV+szItMa7ECOUTECC/YcjMU5qZCcyjMchg9NNNxlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662963; c=relaxed/simple;
	bh=rPRdRLWg8htFM6ROgNGlDPkhA17nR+qayALDPyMV+Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHuvMr2fps6CRuMSNKtNCKOdGXWn4GAGNZHqlPe8YhRjorYzEfkMHnX3VnfCSW3TLinKuAaPRZIuKSQaMzKV4EoZjBNx9R25f/b3Mrth6VI1+XlJLI57SvrXr8t0apoTCA0ob3JZOKAWn3VJy5apoQQqGG7v4LgoaOVn8HbjGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fszmy2zi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fszmy2zi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izbJAGJGsnpYGt8ulJkjqisiCiGregx4QgYg2m66Fn0=;
	b=Fszmy2zi7sSPKZL2RF6zl5N8eXylPKOVAX1DGS5z7Q7iwDXAwMqBnEgh//wSZphqtSUCA3
	JdBI+ZS+EOxQmvFqXip/68OORGE8Pgt4zhZCNZXcK62NRubxLql9Mq6Gt5OuAAYzbBeai6
	5G/iyMjYmyfiYdYpz/erlD8dp8dDC5g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-Z3QMmR3gP92qlGJCYYA4dA-1; Wed,
 08 Apr 2026 11:42:37 -0400
X-MC-Unique: Z3QMmR3gP92qlGJCYYA4dA-1
X-Mimecast-MFC-AGG-ID: Z3QMmR3gP92qlGJCYYA4dA_1775662955
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69C7618002EA;
	Wed,  8 Apr 2026 15:42:35 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 952061955D6B;
	Wed,  8 Apr 2026 15:42:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 16/27] KVM: nVMX: pass advanced EPT violation vmexit info to guest
Date: Wed,  8 Apr 2026 11:42:06 -0400
Message-ID: <20260408154217.458420-17-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

KVM will use advanced vmexit information for EPT violations to
virtualize MBEC.  Pass it to the guest since it is easy and allows
testing nested nested.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h     |  4 ++++
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/vmx/nested.c      | 13 +++++++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 2b449a3948d3..fcd623719334 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -524,6 +524,7 @@ enum vmcs_field {
 #define VMX_EPT_1GB_PAGE_BIT			(1ull << 17)
 #define VMX_EPT_INVEPT_BIT			(1ull << 20)
 #define VMX_EPT_AD_BIT				    (1ull << 21)
+#define VMX_EPT_ADVANCED_VMEXIT_INFO_BIT	(1ull << 22)
 #define VMX_EPT_EXTENT_CONTEXT_BIT		(1ull << 25)
 #define VMX_EPT_EXTENT_GLOBAL_BIT		(1ull << 26)
 
@@ -606,6 +607,9 @@ enum vm_entry_failure_code {
 					 EPT_VIOLATION_PROT_USER_EXEC)
 #define EPT_VIOLATION_GVA_IS_VALID	BIT(7)
 #define EPT_VIOLATION_GVA_TRANSLATED	BIT(8)
+#define EPT_VIOLATION_GVA_USER		BIT(9)
+#define EPT_VIOLATION_GVA_WRITABLE	BIT(10)
+#define EPT_VIOLATION_GVA_NX		BIT(11)
 
 #define EPT_VIOLATION_RWX_TO_PROT(__epte) (((__epte) & VMX_EPT_RWX_MASK) << 3)
 #define EPT_VIOLATION_USER_EXEC_TO_PROT(__epte) (((__epte) & VMX_EPT_USER_EXECUTABLE_MASK) >> 4)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index de8770d2fcfc..f5f9e745f21d 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -494,7 +494,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	 * [2:0] - Derive from the access bits. The exit_qualification might be
 	 *         out of date if it is serving an EPT misconfiguration.
 	 * [5:3] - Calculated by the page walk of the guest EPT page tables
-	 * [7:8] - Derived from [7:8] of real exit_qualification
+	 * [7:11] - Derived from [7:11] of real exit_qualification
 	 *
 	 * The other bits are set to 0.
 	 */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index cdc35a2728d9..e0ef2cb8f2cd 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -443,10 +443,14 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 			vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
 			exit_qualification = 0;
 		} else {
+			u64 mask = EPT_VIOLATION_GVA_IS_VALID |
+				EPT_VIOLATION_GVA_TRANSLATED;
+			if (vmx->nested.msrs.ept_caps & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT)
+				mask |= EPT_VIOLATION_GVA_USER |
+					       EPT_VIOLATION_GVA_WRITABLE |
+					       EPT_VIOLATION_GVA_NX;
 			exit_qualification = fault->exit_qualification;
-			exit_qualification |= vmx_get_exit_qual(vcpu) &
-					      (EPT_VIOLATION_GVA_IS_VALID |
-					       EPT_VIOLATION_GVA_TRANSLATED);
+			exit_qualification |= vmx_get_exit_qual(vcpu) & mask;
 			vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
 		}
 
@@ -7238,7 +7242,8 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
 			VMX_EPT_PAGE_WALK_5_BIT |
 			VMX_EPTP_WB_BIT |
 			VMX_EPT_INVEPT_BIT |
-			VMX_EPT_EXECUTE_ONLY_BIT;
+			VMX_EPT_EXECUTE_ONLY_BIT |
+			VMX_EPT_ADVANCED_VMEXIT_INFO_BIT;
 
 		msrs->ept_caps &= ept_caps;
 		msrs->ept_caps |= VMX_EPT_EXTENT_GLOBAL_BIT |
-- 
2.52.0


