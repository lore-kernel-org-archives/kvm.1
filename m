Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0672E9757
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423500; cv=none; b=tHkzifIEwSsGZd+a8Regb5gLeGw5mrnK1Apt3p8pw93SHVzEn+flXdOytWrJ7PE9WicyhZEvt3h6N0KBltsfZR0uC7nbKt4oERHz/hCxLRT7Haf7v0g3QLeEdJO36/voBXtLz3N+rVa1n3hwhXcxXBoe6fMjVK5Zs18JG2/iDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423500; c=relaxed/simple;
	bh=kQ8netBA62IadnoBhKaczVIc6/MwEXjohgpWR5M7stQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9rMJ+H9CM73ekFQ6jMG8YSajCWun1XW6D9p3geMb7FOr8TGQvwA2ToqYqSyR1IPJ+oSoBEpU7UJJUJbMWLUerRG8Jr4M/CcT+EHvGMpQ86zmzdgOctjD0iiHbOE/uW1l3olOtahInLRkSSe0IYJhD43+6YM2a5nNppayXu0ZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UG7EHl7L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UG7EHl7L"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id EFA3E20B7001;
	Fri, 17 Apr 2026 03:58:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFA3E20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423498;
	bh=7gTom78x3K6oKCng+OiNrUvvmUvSvvHVMp0/uAOVRMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UG7EHl7L2JY25yroZFasVEt+gzalDMZViyWRdOXwO1behKsqN0XyOVSSvYlQxdGPE
	 WwFGURb5Ezjs61qyP34lljWsnhXbCjII/tr5gEh3o8g3Hu+MNsrxf47jpvggB10E9R
	 h+0dgd+68bWHM3OlJAcxoeFc2rPPkhrLXiSvzLEg=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 31/34] target/i386/mshv: migrate XSAVE state
Date: Fri, 17 Apr 2026 12:56:15 +0200
Message-Id: <20260417105618.3621-32-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We implement fn's that roundtrip XSAVE state in migration. We are using
the xsave_helper routines to move individual components from CPUX86State
to an xsave_buf and then we have to compact the buffer to XSAVEC format,
which is what the hypervisor expects.

And the same applies in the other direction for restoring state from the
hypervisor.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/cpu.h           |   2 +-
 target/i386/mshv/mshv-cpu.c | 100 +++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cd5d5a5369..0f30f0dd5b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2272,7 +2272,7 @@ typedef struct CPUArchState {
     int64_t user_tsc_khz; /* for sanity check only */
     uint64_t apic_bus_freq;
     uint64_t tsc;
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_MSHV)
     void *xsave_buf;
     uint32_t xsave_buf_len;
 #endif
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 517b38a32d..5b0b8bda16 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -109,6 +109,78 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
 
 static int set_special_regs(const CPUState *cpu);
 
+static int get_xsave_state(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+    void *xsavec_buf;
+    const size_t page = HV_HYP_PAGE_SIZE;
+    size_t xsavec_buf_len = page;
+
+    /* TODO: should properly determine xsavec size based on CPUID */
+    xsavec_buf = qemu_memalign(page, xsavec_buf_len);
+    memset(xsavec_buf, 0, xsavec_buf_len);
+
+    struct mshv_get_set_vp_state args = {
+        .type = MSHV_VP_STATE_XSAVE,
+        .buf_sz = xsavec_buf_len,
+        .buf_ptr = (uintptr_t)xsavec_buf,
+    };
+
+    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, &args);
+    if (ret < 0) {
+        error_report("failed to get xsave state: %s", strerror(errno));
+        return -errno;
+    }
+
+    ret = decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
+    g_free(xsavec_buf);
+    if (ret < 0) {
+        error_report("failed to decompact xsave area");
+        return ret;
+    }
+    x86_cpu_xrstor_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
+
+    return 0;
+}
+
+static int set_xsave_state(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+    void *xsavec_buf;
+    size_t page = HV_HYP_PAGE_SIZE, xsavec_buf_len;
+
+    /* allocate and populate compacted buffer */
+    xsavec_buf = qemu_memalign(page, page);
+    xsavec_buf_len = page;
+
+    /* save registers to standard format buffer */
+    x86_cpu_xsave_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
+
+    /* store compacted version of xsave area in xsavec_buf */
+    compact_xsave_area(env, xsavec_buf, xsavec_buf_len);
+
+    struct mshv_get_set_vp_state args = {
+        .type = MSHV_VP_STATE_XSAVE,
+        .buf_sz = xsavec_buf_len,
+        .buf_ptr = (uintptr_t)xsavec_buf,
+    };
+
+    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, &args);
+    g_free(xsavec_buf);
+    if (ret < 0) {
+        error_report("failed to set xsave state: %s", strerror(errno));
+        return -errno;
+    }
+
+    return 0;
+}
+
 static int get_lapic(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -766,6 +838,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_xsave_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = get_lapic(cpu);
     if (ret < 0) {
         return ret;
@@ -1258,6 +1335,11 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    ret = set_xsave_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     /* INVARIANT: special regs (APIC_BASE) must be restored before LAPIC */
     ret = set_lapic(cpu);
     if (ret < 0) {
@@ -1786,9 +1868,10 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     AccelCPUState *state = cpu->accel;
-    size_t page = HV_HYP_PAGE_SIZE;
+    size_t page = HV_HYP_PAGE_SIZE, xsave_len;
     void *mem = qemu_memalign(page, 2 * page);
     int ret;
+    X86XSaveHeader *header;
 
     /* sanity check, to make sure we don't overflow the page */
     QEMU_BUILD_BUG_ON((MAX_REGISTER_COUNT
@@ -1802,6 +1885,17 @@ void mshv_arch_init_vcpu(CPUState *cpu)
 
     env->emu_mmio_buf = g_new(char, 4096);
 
+    /* Initialize XSAVE buffer page-aligned */
+    /* TODO: pick proper size based on CPUID */
+    xsave_len = page;
+    env->xsave_buf = qemu_memalign(page, xsave_len);
+    env->xsave_buf_len = xsave_len;
+    memset(env->xsave_buf, 0, env->xsave_buf_len);
+
+    /* we need to set the compacted format bit in xsave header for mshv */
+    header = (X86XSaveHeader *)(env->xsave_buf + sizeof(X86LegacyXSaveArea));
+    header->xcomp_bv = header->xstate_bv | (1ULL << 63);
+
     /*
      * TODO: populate topology info:
      * X86CPUTopoInfo *topo_info = &env->topo_info;
@@ -1826,6 +1920,10 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
     g_free(state->hvcall_args.base);
     state->hvcall_args = (MshvHvCallArgs){0};
     g_clear_pointer(&env->emu_mmio_buf, g_free);
+
+    qemu_vfree(env->xsave_buf);
+    env->xsave_buf = NULL;
+    env->xsave_buf_len = 0;
 }
 
 /*
-- 
2.34.1

