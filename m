Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A033EAEC
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980021; cv=none; b=a7b6VdIRVNSF8udM93jlbDUh+4PaniQWcHWI431NU8dXjIanJAvjFYHOqGIG+kl6TN5VDnQgGBB1cBMW7rf4N9JsOy50rAAYVZHPGZIhVWU3du5w2xrBa1b+x1y0Vp7falIUAZD+8EuzIoWNoqnE0zbJHOWH+WsG1VkRbB/nv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980021; c=relaxed/simple;
	bh=eZjeF/JrB/30U5D5cBP2vYNLiOgE3qU8JE/X7+IwAnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+BDVo25Wzk+QIEtWspI5IDHwkEPs721ZGLwPvD0nfI4CqnoqeGVJEv84FmxgAKPwr5H4hGgbbURAJT5GyDLGxixnWgHdyHr+vJ/gUYOskutlwGmyGi15jaNpB5R090Z0r7txHynvVGI7qofTu7ikEeVfFiIbd5c7UDpIBjTWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bL+Vb+ky; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bL+Vb+ky"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d146705b4so10031435e9.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777980017; x=1778584817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJazhEDPgKRcDHmZKYIM+jso6J9Jwwost9U+BImJW8o=;
        b=bL+Vb+ky7SHcfjNRaPeAU1PaMovJtxy7XjtVsLB5YVCVf7+P92VN7BseJ6AVlmPak+
         KZOJ72e51TMv//qyHTLg3VG2o9NTHSCONfIzTDYDk6L3QSPDxKySZRbne/BW45Mpi2LC
         /ZwbmW9IdePT/kc7ledPwSWm+RoNPD8kxXz6MyFtFpIMgogAKI9eA8ewnn7gy2P3j5bW
         d1dFZNDP9S2D8IxHMwZknmgE9f8EmX+OiJ8oY0FucyQE7iXO/iLUXG7DZn8Rnkao+y8n
         OfW1apmGNlmHR0bIiCFfys+IT2SCE2bV0Ba/9yuDxUI0UNfuFkcTm1xEUkltw/IqhIbZ
         exLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777980017; x=1778584817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DJazhEDPgKRcDHmZKYIM+jso6J9Jwwost9U+BImJW8o=;
        b=CPaqPAsuCziHN1skkKeZT90VgFP7g1b+SBnPu6b24xvxGxsQ2cegyROVQZSXIMmDXx
         Z+mjRV21Ebrh/jG2VvUQcaoWmJLV1oW1m0S+y6vaIkJ/lkyZfL/M6b2e3OcBnXbwvtzL
         PthfdSBYaG/AOOiOK4593g63uUJK5Wyxn4MzGsghMYmfxMmCX38qUNRXaDWFxCOy1BPB
         /JlcdUA459SPcgYQfkwSoPrr6onFhyChm+igypqwk3YKA4KCOV1ZLrP2BrNbLNWepYcm
         WgyvW+6dsiRFn5/qpfESXMrb6IUHVyrYvbbIN6fzBYXvPfuXGv0UqTw1LCw7X317jtnW
         mVew==
X-Forwarded-Encrypted: i=1; AFNElJ+tdT5U+hVkKwLmtLlAI1Q7ZzLzHf2tZX0IKwPLRAVrZWFvNnBgu4aYDlTVzvdUDj0Bm/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw3cohyVdgdhffzq4mJoYblBd74/RAOiNaiyT4yJbCVi0iEpU2
	H4FNIOL23oGwlkNNOnmxpEZwJkQUGOwL24tuwRUeOgKUW9evnHOSjX/Cx4JtjOwEC+g=
X-Gm-Gg: AeBDies7JNIXQWUG+uazzU9vZni25oEE54QBBP+FCxBjTImg+eurrIZGRh8ysqSY4Vq
	Iz3BeFhtovqbiQ08I0X36AbMe2ejTMAg1do/E2XIMcMzCqbpsjGSFtXc+wrDAZS9QvU9De38KiR
	cigk3GQlIU5TxqtBa37MOjSLGySEP1HRKdFUbSvHsbEFLPwLjQ06PkIXNW17d4JAr71sYm7OXSA
	y4dY2c3lY4wNmyXZ4OZz0n2ELGUujTSJX9y/8KL3dG5LqBEEXLi7eXsiSt4jqfHYxjLWGm60+3Y
	xMEyKydpBloih8J/3uReUJcjVOz4Si0IIts8Dfl30zM6LbqVXda5e/M+hoZ7/oa4J32Uia+LrJP
	jC3Q/QnsLepeXFRQlie9NjD6Ayf6BNSPBkMKEnVR/athaQtA+tI0tGdFtBantjC5OiA74QUui/X
	ra8UGLDM4gZB2TVkdNy9RskHF3gWyy5FRVmg==
X-Received: by 2002:a05:600c:810a:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48d18be5ab5mr41738105e9.17.1777980016924;
        Tue, 05 May 2026 04:20:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17ff41a0sm15578735e9.20.2026.05.05.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:20:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 6856F5F913;
	Tue, 05 May 2026 12:20:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 1/7] target/arm: teach arm_cpu_has_work about halting reasons
Date: Tue,  5 May 2026 12:20:07 +0100
Message-ID: <20260505112014.102993-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505112014.102993-1-alex.bennee@linaro.org>
References: <20260505112014.102993-1-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - move arm_set_cpu_power_state to internals.h
  - drop excess brackets
v5
  - more arm_set_cpu_power_state cases
---
 target/arm/cpu.h           | 16 +++++++++++++++
 target/arm/internals.h     | 11 +++++++++++
 target/arm/arm-powerctl.c  |  6 +++---
 target/arm/cpu.c           | 40 +++++++++++++++++++++++++++-----------
 target/arm/kvm.c           |  5 +++--
 target/arm/machine.c       |  2 +-
 target/arm/tcg/op_helper.c |  3 +++
 7 files changed, 66 insertions(+), 17 deletions(-)

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
index a788376d1d3..a06be5cc997 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -78,7 +78,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
 
     /* Finally set the power status */
     assert(bql_locked());
-    target_cpu->power_state = PSCI_ON;
+    arm_set_cpu_power_state(target_cpu, PSCI_ON);
 }
 
 int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
@@ -186,7 +186,7 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
 
     /* Finally set the power status */
     assert(bql_locked());
-    target_cpu->power_state = PSCI_ON;
+    arm_set_cpu_power_state(target_cpu, PSCI_ON);
 }
 
 int arm_set_cpu_on_and_reset(uint64_t cpuid)
@@ -239,7 +239,7 @@ static void arm_set_cpu_off_async_work(CPUState *target_cpu_state,
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

