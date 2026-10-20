Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493019;
	b=hdoh94O14XjJRlGZEG+QXPqSlfujW/3i0ajsKrvKH1Kr2iXZhOzEfFHqPY1XhIbQBM11
	 1yvn9+To9xog0eZdL95aO7n7hutdihak6JOG0sUJ4YbYYWRK20MPtKFhfLAzJDIhZAmPM
	 Q/dvXdtoe4eKTlRYMBi76KEoxugACGQvAY15coRQOOG49aZAvM+56NYMBEaSs8nS2xzCo
	 m0t6o2xhkUzycSqjBFammMBeBWEDshaivuorpnuW3nZWlqtat/DDSOc/KaGFQqM+Y4z0N
	 iCU3prdYYyyPFyyB7DxTJctIuFbKbuhnh6QreZMXYwq5PAVqJM+d2OBbrYrZ0aghGVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IZVpnwXNEyCCWDW5qZNv/CPNg86yVg361tAI8kFJxDQ=;
	b=oa+/14rGKhMb1m8CKnu/i4w6Y/tShd9xSTQChVhwlzGBWOQkRuTE4QpcWKoocTOGuOA9
	 vBkmwPff5wvpLs4c6Fu2+f5MzdF0PWtMBH6G90VSc2ioc5c1wbgfFokyGu1nIlNzKbpao
	 y41FJd7RFvGvCa/p8fi8mUEU0+kCaUqUq/Lk6S282FSvUehbrgDZb/3EMhkjXiYxFrsl2
	 Idzij+C/eUn4yUUDc2msq3712IlJ6rOzVhuKguDjnfiUEo1NgwdOwcseBRpRbfi9AobPs
	 0/sj8H+foR7Vpus86DZu8JPylH8YaUR3snySSZDFe64uvkF+9DnpPPc6Cnc2jK4IcLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wz6gjhZ6;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B2606A320
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D2B2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wz6gjhZ6
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so31465015e9.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493018; x=1793097818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IZVpnwXNEyCCWDW5qZNv/CPNg86yVg361tAI8kFJxDQ=;
        b=wz6gjhZ6iZMNGXQV+uBgdzD04oq5/Y6qloASgeuS9keRG/PJFtgQ6gjUIxuRbPEk59
         wUPJYZaWKAwMcysZ+IXCtdM7FSvVfwoKlpFWGRdE6V6tR+zEZFyeeB8DFUkzCeDWCj3E
         vENUMtRyeHq8Odqdqti2Xojq+wdu3cmFiYmtO/OR1gQPOwtBP+UNOQsmEl4Ctewy2Ynt
         Nk6JIvsLskobFsVCVYBfalgXDJnCo9pnZDF4XYwSdpxsLu2d0KqKE/peEtLAXW78Usx5
         Gnk5B6bjCzABX6qpHklAlgY17qiT4O3POHUz22+ioPOuY2hDcnJs2yhtQVUxSHrPPZK8
         rBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493018; x=1793097818;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZVpnwXNEyCCWDW5qZNv/CPNg86yVg361tAI8kFJxDQ=;
        b=Z3Pa9mG7c6+R19zaiNeh3Ij1wGTVYCG24ZvdjuxQ7GaA5PX8Qb285gOFFDu2ti2/DA
         FzUucpYmMY+E8bX89MJmito81yxt2ooJ/8jUg6IqOLSKK4ASEZbE7och0cjUpNEgZoTU
         W6LXOz0MIW5HpbhHgpxG4lbs+XlUMuJbWJmmh8DH+A1BsbIQB48fmkfXk1TYcAeBMxxA
         VQ8FnPVxY23GHFudT4Uyk+GPRJmBF7xevuCCnLVg/5cRXTXd0CDnlucm3Z3ZaXMasVM7
         TKkx71uv8lyR5QpwKrZGizi0VX3Y23SL0FN7L/cmqTwHOwB8P0EdjdxLN6YKt0G5xM91
         3r/A==
X-Forwarded-Encrypted: i=1; AKwUvBzZAdAHFVj6E3HCWUTQRPscIw7qhfYwKnR+vb6X/UZ4l8qK3W/vQKQDEadSGPIl3SarLrg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLikHiWWWa70lFWThmGMdOJwmM8aZ2lD1YE99j4p0rquCIqsHRR
	WIK162TUu/G4PEe3xnlh8A1cA6JfRzTbcSQWkzeZBE9mT4HJS2oW2tHNHm2aLC+1/Jg=
