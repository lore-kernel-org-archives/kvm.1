Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B03161AB
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776284636; cv=none; b=qLRsXxInkCgoFEfxS2Q/OM0MRH7+0TA3qn33QpYh65VT6/1FuBPd85rV5av28cJkuxndEb1iTK+zXTr3ZufPQw+8PCzJZfDlVU9cX5kVhVDUu7pz80g2/DFyFOWKi/JFMcwuxbsYtdsLYmMdTvpKV4ckXbFlFU5R4OhFNWR3qAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776284636; c=relaxed/simple;
	bh=XimFzuE+iTs8LG5ejhPwammpQ1xzR6hFJK1e/FsQtQk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mhLioiW/8bbPcBtoHN5lC2xxDHIB+dhNlsY+6NnifCC8pTJrjo4rw13JJpV4hMRVyUQmFlfcp5df1Y/55/tF7nGGaof5Gudz+zNblsS0E4BuIT642cgdpsWWMfsNomNyBz3h4uhIE+VH9tgeGAHfyik+V/QQyF9PfvNS5V6gbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqXgH7tR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqXgH7tR"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a90510a6d1so58387785ad.0
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776284635; x=1776889435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BibiKlMJ4/ODuW2X15QmQ8ureNdaaXO0AYMX9/zZ9s0=;
        b=sqXgH7tRy4RlOKp/WIHUwBnywmridE6OFWVMdkXxga6lhdqYqsr93Wwwt69Hg3fhRo
         kJ9KjEwW+JQDHwm5lkT2/vXUqdaPYVeRKrks8qaSJFNhJEypVONjUhJzAPS8vGFWQh64
         VbgZfMX6SQJUvrGqJAU1gEyOsQ4FsiEVD4c/2yABiCGcf4UWzNVYOhra87qvqg6L0CTJ
         SOBy1QzOAOSqrwnNqZfAD+YyjfU1DKZ1NnI1rgCzeBq1e2guscS8HmxAzlGoSlTU6VcH
         pceK9dr3B3jbj9IUqRKqoqW2Dua7oOHLKII+g9yhSUHBzlfX/klQhMOzYzCr4IrRF30C
         5NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284635; x=1776889435;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BibiKlMJ4/ODuW2X15QmQ8ureNdaaXO0AYMX9/zZ9s0=;
        b=DGboiVkeVlS47+4Q8ROEg00NHqzUbAuJCsiDzt12UCMEVQYg02QBgfIxUUgVP/bTF+
         b4a0896I/LaFZY/6w0hSy4FYZHrn/tY8kvH9A4XT3v62p6dcQAEBrHCtQfBZrQyWlNq9
         37UgKBb9bw+wuwd6uDTx2Eb+WaSBivAXuJogHyIW9nKQr1xAG+p8HZO6R5wgkzBvitEb
         yfg6kjGuA7G/cAGVe0KlPkgKmcfna4rOB0147lCa0Be5PBFSkg8kLZr2eJGcvPJjPoXx
         vfaoqCNLsti0f3sNjJfclIINXTOk+Ky3oaTAPjOshPql3comoqr5amyfTJWx5I2BowqX
         u7Zw==
X-Gm-Message-State: AOJu0YzmdjzpRobNiVZ9mef7dD7BQfFDACIG/6ictT9CyvHOMWmoH0/N
	FX3/n19Q7q8nPgwGXNA10If+oq4VhylEegdl7uu6Ts66eUhjgukCb1ASMWZsMLbqIg51ukzrOq6
	n/G9IWQ==
