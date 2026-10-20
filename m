Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493010;
	b=mj0FZiwC1KXhcuaVQB0lGb4J0SBt5axARMMeV3MQ95kkwlwVRQ7UC/PKpumdHFFEFTr0
	 lWKMrPj7JeV7DnGIZbbDCNfLSK+N0tjar0KeC0e+zRXGEtbxXVl8CxRzWL9V4fr4ougkA
	 uqfZc2gx3j/qJgTxPnUaEKs2VidKZAprXnoswQTN1Pdo9IjQoN/+eYFj5WpiVnB9NT6s5
	 VmdQ2p9Jr8U/MNrFWMpMF18zA/OLIMD2VXZeBTqjfN2HmR5viDXh3x2YCr0rQUPi66kyJ
	 CHoD8LqKLvf3xVJv8srocATW3E64c96wB6KutMjVIRPClzWgF6/v2u1LBn5Rm4wUUVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HO3Ja0+9v+igMSVwX72ixvycLcYQhsP4AuHqtgFe9uk=;
	b=aKMhgzc7bIksBIP8C/a05Nd7o/mCsVamiOPuQXuSzcoVkQboin9syXP6NMK8zxEQqL/G
	 s1htcV2c8gqI1JHa5QjlhKO3n+u5N4TQ8AM5YzWf/G3qqo28jvc/zAAo4bFGI1KLaSsxW
	 TSnsdMb/d0vKirjxPIZNCSfL6930aQRXSgAowE4Or7i0O/kMbCUEwVORJJMRGNgQFO+PZ
	 tMv/5R0+tLE4cF5vnZrKUiqM9KJOhOfW5vj9LpKZyzk6jijR5WhlXEc1fE1s3SIlBWILU
	 5MLIyezmkzbGo8JSJbBX0eONyzo5woATlWjQRkWWeImxO/AAmBCMsf69mzTL4QxqG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wXPsF2SZ;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDF660A380F
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DDF660A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wXPsF2SZ
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c45111bebso1906914f8f.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493008; x=1793097808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HO3Ja0+9v+igMSVwX72ixvycLcYQhsP4AuHqtgFe9uk=;
        b=wXPsF2SZitQSBrwrTKK+q22mef3EY2e6LzHasGqO0pXy0J5W+gBPfHgy9oSjOb+Yxg
         KAl0rTo/4/15EnW3w9l5Da4xKs2RGjHQLgHYomanC0EmYSs6v99+z4ImK8Q3jdwFTBlt
         carnZiow8Eth6Um7aKTdmT4HCqycFxNLxsgMmHmoJHhnSo8rwwW9Ftq9SJ7buvVutOnp
         Aw8PmDPNpHKD30zO1uN4czpGRl38+qPLVRD4HrT7O15kwYOpD2esoMk/dNq2XlHTAm+J
         aELiE/xgNwLl4R9J6tETsRd22Pt/9tsM0kya2WTor+v/rGP309hNh39agY5mUVys16nB
         WGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493008; x=1793097808;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HO3Ja0+9v+igMSVwX72ixvycLcYQhsP4AuHqtgFe9uk=;
        b=Bj738tPR6jmeCdorQGz+fOMBcgWpM32E51pk9u9y/KqO4fY3KwioslJpFkC2a8ca5b
         XYgjcNuhi/wqz+hXj7eQP16X0Bkpv1Y2vtDLsgiPDOUaekJhroPN5qAiPgpNV9lD8n7T
         YfdW3lKOnjQSQgTTkQdE43Wj/L4x/JX1kKxYrVV9ZX0W6uGDFVQe3avMhDIGl9w9NWvU
         UfZEkv2D1jncO+8GjVZJdtvDtqX29aRbV/jrC3QAknXtVrkWBpF4qiSCL1mmhGR9m4uy
         1Fpu9p6j8aLKmdspUwQv3YfZhaW03bX6NojevqI1iluKpuA5FzmvXmK1CiTcV8h2WMsd
         ljBg==
