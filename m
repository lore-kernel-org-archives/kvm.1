Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82814C043E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010795; cv=none; b=iGZi5NecF5g2i5li7GeKQI/Dxvgl3y8QigoDnLNc3kyBZkPJ9YjquFbu7rrLhAJtrYbmrt3+DUjIWueqd2gdWwJ2WUcM0jeSnKXwA7fcjP2NqAnlUn9U5P2mfCWjgcZhSUZsGk2TXtrvgD1ICIK1s9BKPXzz+jAGdCSgDQPcLbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010795; c=relaxed/simple;
	bh=p/RS8mTkZARsqGGf5FHu4Sq1ULWyZ5K+JwTgdxX6Gok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsvWzrX9n4EINgIQkrlb0kx/r4lnk2Aq9BvoYePgUTVaUMurSVQhc2hfe3r2pphkEE4psyoekhZ+9CQr9sG5fI0aI41uZhGAg/t9QaOw4FU19POpGVAe3jlldxrIscOQbYd2o4YMlCgK3XPVejRpUtt0EAp8gPaT4lRcsanInA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jR9puPet; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1CrrKlm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jR9puPet";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1CrrKlm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1LlbVVvb6bc3n6W/eomsX6pDCjgYlqb6seg4n1Vqj4=;
	b=jR9puPet7PCv5uwgeSd0Sf8ZtufVeHaPCAWaAkoZam/lMaqkQaEzNTm6ySVCfCIols+CWm
	tSeCiq7wo9uULUgXIfT1NOGIP0zmGUG0vPZp62LtlL3uHj0wtDx1gd+STE/1MYzi76K7wE
	S653CJg/oNLHC/DF2rnAuZ9Srv3Uzck=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-VWZ5ADQYOmWTIVG5ywF33g-1; Tue, 05 May 2026 15:53:11 -0400
X-MC-Unique: VWZ5ADQYOmWTIVG5ywF33g-1
X-Mimecast-MFC-AGG-ID: VWZ5ADQYOmWTIVG5ywF33g_1778010791
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a122a5128so3402560f8f.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010790; x=1778615590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1LlbVVvb6bc3n6W/eomsX6pDCjgYlqb6seg4n1Vqj4=;
        b=T1CrrKlmAHt8ZlL2vCY5uTU+E6KB5CuTQYOav9ySq1vsUPzu3aPhAZdErvDc//O19V
         6xUk8upCvibOVrf29SOnYZ+l7USzX/KOI127oMenChDIkOsTD2TTWZ94YCHnL7jLdgNy
         7/b3XhCTIIqdiMu/DNCJe67EiFBeF0NqSIU7PwuQnp0BCx8Ceic3enW3NMsRCeiYrFfe
         BtkfoFcLfncv/sloHfGlFZxq53k0YppR7TNnvLpu7B2Zwvz13SC0j3OTSn6huF5916Zq
         J8YD/AAavp8kal1ZtUQ062wn1h+iluRrrwIBIekwJhZp+88RslB2d7ytVFJfdCKwIMGi
         XP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010790; x=1778615590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K1LlbVVvb6bc3n6W/eomsX6pDCjgYlqb6seg4n1Vqj4=;
        b=W5OnJ7eJ/Pxyp6cuQY21ZHJ54P2n0JIMF+88FGHuzUjie09YkZkEVmne++tQVLpPTo
         /1tLYJNgskUx8E/kSTqO8teyIWQ7esPa2Q2SNYY9SZyHmsxt0bdQfg9/H6hQUHdubfNq
         4zkae/hBJ7f0Agjp5XOIjbTPK+MpzpwHjkwdO6BTUaMRRb+QaeqGZ9YVAQt2JdGvklMG
         dvPA6TpyIW4G8nWwcT4T+OjkMt63z36OK8Z+4mW3YjnSgEfoe43fF2vLu1s1Z1MGWg71
         iqY2zbsuuXnuCv4X5GSttkiNp8qLW0gww2fnDTBRwmzpEy6kSxfMDVZijRSRUWL1BeAT
         NnAg==
