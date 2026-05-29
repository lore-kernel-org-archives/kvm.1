Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AD3FFAC9
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084230; cv=none; b=b273SOl5dTcsYE/+OHBB+uPWyPdFoanL8EQFaTnrhNRaWDVFHxwdjDYDYQXKR0Fs8/cF+YOzztaf/4pLIheCP1CZW3iQUH5qOhg8PNrCDD1KvzjGf6MvUqpNkt3yJ9r50YD74mZNdDP1A3SqRufwtvR3fk003EIwU8NNAZbRVoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084230; c=relaxed/simple;
	bh=aa8T7yXzpKvr6koDMhIARULin4G2t7juU4+ZcTXbd3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPVE/3M6JrClAANuM2dNNIe1R3k8ztS99kj339uU1FRUWG3+pjMylP1E/UspnxsY5YyFPvRj9XGT0S4mqYSwi6UuuRlmVLaD5E5B3VuwWG66HPyqUi0uJ/1QISJPU0GApy7hRXF4ctT03t77SGCpo1y0xg5Cq9EE5sSJ+C/Xxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M36aMJaF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M36aMJaF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso74463005e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084228; x=1780689028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbtD0a+QduPKTnykEYf324+8lIDbZ8T/QVOG7u6Zyl4=;
        b=M36aMJaFraxG2jifH4pF25xUOQ0JbO8ViTnk4oomcNjWqAv9aac7rASkhm0a4kpieb
         cVn+pr8bcbE6WsJCZZX757ycrgxV61+4ZsUNzNyVmjtPl6eg4bQyaaPylw9NiWxfG+fk
         3KcRcc3bJxoeMOrpY9BMxv5a4b5B0WDj8SUntnyIRx47P9YbklEYhDgWRmeyGLn7r+Hg
         zNYqWf3MnLQsXW9qShiOr+XpadEsL9GgejRtbMYyk+TsAHjbQgTXUZaokTnNadqnSJ4m
         EsXswT2KQOuvcmGgrPqjY0npW3xpKvSshTombrvvyb1Q4P2dn16B7HRB2HZhOo9xQ3BT
         9A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084228; x=1780689028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbtD0a+QduPKTnykEYf324+8lIDbZ8T/QVOG7u6Zyl4=;
        b=ElK3l2XfEuT34yajVnjNDilXK1P2vPH3yQeDGPGRYzzSNn+mVXQSp9Pf6skMU5iSmc
         WMF1GzepY6RlCZnbd1d/CLWmJ4tQ8+RD2BMkBatTeTXiivKB1SsB74byb6ORKAIpFo0z
         jGG/m489tM4CpuOXNyCOjW/7b54SnrfGhbUZJPeCWvU7ciT1OkwDketT4u4kXeA4NpfY
         NcZZE3Y3PFLbJFChs+tz2PBBbWiwQJqwi7zCJQR8Nt+Ea4fTg3hUyiDhHw2JEMR8Y+oR
         OPRw/sbKraZf1AhKjSxRygpIoBoMNCxtPKjlFFijkj4PCNWhesNBTbqtyzg4SFKFyW5F
         N2yQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IC+gk9pxty3nyHdmVYmf7cE7A/re83rhacrYqi3rj1BFr+t0+s6miOn6no5n4HaKlX78=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv020jY2svr/2QC4pQKGC2KYMdYsaxHDTaNXoHPnCElCNnUWJ7
	wRfMhDdEi4dHfJw35XU9IybHJKlJtrDwolwEffdbYTa+GocFJaRC6hR2Svv/kb6HlLI=
X-Gm-Gg: Acq92OF+con2Uale/dqIJ0jVtDiQwc1lUxbCDBzuy7rMzMVYEodXdyKLx48HzBmnLXs
	OoP9j2NX9h+w2afP8175q/EMKyzoeXdRfL9te3syVcItnogaHvVasa06rOashxVacI4Sz5UGraM
	YKr4xnheHsNnYeFexUymVlfjTFgPJm0k0JYQ6Gaid3e5N5iz2JKjRmEzVIFul+RBNuH0P2XZB2f
	SH4LAGZFgM4UYPyIgRWs9DQJtd0I2i63+J3z7PgSdMGn9a2wHjg1V7FWXBtLhg879Or9pVCiWFB
	cMIeqQpBiOCDqXJIIlh7J3mejpnFh0IEHKU3xFfOW+effE3sdH5t/Q9Xqrf1jnzJtVDgARutH6K
	K09+pL1+1tA3RFGjZxPQmAFp8iL6dY115Ndzec5o1pFcxC9SSqFZ/V6GTb92Wa+8cOFSGti9Pe3
	z32c8LNTGbkR8BwnZzzVxoGyCI8kDGqjpQWXuJ/tscZbqOa41pdt11nFTtByO6EgEUwg==
