Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06652332610
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084280; cv=none; b=rtN/n9V3i+erANdJ4xL0rQuu+3z1zWoT4isFS1/402+kyqww4EHeqZey4NnaYGObDdGy4oYFKANSbwH4AV+TmaOfR2TfZANFaP4WDTrpO4sVYSHD+Td85CpL48IAJLgorpv7hIDZmNAsZM64gWBdUFPu5vPXd5xdxOqcVPzv9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084280; c=relaxed/simple;
	bh=opEdt0WbYCJ3ZahLaN3UQRAJdiLCTnMnmsgEMN9q42U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qALQ8nFJu6Xpe+Da/frYuiDrpvhjegxnBFOVDsAH4cU+syODt7P9f8x2P1+7yiZlpvKbq9+jrhGhLhmiWZ7AP6YPRzAod83oMttyBAjg5E5m+uVSdMIcjeE1eiKW+bRV1GEdDvTq+uT4GrJVRsExb7NJcNYIOi9EBibyD0rrwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bkiNabbi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkiNabbi"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eea3448f2so1224856f8f.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084277; x=1780689077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN08zAfKjwU0dgbBSed5OKjgOJn32PYWdXU4H33xVTk=;
        b=bkiNabbi8OvX8sDyRV6E6V4t9UAFCK3/eFj4v4MrbmVOxGckZRK6pb71Gw9l0jO+3/
         KzC5sLWQjgMx0VW7ZHbzNOjx/8f1mRbmoSb+oVMPvOP6u23VrlKxBo+SjETq1oN5nxaH
         OhdbtElh8P3+iP4ZNH9jYYSu1ceaXM4dk3PAj3/7i52/5NsPL82chrDHSLY8d2YNVHkc
         sXvlLyA3p7o+wKOqORqdffpo/X+XK74ceEp6h8aofhCQtqa8seXM3Bq8QGs0egOr5wDm
         J2OFA7I0j6uWAB3/aIcXZMLtOsW49mH3LGtd4eyYZZSIESixM4Q4pQ3g3gPUEjHT7qdJ
         +ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084277; x=1780689077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xN08zAfKjwU0dgbBSed5OKjgOJn32PYWdXU4H33xVTk=;
        b=czDotD7AXYt7c9Cn7Xo0P1jYPhVZT5ddoXJh+ZXkrJi3mRiGzYa2cu6OWZVf+/9ixS
         XiJUb4zaLr60Z0uelHvZy9x+rZM9L0xYQis3Ucv9LVvayxxV0fitOfhNb+aM9X+MC5ye
         njbYQbNV8L7cnhFQDCgUtWSqG62h0CAL7Ru4439YMWX5UiV+JkU6TnS3K9e46lL87qqc
         LYwLe1wG+uklXzfPwHNTb1RvhapxNXvVEFNJBp3sBIDWoJhowtv95M4RdFdvVJJKNDyS
         Kd0ynYK1wHUeKQqpqRAuT6l4ft+AyVkf9UdO3eyiLVQc7GDDiPPcaaDHTP1Oav0P3S7l
         jNsg==
X-Forwarded-Encrypted: i=1; AFNElJ+yhykFqg22guSUqVUsrOvZlbnybjbeFjNOReHpgA0GYSqQX6Sm/P5TYF/fxgSA2zieThU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbfk2OiKBmBoLJXX2D8cgq4wpdZcC2CEl7NIizF7D9iqX6SXY
	3X0xv9RkMrE7mRBLOlAN/YbXxGbq13ao6yamjRn61DT3edbCj2TsfjFNn07Hqqx1QWo=
X-Gm-Gg: Acq92OFH9/R85PLnbEfvstsWLWmXtl4Q04sJ68DEtoKLhdSQjN3INHhx6OYGvvNi1lV
	1nHJtSpqPv+yIXuKG8yZL4+phH/D3O4/l41kHXkcx24bvPT4uN9SNtqFUOe40F5RkbTC7f3bwa3
	Po6Q4oIrxvrffL4zpBZ60p/D+pv7jlUpencdnwTzV0u/l8N+z1bw9Q2Uzu57Q4EXhGHTEwN+abu
	Wx/XLbbRhvs7NqC0FeAD9RNeI0k0njBe16wyyaxIvB5TqklOsa11Z2laB9Amw5KsTKMCT7CsrBE
	ahPydkjTa2YDZYcxN2DMoYO0v4/dwZ1GRLLYXzSPet4A3HVt7M3cGuin7kBGNZ/MSQSh/rTmX79
	9kWKzk4tpTp6Jlf4mmi4QlbAUHFdASxivClf+CpRF/y6eaehmP6HxWG9bgXigULR9uD6HEWxFZH
	3Hy0uNbfDF4FRjUy85iiGmXL+z3A3Zo6DDk+sXnYYRjjzwFvxByn2RG/uuGp/bbNkoAV0nMgT15
	yGH
