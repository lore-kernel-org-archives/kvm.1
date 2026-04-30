Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3742C21E8
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561682; cv=none; b=LRfW5jrXGisB713c0G26rjuGroeoSB63XCMKUbpAvFgAJstb653c538Yvk5eg00wMgjN4G9KCOBNxYpx0UfHt6H9LdfBxn6oilaFx2koNFe07wTQ6oMpofZuSXVFhLmHUA/WUklRE9WGyrN9nFlcai49NlqEFrLNx0Mmt5Pn7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561682; c=relaxed/simple;
	bh=qN6uNsXXrdxPWeiUyZUCQi9CQmefkvVmCbWD7S5KIeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdY4TAiXYlcv8D/LpOQkQsDOK1UR87n3LgpM6bT4nhgpow1fRul6ekkDQO48sX8iGmBFEZg1U7eZOoRfZ+gWxl2hR0DA/nhNrjgQ/KtjmlJw4i5LiCzco37cEPYP0Cqjnxiq3e4lzIxFyN+XD9/vpKOUK1IXRBG7F2jPadxHgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B70tK9mm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B70tK9mm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgCNJ6QbPXfdRFucAOWtH1ZqPtP2sYd3GhwHotAeOtc=;
	b=B70tK9mm911nvmMS+DHN2+KCAEQrOXOIgnBBcv+b59G+W5+x+wi7eEKkMmAYKLNQ8Gu6Vk
	9zhF0PRGgCYWkgcYiuEE746/jx6x/c6CK2n2d64NVYLVDIuVx7vmtVTm5HvJNkPmsUeuwZ
	IP4sfOaD8q0+ssbmKGDiPSP3FSJUlrI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-lYvAiO0cNxWV0EBGXJWXaQ-1; Thu,
 30 Apr 2026 11:07:51 -0400
X-MC-Unique: lYvAiO0cNxWV0EBGXJWXaQ-1
X-Mimecast-MFC-AGG-ID: lYvAiO0cNxWV0EBGXJWXaQ_1777561670
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24EF919560A5;
	Thu, 30 Apr 2026 15:07:50 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EE001800480;
	Thu, 30 Apr 2026 15:07:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 01/28] KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
Date: Thu, 30 Apr 2026 11:07:20 -0400
Message-ID: <20260430150747.76749-2-pbonzini@redhat.com>
In-Reply-To: <20260430150747.76749-1-pbonzini@redhat.com>
References: <20260430150747.76749-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Jon Kohler <jon@nutanix.com>

EPT exit qualification bit 6 is used when mode-based execute control
is enabled, and reflects user executable addresses. Rework name to
reflect the intention and add to EPT_VIOLATION_PROT_MASK, which allows
simplifying the return evaluation in
tdx_is_sept_violation_unexpected_pending a pinch.

Rework handling in __vmx_handle_ept_violation to unconditionally clear
EPT_VIOLATION_PROT_USER_EXEC until MBEC is implemented, as suggested by
Sean [1].

Note: Intel SDM Table 29-7 defines bit 6 as:
  If the "mode-based execute control" VM-execution control is 0, the
  value of this bit is undefined. If that control is 1, this bit is the
  logical-AND of bit 10 in the EPT paging-structure entries used to
  translate the guest-physical address of the access causing the EPT
  violation. In this case, it indicates whether the guest-physical
  address was executable for user-mode linear addresses.

[1] https://lore.kernel.org/all/aCJDzU1p_SFNRIJd@google.com/

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-2-jon@nutanix.com>
Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h | 5 +++--
 arch/x86/kvm/vmx/common.h  | 9 +++++++--
 arch/x86/kvm/vmx/tdx.c     | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 37080382df54..b2291a766e3f 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -608,10 +608,11 @@ enum vm_entry_failure_code {
 #define EPT_VIOLATION_PROT_READ		BIT(3)
 #define EPT_VIOLATION_PROT_WRITE	BIT(4)
 #define EPT_VIOLATION_PROT_EXEC		BIT(5)
-#define EPT_VIOLATION_EXEC_FOR_RING3_LIN BIT(6)
+#define EPT_VIOLATION_PROT_USER_EXEC	BIT(6)
 #define EPT_VIOLATION_PROT_MASK		(EPT_VIOLATION_PROT_READ  | \
 					 EPT_VIOLATION_PROT_WRITE | \
-					 EPT_VIOLATION_PROT_EXEC)
+					 EPT_VIOLATION_PROT_EXEC  | \
+					 EPT_VIOLATION_PROT_USER_EXEC)
 #define EPT_VIOLATION_GVA_IS_VALID	BIT(7)
 #define EPT_VIOLATION_GVA_TRANSLATED	BIT(8)
 
diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 412d0829d7a2..adf925500b9e 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -94,8 +94,13 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 	/* Is it a fetch fault? */
 	error_code |= (exit_qualification & EPT_VIOLATION_ACC_INSTR)
 		      ? PFERR_FETCH_MASK : 0;
-	/* ept page table entry is present? */
-	error_code |= (exit_qualification & EPT_VIOLATION_PROT_MASK)
+	/*
+	 * ept page table entry is present?
+	 * note: unconditionally clear USER_EXEC until mode-based
+	 * execute control is implemented
+	 */
+	error_code |= (exit_qualification &
+		       (EPT_VIOLATION_PROT_MASK & ~EPT_VIOLATION_PROT_USER_EXEC))
 		      ? PFERR_PRESENT_MASK : 0;
 
 	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1e47c194af53..89f9fe30435d 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1845,7 +1845,7 @@ static inline bool tdx_is_sept_violation_unexpected_pending(struct kvm_vcpu *vcp
 	if (eeq_type != TDX_EXT_EXIT_QUAL_TYPE_PENDING_EPT_VIOLATION)
 		return false;
 
-	return !(eq & EPT_VIOLATION_PROT_MASK) && !(eq & EPT_VIOLATION_EXEC_FOR_RING3_LIN);
+	return !(eq & EPT_VIOLATION_PROT_MASK);
 }
 
 static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
-- 
2.52.0