X-Received: by 2002:a05:600c:c108:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-490a290de68mr14778405e9.2.1780084227615;
        Fri, 29 May 2026 12:50:27 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c104920sm20387615e9.21.2026.05.29.12.50.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:50:26 -0700 (PDT)
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
Subject: [PATCH v2 05/17] accel/kvm: Remove need for AccelCPUClass::cpu_realize
Date: Fri, 29 May 2026 21:49:27 +0200
Message-ID: <20260529194940.97143-6-philmd@linaro.org>
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

accel_cpu_common_realize() first calls accel_cpu->cpu_realize
then ops->cpu_realize.

Rather than having one handler for each host architecture, use a
single host-specific method (prefixed with kvm_arch_* like other
similar KVM methods). Register it once as AccelOpsClass
cpu_realize handler. Add stubs for when a host lacks such method.

PPC's ACCEL_CPU_NAME("kvm") TypeInfo is  now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/kvm.h       |  2 ++
 accel/kvm/kvm-accel-ops.c  |  1 +
 target/arm/kvm.c           |  5 +++++
 target/i386/kvm/kvm-cpu.c  |  3 +--
 target/loongarch/kvm/kvm.c |  5 +++++
 target/ppc/kvm.c           | 23 +----------------------
 target/riscv/kvm/kvm-cpu.c | 10 +---------
 target/s390x/kvm/kvm.c     |  5 +++++
 8 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda3..cb077d6d863 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -223,6 +223,8 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
 void kvm_irqchip_remove_change_notifier(Notifier *n);
 void kvm_irqchip_change_notify(void);
 
+bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
 
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6d9140e549f..4e7e3039208 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
     ops->create_vcpu_thread = kvm_start_vcpu_thread;
+    ops->cpu_realize = kvm_arch_cpu_realize;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
     ops->cpus_are_resettable = kvm_cpus_are_resettable;
     ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7d194ea112b..22bd924a399 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1783,6 +1783,11 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
         "Eager Page Split chunk size for hugepages. (default: 0, disabled)");
 }
 
+bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
+{
+    return true;
+}
+
 int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index c34d9f15c7e..36634ec8929 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -39,7 +39,7 @@ static void kvm_set_guest_phys_bits(CPUState *cs)
     }
 }
 
-static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
+bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
@@ -237,7 +237,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_target_realize = kvm_cpu_realizefn;
     acc->cpu_instance_init = kvm_cpu_instance_init;
 }
 static const TypeInfo kvm_cpu_accel_type_info = {
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 9d844c4905a..ec4c05006c6 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1495,3 +1495,8 @@ int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
+{
+    return true;
+}
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b94c2997a07..013f5e852e1 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -49,7 +49,6 @@
 #include "elf.h"
 #include "system/kvm_int.h"
 #include "system/kvm.h"
-#include "accel/accel-cpu-target.h"
 
 #include CONFIG_DEVICES
 
@@ -2353,7 +2352,7 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
     }
 }
 
-static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
+bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     int ret;
     const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
@@ -2995,23 +2994,3 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
-
-static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_target_realize = kvmppc_cpu_realize;
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
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 17ba38403a3..7c4440d0025 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1990,14 +1990,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
     kvm_riscv_add_cpu_user_properties(obj);
 }
 
-/*
- * We'll get here via the following path:
- *
- * riscv_cpu_realize()
- *   -> cpu_exec_realizefn()
- *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
- */
-static bool kvm_cpu_realize(CPUState *cs, Error **errp)
+bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     int ret;
@@ -2120,7 +2113,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
     acc->cpu_instance_init = kvm_cpu_instance_init;
-    acc->cpu_target_realize = kvm_cpu_realize;
 }
 
 static const TypeInfo kvm_cpu_accel_type_info = {
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 2e4f435c537..1c259652925 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2611,3 +2611,8 @@ int kvm_s390_topology_set_mtcr(uint64_t attr)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
+{
+    return true;
+}
-- 
2.53.0

