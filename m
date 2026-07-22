Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F872475CB
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693001; cv=none; b=JpqRWIK4F4pYs8QJ7jbLUtoqnKGknmFiiTiQflt2jnvVaCFqHbHFFPKQTYoXyyMnvtxZYSrz64W0jib0gNIMYtNixjvYZRivZ85jHltEeWHm99u76jtSf1S/TKyKxPxLmkFxe9DID1FdXIpaFeSkb1Arh8Gh/U2/YqdjBJp2Oqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693001; c=relaxed/simple;
	bh=VOBtRcOQg4mA1A0Pagcmmpv6b0Tg2ONUPvy5OsvrnMI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SGx/XjBsewe2SPn7TYYUPHF9IvPM06w8PLLNbjrdRTj3e+WBCqhPdWHXyX61Ju0Ae5o3fjC1fg0umBzMFKtWO2OK5qwYb9jTWfmcQyeb45rzULJj1grnsrlWywyRRA8veIweyVgFuNK9vZeBCeXDLXA34suelFXdH9PW5h7jYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sj4ZKONE; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sj4ZKONE"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so6708810a91.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 21:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784692999; x=1785297799; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZGFGm66+t+aia/xn3ZV0jhuYgmzvMjcwSMzrbV18qyA=;
        b=Sj4ZKONEuj4Vb9NflHSg4VpHFTMCaDi9pp3A5KKCgiSk7V9dj7FL9+AAofEi77urS/
         6LqyeY0b7yAI1uvq6DgOH8iy8WVpaA93MiM0tVgyFb2ReEu9jrfl2lli87Ed0t4sNYL2
         CGm6t7MSrmtWMXFL6lY2iG/968f6VfAtTzmT13VA5dxsWy7lfUGUPMJmBSv9240ByiiP
         4qVzTXeHmYzdepTGxWnCe5a6yXhLHZAUDJ0WkCIwEQQJioBQSCe3ok3n0ZjAPUShevGz
         nUlzVW/+acIRrGL60d+HuAFk63X6JJlexWeGRzaiQeBBjE+uuyUws/szopblb3jP+5I7
         zx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784692999; x=1785297799;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGFGm66+t+aia/xn3ZV0jhuYgmzvMjcwSMzrbV18qyA=;
        b=VGJieJ7ut4UCSKr/1+E1irnjx7PqKHd8cv3tcktajH2QjPeYT6xh/5yPyLbSoWeZem
         2MVOvsUFU8zfTG7wCnBg/dGg9uiuCRDNXDA2nLTnim+BgSA+JJX0C5AKngfAwBG02tEU
         XafzEi/cVUXttJwU41r572+pUELuOPNO/HULtlNQ1M5wE3Gg1WJNzKOHzEz6vPICMj70
         qiKrL3KDNNQ1rhcdm1flTkgpoy/Q39LMikT1/b34+voGEGnOZJRq659jW4v24Cwt2hpr
         wh2O6EaPHY5bU9153YCn3LRGit3AK11UwT1kvOEsPuQZ4nkpWCBhXb6Cn+iFwjL2oP73
         wF7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrkO650NF04MiS1uexD2msJyO4zv3xu2uebfpLr1SHWqkpH7+v4fEacm44eqiztywy/h2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyoejKyeLNhB3W9TbykRrY2GAFvDSV62bCA7BzjP0RFT92+rQx
	jI4MPgqIbkbaHbaROFWRWC8rM2cKJBJOEnmmsBggkzLV68bil63bk+Bzl7DyZyZtS0BdD3C6s1r
	zwhfE0E6No8DLGQ==
X-Received: from pjhu91.prod.google.com ([2002:a17:90a:51e4:b0:381:71cf:62c])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5150:b0:38e:3097:dd0b with SMTP id 98e67ed59e1d1-38e4b5c8c41mr21030838a91.36.1784692998774;
 Tue, 21 Jul 2026 21:03:18 -0700 (PDT)