X-Forwarded-Encrypted: i=1; AKwUvBy2l0DXFS6BrklYq9EFQ0yTZLyOeUdtFSmQYhYQ6vw24Ryeolzbp52vPdqIyoEu0xJqTy0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5rgYxnqKX/DPl8rpOUJPBD9JBlU2aIGWePztH8c0aWHqMGmvX
	gMiPQ4wHrdWBDwPKxtE5m5W+77lVTawkX4fHf9MdfMT5/rFwTOBYE7m1m3givzuXgRE=
X-Gm-Gg: AYBFou1wG4xIjyokp9pZtHNXcu9+fcR1a7KGuOhihawr8a29Z6iEIxMAe1XSRwjvv7Y
	IHLbaVXvCP4g1f3RdJ0fJyCGzcLjX0wqGwxREcsRa+9ZrKZ5Y5P7KSAaYEf6LhD4kCj8Fo+yzY9
	wIlssDYyLatb6Gn4tdXJtEQ0KEvs3aLbynp8FQy52E1l/5NYHGsr292AnpUXH0ZQ5KWkr60VdRP
	ktb6l3PkZRnP9V8mdfYdICMnaekD+wNIF0R94KDzQJi54H+EwPCoBRvJztVyCwGyIs/cZ+ZP6ze
	pzJPjzus14DpoVxvBnhVSr5IntVWWFsl9JWnlwrZknXnNfTSX8zWesfKPK948HCjAtTlumihVKI
	4OQ+dgmiKsbzwslsbVIGJoekaxV2+yp58oEy3iep3xFRXnANIGlJGfAE04Cln+8ALQWlRcEByBf
	GLd1tGMOWJwkUVFMcLPZUrIx4wbmaaA0C6URV+8PZw7qLXUr/VXcosrtzBB4bfhMeFfl2+9w==
X-Received: by 2002:a05:6000:468d:b0:48d:f39b:83de with SMTP id ffacd0b85a97d-48e07b92058mr15645006f8f.3.1792493008429;
        Tue, 20 Oct 2026 03:43:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82e8f7sm5296588f8f.48.2026.10.20.03.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 43CE45F957;
	Tue, 20 Oct 2026 11:43:22 +0100 (BST)
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
Subject: [PATCH 12/23] accel/kvm: port kvm_arch_[put|get]_registers to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:06 +0100
Message-ID: <20261020104320.3686723-13-alex.bennee@linaro.org>
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

The ability to save and restore register state from KVM is required
for both migration and the gdbstub. These hooks are mandatory for any
KVM implementation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 11 +++++++++++
 include/system/kvm.h        |  4 ----
 target/i386/kvm/kvm_i386.h  |  2 ++
 accel/kvm/kvm-all.c         |  6 ++++--
 target/arm/kvm.c            |  6 ++++--
 target/i386/kvm/kvm-cpu.c   |  2 ++
 target/i386/kvm/kvm.c       |  4 ++--
 target/loongarch/kvm/kvm.c  |  7 +++++--
 target/ppc/kvm.c            |  6 ++++--
 target/riscv/kvm/kvm-cpu.c  |  7 +++++--
 target/s390x/kvm/kvm.c      |  7 +++++--
 11 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index cbd3935ba4d..b3f6b8e47b7 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -12,12 +12,21 @@
 #include "qom/object.h"
 #include "hw/core/cpu.h"
 #include "accel/accel-cpu-target.h"
