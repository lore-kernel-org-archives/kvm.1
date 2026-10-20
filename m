Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493018;
	b=HYB5GPpSM9zgb3TVODmO9+M0UTYZV+mzgWzc25vnOUj7qiETNS0wbGHKjBUEryIkLayL
	 YVzM/uxY1Pq2KwHd+TDNDQvb6ZgGP73aFTwcQ81CDhN7kg8Qfdhfn8GZiz7ApQdm2odSY
	 HmuuQoMoJawmefQ393sdiQQD5/8mC9l3DMGZCJzlrg8kQB/L04lavHVPYcsZOzR0nCCnt
	 H/BxMHt4rFrPZZn+i7514ZaanShoFhtuMFT3MYdhWj9Ao1RiSSwFNzftbQesIX7Q+0qqA
	 QXgr0eDoC/pqajcjAVEV1hxq73HSwP21jc1JuPiToy9DqivVz9yr4cV71s4nR7YZnRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d8sAo4RHPko4hi2qqkKFKsivhsO5nInc2hxbjXJGN8Q=;
	b=QbdqXvrEYUMx6oT04cip6/Vs0KjlVrW8nT3e3qDN1rnwbtaxDtDbUrc/TT+qsJMo/J0Y
	 MkYobpLYmmf3EkZcmGVghctcTtfB8YGYSmkFnj95QdYfqnkBFQzbugTJBrMBRMt6ojl1h
	 hx9vPAiwuI9wV3QA1QvRxd9gl1UjtY+KY16LNikLmDHbuZ03aSNYtlyzZRHI1Fq3VU2ur
	 z58wkPvVmB7ppJSBtt6qJWwqBzEvUDXXTVGc/bPL819KpjGgWjkKA99PVNU1Oav4atmF0
	 UZkvkirSpQHLQNssga8Es1Psutd1oF0ymlxwI32OvQjmgiMxBwiwjdzr1dSsZwMjnww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="jm/ghVD7";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12A60A3809
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF12A60A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jm/ghVD7
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so26099795e9.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493016; x=1793097816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d8sAo4RHPko4hi2qqkKFKsivhsO5nInc2hxbjXJGN8Q=;
        b=jm/ghVD7KGaAzRiPh7pqiXq9IDPmlXcwOeS4mDkrEvpWbD0+BzVs5XpGEdny3M7nLw
         0XNP+yYgrR4zru6GGpBfuUDtDydxG1A3hOQYgA5VJNmPMCxlG7TXRACeTRIeKtRAYecm
         9gaGwZSReGpK+CL0JLKkPg5E4lmVPNXgg8+rJlibHAh2Qnl1zClOZKUx6VhY/QH+1GgY
         ZTDkDLKRNUxoPUTSGdS/nKzj6Zl4qCQkZ5IW3WapUs2JdcCz34nWYpAn+TvDQ+BFSWJr
         BAVDawltTsRx2KRznTdplWKwlqW2KuRp6ExljPGu3lBHAs0qbVOQnnKvVS2KXasUjiVp
         880w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493016; x=1793097816;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8sAo4RHPko4hi2qqkKFKsivhsO5nInc2hxbjXJGN8Q=;
        b=M0DVlb4z7+nCmxGrA3gW15+BXkutJu3LuwUMdJq6mhNH1brmrx1MLKSof6Df3EgQkG
         EdHnsRYDO3iT+ufkjw5HqX6riIIyfoYzt8/kWb1sJ4qxJqfPKM5clrQOhOtmTQuLzvGT
         lYcWyn2FrP/awZ2pTp/zjgYh8WWuNVT6aFmpW0XYy1kdungQfqTA0yQYO5yXwVJ9k8Zo
         qnXap9E1aGrQDUvJ9MaPyJ3EMFszEqOycv29Yqwoo6bwHvjraiyZG6vhHfxAj/ap+k8O
         6ZIe8WQdqUFedPO3Qj3IjbXddXglp1MJ7LtMx6K2lwzi+yK0xCQTKvTGnrKOUpbw8Wwy
         F4kA==
X-Forwarded-Encrypted: i=1; AKwUvBxK1p/l8zxaTislAlDKeVcu9cLlwHQe3XDCFPKrpjvea3jXvgWDsjrrq9+wM6uXqH1eWr4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoHe3qkohiSTikKJ83EPdATOvCWTKLeTrR0xCAN0J6s3nau5VY
	Pkpjlfwwlr1ao2X7S6YI6NtfOLTI5b28vLrGfNMkkBHcS4X2kiQXKiaErSTxrYBNTco=
X-Gm-Gg: AYBFou1B/9RULZqYeAR35cwkHMWHWhk5hTzYsZCzPaz9tGBJBf+KWS/zC2MGG4xQi16
	wf64d1zvqbd2mjUgq6Oykno95HFMgWRd/eSg1BRnf5QvSk12L5IuZHe8cleeblgAbdGBRCUBC2a
	UQ0vIzrk4ptoCksEvyl4O6zaHz27oE9G2b4sF/kkS9YzFp5hODSvGcLgFG4Bu+g/WomtcwHn5Bh
	db0g4UhU/zwpCj+o2unPBkjxc0z+UR2uDbgkauh4Yq5uOX6eaVijqEuOiBt6c/Tkk7Rxfmpfky/
	8iO3tRsFip/7mbBWMTMWeetmgVd8i/Wg2b1iZjOMDIxdBamZG6XPP6EkMPKVECN5lZ4vaV3bHqP
	zh/X8/aGFpjuJdaENGk0YhVdKxJ6tliO0eq7JoumOuhkm+D23/E63GpgG26xWW9GFjZ/xKHWv/t
	+SQ+KK0vOsmrvgtBEgRKSVdVx6a6oA1O67OxxQnt3BSvRyhGhCnFZ+MfX66FRi/FIa4bBakw==
