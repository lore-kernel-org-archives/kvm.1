Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493019;
	b=O4AwmhUi69esiDF5LPhGtgesXJAQdlH005Zi9/GpDLgAeutqx8n5q/wXP4RBXVAxgnQE
	 e1+rnL1YZXx1owKX+3FC44b44efGYi56ovV7XamHrt9aKtCnraEaOzVqX2hWkt+BBbchI
	 aOxyJj84kjU38mrRucghrz7fF4SUN3UtHxiOKLwqWP4lI45BpfA6VipINKB/vkMGptsPy
	 gzlOGBUP2s+liWipSXdkg280IQ9BWzSAH6DHPTWxmp0s4sHqrWK0/HtDGzPlGqyp6YCZf
	 iOP54/Ow7VJoyoY6hKSju4IJbjXQLPr4J+fDpZkFAj2sFqgb+wpW6F1PFgpdhn8A4kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CI4y4+8QDNrII/yQJeeQ7eR8U6iPwLtUl1oInnwM8Os=;
	b=t7n4qEUK37sYOtoOgPf05xbtcD2MzBFiWm0Ndoa6jvpNpnO0q216OPnQj8tqGcrvYoxz
	 xrRNFCVsM5dX2/yqpQsc+3v3F56tayUzM4WkHgTouRahnhqv43D3CYya69FIO07P1/Mmf
	 0S1df4fS0CEnz6l9zuQ3uDdU5rQVhXXrpQMM6EolXttV65b3JlCWHCg88ZwW2PFoM5G0y
	 5C5Gh3OAAW0H+zK+AH+BCEeu8v7cp2153DHHcl52pwzV+SjmFnHZOfgmvO8guuzrM3bjI
	 xvkrfLgu0wxK17aYqqf9jklRW/nlbzxRaz9NZeBAsBOD6XRnyfO2BRvHGHGbzeorVAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i+qVVc8n;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B160A5BDF
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC0B160A5BDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i+qVVc8n
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e10a70540so1300567f8f.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493017; x=1793097817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CI4y4+8QDNrII/yQJeeQ7eR8U6iPwLtUl1oInnwM8Os=;
        b=i+qVVc8naYo1LGoNXRIPwQbelxRlhtybCEvFXv8JujMvSocE1LkA2uBNxVhExpWsDB
         V5YOLaBRs5H9+iN/QImdtWZjAQ+HFYFOvohaJSoCQZaJYZR8Bj9S75S7iOOgeerKbDqK
         QhNepZLsC/OI01/6fj3jlB/0BlfWXsZLH+6OsfFJkxi3VeBsV1eUAN5ba7KqD9d0f6Ue
         MofqPCSDYpFj4ysK6h5/nZUJjQfpRkQC2zYpiekf9tRB1UC8Gzo5fwk488voRMP7Pnzn
         eqr0nhm6EumJXvW0TNc+OFCz//T1NrVw/SAuIrcAS5gGxoJ/FHDFx/fRROqdcCO+p4xt
         bzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493017; x=1793097817;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CI4y4+8QDNrII/yQJeeQ7eR8U6iPwLtUl1oInnwM8Os=;
        b=EJnqF5nv0rUZtyCB6DBJi/iIiRGwBfyA600RULXos+pfp/Vn0H+s3lx50WAqzmJIXE
         +jLS5UBt/d2saYaOi06XJatVPCwjHpLpwcGHu1kMs2rYMi+xm1B3uf7+hnVbXo17kGdy
         MpdAtguDkwRBFCnoq94+feTCx/YaGsA4Lg/WFl3jGAH07fIVzlZEOfcjEiMJVbn3ty74
         l+qmw4+s/RgXILx4CSQaRDJcxAA5feS4woZUcCJngFklvLVou+PzQqWI1NFhuqlZ2Qia
         btWZvsidPqseSm4e6pGiCuxJMavNeV+05TIKjptZsCBy8NLawLXub4p/Ig9A8LexQ5Z+
         CG5g==
X-Forwarded-Encrypted: i=1; AKwUvBwlG8P+ofIVSkjhD3QkRcG4NJQG5W+F2ENleDc6luFDmxFLFnrVcuu40utKqNSdKXMHlvQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJS4X0wBZ0w6TzQX9tcPdpKJJn8B8WW1Y4cD+DaJcNwqlXPrzmA
	23gtX4A7gIcj1Fn3VESEsX/sn/kb490QyaNIHUoB5Q/QBlXUJpameGTjC+ng6XBs1gU=
