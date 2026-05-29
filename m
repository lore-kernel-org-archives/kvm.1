Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50F47D947
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093407; cv=none; b=WECthPEfMQNCNtbGhk9k9ahHz40fL5V6RSs1eqvh2/EJk1fp4xH5VkFTI+Oz01Je/pXMdB8O3GZeimAMwmVSFSD1G/WLr/+qGKm8r4fWxRDET3GMt4gZrtQ9O/F578PQFxWpcom/acpikf0ExbKCHUcGGVIff6CfN1Z/HBiC+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093407; c=relaxed/simple;
	bh=+s6xBOQ8qu6SI6nRP+HhTyt6JUEzgxZY18AyIiC69OM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ij0M7MAV1Qcx9ABXLYBVky4PKK094bqLGNNTYPhy1tOwawxLUmSUWNao4NDDd3G4X3ox5TnQqAWOzvg5NMNbjFP3aCbhr1QSiDuquNv7BEgNJgXat4dg60WkjHEhQ4H5WNks6Ghd/SxtB3OVF4+gd1VDUNIrquoYg/ErvxsmWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1nnn3Yw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1nnn3Yw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc6899bfb1so155864475ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093405; x=1780698205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=B45QF1eRSPwRPsQdGnQfeoTY9Ry5cop0GiLPIJpG3/U=;
        b=Z1nnn3YwIxqdjHlSlrtrxVE0RUKvn9jiT2rrrXaNdGvCub/+GNPb9jAxnH4sumCO1W
         wwYD1xcMECImyoTLkCpJmLYAM8BqPiNHKewUH74OWJtF+NAB8sQsrAIya/Z2KLPBX698
         vsPVi14g3qVQMMVcgzOCsn1nkVnNO1zi7VtWwgAbxcLFs1p7ktorAkM+ZS2PacL1lJez
         r9ngpvhXfij7zAxvxvfiJUnCZcY1RSQeZWf7WsqIgEBurOdzltb+Dc2hjg7NbhbuT81P
         1CVqjMUq7PA/RdiLHdHGS80ZEAwdCmgAAX1Y+9ouS9uKASJXLnj2yzoojUq1sxcfJ5Po
         2NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093405; x=1780698205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B45QF1eRSPwRPsQdGnQfeoTY9Ry5cop0GiLPIJpG3/U=;
        b=LII6gc5qwgsa7cCQFJ09NJNAk+D5hzwZOAU4iAAafkYLa1+9Be5iRP04r6G6dCYfZ+
         KpaQ9gBbKms8475rHQn6rP4AY7CH96EytRHXcHs62Mn7vVWUrL4PCyr6SJKNrzKg8fcx
         AtLtm9o9jL24VhYjUocBRb1UOFvaU0cgenp0Vu+QFH9fDmUP4x2+pWByhVaalFFC4a0a
         lG7Zcpwt6Yb4TYvvxJmUqBT+dJkxzuk1Y8WKZPhIpYCkelkSV3U2XAjWfO7KRzKyGL+k
         1mgUlhmmfQcSKJluerlvDhbtpneWd/lsXj5VmtZDRLxQUiXOFY2QWVadegLQOU0z7EnG
         9Vmw==
X-Gm-Message-State: AOJu0YyNbdN3eYJb22S81rc1HbCL9KQh7HlEsH/JyXpMCu2L85NYg72K
	skmLbNyPTx2hZOy16QFkh4+78JEPm4/fVKulAwq90Brkyh5pO8Ku4a+RUtt8Se7wAGhNDwq9tB+
	53ozttQ==
X-Received: from plgv8.prod.google.com ([2002:a17:902:e8c8:b0:2bf:2f05:e721])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3884:b0:2bf:33a9:bf4a
 with SMTP id d9443c01a7336-2bf368a3d92mr19960435ad.38.1780093404494; Fri, 29
 May 2026 15:23:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:17 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-35-seanjc@google.com>
Subject: [PATCH v3 34/40] KVM: x86: Move misc "VALID MASK" defines from
 kvm_host.h => x86.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move a variety of "VALID MASK" defines, e.g. that capture which flags in
a given ioctl are supported by KVM, from kvm_host.h to x86.c.  The set of
valid flags/bits is very much a KVM-internal detail, as the hardcoded
defines are often massaged at runtime, i.e. *directly* using the macros
outside of KVM x86 would be actively dangerous.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 34 ---------------------------------
 arch/x86/kvm/x86.c              | 33 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 989294c7501b..53994b8292fc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -78,12 +78,6 @@
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 					KVM_DIRTY_LOG_INITIALLY_SET)
 