X-Gm-Gg: AYBFou0OHtBcAx/qPr4g8Sexkg9tkYzzdmGcI0WfC2eScgfgmXpxNB07/5eiEtQt13A
	6tDRKMcGX8vwQezNW2N/dAy4gEvPcWCTSBzoncyHwVsH+VqSl1GmMgrnY5pDyf+qy12rkMgOgFu
	zNDYpoqZx7G96ysXYNq0fj6jAKRd80gJDtnHOfQ1gxRX17oW5vaWDQiVCUl5HpY38MGLtTxL4Fq
	LTyIf8KpEIZQnGBdvuWVlvl0V4TYxpK0MNmjH53Ma717nnE5ZmW+WS9DnE6BDo1rQOUjH9QYaHz
	a20golmaHyqgIGskGXYvNjhvYc4oUHmIn2b5DIurHbRSjyfwn6ov8rb+EoNx07SCqAMi/h5LvB8
	hY81QBhtjR55NmPQ+22g0e3I+Mq89ESfkxqihCOAH6JDGBAluSBpUOypUhlxTbT8G2P3H9emMJW
	4PiRNY7BvIeDuS7F5nWQfzWie1w990ZVBK/uHsL+efTQElodN1e9xTAKRATXwGHBQ9CISoOA==
X-Received: by 2002:a05:600c:4455:b0:4a1:e225:b122 with SMTP id 5b1f17b1804b1-4a1e225b8d7mr156541115e9.14.1792493017818;
        Tue, 20 Oct 2026 03:43:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc952d63sm346602105e9.2.2026.10.20.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 6F0A45FF88;
	Tue, 20 Oct 2026 11:43:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Song Gao <17746591750@163.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Bernhard Beschow <shentey@gmail.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Durrant <paul@xen.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Walk?= <bwalk@linux.ibm.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	qemu-s390x@nongnu.org,
	David Woodhouse <dwmw2@infradead.org>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	qemu-ppc@nongnu.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	linux-edac@vger.kernel.org,
	Glenn Miles <milesg@linux.ibm.com>,
	Chao Liu <chao.liu@processmission.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Xianglai Li <lixianglai@loongson.cn>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Chinmay Rath <rathc@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-riscv@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 21/23] accel/kvm: port kvm_arch_on_sigbus_vcpu to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:15 +0100
Message-ID: <20261020104320.3686723-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This leaves hanging the question of if we should clean-up
KVM_HAVE_MCE_INJECTION? It is poisoned to avoid entering generic code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/specs/acpi_hest_ghes.rst |  3 ++-
 include/accel/kvm/cpu-ops.h   |  6 ++++++
 include/system/kvm.h          |  2 --
 target/i386/kvm/kvm_i386.h    |  1 +
 accel/kvm/kvm-all.c           | 19 ++++++++++++++++---
 target/arm/kvm.c              |  3 ++-
 target/i386/kvm/kvm-cpu.c     |  1 +
 target/i386/kvm/kvm.c         |  2 +-
 8 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index aaf7b1ad11a..dfb319dc3b4 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -114,5 +114,6 @@ Design Details
      kernel, on receiving notification, guest APEI driver could read the CPER error
      and take appropriate action.
 
-(11) kvm_arch_on_sigbus_vcpu() reports RAS errors via a SEA notifications,
+
+(11) The KVMCPUops::on_sigbus_vcpu callback reports RAS errors via a SEA notifications,
      when a SIGBUS event is triggered.
diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index c2ae74f2b87..d43bc845ad5 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -101,6 +101,11 @@ struct kvm_run;
  *                           execution should stop.
  *                           Returns true to stop the VM, or false to dump state
  *                           and continue. If NULL, defaults to true.
