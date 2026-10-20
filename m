Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493015;
	b=ck6onF76nOUi5dziuLR2+r2W0XhDDRwBUkCljquNUY1KwkuBDr69x+6fheEj0nhtgZRW
	 TLxpUMKrpvZeejFSQg9AOBtPEDgz4PvR/B9sUvHP9mBgzvPAB8DgKgj4dkePdcJt6wBQ1
	 71vBiDTrQcnCpSrRiUEYb9KprmDZGxG3LlLPwjOpxcJB2B4MMKEg7KHJkLTxudm52pNME
	 6ZdLFdUhMsHKfvTnm5BDK1XarYrA8yeicMov8eeAV8xyFT7s8P7Dx3PUoBFCmVc4LNyAu
	 2EmUfNai0P96+PXYaq68md/QpIsMxmqKTXSrbcEvBcOpjb42/9pPsDOzFOar518rJWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QWwoMa4UZtGGfww2XLbb/N5Nn1L+rU0o0RKmqlS3tj4=;
	b=izVpKFTRGUx/33s9U/2hxQXJKRQDhm6eRVEhsdkGwzmOe3HDODy2xCU0LR6RlBfoa9DM
	 lsmdl8ZDDivc7a/LqdUf71k16lhOB3WwrWqZ4xu1M36wJtlmSJVzwdwTu45sYWrkP5XQg
	 GlC8iRsk9Se5dI33ZfYngrLg9Qpmihf1r/2QxKyxuO7KKhdBXwMAm4UTypZV+xbyCHxyO
	 TYcLEBMLNh7cErqEiTD48evqu5A3LRHE0FIAZIl5DjeLeKmiHpL63YEkn+vqcXbis71S9
	 CzGfEAoXMWJ2fccUq+kuoxxUdY2a8PZh+nrE+vxU3ziMfqf5VYPzjoI+NLu4/B5UaIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rSrFegMk;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E2606A33C
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 996E2606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rSrFegMk
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so38014805e9.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493013; x=1793097813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QWwoMa4UZtGGfww2XLbb/N5Nn1L+rU0o0RKmqlS3tj4=;
        b=rSrFegMkdDque1mCp9JBlff7OH09R4/5QeCZlDQ1+jTc0ci1KpdgTlC+/MAklXbR5N
         GuT3Y7EVVfNZX+3FtX8XcLDR+1ggpzhWGVjHHfeEVDmeexFKHjYShXlHXec/bkGSs5pd
         xv7ZNNemvH3DbL3pWKFzWDkb/v1rHJG+EaxL0txiEbqPLz34buOMmgcUgvgYdHJ63vyf
         tjV6AlD/nOBvqf3ZgUFQQYHv7krrbG75o7STZhGRvTjQXuokJAWyvbmCFOwqkys2COWO
         VL2OAgsrn7Mtid8pz4F5+TMx7WpRWh983ntxU8khnDlMd0xG6MniSsIRcGWYopxOmOuX
         QhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493013; x=1793097813;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWwoMa4UZtGGfww2XLbb/N5Nn1L+rU0o0RKmqlS3tj4=;
        b=Eg6aiBfkCVKAGnRwaceCEVn2JkUeeIAoATqZvmkd3vthhW6DZoEf7r3Jpo4VY2/xFF
         6V1sqEOb0n6AfhlzP2a8wy9b22ExVA7Kd8h4G42jssihukML3OBDualie+nnU4yTbs6V
         wQNJ3gT+94ZKm4+mkmYuc+Bcxfa+m6ikEGUvfUvEfYlqhr+m+gfKlvOaZ8Cer0Ny24+t
         7SzDksUDiyegS1l3/UcAn2XxM8sCmyZKOVT6PFej/DvX9wN+J1DSB9LVCyyvThkiyTiJ
         QttorqJ6DwkWA9rhWSr4ZqBb2pLFdfvaXSRhJOz43ovttDsWsLp9eEfoSbPbJyHCsgDS
         wJsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGgA0mMWziKgTaMJLMnuDUiKslLXs80emViFMOiSYQWBwRY+7Dq0OFFPA4sdsiUXiFuOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxrOA2MnP5a/R3flKoIpaEVOpEJOeggQp0furMqY/q66qZSgeh
	GMjvfAs1mlEoYsJ/MExwwuA818tdevbKu4XDW+YZQgpGsa2e1xZDoEYndghNWB+Gopk=