X-Gm-Gg: AYBFou3prZJnlvs7yQ6GezvXgyON9g5BMTbBG0DrGvVlxp8CKdFUGcLIPcVR0buG4bH
	C+M+LDUw/YomWlat3Tgm1XLPI5+ENv+ESflgVsc3Qhzip+jhvBfjWJyDLBRgdZb2iwZa/r5JcMm
	X5v4S7pXKtLvGIYSmrvvh/h4g1eBKVqH8bYEIiD0bsUrPFeb3GOsoh4KNd/jnFJS623ghr3tIRk
	1KYYFLH7pifLJvePt7a0J/Y9twYOVJQiCtGXIgLVODWmXawBtQ+ckc3HKQl8Q77fuf1/riefoAW
	LvkeQ/UZmFMxCNuFFY5Pv754yZLMKSDIo2dYW9XP6G016n6f+vo5O26lN4RLPF68FOodVr+i6fq
	/DFlvAKi6DQMM5Mo1Yovv/emKYLXoL/sTgk0/UD4dreOP4S7hnXk0SkMfmHIQrEp/N4bgZO4n0z
	1I5W4VHiVX5CMiKxIhbpitRiEhfZCndc5EpxraTL1xh8WvWNYTwxUA35gu/awvc8M9Q4xZiP8ME
	F7FkUEj
X-Received: by 2002:a05:6000:4a0e:b0:48b:1119:5756 with SMTP id ffacd0b85a97d-48e07bbd34bmr18765919f8f.17.1792493017263;
        Tue, 20 Oct 2026 03:43:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80feb1sm5497671f8f.12.2026.10.20.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id B7A725FE0E;
	Tue, 20 Oct 2026 11:43:23 +0100 (BST)
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
Subject: [PATCH 18/23] accel/kvm: port kvm_arch_[insert|remove]_hw_breakpoints to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:12 +0100
Message-ID: <20261020104320.3686723-19-alex.bennee@linaro.org>
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

We are able to eliminate some NOP implementations with a default
fallback.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 15 +++++++++++++++
 include/system/kvm.h        |  6 ------
 target/i386/kvm/kvm_i386.h  |  5 +++++
 accel/kvm/kvm-all.c         | 18 ++++++++++++++----
 target/arm/kvm.c            | 13 ++++++++-----
 target/i386/kvm/kvm-cpu.c   |  3 +++
 target/i386/kvm/kvm.c       | 10 +++++-----
 target/loongarch/kvm/kvm.c  | 16 ----------------
 target/ppc/kvm.c            | 13 ++++++++-----
 target/riscv/kvm/kvm-cpu.c  | 19 -------------------
 target/s390x/kvm/kvm.c      |  9 ++++++---
 11 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index d2374e91cef..23a83eee6ed 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -85,6 +85,16 @@ struct kvm_run;
  *                        software breakpoint, restoring @bp->saved_insn at
  *                        @bp->pc.
  *                        Returns 0 on success, or a negative errno on failure.
+ * @insert_hw_breakpoint: Optional callback to insert an architecture-specific
+ *                        hardware breakpoint or watchpoint at address @addr
+ *                        with length @len and type @type.
+ *                        Returns 0 on success, or a negative errno on failure.
+ * @remove_hw_breakpoint: Optional callback to remove an architecture-specific
+ *                        hardware breakpoint or watchpoint at address @addr
+ *                        with length @len and type @type.
+ *                        Returns 0 on success, or a negative errno on failure.
+ * @remove_all_hw_breakpoints: Optional callback to remove all architecture-
+ *                             specific hardware breakpoints and watchpoints.
  */
 typedef struct KVMCPUOps {
     int (*pre_create_vcpu)(CPUState *cpu, Error **errp);
@@ -100,6 +110,11 @@ typedef struct KVMCPUOps {
     void (*update_guest_debug)(CPUState *cpu, struct kvm_guest_debug *dbg);
     int (*insert_sw_breakpoint)(CPUState *cpu, struct kvm_sw_breakpoint *bp);
     int (*remove_sw_breakpoint)(CPUState *cpu, struct kvm_sw_breakpoint *bp);
+    int (*insert_hw_breakpoint)(CPUState *cpu, vaddr addr, vaddr len,
+                                GdbBreakpointType type);
+    int (*remove_hw_breakpoint)(CPUState *cpu, vaddr addr, vaddr len,
+                                GdbBreakpointType type);
+    void (*remove_all_hw_breakpoints)(CPUState *cpu);
 } KVMCPUOps;
 
 #define TYPE_KVM_ACCEL_CPU "kvm-accel-cpu"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 52b7a63a0b3..cfc0144d9a5 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -394,12 +394,6 @@ struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
 
 int kvm_sw_breakpoints_active(CPUState *cpu);
 
-int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type);
-int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type);
-void kvm_arch_remove_all_gdbstub_hw_breakpoints(void);
-
 bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
 
 int kvm_vm_check_extension(KVMState *s, unsigned int extension);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 27eea1f65ff..e2ae601100c 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -46,6 +46,11 @@ int x86_kvm_process_async_events(CPUState *cs);
 void x86_kvm_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg);
 int x86_kvm_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp);
 int x86_kvm_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp);
