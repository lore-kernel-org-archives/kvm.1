Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B63EB7F0
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374608; cv=none; b=Y656hbRssvn3WrHiI2o3THuzW1Ve6nL0q6zM5agu4lW0XvQhZbD9rx0q3WxXuUyGlRyrOqM5fp9B9qiyQL6N0Jh12SYcZTF/UJeMi5m6UO+KB3TT07rz4tYALsYcNw03A0Oz9Ilku2AMkgiUQPtaKCeZ6gOvkxs+aU17OoK/pS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374608; c=relaxed/simple;
	bh=uWRDnS/vHDd52rjGMERq6SsAiryYF/CgZnXspFuYvHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMYOyEp9omUu9Y0WLlQsxVxgIAuuW7DlUzFu15foG2H4FhhvRWMeQR6ziRkL42GxHKiH9gm26sm+6iWAhlbiYfNmumbSrujR7SsIRqGbyg3UtdF83FxHLnGr99VlIu7rOt6L0iIhrN1EfkHH4Kexsa6BSvwOE8iOcrtIqwOj7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3t9y54u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3t9y54u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kuf4IDR3Ydbimabid6qV/JghvOduDmfrEOhZ/hgfers=;
	b=X3t9y54uviADtZUFdEkgjPx0hEZJEudmH8mFnwWfWr1Rikpb64XWg3lY8ZQqJrT/Q4tJS/
	yZVwTs1y1hXnriUqh8hV1v251OWTbMnUbHQx8RymRoAw/+NxzHmmdCNkw7fgAkw1SWfqo3
	eAW6Iaa0lJjjdpFeauqaUXDX70w4Szs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-hmPNU8CTNky9muvwOoZq8A-1; Tue,
 28 Apr 2026 07:10:01 -0400
X-MC-Unique: hmPNU8CTNky9muvwOoZq8A-1
X-Mimecast-MFC-AGG-ID: hmPNU8CTNky9muvwOoZq8A_1777374600
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F7531800367;
	Tue, 28 Apr 2026 11:10:00 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC6FF180047F;
	Tue, 28 Apr 2026 11:09:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 16/28] KVM: nVMX: pass advanced EPT violation vmexit info to guest
Date: Tue, 28 Apr 2026 07:09:34 -0400
Message-ID: <20260428110946.11466-17-pbonzini@redhat.com>
In-Reply-To: <20260428110946.11466-1-pbonzini@redhat.com>
References: <20260428110946.11466-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

KVM will use advanced vmexit information for EPT violations to
virtualize MBEC.  Pass it to the guest since it is easy and allows
testing nested nested.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h     |  4 ++++
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/vmx/nested.c      | 13 +++++++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 54aa5be50df9..ed2ded531e55 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -535,6 +535,7 @@ enum vmcs_field {
 #define VMX_EPT_1GB_PAGE_BIT			(1ull << 17)
 #define VMX_EPT_INVEPT_BIT			(1ull << 20)
 #define VMX_EPT_AD_BIT				    (1ull << 21)
+#define VMX_EPT_ADVANCED_VMEXIT_INFO_BIT	(1ull << 22)
 #define VMX_EPT_EXTENT_CONTEXT_BIT		(1ull << 25)
 #define VMX_EPT_EXTENT_GLOBAL_BIT		(1ull << 26)
 
@@ -617,6 +618,9 @@ enum vm_entry_failure_code {
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
index 299d4ca60fb3..46b65475765d 100644
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
 
@@ -7240,7 +7244,8 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
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


