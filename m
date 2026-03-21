Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104D2236E8
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051782; cv=none; b=lBwuQFk81kYVCFKpz2jIofluuJ4WDpBWutloZkZEy2JR73E4MvnHVeesBYwakea7OvSqcs3cNiLX3PDtoy3uNxlgX49kt4MlvmfuEJ/5pEVpFMPr45niTFs+PIJ/rT9fx/Mjfm348RGpfHamfIf2aj5tuE+m7b5wDhWNvFzP9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051782; c=relaxed/simple;
	bh=zDCBCYBPUvbeE25M9z63UMM9kTMU/AQZnM1CnQbk58s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Type; b=FS4iRc0FjwzLiqMpq4LxNNty5xXLv4iGZc8wrZSnSFmtT5kYZQh90fd7CTtBciQ/7Fk7wFjSnKUSMy5eTlQibFngBbQazgp/impH7pGgkTd0kQRdzgGwEWDfsB6lH8xvCXS7LO8yB3g+ZPq4awhc++I7PZGUxAnc0n/DPan2y60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HofBSRKw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNs5EGzX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HofBSRKw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNs5EGzX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sc7ZxTtUy7hlpRcyZngf1dKFBcofak52j6l4UPVMDlo=;
	b=HofBSRKwRr5QSXTMTl/hltjeefZpPtkxvIFH6P3lAMmhY955MFhVSkBNUF2mCh56oKcig7
	J254yQ7s4ZfMa9SyewBce2Kiv9qbRw5NM6czgYzFVA67ECuY4C9aiWBX7NKKVmCIb3pCxt
	DTcsuaXAKCMgj7L81SW4L/sTqTRxKe8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-78yYO-NXP2W_yF1Xw0yH_w-1; Fri, 20 Mar 2026 20:09:38 -0400
X-MC-Unique: 78yYO-NXP2W_yF1Xw0yH_w-1
X-Mimecast-MFC-AGG-ID: 78yYO-NXP2W_yF1Xw0yH_w_1774051777
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48531e8ae62so6790825e9.3
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051777; x=1774656577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc7ZxTtUy7hlpRcyZngf1dKFBcofak52j6l4UPVMDlo=;
        b=DNs5EGzXb8pahymQaHxsjjWPV/4Tb2Verj4FSfNO0Usgp6oqyol3vvp5x0/DdhF4U6
         6+Sqihvj+z4UZZDWLBwK1mP8ungU/HOvblsq9PgEDqtve82sIff4eJ76gyc7T+lBHLkb
         76PE0WjPnjcjPWSnG85QecO13myOKEm5P2Ea4ugaxFYKs86aSy4p6GUTSYK7lIaA1rFw
         Ua/t48W45RRnOez27Bk9rN+rZEqU+PidiaH4wbfI4Q5+32s60BsnVzLePyEul1eiDZo9
         EqqyCO6CSpE2iLcngk1HLCRRkexLSkmPufX008+UFR/CElj9BLKxUG9auDnFhp+LxiDN
         6LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051777; x=1774656577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sc7ZxTtUy7hlpRcyZngf1dKFBcofak52j6l4UPVMDlo=;
        b=gCXY4XDGuhCH+TKjHkQONY/Ga+wWO+igoF10kev8T9X1R7Ozva2LWzQx/s2rjME7Dj
         ThBgTVnPMlMEhAV49fOqoequx/wSj4GuWLDoknl+yCMeNNMAtAQljS8TZVdFcid69NAQ
         sV8Ke5DlNZfeROplRkVxEM4+FMxcei8W0cKk00cPpH4XDNUHBKokVokRcai1eD918Y/i
         DO3JfKg62xI3odvqbq0enN4Y7FqHbUyC4MytJDOHfVjwvP8p6CUf3slYrHn83AG9KYTa
         EbTm+6DmzpDpGesVyrpgVo/BW6sqWm6vRPYi+bra7R2qJG0U/D6LYDZeuimANIfP/YdB
         pD5A==
