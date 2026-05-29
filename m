Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237112472AF
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064769; cv=none; b=POhkBiUX5YvyKLV/cexQI5vGGC7eBFqnnE1fqw7Rha5LZHWuVxhtHzBz+Vi6YlZXsRodyn1O1fuqqI4qxh3A7lIrXQS9BOhmcAd+udV1W6N40lv8v9MZ9ftcSQ1DJGidtwLHyuaDOPciy1oXtj04bPaQ30lNV2+qfMuCQ/FWYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064769; c=relaxed/simple;
	bh=84xzBU8lTHnmR6Bm3ca8fd6RpWiBNgkAgApLb3XWYH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTvUkewpjDAyF0wXRLi1ATT8hEjcBXzXgucFCr3RypAc9hO275i00q/PYUrNeXnUCPMk28XlYRKnhki8gVhFMW3qgyAyhhDA6RdJUoKeptHJzeA9qwwlotC7JHWKo3ooem1wzP9rnsMxeU1hmW5qRGGfAqFZXKCP1+7ZyUSHG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ej1tMQQZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ej1tMQQZ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef29c5561so402713f8f.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064767; x=1780669567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLjO9ILLNjldGaO/XRaKWcElj66Y6w+X8KhGj9XwuEI=;
        b=Ej1tMQQZrCgd+nV/gPuBNuvu5fSUL1cCycMink73nY/6P4pr5IjMy47H0gUcpdI/n0
         uEQeOEETH/5f/6YRaT/GF/pVCWqSaQpvN5xJHr1iSkCFDFHhXpc5QrhrDI+pkCQUpiQ7
         n+MknW8xT7MMWm63WQDFWLbzgtE85CzmvMpX/g+QTmOOWiwVCXpOw9AsJtQ87yJFcMap
         Z8xMAkcTad3mRpXdS6lBXC43meaNQcKZZXl/CHgB018xUP/6QabmUKdh70/J7OYxHney
         KywN7W88ASgABOcOwbiQb7YaLoPVf7P+q0WxmUVOdFg0qDYomcNRUxS3hhy5It9QXcSu
         z1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064767; x=1780669567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLjO9ILLNjldGaO/XRaKWcElj66Y6w+X8KhGj9XwuEI=;
        b=LLMGJ+RIVu30T17V0uwip+BAtIj4mKAD6OGdzH3v44WQyoZDies7fJxZl/zi3AIPR+
         o2WcUwyln+vkkUQ9wkSZy6qJE+T/W/Yk2oN24Y4dbpnfk8fvtTKIpQX6vUsyd/Rh/Ef2
         BefNWfG4CA5EojstZbpf1yuaORmzbNY2YAGd/6dN9I8PNCevvb6DVwNfp7Qgrpl7F4rH
         CFfOdqTYtMr3gzQwiz4RV2P8S/D8vXCftC0YejZ8zVPp5TNiUJ9adwU1Qy9q7a42lWvb
         7AOqesSEB4E6H7eCP1OS9BqcWyS0JChkNyCbdfbNVZ3J5uw3DACzKQk3tOtk8y38oONb
         eajg==
X-Forwarded-Encrypted: i=1; AFNElJ9iINA1Rvqbz+8gBdN2lHqVox3bCTB+pqqN33OV3ciTLnbdVlt6NrgTnVdiahNfPreVrAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxvsL4mhhfJBUBnd+UbdWcI/19xq8dWwF8uPiAMvG70LsaAk5s
	2fFv47LCbcnAoa9de1x1jxMe3xD1ts7EkVJirtNLxkOI2tlYTPrfgUGHSjvXFkB94w4=
X-Gm-Gg: Acq92OHO1a9Vk/1xuHSHOguiPMLoLxhUJnx46OZaKu8mMVgRx5GuXgfUa5sdtciBxm7
	3hi5KHnRwRj2+xT1Ebwdcx8pYJrI1yHIj1do8Fxv3/NcqmAzJqpcoLemLOzSyRZ61fAZCeDy7uh
	0KljLvJAj3D/q65aUMgPxHZPIa0U5X9aoZW+dmbMU5kPEJSndHpuXHeWn483Lh/Ik+6yJmmxjBw
	AfHJER+xgQp+V8QTGuHWQMpDgTvyWX6A7ANhf+h08V4L4x3XcUcdfXq1VOu4OPlP2tk5LzSR/wn
	KzPJLrUiNdWAnJuu9pg8h8/nUncrn2vTqlQNHm2DpqHJ154PSvILcYP+/sxXw+SfjfJhIZL/qRb
	n5jz0KmA7d5GonuQ4goBfpegSfMct+KqWjv4UrRk4d3ZXbSOIlkemPdLOfExUVm9/iDoxiel2cT
	9l9mBQ4Qh23zGZ1OQLjSR/YqWjN34PKPAFLXO5WIB9YIN5GWu5eh+Do5HdfrSCqpFCpw==
X-Received: by 2002:adf:f2d1:0:b0:45e:f354:8603 with SMTP id ffacd0b85a97d-45ef6b6d51cmr4895f8f.22.1780064766603;
        Fri, 29 May 2026 07:26:06 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm4066115f8f.34.2026.05.29.07.26.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:26:05 -0700 (PDT)
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
Subject: [PATCH 11/17] accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init
Date: Fri, 29 May 2026 16:24:27 +0200
Message-ID: <20260529142434.87880-12-philmd@linaro.org>
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

Introduce a TCGCPUOps::cpu_instance_init hook and call it with
tcg_cpu_instance_init(). Register tcg_cpu_instance_init() as
AccelOpsClass::cpu_instance_init.

At the same time, convert X86 and RISCV AccelCPUClass hooks,
after forward-declaring each target method (to avoid moving
code around).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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

