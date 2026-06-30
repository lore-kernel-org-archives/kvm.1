Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82133D6C1;
	Tue, 30 Jun 2026 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863244; cv=none; b=bz9jhUnlD/SH7+y/6R7sSd3NzGjBSvk3NlTL2fkp+iI3ETVYd4N73ajDCZk7BU8ER1HkNeCpQoZU+RtEefDoFyeE/G2Lc4VAWRU0BfEp5d/sx5bGB8wkJAyVXS08zXxBsO4yh/u4eN15SlDHCtw0X0nNW8XZmx673XQrLQ/3+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863244; c=relaxed/simple;
	bh=U1YyO2OuRP6Ql8BFn/QAVpSKHYRDlP2c0ZOYnMUwmBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDCbBjzUHfFm1tx1q+66KgNmJhqZQnmvba1p85BMd6cm5lmCT9Y0UYuOs4OJWQHmr4+AuTeRTneQW3FW2m4GM7c8HFh2b9JH2xCZLuu3dX5m/pTUC2wROSqNdbkS+wt+5/07cCBcrvU4LxomrSTQmlTWJX1CBLh7GYbUhC0nqZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSWw17Ry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSWw17Ry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2664B1F00A3A;
	Tue, 30 Jun 2026 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863243;
	bh=xJZTX5P5jjgiFltGON0BaSZxmccm2siBQMffV/0qFRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cSWw17RynOl6zB5SOwPgNE9gI4KY1r5pY4QfKu/eMim8QhwOycCHtf1ortHKB08xP
	 kmhhBUjRMBIIJWDAvvUc0ijKd3doS9PdKNL0as6rZXPUh3iXHVbkvuL9jBiztfiVHc
	 yeOZ/SkLPlt+a6nicDcXuYA4lXKUsjL/SG75LJZb/yOL5SntOqB/LiNyY7dF4iZYZO
	 zKgEHd6ai4Y+QgCv04mqq8Y7IhPp/l519jVKtdfZ+R6KwyqI+P4S2iWKM7LtUeIY5Z
	 kdXzpIyB89MbvMx8PBkQ59jpVtMfQ/Dh0asap2IRYdI+x09PchCFr+3yNdvwxn0eQu
	 68RJOAe/BFqpA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 4/7] KVM: x86: Add a per-vendor callback to setup EFER caps
Date: Tue, 30 Jun 2026 23:47:12 +0000
Message-ID: <20260630234716.3039031-5-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260630234716.3039031-1-yosry@kernel.org>
References: <20260630234716.3039031-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move handling EFER.SVME and EFER.LMSLE from hardware setup to a new
optional per-vendor callback invoked from kvm_setup_efer_caps(). This
centralizes allowed EFER bits handling to kvm_setup_efer_caps(),
facilitating following changes to move efer_reserved_bits into kvm_caps.

Move the call to kvm_setup_efer_caps() after per-vendor ops are
initialized.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/svm/svm.c             | 20 +++++++++++++-------
 arch/x86/kvm/x86.c                 |  6 ++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 83dc5086138b3..d587242dcab56 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -45,6 +45,7 @@ KVM_X86_OP_OPTIONAL(post_set_cr3)
 KVM_X86_OP(is_valid_cr4)
 KVM_X86_OP(set_cr4)
 KVM_X86_OP(set_efer)
+KVM_X86_OP_OPTIONAL(setup_efer_caps)
 KVM_X86_OP(get_idt)
 KVM_X86_OP(set_idt)
 KVM_X86_OP(get_gdt)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d8700eb848b45..0efd93f961df4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1730,6 +1730,7 @@ struct kvm_x86_ops {
 	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	int (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
+	void (*setup_efer_caps)(void);
 	void (*get_idt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_idt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1d51500238462..747f1e31a3622 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -274,6 +274,18 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 	return 0;
 }
 
+static void svm_setup_efer_caps(void)
+{
+	if (nested) {
+		kvm_enable_efer_bits(EFER_SVME);
+		if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
+			kvm_enable_efer_bits(EFER_LMSLE);
+	} else {
+		kvm_disable_efer_bits(EFER_SVME);
+		kvm_disable_efer_bits(EFER_LMSLE);
+	}
+}
+
 static u32 svm_get_interrupt_shadow(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -5364,6 +5376,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.is_valid_cr4 = svm_is_valid_cr4,
 	.set_cr4 = svm_set_cr4,
 	.set_efer = svm_set_efer,
+	.setup_efer_caps = svm_setup_efer_caps,
 	.get_idt = svm_get_idt,
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
@@ -5638,16 +5651,9 @@ static __init int svm_hardware_setup(void)
 
 	if (nested) {
 		pr_info("Nested Virtualization enabled\n");
-		kvm_enable_efer_bits(EFER_SVME);
-		if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
-			kvm_enable_efer_bits(EFER_LMSLE);
-
 		r = nested_svm_init_msrpm_merge_offsets();
 		if (r)
 			return r;
-	} else {
-		kvm_disable_efer_bits(EFER_SVME);
-		kvm_disable_efer_bits(EFER_LMSLE);
 	}
 
 	/*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a0b2c40d93c21..a297a77469b38 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6903,6 +6903,8 @@ static void kvm_setup_efer_caps(void)
 
 	if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
 		kvm_enable_efer_bits(EFER_AUTOIBRS);
+
+	kvm_x86_call(setup_efer_caps)();
 }
 
 static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
@@ -7041,13 +7043,13 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (r != 0)
 		goto out_mmu_exit;
 
-	kvm_setup_efer_caps();
-
 	enable_device_posted_irqs &= enable_apicv &&
 				     irq_remapping_cap(IRQ_POSTING_CAP);
 
 	kvm_ops_update(ops);
 
+	kvm_setup_efer_caps();
+
 	for_each_online_cpu(cpu) {
 		smp_call_function_single(cpu, kvm_x86_check_cpu_compat, &r, 1);
 		if (r < 0)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

