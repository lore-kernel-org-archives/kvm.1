Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931F3C8C73;
	Wed,  8 Jul 2026 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492485; cv=none; b=AuGCN7gM+IqDka2tSR/pQryw2PcPSPfe9inphiw95YfcRXVnbYO0xO2KzLZq2KoqxdaB1enol8i4Txg+2H6nGRsJey1blY6JdSFs509EkwYc4DhGTgRCFLIYXMM31yWKo7OT9t8FiS+Mcp5O4QMMbt54JRX59L4xbSKhVg3mPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492485; c=relaxed/simple;
	bh=oerl05PBF8z3j93hHXivADX0WRmfTBzdZejSow0+E0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRxkOY3WF0d5Fc29OM9OS9wjuTmIXly0KwmFF27hG9CyQ+SMKWjaKHmsADpvmn7htjDU1lo3CefL7MxZGxbJ2tv7BdUhkf18pofo8gNkdFL5/uNqhAS0bVD+b5AV8xVE2MmTuhX1npUKZTPsUrF3yaS6qDr6EEg2TanPs5wxaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfTMW5Zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfTMW5Zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259FA1F000E9;
	Wed,  8 Jul 2026 06:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492484;
	bh=o8I83cPwQxkdpiPvomF3BsmhmI22XikmtCvjK/7pNO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DfTMW5Zrnp0oCsixf+UueYl/OyNuu+16D+QxCsgJbSgY1cCHkyFcv0Fsa8rTq8FL3
	 AG7PfAzq7Aef6Bw5/iOmd5cVWuEiI48GnZc6zo8eGNyh+SX5ETmJixJNEGBI4/5iIP
	 cPt85SpRd+wtQfEH04cgCB+BjYNwFg1Fzkx19slFQSW14j+LR4/cVJhj74Wdy3FzKg
	 z7Iw+SSbCrjxzk3vjSjlGh0ABAjWbhQr6JtX9+RXiuum8JxUfB1mONqvLhmQheZFL4
	 hYB9t3RcxXGX++0wdzumUR0lur8NwhOupHaE/+0wWbnRO0R2WN/NN8Y/0lYw+tlnyt
	 kAUUNVywc3JKA==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 20/27] KVM: SVM: Implement kvm_x86_ops->protected_apic_has_interrupt() for Secure AVIC
Date: Wed,  8 Jul 2026 12:02:18 +0530
Message-ID: <c3e4f978f43bce1b187d054f83d13894739658b6.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since KVM tracks pending interrupts for a Secure AVIC guest in its copy
of the APIC_IRR, wire up protected_apic_has_interrupt() to just use
protected_apic_has_injectable_intr().

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/svm.h | 2 ++
 arch/x86/kvm/svm/sev.c | 5 +++++
 arch/x86/kvm/svm/svm.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index af3c84a61c07..f5e270086b51 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1018,6 +1018,7 @@ struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
 void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
 bool snp_is_secure_avic_enabled(struct kvm *kvm);
 bool snp_protected_apic_has_injectable_intr(struct kvm_vcpu *vcpu);
+bool snp_protected_apic_has_interrupt(struct kvm_vcpu *vcpu);
 #else
 static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 {
@@ -1057,6 +1058,7 @@ static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 static inline void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa) {}
 static inline bool snp_is_secure_avic_enabled(struct kvm *kvm) { return false; }
 static inline bool snp_protected_apic_has_injectable_intr(struct kvm_vcpu *vcpu) { return false; }
+static inline bool snp_protected_apic_has_interrupt(struct kvm_vcpu *vcpu) { return false; }
 #endif
 
 /* vmenter.S */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3d36168c3327..a0c5271ec4ca 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4947,6 +4947,11 @@ bool snp_protected_apic_has_injectable_intr(struct kvm_vcpu *vcpu)
 	return apic_find_highest_vector(vcpu->arch.apic->regs + APIC_IRR) != -1;
 }
 
+bool snp_protected_apic_has_interrupt(struct kvm_vcpu *vcpu)
+{
+	return snp_protected_apic_has_injectable_intr(vcpu);
+}
+
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 441520c1312d..3f731483f6a2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5399,6 +5399,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.required_apicv_inhibits = AVIC_REQUIRED_APICV_INHIBITS,
 
 	.protected_apic_has_injectable_intr = snp_protected_apic_has_injectable_intr,
+	.protected_apic_has_interrupt = snp_protected_apic_has_interrupt,
 
 	.get_exit_info = svm_get_exit_info,
 	.get_entry_info = svm_get_entry_info,
-- 
2.54.0

