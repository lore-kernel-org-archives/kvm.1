Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493008;
	b=3aW9FUm+5YCvesxYyFa1aS/sOdCWIZn0OrMFc1SAGcP+adeMx269nmqSSgCdy7aCbsIQ
	 SXgyfuIWNzJYCfWLPAg/rdHsVD1E7lnn4A2ZI8pqcTtTmVuP/gLqN91tqUgUFkdQrZUA+
	 z1H7EmrmEBwGYKVPJN9mTZ3jBjytJQj/9bNX6v6AuJNc3RVVGpLqy09LPMBxQ0dQjhRZG
	 UpL8r0NHR183WhDfvV9Y9hEu0XtuSaduY6f5REHTgq0CO2B7pc58vl+HF70zZG1Y9JLok
	 vCYtYBQnXv/gyywdlzNsJC5HZ9u9xX39/21J5C81W3HAGgi503fEAoZBRz64hsAH3Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XaCIspnOiGUcI2BoHO8g5A8hP2lh454sdkCiT2j/ODo=;
	b=UBEdqJbNRDI0Qv4Oc2tWgPlpq0v+F4HCAdkLHKpI+QcpFga9vh5UbF/R3ctDPVfV5oPP
	 aPRQs1iSYITXOlkBbaegZM8vBG+6N0xOQResBOjNYOIYywvY+74JzaKyKLzc5x2nXMpv/
	 bDFHFd+C6c7Q6Tulm0lWCpsHthhPB84cSQgE+aPde2p68Od5rA3KOvz2ymA29w1hXKMCW
	 IhGQWHqXtvJRVl1SOz95aZrQjMi5fGp3Xh8JyFk/g6jTQHcs/JNah6dfMcNqsjjjbCGab
	 ODktH1kiZ3hTtGqQwwVzLAADWNT8/PKz4SPbnngsAznhnRVkSdXbf0rMzzueCawaDsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VokRk0Y1;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427060A2607
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1427060A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VokRk0Y1
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2032279f8f.2
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493006; x=1793097806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XaCIspnOiGUcI2BoHO8g5A8hP2lh454sdkCiT2j/ODo=;
        b=VokRk0Y1gKvX4VO3g6pF3zWMHz7nHc1tNeJ9Pqla4fbm4HbiniRNFrHhahAWd/MmnB
         +S3uLh12U6Tu86YpCDXwF5A5mNVvMKtO0wNxR6T4JaWacAKnKVrwQgfm6sGgN3dJJ6d1
         C/czJp4rTYVm2c2gV4sYo4o3tAF4+c/qVCYcciPTXAtdTpbLthK9fhPvAOHpJ6tpdz69
         Hpj9i8DFB3PC8SFT6G7GfNcGvXm+W8luYIjF2rxOzn6726Ibsn06viZBTyRVRQBk5Lfy
         fmaRiIov7JgWWQXsn8w5+8EbsJtvXrTGVkaGnzynlGTgn9/02lD8X3N5GxrqERgIyS4M
         vmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493006; x=1793097806;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XaCIspnOiGUcI2BoHO8g5A8hP2lh454sdkCiT2j/ODo=;
        b=P8m4SqT+ZLtBrj5IXaCDJfHftzKtS5bYSg1zogm94+jL0hKNM05EGQqiumUQeTE5jf
         2gAjZEahOExG4ZtNzcMM/6Wqb6HpnKxoe4KgaqPK59p95El3ODs2eguHK+ykLdjHJCWt
         PZU5Sagh5QFS593uFsHq7oi1H6tXNID0+3hzSfUzq8HCdQnsVkZ/QpLQHgLkdyBPVANd
         LC47cUm37OJe/d2zsPG078Izo2Ii6vUgQJuA7zN4xe1oxxWOq9IOXdiYIK1EkBwRU5iw
         upTqFwbMG/6hXwftyQF7tPC+OXfzfvHbih6BAVRJ4Ybt2uNOifaTV84UdU3z0L6O8/2Q
         uvag==
