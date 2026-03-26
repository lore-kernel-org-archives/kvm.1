Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8C3A1A5B
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549055; cv=none; b=MPE/Q3YpVSnURsIplvlXDScgXNywcpDcki7jqZh603vg0jOAo10ZDbhJYOjlNcFTrSTOMJk6rVQl9JLwGGLNXzW/wTXdsxM3j/0l7QSh4vLaRGY0I4b35hdwLCpl7JH1T9MUZAMCheWEagn5Mj8cOjt6s6DzFDNqkBY96GuLeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549055; c=relaxed/simple;
	bh=/hgPA8ofUfgPut6kjk1EiKMkvUvqj4HcFOe/kxoKD5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmimshJ85Oidv/OP788jRCSwvIr2yn/x0Idb2SBlcgZ43+qAxOGnJNEuRuJ4NbowVEJiP0F44n2rBKFFtbhyn8kbzyzz8ns9RdbwW0x8Sm9SGLMG8U6NEEC9W6DfifIpml7MfEzMllshah7BP+mQE++JsHdJU0eqcc4hKStixJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnEfgenV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9RoY2bM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnEfgenV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9RoY2bM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDapCol8DB+8Onsizv1MMEQf+Ju0eOGDbqoSTr6KUVY=;
	b=fnEfgenV3Zbm+30x+QylL2KciQzotj5fsmOPXHsDC5brcxKIp7XfIuxfzM6axnV9isbWCm
	FVnUSQriRvQizDAk8rL1yVkEZ5IzYGPoU2pnJ5iFNs9N/IVoajNDFG3G0FWx9q/I+JVtW/
	urkzZut3Ln3PalG3mxVHyQ7uYbSwoxc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-dooUKcF-ONOL23zNPdYn6w-1; Thu, 26 Mar 2026 14:17:30 -0400
X-MC-Unique: dooUKcF-ONOL23zNPdYn6w-1
X-Mimecast-MFC-AGG-ID: dooUKcF-ONOL23zNPdYn6w_1774549049
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4362197d1easo842410f8f.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549049; x=1775153849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDapCol8DB+8Onsizv1MMEQf+Ju0eOGDbqoSTr6KUVY=;
        b=i9RoY2bMJWiDNAhtB064Er8wZviqeEtFxYXU57iHddcxP7SAecRiyOTMD+xphFtUGM
         gFw4wRAsfmYFF5VKDCNyon/gm8EJT2gF6muWuO+wlRB7Cv5LX342xuz7zXKVfdJb5oTB
         cqkV7UU/fQUF1gbY5AzTp5MYUPzPgsm4j42SVGwEOpe7NbNn/m9SgV47rRd4gtWSOrb2
         lrcVaXtaJ4QGPYALnpo9F/t2UnVj6U0xywAl3+++Kqm3Xsm1Q+2KdCs5tm5b7DYeg47x
         r0UD+zum/ZJa4s1TXnfzeplAAHPHlz8mjZRtO50bnTrWaEEE6w5SuroJCNMDwx7buzLT
         KVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549049; x=1775153849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WDapCol8DB+8Onsizv1MMEQf+Ju0eOGDbqoSTr6KUVY=;
        b=M1uPBjoexOOqZ9hnI1zSW/F6x9k5C/K7EWOdEBpLIF7c0ucKUMGAdE2P+qg2RHjxMf
         l/3/W/GO3uoxHM6GyMJFYjCfHWwVlQbbNPupvotUcyqhXa+tfsXytYBfpM/HnNvJrorx
         Gfr+DqB9JXrCwFwOXYktdJ92LryeTEcjT6Gj7k3LkpPoF+kj3vOh/d5zFDz1i6VxhO4R
         K1kotY+vwCPIZxS4CEMEBQQB1j3BGPRzSBqtQrwzuzNG09nIO6JpDFvg3FuItsjPgjPx
         YFsQsFHO3EgtS8ah35I7gESGGRY9uSQr9EPwhpfuTEn5ZRMSFz7tcsTQ2MPDHXUlbMGy
         nCJA==
X-Forwarded-Encrypted: i=1; AJvYcCUSFpT8VBtjbmgImY6y2Hekwaa9B8UI8qyWMQugpC1ilS3dGXTemCSekAzzQj0bxzYJswY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsxhBc8AeQMgOejljGPlcvC1SGGJaYtREX0y5TOu6F/UjAWhk
	dvUFV+coYYFiSyFY1Gt76FIrapymC4GZ5X4+O6VaPuWA0jmm7qTLPo79x92I8MyV8ZamFj1Uf+s
	Coqc9BrpVWlKrkJpTxl4V4N7G41TS6uTuvd3VCTaChtoG6mevaNFfww==
X-Gm-Gg: ATEYQzwH3wllIQd0iQAP4yGEmGGT4nMj3VJAMsTEO0grP89rtr2RGPw5in9qn62GXl1
	AJ3j6Ly0PEV4wU6O3kqWABBMRFXGY0jq7eMFDV28VLRRrNJ8tYIuLL8wlMTQXE/oqWfT/bzZeaj
	+5y+3eDLVTARi6fvn9A1yBq7NdkU5QYtZLXEfeKOZbgVk3Joc1A8kW9+IGNmjBgJaxlBsDGrosj
	jzn73YHrqshDJ/fB1BtOw6ZvELF2LhXX7XA7+bMS5mOPdM67WQ3H5nKLSojiySLsgfH7+ny4L+j
	sDCF6NcD6D7qyZ+l8m3g3XkKmXdKWJo6UucpptAJdgubrPGM2J6GFufeWIT8q4NayUaFQ9kzmQJ
	cI94RF30oUoesT59yHfPNJ6IfHpRwFs2BSLvyoHiB2GsDFXcPc2VtYIbvXCmJMhrm1TLjzf2zg3
	Z8pOlU8vZv9Qa7gbnY2F0FLvzA
X-Received: by 2002:a05:6000:2c06:b0:43b:5762:2999 with SMTP id ffacd0b85a97d-43b88a8e8ffmr12921631f8f.37.1774549049151;
        Thu, 26 Mar 2026 11:17:29 -0700 (PDT)
X-Received: by 2002:a05:6000:2c06:b0:43b:5762:2999 with SMTP id ffacd0b85a97d-43b88a8e8ffmr12921578f8f.37.1774549048681;
        Thu, 26 Mar 2026 11:17:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7111sm9492066f8f.37.2026.03.26.11.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 01/24] KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
Date: Thu, 26 Mar 2026 19:16:59 +0100
Message-ID: <20260326181723.218115-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h | 5 +++--
 arch/x86/kvm/vmx/common.h  | 9 +++++++--
 arch/x86/kvm/vmx/tdx.c     | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index b92ff87e3560..7fdc6b787d70 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -597,10 +597,11 @@ enum vm_entry_failure_code {
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
index c5065f84b78b..fa740f70ee75 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1855,7 +1855,7 @@ static inline bool tdx_is_sept_violation_unexpected_pending(struct kvm_vcpu *vcp
 	if (eeq_type != TDX_EXT_EXIT_QUAL_TYPE_PENDING_EPT_VIOLATION)
 		return false;
 
-	return !(eq & EPT_VIOLATION_PROT_MASK) && !(eq & EPT_VIOLATION_EXEC_FOR_RING3_LIN);
+	return !(eq & EPT_VIOLATION_PROT_MASK);
 }
 
 static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
-- 
2.53.0