+int x86_kvm_insert_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
+                                 GdbBreakpointType type);
+int x86_kvm_remove_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
+                                 GdbBreakpointType type);
+void x86_kvm_remove_all_hw_breakpoints(CPUState *cs);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 24ded4b1804..3bd61264a7e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3917,7 +3917,12 @@ int kvm_insert_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
 
         QTAILQ_INSERT_HEAD(&cpu->kvm_state->kvm_sw_breakpoints, bp, entry);
     } else {
-        err = kvm_arch_insert_gdbstub_hw_breakpoint(addr, len, type);
+        const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
+
+        if (!ops || !ops->insert_hw_breakpoint) {
+            return -ENOSYS;
+        }
+        err = ops->insert_hw_breakpoint(cpu, addr, len, type);
         if (err) {
             return err;
         }
@@ -3937,9 +3942,9 @@ int kvm_remove_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
 {
     struct kvm_sw_breakpoint *bp;
     int err;
+    const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
 
     if (type == GDB_BREAKPOINT_SW) {
-        const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
 
         bp = kvm_find_sw_breakpoint(cpu, addr);
         if (!bp) {
@@ -3963,7 +3968,10 @@ int kvm_remove_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
         QTAILQ_REMOVE(&cpu->kvm_state->kvm_sw_breakpoints, bp, entry);
         g_free(bp);
     } else {
-        err = kvm_arch_remove_gdbstub_hw_breakpoint(addr, len, type);
+        if (!ops || !ops->remove_hw_breakpoint) {
+            return -ENOSYS;
+        }
+        err = ops->remove_hw_breakpoint(cpu, addr, len, type);
         if (err) {
             return err;
         }
@@ -4005,7 +4013,9 @@ void kvm_remove_all_gdbstub_breakpoints(CPUState *cpu)
         QTAILQ_REMOVE(&s->kvm_sw_breakpoints, bp, entry);
         g_free(bp);
     }
-    kvm_arch_remove_all_gdbstub_hw_breakpoints();
+    if (ops && ops->remove_all_hw_breakpoints) {
+        ops->remove_all_hw_breakpoints(cpu);
+    }
 
     CPU_FOREACH(cpu) {
         kvm_update_guest_debug(cpu, 0);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a4f063f2efb..5c0ccfc11cd 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1821,8 +1821,8 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
         "Eager Page Split chunk size for hugepages. (default: 0, disabled)");
 }
 
-int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type)
+static int arm_kvm_insert_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
+                                         GdbBreakpointType type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -1837,8 +1837,8 @@ int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
     }
 }
 
-int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type)
+static int arm_kvm_remove_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
+                                         GdbBreakpointType type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -1852,7 +1852,7 @@ int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
     }
 }
 
-void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
+static void arm_kvm_remove_all_hw_breakpoints(CPUState *cs)
 {
     if (cur_hw_wps > 0) {
         g_array_remove_range(hw_watchpoints, 0, cur_hw_wps);
@@ -2658,6 +2658,9 @@ static const KVMCPUOps arm_kvm_cpu_ops = {
     .update_guest_debug = arm_kvm_update_guest_debug,
     .insert_sw_breakpoint = arm_kvm_insert_sw_breakpoint,
     .remove_sw_breakpoint = arm_kvm_remove_sw_breakpoint,
+    .insert_hw_breakpoint = arm_kvm_insert_hw_breakpoint,
+    .remove_hw_breakpoint = arm_kvm_remove_hw_breakpoint,
+    .remove_all_hw_breakpoints = arm_kvm_remove_all_hw_breakpoints,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 0cd0884be30..baaee0c7e71 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -248,6 +248,9 @@ static const KVMCPUOps x86_kvm_cpu_ops = {
     .update_guest_debug = x86_kvm_update_guest_debug,
     .insert_sw_breakpoint = x86_kvm_insert_sw_breakpoint,
     .remove_sw_breakpoint = x86_kvm_remove_sw_breakpoint,
+    .insert_hw_breakpoint = x86_kvm_insert_hw_breakpoint,
+    .remove_hw_breakpoint = x86_kvm_remove_hw_breakpoint,
+    .remove_all_hw_breakpoints = x86_kvm_remove_all_hw_breakpoints,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4ee7f53c2a8..78c06a07bd6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6176,8 +6176,8 @@ static int find_hw_breakpoint(target_ulong addr, int len, GdbBreakpointType type
     return -1;
 }
 
-int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type)
+int x86_kvm_insert_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
+                                 GdbBreakpointType type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -6217,8 +6217,8 @@ int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
     return 0;
 }
 
-int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type)
+int x86_kvm_remove_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
+                                 GdbBreakpointType type)
 {
     int n;
 
@@ -6232,7 +6232,7 @@ int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
     return 0;
 }
 
