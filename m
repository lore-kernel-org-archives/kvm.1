Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC63C5DCD
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010756; cv=none; b=UiDTA+yR8mJToKAosQfo6SBOkFBAruMfJbR0hD81Srsz6/TJygymRldHsaPcbwAPJ2sbEL8sFkxodHdhEoSQVjvaOgv+2vQyhFbPjbYn9WhO0sfFvkJ6AkhfNOO8IjBLRV9DdhKtYfnPMqc8kOBZpjm1sioMD+0aIP7h1Zh5aoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010756; c=relaxed/simple;
	bh=X2Z78ecZ3ZOqfsmKUl49A6t2EIzk4qED2aVr+auIv38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZSbKC+NMgu35NSXvjM7rnMal/XS/MtBVaV7O+vxNAHNWsLncR2QGG7VpO/UfqFOnclys96EoO1fCB1pvquGW5ioFjiovWL4QxpFPM48Q9nMqlGm2L88xVeWMLlWHRIeMjXffUuKZvLi6E4b0Aw0/32JwNRyZyv248CGQXRVWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFOnVnpx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvYVtk4S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFOnVnpx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvYVtk4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ou2MGqWQWlSf5Uj7do5k2J/VRiPnju6cFxW52aKM19Y=;
	b=SFOnVnpxvNeW5qXX0ShiAf3+K1XLjQQbeJTpWNpW2iD5n55vW7MPqoDHAwd9TCYK2HMo8s
	xAtKpAsl0dWijeNfnFjx0hQUy1BSrcVc7z0mf8qqxIGkU9xGzvSB0AdtTmSEWaisVbnE3d
	1zBs39pN2k7zKzDG9wXyLHT62aVHS98=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-feRGCFSZPoSUJjFfU5ZHGA-1; Tue, 05 May 2026 15:52:32 -0400
X-MC-Unique: feRGCFSZPoSUJjFfU5ZHGA-1
X-Mimecast-MFC-AGG-ID: feRGCFSZPoSUJjFfU5ZHGA_1778010751
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso70673875e9.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010751; x=1778615551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou2MGqWQWlSf5Uj7do5k2J/VRiPnju6cFxW52aKM19Y=;
        b=OvYVtk4SgRG6fZ0PdGeqtlv5ffgzZJ+oBj2mnXk3oQ2Qryji9UwOVSMi6tisOSqiKz
         8/NaEiEwPp4zjvyJFnXerJWBBTdSX9BvDZvK53liVXviiKMsEWZt+ltKf+W6qwgxQm1T
         dRGI9FlilNSXfa68TtVDiEi+g3UXqZzGw1V34aosNsXxTI07rlzYH3mF64S79wZr3PcE
         mM9cTs79uONdrBxAg1sjtYjCSEwgZv3m5dqM36kiAvc8des0EOI3CNP/QhN5l+OQEIqW
         /sozRkrBkD1ZNDf6j5Y7N/sSrAxeyh/Y3zmu7/iGwyAlQSwY2B/0wfa8o4hJy8LVOiE1
         Cr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010751; x=1778615551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ou2MGqWQWlSf5Uj7do5k2J/VRiPnju6cFxW52aKM19Y=;
        b=UUbIUjvABHV8JMCulxXVnKvsev98fq2JcXAEFdY3Iizk9LipMnVM8KhosULl1mR5gQ
         f5C6qDC3U1bCO7YCc0Fu97ps/cIEMUKfxjwyExrQZpOubIg8bRma9EpDMV+XDIFQroWO
         8q5tf8NwIr7yr2MURwLtbn3PlrUZDX0L6MyJxxK0XhdIxMEKBA7lrmEgDwqJVp7G2H50
         pipTGveTtc5PjWOaI8xJeCeTaDfXlKbD08dGiwGx5vLO1TU2vXOYE8oNSY66eIT7YD7E
         EuR18u5WlZT7XRwzjOHlyDzJB/V9ZBv//qMADXJiJjjCinNqLoAb7t/k95jSD0VHCZBu
         Dm+w==
X-Forwarded-Encrypted: i=1; AFNElJ/cOphNN8VlnbePipoMQO85Sbi0nHTN/thmLSujTUg4E8/NpCUHPDYQ3aM4IZjOH8k1ycA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3LWmZ+nOAAAmBUJeWPVcAtu1f4QIIUmAlsUkJKKxSMs7nZZp7
	gueVEgWg36CF0PdJtGNE8/t97ae7NzJfUsT4sk7MwpcyfDq/roY8z7Qgk+2tiTUGqKP/mdVa8cz
	4iCIIQTmoE5uEmU1iY2i/zZQBlMlvu7JbH9eiRqPpKUC5bG7Md5pdTA==
X-Gm-Gg: AeBDieuWyN3qbY6ApLplOYTRcXHFh+s6FGu/wzuZmDbB7GGtBs2sM5f/ygQbhwHUITK
	sNAKRhr3wYBIcAKdx3b70ulOO8eGdklFqQOjzuE2VEP6hCD0f1ksYZDf881XlmZSeUUG8co4PAv
	bLK0kJFno/z63lQT8TXV1FvUPKqETZ11tsdXmwngMgtQ/qVMoYpiQ8+2ASOOWmy605hJCCgoC1p
	tr+IwB2O8BUiI2oDTGOoAJaGPnmLiBQ0Ul/pn1i/0nl2q5oFHT3i7Oid2vpP40B34PhvJIcROE/
	eUbLQ3TSeRRcuu9DYVNNx5Xq+IEcshSPVHyD6kZ+TzlFYSV6s/MSNu2LkR9dLqaptOCEt4BU50I
	g+NTkfMvuL2JI/gjMuh/OIPtqJDdmwlvmOasmCEOu2n5yor3XqPknXqL5eFnZwFKVIztMuBp4IF
	FnlgptciUjyK5dLwrRkc+vVBmvIqLW3AVn4DT1mkM=
X-Received: by 2002:a05:600c:3b96:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48e51f55272mr10710405e9.27.1778010751498;
        Tue, 05 May 2026 12:52:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3b96:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48e51f55272mr10709995e9.27.1778010751111;
        Tue, 05 May 2026 12:52:31 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb694fcsm397588845e9.3.2026.05.05.12.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 01/28] KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
Date: Tue,  5 May 2026 21:51:59 +0200
Message-ID: <20260505195226.563317-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
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
2.54.0

