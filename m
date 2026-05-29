Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C92E7635
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084264; cv=none; b=Cjj2Ht6rOgOkGgdNrmDkQCCeSr2y1WNTXrEirdoOitU5TmJ8ayVUlqUhhGMQoNg5LTH97+rs/fHaGQOVfC7rOSldS67J0lOkrjX/Lb8bb2Xy/jgA8TRrGL6WEUbYHjlX7oyftESzx4+BsqyvgqZK+tueyTVAWvvidiWhVoo+Reg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084264; c=relaxed/simple;
	bh=iqls9L+nVGUQnxTG2UTNd/tqxK4ETke+rBx7GpCM4Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyhboLOj6aaTBxNZ+8UeT+2q9FybTVU6fdm3EQVFgrc4Dm8ue53dlA0+3RfMlLBsLnQR4TTwPsKQ89/UedSb9sAHk/rrC4lYKZ/Eh+KErJqI6r0VEjLNbP8Fq2AV0I+J4AXvBKqq0KlpR4QedX4z+SN3C2JT7s7s0BGn/o4IT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QqboDzHq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqboDzHq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso74320145e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084261; x=1780689061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ACAuqBSNPM8qIatOkZfzbxNuahjvLF1jUZgEVx43Yg=;
        b=QqboDzHqF0fY5sguyqtRGng+cB7hAy3jEk7P+asz7nzV3neZeVz5WqvttHNy+/vNg8
         RDX48n6Xz8SCvTDUuuWbyQ9YqzhQIhKHGYR3OlZM03XXEWFbmoqnim74HcYp9XBgAdAL
         sH04IrtB0gVFlVnTJqjHCEl98iHy87KO0SMH42or92tg6rW+lCSzFDFLQvOyq9kuAHLC
         9+fm1JNpB1TN4VfAdf+x1rzZHr9hLle6E7bnmmmX0qFYceTSHXwoiXcR338FyKbICXAA
         ut1NVHEMJlXU2QGYTck4k61GjeqKjXe7pnfEUDsCA/Ng+0/Bm6WdVnIRfAxQrLwlYOTU
         Y94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084261; x=1780689061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ACAuqBSNPM8qIatOkZfzbxNuahjvLF1jUZgEVx43Yg=;
        b=iNMwQJzwSr5UHqjhIGjSGzhULJ2YMGEc8qdZ8G5ODZcukZ2XelCmdXYtTd6iVxG4yr
         7oCHnvHf168p4PrIUiq/PvE8iAEYEB00/6HRKSqdHn0Q0YZEhEz+7XecaB0DiBjnESiP
         kki+bYPkkesWQ69GUj+3WHU0dYn3zMjqAwEeVjE4xP1+a/P2o9LQrTCW1OmYf54qV4ko
         CvNpGiQsRtVvhRy2ws/KqKbwAaw/J55H9akB37IXqwllZxqbk0O/du61do55S8fkqOun
         6/AziqceOx5nkCj0yN7sdyRXeghATN8b0Hx6N5TBfzI6Z4U4Unapky6IQ/pbIcHZVsvh
         fJGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wfpU5oJ+jdqDy+n3Imj1eLohKalh8uyZhDHtSkZ9WFWb1Z2C6dAlzjMBAKjyL/XEQajs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4iXLs/vHFw//MWycP1ukZUJF59QYDq0tbMeZRcKio+U+kgT8
	LTIWd0wGoopVZae8rykvRSmO8wHh51J1jPeT5+QmCvnTfIJC70MomOIncOoHnWPvvrE=
X-Gm-Gg: Acq92OHW8ngtyVZ6Fxo9VBIPd3XOyAWwKnpwW4fF7G+3nSoNlWF6OpgCCci/0xOy3XZ
	BApoTqc0KepMpA0HMNoQQG2u5UFoTAOCayMn9zxV92rhmxcw8acUnYmimDry9yE7Nt+LZERH89D
	m/QdZFz2U7pQ/kBM914xKhHX0YftpaAZn/qMIgfitihGppbPPSoFdPwlJ8HcljsgqQ4jZYjDaGD
	zQ2uFrEoHcHwZkM+gago+0u6QsEPMmMlmudS8Bp+mOD12fK7hrW1FR0l86wCtM4naiia96ASURv
	J9UZxlkY26yvFXvXXNZaSfQFUrYI3eDxwowkIvkJYe7WJ3JURk6tJldGidcyicwfA+aKiLD0SZb
	tMRpfZPhhu6f3G/p7wsVM/I54dbV0KwVndV9qpobRYWw8ktaM+9U69xwwJVQk1TV6STWiX8x9Af
	90qh5mrg1fforzBMoHyR2bZkffKE1EfURJ9ew3zVC7XhIV7czz6waWwxi0GT3siJ10RA==
X-Received: by 2002:a05:600c:8b12:b0:490:2238:4021 with SMTP id 5b1f17b1804b1-490a29079a0mr18527745e9.8.1780084261187;
        Fri, 29 May 2026 12:51:01 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm5949931f8f.35.2026.05.29.12.50.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:51:00 -0700 (PDT)
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
Subject: [PATCH v2 09/17] accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 21:49:31 +0200
Message-ID: <20260529194940.97143-10-philmd@linaro.org>
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

HVF cpu_instance_init() was only implemented for X86.
Add a stub for ARM, allowing to register as generic
AccelOpsClass::cpu_instance_init hook.

X86's ACCEL_CPU_NAME("hvf") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/hvf_int.h  |  1 +
 accel/hvf/hvf-accel-ops.c |  1 +
 target/arm/hvf/hvf.c      |  4 ++++
 target/i386/hvf/hvf-cpu.c | 25 +------------------------
 4 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d5eaf26dda8..cb8abbc7cc9 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -109,6 +109,7 @@ int hvf_update_guest_debug(CPUState *cpu);
  */
 bool hvf_arch_supports_guest_debug(void);
 
+void hvf_arch_cpu_instance_init(CPUState *cpu);
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
 uint32_t hvf_arch_get_max_ipa_bit_size(void);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 6edc2242ed9..a9c9d5d9a81 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -356,6 +356,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->cpu_instance_init = hvf_arch_cpu_instance_init;
     ops->cpu_realize = hvf_arch_cpu_realize;
 
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d88cbe7c82a..b825a1ae6d4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1504,6 +1504,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+void hvf_arch_cpu_instance_init(CPUState *cpu)
+{
+}
+
 bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 35f6bddbc0e..536bcecd7d2 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -14,7 +14,6 @@
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "system/hvf.h"
-#include "accel/accel-cpu-target.h"
 #include "hvf-i386.h"
 
 static void hvf_cpu_max_instance_init(X86CPU *cpu)
@@ -56,7 +55,7 @@ static void hvf_cpu_xsave_init(void)
     }
 }
 
-static void hvf_cpu_instance_init(CPUState *cs)
+void hvf_arch_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
@@ -77,25 +76,3 @@ bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     return host_cpu_realizefn(cs, errp);
 }
-
-static void hvf_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = hvf_cpu_instance_init;
-}
-
-static const TypeInfo hvf_cpu_accel_type_info = {
-    .name = ACCEL_CPU_NAME("hvf"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = hvf_cpu_accel_class_init,
-    .abstract = true,
-};
-
-static void hvf_cpu_accel_register_types(void)
-{
-    type_register_static(&hvf_cpu_accel_type_info);
-}
-
-type_init(hvf_cpu_accel_register_types);
-- 
2.53.0

