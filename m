Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA813E51E3
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968189; cv=none; b=C4nE2rRdO5Mu5CcB96R8Y12x+WNNyT2UTlCcEVy0k4eNYEsVzSTxaumJguQwkz+u51gvx41/OsZlrCNvVdlj0aCOod5qWBFTeCr+9A9qFhxuZ/1H/uQr10KVdUswMTRHSOWnqzoBYSx62TjjyyQq5SSTBdOkLW79Z8O78V0MglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968189; c=relaxed/simple;
	bh=c/BRJrvMgUknobRNXd28o9C5+IkXCI0PYo28UU2pMjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukBSzpPttbNH56iPjHWGzcX5Nz1zgyyJEyHBGGCfiNov1l3/WjzK152ktAfqQwt1XnGn5JAE7GH/l2f8A2L48GZH69mGaeEwFaKlBLJ/FWYj0syH55vhTGHsgjtKSa4LISAvunAnHZpI+SZm8GxA6neQzC2N3YsFafpTEMGAS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D10946AE3A;
	Thu, 28 May 2026 11:36:22 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 904CD5AD77;
	Thu, 28 May 2026 11:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /yQuIrYoGGpqSQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 28 May 2026 11:36:22 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/6] KVM/x86: Return -errno instead of "1" for APIC related MSR emulation
Date: Thu, 28 May 2026 13:36:01 +0200
Message-ID: <20260528113605.267111-3-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528113605.267111-1-jgross@suse.com>
References: <20260528113605.267111-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: D10946AE3A
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

Instead of a literal "1" for signalling an error, use a negative errno
value in the emulation code of APIC related MSR registers.

Remove some not needed braces.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- use -errno instead of KVM_MSR_RET_ERR
---
 arch/x86/kvm/lapic.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4078e624ca66..3e7d83db2f7a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2412,11 +2412,10 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 
 	switch (reg) {
 	case APIC_ID:		/* Local APIC ID */
-		if (!apic_x2apic_mode(apic)) {
+		if (!apic_x2apic_mode(apic))
 			kvm_apic_set_xapic_id(apic, val >> 24);
-		} else {
-			ret = 1;
-		}
+		else
+			ret = -EINVAL;
 		break;
 
 	case APIC_TASKPRI:
@@ -2432,14 +2431,14 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 		if (!apic_x2apic_mode(apic))
 			kvm_apic_set_ldr(apic, val & APIC_LDR_MASK);
 		else
-			ret = 1;
+			ret = -EINVAL;
 		break;
 
 	case APIC_DFR:
 		if (!apic_x2apic_mode(apic))
 			kvm_apic_set_dfr(apic, val | 0x0FFFFFFF);
 		else
-			ret = 1;
+			ret = -EINVAL;
 		break;
 
 	case APIC_SPIV: {
@@ -2470,7 +2469,7 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 		break;
 	case APIC_ICR2:
 		if (apic_x2apic_mode(apic))
-			ret = 1;
+			ret = -EINVAL;
 		else
 			kvm_lapic_set_reg(apic, APIC_ICR2, val & 0xff000000);
 		break;
@@ -2485,7 +2484,7 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 	case APIC_LVTCMCI: {
 		u32 index = get_lvt_index(reg);
 		if (!kvm_lapic_lvt_supported(apic, index)) {
-			ret = 1;
+			ret = -EINVAL;
 			break;
 		}
 		if (!kvm_apic_sw_enabled(apic))
@@ -2527,7 +2526,7 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 	}
 	case APIC_ESR:
 		if (apic_x2apic_mode(apic) && val != 0)
-			ret = 1;
+			ret = -EINVAL;
 		break;
 
 	case APIC_SELF_IPI:
@@ -2536,12 +2535,12 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 		 * the vector, everything else is reserved.
 		 */
 		if (!apic_x2apic_mode(apic) || (val & ~APIC_VECTOR_MASK))
-			ret = 1;
+			ret = -EINVAL;
 		else
 			kvm_apic_send_ipi(apic, APIC_DEST_SELF | val, 0);
 		break;
 	default:
-		ret = 1;
+		ret = -EINVAL;
 		break;
 	}
 
@@ -2599,7 +2598,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lapic_set_eoi);
 static int __kvm_x2apic_icr_write(struct kvm_lapic *apic, u64 data, bool fast)
 {
 	if (data & X2APIC_ICR_RESERVED_BITS)
-		return 1;
+		return -EINVAL;
 
 	/*
 	 * The BUSY bit is reserved on both Intel and AMD in x2APIC mode, but
@@ -2804,12 +2803,12 @@ int kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value, bool host_initiated)
 		(guest_cpu_cap_has(vcpu, X86_FEATURE_X2APIC) ? 0 : X2APIC_ENABLE);
 
 	if ((value & reserved_bits) != 0 || new_mode == LAPIC_MODE_INVALID)
-		return 1;
+		return -EINVAL;
 	if (!host_initiated) {
 		if (old_mode == LAPIC_MODE_X2APIC && new_mode == LAPIC_MODE_XAPIC)
 			return 1;
 		if (old_mode == LAPIC_MODE_DISABLED && new_mode == LAPIC_MODE_X2APIC)
-			return 1;
+			return -EINVAL;
 	}
 
 	__kvm_apic_set_base(vcpu, value);
@@ -3438,7 +3437,7 @@ static int kvm_lapic_msr_read(struct kvm_lapic *apic, u32 reg, u64 *data)
 	}
 
 	if (kvm_lapic_reg_read(apic, reg, 4, &low))
-		return 1;
+		return -EINVAL;
 
 	*data = low;
 
@@ -3457,7 +3456,7 @@ static int kvm_lapic_msr_write(struct kvm_lapic *apic, u32 reg, u64 data)
 
 	/* Bits 63:32 are reserved in all other registers. */
 	if (data >> 32)
-		return 1;
+		return -EINVAL;
 
 	return kvm_lapic_reg_write(apic, reg, (u32)data);
 }
@@ -3468,7 +3467,7 @@ int kvm_x2apic_msr_write(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 	u32 reg = (msr - APIC_BASE_MSR) << 4;
 
 	if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(apic))
-		return 1;
+		return -EINVAL;
 
 	return kvm_lapic_msr_write(apic, reg, data);
 }
@@ -3479,7 +3478,7 @@ int kvm_x2apic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 	u32 reg = (msr - APIC_BASE_MSR) << 4;
 
 	if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(apic))
-		return 1;
+		return -EINVAL;
 
 	return kvm_lapic_msr_read(apic, reg, data);
 }
@@ -3487,7 +3486,7 @@ int kvm_x2apic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 int kvm_hv_vapic_msr_write(struct kvm_vcpu *vcpu, u32 reg, u64 data)
 {
 	if (!lapic_in_kernel(vcpu))
-		return 1;
+		return -EINVAL;
 
 	return kvm_lapic_msr_write(vcpu->arch.apic, reg, data);
 }
@@ -3495,7 +3494,7 @@ int kvm_hv_vapic_msr_write(struct kvm_vcpu *vcpu, u32 reg, u64 data)
 int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 reg, u64 *data)
 {
 	if (!lapic_in_kernel(vcpu))
-		return 1;
+		return -EINVAL;
 
 	return kvm_lapic_msr_read(vcpu->arch.apic, reg, data);
 }
-- 
2.54.0

