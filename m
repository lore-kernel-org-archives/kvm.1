Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76660392C39
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545880; cv=none; b=N0ofYH3g6N2sDHl7B3NwiFaMlaOSt1pyBi6cIMNKy6xByKyGS6LeuZF/GJvTbvRvVljhgPVtzr28ZPmzSKw+/7GM6y+9JA9bVH8KVfpWMWmx2xulWTMi9KEXZC3VU7GYikKH6vsE8fV/ijqQWeaAozLfIEk3KrLj6iU1kv1R7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545880; c=relaxed/simple;
	bh=zP4uQiqCW9FOgNkJK+jh8MivDZdBfu8XSnFXr2D8/pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKk3YyGg4MNduhgFQnxPuqVyyDAIt48VG6p4+b9phs+H2JhcGMktVLboLSyvrrz9erFP7ub+pUf7kQoGE798ht/gRlD/O/Q7XW0H5aQy5gkSuBm+2PuEN0QZ3yNOLFkIibLEEQgbamSMP9DRWbq4q7aDaCV8REVLz/VM2abTQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ckkvhyvr; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ckkvhyvr"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43d77f60944so547339f8f.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777545877; x=1778150677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXkCjDNNed+tdCztqK2sYupZhfXPPqZLJxXlVw3UrqI=;
        b=CkkvhyvrVnUrg91KQpGvXj35B+Kb5HlOnCdC3EKGtn/LX2tBPrjuVJyv6TQ3JD1tau
         eiQk99CaDmx54CqBNT6BFfzSrFOkr2VBHXHk1qcVzBecl0fx3YIFOA3JdY7gg+YemRuL
         UGZvN9gARDU4jT3/YOFC4hbFikLBVA88vtoSL84duOnKs5UvWqz0rW3qKjcLm4JSo452
         aGBZBzFQP7CU1lDiwsq+uvBV3ebhSFoxDM/K7wOvVKrhVL8aQab4TEO8mC1YTNJgNPhR
         CtoTpi9KqEOaoYFnjJcfYh2NWAPDbarnwGgvLwGm32lFzjO3dCY7AfW2UQWH/ZXToidR
         +e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777545877; x=1778150677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oXkCjDNNed+tdCztqK2sYupZhfXPPqZLJxXlVw3UrqI=;
        b=g0eIYuqcGFKvwxSV2aEQ4gDCoXYebq/80JFxiUtCDpUxOfr+YchkRvGAi+I1EdbX4O
         ensC9RrYdQcSHyr7BkJNcr3ORLVLKwrOL5VlUF+gH4lGXJAanxhVlWN8vMz3IyKOaA37
         nBdEm7EXlt3nLKjpokzcXnER45gWAIwTdcnaxsl1FIa4aP7sEWBAcDDIj/F4ulHICqOg
         eK7xdZhItb22IwRo01TmUZulgF7WPTi38UqwagceL1HCJyIlI9XDTQ3h4tbsWnrhfPjq
         OQEoXL+IE1soI6lDGDS5c6slXUUd6p5Uwu2LpoFfMOuKqq3fABY5wGAEEVMwoDoiWaac
         MexQ==
X-Forwarded-Encrypted: i=1; AFNElJ82q8vVhLLgfEnCUSsufPQCDGLPigefg+A7IjIWFnjsmMXd+KHeSbXuFM2CptB0TiByXLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1GwfnTrXjncwprK/1pDOF7STptcH60bcfOyaPJs0RG2p7em45
	EIjgsVwb7NGoeRZh0+CxrN6O0xR7hZV1SOAxNTfWyHVtPNxU+rYnQgnnXX5X/zsG4E0=