-void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
+void x86_kvm_remove_all_hw_breakpoints(CPUState *cs)
 {
     nb_hw_breakpoint = 0;
 }
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 0899aef552e..b15f60bd2c3 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1551,22 +1551,6 @@ static int loongarch_kvm_remove_sw_breakpoint(CPUState *cs,
     return 0;
 }
 
-int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type)
-{
-    return -ENOSYS;
-}
-
-int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type)
-{
-    return -ENOSYS;
-}
-
-void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
-{
-}
-
 static bool kvm_loongarch_handle_debug(CPUState *cs, struct kvm_run *run)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 4b2e42ef163..548bf3e00ad 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1438,8 +1438,8 @@ static int find_hw_watchpoint(target_ulong addr, int *flag)
     return -1;
 }
 
-int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type)
+static int ppc_kvm_insert_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
+                                         GdbBreakpointType type)
 {
     const unsigned breakpoint_index = nb_hw_breakpoint + nb_hw_watchpoint;
     if (breakpoint_index >= ARRAY_SIZE(hw_debug_points)) {
@@ -1483,8 +1483,8 @@ int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
     return 0;
 }
 
-int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type)
+static int ppc_kvm_remove_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
+                                         GdbBreakpointType type)
 {
     int n;
 
@@ -1512,7 +1512,7 @@ int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
     return 0;
 }
 
-void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
+static void ppc_kvm_remove_all_hw_breakpoints(CPUState *cs)
 {
     nb_hw_breakpoint = nb_hw_watchpoint = 0;
 }
@@ -3075,6 +3075,9 @@ static const KVMCPUOps ppc_kvm_cpu_ops = {
     .update_guest_debug = ppc_kvm_update_guest_debug,
     .insert_sw_breakpoint = ppc_kvm_insert_sw_breakpoint,
     .remove_sw_breakpoint = ppc_kvm_remove_sw_breakpoint,
+    .insert_hw_breakpoint = ppc_kvm_insert_hw_breakpoint,
+    .remove_hw_breakpoint = ppc_kvm_remove_hw_breakpoint,
+    .remove_all_hw_breakpoints = ppc_kvm_remove_all_hw_breakpoints,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 8a82160a7bf..aeb049c0c71 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2279,25 +2279,6 @@ static int riscv_kvm_remove_sw_breakpoint(CPUState *cs,
     return 0;
 }
 
-int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type)
-{
-    /* TODO; To be implemented later. */
-    return -EINVAL;
-}
-
-int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
-                                          GdbBreakpointType type)
-{
-    /* TODO; To be implemented later. */
-    return -EINVAL;
-}
-
-void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
-{
-    /* TODO; To be implemented later. */
-}
-
 static void riscv_kvm_update_guest_debug(CPUState *cs,
                                          struct kvm_guest_debug *dbg)
 {
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 12695376442..ccdc85900ba 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -902,7 +902,7 @@ static int insert_hw_breakpoint(vaddr addr, int len, int type)
     return 0;
 }
 
-int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+static int s390x_kvm_insert_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
                                           GdbBreakpointType type)
 {
     switch (type) {
@@ -921,7 +921,7 @@ int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
     return insert_hw_breakpoint(addr, len, type);
 }
 
-int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+static int s390x_kvm_remove_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
                                           GdbBreakpointType type)
 {
     int size;
@@ -951,7 +951,7 @@ int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
     return 0;
 }
 
-void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
+static void s390x_kvm_remove_all_hw_breakpoints(CPUState *cs)
 {
     nb_hw_breakpoints = 0;
     g_free(hw_breakpoints);
@@ -2653,6 +2653,9 @@ static const KVMCPUOps s390x_kvm_cpu_ops = {
     .update_guest_debug = s390x_kvm_update_guest_debug,
     .insert_sw_breakpoint = s390x_kvm_insert_sw_breakpoint,
     .remove_sw_breakpoint = s390x_kvm_remove_sw_breakpoint,
+    .insert_hw_breakpoint = s390x_kvm_insert_hw_breakpoint,
+    .remove_hw_breakpoint = s390x_kvm_remove_hw_breakpoint,
+    .remove_all_hw_breakpoints = s390x_kvm_remove_all_hw_breakpoints,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
-- 
2.47.3

