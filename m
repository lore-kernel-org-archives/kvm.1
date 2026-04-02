Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED333D6478
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149511; cv=none; b=nZoZaSa81CGXWLJUhU6vcWGtmje9SZ85qLB3QqSGTizD1taIO0A9mBbFKNx/s79SJyxoONXi4VJOYW5mrmpZnGFCkSdpWe2gZMi+ZslUuE7yjxQBf7nKVqFFRZfl0B54CHFym5fKZYGcxRe7Cj/xSoH6xYGPZA/dr4uTydQD71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149511; c=relaxed/simple;
	bh=ntbcCkQzxefj6KuNZPpZSfQk1jGKN1Ue4WocuW/9LR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jj9gUMnTigxJkRFjUKYrkIdnWZxAJVUMVJ3ZcP5KS+iMZA58+lFvyNydKeq40DtGGsNpKWrBf2PPhIzER1H/oHDq/9wU298rM0ys6Pl+x5xUNvc3mELrQmrSqVQdS1haZyglvTZAaPDFxVPUH2lnaGP+Q+UmHjBJ7LPWAJw+2qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u6sgdwaw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6sgdwaw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso10441715e9.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775149500; x=1775754300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrVl5JuVN8G6WWTaySq76RqbM4pMpv5bVR911pKLKsw=;
        b=u6sgdwawVBj41BgSK4Fo0xpdVca69mjWWShp0eyjENkFQSEw8d+KGEp7vDRLOGKII6
         vQ3SEjJUZa482xbTOYls9R+xPLw8d3CXVhVFN/wkMPkjvoyjXXICfLPglB9AEK580KGo
         jK4ufWTG21bs7F2703rY8df0PtWAytZLFWtFgHX4EUYIvBTOWWin38xz6bOYO/BCfior
         CiU58zgY3nXhB0dSOVG0N/7wvieikMxvbujLpwapN3sJo07PGsXGSmckZFK8mStChyL5
         kT/kkQQh61niH2WnKxU1zImCAYW+KwYZAhiRMM6bSozqXXS5/A9tnKdV6shLXPJbYhrt
         qq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149500; x=1775754300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JrVl5JuVN8G6WWTaySq76RqbM4pMpv5bVR911pKLKsw=;
        b=iVRAhROWk87CUsTsFAxl8xhfvonzF12y308DMb4mvkQ0wYwXyUthzM3A23iByEX6fn
         yZJ6ja9ZruA2hQIsyA/vyruugq2zZk4/0FlLUFxLeT1fHkQS9WLZI3ObaWDvlOrUAVJh
         qNhQPZQJNHJdM1SubCqPkYorIMpKqBR+Elf8d0fZO+FLXDcW9bKUnDkj1l6dRij/4fPJ
         UFYMUlnMM+ootkOQ9QA/kVMZ0gHLVEFbU9a3dfngG8Whdc8Tmq/Bp35a6ZTgxrNT3tfC
         lQ/BrnWuL+dmyJyfT7KGCF0PmpzNzpUHCAT91WeKFMRLcN5bH/nz9HBSNB1jO2X20j1G
         2SBg==
X-Gm-Message-State: AOJu0YwDWE1hbgSJvYpwt6UNLOrsykan9Wsi4mbCHO+0RJg3bF8pMAtU
	2tszjoprmn6+ROe+mbwYYh1vYaZm7Dn9Fd9PMiXkcZ6QQM/uvhiHUP16vBsyrLUyGKg=
X-Gm-Gg: ATEYQzxrucbTH0+IJt4KLw19BwRnEuHSCjbyL+GcyxERoyyQ74+LaKeTpKX9EVAQIKT
	CLkt0zH858qF1vaNak3nE0vVL+V9Q3m9dlP5kTyo5dIJWpoR9lhdSrpBin6t/Gs6TeQnu8DQHSO
	V8jWe3zfqkX1/9woeHJBLs9RBlpha4TuWxFTISGDzfqSiWmBX0Mw/yCPr0MGVs8ikXTBk3TsEUF
	e/Ew62womAl6B4FteVlLvc7dWT5oiUd5oa0C/bl/rEhnGMwNG4yZVgV9z7xonfADsW9B9FZ+Ftk
	XzHhJVWavQaDcuWyrR5AElph8VKQgv/7wYSQs9F7GvVM+ryywUIWtI8h0z3MON+7Npz0R/bN8Z3
	isrywyhNQpFvrwesdEAKbK1l+u/uX9dWrX6WK2Lq836U/6Q7sef3InAKTF+BKjv/NySKSUCpVbi
	022ElsOvwiILdsQwL7NvjzXMzdZUx+unLVUvcgioe2r2DIPvrlez/2ymG2Sm3TWQxwVaOGBa9sg
	+xsaOwogXM=
X-Received: by 2002:a05:600c:19d0:b0:485:45fb:3472 with SMTP id 5b1f17b1804b1-48883562172mr131175635e9.7.1775149499446;
        Thu, 02 Apr 2026 10:04:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488980e3b55sm562915e9.8.2026.04.02.10.04.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 10:04:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	Anton Johansson <anjo@rev.ng>,
	qemu-s390x@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Song Gao <gaosong@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-11.1 v2 3/9] accel/kvm: Remove TARGET_KVM_HAVE_GUEST_DEBUG