X-Gm-Gg: AYBFou2SYQEV6RjH6sq3EwnqRa9gIZA9YkR79zOFTM9cXDo4AREVLF3mn064mF3QXat
	XY7Ld/4zr0kusTCjS/lk9grVma9igxD6TLSI4o4aQJi3hn7e1gAOkp2QFAz4JZqZPdV3gd4gRM1
	ZobaNNN3St2p4UZYdQKqLbH8TRB+LSwlhlqUtQzrhoMxc8JRrozyEeiVxlmK2lS3iXLgRwa4zyu
	riVVInpROAo1eANu9GnIznTgcfFa3f2wF1+47cE+3aG3jL+TKBzdjo7zZ3aZd61j+dW1L/ov8gg
	31mlhiGLYNntzPZiPhwvaksyjZl50mctv+JJnV571zoFJsQ/ug3lrl6b2UCav+pCwOgN6uLh500
	tffxZVk0O4vKsmBPsnZbwYe9lJne36oecy+fHmcN/SvJOSFnwtOwlphRX+FvfmR0jsngeSv48wm
	KlIkTtzgi6huUkdySnp64tnwroJygbHcRzZLXAwGPyWSooy12NypgBEk3NOFglYApVP4Chjv9Ly
	bFFwYqA
X-Received: by 2002:a05:600c:3547:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4a1d7608dcemr216790035e9.16.1792493012821;
        Tue, 20 Oct 2026 03:43:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dc034sm4931794f8f.3.2026.10.20.03.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id EF4CC5F915;
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
Subject: [PATCH 15/23] accel/kvm: port kvm_arch_destroy_vcpu to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:09 +0100
Message-ID: <20261020104320.3686723-16-alex.bennee@linaro.org>
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

Not every architecture was doing something here so we can make it an
optional hook.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h |  6 ++++++
 include/system/kvm.h        |  2 --
 target/i386/kvm/kvm_i386.h  |  1 +
 accel/kvm/kvm-all.c         | 17 +++++++++++------
 target/arm/kvm.c            |  5 -----
 target/i386/kvm/kvm-cpu.c   |  1 +
 target/i386/kvm/kvm.c       |  2 +-
 target/loongarch/kvm/kvm.c  |  3 ++-
 target/ppc/kvm.c            |  5 -----
 target/riscv/kvm/kvm-cpu.c  |  5 -----
 target/s390x/kvm/kvm.c      |  3 ++-
 11 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index 23557a42ba7..171568e08cb 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -28,6 +28,11 @@ struct kvm_run;
  * @init_vcpu: Mandatory callback executed to perform architecture-specific
  *             initialization of a newly created KVM vCPU.
  *             Returns 0 on success, or a negative errno on failure.
+ * @destroy_vcpu: Optional callback executed when destroying a KVM vCPU
+ *                (e.g. to free architecture-specific buffers or deregister
+ *                state change handlers).
+ *                May be NULL if no architecture-specific cleanup is required.
+ *                Returns 0 on success, or a negative errno on failure.
  * @get_registers: Mandatory callback to synchronize architecture-specific
  *                 vCPU register state from KVM into QEMU's CPUState.
  *                 Returns 0 on success, or a negative errno on failure.
@@ -65,6 +70,7 @@ struct kvm_run;
 typedef struct KVMCPUOps {
     int (*pre_create_vcpu)(CPUState *cpu, Error **errp);
     int (*init_vcpu)(CPUState *cpu);
+    int (*destroy_vcpu)(CPUState *cpu);
     int (*get_registers)(CPUState *cpu, Error **errp);
     int (*put_registers)(CPUState *cpu, KvmPutState level, Error **errp);
     void (*pre_run)(CPUState *cpu, struct kvm_run *run);
diff --git a/include/system/kvm.h b/include/system/kvm.h
index a722f266dae..a66344cc70c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -346,8 +346,6 @@ int kvm_arch_get_default_type(MachineState *ms);
 
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
-int kvm_arch_destroy_vcpu(CPUState *cpu);
-
 #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
 void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
 #else
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 8af5a9dc0ef..c7ffed75c1d 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -35,6 +35,7 @@ int kvm_get_vm_type(MachineState *ms);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 int x86_kvm_pre_create_vcpu(CPUState *cpu, Error **errp);
 int x86_kvm_init_vcpu(CPUState *cs);
+int x86_kvm_destroy_vcpu(CPUState *cs);
 int x86_kvm_get_registers(CPUState *cs, Error **errp);
 int x86_kvm_put_registers(CPUState *cpu, KvmPutState level, Error **errp);
 void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d877edaa5e8..69117271fa3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -468,9 +468,11 @@ static int kvm_rebind_vcpus(Error **errp)
             close(cpu->kvm_fd);
         }
 