X-Received: by 2002:a05:600d:82c5:b0:4a1:e575:33dd with SMTP id 5b1f17b1804b1-4a1e57533efmr143324095e9.18.1792493016088;
        Tue, 20 Oct 2026 03:43:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cc809csm64726835e9.8.2026.10.20.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 3C5355FED7;
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
Subject: [PATCH 20/23] accel/kvm: port kvm_arch_stop_on_emulation_error to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:14 +0100
Message-ID: <20261020104320.3686723-21-alex.bennee@linaro.org>
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

Really only x86 is doing much complicated, everyone else defaults to
stop.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 7 +++++++
 include/system/kvm.h        | 2 --
 target/i386/kvm/kvm_i386.h  | 1 +
 accel/kvm/kvm-all.c         | 8 +++++++-
 target/arm/kvm.c            | 5 -----
 target/i386/kvm/kvm-cpu.c   | 1 +
 target/i386/kvm/kvm.c       | 2 +-
 target/loongarch/kvm/kvm.c  | 5 -----
 target/ppc/kvm.c            | 5 -----
 target/riscv/kvm/kvm-cpu.c  | 5 -----
 target/s390x/kvm/kvm.c      | 5 -----
 11 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index 23a83eee6ed..c2ae74f2b87 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -95,6 +95,12 @@ struct kvm_run;
  *                        Returns 0 on success, or a negative errno on failure.
  * @remove_all_hw_breakpoints: Optional callback to remove all architecture-
  *                             specific hardware breakpoints and watchpoints.
+ * @stop_on_emulation_error: Optional callback executed when KVM encounters an
+ *                           internal emulation failure (such as
+ *                           KVM_INTERNAL_ERROR_EMULATION) to decide whether
+ *                           execution should stop.
+ *                           Returns true to stop the VM, or false to dump state
+ *                           and continue. If NULL, defaults to true.
  */
 typedef struct KVMCPUOps {
     int (*pre_create_vcpu)(CPUState *cpu, Error **errp);
@@ -115,6 +121,7 @@ typedef struct KVMCPUOps {
     int (*remove_hw_breakpoint)(CPUState *cpu, vaddr addr, vaddr len,
                                 GdbBreakpointType type);
     void (*remove_all_hw_breakpoints)(CPUState *cpu);
+    bool (*stop_on_emulation_error)(CPUState *cpu);
 } KVMCPUOps;
 
 #define TYPE_KVM_ACCEL_CPU "kvm-accel-cpu"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 1a52e7e5261..719ae1c71fb 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -387,8 +387,6 @@ struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
 
 int kvm_sw_breakpoints_active(CPUState *cpu);
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
-
 int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 
 #define kvm_vm_enable_cap(s, capability, cap_flags, ...)             \
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index e2ae601100c..9d4be604443 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -51,6 +51,7 @@ int x86_kvm_insert_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
 int x86_kvm_remove_hw_breakpoint(CPUState *cs, vaddr addr, vaddr len,
                                  GdbBreakpointType type);
 void x86_kvm_remove_all_hw_breakpoints(CPUState *cs);
+bool x86_kvm_stop_on_emulation_error(CPUState *cs);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5b96fac513e..62ebb3458c8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3183,8 +3183,14 @@ static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
                 i, (uint64_t)run->internal.data[i]);
     }
     if (run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION) {
+        const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
+        bool stop = true;
+
         fprintf(stderr, "emulation failure\n");
-        if (!kvm_arch_stop_on_emulation_error(cpu)) {
+        if (ops && ops->stop_on_emulation_error) {
+            stop = ops->stop_on_emulation_error(cpu);
+        }
+        if (!stop) {
             cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
             return EXCP_INTERRUPT;
         }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5c0ccfc11cd..ed99699098c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1609,11 +1609,6 @@ static int arm_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cs)
-{
-    return true;
-}
-
 /**
  * kvm_arm_hw_debug_active:
  * @cpu: ARMCPU
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index baaee0c7e71..c9340183eaf 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -251,6 +251,7 @@ static const KVMCPUOps x86_kvm_cpu_ops = {
     .insert_hw_breakpoint = x86_kvm_insert_hw_breakpoint,
     .remove_hw_breakpoint = x86_kvm_remove_hw_breakpoint,
     .remove_all_hw_breakpoints = x86_kvm_remove_all_hw_breakpoints,
+    .stop_on_emulation_error = x86_kvm_stop_on_emulation_error,
 };
 
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 78c06a07bd6..e419af944cb 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6661,7 +6661,7 @@ int x86_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cs)
+bool x86_kvm_stop_on_emulation_error(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index b15f60bd2c3..fd0f3a82a6b 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1513,11 +1513,6 @@ static int loongarch_kvm_process_async_events(CPUState *cs)
     return cs->halted;
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cs)
-{
-    return true;
-}
-
 static void loongarch_kvm_update_guest_debug(CPUState *cpu,
                                              struct kvm_guest_debug *dbg)
 {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 548bf3e00ad..f5f2f82a4d8 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2840,11 +2840,6 @@ int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
     return 0;
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cpu)
-{
-    return true;
-}
-
 void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index aeb049c0c71..6a88fe761c0 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1621,11 +1621,6 @@ int kvm_arch_irqchip_create(KVMState *s)
     return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cs)
-{
-    return true;
-}
-
 static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index ccdc85900ba..e0373d05515 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1935,11 +1935,6 @@ static int s390x_kvm_handle_exit(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
-bool kvm_arch_stop_on_emulation_error(CPUState *cpu)
-{
-    return true;
-}
-
 void kvm_s390_enable_css_support(S390CPU *cpu)
 {
     int r;
-- 
2.47.3

