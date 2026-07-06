Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3D3CB2DF;
	Mon,  6 Jul 2026 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367685; cv=none; b=hrP9+n3l2mGBas7Gjyn9wwg9/Fm0a+4PGFvh6d16JPMVxfzwi74F2myKA2fxIBQjmE6enPDUXcRLjS/6a+tD+7V7VnokJm7wcW7Bh6yJprwV4Eg0DL+0y4d5XO7Hu69vRneiTp7xhqlFTBN+h8XUoMXcdKMXwLJYjQ9zIa6r2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367685; c=relaxed/simple;
	bh=//ksvxEOsTROg0L7JTVpfzuo2E59+46VMVcev0NNfEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otxVWFTJORIiEGX2lNrV5AEiWIb0SMzUdp+ASgSvFL6/UwxGYwxZ/tnNDX3xk3wrDGkMFbpxGnHRoGHTqDleN1QWF10k4JTen8RNt1aUHUo84jR7MVVx8nzSVk5cqldhmqIT0vOQJF8q7P8YUAaDxrmD3oT5TLrQoxr1YpZi6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjJTLFxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjJTLFxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27CC1F00AC4;
	Mon,  6 Jul 2026 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783367684;
	bh=BFub33c3f8SdmXGCrZHfcm1L5QEALoZs3d5KU2yLowY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AjJTLFxQ2pRgeLLePYVUAE44fbu21PgcaWw8W8MeZr8FrkdVXwQ9NcFa/F5m42+3r
	 D012fVhWIzpy/Nh0xjI/PHO/9LsYLsee8QI+WCtNwkelm4lj74LCxi035kFodmJ1C2
	 fti8VakSiGlgfsHdECE2p9CLoYD5qzQWtvyvMjzkPdcfPb/ZySexVYoGjwCe8mfzKE
	 3+3kxxW+5Te0o6PWraR97S9eY9Sk9VTnn3llOxqQopZy6nNIULMZ5T2Y0VYJaxMjjm
	 9p93JqFVavG1+09pRYfsPDLS+GVVjYIjz0UTu+yPchviw17vjKlYCVnx5TU6H5PyxS
	 NqUHKI04Hd3pQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 4/7] KVM: x86: Add a per-vendor callback to setup EFER caps
Date: Mon,  6 Jul 2026 19:54:10 +0000
Message-ID: <20260706195413.1966458-5-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706195413.1966458-1-yosry@kernel.org>
References: <20260706195413.1966458-1-yosry@kernel.org>
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
2.55.0.rc2.803.g1fd1e6609c-goog

