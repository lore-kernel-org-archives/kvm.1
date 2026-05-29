Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA003B3C1A
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064761; cv=none; b=bvu3+DQyQru081k9KX0XboEMwy03N2bqzMTXOB3pR3kUTjXg81Mlk9arQivUpN2MjARveniaDDkOTcaVjvoilBIsYKWywE4YkSiG/XuWvNooVJGK6PWjV1oLlY7lKfzweY+sDjMm+cJwhKKqsTBm1j61Ykcr8e/CeB1WLqCNklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064761; c=relaxed/simple;
	bh=NpVoBgyDXo4kFiuSowigNDh/GPxlG6tecJ2l7rtPWYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeiMwe9zKsFrl8V2M6Y0S2/GicsETbWM62KDmYeGk1WZpX2fGGep00jzLmXwTj5cJgD6zGytGpkwBQ2G9QPKukqJVdnIz3T50yfqA/El9qfj9tBirbLzi1sIpHymSIpE9VZ7ygx1ijjVXLreUcBYH+nLQssg2+ZJa8ooWiMFEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=syEL5CJA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syEL5CJA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso121483385e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064759; x=1780669559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P59p3YW/AQDnYqwHW3EKNEj9nqZIetNGrubj5RXjTq8=;
        b=syEL5CJAK8s3bVw/OafGkENZTFIAP9YqknXv+S78znUXOGZkuinqgT8Vm2ABqK9o1B
         n93VmFz8EFRrZGiPyDw/1z0h131VLNj5r5fwtgfFLxKrmrleI389HRClF6AhtqDOkIKD
         8VGMDVwzetYZOCpmglPyj6ZLI28sStSyNY0zrqMFMJu3D09vH5BYJp7gYn5ralDdnvZ6
         s3wu6HauqzmDyydw5oJbEFq7BCVMTX+aJO5ycUequZWq3fI8nMNBwPT/5m5/Y9r7kK7s
         UChiDjDv6zLdVal8Q1dpKPoJQfO787akbhi2wuYpgqI3hD3QZAo8+8OogEC2uP6UIEJe
         Jz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064759; x=1780669559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P59p3YW/AQDnYqwHW3EKNEj9nqZIetNGrubj5RXjTq8=;
        b=TCB9iiXLmBwLW1+FGsMdkxkiGNHbIRUeEXhtv12+fYhDcWrphvIRife8GVKP9mrNXI
         +clv1pxH0N2hskteB5E7QWLVHtQ/BWDGjYDGG7g0e0NU8ebvWV9Un8UEQMLgBSRL0pJJ
         GFTGPYDDHkMXP4H1lPaHqUVb2i3T9/S8uaZG1UspHGkTp3oADLqhaVPyKoP3wdq2FiAG
         avYU/QhFM5AQ2DV2bN2BgFx2FY6U5/r558CCwaWt4j23S0v/EZeeIYnnge2o5CjPGcrv
         ju5Wnv76LNCiPZV+FRqB94nOmGilTChbW7RvP1mm+SQ7ed7FWo4NgH28pEuNIgRkDK2q
         4XPA==
X-Forwarded-Encrypted: i=1; AFNElJ/kk8lnOUQP2T+Sk8fU6S7bPvYtCeYf0biA2rC31BqRwSCNOxXiNgLFhTfibvXCHCgxHFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/WbXdHxu8g4wxvyKOxVpPchG6bAZ81h8pFxzWyFrDdYSf9Pc
	6xxK1gHBKYqcTAqSTyJDlmXOV7cZdWRye0lxt00fTrivDjxC1GC/GCVyhD5rGBEUJ4Q=
X-Gm-Gg: Acq92OGr+YfS3Q1IBZ3WqhfvspCagcznkWA1xKnrKJaOZBl8SlF5eoVPi+xYotN4ZyO
	o4USBx+kdswHhBBM2TRyxp04hs5eDDJRN7IVGIupugbc8N38pirBTholBvMGrTgXFkJnMM4AMLa
	72abmTbOCdidHX69Rj42Xt3+R6dw706DinCKzsHVlDBxAyjaQ+adz+nXFLgc0gdQLUXvkQ/t3vb
	O/iFJ9DdfXHXZY+RbdBehZp/urQYe5t270MYgd+BfVYY/hsjw/bVPOXx5enY/xpN0fnot8OxZlo
	gSHHhO5yK40QsF1gVO0DYyzy87zJ5XSNlqjqu6p4UWRvZHDwjzZ3SSp1jcsBkorov3ZWQkcJdTw
	pRx2Jlit0wfPUXovKpITlf+erSBbFSz0RIb7vbJvb0X6dUMUK9+W9WbrlCMzjvFdPa1zeV/Vbcj
	lw5m9JpCiwjQ/Lwr3tUxlPngl8Qich/HuU6G4xEPCNwejxqEBpT04afSO6LnBmmIi3LA==
X-Received: by 2002:a05:600c:c0d2:10b0:48e:7854:1608 with SMTP id 5b1f17b1804b1-4909c0b34e3mr43174675e9.25.1780064758692;
        Fri, 29 May 2026 07:25:58 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6eb4acsm42435095e9.9.2026.05.29.07.25.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:25:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	qemu-arm@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Song Gao <gaosong@loongson.cn>,
	qemu-riscv@nongnu.org,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Alistair Francis <alistair.francis@wdc.com>,
	qemu-ppc@nongnu.org,
	Weiwei Li <liwei1518@gmail.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	kvm@vger.kernel.org,
	Claudio Fontana <cfontana@suse.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/17] accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 16:24:26 +0200
Message-ID: <20260529142434.87880-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
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
---
 include/system/kvm.h       |  1 +
 accel/kvm/kvm-accel-ops.c  |  1 +
 target/i386/kvm/kvm-cpu.c  | 22 +---------------------
 target/riscv/kvm/kvm-cpu.c | 23 +----------------------
 4 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index fd7175ea9f5..2c31fa6019e 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -364,6 +364,7 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
+void kvm_arch_cpu_instance_init(CPUState *cpu);
 bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
 
 #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 4294c7a9514..113a23f2384 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
     ops->create_vcpu_thread = kvm_start_vcpu_thread;
+    ops->cpu_instance_init = kvm_arch_cpu_instance_init;
     ops->cpu_target_realize = kvm_arch_cpu_realize;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
     ops->cpus_are_resettable = kvm_cpus_are_resettable;
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
-- 
2.53.0

