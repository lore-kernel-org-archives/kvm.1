Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB93EC2F6
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862390; cv=none; b=pvBo+f0+obrt7EPJEiZN5su+K8rBX0REau91h5AyMhgvnPNRDxQeN/Bj1V5JH7dH/ml1/AZFbLwpguKCjpb4dEsb39DVvQrynNS86WDP6cdcm4Jq0SZMka3UHJJFG/Qh+8XLOzaEvAFl2/dOp0r+9AvzkDIG3p/8553Hl1NjYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862390; c=relaxed/simple;
	bh=dAebQ6ZDDatNzL+6vwaqtuO7483PVvyMvhFQdmkviAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgD4qKe8jF7vQ+g5fiGzv/DPV/dISCmPH7F66JpEex6tj4iprGMMu+TZ5DLC7LhujwCuoNV3aLVi7ujI3/36zIJyjKKwxbK7SrvDYuPfSEn/pOSER/1vBpTVE+3/HAVye6+9bL/qQsObzqLq+R9vDDigWuTu6qvWNBnbjNw1eoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wpFm4Pg3; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpFm4Pg3"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43cfbd17589so4297285f8f.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862387; x=1777467187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/Ygp/F48dZ3RysrI6Uw/aAqnHQSpp+gk0lyGlg/T44=;
        b=wpFm4Pg3rPvT6nZh8eg+WMUQnQDs/ssTIRpDYNhHGFYnnIpLJ4F30XPDqJdgFNB5kK
         1yVeQMWRdpHOBABta4hWyGhWlfaJQUbtXScPR43QrAAWuKhUq25gy8e3qoNHHEwjZkbS
         3V/A0D1Z7jAGz/5M3EX5FTz+H7Okm5xo/XkSVng2ZgsZgK3pKPg8NljIIRsXXCS36KOb
         352ZcU5ynzsSbqoqTNrF/hl4jeYSytnircTCupMStfMXJS4x0ZJ5LPKMlTlBGOOP6UJC
         ywS4hyxldURFy3Ga4wYFf2k6XVEHMUxcM3632oOb+agPzX1JrlapOVIDrGAlpd9cxckr
         tneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862387; x=1777467187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/Ygp/F48dZ3RysrI6Uw/aAqnHQSpp+gk0lyGlg/T44=;
        b=PVMwuXVkDxeYFMcZhuqeKLtDCep5rKFkwHVoRtiDsiCx2t3nuLrnQ1ibTnFUwj26Ez
         1pOFaV6qv01ySaGhfNE6nY3FhFnTpOavi51LmnqYXhjktt2nXZDJChHvnXxdEFBLUyTu
         7nUjh9OXfnfL0Uli/KFuauGE5wYJ0Gaf+v7m5QALHMWH1Jcq0DOYE43XaWzC+dLU4Sci
         cPqyOxnSXfZP/42/GcuhFB1wHGzey2WXoqVs1AhMTfohTkGQFkVX+s6pZsJLTh/Is8xU
         u5ccd175CHurjqpk6S3o/utaHnoi2MtAqVaJzF6eJ1MVaVBLiH91rpiXUqw/bi9iQa/G
         XsnA==
X-Forwarded-Encrypted: i=1; AFNElJ/MfPmb001ehAk9B5FjFQvcjdCSFS6p58798QobW+fv0IEAhO1oKhlWmEpr1W8G7vpvfGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrM9rEMkAHljqrIM0CFrAU27eDTY3phsIOhr1QChl9/PLYwu6C
	SiRbruG5LdMHF9D6f0vc6FGaTzaPdjOY/johayfdTPJPURNHDl94FcQuLZzm1z+j06Q=
X-Gm-Gg: AeBDiev5y0Q40xbeqJGfrBtJJDiogcfGpywalWaVwNMdKlwEdSsjljUdO5yVA0/YBxG
	L0xku2L4Rc2ymAA7BHYDaElGiUJ77ToNhSiXpfe6KU48A3ypu/PL+c93HvWBHepbodb01WMQG0l
	oqGPzLTJ2/4rLXIFfPJblJCkn1MhVnrpnBTkPbQvVT+nLIu+Z41K0eKd4kVCyVY/Rfp5P4OcIaX
	JtxMsOu+pxOcjqimSvPgCVDa6NzqAGAl1bTVt/ZH/lz1ECShZrDXGd+F7AuVLbivmssV7h4PzeI
	bxJc01UVa6HE6iXF7f2NHKrLhdHLDM0KVSsDLbOiZjl5EnhLFabaaoXoI1479JxsSDiLVHwkhfv
	9bo3lH4tjg6A1F3Z46rMSypnvL1pBToywAUwQnogb9SNAMhW7fY79i4UpCkjj0zaZQ/iYxJ14OJ
	+dOuT8cAPI0L6YLXE4hMQ29MsnXvEI6a5dGQ==
X-Received: by 2002:adf:fcc9:0:b0:43f:e4f1:bd9b with SMTP id ffacd0b85a97d-43fe4f1bdf7mr22720056f8f.30.1776862386869;
        Wed, 22 Apr 2026 05:53:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm45215207f8f.16.2026.04.22.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id E34FB614FF;
	Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 24/32] target/arm: teach arm_cpu_has_work about halting reasons
Date: Wed, 22 Apr 2026 13:52:41 +0100
Message-ID: <20260422125250.1303100-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
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
 target/arm/cpu.h           | 27 +++++++++++++++++++++++++
 target/arm/arm-powerctl.c  |  4 +++-
 target/arm/cpu.c           | 40 +++++++++++++++++++++++++++-----------
 target/arm/kvm.c           |  5 +++--
 target/arm/machine.c       |  2 +-
 target/arm/tcg/op_helper.c |  3 +++
 6 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20b..98cdfa6f130 100644
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
@@ -1691,6 +1707,17 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #endif
 }
 
+/**
+ * arm_set_cpu_power_state() - set power state synced with halt_reason
+ */
+static inline void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
+{
+    CPUARMState *env = &cpu->env;
+
+    cpu->power_state = state;
+    env->halt_reason = (state == PSCI_OFF) ? HALT_PSCI : NOT_HALTED;
+}
+
 #define HCR_VM        (1ULL << 0)
 #define HCR_SWIO      (1ULL << 1)
 #define HCR_PTW       (1ULL << 2)
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
index ccc47c8a9ad..124be8c401e 100644
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
 
@@ -250,7 +268,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
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
index b0e499515cf..62401c5a3ea 100644
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
index 652611b4313..46c745077d5 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -403,6 +403,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
                         target_el);
     }
 
+    env->halt_reason = HALT_WFI;
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -464,6 +465,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
     } else {
         timer_mod(cpu->wfxt_timer, nexttick);
     }
+    env->halt_reason = HALT_WFI;
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -508,6 +510,7 @@ void HELPER(wfe)(CPUARMState *env)
             return;
         }
 
+        env->halt_reason = HALT_WFE;
         cs->exception_index = EXCP_HLT;
         cs->halted = 1;
         cpu_loop_exit(cs);
-- 
2.47.3

