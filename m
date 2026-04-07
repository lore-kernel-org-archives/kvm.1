Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0073344020
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588631; cv=none; b=XZWaYJBu9sJjYRBPCE4Ve7Kx25LH0y9n6UsJ6z0MYy1CWLknJ6grDy/xzwnO/b+iGyTPmGJzM4RnTXkFI2P0J7zIT0Bxh1bC3an4p2Vrm8SamMNFWmBLx+OjApQT5IaWzAjKU93SU6hIe+LdOIGIIMo1kOD+jrLbw7PcqOowQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588631; c=relaxed/simple;
	bh=6juHQCWztUFaxx9hoqRXPoiD6MVwVYPsJH7r51TIDRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MmJQPDfsov7WjjfDrnHSbEXYKTfOQ6rnhNbrJF8bvwZ+wZkpyugswO/7bO7p0X/CY5oIDmRI+jyAPVUCEU5O3vfXozIefZn65fNzlLUI7Ov4Syea6J7l6948rTWYWp+fCX1mjZ2qCj0n63zFszXDC95t4QAREmRWSYVAk/eyHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+cELYEw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+cELYEw"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76b6d4337bso2845645a12.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775588629; x=1776193429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwEAX7pAAMU5RaDm3NczH4P1rFTtDKFQk6fUYVkSa/U=;
        b=k+cELYEwnemsXyILLMj712iwenzq4hkYy85bwZ/p8aREhw8/tukSVw2+KbH723pG40
         g7vZLuEYwxqTuS5933tYY3UHuMXvDGMkjaCn6HtM7ulT9toJ8sdtDNIWgZTAbaLvLx9n
         RikngEUPHUq8xTmqzm6IYTBR+pS6xv94gBgYCCZoQP64regXiAetCXHCho+HTo8x75Xf
         sNsCu6JE2Q4m24TPFSJygGf9hgfO61oYYJKKxpTtNd4qHoVTfXVCbbQQTltIhgo+T1lR
         UkfBcOb3F0b3Vo+D9QkLn2OTC+lUedJS3vgFTJwI1HcCcBqf6Aotwkaun/Kp7Wmk7FHz
         JQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588629; x=1776193429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwEAX7pAAMU5RaDm3NczH4P1rFTtDKFQk6fUYVkSa/U=;
        b=IqpLY1yJW483ZE7OmS1GKQFX3zq9Z7/X0r/6yjPf1uGRT+s8InVuVnVLiqbcWsuJjB
         fX7rGbRmkG4RRvRnbBJm1nzUPMm16HWP8unR4SeQzc+oJXCtC/c6b+qjVB8GB+WDFTGF
         v+HndoQGUYEU9cGyT6kcnfoPeFrkgcOvcqIZzMmNwdXCoDiV8q7FAzWi0AoCK6aaEaIG
         OxgnsQa1KHPyEGlfSMlCga0b+8be4gUZbZxnPXeRKrnd7GfSfj48UDnlNfCOiSsyQJ9R
         qRnEZfugQoGctmcy2AjG/gVV9n7D2JDzeG7C6fvkDe3+xyd6tRdB0J6Se93Cum+re2Zh
         BLjA==
X-Forwarded-Encrypted: i=1; AJvYcCV4fwyK2/6tE1LvP/291dyy2WWXveULoLS57Q27ImliTAMpyJlk+DU66RfVPkj4Qudbtgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WDEwxsfcK+3YJzmv5+EuIyP3PLCkf+xqxntysxE6+tBYWCTY
	eFhSN4ykldoG58LWef4SEMpNo+CrgPjAjJU6Ws6uaqtqZaiN6Ry0gvAcuqQAhVT1lG/9wueVo/z
	dRbYN9w+QZG+oEA==
X-Received: from pfo19.prod.google.com ([2002:a05:6a00:2f3:b0:824:5a56:ebe3])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2da8:b0:82c:eafa:8875 with SMTP id d2e1a72fcca58-82d0da3ddb2mr17052344b3a.2.1775588628916;
 Tue, 07 Apr 2026 12:03:48 -0700 (PDT)
Date: Tue,  7 Apr 2026 12:03:24 -0700
In-Reply-To: <20260407190343.325299-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407190343.325299-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407190343.325299-2-jmattson@google.com>
Subject: [PATCH v8 1/8] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
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
 arch/x86/kvm/svm/svm.h          | 10 ++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

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
index c470e40a00aa..f77d64bbd409 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2526,7 +2526,8 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
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
index fd0652b32c81..a91942269f6a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -630,6 +630,16 @@ static inline bool nested_npt_enabled(struct vcpu_svm *svm)
 	return svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_NP;
 }
 
+static inline bool l2_has_separate_pat(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * If KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled while a vCPU
+	 * is running, the L2 IA32_PAT semantics for that vCPU are undefined.
+	 */
+	return nested_npt_enabled(to_svm(vcpu)) &&
+	       !kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
+}
+
 static inline bool nested_vnmi_enabled(struct vcpu_svm *svm)
 {
 	return guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_VNMI) &&
-- 
2.53.0.1213.gd9a14994de-goog

