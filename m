Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053F379C32
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652481; cv=none; b=FnLAjCeQq+tEi49XbWMLXgmAbzw+oppRk5xep8XD7F2tQZMpoShXh+Mbdbb6aDoS6gXr8M5uFp1iCp0PuJ8zdN5tEhqgDlfePEZSaIbWbVgNt3zRHMiRY91Nven4LQVPzo/kk0++lFeZ0Ev+VFCKLOiw//LM402xO4Wc0Fb49yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652481; c=relaxed/simple;
	bh=6RwquLywhi0GBUCnzatAMSofcxVHNo0nZEB3gMhfyWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uiu1G09pRmL+GmECw5b8bUiiYWP3vvIUD7qJNDlWHLc2pMlyLS9qA/+Ky8onUGMUmWiWeFpHP+F6fKwfE2TiGL87XSygNqTkANcbMkdvC7+yEj1mnifCLxz+0MVo5yhyypacZi9vacxJs2HxSkVq0KQ25QRkz3krqGwT4m3wOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SE0hcyIq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmsO8l5P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SE0hcyIq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmsO8l5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784652476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=be3+Li/Szx6t4rZokyI99j2GfhjzMsbkOxQWganE5Mw=;
	b=SE0hcyIqWMCgka1EDYz9pH1WFgWoT8O1pRhFMq8BnvoZnU+qYJMMeXmH+cLCJ9TRdb4Qdh
	FUPqzdUXbhFPTixWqpZLM/s3zLLfxbPsRi3tfa3eoBb8FjwIMvDi+yR3rwYSbVnYyVeVCk
	W7emKxPniOt3LlDj3CajVJOgNlBorbY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-v8rj7O6XPG64I44Vsrd6dg-1; Tue, 21 Jul 2026 12:47:49 -0400
X-MC-Unique: v8rj7O6XPG64I44Vsrd6dg-1
X-Mimecast-MFC-AGG-ID: v8rj7O6XPG64I44Vsrd6dg_1784652468
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-473e18559b2so5476409f8f.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784652468; x=1785257268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=be3+Li/Szx6t4rZokyI99j2GfhjzMsbkOxQWganE5Mw=;
        b=ZmsO8l5PYnOuju9ndnj3ze3phK9B3AVkmjMwjgKTDrJi5nmBEyn/NaZv+vklTdaqy1
         tVeJerjZV8/MNZOBMHqZmwJC2NPtf5u5P9oiJss9Tphm8SIbrB0adUeFMyDoN1+3lD47
         N7lmDsirLxlK9skPt7rwz1cBt5T0imcjIvLflgQ49MHDsta26kVpz9Mby8aqmlwPYaGz
         dY8nHnBzcfWERETKUIiN2ASsTw6GL08YnPtEkmnee6lfioy77tm8BV/ppThcHjxxG+zT
         vRZ7+7koXSO2+/4bMJ5YAkZK6t6sUBVlSRck8DUiDzlJRFqRW656RKG4bqzXLCfq8dfJ
         //Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784652468; x=1785257268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=be3+Li/Szx6t4rZokyI99j2GfhjzMsbkOxQWganE5Mw=;
        b=pqvrn2qf3VFQrwSFGMCKtY1OaAxMyvVy8gkhkjPTb/o/NdRfMAWFT5uwNc8O9hIwHp
         xWmePbPFZHwbzShwD3sdn9VqE3Xigltrqrk3Glsi6dAwT3Tnd28fga6W9id/L2Di+Cpj
         Yjur3eunHkGLEIf7BE+lRIqLkDo9AKwT0gHLtC00WJZENPe2oWpGyzCGzt0Ko9gkN8RS
         NweIgQcAQvlEhSSeOYG1OntOXsFOUHGLS4e9YUhxYvQFlIBmPvpGxZp+N6qZXECfpq/+
         L1rLm+UW8P5zHy66mI+YvMCL6seWJwIWjdaIue77GZFMdDI6oXy1nppCtfALceNhI1wa
         oGdw==
X-Forwarded-Encrypted: i=1; AHgh+RrOk3tpL4AsylM26FrP+XVuGJ2qmb76PfpO1QnvqjsuXjyRPMafMSad0f41MXZbFHNkyDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwESneIE+GZLsNre9zTbrPNcPM66ZPZv0O8YPqpVgQgBA09H4/z
	m5mZovrTvThz8tK8skre2ALqbl7ZGaI66E3LhglBFk6pJb8DznD90jeSuCPIAFBTESLiKqPZ0V0
	TVnCtt5C20/2uiZ5Y3Q9KCuVJB7FWxHoKDPzl7L61ppjHdf77/VKLSiYCelOsUA==
