Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C337BE9E
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425103; cv=none; b=GZPJofi4z4UziFnm6/vejAf6Iw/SdK69OxJA7O7a9+CbZdBH+XbjEXHk+3RlzAfsVxU4u+IYlH/mzf7EIFTH2b6isj/t4DgCCDEvnTFQTh2MG2nhShGvdqUo75hY4eqkld5XzOV3iCXJyYRLDT6NF9Rfo36jyyH3vXUixwNFpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425103; c=relaxed/simple;
	bh=wwRVvLigS2c3TJEKbcWn2sis93Rk0Xrw22gvEH7jI68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TFoYEO6OMQzBqgoL/OaQy9zxftbRmNrPRQYyGGfCldyDNwCVjr1QtVqKURoeS9/WPTjKxwbH+CWehcOzu5qzFVdtwAHA5T8O2rVnixitdcEhqoh5p8+dlIbN4mBERrjOkos/EhxXIh8iJOyk2tc0pDnFb4xzDG18d2xQwPMKEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ddvFNFuj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddvFNFuj"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c890bac374eso301074a12.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425098; x=1783029898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qnZ/W5OSl3z6eiq78FNIpFTFjeh/s8n67648uxr0CUY=;
        b=ddvFNFujkMYmU9e0loru7ueyTOauFTQw89PppJXlS2dPJ0o7akjtNJ5ofbgSVnfjQ2
         mKL56/avvS8wXG2QR8kpQzG1eWlUwf9YSi8uunAQjmLhPnjXZZ/F67kxcIjiQVYfodvQ
         ZpPqdzBNl2YK0JUvM7zNJ0zNaNGhe0a7iInwuj39G+9NN6DEoCbnVJ+uyNJWy7TzKMXF
         /RTWTuWrmuusSXQLSYv0DKzEo4TDVWlPlLiNX8Lc586uL7PuJ8YWDZUqSe0laiDN+PRT
         dyZfwQHaLL4iuUsua1Ie+lWQ44mZ6F7CgL5o72UOc0F6j1kuRFnN7L3y3A9iI4I0haup
         rz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425098; x=1783029898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnZ/W5OSl3z6eiq78FNIpFTFjeh/s8n67648uxr0CUY=;
        b=NNTVF5kNE7+0UaaiEdo0UIepxgzffjrW72zzzbgUGLJz1YTM5YZDxIboxOKjZ+j6bM
         SP0vMjr0zgxmguide92sOP7q/fg+MH/yUGhbv59h9mA9LhBAtmht2aAyHIhc4YjKJKNU
         3M2KIsD2YuortglZcpuBZrpLkn4YFWHM75Gy+1w12EuGb7z6c7o9ld/XkrWgnZHalYAZ
         DMmGHo8X1OhdazJYl/MOrCyXpwQCZzpjEy4h4J1oC/OxEYuRlzWmLVfiVlaMmUgUhp14
         oHZKFrXf3adcRPtjVfzY/AVlg+uKkV7TSRwv0YL3HPDVQ91VVeFQpOZ1ISxyLTHKj5GY
         CLtw==
X-Gm-Message-State: AOJu0YwSHP0wTzle/hf8RN1Sy5Lb3pZW7S6osT6u3sEHRvaHJeuSTOLo
	qFX2c6WhwInb7AIMUdmP8HTM4znypI0k/Qy10aXRU1EKexjPXFFpkXCCPrb77RotCbF6B+EJxuJ
	AeFHUcA==
X-Received: from pjbbf22.prod.google.com ([2002:a17:90b:b16:b0:37d:7bb8:2561])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e18d:b0:37d:ab59:e48c
 with SMTP id 98e67ed59e1d1-37dfa173810mr3771425a91.5.1782425097707; Thu, 25
 Jun 2026 15:04:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:04:45 -0700
In-Reply-To: <20260625220450.3354415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220450.3354415-5-seanjc@google.com>
Subject: [PATCH 4/9] KVM: x86: Move CR and DR macro definitions from
 kvm_host.h => regs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Relocate a variety of Control/Debug Register macros that unintentionally
got left behind when the related helper function prototypes were moved to
regs.h.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 40 ---------------------------------
 arch/x86/kvm/regs.h             | 38 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9ba8aa739f93..fd712f604636 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -125,24 +125,6 @@
 #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE \
 	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT)
 