X-Forwarded-Encrypted: i=1; AFNElJ/iZjzLKx7qJ5ebb0nJ/pmLkXOj0aAcvSd/JJ3/h7G+8ieM/P640nA0JURrqUz9LhPW8eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76tq7iqnuBBZRgauXgFfcr1TdnR+iPPI6LB5ilhr6rhQyXaS7
	m8cdSe9FRqdrOSrYfaJIF3qiPYeJr9tcWZ/+9igRdj67iLLTC4b9pKWjYocf5lqZtqQldHwp6YC
	0zF4wh47IOssxpKwzqQoSKlNjfaohBacxCRD87ua+HSKD/bonWL6v7JE94e39Kg==
X-Gm-Gg: AeBDietI0em+f8no29wsk9u/zQtujJmkuTEAxRysBz46sbR2FBqiJKj6fNj3gSZW/4a
	BwM/24qTNcsyOEsa9c/0s/O27oNbgwjetOX+tcH+D/uWVabSHzerAaHhnnFQJrCdBh2ufr3uB8i
	GTtaYU17M1Gaxb5m8p4Ic8UqqBuavI66+UZZHhSbXxz/Y/NXsU+1ViChZzbTkIKafobT7SZ0rlu
	+Q0ETRKxnJd/ISFGIlW18yXeQeg+/SV99P8//XKjdEIEee2QLx73C3N3r7ibieS+bkHlhPd5wxA
	Q5S5VFIHNWQNh1auQKTlR6OElA9OQf9GAmjBRH5RGDEImXmQFF/Dbo2RjNQyYqXf+ZR1rTqWjCO
	OpbBiOv8Zr2e77frmLmvKV8+cx42EZA9CEAsFqf/P9lJF1rL2R1Te/lMZ+zg2rMdP7q4YAFlhdA
	p1yxc3QzFSlP9BAOpUd7le+42xcg2/e2qGOCwhKYw=
X-Received: by 2002:a05:600c:8b04:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48e51f183demr9670625e9.5.1778010790226;
        Tue, 05 May 2026 12:53:10 -0700 (PDT)
X-Received: by 2002:a05:600c:8b04:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48e51f183demr9670255e9.5.1778010789807;
        Tue, 05 May 2026 12:53:09 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb2f32sm377292575e9.13.2026.05.05.12.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 17/28] KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
Date: Tue,  5 May 2026 21:52:15 +0200
Message-ID: <20260505195226.563317-18-pbonzini@redhat.com>
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

For EPT, PFERR_USER_MASK refers not to the CPL of the guest,
but to the AND of the U bits encountered while walking guest
page tables; this is consistent with how MBEC differentiates
between XS and XU.  This is available through the
"advanced vmexit information for EPT violations" feature.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/common.h | 12 +++++++++---
 arch/x86/kvm/vmx/vmx.c    | 10 ++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 40fa72f31fc7..08005676702c 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -100,9 +100,15 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 		error_code |= (exit_qualification & EPT_VIOLATION_PROT_USER_EXEC)
 			      ? PFERR_PRESENT_MASK : 0;
 
-	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
-		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
-			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
+	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID) {
+		if (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) {
+			error_code |= PFERR_GUEST_FINAL_MASK;
+			if (exit_qualification & EPT_VIOLATION_GVA_USER)
+				error_code |= PFERR_USER_MASK;
+		} else {
+			error_code |= PFERR_GUEST_PAGE_MASK;
+		}
+	}
 
 	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa))
 		error_code |= PFERR_PRIVATE_ACCESS;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f1d616f928a1..9d5cd358ccc5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2790,6 +2790,16 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		vmx_cap->vpid = 0;
 	}
 
+	/*
+	 * Virtualizing MBEC requires advanced vmexit information in order to
+	 * distinguish supervisor and user accesses.  For simplicity and clarity
+	 * disable MBEC entirely if advanced vmexit information is not available,
+	 * this way mbec=1 in the kvm_intel module parameters implies availability
+	 * to nested guests as well.
+	 */
+	if (!(vmx_cap->ept & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT))
+		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
+
 	if (!cpu_has_sgx())
 		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_ENCLS_EXITING;
 
-- 
2.54.0