X-Gm-Gg: AeBDietA/qUol8H3tmKg8l3CKb9BE4LFwySBL41iuhihjlIuBK5oPHkke5zdNW9b2R6
	n5LqIHsa3j8cIAgcW7FXI26kzI/gJnnQzoJEd0JWJtyLEySTzWa2NeMJcfFEudDaSHh1JmkPx3P
	h53W1rsKfDQMG/Q8JHKa/O8t81+oZue/WRurEtt3s2sjfoD5lG3EldZlwcyylQDQdHfnO9WMJPc
	yjIUeC8caQvbz2lx4V16xlVZMlmNQJu4uVivhxHdwpb5pSMNy4uvyr4wPYzqu5CDP8kaIZ7zcYB
	6uSXN/JUwJ0s4a9t5FeuMVLgdMFL/prXEJGJNfWS7Tew5Si5i0t/h6EkMo3DSwQCA6gI7mTMRpM
	S+7+WFXglsj/jtdy91tZLrCOJHsBbs82+hFM2ZjK/5wXFN/93SbBeFRwTcA6isiSnJi+H1mBdqp
	asS8rkKs2LUfq2qopyeu40K+CWTBHYcYhNRw==
X-Received: by 2002:a05:6000:24c5:b0:43f:e452:f391 with SMTP id ffacd0b85a97d-4493cb42f83mr4018286f8f.6.1777545876542;
        Thu, 30 Apr 2026 03:44:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-448af0fa81esm7222907f8f.19.2026.04.30.03.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:44:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id DD4785F92A;
	Thu, 30 Apr 2026 11:44:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
	qemu-arm@nongnu.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 1/7] target/arm: teach arm_cpu_has_work about halting reasons
Date: Thu, 30 Apr 2026 11:44:28 +0100
Message-ID: <20260430104434.1482407-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430104434.1482407-1-alex.bennee@linaro.org>
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With the advent of WFE and WFI we need to pay closer attention to the
reason why the vCPU may be sleeping to figure out if we should wake
it up.

Create env->halt_reason to track this and then re-order the tests so
we:

  - ignore everything is the vCPU is powered off
  - wake up if the event_register is set and we were in a WFE
  - otherwise any IRQ event does wake the vCPU up.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - move arm_set_cpu_power_state to internals.h
  - drop excess brackets
---
 target/arm/cpu.h           | 16 +++++++++++++++
 target/arm/internals.h     | 11 +++++++++++
 target/arm/arm-powerctl.c  |  4 +++-
 target/arm/cpu.c           | 40 +++++++++++++++++++++++++++-----------
 target/arm/kvm.c           |  5 +++--
 target/arm/machine.c       |  2 +-
 target/arm/tcg/op_helper.c |  3 +++
 7 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index be14a47c357..357359011cb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -257,6 +257,19 @@ typedef enum ARMFPStatusFlavour {
 } ARMFPStatusFlavour;
 #define FPST_COUNT  10
 
+/**
+ * ARMHaltReason - the reason we have entered halt state
+ *
+ * To be able to correctly wake up via arm_cpu_has_work() we need to
+ * track the reason we went to sleep.
+ */
+typedef enum {
+    NOT_HALTED = 0,
+    HALT_PSCI,
+    HALT_WFI,
+    HALT_WFE
+} ARMHaltReason;
+
 typedef struct CPUArchState {
     /* Regs for current mode.  */
     uint32_t regs[16];
@@ -760,6 +773,9 @@ typedef struct CPUArchState {
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
 
+    /* Reason the CPU is halted */
+    ARMHaltReason halt_reason;
+
     /*
      * The event register is shared by all ARM profiles (A/R/M),
      * so it is stored in the top-level CPU state.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a632584a4e0..4a1ea5465d7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1997,4 +1997,15 @@ bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
                                        ARMCPRegMigToleranceType type);
 
 
+/**
+ * arm_set_cpu_power_state() - set power state synced with halt_reason
+ */
+static inline void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
+{
+    CPUARMState *env = &cpu->env;
+
+    cpu->power_state = state;
+    env->halt_reason = state == PSCI_OFF ? HALT_PSCI : NOT_HALTED;
+}
+
 #endif
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index a788376d1d3..4ca63a54443 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -78,6 +78,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
 
     /* Finally set the power status */
     assert(bql_locked());
+    target_cpu->env.halt_reason = NOT_HALTED;
     target_cpu->power_state = PSCI_ON;
 }
 
@@ -186,6 +187,7 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
 
     /* Finally set the power status */
     assert(bql_locked());
+    target_cpu->env.halt_reason = NOT_HALTED;
     target_cpu->power_state = PSCI_ON;
 }
 
