Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091C332610
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084272; cv=none; b=lea9eRReARNP813EeO3dKp7AdLjqQ3pAuD3FwF8XrT8p9sN2j/gVrz99FlmEXPE+ljvquNasodRngQE5DK8lIxPxs2/HqhLMCvBHq4BzXnoAWMiAY1mpp3AvNAAlgRKIvr/cl02ycDcW0Fq6KX9vAB0C2EDegsB51SSliSRM6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084272; c=relaxed/simple;
	bh=eTeioCFyCFqNEzbJFyqhn3SSHEoGA7E1hBEOzjuXtfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqgOaWFBB6GV7r0N1w/1BwBzS8YLw6BilKrH/HqqEswpOTucUnBTXMbfcRuDcq9XwMwR2M1JD7TxPGWgNRd3y2p4zxP5c+Q5mib0ypUrsAAXE1B9boUyGXfh7Jnausw9YVw9vVXHZI8QMo0TlqleBZrjsBq0luIjg4EOiPUCLGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GQl5U0yo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GQl5U0yo"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so106890f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084269; x=1780689069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWnhuAA8R9T9RYOGxNIaIDGmYbKBGKM0uEReh2pp44c=;
        b=GQl5U0yofU4lu9qYx1NYAkpuRNUGnbPFY4T39Z76cIy1xIF+sYPFt8mu+Zaq42nZvY
         B1LDc9QY6sl1oEMmTNSjMw7HZZHaTTtkUit6vJ4eX1DYPy7L1cGWWt7OJ5eo4G/sXdU4
         N/E22ybKeqa4yk+Ptjm8J2tWCMJeZd/HSg7AmPeZRCBI0qQvzj0IVaWvOhcvkERcQrs0
         q5Ge2vI8kRjCTe5yOpmumJlhZLsKTL2kB35MogkMmsm/c88rf9mAS22IkgQRL18NgzrX
         980YCNNW8WllApGVBl9jZbMHOq7WT6mO4E0CV7q0rfyQkMwbrUYFIMx3VHKJj393enWP
         qAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084269; x=1780689069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sWnhuAA8R9T9RYOGxNIaIDGmYbKBGKM0uEReh2pp44c=;
        b=iccg/p9L2gXfc3/bO7Yyw4OTBr+ll3gMLVR+lpdZpNrXLF5SFsErjXxhoWseiT+5e9
         1XkUO8sB5rx0m0bH9deA8iohsYboitHE/shazNOW8kIw/MbcvT8/UIK998QfQbhbt8fQ
         k1pzb06Bzm41j9J9WJ+kuFxNqz0C2a600rS3I1ecwQEu9lbJtuw+ChUuNA9aEBWgA5d1
         WYzA5ua1LMh2DDaJdx9scNYc2GcUOQY+2IhIVGrkLB75vG+cVq4/fLbc0o6zaH4negvG
         CUpQSKTSBMWkpvey46p0f3hvhaHeyrEeX8EE/sI0f2X5T1I7G4jyEFTma1MKr4SFvERI
         Y79w==
X-Forwarded-Encrypted: i=1; AFNElJ/qJBZ6na2abbLduHjy2Vc5B6WJWejiHlQfuFv6VX1e6Gur68uYd/1Nb74PyzZlRTKTncw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnckNloTFt8u0ItCdIRMcYjI0cGmUwJHq1TgaoMuk5whLoa7OX
	W3xa7t9ylwpMYB/lO5cOtyUYq7P+I6a9OVcO+/mFyUy8g4rWbGtni9HDL1QXSUS1bvA=
X-Gm-Gg: Acq92OH9LKw/1G3nfI8iapc6kg3aYvs3YwB7eejNJ3afKU5GTyxtpIy51qenJ0koI5R
	ncdATjErPiP30Jh0LfXFLFfvxng50g5GzyfHMZtEP0tTN+HfTE6ea1DJniG7cuV2MQsFlGiE1L2
	pkhsZYrwsTaL2XyMC8HRXSfxFPpgBI88hPXSma6GXKHFCQnOomsgs8TjgrFhyOl1oewwI/6mBmi
	XwuhoPMLY1wQAG2Q9bIQTHxMUB7UeS9SqmXcpcmwZ0N460X5X9Z6mubG0hufgaEH9UWXXwv0ORU
	1pADmn/9enFlntMK5cvjnZ/AInginFUiu4KmKyTX3KEWywC65kG9rUzmP8vVIqcxvK50aYkNYl8
	2J9TdVYwnNH61kzqsNgTfjnuhk9LY5bpD3Is/+jyv6FAN0L/XiufTZwAzMsJ68o/gexm7wMHAkE
	nXmMuraHCUOS4V4R6Qob6Sob2Jmh/+l0mShEFf3f9GEp08IMA/plmISLFk2y4OS4aVpw==