-        ret = kvm_arch_destroy_vcpu(cpu);
-        if (ret < 0) {
-            goto err;
+        if (ops->destroy_vcpu) {
+            ret = ops->destroy_vcpu(cpu);
+            if (ret < 0) {
+                goto err;
+            }
         }
 
         if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
@@ -647,14 +649,17 @@ static int vcpu_unmap_regions(KVMState *s, CPUState *cpu)
 
 static int do_kvm_destroy_vcpu(CPUState *cpu)
 {
+    const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
     KVMState *s = kvm_state;
     int ret = 0;
 
     trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
-    ret = kvm_arch_destroy_vcpu(cpu);
-    if (ret < 0) {
-        goto err;
+    if (ops->destroy_vcpu) {
+        ret = ops->destroy_vcpu(cpu);
+        if (ret < 0) {
+            goto err;
+        }
     }
 
     /* If I am the CPU that created coalesced_mmio_ring, then discard it */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b62f40623c3..042a075e612 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2093,11 +2093,6 @@ static int arm_kvm_init_vcpu(CPUState *cs)
     return kvm_arm_init_cpreg_list(cpu);
 }
 
-int kvm_arch_destroy_vcpu(CPUState *cs)
-{
-    return 0;
-}
-
 /* Callers must hold the iothread mutex lock */
 static void kvm_inject_arm_sea(CPUState *c)
 {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 6c547f204f8..8d250b3a847 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -237,6 +237,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
 static const KVMCPUOps x86_kvm_cpu_ops = {
     .pre_create_vcpu = x86_kvm_pre_create_vcpu,
     .init_vcpu = x86_kvm_init_vcpu,
+    .destroy_vcpu = x86_kvm_destroy_vcpu,
     .get_registers = x86_kvm_get_registers,
     .put_registers = x86_kvm_put_registers,
     .pre_run = x86_kvm_pre_run,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 46b7e497aaf..a8109004e43 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2533,7 +2533,7 @@ int x86_kvm_init_vcpu(CPUState *cs)
     return r;
 }
 
-int kvm_arch_destroy_vcpu(CPUState *cs)
+int x86_kvm_destroy_vcpu(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 8f2ceb50a78..6705e6698bd 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1437,7 +1437,7 @@ void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
                                     "Set off to disable KVM steal time.");
 }
 
-int kvm_arch_destroy_vcpu(CPUState *cs)
+static int loongarch_kvm_destroy_vcpu(CPUState *cs)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
 
@@ -1640,6 +1640,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 
 static const KVMCPUOps loongarch_kvm_cpu_ops = {
     .init_vcpu = loongarch_kvm_init_vcpu,
+    .destroy_vcpu = loongarch_kvm_destroy_vcpu,
     .get_registers = loongarch_kvm_get_registers,
     .put_registers = loongarch_kvm_put_registers,
     .handle_exit = loongarch_kvm_handle_exit,
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 075999b553a..cb461963713 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -524,11 +524,6 @@ static int ppc_kvm_init_vcpu(CPUState *cs)
     return ret;
 }
 
-int kvm_arch_destroy_vcpu(CPUState *cs)
-{
-    return 0;
-}
-
 static void kvm_sw_tlb_put(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b202882a155..4247cbec3d9 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1512,11 +1512,6 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     return 0;
 }
 
-int kvm_arch_destroy_vcpu(CPUState *cs)
-{
-    return 0;
-}
-
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
 {
     return cpu->cpu_index;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 478b21a57fd..0dcd198afe3 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -409,7 +409,7 @@ static int s390x_kvm_init_vcpu(CPUState *cs)
     return 0;
 }
 
-int kvm_arch_destroy_vcpu(CPUState *cs)
+static int s390x_kvm_destroy_vcpu(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
 
@@ -2647,6 +2647,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 
 static const KVMCPUOps s390x_kvm_cpu_ops = {
     .init_vcpu = s390x_kvm_init_vcpu,
+    .destroy_vcpu = s390x_kvm_destroy_vcpu,
     .get_registers = s390x_kvm_get_registers,
     .put_registers = s390x_kvm_put_registers,
     .handle_exit = s390x_kvm_handle_exit,
-- 
2.47.3

