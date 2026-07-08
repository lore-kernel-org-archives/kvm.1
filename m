Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D115C3CC324;
	Wed,  8 Jul 2026 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492481; cv=none; b=FCrgDEd7yRvZetDwTl4FH/M7Nep2aUfZ/X0MP7eYT9KfUYnwP+uGuuyUF6CTxuN/PJoxYLB2Ty7ZKF3+IhiBK+AzCP8KJI5/wk9VRI/SKInFImWV85GAdt6OQWxIHgIF4ucfDEE/HLKB7Twwqjy1P0x5ByrexJSyMRsfefpyWW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492481; c=relaxed/simple;
	bh=droMoq/e2Pt1YlFhEwgCABfQVv4g9i7Rm5vXV11LJ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNqQCN6H4txhdrc9Mv41faKTZqxeOLcW4/Ev26PS1nWfwup/t9HjdHe1WtW/OvRVHPZG+oPaifnQp0Mk7xQKqTpi0SZTj45HoCYNExMXjXVC99OCyOpSV6CqSwoscNt+JQBmvMpo+wfkzS74218nI5W7p1RK3rlveWaqFAR8j2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnjsZWWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnjsZWWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF3C1F00A3D;
	Wed,  8 Jul 2026 06:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492479;
	bh=Xu2eX1Apoodu9sE76eL1NY9WnTI7fJo0R0MlSCbfKRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UnjsZWWu+ONMF9FxrU9/N1B7mivdMnGufKXj+ROupGjlzcf5KngBNTxv+7wNtxya/
	 XiDXdWdo0J4kXCNBdtV9XD5KioaDJCwjppS64jx6/1pfypxtCU12KYmv0293y69SJz
	 KaEj0cCyh17Q6u0fQjLMvKB3S6GwxPfzJdoKEfTg01JjCjvxN7Fa39ZBvnIhpIwnWC
	 giVhrzwo2rtmfSye9Yf76uRj5tC16eY/qaZeaR0SE8jDJsVkv1pvUGvtx93saa0/5m
	 RfACMvAeTU1WUWRcil12yPDxrOjHArdIryUEFjQRDNqTkJL0OV5s7oJH3hFr4Ru+8L
	 x70xtPPcYOZuw==
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
Subject: [RFC PATCH v3 19/27] KVM: SVM: Implement kvm_x86_ops->protected_apic_has_injectable_intr() for Secure AVIC
Date: Wed,  8 Jul 2026 12:02:17 +0530
Message-ID: <063774d79eb2e66c5f9fa3b24006e509f4677d75.1783490022.git.naveen@kernel.org>
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

KVM tracks interrupts to be injected for a Secure AVIC enabled guest in
its copy of the APIC_IRR. Consequently, checking if an interrupt is
pending injection just requires checking KVM's copy of the APIC_IRR. Wire
up protected_apic_has_injectable_intr() to do so.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/svm.h | 2 ++
 arch/x86/kvm/svm/sev.c | 6 ++++++
 arch/x86/kvm/svm/svm.c | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5e9496f8566a..af3c84a61c07 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1017,6 +1017,7 @@ int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
 void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
 bool snp_is_secure_avic_enabled(struct kvm *kvm);
+bool snp_protected_apic_has_injectable_intr(struct kvm_vcpu *vcpu);
 #else
 static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 {
@@ -1055,6 +1056,7 @@ static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 }
 static inline void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa) {}
 static inline bool snp_is_secure_avic_enabled(struct kvm *kvm) { return false; }
+static inline bool snp_protected_apic_has_injectable_intr(struct kvm_vcpu *vcpu) { return false; }
 #endif
 
 /* vmenter.S */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index ca921a185b64..3d36168c3327 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -35,6 +35,7 @@
 #include "svm_ops.h"
 #include "cpuid.h"
 #include "trace.h"
+#include "lapic.h"
 
 #define GHCB_VERSION_MAX	2ULL
 #define GHCB_VERSION_MIN	1ULL
@@ -4941,6 +4942,11 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
 		hostsa->tsc_aux = kvm_get_user_return_msr(tsc_aux_uret_slot);
 }
 
+bool snp_protected_apic_has_injectable_intr(struct kvm_vcpu *vcpu)
+{
+	return apic_find_highest_vector(vcpu->arch.apic->regs + APIC_IRR) != -1;
+}
+
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0e0dd9618750..441520c1312d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5398,6 +5398,8 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.apicv_post_state_restore = avic_apicv_post_state_restore,
 	.required_apicv_inhibits = AVIC_REQUIRED_APICV_INHIBITS,
 
+	.protected_apic_has_injectable_intr = snp_protected_apic_has_injectable_intr,
+
 	.get_exit_info = svm_get_exit_info,
 	.get_entry_info = svm_get_entry_info,
 
-- 
2.54.0

