Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396133EAEC
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654832; cv=none; b=gtau0PvFyPMAzXeoD/XousKPAJUKmaYQIpNfsSx238uqGkHbI+aKMp4HoZ/tRTsaye42xoy8LAgWDohlHmOh0PLAFODd/h+GurB6Hfp4kCZzMT0F4qMNkEaps0z/2MsAt5sMT7E98qrESl8S1ziBDR/V9UsZiPT2DnHE/OM7eJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654832; c=relaxed/simple;
	bh=NJXEJgy4bPsYXdgxGBE9MnVX3jvlhx2jJ8S0FqDBjHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YTXwJWoAwRBAd63CS7+Ux65AbnFGzi15F3n9ZVsAiwTnhjDfRNnhJ+yv+nadFnMtq1CnAsbqncn2uwpWuyIL8uCjHw82En6gdBVVi/T9eVMmbyaa14NDH2LQ8KnlhI/1M7e1ilRaO+9ezposw+dTXblgWMQ9eGEWYxLsZH6Qx7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBPX9jNc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBPX9jNc"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24308165dso3200635ad.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 16:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774654830; x=1775259630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZDHXOjvuNOIQxgTZwaBEqdL2bgAcnxDW6LrcDeA+rU=;
        b=EBPX9jNcbQQ2/z6H3hKfEK03n0pIBKicthb1MAf3U0tLYRRgHwNP3dQ9ucNbPyQDHI
         7Qb7VsKmSEq3Qiu8zTJL3kgIHobAIt70aKL7jzDFP9LJ6cCm3/yE5GP9NPf6D+KTvRwh
         8yZc+gLMdFpVPg0285HGkjSVbqYVhKYWEf+atzBzO6wb8gMlxAfCWgBUP0fU3HvBXdk6
         zO8RJOQrX8a0xIF20fUKArrBTwVYIQbGV9T24FX/fdGQfeOu9o1aFjVx+uhnB++3/pCm
         PFXDjrlzM5sy+x824gp6Tl1MitQZsGUTxBNXXzNMoti08GKBi0YwbwZ5ZZmLXMQ6GPoZ
         2/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654830; x=1775259630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZDHXOjvuNOIQxgTZwaBEqdL2bgAcnxDW6LrcDeA+rU=;
        b=HGwa76qSJl0lh1zp97q2jt2KYpRyRWMT6D3k4MHgf8JiVAsM+31UY3yYBXYp7NchMa
         BIpvD1q4xIlUB6bKwNUUng2PnSm6CDSVuiXxRLzP7tJrseE5dy6H+1LK14N+gffAw6D6
         zjS2KXPPJXZe3QnrVJXFfN+fP6Cg/Dk7y0XXCfyyQy36ExPUyH564+tkUy8APrytyrEp
         zXiwZFwvGXtWHIsm35uO3U8Tfpq5mqOIPodxu4UO0xCfUVNYMMThbL6RY4HKF3Jf++/c
         lzOxoAeDkW9y9jhtDdOT+rHpU3fPxueKEJ7n4tfmc3HGJuUmTimA8+idThey1IjB6esf
         KMUg==
X-Forwarded-Encrypted: i=1; AJvYcCXIBfnpmMUu/2GK3sfbqm9nU6OvJtEVvqZmZC6HlZ5dDJs219yV1rftFJaZ1ebGt4YqOpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDsw5PjOeqgOBhNNWfyyqYZajKCZL16JLxHqgYLCLwb4+X1vOj
	9jTVwN8K/102SYkofQiS4eaAALywrzwqtsbiAi+nLhLWaliK/ABp+qtb8ZtoWFL0dRhURcW/avF
	DilLCI9+uzl1Z0w==
X-Received: from plbw4.prod.google.com ([2002:a17:902:d3c4:b0:2b0:6147:a0ee])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4407:b0:2b0:5e10:9dbd with SMTP id d9443c01a7336-2b0cdbeb419mr45733875ad.3.1774654830227;
 Fri, 27 Mar 2026 16:40:30 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:40:08 -0700
In-Reply-To: <20260327234023.2659476-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327234023.2659476-2-jmattson@google.com>
Subject: [PATCH v7 1/9] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
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
 arch/x86/kvm/svm/svm.h          | 11 +++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

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
index d3bdc9828133..0b4ab141feae 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2511,7 +2511,8 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 	 KVM_X86_QUIRK_SLOT_ZAP_ALL |		\
 	 KVM_X86_QUIRK_STUFF_FEATURE_MSRS |	\
 	 KVM_X86_QUIRK_IGNORE_GUEST_PAT |	\
-	 KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM)
+	 KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM |	\
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
index ff1e4b4dc998..74014110b550 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -616,6 +616,17 @@ static inline bool nested_npt_enabled(struct vcpu_svm *svm)
 	return svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_NP;
 }
 
+static inline bool l2_has_separate_pat(struct vcpu_svm *svm)
+{
+	/*
+	 * If KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled while a vCPU
+	 * is running, the L2 IA32_PAT semantics for that vCPU are undefined.
+	 */
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