@@ -239,7 +241,7 @@ static void arm_set_cpu_off_async_work(CPUState *target_cpu_state,
     ARMCPU *target_cpu = ARM_CPU(target_cpu_state);
 
     assert(bql_locked());
-    target_cpu->power_state = PSCI_OFF;
+    arm_set_cpu_power_state(target_cpu, PSCI_OFF);
     target_cpu_state->halted = 1;
     target_cpu_state->exception_index = EXCP_HLT;
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10feb639c4d..fb79981338c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -144,18 +144,36 @@ static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
 
-    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
-        if (cpu->env.event_register) {
-            return true;
-        }
+    /*
+     * Only another PSCI call can wake the CPU up in which case the
+     * power_state would be set by arm_set_cpu_on_and_reset_async_work()
+     */
+    if (cpu->power_state == PSCI_OFF) {
+        g_assert(cpu->env.halt_reason == HALT_PSCI);
+        return false;
+    }
+
+    /*
+     * A wake-up event should only wake us if we are halted on a WFE
+     */
+    if (cpu->env.halt_reason == HALT_WFE && cpu->env.event_register) {
+        cpu->env.halt_reason = NOT_HALTED;
+        return true;
+    }
+
+    /*
+     * Otherwise pretty much any IRQ would wake us up
+     */
+    if (cpu_test_interrupt(cs,
+                           CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
+                           | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
+                           | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
+                           | CPU_INTERRUPT_EXITTB)) {
+        cpu->env.halt_reason = NOT_HALTED;
+        return true;
     }
 
-    return (cpu->power_state != PSCI_OFF)
-        && cpu_test_interrupt(cs,
-               CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
-               | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
-               | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
-               | CPU_INTERRUPT_EXITTB);
+    return false;
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -326,7 +344,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.mvfr1;
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
-    cpu->power_state = cs->start_powered_off ? PSCI_OFF : PSCI_ON;
+    arm_set_cpu_power_state(cpu, cs->start_powered_off ? PSCI_OFF : PSCI_ON);
 
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
         /* 64 bit CPUs always start in 64 bit mode */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b88..c08e4797b32 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1143,11 +1143,12 @@ static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
     if (cap_has_mp_state) {
         struct kvm_mp_state mp_state;
         int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
+        ARMPSCIState state;
         if (ret) {
             return ret;
         }
-        cpu->power_state = (mp_state.mp_state == KVM_MP_STATE_STOPPED) ?
-            PSCI_OFF : PSCI_ON;
+        state = (mp_state.mp_state == KVM_MP_STATE_STOPPED) ? PSCI_OFF : PSCI_ON;
+        arm_set_cpu_power_state(cpu, state);
     }
     return 0;
 }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 8dc766d3225..dbd39e7ba76 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -916,7 +916,7 @@ static int get_power(QEMUFile *f, void *opaque, size_t size,
 {
     ARMCPU *cpu = opaque;
     bool powered_off = qemu_get_byte(f);
-    cpu->power_state = powered_off ? PSCI_OFF : PSCI_ON;
+    arm_set_cpu_power_state(cpu, powered_off ? PSCI_OFF : PSCI_ON);
     return 0;
 }
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index e8f0996ed39..504526153a6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -402,6 +402,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
                         target_el);
     }
 
+    env->halt_reason = HALT_WFI;
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -463,6 +464,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
     } else {
         timer_mod(cpu->wfxt_timer, nexttick);
     }
+    env->halt_reason = HALT_WFI;
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -507,6 +509,7 @@ void HELPER(wfe)(CPUARMState *env)
             return;
         }
 
+        env->halt_reason = HALT_WFE;
         cs->exception_index = EXCP_HLT;
         cs->halted = 1;
         cpu_loop_exit(cs);
-- 
2.47.3

