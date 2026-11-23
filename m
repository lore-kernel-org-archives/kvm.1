Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456522;
	b=zr8AHZPuoZ/J1MNDmG3nmc2ksMLCKcX5zEcWmKHVhsQd+Pm0koH2EGq7dR73xpZbHpVB
	 shY7rS2AiOic+12bxB3z8xH5xgUkiJRigGgyG8GmY7F7CZX7kAiHlbUfSNu9wlkXdS/ON
	 yzvN8pMZAYziroovyZquTTrsXYdt50V3ijqHpU9Y1yZNjXoF05uOn9Zn5fZy/Py64VyZZ
	 1oLaYv6c36CZdx9dxTywXNNRnsyBC886MWdHoukdx9lXze9nuiqNYMjBmHqRQoKe89r3v
	 JjghZH2bD0RyvLcJqxF+eZbB86p6B4HRI9ig3ZPAaH9AqcOJ9q2pjlT3bhQJIY+zrKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456522;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=AZgcAsid3eINy8AxOkhe0rK3Qg9CEfzVQ1V1pzfpXmo=;
	b=umOY+tEfuRyeJiwjQKwKoA1elK4Oi6HgVHlzenzxGaNA9WF1HUtzi5RTCzCN84Y4E993
	 8rWxFtrVTyO7fpjC9p886TpHbiBuR+FrO6I+Qy9Gb59EhJM5503nOaQzasbLFIdZ1uakU
	 cvVnb60fujrpoWRE3+zzZGlF8nQQHUOmIPMkQoT6VxeKA2dm9qS+qBGPUs4nIG1xDd0xn
	 I/DzQP83yrrV4PSllI5AkMe44DoiZj45w/6d3uQtV8m6lz1hMPGUb31B9tZLfHKEDSMZv
	 f8A1H8xqV2PXOjFtZnjQr2PspE1wWLtprel4xzsJJNWevXPsPwEBVpcetxRNaXMWl9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=de4Ntwlm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D3606A32E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 17:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C8D3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=de4Ntwlm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795456521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZgcAsid3eINy8AxOkhe0rK3Qg9CEfzVQ1V1pzfpXmo=;
	b=de4NtwlmNar7+3fsoEn7XL76mxSovZx9kUi99OpO1J/XLg2cSct2DFbrnEpV5/9AUONNFA
	czZtcxyjNrQfZwcuTIesqhNmnJscYY2O3qIcBbEPV8cPaRtCT8UWwZgl5Q3Pbw/H89YjPx
	C4XRf6TRMDFbfwm88FhmOmJ7uFXGycY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-tMsMsEokMhuEOrogH7yD5Q-1; Mon,
 23 Nov 2026 17:55:18 +0000
X-MC-Unique: tMsMsEokMhuEOrogH7yD5Q-1
X-Mimecast-MFC-AGG-ID: tMsMsEokMhuEOrogH7yD5Q_1795456517
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ED1F1954AF4;
	Mon, 23 Nov 2026 17:55:17 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A680346;
	Mon, 23 Nov 2026 17:55:16 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v3 2/5] KVM: x86: split vcpu->arch.hflags into nested_guest_mode and smm_mode
Date: Mon, 23 Nov 2026 12:55:09 -0500
Message-ID: <20261123175512.80438-3-mlevitsk@redhat.com>
In-Reply-To: <20261123175512.80438-1-mlevitsk@redhat.com>
References: <20261123175512.80438-1-mlevitsk@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Split vcpu->arch.hflags into nested_guest_mode and smm_mode to prepare
for converting nested_guest_mode into an atomic variable that will contain
nested guest state that is exposed locklessly for other vCPUs.

