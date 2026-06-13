Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA52D0C62
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309047; cv=none; b=V7Rn4SqEMN9MDctVQnla3TuETDr1QAsZWcpqAiWBajKxYXSRaw4VgDmWyFt7YXIEIHMSKMLcs9+WGGUXDPyao6kA5IY8qdFkpowFqDAUTtGRzXtCR+Rc9tN+ESVr9TW7L8Wy3Ln2b113m4dKlf0joii6NNxO20aRy1/kv5TV5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309047; c=relaxed/simple;
	bh=Uua8NoReLZwg+KtTDEAKtFGq6YCkul3qgJGQ39pG+U0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ah/fJ4Kjz2yXKPUBNIgdmz26bvQGENClclzwvsA0HfNWuFMorBUtCOASWYOjJSENdGkIVxGeDlyd49x+JB4ZIG9fI6h1lNLuTvzmVLAufFbvfGUPfFY4+zKDSJr0Qjb6lAio9Pzbbx4mt0DbEwDplpsNnySYTtsPjR/wSfKUcI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kme6ZnaQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kme6ZnaQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0bfcd629eso17245185ad.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309043; x=1781913843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yMmgBRMgDm3PgTUcsZS0pmZjV2CvUFeUFMjem5CthKU=;
        b=Kme6ZnaQYaI9jcf+lssVROyVHS1rOJ+Z9534AhjrKnjOA/w65GxNu9HId5ZWBFnlri
         0GbPSq7vhqKtSTofq3m7Q7d5x3HCgNwKMZ2nubEaEEyK5Yl7C9YHcDSZ8M8gNlmmUTlc
         4jdV+XmFMJmDQlHA/lmigDTg2heBgb0wgBamtdjsCbEyCxIR2o5b2ECR0ihwoOW1wLS2
         o0UrLwWxVbz7z4djrwetKxjvs78vVe4Mt+TgDw6mQyf0126AXJ1p8KLaFGpDtoY00UEc
         7soB8gAfOQBWeiti/suumSeIvFgBOhSVGpz5ehu1gXfV412ickELuFWxI8QvAy8btO07
         tNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309043; x=1781913843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMmgBRMgDm3PgTUcsZS0pmZjV2CvUFeUFMjem5CthKU=;
        b=mkl0RAt514WgIkZQzktYx2cqOOA9NdaQ4ADuutJKv3e5KBh0IAoM0FTEKxX5BalOcC
         QmVYcR92+66UazyjZvmVDj+lVk2dMqmdjjgXCXN3y9e08psDpasQjaKTkemmXCsMeBRJ
         KqQC6cfzIR9pKI0rOrWPdtyUrYp7IJkBvzTtDnAGuTLxRU9m5I8IBrsO4jxFNth0YUMu
         Dm5fmucmVizcmiJMqIOvgpgXnEW6ScOnOfdoEDnTazrlWWQbbZTbxmjuiUX6n21iZEcy
         gfC87tytfJR+ZwisBZQUZa/g2mWa+L+ZIM8ResRj4ghqY0tBz1fvL50kur8FkmFEzPgI
         RDig==
X-Gm-Message-State: AOJu0Ywpe82Xq6MGUTIB/o3BHGq35SQO/HPjluGUYWK0kyCFGDOVvdGh
	YG2IcLbq1QbmOSHRAR0ntpgZLU2iHfMKQYArX2whLdoN2huRUW8UOJ+Hqpt5exBFtMuM5qSotO4
	yN1eqvw==
X-Received: from plps24.prod.google.com ([2002:a17:902:9898:b0:2c0:d81c:b06a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e790:b0:2c0:b4f5:41ea
 with SMTP id d9443c01a7336-2c66424305emr17166115ad.17.1781309042887; Fri, 12
 Jun 2026 17:04:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:20 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-22-seanjc@google.com>
Subject: [PATCH v4 21/30] KVM: x86: Move LLDT assembly wrappers into VMX
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move kvm_{load,read}_ldt() into vmx.c, as vmx_{load,store}_ldt(), as they
are exclusively used by VMX to save/restore host state, and have no
business being globally visible.

Ideally, KVM-specific helpers wouldn't exist at all, as they are nothing
more than assembly wrappers for SLDT and LLDT, i.e. should be provided by
the kernel, not by KVM.  Punt that cleanup to the future, as
arch/x86/include/asm/desc.h _does_ provide helpers, but load_ldt() is only
available for CONFIG_PARAVIRT_XXL=n builds, and both {load,store}_ldt()
unnecessarily constrain the operands to memory.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 12 ------------
 arch/x86/kvm/vmx/vmx.c          | 18 +++++++++++++++---
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1dd231ecf4b2..d1fdb2c3fdfa 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2312,18 +2312,6 @@ static inline void kvm_dec_apicv_irq_window_req(struct kvm *kvm)
 
 #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
 
-static inline u16 kvm_read_ldt(void)
-{
-	u16 ldt;
-	asm("sldt %0" : "=g"(ldt));
-	return ldt;
-}
-
-static inline void kvm_load_ldt(u16 sel)
-{
-	asm("lldt %0" : : "rm"(sel));
-}
-
 #ifdef CONFIG_X86_64
 static inline unsigned long read_msr(unsigned long msr)
 {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c548f22375ad..2c120ff47790 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1186,6 +1186,18 @@ static void vmx_remove_autostore_msr(struct vcpu_vmx *vmx, u32 msr)
 	vmx_remove_auto_msr(&vmx->msr_autostore, msr, VM_EXIT_MSR_STORE_COUNT);
 }
 
+static u16 vmx_store_ldt(void)
+{
+	u16 ldt;
+	asm("sldt %0" : "=g"(ldt));
+	return ldt;
+}
+
+static void vmx_load_ldt(u16 sel)
+{
+	asm("lldt %0" : : "rm"(sel));
+}
+
 #ifdef CONFIG_X86_32
 /*
  * On 32-bit kernels, VM exits still load the FS and GS bases from the
@@ -1203,7 +1215,7 @@ static unsigned long segment_base(u16 selector)
 	table = get_current_gdt_ro();
 
 	if ((selector & SEGMENT_TI_MASK) == SEGMENT_LDT) {
-		u16 ldt_selector = kvm_read_ldt();
+		u16 ldt_selector = vmx_store_ldt();
 
 		if (!(ldt_selector & ~SEGMENT_RPL_MASK))
 			return 0;
@@ -1358,7 +1370,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	 * Set host fs and gs selectors.  Unfortunately, 22.2.3 does not
 	 * allow segment selectors with cpl > 0 or ti == 1.
 	 */
-	host_state->ldt_sel = kvm_read_ldt();
+	host_state->ldt_sel = vmx_store_ldt();
 
 #ifdef CONFIG_X86_64
 	savesegment(ds, host_state->ds_sel);
@@ -1405,7 +1417,7 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 	rdmsrq(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #endif
 	if (host_state->ldt_sel || (host_state->gs_sel & 7)) {
-		kvm_load_ldt(host_state->ldt_sel);
+		vmx_load_ldt(host_state->ldt_sel);
 #ifdef CONFIG_X86_64
 		load_gs_index(host_state->gs_sel);
 #else
-- 
2.54.0.1136.gdb2ca164c4-goog