X-Received: from ploc13.prod.google.com ([2002:a17:902:848d:b0:2b2:3d4a:16db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:76c8:b0:2b4:64cf:e8f8
 with SMTP id d9443c01a7336-2b5eaa22628mr5434185ad.2.1776284634536; Wed, 15
 Apr 2026 13:23:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 15 Apr 2026 13:23:46 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260415202346.3026288-1-seanjc@google.com>
Subject: [PATCH 6.6] KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Taeyang Lee <0wn@theori.io>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 321ef62b0c5f6f57bb8500a2ca5986052675abbf ]

Check for a Requested Virtual Interrupt, i.e. a virtual interrupt that is
pending delivery, in vmx_has_nested_events() and drop the one-off
kvm_x86_ops.guest_apic_has_interrupt() hook.

In addition to dropping a superfluous hook, this fixes a bug where KVM
would incorrectly treat virtual interrupts _for L2_ as always enabled due
to kvm_arch_interrupt_allowed(), by way of vmx_interrupt_blocked(),
treating IRQs as enabled if L2 is active and vmcs12 is configured to exit
on IRQs, i.e. KVM would treat a virtual interrupt for L2 as a valid wake
event based on L1's IRQ blocking status.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240607172609.3205077-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Cc: Taeyang Lee <0wn@theori.io>
[sean: deal with lack of vmx/main.c and vmx/x86_ops.h]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  1 -
 arch/x86/kvm/vmx/nested.c          |  4 ++++
 arch/x86/kvm/vmx/vmx.c             | 21 ---------------------
 arch/x86/kvm/x86.c                 | 10 +---------
 5 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index a0a4fc684e63..3d00c2444a75 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -83,7 +83,6 @@ KVM_X86_OP_OPTIONAL(update_cr8_intercept)
 KVM_X86_OP(refresh_apicv_exec_ctrl)
 KVM_X86_OP_OPTIONAL(hwapic_irr_update)
 KVM_X86_OP_OPTIONAL(hwapic_isr_update)
-KVM_X86_OP_OPTIONAL_RET0(guest_apic_has_interrupt)
 KVM_X86_OP_OPTIONAL(load_eoi_exitmap)
 KVM_X86_OP_OPTIONAL(set_virtual_apic_mode)
 KVM_X86_OP_OPTIONAL(set_apic_access_page_addr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index df950c184c59..d79b8f7a3991 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1671,7 +1671,6 @@ struct kvm_x86_ops {
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
 	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
-	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
 	void (*set_apic_access_page_addr)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index fb274bae41e2..377b30212c19 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4007,6 +4007,10 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 
 	vppr = *((u32 *)(vapic + APIC_PROCPRI));
 
+	max_irr = vmx_get_rvi();
+	if ((max_irr & 0xf0) > (vppr & 0xf0))
+		return true;
+
 	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
 	    pi_test_on(vmx->nested.pi_desc)) {
 		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b68fb5329a13..4a45e86c5e2f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4127,26 +4127,6 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 	}
 }
 
-static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	void *vapic_page;
-	u32 vppr;
-	int rvi;
-
-	if (WARN_ON_ONCE(!is_guest_mode(vcpu)) ||
-		!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
-		WARN_ON_ONCE(!vmx->nested.virtual_apic_map.gfn))
-		return false;
-
-	rvi = vmx_get_rvi();
-
-	vapic_page = vmx->nested.virtual_apic_map.hva;
-	vppr = *((u32 *)(vapic_page + APIC_PROCPRI));
-
-	return ((rvi & 0xf0) > (vppr & 0xf0));
-}
-
 static void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -8390,7 +8370,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.required_apicv_inhibits = VMX_REQUIRED_APICV_INHIBITS,
 	.hwapic_irr_update = vmx_hwapic_irr_update,
 	.hwapic_isr_update = vmx_hwapic_isr_update,
-	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
 	.sync_pir_to_irr = vmx_sync_pir_to_irr,
 	.deliver_interrupt = vmx_deliver_interrupt,
 	.dy_apicv_has_pending_interrupt = pi_has_pending_interrupt,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ac0b458582c3..485c1820e65a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12906,12 +12906,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		kvm_arch_free_memslot(kvm, old);
 }
 
-static inline bool kvm_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-{
-	return (is_guest_mode(vcpu) &&
-		static_call(kvm_x86_guest_apic_has_interrupt)(vcpu));
-}
-
 static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 {
 	if (!list_empty_careful(&vcpu->async_pf.done))
@@ -12942,9 +12936,7 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_test_request(KVM_REQ_PMI, vcpu))
 		return true;
 
-	if (kvm_arch_interrupt_allowed(vcpu) &&
-	    (kvm_cpu_has_interrupt(vcpu) ||
-	    kvm_guest_apic_has_interrupt(vcpu)))
+	if (kvm_arch_interrupt_allowed(vcpu) && kvm_cpu_has_interrupt(vcpu))
 		return true;
 
 	if (kvm_hv_has_stimer_pending(vcpu))

base-commit: 8cee53b8eaeb5d1f7c97b7f2381653ed00ffc26b
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

