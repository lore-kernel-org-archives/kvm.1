Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493017;
	b=n9pg5ZULBppq6d7jXJMlysvHXl6/PHEaDh5B65zRCAC9+ggkte1JZOqleaumfiKl19/7
	 RMeGEzh5kwV7UOogzuQVEj013Q0zy5OiTCQP2XBoWDbSgbBPGwuXf+buiPIZxqSfBqwcx
	 RmV8+v+uuckf5Ug6gjsXEnYhpKEe23CJ33rDv9jMt/eoWS8Ts6oTRFae2ngE79D2tB7W1
	 9yKWml0fXVInuB2rnlBjxYEy2jYwDkRRKhmQ1UpPx6fRPrNxvc1qUJx3QYoCXEhiJLIoP
	 v5/87povCntfqrqmsZk6OHk9LVGC9+JPyq9eLTwiBLuyUki4wsQkzHoRTKPGQ71/0WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rlGqnDKcLdvQ6taSdMwsgc96SAB4pCJT2O+A8tIZZ9Y=;
	b=UeSWR8R5gPaVCmhpI5HR5JJOdrgPQH0jDMZYXqAZNMhgtoH3x1J72cgY82Eo3vvRPgwy
	 IJoTvqT/dhwIVBXzH8d7grwYbd77GTqojgyF+Dgf0JjUUtqdhB0RsdRbXcgBhA2GQmjFZ
	 vXxnF8nsRvddjA91bMhABcoa9lDkRZzcVfmUU1cf/8aig/8eApDEtm8SE8p8cjzFH4MwV
	 pNT6Vg3W8Gq5Z32QwjWyRy/MoZs2+G7UCptuvD6I5ct/P0Nf9si9hhD6ItNf2YQ+YP6IA
	 LZFICr9Y8Jfzn/8uKYeZ9FCa0Zc13ojrpMso2jumVxLMINxTygp2ylQjRsvOQcL5UXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AqiP9ogy;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18B60A4AE1
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE18B60A4AE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AqiP9ogy
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so15263195e9.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493015; x=1793097815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rlGqnDKcLdvQ6taSdMwsgc96SAB4pCJT2O+A8tIZZ9Y=;
        b=AqiP9ogyDVN76/UpA1RFgqQQgogJI3fs35BunEYZd+iwjno66S4KoMftb5AKxUaZGj
         W8PBti1HaicUB/LfniIY2/TW1YLflsUMpQYAjjUyR41Sjsmo5GsAMAjcemobnCuilCtw
         Aif7AjLZ5lVGR8IuX3BbT+Pe8rVh0xayFaVpjOOAOloN9wa8+ODvoEsBJWvpfUPwsQus
         C+4BXMcaQsL8pIoFb455G7IJMYpNdHSVSaPfUXS8yw4Gvx30m61/xrjVLUvpr0OMF8Wf
         t9jc2dnEyuYrnPDvfLaL5jXqFTcIjFtSey2+jq5NXlunyj4/MELiNV5pXqmdJMx7PVSf
         EMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493015; x=1793097815;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlGqnDKcLdvQ6taSdMwsgc96SAB4pCJT2O+A8tIZZ9Y=;
        b=RQRkvSk0Q/LwzIwHobVqK/602UiKClbyY+6Lt71Uq4Se6dxsjdYVkeVfUnLM9C6MYI
         wG9Brpo2DL7aCH8Xbj6vOG5Wqd453D0YBnkzqwEpuUUvw8QG3pj0xr2RmAEmZZl0E524
         8aRxn3neNF3pxlQ9oNbMP++0W8SVvZqr3mq0Px4Jq1t1wmdqgbbxgYvgrCVn/BO+BE1Y
         OLknM8yxNck1YgvC4X5fM4DQ8IIuqU4u9EqJY0lM/n/iACNQqIWJM8RtxMaspmON4n8a
         1FmfFWtaxoVwTrIolrKwh1fsgJkinGJ5WE8HpBs6eCfiK9jujLwzwemVIk1CMNJyZhJA
         a2xA==
