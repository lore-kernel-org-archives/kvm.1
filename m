Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B53ACA5B
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374597; cv=none; b=uwb3MEBN5E/8FZXJqR+QrfFeRVGxNB6lS14qHvbWJvxhTEXaI7BG3glt8OX2q9CDNSwJ2szU/mdemLW8D7PcyHiT7dEjg8DypX5QPnrZBl7H5kw4stOzAP6VQ2NnvpSpMrmGy/3uG108FGm0bqeCCEcamiBhU3NUXMTapT2y+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374597; c=relaxed/simple;
	bh=m/y1kMQz/0mZXMPtm+sW3IoQNR3ZtUfQB3hgxkbWXHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPafYAthzn+KN8yFIed6d/0y7CknUBoI31QiTVIiO13NXEORamMyzy9a79S1TSWPw4WQQNJ3HPeoDVUiB0Qn1AFoERW/DG/fzb3QJQmyu2bujrBcjB4wo/hlTo5ZolK0IHGewnUBgiQhdLr5uOXqTLEnxwzjXVGQ6xW97hphfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTSOztVu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTSOztVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxFFgrsB72Gtu2mLfBxxq44PkZ2W/bhE3LoVP54M540=;
	b=YTSOztVuQ8aeQCmU1SlKCfmdksktap6S/JBIJx/U/C99gBWeLMDfABTlQffzav6ciHP+CQ
	PzraAdaIQV4z7kV/L4ID0gPaxn2Tf7zPkT8/oTSOBbtpwTHvmjbYscYc5h0Ek7IsvozccQ
	+uKhy9EHTvRPogV97X6LjJQoJsujXrY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-2P33H7KyNhiwBKcJK9tMDA-1; Tue,
 28 Apr 2026 07:09:50 -0400
X-MC-Unique: 2P33H7KyNhiwBKcJK9tMDA-1
X-Mimecast-MFC-AGG-ID: 2P33H7KyNhiwBKcJK9tMDA_1777374589
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD0F51956048;
	Tue, 28 Apr 2026 11:09:48 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD2DA300757C;
	Tue, 28 Apr 2026 11:09:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 01/28] KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
Date: Tue, 28 Apr 2026 07:09:19 -0400
Message-ID: <20260428110946.11466-2-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index 04ce321ebdf3..30cd5b19ecf9 100644
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