+#include "system/kvm.h"
 
 struct kvm_run;
 
 /**
  * struct KVMCPUOps - Target-specific per-vCPU operations for KVM
  *
+ * @get_registers: Mandatory callback to synchronize architecture-specific
+ *                 vCPU register state from KVM into QEMU's CPUState.
+ *                 Returns 0 on success, or a negative errno on failure.
+ * @put_registers: Mandatory callback to synchronize architecture-specific
+ *                 vCPU register state from QEMU's CPUState into KVM.
+ *                 The @level parameter specifies whether to write runtime,
+ *                 reset, or full state.
+ *                 Returns 0 on success, or a negative errno on failure.
  * @pre_run: Optional callback executed immediately prior to entering the
  *           KVM_RUN ioctl in the vCPU thread loop. Used by architectures
  *           that need to inject pending events (e.g. x86 NMI/SMI) or verify
@@ -45,6 +54,8 @@ struct kvm_run;
  *                        processing before execution.
  */
 typedef struct KVMCPUOps {
+    int (*get_registers)(CPUState *cpu, Error **errp);
+    int (*put_registers)(CPUState *cpu, KvmPutState level, Error **errp);
     void (*pre_run)(CPUState *cpu, struct kvm_run *run);
     MemTxAttrs (*post_run)(CPUState *cpu, struct kvm_run *run);
     int (*handle_exit)(CPUState *cpu, struct kvm_run *run);
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 8c705d21f79..b2d76f99df0 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -333,8 +333,6 @@ extern const KVMCapabilityInfo kvm_arch_required_capabilities[];
 
 void kvm_arch_accel_class_init(ObjectClass *oc);
 
-int kvm_arch_get_registers(CPUState *cpu, Error **errp);
-
 typedef enum kvm_put_state {
     /* state subset only touched by the VCPU itself during runtime */
     KVM_PUT_RUNTIME_STATE = 1,
@@ -344,8 +342,6 @@ typedef enum kvm_put_state {
     KVM_PUT_FULL_STATE = 3,
 } KvmPutState;
 
-int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp);
-
 int kvm_arch_get_default_type(MachineState *ms);
 
 int kvm_arch_init(MachineState *ms, KVMState *s);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index bff587a56de..2c92afc3320 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -33,6 +33,8 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 
 int kvm_get_vm_type(MachineState *ms);
 void kvm_arch_reset_vcpu(X86CPU *cs);
+int x86_kvm_get_registers(CPUState *cs, Error **errp);
+int x86_kvm_put_registers(CPUState *cpu, KvmPutState level, Error **errp);
 void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run);
 MemTxAttrs x86_kvm_post_run(CPUState *cpu, struct kvm_run *run);
 int x86_kvm_handle_exit(CPUState *cs, struct kvm_run *run);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e8a26a9f067..3de05bb8bb8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3214,8 +3214,9 @@ void kvm_flush_coalesced_mmio_buffer(void)
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
+        const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
         Error *err = NULL;
