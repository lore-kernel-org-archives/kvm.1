Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79156175A5
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064721; cv=none; b=m8qtTP6nNgytEoi/UChhwmBHVEx1XTlNyDI1yez1V+HSYzHeR0C4/0QEnkssG6VlZSp48yabbNW+HC2fFmWPvQdDlR2EAKx66T5DFheLOsiKl0jE61sV4pLlfWYNr+sZzNHtyqe9vH6wnUDHhKjKGwNj/XSRCDeARyC3B5Uq6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064721; c=relaxed/simple;
	bh=Ao96lZJMA4wBl/0dfW6VbCxCvQZLcclJkoFQTapqy2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNHu1xkVzyNRPrZDC7f8i1uNV0sLnpG0Zqy/gAisp3rm8t883wYxy4catbYRqdX4d6lmO317vMei6PfJpVG99CoFvBjCHL2JU0g1RonPvntE49GzbvOc6IxTcXIn4XMGX9FI1aIonikjaVHoxau6Wjyyg/PWEc+jyXjMmgdhmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vSnfFS6A; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSnfFS6A"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490686877a1so40924365e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064718; x=1780669518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdP9i+JrjhdKS8gr6UNWElrHkOhMofDhadEAoaHt3zc=;
        b=vSnfFS6A7GWbEgdraipWuZd3rzCqTr0pAFir9CPiYQr3+RhVD+ALBd9mZGpjIGW8nZ
         jNKVaTcMuyWZ7Q1v+Q20cpRB2sD00VkDRXvqZVCVLn5UPETSr7oXqzGUd6mpN2KzPG0R
         9f9Tcgl1zVIe2xqlE4x3FBKVM3Ofm+1K6kBBYo7blakxxJ/zKWmcMSwlv6Ds6RqsvTTv
         k9SN5UoyQc8MD9PdxwyZ1V1CkM1RBg3W3TQxTy3YXBusPbcZb2SKl0BJGp30ZRttYYmr
         L64syEmWOD2xIB8Alw3CdpVHP33OzChstlIS10COaCaerS/9j5STKm7DbAA9anKjZgYN
         R2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064718; x=1780669518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bdP9i+JrjhdKS8gr6UNWElrHkOhMofDhadEAoaHt3zc=;
        b=p8EWNemoORIJ56cLLtPPc8D0B7Y8wFII6gyQ0ZVWCszLjn9vujkQU2CmRP+7lnNqmW
         qOj0kbLaTuVAA7VpIyCplBU1G7m1JfZP6XYtB+whOC431G21id7Bga48+2Rf2zLMu/W4
         0CHvtbYDrP2cVuUcg+8zR4/w/nWnb5yN4RH/NAFaPuY/rQo8h886tADjIp2u3mpW94G3
         IZh2mY3b+y7UJTkI5XsIKlJ7tf8aDL7KM47SbCeos66PKcT8AqZF05ce1hK0Qg4B56JZ
         F5HCEcUrzgPjzI5jCaCpY6/aPtM2ykyLN0TaFmfWFH1vtAkgL3J/4E+Nk4+kAnqi+uMb
         fNCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NSSLmGkzAREKod5SK/r4cIXO8Q6HAdSJa1spwYURmLbAwKBnpO5jSCFlfEpvxBUnDF7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qKreNpWrat++HMOPR+sQXWxGo6uFgCT304NpFZhiubqFv3js
	cI4m2ZJ2ogv3p8jb4tEqzW7aw2+ws0DN04RMGWhHZui/dMP1gC8Hkdh/EOvvOJ1Ne5A=
X-Gm-Gg: Acq92OGttbFCh57u+4GJ4uliM+DMR3mMFcEU2AJheds1EDEdXK55wi3fa4zw1hS7reY
	f0F6unb0eSdp9lzT5Bv/NdZJPfud9qLWa18S0Hxj6hk96bFwi5Y/I5gC3D2zl98BpncN0OOJ0nG
	SWRt54T/iivGkA94Yhv9x6qnBeo89mfIdh+nZ/q6xh5nbACX3izXQdHHveKA/pmUZzDt3Q1h9pv
	lOq57MR3o6QwFfGErm4gEAu8RCMQE0bVqVd5qBLIaxxGurLCcZhznvJ2ln+6UxSfUuTytDm9ZCO
	FQDJ9MpxkzDf67vaasZNxWu9Y5LfOICX3eCacsNtw4l0TIWvju3390SoFw+FhC3ZssM8ztOU3uP
	C8WBc7qhbqJxREFmWWvDCyzW2akEVNd40EYhYvb7IY/v2hLdcAWGgubOpwUzSdbDZK6M1XS2uRM
	297rOVCQtU/SVmQX3I/xOzdSMPicVME5XImR1rN/hSCtcsNcUFndSYSWaMaPYYrTrzoN5S2wEMa
	hI+
X-Received: by 2002:a05:600c:8b37:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-4909c631587mr43232345e9.14.1780064717711;
        Fri, 29 May 2026 07:25:17 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab7b00sm47144685e9.14.2026.05.29.07.25.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:25:16 -0700 (PDT)
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
Subject: [PATCH 05/17] accel/kvm: Remove need for AccelCPUClass::cpu_target_realize
Date: Fri, 29 May 2026 16:24:21 +0200
Message-ID: <20260529142434.87880-6-philmd@linaro.org>
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

accel_cpu_common_realize() first calls accel_cpu->cpu_target_realize
then ops->cpu_realize.

Rather than having one handler for each host architecture, use a
single host-specific method (prefixed with kvm_arch_* like other
similar KVM methods). Register it once as AccelOpsClass
cpu_target_realize handler.

PPC's ACCEL_CPU_NAME("kvm") TypeInfo is  now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h       |  2 ++
 accel/kvm/kvm-accel-ops.c  |  1 +
 target/i386/kvm/kvm-cpu.c  |  3 +--
 target/ppc/kvm.c           | 23 +----------------------
 target/riscv/kvm/kvm-cpu.c | 10 +---------
 5 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda3..fd7175ea9f5 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -364,6 +364,8 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
+bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
 void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
 #else
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6d9140e549f..4294c7a9514 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
     ops->create_vcpu_thread = kvm_start_vcpu_thread;
+    ops->cpu_target_realize = kvm_arch_cpu_realize;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
     ops->cpus_are_resettable = kvm_cpus_are_resettable;
     ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
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
-- 
2.53.0