X-Forwarded-Encrypted: i=1; AKwUvBwYhvPOakGbtQzO5bFHxer2aOI/muHfVTWisM+qR2XC/03QVc4T+KSpVqRhODlySkrjmwE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdkxUxmeezVVDCHMlHYq5UdAJG0ZRugXLFh11XVTItMLGuVX+Z
	pCtSoN/IhJ36/ogq5fX1+AWZGPxJTwPlddb95iyl/3WIlYmavqvHp7d2LZwz/aoT+sQ=
X-Gm-Gg: AYBFou06xuj92ddJd84GcsLT/Uk1NmVT46IOgb26zdeuLck8CAJa3Ynlcb/6bffyzUa
	nGf1/QdwLzfPMj4ISipjUxIJ/czLtQM8VD73iiAVv6hO0tAKcQpOwDHF5D/zaLLaX8iPPgB0Jc7
	+SA2GfGirudenq9D9Dl4EekjU3IeXKgEnxLJ6xMIBDvLCg2/U9d63Gh9wmNTQq8S0Vipe/HF5fl
	1c+S5l5A9thx3/42b3ShuLh2Q+M9Fo7F3iKiepnalZSa70BwcJ9yZu0+W3LBFnzoh5ExrsFXJEv
	0eOuKUzLH1yoSoVmszqdRnWfjTzHpQeZ9K3cJdsy+wtOuyPkB19lygg5aX2KBt8ZWFxUg4teRUT
	XFXA6FzM8L1s93DpC3v4k6gHBMs7/RjJWzIzWtaa2ZhQRiAGMPAES53E6coUgPii149O1ybHbZn
	AwJCXl50ZY6gNPL5C/hsEHarjLGvJWMLT1/14z+Ebs2FqDrGfBqY06gD6sMxR2h38udFrKDQ==
X-Received: by 2002:a05:600c:4e11:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a1d75f24b4mr214465875e9.9.1792493015117;
        Tue, 20 Oct 2026 03:43:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1df370381sm168472065e9.1.2026.10.20.03.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 7C7265FD52;
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
Subject: [PATCH 13/23] accel/kvm: port kvm_arch_pre_create_vcpu to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:07 +0100
Message-ID: <20261020104320.3686723-14-alex.bennee@linaro.org>
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