Date: Tue, 21 Jul 2026 21:03:11 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722040311.3369898-1-jmattson@google.com>
Subject: [PATCH v3] KVM: VMX: Cap VMX preemption timer to work around Intel erratum
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: chao.gao@intel.com, kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Due to a widespread Intel erratum (e.g. EMR158), programming the
VMX-preemption timer with certain large values may cause the timer to
expire earlier than expected.  The recommended workaround is to cap the
VMX-preemption timer value to strictly less than 2^25 * CPUID.15H:EBX[31:0]
/ CPUID.15H:EAX[31:0].

Calculate preemption_timer_limit during hardware setup based on CPUID 15H
when available, and return -ERANGE in vmx_set_hv_timer() if the shifted
delta_tsc reaches or exceeds preemption_timer_limit.

Use preemption_timer_limit - 1 instead of 0xffffffff when soft-disabling
the timer and when checking the timer frequency limit in hardware setup.

Reported-by: Sean Christopherson <seanjc@google.com>
Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/
Suggested-by: Chao Gao <chao.gao@intel.com>
Assisted-by: Gemini:Gemini-Next
Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
v3:
  * Use preemption_timer_limit - 1 instead of 0xffffffff when soft-disabling
    the timer and when checking the timer frequency limit in hardware setup
    [Chao]

v2: https://lore.kernel.org/all/20260720231639.1592848-1-jmattson@google.com/

v1: https://lore.kernel.org/all/20260720205230.1457146-1-jmattson@google.com/

 arch/x86/kvm/vmx/vmx.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..268a3841c9de 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -151,6 +151,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
 /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
 static int __read_mostly cpu_preemption_timer_multi;
 static bool __read_mostly enable_preemption_timer = 1;
+static u64 __ro_after_init preemption_timer_limit;
 #ifdef CONFIG_X86_64
 module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 #endif
@@ -7412,7 +7413,7 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit
 		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
 	} else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
-		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, -1);
+		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, preemption_timer_limit - 1);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = true;
 	}
 }
@@ -8338,12 +8339,12 @@ int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 		return -ERANGE;
 
 	/*
-	 * If the delta tsc can't fit in the 32 bit after the multi shift,
-	 * we can't use the preemption timer.
+	 * If the delta tsc exceeds the preemption timer limit after the
+	 * multi shift, we can't use the preemption timer.
 	 * It's possible that it fits on later vmentries, but checking
 	 * on every vmentry is costly so we just use an hrtimer.
 	 */
-	if (delta_tsc >> (cpu_preemption_timer_multi + 32))
+	if ((delta_tsc >> cpu_preemption_timer_multi) >= preemption_timer_limit)
 		return -ERANGE;
 
 	vmx->hv_deadline_tsc = tscl + delta_tsc;
@@ -8585,6 +8586,26 @@ static void __init vmx_setup_me_spte_mask(void)
 	kvm_mmu_set_me_spte_mask(0, me_mask);
 }
 
+/*
+ * Workaround for a widespread Intel erratum (e.g. EMR158) where the
+ * VMX-preemption timer may expire earlier than expected when programmed
+ * with large values. The workaround is to cap the timer value to strictly
+ * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
+ */
+static __init u64 calc_preemption_timer_limit(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (cpuid_eax(0) < 0x15)
+		return 1ULL << 32;
+
+	cpuid(0x15, &eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx)
+		return 1ULL << 32;
+
+	return min_t(u64, 1ULL << 32, div_u64((u64)ebx << 25, eax));
+}
+
 __init int vmx_hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
@@ -8726,6 +8747,8 @@ __init int vmx_hardware_setup(void)
 		cpu_preemption_timer_multi =
 			vmx_misc_preemption_timer_rate(vmcs_config.misc);
 
+		preemption_timer_limit = calc_preemption_timer_limit();
+
 		if (tsc_khz)
 			use_timer_freq = (u64)tsc_khz * 1000;
 		use_timer_freq >>= cpu_preemption_timer_multi;
@@ -8735,7 +8758,7 @@ __init int vmx_hardware_setup(void)
 		 * value.  Don't use the timer if it might cause spurious exits
 		 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
 		 */
-		if (use_timer_freq > 0xffffffffu / 10)
+		if (use_timer_freq > (preemption_timer_limit - 1) / 10)
 			enable_preemption_timer = false;
 	}
 
-- 
2.55.0.229.g6434b31f56-goog