No functional change expected.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 18 +++++++++++-------
 arch/x86/kvm/regs.h             |  6 +++---
 arch/x86/kvm/smm.c              |  8 ++++----
 arch/x86/kvm/smm.h              |  2 +-
 arch/x86/kvm/x86.c              | 11 ++++++-----
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ab30f418e526..d891dc678e9b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -738,7 +738,6 @@ struct kvm_vcpu_arch {
 	unsigned long cr8;
 	u32 host_pkru;
 	u32 pkru;
-	u32 hflags;
 	u64 efer;
 	u64 host_debugctl;
 	u64 apic_base;
@@ -758,6 +757,16 @@ struct kvm_vcpu_arch {
 	u64 arch_capabilities;
 	u64 perf_capabilities;
 
+#define KVM_NESTED_IN_GUEST	BIT(8)
+	/* Non zero when the guest is executing another guest */
+	u16 nested_guest_state;
+
+#ifdef CONFIG_KVM_SMM
+#define SMM_MASK		BIT(0)
+#define SMM_INSIDE_NMI_MASK	BIT(1)
+	/* Non zero when the guest is in SMM*/
+	u16 smm_mode;
+#endif
 	/*
 	 * Paging state of the vcpu
 	 *
@@ -1875,16 +1884,11 @@ static inline unsigned long read_msr(unsigned long msr)
 }
 #endif
 
-#define HF_GUEST_MASK		(1 << 0) /* VCPU is in guest-mode */
-
 #ifdef CONFIG_KVM_SMM
-#define HF_SMM_MASK		(1 << 1)
-#define HF_SMM_INSIDE_NMI_MASK	(1 << 2)
-
 # define KVM_MAX_NR_ADDRESS_SPACES	2
 /* SMM is currently unsupported for guests with private memory. */
 # define kvm_arch_nr_memslot_as_ids(kvm) (kvm_arch_has_private_mem(kvm) ? 1 : 2)
-# define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
+# define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.smm_mode & SMM_MASK ?  1 : 0)
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
 #else
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 447f0ec3e63e..6114a099d177 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -457,13 +457,13 @@ static inline unsigned long kvm_get_effective_dr7(struct kvm_vcpu *vcpu)
 
 static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.hflags |= HF_GUEST_MASK;
+	vcpu->arch.nested_guest_state = KVM_NESTED_IN_GUEST;
 	vcpu->stat.guest_mode = 1;
 }
 
 static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.hflags &= ~HF_GUEST_MASK;
+	vcpu->arch.nested_guest_state = 0;
 
 	if (vcpu->arch.load_eoi_exitmap_pending) {
 		vcpu->arch.load_eoi_exitmap_pending = false;
@@ -475,7 +475,7 @@ static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
 
 static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.hflags & HF_GUEST_MASK;
+	return vcpu->arch.nested_guest_state != 0;
 }
 
 static inline unsigned long kvm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 656a38dad7e7..60af64a6209f 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -114,9 +114,9 @@ void kvm_smm_changed(struct kvm_vcpu *vcpu, bool entering_smm)
 	trace_kvm_smm_transition(vcpu->vcpu_id, vcpu->arch.smbase, entering_smm);
 
 	if (entering_smm) {
-		vcpu->arch.hflags |= HF_SMM_MASK;
+		vcpu->arch.smm_mode |= SMM_MASK;
 	} else {
-		vcpu->arch.hflags &= ~(HF_SMM_MASK | HF_SMM_INSIDE_NMI_MASK);
+		vcpu->arch.smm_mode &= ~(SMM_MASK | SMM_INSIDE_NMI_MASK);
 
 		/* Process a latched INIT or SMI, if any.  */
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
@@ -311,7 +311,7 @@ void enter_smm(struct kvm_vcpu *vcpu)
 		goto error;
 
 	if (kvm_x86_call(get_nmi_mask)(vcpu))
-		vcpu->arch.hflags |= HF_SMM_INSIDE_NMI_MASK;
+		vcpu->arch.smm_mode |= SMM_INSIDE_NMI_MASK;
 	else
 		kvm_x86_call(set_nmi_mask)(vcpu, true);
 
@@ -584,7 +584,7 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 	if (ret < 0)
 		return X86EMUL_UNHANDLEABLE;
 
-	if ((vcpu->arch.hflags & HF_SMM_INSIDE_NMI_MASK) == 0)
+	if ((vcpu->arch.smm_mode & SMM_INSIDE_NMI_MASK) == 0)
 		kvm_x86_call(set_nmi_mask)(vcpu, false);
 
 	kvm_smm_changed(vcpu, false);
diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
index db3c88f16138..323c03827d28 100644
--- a/arch/x86/kvm/smm.h
+++ b/arch/x86/kvm/smm.h
@@ -151,7 +151,7 @@ static inline int kvm_inject_smi(struct kvm_vcpu *vcpu)
 
 static inline bool is_smm(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.hflags & HF_SMM_MASK;
+	return vcpu->arch.smm_mode & SMM_MASK;
 }
 
 void kvm_smm_changed(struct kvm_vcpu *vcpu, bool in_smm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..821411291f48 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3013,7 +3013,7 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
 	events->smi.smm = is_smm(vcpu);
 	events->smi.pending = vcpu->arch.smi_pending;
 	events->smi.smm_inside_nmi =
-		!!(vcpu->arch.hflags & HF_SMM_INSIDE_NMI_MASK);
+		!!(vcpu->arch.smm_mode & SMM_INSIDE_NMI_MASK);
 #endif
 	events->smi.latched_init = kvm_lapic_latched_init(vcpu);
 
@@ -3099,7 +3099,7 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 
 	if (events->flags & KVM_VCPUEVENT_VALID_SMM) {
 #ifdef CONFIG_KVM_SMM
-		if (!!(vcpu->arch.hflags & HF_SMM_MASK) != events->smi.smm) {
+		if (!!(vcpu->arch.smm_mode & SMM_MASK) != events->smi.smm) {
 			kvm_leave_nested(vcpu);
 			kvm_smm_changed(vcpu, events->smi.smm);
 		}
@@ -3108,9 +3108,9 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 
 		if (events->smi.smm) {
 			if (events->smi.smm_inside_nmi)
-				vcpu->arch.hflags |= HF_SMM_INSIDE_NMI_MASK;
+				vcpu->arch.smm_mode |= SMM_INSIDE_NMI_MASK;
 			else
-				vcpu->arch.hflags &= ~HF_SMM_INSIDE_NMI_MASK;
+				vcpu->arch.smm_mode &= ~SMM_INSIDE_NMI_MASK;
 		}
 
 #else
@@ -9554,7 +9554,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_lapic_reset(vcpu, init_event);
 
 	WARN_ON_ONCE(is_guest_mode(vcpu) || is_smm(vcpu));
-	vcpu->arch.hflags = 0;
+	vcpu->arch.smm_mode = 0;
+	vcpu->arch.nested_guest_state = 0;
 
 	vcpu->arch.smi_pending = 0;
 	vcpu->arch.smi_count = 0;
-- 
2.56.1