Only x86 actually does anything for this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h |  7 +++++++
 include/system/kvm.h        |  1 -
 target/i386/kvm/kvm_i386.h  |  1 +
 accel/kvm/kvm-all.c         | 19 +++++++++++++------
 target/arm/kvm.c            |  5 -----
 target/i386/kvm/kvm-cpu.c   |  1 +
 target/i386/kvm/kvm.c       |  2 +-
 target/loongarch/kvm/kvm.c  |  5 -----
 target/ppc/kvm.c            |  5 -----
 target/riscv/kvm/kvm-cpu.c  |  5 -----
 target/s390x/kvm/kvm.c      |  5 -----
 11 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index b3f6b8e47b7..9b8a54253b1 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -19,6 +19,12 @@ struct kvm_run;
 /**
  * struct KVMCPUOps - Target-specific per-vCPU operations for KVM
  *
+ * @pre_create_vcpu: Optional callback executed before creating the KVM vCPU
+ *                   (via KVM_CREATE_VCPU). Used by architectures that need
+ *                   to configure VM-level capabilities or features before
+ *                   vCPUs are created (e.g. x86 PMU disable or TDX).
+ *                   May be NULL if the target does not require pre-creation
+ *                   handling.
  * @get_registers: Mandatory callback to synchronize architecture-specific
  *                 vCPU register state from KVM into QEMU's CPUState.
  *                 Returns 0 on success, or a negative errno on failure.
@@ -54,6 +60,7 @@ struct kvm_run;
  *                        processing before execution.
  */
 typedef struct KVMCPUOps {
+    int (*pre_create_vcpu)(CPUState *cpu, Error **errp);
     int (*get_registers)(CPUState *cpu, Error **errp);
     int (*put_registers)(CPUState *cpu, KvmPutState level, Error **errp);
     void (*pre_run)(CPUState *cpu, struct kvm_run *run);
diff --git a/include/system/kvm.h b/include/system/kvm.h
index b2d76f99df0..3b08eb4f5d0 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -346,7 +346,6 @@ int kvm_arch_get_default_type(MachineState *ms);
 
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 2c92afc3320..b5dace5d3be 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -33,6 +33,7 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 
 int kvm_get_vm_type(MachineState *ms);
 void kvm_arch_reset_vcpu(X86CPU *cs);
+int x86_kvm_pre_create_vcpu(CPUState *cpu, Error **errp);
 int x86_kvm_get_registers(CPUState *cs, Error **errp);
 int x86_kvm_put_registers(CPUState *cpu, KvmPutState level, Error **errp);
 void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3de05bb8bb8..dbd4cfc7c7a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -460,6 +460,8 @@ static int kvm_rebind_vcpus(Error **errp)
     int kvm_fd, ret = 0;
 
     CPU_FOREACH(cpu) {
+        const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
+
         vcpu_id = kvm_arch_vcpu_id(cpu);
 
         if (cpu->kvm_fd) {
@@ -480,9 +482,11 @@ static int kvm_rebind_vcpus(Error **errp)
             goto err;
         }
 
-        ret = kvm_arch_pre_create_vcpu(cpu, errp);
-        if (ret < 0) {
-            goto err;
+        if (ops->pre_create_vcpu) {
+            ret = ops->pre_create_vcpu(cpu, errp);
+            if (ret < 0) {
+                goto err;
+            }
         }
 
         kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
@@ -723,14 +727,17 @@ static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp)
 
 int kvm_init_vcpu(CPUState *cpu, Error **errp)
 {
+    const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
     KVMState *s = kvm_state;
     int ret;
 
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
-    ret = kvm_arch_pre_create_vcpu(cpu, errp);
-    if (ret < 0) {
-        goto err;
+    if (ops->pre_create_vcpu) {
+        ret = ops->pre_create_vcpu(cpu, errp);
+        if (ret < 0) {
+            goto err;
+        }
     }
 
     ret = kvm_create_vcpu(cpu);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ea8c4d02ee8..da6c3e0b3d3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1994,11 +1994,6 @@ static int kvm_arm_sve_set_vls(ARMCPU *cpu)
 
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret;
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 08308ef8a80..e2cf42a126e 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -235,6 +235,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
 }
 
 static const KVMCPUOps x86_kvm_cpu_ops = {
+    .pre_create_vcpu = x86_kvm_pre_create_vcpu,
     .get_registers = x86_kvm_get_registers,
     .put_registers = x86_kvm_put_registers,
     .pre_run = x86_kvm_pre_run,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7ee6d3d4f38..1c53b62a1f7 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2056,7 +2056,7 @@ full:
     abort();
 }
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+int x86_kvm_pre_create_vcpu(CPUState *cpu, Error **errp)
 {
     static bool first = true;
     int ret;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 1e7565732e8..9ce6e9e65b4 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1297,11 +1297,6 @@ static int kvm_cpu_check_misc_v1_1(CPUState *cs, Error **errp)
     return 0;
 }
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     uint64_t val;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25f797cb2d8..8a2d2421dc2 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -480,11 +480,6 @@ static void kvmppc_hw_debug_points_init(CPUPPCState *cenv)
     }
 }
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c38c07a563b..cef9d90c66f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1579,11 +1579,6 @@ static int kvm_vcpu_enable_sbi_dbcn(RISCVCPU *cpu, CPUState *cs)
     return kvm_set_one_reg(cs, kvm_sbi_dbcn.kvm_reg_id, &reg);
 }
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret = 0;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index c85d286288b..64020450dec 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -400,11 +400,6 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
     return cpu->cpu_index;
 }
 
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
-- 
2.47.3