Date: Thu,  2 Apr 2026 19:04:28 +0200
Message-ID: <20260402170434.94783-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All targets except MIPS have TARGET_KVM_HAVE_GUEST_DEBUG=y.
Declare the kvm_update_guest_debug() stub to MIPS and have
TARGET_KVM_HAVE_GUEST_DEBUG be the default.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 configs/targets/aarch64-softmmu.mak     |  1 -
 configs/targets/i386-softmmu.mak        |  1 -
 configs/targets/loongarch64-softmmu.mak |  1 -
 configs/targets/ppc-softmmu.mak         |  1 -
 configs/targets/ppc64-softmmu.mak       |  1 -
 configs/targets/riscv64-softmmu.mak     |  1 -
 configs/targets/s390x-softmmu.mak       |  1 -
 configs/targets/x86_64-softmmu.mak      |  1 -
 include/system/kvm.h                    |  7 -------
 include/system/kvm_int.h                |  2 --
 accel/kvm/kvm-accel-ops.c               |  4 ----
 accel/kvm/kvm-all.c                     | 13 ++-----------
 target/mips/kvm.c                       |  5 +++++
 13 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index d34aead41c4..6f60ca6505c 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml aarch64-pauth.xml aarch64-sme2.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 38a8f85201f..2eef68dc55e 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=i386
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= i386-32bit.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index 476407f9413..7e0b1ab5d05 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= loongarch-base32.xml loongarch-base64.xml loongarch-fpu.xml loongarch-lsx.xml loongarch-lasx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 867898bd47c..c47887f8992 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=ppc
 TARGET_BIG_ENDIAN=y
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= power-core.xml power-fpu.xml power-altivec.xml power-spe.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 10d7a2681e7..8c6dc84b821 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_BIG_ENDIAN=y
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 5059c550480..e0d2c7032d6 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index e273075f1a9..699e5ced96f 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=s390x
 TARGET_BIG_ENDIAN=y
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index c7f8746b4f5..491173df466 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/include/system/kvm.h b/include/system/kvm.h
index b5763a562d7..9b722ad931a 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -237,14 +237,7 @@ void kvm_irqchip_change_notify(void);
  * calling down to kvm_arch_update_guest_debug after the generic
  * fields have been set.
  */
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
-#else
-static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
-{
-    return -EINVAL;
-}
-#endif
 
 /* internal API */
 
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938d..9d1d3fd3deb 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -113,9 +113,7 @@ struct KVMState
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
     bool coalesced_flush_in_progress;
     int vcpu_events;
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
-#endif
     int max_nested_state_len;
     int kvm_shadow_mem;
     bool kernel_irqchip_allowed;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6d9140e549f..d4af6b416c3 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -85,12 +85,10 @@ static bool kvm_cpus_are_resettable(void)
     return !kvm_enabled() || !kvm_state->guest_state_protected;
 }
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 static int kvm_update_guest_debug_ops(CPUState *cpu)
 {
     return kvm_update_guest_debug(cpu, 0);
 }
-#endif
 
 static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
@@ -105,13 +103,11 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
     ops->handle_interrupt = generic_handle_interrupt;
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
     ops->supports_guest_debug = kvm_supports_guest_debug;
     ops->insert_breakpoint = kvm_insert_breakpoint;
     ops->remove_breakpoint = kvm_remove_breakpoint;
     ops->remove_all_breakpoints = kvm_remove_all_breakpoints;
-#endif
 }
 
 static const TypeInfo kvm_accel_ops_type = {
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5df3fb90d88..91724b54cdf 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2920,9 +2920,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     s->sigmask_len = 8;
     accel_blocker_init();
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_INIT(&s->kvm_sw_breakpoints);
-#endif
     QLIST_INIT(&s->kvm_parked_vcpus);
     s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
     if (s->fd == -1) {
@@ -3033,23 +3031,19 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_vm_attributes_allowed =
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     kvm_has_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
-#endif
 
     kvm_sstep_flags = 0;
     if (kvm_has_guest_debug) {
-        kvm_sstep_flags = SSTEP_ENABLE;
-
-#if defined TARGET_KVM_HAVE_GUEST_DEBUG
         int guest_debug_flags =
             kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
 
+        kvm_sstep_flags = SSTEP_ENABLE;
+
         if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
             kvm_sstep_flags |= SSTEP_NOIRQ;
         }
-#endif
     }
 
     kvm_state = s;
@@ -3782,7 +3776,6 @@ bool kvm_arm_supports_user_irq(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
 }
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct kvm_sw_breakpoint *bp;
@@ -3942,8 +3935,6 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
-#endif /* !TARGET_KVM_HAVE_GUEST_DEBUG */
-
 static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
 {
     KVMState *s = kvm_state;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index a85e162409c..49bff68b137 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1262,6 +1262,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     abort();
 }
 
+int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
+{
+    return -EINVAL;
+}
+
 int kvm_arch_get_default_type(MachineState *machine)
 {
 #if defined(KVM_CAP_MIPS_VZ)
-- 
2.53.0

