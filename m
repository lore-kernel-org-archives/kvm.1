Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C9939D6E6
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547403; cv=none; b=AUNikc35Z8mkvrioIkcM4bUNEGDMhzXZi2ZcfQFN7L89PfOw4+a+wQ28RR/8PWRj35Cdf9Y6nlb4Me1zc3nLZlYN2SZEEuO8edDMkpRNr1QFQrE2OCGzCrIhVqINEfTThO0paoGPlf6gUcdKCFGOYg0N/k6tDfCQsEIFrb8EekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547403; c=relaxed/simple;
	bh=4vsIq1VfSzTSyTEBFa61is6eowpApyT+KkPsKzqgDyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PuuHyJZqD+yf++gW5XFis9CGkFFBwhg/wPJ2O7SWTHV6v4zX1spBG1im2rqy4Bbh7cQ4rR66MquJPXoHKhw4yoNqVvntw2Mzc7TC9+Lqg7UoY83WyDLLI77He0GIRDPbTQLij5s8Ajm727w7MJ4ULyfXLTAXcifGPi+4C86q8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlhT16vQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlhT16vQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b0be75dfd4so17068645ad.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774547401; x=1775152201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fxWdpT8ek9U1KpozmfT6zoWQuFICVRwtG9anfQiaBI=;
        b=wlhT16vQgD0/vOyxsqQrq2oZxLcsnfv2TfuvSnBCMk3LPfsBD+s+NCG44F0BAxvbNW
         R4r9GVHCwz/u4u8PY3hT8Am+I7RLaED9c5aRCUnKVuPNpvpGnLDZ+q1BePR2NyN+PuCJ
         LxHXrkypm4IV0B1n/NtZjGTmukUlLE0B+aN9/+LLdYcsezIWbxeTyFisrU+Hr3gQ+jQr
         eX/c/yypz2mETFfmwYYvq1Gz9I3j9cASxrts/7IJzx8y51XxKJ1eidQZzULZl9tFBbZD
         ftWqIWEoq41mmZ4fQVzw7Qaimmwp9F06mPZu5L0ktm/6FvLsh+stEIuYIJAGvcxHGXaC
         CeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547401; x=1775152201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fxWdpT8ek9U1KpozmfT6zoWQuFICVRwtG9anfQiaBI=;
        b=akad8pSx50LzNPWZSVvQRveXR4Kv8V16sKB20/MxeYF3hL7cKbn8Wvrg21bVxqQ1VW
         rqHw/IfQKxM+Y6DwepRsuF2AsKO5AMfMneCIo2N8OO8LceMqkMmJNopK1eBKrIX1qJHz
         BcBlTBli3iJcSMQohADs76f0nxFLl92b++T9Jcc0xYnXFkbHkLgSGVfl5EmJOhozISu+
         lOkmlmZjvG/LHeEAFGg9BAw2WyNeECJZOBz6B5qo8jklkQM7YgxhS1G2ew1CTQk6C47Z
         AMdepEXqlrxujFjg0hw52eelJU47ZEKfN4MNdM9ZaacGBxwCc9bFzBibBO48xFGIjV6O
         U+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv+Ge7MOiyxrZhC4I9pngC9qGnZz/5t8mboTpyvqXBSb4O4CcWBXsVq0eke545LHvbsmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjD6qTKelFTLMuRViR5eiyzsTN9BxwI79OOblEwZRZl1nwpphM
	yAjPKYh/pk+HemDaCwhZ8HnCap9BEFd740tnI6uTTeVhPyxdzI/mpubFSeziMWHKNn+mNeQa4wT
	moeWgERV2XJypFg==
X-Received: from plll4.prod.google.com ([2002:a17:902:d044:b0:2ae:5344:9e72])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc2:b0:2aa:d5e5:b136 with SMTP id d9443c01a7336-2b0b0af3befmr101915535ad.38.1774547401035;
 Thu, 26 Mar 2026 10:50:01 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:49:19 -0700
In-Reply-To: <20260326174944.3820245-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326174944.3820245-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326174944.3820245-2-jmattson@google.com>
Subject: [PATCH v6 01/10] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Define a quirk to control whether nested SVM shares L1's PAT with L2
(legacy behavior) or gives L2 its own independent gPAT (correct behavior
per the APM).

When the quirk is enabled (default), L2 shares L1's PAT, preserving the
legacy KVM behavior. When userspace disables the quirk, KVM correctly
virtualizes the PAT for nested SVM guests, giving L2 a separate gPAT as
specified in the AMD architecture.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 Documentation/virt/kvm/api.rst  | 14 ++++++++++++++
 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/include/uapi/asm/kvm.h |  1 +
 arch/x86/kvm/svm/svm.h          |  7 +++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 032516783e96..2d56f17e3760 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8551,6 +8551,20 @@ KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM   By default, KVM relaxes the consisten
                                            bit to be cleared.  Note that the vmcs02
                                            bit is still completely controlled by the
                                            host, regardless of the quirk setting.
+
+KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT        By default, KVM for nested SVM guests
+                                           shares the IA32_PAT MSR between L1 and
+                                           L2. This is legacy behavior and does
+                                           not match the AMD architecture
+                                           specification. When this quirk is
+                                           disabled and nested paging (NPT) is
+                                           enabled for L2, KVM correctly
+                                           virtualizes a separate guest PAT
+                                           register for L2, using the g_pat
+                                           field in the VMCB. When NPT is
+                                           disabled for L2, L1 and L2 continue
+                                           to share the IA32_PAT MSR regardless
+                                           of the quirk setting.
 ========================================   ================================================
 
 7.32 KVM_CAP_MAX_VCPU_ID
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d3bdc9828133..0809d8f28208 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2511,7 +2511,8 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 	 KVM_X86_QUIRK_SLOT_ZAP_ALL |		\
 	 KVM_X86_QUIRK_STUFF_FEATURE_MSRS |	\
 	 KVM_X86_QUIRK_IGNORE_GUEST_PAT |	\
-	 KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM)
+	 KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM	\
+	 KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT)
 
 #define KVM_X86_CONDITIONAL_QUIRKS		\
 	(KVM_X86_QUIRK_CD_NW_CLEARED |		\
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 5f2b30d0405c..3ada2fa9ca86 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -477,6 +477,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
 #define KVM_X86_QUIRK_IGNORE_GUEST_PAT		(1 << 9)
 #define KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM (1 << 10)
+#define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT	(1 << 11)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ff1e4b4dc998..67aa5d34332e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -616,6 +616,13 @@ static inline bool nested_npt_enabled(struct vcpu_svm *svm)
 	return svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_NP;
 }
 
+static inline bool l2_has_separate_pat(struct vcpu_svm *svm)
+{
+	return nested_npt_enabled(svm) &&
+		!kvm_check_has_quirk(svm->vcpu.kvm,
+				     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
+}
+
 static inline bool nested_vnmi_enabled(struct vcpu_svm *svm)
 {
 	return guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_VNMI) &&
-- 
2.53.0.1018.g2bb0e51243-goog