-        int ret = kvm_arch_get_registers(cpu, &err);
+        int ret = ops->get_registers(cpu, &err);
         if (ret) {
             if (err) {
                 error_reportf_err(err, "Failed to synchronize CPU state: ");
@@ -3241,8 +3242,9 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
 static bool kvm_cpu_synchronize_put(CPUState *cpu, KvmPutState state,
                                     const char *desc)
 {
+    const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
     Error *err = NULL;
-    int ret = kvm_arch_put_registers(cpu, state, &err);
+    int ret = ops->put_registers(cpu, state, &err);
     if (ret) {
         if (err) {
             error_reportf_err(err, "Restoring resisters %s: ", desc);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 06b133ebf53..ea8c4d02ee8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2198,7 +2198,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int arm_kvm_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2383,7 +2383,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int arm_kvm_get_registers(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2661,6 +2661,8 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 }
 
 static const KVMCPUOps arm_kvm_cpu_ops = {
+    .get_registers = arm_kvm_get_registers,
+    .put_registers = arm_kvm_put_registers,
     .pre_run = arm_kvm_pre_run,
     .post_run = arm_kvm_post_run,
     .handle_exit = arm_kvm_handle_exit,
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 163d60a1060..08308ef8a80 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -235,6 +235,8 @@ static void kvm_cpu_instance_init(CPUState *cs)
 }
 
 static const KVMCPUOps x86_kvm_cpu_ops = {
+    .get_registers = x86_kvm_get_registers,
+    .put_registers = x86_kvm_put_registers,
     .pre_run = x86_kvm_pre_run,
     .post_run = x86_kvm_post_run,
     .handle_exit = x86_kvm_handle_exit,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 83c4451cf31..7ee6d3d4f38 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5712,7 +5712,7 @@ static int kvm_get_nested_state(X86CPU *cpu)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp)
+int x86_kvm_put_registers(CPUState *cpu, KvmPutState level, Error **errp)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     int ret;
@@ -5817,7 +5817,7 @@ int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+int x86_kvm_get_registers(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
     int ret;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 600903a2280..1e7565732e8 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -823,7 +823,7 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
     return ret;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int loongarch_kvm_get_registers(CPUState *cs, Error **errp)
 {
     int ret;
 
@@ -861,7 +861,8 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int loongarch_kvm_put_registers(CPUState *cs, KvmPutState level,
+                                       Error **errp)
 {
     int ret;
     static int once;
@@ -1643,6 +1644,8 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 }
 
 static const KVMCPUOps loongarch_kvm_cpu_ops = {
+    .get_registers = loongarch_kvm_get_registers,
+    .put_registers = loongarch_kvm_put_registers,
     .handle_exit = loongarch_kvm_handle_exit,
     .process_async_events = loongarch_kvm_process_async_events,
 };
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index e52f0b84ee3..25f797cb2d8 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -908,7 +908,7 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_SREGS, &sregs);
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int ppc_kvm_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
@@ -1213,7 +1213,7 @@ static int kvmppc_get_books_sregs(PowerPCCPU *cpu)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int ppc_kvm_get_registers(CPUState *cs, Error **errp)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
@@ -3073,6 +3073,8 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 }
 
 static const KVMCPUOps ppc_kvm_cpu_ops = {
+    .get_registers = ppc_kvm_get_registers,
+    .put_registers = ppc_kvm_put_registers,
     .handle_exit = ppc_kvm_handle_exit,
     .process_async_events = ppc_kvm_process_async_events,
 };
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index a5333083765..c38c07a563b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1389,7 +1389,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int riscv_kvm_get_registers(CPUState *cs, Error **errp)
 {
     int ret = 0;
 
@@ -1444,7 +1444,8 @@ static int kvm_riscv_put_mp_state(CPUState *cs)
     return kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int riscv_kvm_put_registers(CPUState *cs, KvmPutState level,
+                                   Error **errp)
 {
     int ret = 0;
 
@@ -2183,6 +2184,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 }
 
 static const KVMCPUOps riscv_kvm_cpu_ops = {
+    .get_registers = riscv_kvm_get_registers,
+    .put_registers = riscv_kvm_put_registers,
     .handle_exit = riscv_kvm_handle_exit,
 };
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 420703f7683..c85d286288b 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -471,7 +471,8 @@ static int can_sync_regs(CPUState *cs, int regs)
                                 KVM_SYNC_CRS | KVM_SYNC_PREFIX | \
                                 KVM_SYNC_PFAULT)
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int s390x_kvm_put_registers(CPUState *cs, KvmPutState level,
+                                   Error **errp)
 {
     CPUS390XState *env = cpu_env(cs);
     struct kvm_fpu fpu = {};
@@ -582,7 +583,7 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int s390x_kvm_get_registers(CPUState *cs, Error **errp)
 {
     CPUS390XState *env = cpu_env(cs);
     struct kvm_fpu fpu;
@@ -2650,6 +2651,8 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 }
 
 static const KVMCPUOps s390x_kvm_cpu_ops = {
+    .get_registers = s390x_kvm_get_registers,
+    .put_registers = s390x_kvm_put_registers,
     .handle_exit = s390x_kvm_handle_exit,
     .process_async_events = s390x_kvm_process_async_events,
 };
-- 
2.47.3