X-Forwarded-Encrypted: i=1; AJvYcCUDut3ga6M8ADEw27MmHRsI3vAtCjpE4vDgpExEMkgdcnqzVdqnVqREuTuT0Xga0JPnGds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehGsspr05Oe6RqbLA/ZTRMj2jM496YsUU7ZHqN6caCVfvkijE
	C6QOqnUWVoeX1Q2eb53Mp/AS6s2IKkdPsTCC6gb/Eo6XJSGMNfpxS4I4SKI9xHsy3Le5Z5yd+6G
	RqcDD9q0viZ97T6GUVe2Jft6nIBRPPbc44LM4pzmOdeY2fuP6JXN4QQ==
X-Gm-Gg: ATEYQzwkOHScTm9YFl+s/SPA8uFaV57ifr5kamYFzLT/8sBLnQO7emQQ81gLI9v0Ayd
	cwoqJsS25PUTUULwPVVOM+IKNDib1DpsmvhL9R8Zc6gjnx6d28WgYZGvnkP+gb8RvIoY5bBZt/c
	qeMnslnRTvUqCGlrwoP70DqjbC2Hv04VcupiWJmAN2ci9/y4B+8/iKQ03AOsl1SldoaMwydN0hG
	UQtNnIfruo+j5a+pQ6SdZsfV9ALrBv5r48u/SgE0wnsWKiS3d2QooUhgxWnbeEPdSPOlXB+XEiU
	DMPJGXpIKqUU5L23wIV0ZxTs9MuGjzd+Ee/luLzIajjq5x+D2/M9HhCu0krBahGGcEge5mMlDFb
	Qe7GpEMg7BZrMDxnn/vtoEu9nSNczcPtzXR49vWOs3yadq9fj9GY5t+S3/Fqk7fKrmJoYC8RbY2
	QSbGETbdYILqfqDewjlx79o1Hh
X-Received: by 2002:a05:600c:4ed1:b0:485:f1d1:8f3d with SMTP id 5b1f17b1804b1-486fede5d12mr70797615e9.6.1774051776699;
        Fri, 20 Mar 2026 17:09:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed1:b0:485:f1d1:8f3d with SMTP id 5b1f17b1804b1-486fede5d12mr70797325e9.6.1774051776218;
        Fri, 20 Mar 2026 17:09:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe032a55sm177243955e9.7.2026.03.20.17.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 01/22] KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
Date: Sat, 21 Mar 2026 01:09:10 +0100
Message-ID: <20260321000931.1947084-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

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
  If the “mode-based execute control” VM-execution control is 0, the
  value of this bit is undefined. If that control is 1, this bit is the
  logical-AND of bit 10 in the EPT paging-structure entries used to
  translate the guest-physical address of the access causing the EPT
  violation. In this case, it indicates whether the guest-physical
  address was executable for user-mode linear addresses.

[1] https://lore.kernel.org/all/aCJDzU1p_SFNRIJd@google.com/

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-2-jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h | 5 +++--
 arch/x86/kvm/vmx/common.h  | 9 +++++++--
 arch/x86/kvm/vmx/tdx.c     | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index cca7d6641287..4a0804cc7c82 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -587,10 +587,11 @@ enum vm_entry_failure_code {
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
index c308aedd8613..bf9fe76d974d 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1921,7 +1921,7 @@ static inline bool tdx_is_sept_violation_unexpected_pending(struct kvm_vcpu *vcp
 	if (eeq_type != TDX_EXT_EXIT_QUAL_TYPE_PENDING_EPT_VIOLATION)
 		return false;
 
-	return !(eq & EPT_VIOLATION_PROT_MASK) && !(eq & EPT_VIOLATION_EXEC_FOR_RING3_LIN);
+	return !(eq & EPT_VIOLATION_PROT_MASK);
 }
 
 static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
-- 
2.52.0