-#define KVM_BUS_LOCK_DETECTION_VALID_MODE	(KVM_BUS_LOCK_DETECTION_OFF | \
-						 KVM_BUS_LOCK_DETECTION_EXIT)
-
-#define KVM_X86_NOTIFY_VMEXIT_VALID_BITS	(KVM_X86_NOTIFY_VMEXIT_ENABLED | \
-						 KVM_X86_NOTIFY_VMEXIT_USER)
-
 /* x86-specific vcpu->requests bit members */
 #define KVM_REQ_MIGRATE_TIMER		KVM_ARCH_REQ(0)
 #define KVM_REQ_REPORT_TPR_ACCESS	KVM_ARCH_REQ(1)
@@ -2429,34 +2423,6 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 
-#define KVM_CLOCK_VALID_FLAGS						\
-	(KVM_CLOCK_TSC_STABLE | KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC)
-
-#define KVM_X86_VALID_QUIRKS			\
-	(KVM_X86_QUIRK_LINT0_REENABLED |	\
-	 KVM_X86_QUIRK_CD_NW_CLEARED |		\
-	 KVM_X86_QUIRK_LAPIC_MMIO_HOLE |	\
-	 KVM_X86_QUIRK_OUT_7E_INC_RIP |		\
-	 KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT |	\
-	 KVM_X86_QUIRK_FIX_HYPERCALL_INSN |	\
-	 KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS |	\
-	 KVM_X86_QUIRK_SLOT_ZAP_ALL |		\
-	 KVM_X86_QUIRK_STUFF_FEATURE_MSRS |	\
-	 KVM_X86_QUIRK_IGNORE_GUEST_PAT |	\
-	 KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM |	\
-	 KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT)
-
-#define KVM_X86_CONDITIONAL_QUIRKS		\
-	(KVM_X86_QUIRK_CD_NW_CLEARED |		\
-	 KVM_X86_QUIRK_IGNORE_GUEST_PAT)
-
-/*
- * KVM previously used a u32 field in kvm_run to indicate the hypercall was
- * initiated from long mode. KVM now sets bit 0 to indicate long mode, but the
- * remaining 31 lower bits must be 0 to preserve ABI.
- */
-#define KVM_EXIT_HYPERCALL_MBZ		GENMASK_ULL(31, 1)
-
 static inline bool kvm_arch_has_irq_bypass(void)
 {
 	return enable_device_posted_irqs;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 660ba27c76ec..a854b83e9881 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -105,6 +105,12 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host);
 #define emul_to_vcpu(ctxt) \
 	((struct kvm_vcpu *)(ctxt)->vcpu)
 
+/*
+ * KVM previously used a u32 field in kvm_run to indicate the hypercall was
+ * initiated from long mode. KVM now sets bit 0 to indicate long mode, but the
+ * remaining 31 lower bits must be 0 to preserve ABI.
+ */
+#define KVM_EXIT_HYPERCALL_MBZ		GENMASK_ULL(31, 1)
 #define KVM_EXIT_HYPERCALL_VALID_MASK (1 << KVM_HC_MAP_GPA_RANGE)
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
@@ -114,6 +120,33 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host);
 				    KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	| \
 				    KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
 
+#define KVM_CLOCK_VALID_FLAGS						\
+	(KVM_CLOCK_TSC_STABLE | KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC)
+
+#define KVM_X86_VALID_QUIRKS			\
+	(KVM_X86_QUIRK_LINT0_REENABLED |	\
+	 KVM_X86_QUIRK_CD_NW_CLEARED |		\
+	 KVM_X86_QUIRK_LAPIC_MMIO_HOLE |	\
+	 KVM_X86_QUIRK_OUT_7E_INC_RIP |		\
+	 KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT |	\
+	 KVM_X86_QUIRK_FIX_HYPERCALL_INSN |	\
+	 KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS |	\
+	 KVM_X86_QUIRK_SLOT_ZAP_ALL |		\
+	 KVM_X86_QUIRK_STUFF_FEATURE_MSRS |	\
+	 KVM_X86_QUIRK_IGNORE_GUEST_PAT |	\
+	 KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM |	\
+	 KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT)
+
+#define KVM_X86_CONDITIONAL_QUIRKS		\
+	(KVM_X86_QUIRK_CD_NW_CLEARED |		\
+	 KVM_X86_QUIRK_IGNORE_GUEST_PAT)
+
+#define KVM_BUS_LOCK_DETECTION_VALID_MODE	(KVM_BUS_LOCK_DETECTION_OFF | \
+						 KVM_BUS_LOCK_DETECTION_EXIT)
+
+#define KVM_X86_NOTIFY_VMEXIT_VALID_BITS	(KVM_X86_NOTIFY_VMEXIT_ENABLED | \
+						 KVM_X86_NOTIFY_VMEXIT_USER)
+
 static void process_nmi(struct kvm_vcpu *vcpu);
 static void store_regs(struct kvm_vcpu *vcpu);
 static int sync_regs(struct kvm_vcpu *vcpu);
-- 
2.54.0.823.g6e5bcc1fc9-goog