X-Gm-Gg: AR+sD12mPnCkArpeW1IYwYpmjTJdVwB3hXQk88ijGscOoum72y+koDhOj+cyV13q1G5
	elVuZjMRGzLUYx84xBLRqoDocO2SK4Gz5OEGWgq0/7SW4u91WU2tzyzwNswg/XXKtxluEbF598z
	ZI+FJg9aOCHrktVB3KsZfT7u4iZazwW8qhhPCx/P+4UdOhXeSYZuMwfo5Gai3iUS5WUmtlSgir8
	j8GHNoxe/CPosl8CvAVLeftxpQ+CMUCnZfZ1p8SfjnOf0Qhl0gdDe13IYpvOuK8JVD6K0BsxfxU
	wzEoXNjG2Qu1HKyabXvFQdZhgUBM9eEB4MaymvSc0aBlb3NWivHcqEXxtsY2XYmaAZJHW6cdVmD
	ucn2eASQCtr2T9DeQpgjEAJDNi/KtwDPThMTOj19IaUfY8zZzT2ZDPz0OAnAH+mdwiP59ujbb47
	apOw==
X-Received: by 2002:a05:6000:400f:b0:47f:8152:e568 with SMTP id ffacd0b85a97d-47f8152e595mr4213983f8f.60.1784652468383;
        Tue, 21 Jul 2026 09:47:48 -0700 (PDT)
X-Received: by 2002:a05:6000:400f:b0:47f:8152:e568 with SMTP id ffacd0b85a97d-47f8152e595mr4213959f8f.60.1784652467986;
        Tue, 21 Jul 2026 09:47:47 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec7c69sm43124153f8f.17.2026.07.21.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:47:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: VMX: add memory clobber to asm for VMX instructions
Date: Tue, 21 Jul 2026 18:47:46 +0200
Message-ID: <20260721164746.376551-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMCLEAR/VMREAD/VMWRITE/VMPTRLD access the internal VMCS cache, which
is not visible to the compiler; without a memory clobber, the compiler
can reorder them in troublesome ways because "asm volatile" and "asm goto"
only protect against removal of the asm.  For example, placing a VMWRITE
before the corresponding VMCS pointer is loaded can lead to corruption.
While none of this has been observed, it is better to prevent than cure.

Likewise, INVEPT and INVVPID access the TLB and, even though in their
case the effect is only visible to the next VMLAUNCH/VMRESUME, it is
technically correct to add the clobber there too.  So avoid any urge to
special case them, and simply hardcode "memory" into the clobber list
of vmx_asm1() and vmx_asm2().  __vmcs_readl() open-codes its own asm,
so add the clobber there as well.

Link: https://lore.kernel.org/kvm/CABgObfbL3t21yVeSwiLSjjOUER+rTYDPHYAH9YU4TWGRjx6XHg@mail.gmail.com/
Cc: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx_ops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 81784befaaf4..9ffe03a0c223 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -101,7 +101,7 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 
 			  : [output] "=r" (value)
 			  : [field] "r" (field)
-			  : "cc"
+			  : "cc", "memory"
 			  : do_fail, do_exception);
 
 	return value;
@@ -145,7 +145,7 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 
 		     : ASM_CALL_CONSTRAINT, [output] "=&r" (value)
 		     : [field] "r" (field)
-		     : "cc");
+		     : "cc", "memory");
 	return value;
 
 #endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
@@ -192,7 +192,7 @@ do {									\
 	asm goto("1: " __stringify(insn) " %0\n\t"			\
 			  "jna %l[error]\n\t"				\
 			  _ASM_EXTABLE(1b, %l[fault])			\
-			  : : op1 : "cc" : error, fault);		\
+			  : : op1 : "cc", "memory" : error, fault);	\
 	return;								\
 error:									\
 	instrumentation_begin();					\
@@ -208,7 +208,7 @@ do {									\
 	asm goto("1: "  __stringify(insn) " %1, %0\n\t"			\
 			  "jna %l[error]\n\t"				\
 			  _ASM_EXTABLE(1b, %l[fault])			\
-			  : : op1, op2 : "cc" : error, fault);		\
+			  : : op1, op2 : "cc", "memory" : error, fault);\
 	return;								\
 error:									\
 	instrumentation_begin();					\
-- 
2.55.0

