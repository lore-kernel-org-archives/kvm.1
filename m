Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9D3AFD01
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043393; cv=none; b=IsH262g3OXR8yi4fwC/b8OztUZEZuGklYAANqae921OQE37AIcpAO6mBrfmrQ3Ju7MrDYfHK3J34qxlLHO09brVZxxpH0xBMZDR1UEoBj4BN/FLPPxujCWe+qnu+UDgM/uAOcUQXiL/NlfR14ZklNskEBA+AE/4MZFUHS28SM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043393; c=relaxed/simple;
	bh=5IoayQHePeYXPgqvgUZg9BKpjkZhg9s7zTCEENDpL5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJvwxJjzqSvoI7LIsnYpFVNbgJXiVI6JZb23tx8dyzjQPKW4Bmu2tglJpRCE+5/LQ+LD8szeE0ClSJyuKEwsgddeBUKrjgAVQzxkV/zsWWWgEmPR2KjJYZ7NdttU1Pc/gCbemljX038yvYq40M7P2Ovv87HfSon+t05/hSMUzII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yW5Q2Vhl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yW5Q2Vhl"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49048e043e5so58566435e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780043390; x=1780648190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZKUB+wKUb0aYLSeMPcEAHuuX6sOf6z7ImGaMMZVjj8=;
        b=yW5Q2VhlEkfzXzUXSDb/wYaMbplQZs38xy5e8uGgCIsZjBN0kezvo4LwnbtbwR8R5q
         rZvFWxkgy/7ZZHiqpxt2mqtDFUMPGHJ+xF9GXSHmbdOB4bm1luDZy1I2BsJXuE2hH3dd
         hJps4NCCchddmGQvAJjJO6baPGk/qqDsplDQrF7XeiBhDq4kV8tIfyTYVWO8BsQD3/0g
         xhhNPEipxH8FpJsdBTgl2FjLzDauxwGKrnDHWam4QfKUNIFiv9DOp8xYQh2bYE+sqhQ0
         FkP051YrOdYE19FpweB8YIGDoWhjoRs/5D1cIsGlHNaxzBkVZkkhZ+dhEpbk7kNWHgRD
         ytxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043390; x=1780648190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZKUB+wKUb0aYLSeMPcEAHuuX6sOf6z7ImGaMMZVjj8=;
        b=qAbdH69NqnjmLOYgEIUIRoorCiLbBpGmFTtSxTQCWVGktzokrIe3cYpMttvaupbJls
         rLfsnyzHJSI1CzzOpSa5s0NRAKhyb528OWr2UN0sNg0aU26VWTnznQ/wLbckURb8rvGw
         WfGtbQiTQM8rqtxx85CC6mVyaXOzqHYXKfi/8sogA3e3I88t0ANzLoYq0Dr9ybbHWYX4
         n8WrSjagbyp5XDeiCcyglbOoNjqGjJePJgz7t0NiYUcqQ5iieBTAkGnszaS1INAmmsua
         ZQWs/4+Pms+jR7NGaTX+u0aEPsRmDrOBmwpznxgt9c1LkdLr9j+PbUoNajpX4idfI+rN
         +KvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9wmiArvgFCHCJ2/y85pgx40mU699APo4XmJIn2DmAR1YNiiuj26H172MvH+YvQ+7Kvew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Bo1m8fIqKwLrMV2UCy0bnRsZd3rYh6WcBswGRwPTjC0LowjL
	iQs15K7ZVpTNGmUBysKlZAOk0ns5xFrsiyHZTxSchCTSgmgu0blLewPNwZmJwE4K4qc=
X-Gm-Gg: Acq92OHo+5gP2VChwa2s40CknLacekFtiukY8wvzaaqMeR7n3NwTBSYBVEA2ZRkO07c
	iR3MMWQxPAPjcmda/D6T87HMcq8w5pD8RjkV/ZwX59XIw8I3vNFHAuBXqsM5rpBb/D8MNYBT5na
	NNR3rDlpbX97+Aqqa5v18IBiDhVbxpCPPBXxPj2oc9QGt4Xoi5NWlXTwK9otnxxjpXUR4brsKbb
	da1s1uixgsQOR7Yu5EpJibUtr9BNLzIJNuaT7nic2o583VChSGrX8QVfMjAuOddVzUrn0q5l7Xf
	2awkm2w5V21nfl5/fL3WrPKPcf4Z5YJl0rtTucQ21jpaU2a0dM2K/nz1gs94qSEzkvbcIskHywK
	s5GwCtwFN4ubhH0f4btKaD1p73anhuF+kMVnHlDdclMhLfGQFKo4P51fIVdxiRYVjD8muZpiSfP
	9KD2jjwmwCkgLZHT95S8+ucGXgYybUIacTIw==
X-Received: by 2002:a05:600d:848a:b0:490:60cb:55f0 with SMTP id 5b1f17b1804b1-4909c0aa2c7mr22086495e9.21.1780043390221;
        Fri, 29 May 2026 01:29:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68a925sm37842375e9.2.2026.05.29.01.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:29:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 562B8602BD;
	Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 2/8] target/arm: teach arm_cpu_has_work about halting reasons
Date: Fri, 29 May 2026 09:29:41 +0100
Message-ID: <20260529082948.363931-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
References: <20260529082948.363931-1-alex.bennee@linaro.org>
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
index 85552b573c4..dfc369b5844 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -224,6 +224,19 @@ typedef enum ARMFPStatusFlavour {
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
@@ -746,6 +759,9 @@ typedef struct CPUArchState {
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
 
+    /* Reason the CPU is halted */
+    ARMHaltReason halt_reason;
+
     /*
      * The event register is shared by all ARM profiles (A/R/M),
      * so it is stored in the top-level CPU state.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ae5afc5362e..fb9df50da29 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2027,4 +2027,15 @@ bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
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
index a13e6dae2a2..8771b695d9d 100644
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
index 58f8dfd53c8..fde3b3e8d75 100644
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