X-Received: by 2002:a05:6000:4610:b0:45e:db3b:921d with SMTP id ffacd0b85a97d-45ef6b67882mr2410650f8f.31.1780084269413;
        Fri, 29 May 2026 12:51:09 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35601d7sm8034142f8f.28.2026.05.29.12.51.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:51:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anton Johansson <anjo@rev.ng>,
	Claudio Fontana <cfontana@suse.de>,
	Eric Farman <farman@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	qemu-riscv@nongnu.org,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Reinoud Zandijk <reinoud@netbsd.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/17] accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 21:49:32 +0200
Message-ID: <20260529194940.97143-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Expose kvm_arch_cpu_instance_init() and register it as generic
AccelOpsClass::cpu_instance_init hook.

Both X86 / RISCV's ACCEL_CPU_NAME("kvm") TypeInfo are now empty,
remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/kvm.h       |  1 +
 accel/kvm/kvm-accel-ops.c  |  1 +
 target/arm/kvm.c           |  4 ++++
 target/i386/kvm/kvm-cpu.c  | 22 +---------------------
 target/loongarch/kvm/kvm.c |  4 ++++
 target/ppc/kvm.c           |  4 ++++
 target/riscv/kvm/kvm-cpu.c | 23 +----------------------
 target/s390x/kvm/kvm.c     |  4 ++++
 8 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index cb077d6d863..a249f076763 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -223,6 +223,7 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
 void kvm_irqchip_remove_change_notifier(Notifier *n);
 void kvm_irqchip_change_notify(void);
 
+void kvm_arch_cpu_instance_init(CPUState *cpu);
 bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
 
 #ifdef COMPILING_PER_TARGET
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 4e7e3039208..edad3c1acea 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
     ops->create_vcpu_thread = kvm_start_vcpu_thread;
+    ops->cpu_instance_init = kvm_arch_cpu_instance_init;
     ops->cpu_realize = kvm_arch_cpu_realize;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
     ops->cpus_are_resettable = kvm_cpus_are_resettable;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 22bd924a399..0f1a98b430f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1783,6 +1783,10 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
         "Eager Page Split chunk size for hugepages. (default: 0, disabled)");
 }
 
+void kvm_arch_cpu_instance_init(CPUState *cpu)
+{
+}
+
 bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
 {
     return true;
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 36634ec8929..6d93b50248c 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -16,7 +16,6 @@
 #include "hw/i386/x86.h"
 
 #include "kvm_i386.h"
-#include "accel/accel-cpu-target.h"
 
 static void kvm_set_guest_phys_bits(CPUState *cs)
 {
@@ -207,7 +206,7 @@ static void x86_cpu_change_kvm_default(const char *prop, const char *value)
     assert(pv->prop);
 }
 
-static void kvm_cpu_instance_init(CPUState *cs)
+void kvm_arch_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
@@ -232,22 +231,3 @@ static void kvm_cpu_instance_init(CPUState *cs)
 
     kvm_cpu_xsave_init();
 }
-
-static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = kvm_cpu_instance_init;
-}
-static const TypeInfo kvm_cpu_accel_type_info = {
-    .name = ACCEL_CPU_NAME("kvm"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = kvm_cpu_accel_class_init,
-    .abstract = true,
-};
-static void kvm_cpu_accel_register_types(void)
-{
-    type_register_static(&kvm_cpu_accel_type_info);
-}
-type_init(kvm_cpu_accel_register_types);
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index ec4c05006c6..167fdd515be 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1496,6 +1496,10 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
 
+void kvm_arch_cpu_instance_init(CPUState *cpu)
+{
+}
+
 bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
 {
     return true;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 013f5e852e1..894962d509f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2352,6 +2352,10 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
     }
 }
 
+void kvm_arch_cpu_instance_init(CPUState *cpu)
+{
+}
+
 bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     int ret;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 7c4440d0025..b8e08d810a8 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -32,7 +32,6 @@
 #include "system/kvm_int.h"
 #include "cpu.h"
 #include "trace.h"
-#include "accel/accel-cpu-target.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
@@ -1981,7 +1980,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
     kvm_msi_via_irqfd_allowed = true;
 }
 
-static void kvm_cpu_instance_init(CPUState *cs)
+void kvm_arch_cpu_instance_init(CPUState *cs)
 {
     Object *obj = OBJECT(RISCV_CPU(cs));
 
@@ -2108,26 +2107,6 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
 
-static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = kvm_cpu_instance_init;
-}
-
-static const TypeInfo kvm_cpu_accel_type_info = {
-    .name = ACCEL_CPU_NAME("kvm"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = kvm_cpu_accel_class_init,
-    .abstract = true,
-};
-static void kvm_cpu_accel_register_types(void)
-{
-    type_register_static(&kvm_cpu_accel_type_info);
-}
-type_init(kvm_cpu_accel_register_types);
-
 static const TypeInfo riscv_kvm_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU_HOST,
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 1c259652925..46730e72a92 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2612,6 +2612,10 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
 
+void kvm_arch_cpu_instance_init(CPUState *cpu)
+{
+}
+
 bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
 {
     return true;
-- 
2.53.0

