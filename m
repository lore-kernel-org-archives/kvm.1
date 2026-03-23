Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C053B3894
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274408; cv=none; b=X4D5s8KyslEso/45Z4xTQ8xARGybzEY6sucmSZkF4bRhXxEeS6n+RQ0Fv235PjLnX8m8hP6nmdvb9RDBOBuF36u5wJRNSLqqIhvhjta4VjJlhu/DOIwlDsZ4z/qxS9cBQTPmaa2Iz07wCO0OUAbehg5o4/3GWwB/zjRdal8OGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274408; c=relaxed/simple;
	bh=kuSvLXKTkVReEQlM0J0biQ8YtOnpG3lxNYXEth3fLfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=reME50OWhlakjyphM3PhH0SRqV1jZfeL2dQwtxv/AgZNhRy4vo3XZWXsWwf486WxG5obpFR2kdm2JQpgcuExhawfYHhcnRY319xihtcK+O0r06/v0Vui/d09n1uHm+p1GaTWR0J6hLJIwxiBZ1Ubz9QCFfhzV+bmZrJxQVjapOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GBWvBSQv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GBWvBSQv"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7EACB20B6F20;
	Mon, 23 Mar 2026 07:00:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EACB20B6F20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274406;
	bh=WL7aGhrD9h47rdLHpTc412OkLiLisXW3EZzyJTLGXtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBWvBSQvLoC3WBwWC0h45O+c/bU66/wvFs3nCeH9dOBaDh3MrqJbaMB0d/3twYolp
	 qvvOrQRf4mxkubIxtdNXWQ89nWGQeQiEHfiBjm2tSgorfRLojL4M5nu+I0Yb4MmhCA
	 QpG9cl4yELEpjCTar2KL9Xfg8mHIvHV2pMlhckrQ=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 29/32] target/i386/mshv: migrate XSAVE state
Date: Mon, 23 Mar 2026 14:58:09 +0100
Message-Id: <20260323135812.383509-30-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
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
index 746987d62b..dacc33674c 100644
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
@@ -1284,6 +1361,11 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
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
@@ -1812,9 +1894,10 @@ void mshv_arch_init_vcpu(CPUState *cpu)
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
@@ -1828,6 +1911,17 @@ void mshv_arch_init_vcpu(CPUState *cpu)
 
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
@@ -1852,6 +1946,10 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
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

