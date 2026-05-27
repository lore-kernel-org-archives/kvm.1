Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119A3FCB2A
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882211; cv=none; b=jMmuWIzh8MOeJjUdDNYu/k8NAG6TbV9WrrYoTlJz6K3yuVT102GKOlgEplRm7Z/R+6g21GzUFI9E8mECyRxr6irBWGqYlREGbe5EpcZQtb/xbTVghXP/R3+ivnwIS+gWHhvDTjaywmVy25g4JQrfBDNBw9GcOZJeU9Q/3aLcQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882211; c=relaxed/simple;
	bh=YpuU8KjEe8F7QZ8KdfwitKo9HdA3jV1moysWB8yYDuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGe2+Jn0HAM1Q9lzSNWaA2zAJpUzTU9kNCOlKhNkTA+Vp9g3pr3Oy+9vC5wNKnoRhuxpy1bS6CixVWK+4udoqjCLBGV9xS8FC+a3JO05XYmjJM5oukV4ERTy3RSd+LRYmh6p/WagUuknLBHALw6z4qdYLPRo4A09xkghTArFwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AYiCFmDg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYiCFmDg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so67614575e9.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779882205; x=1780487005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usmkTmoNt7MujhX2fIpEqD99hA9+jgSr5Arc9FH3Q5g=;
        b=AYiCFmDgb/WkBi/35VMFHJUeCj6IDJJN/MjFfPKUTYDgZvO9UWHRSvh4dnJmEXJpcg
         PcWy95P0+ahGS97VpB9CUObxU4/FTQqj4FMqhmjpbX1fFSuH7/CvUejiCjnDx/wBk3zF
         HC6e/PjQ4y8O6mhX3bl2XZmrquic5MRoFMI2Ko02MxuY43zYVBvd/Ox5Rey87L56CNrT
         tCGw6ODo1druurrF9Q6FxWldD8pbz9tBuBDxqWmkAYxpDEbzB4vae+sTs+7xbwWuYND2
         pAtLEDY//eOCoOGMAA/uQaF9ZUSznsBlNbMKxdQndQr0GPLlUFQbxD+nNaJSpIfCKFSO
         uMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779882205; x=1780487005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=usmkTmoNt7MujhX2fIpEqD99hA9+jgSr5Arc9FH3Q5g=;
        b=XlW9KTiNuk1cC47pF4ZmwAX/LynBl5r8pUQIFJSq9HMcnhTbZZLIxUqMYEVJCPaEL6
         +mC9aS3gYcGEyLdZ3pUzdOcOYb0g+fpAAnyS0IJX/YRLVhPRMjTlIJa6MBjZJ4w7DARc
         t3fipOQdsj99UlplyVpcRrT1UCZWNc3bnigdSNLYzMfA0aSocYFDmTRZQbOrf4ZY2w3o
         +vOpJZx4p+YH7BCgGrm2Qp1sbAxm+ZmQnlpa+dB/5w/AgkcBr4wbBtNoqeKkXxNvCjeM
         kQnJsEyNA4GevEWQ1KUsvEo3hAHek+rsLuSVD2nN6NZciJd4DDTI/fdM5n4JslZgD8aA
         aA6Q==
X-Forwarded-Encrypted: i=1; AFNElJ94aE66WMZGYuQm0gZPdrK0SXV+vGtb34jz0lghqNBYDLkLs+U3eDBl8U6RGt6ScdD42V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdts3PsyjWTuUrN9Y3+m7bu0MMiKfwzXnAn49ZuheXROCCk/Kc
	VeCBM2GIcNrqK2X0qYasVmU+MbV4PA2u0cvl/pi0ErNo1OC8sTFMtpzE/Yaa7SxCx7g=
X-Gm-Gg: Acq92OF6FedGAH55i3bCja7Oo5N2AQ78V38dDTVBUXNc/0An34496dQrWaAY7qxFjh4
	LhZ0lnD4rETTrrQqZM/kTAasHGOVjYWLxUQXvfoEY2X2giDgT5YaZiaMIb1D8+kt9zJwyF4JMWl
	3/KyYuuNEIYyIQBUe0+3V5xtCzYaibSCcSTxXOl1huxFVs7o5N2W24hpySDjI7u8cihTTtQiC20
	5K6j9brNkdcvyw2Us0eyT0iL20jv29DO+YEnfNosrPYHL/0F6NjnZU+eMnPYrARYRiSLqHi+7sp
	qvsy+ci7zyczInyzTObNL2se+2F34J9qgnV15txBCWyAyJd28rHi+yVdUiOdMf8EMpIgXdPZhxf
	0KMdar4otBJtQ06JnVk/Jh5ge04u2rwEbb9jlPSrJEjtQkcYA1sKqBYWlBYrlx3ol8CBPnovFf8
	gcXMZi8a9OeWBm0RJ8GEjRJdzCVhZAec9hIg==
X-Received: by 2002:a05:600c:5298:b0:48f:e230:2a26 with SMTP id 5b1f17b1804b1-490428e16bamr379652715e9.33.1779882205137;
        Wed, 27 May 2026 04:43:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908098f8c8sm15238135e9.15.2026.05.27.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 0CF8A5FB8B;
	Wed, 27 May 2026 12:43:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 2/8] target/arm: teach arm_cpu_has_work about halting reasons
Date: Wed, 27 May 2026 12:43:14 +0100
Message-ID: <20260527114320.1581552-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527114320.1581552-1-alex.bennee@linaro.org>
References: <20260527114320.1581552-1-alex.bennee@linaro.org>
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
index 15a13b92927..85f2c25f476 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -260,6 +260,19 @@ typedef enum ARMFPStatusFlavour {
 /* Architecturally there are 128 PPIs in a GICv5 */
 #define GICV5_NUM_PPIS 128
 
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
@@ -781,6 +794,9 @@ typedef struct CPUArchState {
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
 
+    /* Reason the CPU is halted */
+    ARMHaltReason halt_reason;
+
     /*
      * The event register is shared by all ARM profiles (A/R/M),
      * so it is stored in the top-level CPU state.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 00830b17248..7deaf1ab6de 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2010,4 +2010,15 @@ bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
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
index c47b70ac694..8bed5214eed 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -145,18 +145,36 @@ static bool arm_cpu_has_work(CPUState *cs)
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
 
@@ -327,7 +345,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.mvfr1;
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
-    cpu->power_state = cs->start_powered_off ? PSCI_OFF : PSCI_ON;
+    arm_set_cpu_power_state(cpu, cs->start_powered_off ? PSCI_OFF : PSCI_ON);
 
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
         /* 64 bit CPUs always start in 64 bit mode */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7d194ea112b..a54ef51ec2a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1149,11 +1149,12 @@ static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
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