X-Forwarded-Encrypted: i=1; AKwUvBxea6Wa23rNUhHuuyZPLRpWoqa+B7wDDr3zFYQE2C2Ok0sZ/r2a1zIzNzPPqxbKerWoRi8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfjMlyi3eUMpHTx1qtekNzJFoVh+OP2uWHkZISLB0UWHXPg6EE
	5ELU4gXFyXpuQXd2Udg8dJLnKYwz6b20VR+3EHah57NbllTRcWP69FwnkhlxDG/6pvA=
X-Gm-Gg: AYBFou1MHRR/1UfQM0HgezlG9Wffudsio7LcAyn7DA+fQiWzT65fBJ5zuhHKck9jo2O
	t1mU+4nkSQ0sVU64gdLlh1pqb+CK7/VBajLAi8/y4SjME5fml7LcxPXPdpCzlFnjM6h9BvMgXJF
	XA4AldU30YCKqNg8+mOyngJ4T+pQcDmmG22vSc3FXoyC0pkg4pLnPjCBMUdtkZ+pUMtOXzIT0KP
	LcN3VHzK5CdKZHZMdT1AVwdXxhNIEzRRUDZ/1BnsDbc6n4w+satpqVzCP/P5LxYxT6mgO0ZMu9M
	3qtB3cNZEfdgg2cfZUPrrGOXcYUEoGnRvGpJwJToJKHjd5iDslabTmCfSzjxWFTAprQxnhS8uqH
	YVktZulSM1sfRJqxDLyzF6b8UTpORJK7L2sBC09N8UPE1CbHrbes6vOjsPoVTNkbxFPZjLVWoV4
	UGCVJS5D2VYCedHRNrNpujLmwDqt4FgW2lC80gnu68rqT1BEI9kWu1knIVD+XL+CocY/AACujPq
	EQcHZfz
X-Received: by 2002:adf:e001:0:10b0:48d:f876:f370 with SMTP id ffacd0b85a97d-48e1bdf80a0mr4553512f8f.48.1792493006379;
        Tue, 20 Oct 2026 03:43:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820714sm5176611f8f.35.2026.10.20.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 871EE5FB54;
	Tue, 20 Oct 2026 11:43:21 +0100 (BST)
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
Subject: [PATCH 09/23] accel/kvm: port kvm_arch_post_run to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:03 +0100
Message-ID: <20261020104320.3686723-10-alex.bennee@linaro.org>
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

Again not all arches do something for this so default to set
MEMTXATTRS_UNSPECIFIED for any potential MMIO we might handle next.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 8 ++++++++
 include/system/kvm.h        | 2 --
 target/i386/kvm/kvm_i386.h  | 1 +
 accel/kvm/kvm-all.c         | 6 +++++-
 target/arm/kvm.c            | 3 ++-
 target/i386/kvm/kvm-cpu.c   | 1 +
 target/i386/kvm/kvm.c       | 2 +-
 target/loongarch/kvm/kvm.c  | 5 -----
 target/ppc/kvm.c            | 5 -----
 target/riscv/kvm/kvm-cpu.c  | 5 -----
 target/s390x/kvm/kvm.c      | 5 -----
 11 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index 2c04fa5adf5..e74081eb133 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -23,9 +23,17 @@ struct kvm_run;
  *           that need to inject pending events (e.g. x86 NMI/SMI) or verify
  *           injected exceptions (e.g. ARM external data aborts).
  *           May be NULL if the target does not require pre-run handling.