+ * @on_sigbus_vcpu: Optional callback executed when a SIGBUS signal is received
+ *                  to inject an architecture-specific hardware memory error
+ *                  (e.g. MCE on x86 or SEA on ARM) into the guest.
+ *                  May be NULL if the target does not support hardware error
+ *                  injection.
  */
 typedef struct KVMCPUOps {
     int (*pre_create_vcpu)(CPUState *cpu, Error **errp);
@@ -122,6 +127,7 @@ typedef struct KVMCPUOps {
                                 GdbBreakpointType type);
     void (*remove_all_hw_breakpoints)(CPUState *cpu);
     bool (*stop_on_emulation_error)(CPUState *cpu);
+    void (*on_sigbus_vcpu)(CPUState *cpu, int code, void *addr);
 } KVMCPUOps;
 
 #define TYPE_KVM_ACCEL_CPU "kvm-accel-cpu"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 719ae1c71fb..98ef937eff1 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -352,8 +352,6 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_vcpu_id(CPUState *cpu);
 
-void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
-
 void kvm_arch_init_irq_routing(KVMState *s);
 
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 9d4be604443..88aa0699c28 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -52,6 +52,7 @@ int x86_kvm_remove_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
                                  GdbBreakpointType type);
 void x86_kvm_remove_all_hw_breakpoints(CPUState *cs);
 bool x86_kvm_stop_on_emulation_error(CPUState *cs);
+void x86_kvm_on_sigbus_vcpu(CPUState *c, int code, void *addr);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 62ebb3458c8..5189cdc6a01 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3535,8 +3535,10 @@ int kvm_cpu_exec(CPUState *cpu)
 #ifdef KVM_HAVE_MCE_INJECTION
         if (unlikely(have_sigbus_pending)) {
             bql_lock();
-            kvm_arch_on_sigbus_vcpu(cpu, pending_sigbus_code,
+            if (ops->on_sigbus_vcpu) {
+                ops->on_sigbus_vcpu(cpu, pending_sigbus_code,
                                     pending_sigbus_addr);
+            }
             have_sigbus_pending = false;
             bql_unlock();
         }
@@ -4080,6 +4082,11 @@ void kvm_init_cpu_signals(CPUState *cpu)
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 {
 #ifdef KVM_HAVE_MCE_INJECTION
+    const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
+
+    if (!ops || !ops->on_sigbus_vcpu) {
+        return 1;
+    }
     if (have_sigbus_pending) {
         return 1;
     }
@@ -4097,13 +4104,19 @@ int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 int kvm_on_sigbus(int code, void *addr)
 {
 #ifdef KVM_HAVE_MCE_INJECTION
+    const KVMCPUOps *ops;
+
     /* Action required MCE kills the process if SIGBUS is blocked.  Because
      * that's what happens in the I/O thread, where we handle MCE via signalfd,
      * we can only get action optional here.
      */
     assert(code != BUS_MCEERR_AR);
-    kvm_arch_on_sigbus_vcpu(first_cpu, code, addr);
-    return 0;
+    ops = kvm_get_cpu_ops(first_cpu);
+    if (ops && ops->on_sigbus_vcpu) {
+        ops->on_sigbus_vcpu(first_cpu, code, addr);
+        return 0;
+    }
+    return 1;
 #else
     return 1;
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99699098c..563b331a7cf 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2486,7 +2486,7 @@ static int arm_kvm_get_registers(CPUState *cs, Error **errp)
     return ret;
 }
 
-void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+static void arm_kvm_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 {
     ram_addr_t ram_addr;
     hwaddr paddr;
@@ -2656,6 +2656,7 @@ static const KVMCPUOps arm_kvm_cpu_ops = {
     .insert_hw_breakpoint = arm_kvm_insert_hw_breakpoint,
     .remove_hw_breakpoint = arm_kvm_remove_hw_breakpoint,
     .remove_all_hw_breakpoints = arm_kvm_remove_all_hw_breakpoints,
+    .on_sigbus_vcpu = arm_kvm_on_sigbus_vcpu,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index c9340183eaf..e876ec6b794 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -252,6 +252,7 @@ static const KVMCPUOps x86_kvm_cpu_ops = {
     .remove_hw_breakpoint = x86_kvm_remove_hw_breakpoint,
     .remove_all_hw_breakpoints = x86_kvm_remove_all_hw_breakpoints,
     .stop_on_emulation_error = x86_kvm_stop_on_emulation_error,
+    .on_sigbus_vcpu = x86_kvm_on_sigbus_vcpu,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e419af944cb..26d30629272 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -767,7 +767,7 @@ static void hardware_memory_error(void *host_addr)
     exit(1);
 }
 
-void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+void x86_kvm_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 {
     X86CPU *cpu = X86_CPU(c);
     CPUX86State *env = &cpu->env;
-- 
2.47.3

