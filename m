Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580C2DB79C
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309046; cv=none; b=qEt3l51gElNHseGTHaIamvjAw2DxGIMeRbB6A6uzK+svs2GR7gzMGQcNhb0CIcu6xQgvMoFrO/utA1NIRI55uTuqDFko9+6G44Yw0eGPqgKCWh2M3Ckc8cx3C+88cHm3LNLearmcfMU6y9noPVMlRyWAQtN+VuhAjUws6bnEpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309046; c=relaxed/simple;
	bh=/T2vmxazMAL/rSiQr7PnEIv3/EzgaILwVX7LUgI92TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fYeB9tvJrqKqbRgWy8wUtEAWFGhqYkp/vi2XLpAUuWBnZqmRiLwHG2h+2nqjCHJQoirz4uF3kD3FrxV8TN6ERwn/sTwUw/FA9GVZoDJTU4ekJE2Oer7cbQuci4YIu6BXIV7uJ6c+48PZlnSYF4KPTCny/QzTOpZ/IEQa9dh5hIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMf2fgds; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMf2fgds"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2befec3fd8fso10299125ad.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309044; x=1781913844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpFYASI5LxKKFgoIw0vbf1xsOHbUnNmML7lXcwkzgaE=;
        b=XMf2fgdsF7iAFgIUiohc2jWdZ/Sld9KIETHx4lzHzs2FRsW31PMgNMT03j5suhIsXP
         KoKPRlG3/GGue0ure6aRzXbgs4bZHbdoye3K1MJunP5fgdAT6s77QSlCKYXOzFqD85Ks
         DUVKeI3MBcF9VcGk9yLV8Lk/ky/nouo6DhkSfBksYMsYg0CB6DIoIpuLiCaze57pHkmI
         VtKWN2JJBDiIqWtafYrKe37XdVBic8WjxYUTE4gmFdZgcarcOhPUY3dA37bcg47hNI7U
         jCiItlZ1WtvSJ0jMqNUp7fztivipKWmSNCXXllBigkucgu9uJQpZZji/30K3TRudBMXT
         OXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309044; x=1781913844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpFYASI5LxKKFgoIw0vbf1xsOHbUnNmML7lXcwkzgaE=;
        b=FRE4PebHAjy5Y6tZ39sTiUio1ix68T/6hNXgc/Fdwz7iiJ+wryb5OaicUWDeVdPQEu
         ahek2A8rTNw485TDtaQtZSK4CHxA9TeGs/CBh5akd6Z4bPU2vBBp3u16cPBNQWZB7TnP
         vfb9BBK9MKk+8YFKQ1JhFpkC/W82si5sJnlpZW4UAUeDxBb8ERiTQwmtC8D3kq1Vjh2x
         4lpnsM3fB2l8miiKJGFMcnNVay4yIqC7l2uVm0O3sWS/Ib1kbwH1HqZLaliGGcOa0AXk
         1DZ+MebKdFZuft5Ehsa1EDy1EiiSMaSTwP8tcjUpMQii5ORfOL6ldWPtl9MMOfufcgjO
         YnHw==
X-Gm-Message-State: AOJu0YzicSeSN8N/LarDkQFiKTJ22vyZAaGe97EVYvwd7naNxMc/M1wC
	XKu0vWzEb6rUTQiUL6ZbbnUxF2h33wCYRzdybewjj1YkA84GLEWGlIo1ciCcI0+cNJybN3GG4co
	eYtBQ2A==
X-Received: from plzv4.prod.google.com ([2002:a17:902:b7c4:b0:2bd:40d4:e407])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da84:b0:2c0:d9b7:b7b0
 with SMTP id d9443c01a7336-2c41216fae7mr62403755ad.31.1781309044262; Fri, 12
 Jun 2026 17:04:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:21 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-23-seanjc@google.com>
Subject: [PATCH v4 22/30] KVM: x86: Move misc "VALID MASK" defines from
 kvm_host.h => x86.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move a variety of "VALID MASK" defines, e.g. that capture which flags in
a given ioctl are supported by KVM, from kvm_host.h to x86.c.  The set of
valid flags/bits is very much a KVM-internal detail, as the values from the
hardcoded #defines are often captured and massaged by KVM's setup code, i.e.
*directly* using the macros outside of KVM x86 would be actively dangerous.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 34 ---------------------------------
 arch/x86/kvm/x86.c              | 33 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d1fdb2c3fdfa..72f8f8933ab7 100644
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
@@ -2417,34 +2411,6 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
 
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
index c6cc0961a4e7..e0456133133b 100644
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
2.54.0.1136.gdb2ca164c4-goog