+ * @post_run: Optional callback executed immediately after the KVM_RUN ioctl
+ *            returns in the vCPU thread loop. Used by architectures to
+ *            inspect or process hardware registers/flags (e.g. x86 APIC/TPR
+ *            or ARM timer interrupt synchronization) and return the
+ *            #MemTxAttrs to use for handling MMIO exits.
+ *            May be NULL if the target does not require post-run handling,
+ *            in which case MEMTXATTRS_UNSPECIFIED is assumed.
  */
 typedef struct KVMCPUOps {
     void (*pre_run)(CPUState *cpu, struct kvm_run *run);
+    MemTxAttrs (*post_run)(CPUState *cpu, struct kvm_run *run);
 } KVMCPUOps;
 
 #define TYPE_KVM_ACCEL_CPU "kvm-accel-cpu"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index e9d7b86ea4a..82785d37600 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -333,8 +333,6 @@ extern const KVMCapabilityInfo kvm_arch_required_capabilities[];
 
 void kvm_arch_accel_class_init(ObjectClass *oc);
 
-MemTxAttrs kvm_arch_post_run(CPUState *cpu, struct kvm_run *run);
-
 int kvm_arch_handle_exit(CPUState *cpu, struct kvm_run *run);
 
 int kvm_arch_process_async_events(CPUState *cpu);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 218ae8f09ce..6fb1da6a40c 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -34,6 +34,7 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 int kvm_get_vm_type(MachineState *ms);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run);
+MemTxAttrs x86_kvm_post_run(CPUState *cpu, struct kvm_run *run);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4dca5467f4a..41229774068 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3500,7 +3500,11 @@ int kvm_cpu_exec(CPUState *cpu)
          * as true, cpu->exit_request will always read as true.
          */
 
-        attrs = kvm_arch_post_run(cpu, run);
+        if (ops->post_run) {
+            attrs = ops->post_run(cpu, run);
+        } else {
+            attrs = MEMTXATTRS_UNSPECIFIED;
+        }
 
 #ifdef KVM_HAVE_MCE_INJECTION
         if (unlikely(have_sigbus_pending)) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4475fd1a9d9..d5f9b7c088c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1404,7 +1404,7 @@ static void arm_kvm_pre_run(CPUState *cs, struct kvm_run *run)
     }
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
+static MemTxAttrs arm_kvm_post_run(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu;
     uint32_t switched_level;
@@ -2667,6 +2667,7 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 
 static const KVMCPUOps arm_kvm_cpu_ops = {
     .pre_run = arm_kvm_pre_run,
+    .post_run = arm_kvm_post_run,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index eab5ab46d45..64af85cd113 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -236,6 +236,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
 
 static const KVMCPUOps x86_kvm_cpu_ops = {
     .pre_run = x86_kvm_pre_run,
+    .post_run = x86_kvm_post_run,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e9bcda70dac..a1b91d502f0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5995,7 +5995,7 @@ static void kvm_rate_limit_on_bus_lock(void)
     }
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cpu, struct kvm_run *run)
+MemTxAttrs x86_kvm_post_run(CPUState *cpu, struct kvm_run *run)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index b8fb2094062..192538c0aa9 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1517,11 +1517,6 @@ int kvm_arch_irqchip_create(KVMState *s)
     return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
-{
-    return MEMTXATTRS_UNSPECIFIED;
-}
-
 int kvm_arch_process_async_events(CPUState *cs)
 {
     return cs->halted;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 17b16e33881..5ef4722cd6f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1336,11 +1336,6 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
     return 0;
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
-{
-    return MEMTXATTRS_UNSPECIFIED;
-}
-
 int kvm_arch_process_async_events(CPUState *cs)
 {
     return cs->halted;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 8575e673811..9580b6c1b20 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1640,11 +1640,6 @@ int kvm_arch_process_async_events(CPUState *cs)
     return 0;
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
-{
-    return MEMTXATTRS_UNSPECIFIED;
-}
-
 bool kvm_arch_stop_on_emulation_error(CPUState *cs)
 {
     return true;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 827816e5b98..ad1145c4ec1 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -984,11 +984,6 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
     }
 }
 
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
-{
-    return MEMTXATTRS_UNSPECIFIED;
-}
-
 int kvm_arch_process_async_events(CPUState *cs)
 {
     return cs->halted;
-- 
2.47.3