X-Received: by 2002:adf:ed43:0:b0:43d:7dcf:ae26 with SMTP id ffacd0b85a97d-45ef6b78552mr1840866f8f.34.1780084277341;
        Fri, 29 May 2026 12:51:17 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34bcc30sm5738817f8f.12.2026.05.29.12.51.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:51:16 -0700 (PDT)
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
Subject: [PATCH v2 11/17] accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init
Date: Fri, 29 May 2026 21:49:33 +0200
Message-ID: <20260529194940.97143-12-philmd@linaro.org>
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

Introduce a TCGCPUOps::cpu_instance_init hook and call it with
tcg_cpu_instance_init(). Register tcg_cpu_instance_init() as
AccelOpsClass::cpu_instance_init.

At the same time, convert X86 and RISCV AccelCPUClass hooks,
after forward-declaring each target method (to avoid moving
code around).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/tcg/tcg-accel-ops.h   | 1 +
 include/accel/tcg/cpu-ops.h | 1 +
 accel/tcg/cpu-exec.c        | 9 +++++++++
 accel/tcg/tcg-accel-ops.c   | 1 +
 target/i386/tcg/tcg-cpu.c   | 5 +++--
 target/riscv/tcg/tcg-cpu.c  | 4 +++-
 6 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index aecce605d7b..be712c02efd 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -14,6 +14,7 @@
 
 #include "system/cpus.h"
 
+void tcg_cpu_instance_init(CPUState *cpu);
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 5950cdcaab1..d7d329e419d 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -48,6 +48,7 @@ struct TCGCPUOps {
      * Called when the first CPU is realized.
      */
     void (*initialize)(void);
+    void (*cpu_instance_init)(CPUState *cpu);
     /**
      * @translate_code: Translate guest instructions to TCGOps
      * @cpu: cpu context
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ad94f96b252..ef44c12b601 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1045,6 +1045,15 @@ int cpu_exec(CPUState *cpu)
     return ret;
 }
 
+void tcg_cpu_instance_init(CPUState *cpu)
+{
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
+    if (tcg_ops->cpu_instance_init) {
+        tcg_ops->cpu_instance_init(cpu);
+    }
+}
+
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
     static bool tcg_target_initialized;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3bd98005042..381f1614923 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -219,6 +219,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
         }
     }
 
+    ops->cpu_instance_init = tcg_cpu_instance_init;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b9..04bb9787575 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -157,6 +157,8 @@ static vaddr x86_pointer_wrap(CPUState *cs, int mmu_idx,
 }
 #endif
 
+static void x86_tcg_cpu_instance_init(CPUState *cs);
+
 const TCGCPUOps x86_tcg_ops = {
     .mttcg_supported = true,
     .precise_smc = true,
@@ -165,6 +167,7 @@ const TCGCPUOps x86_tcg_ops = {
      */
     .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
     .initialize = tcg_x86_init,
+    .cpu_instance_init = x86_tcg_cpu_instance_init,
     .translate_code = x86_translate_code,
     .get_tb_cpu_state = x86_get_tb_cpu_state,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
@@ -237,8 +240,6 @@ static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
 #ifndef CONFIG_USER_ONLY
     acc->cpu_target_realize = tcg_cpu_realizefn;
 #endif /* CONFIG_USER_ONLY */
-
-    acc->cpu_instance_init = x86_tcg_cpu_instance_init;
 }
 static const TypeInfo x86_tcg_cpu_accel_type_info = {
     .name = ACCEL_CPU_NAME("tcg"),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3e22e7ed53d..703c2d9bd0a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -268,11 +268,14 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
 }
 #endif
 
+static void riscv_tcg_cpu_instance_init(CPUState *cs);
+
 const TCGCPUOps riscv_tcg_ops = {
     .mttcg_supported = true,
     .guest_default_memory_order = 0,
 
     .initialize = riscv_translate_init,
+    .cpu_instance_init = riscv_tcg_cpu_instance_init,
     .translate_code = riscv_translate_code,
     .get_tb_cpu_state = riscv_get_tb_cpu_state,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
@@ -1678,7 +1681,6 @@ static void riscv_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_instance_init = riscv_tcg_cpu_instance_init;
     acc->cpu_target_realize = riscv_tcg_cpu_realize;
 }
 
-- 
2.53.0