-#define CR0_RESERVED_BITS                                               \
-	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
-			  | X86_CR0_ET | X86_CR0_NE | X86_CR0_WP | X86_CR0_AM \
-			  | X86_CR0_NW | X86_CR0_CD | X86_CR0_PG))
-
-#define CR4_RESERVED_BITS                                               \
-	(~(unsigned long)(X86_CR4_VME | X86_CR4_PVI | X86_CR4_TSD | X86_CR4_DE\
-			  | X86_CR4_PSE | X86_CR4_PAE | X86_CR4_MCE     \
-			  | X86_CR4_PGE | X86_CR4_PCE | X86_CR4_OSFXSR | X86_CR4_PCIDE \
-			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
-			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
-			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
-			  | X86_CR4_LAM_SUP | X86_CR4_CET))
-
-#define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
-
-
-
 #define INVALID_PAGE (~(hpa_t)0)
 #define VALID_PAGE(x) ((x) != INVALID_PAGE)
 
@@ -230,28 +212,6 @@ enum x86_intercept_stage;
 
 #define KVM_NR_DB_REGS	4
 
-#define DR6_BUS_LOCK   (1 << 11)
-#define DR6_BD		(1 << 13)
-#define DR6_BS		(1 << 14)
-#define DR6_BT		(1 << 15)
-#define DR6_RTM		(1 << 16)
-/*
- * DR6_ACTIVE_LOW combines fixed-1 and active-low bits.
- * We can regard all the bits in DR6_FIXED_1 as active_low bits;
- * they will never be 0 for now, but when they are defined
- * in the future it will require no code change.
- *
- * DR6_ACTIVE_LOW is also used as the init/reset value for DR6.
- */
-#define DR6_ACTIVE_LOW	0xffff0ff0
-#define DR6_VOLATILE	0x0001e80f
-#define DR6_FIXED_1	(DR6_ACTIVE_LOW & ~DR6_VOLATILE)
-
-#define DR7_BP_EN_MASK	0x000000ff
-#define DR7_GE		(1 << 9)
-#define DR7_GD		(1 << 13)
-#define DR7_VOLATILE	0xffff2bff
-
 #define KVM_GUESTDBG_VALID_MASK \
 	(KVM_GUESTDBG_ENABLE | \
 	KVM_GUESTDBG_SINGLESTEP | \
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 94fd86728fed..447f0ec3e63e 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -16,6 +16,44 @@
 
 static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
 
+#define CR0_RESERVED_BITS                                               \
+	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
+			  | X86_CR0_ET | X86_CR0_NE | X86_CR0_WP | X86_CR0_AM \
+			  | X86_CR0_NW | X86_CR0_CD | X86_CR0_PG))
+
+#define CR4_RESERVED_BITS                                               \
+	(~(unsigned long)(X86_CR4_VME | X86_CR4_PVI | X86_CR4_TSD | X86_CR4_DE\
+			  | X86_CR4_PSE | X86_CR4_PAE | X86_CR4_MCE     \
+			  | X86_CR4_PGE | X86_CR4_PCE | X86_CR4_OSFXSR | X86_CR4_PCIDE \
+			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
+			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
+			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
+			  | X86_CR4_LAM_SUP | X86_CR4_CET))
+
+#define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
+
+#define DR6_BUS_LOCK   (1 << 11)
+#define DR6_BD		(1 << 13)
+#define DR6_BS		(1 << 14)
+#define DR6_BT		(1 << 15)
+#define DR6_RTM		(1 << 16)
+/*
+ * DR6_ACTIVE_LOW combines fixed-1 and active-low bits.
+ * We can regard all the bits in DR6_FIXED_1 as active_low bits;
+ * they will never be 0 for now, but when they are defined
+ * in the future it will require no code change.
+ *
+ * DR6_ACTIVE_LOW is also used as the init/reset value for DR6.
+ */
+#define DR6_ACTIVE_LOW	0xffff0ff0
+#define DR6_VOLATILE	0x0001e80f
+#define DR6_FIXED_1	(DR6_ACTIVE_LOW & ~DR6_VOLATILE)
+
+#define DR7_BP_EN_MASK	0x000000ff
+#define DR7_GE		(1 << 9)
+#define DR7_GD		(1 << 13)
+#define DR7_VOLATILE	0xffff2bff
+
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0);
 void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4);
 int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

