Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2352264A8
	for <kvm@vger.kernel.org>; Wed, 28 Jan 2026 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769642265; cv=none; b=MHJrr19qWXKIZxKCa6oO2hrykXFeZvuVMsSg90uTrdMpvuyj1+81wvdpFtXgGuWzLEDKwZ+qOV77ZdGUeJtJX5YFZ1soEsI618piYtgIY2FIWflDsE/GFzgoaFSfx4Vdi4m3QrgTAbbo5B43pUBa0Z56fmdH8jwmhJrYNXmxqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769642265; c=relaxed/simple;
	bh=pfTHmiu52aVPiOg3YN+F0zjdcLkkAwysFjXGDpbeVVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWRFfxDeFz9CMcFAR6aYsHkqN/wHrM7xXnE40O4npwymS/1YZxOaXffWoMGTzXPme84IU5u8lYU0q9eSMcfZg7QjpZbFPB9lgtmvJgasgaE10EsWdNZK6yXdpkQp+dYJIjZo22MomZDlhRdZn2etq4ERGp2VOLTzEPrXLP0fsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rqs8xbFK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rqs8xbFK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769642263; x=1801178263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pfTHmiu52aVPiOg3YN+F0zjdcLkkAwysFjXGDpbeVVk=;
  b=Rqs8xbFK0xhMerdOk1UB0nfDb/IBEQaMAkaLhioYzbwOhCr4W/KICdOd
   dgxQY/ObhB4KV9u58n2FNHsY5Bh7lromTe3NH3tKpF4p3HXt5BcI/NOg0
   548wQnIFAvncYZlK4zxlbRJChvV8tiXjHiOYAS0ZCg+HswNqjlp6TxU07
   R+jVC4C/1eqQ53QjrEVRDAC4kXtbx0bmNPMMlX/N/XIkQ9s9yKQfA2mMA
   nIdfzlWkPG7xWIsiCRMlSvcgacDxh5Nh4WXIuWNbeCGXc8pZZ2zE+xVeH
   38nEMMiqVW8U4otyaiGVru1AsEpa9IfE9G/SS5tyGbrNOBVYmWTR5y/1Z
   w==;
X-CSE-ConnectionGUID: +qnutDs3QP6ktieOCF4o5A==
X-CSE-MsgGUID: BFblDz3rSimgulJtQzMnXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462345"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="73462345"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:17:42 -0800
X-CSE-ConnectionGUID: cjfmxDGETm+B3YW3nNcMyg==
X-CSE-MsgGUID: 8dxBRV9GQyaz9By1/G5Ddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208001786"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:17:41 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 09/11] target/i386: Refactor LBR format handling
Date: Wed, 28 Jan 2026 15:09:46 -0800
Message-ID: <20260128231003.268981-10-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128231003.268981-1-zide.chen@intel.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detach x86_cpu_pmu_realize() from x86_cpu_realizefn() to keep the latter
focused and easier to follow.  Introduce a dedicated helper,
x86_cpu_apply_lbr_pebs_fmt(), in preparation for adding PEBS format
support without duplicating code.

Convert PERF_CAP_LBR_FMT into separate mask and shift macros to allow
x86_cpu_apply_lbr_pebs_fmt() to be shared with PEBS format handling.

No functional change intended

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- New patch.

 target/i386/cpu.c | 94 +++++++++++++++++++++++++++++++----------------
 target/i386/cpu.h |  3 +-
 2 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 09180c718d58..54f04adb0b48 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9781,6 +9781,66 @@ static bool x86_cpu_update_smp_cache_topo(MachineState *ms, X86CPU *cpu,
 }
 #endif
 
+static bool x86_cpu_apply_lbr_pebs_fmt(X86CPU *cpu, uint64_t host_perf_cap,
+                                  uint64_t user_req, bool is_lbr_fmt,
+                                  Error **errp)
+{
+    CPUX86State *env = &cpu->env;
+    uint64_t mask;
+    unsigned shift;
+    unsigned user_fmt;
+    const char *name;
+
+    if (is_lbr_fmt) {
+        mask = PERF_CAP_LBR_FMT_MASK;
+        shift = PERF_CAP_LBR_FMT_SHIFT;
+        name = "lbr";
+    } else {
+        return false;
+    }
+
+    if (user_req != -1) {
+        env->features[FEAT_PERF_CAPABILITIES] &= ~(mask << shift);
+        env->features[FEAT_PERF_CAPABILITIES] |= (user_req << shift);
+    }
+
+    user_fmt = (env->features[FEAT_PERF_CAPABILITIES] >> shift) & mask;
+
+    if (user_fmt) {
+        unsigned host_fmt = (host_perf_cap >> shift) & mask;
+
+        if (!cpu->enable_pmu) {
+            error_setg(errp, "vPMU: %s is unsupported without pmu=on", name);
+            return false;
+        }
+        if (user_fmt != host_fmt) {
+            error_setg(errp, "vPMU: the %s-fmt value (0x%x) does not match "
+                        "the host value (0x%x).",
+                        name, user_fmt, host_fmt);
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static int x86_cpu_pmu_realize(X86CPU *cpu, Error **errp)
+{
+    uint64_t host_perf_cap =
+        x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
+
+    /*
+     * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
+     * with user-provided setting.
+     */
+    if (!x86_cpu_apply_lbr_pebs_fmt(cpu, host_perf_cap,
+                                    cpu->lbr_fmt, true, errp)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -9788,7 +9848,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
-    unsigned guest_fmt;
 
     if (!kvm_enabled())
         cpu->enable_pmu = false;
@@ -9824,35 +9883,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
-    /*
-     * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
-     * with user-provided setting.
-     */
-    if (cpu->lbr_fmt != -1) {
-        env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
-        env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
-    }
-
-    /*
-     * vPMU LBR is supported when 1) KVM is enabled 2) Option pmu=on and
-     * 3)vPMU LBR format matches that of host setting.
-     */
-    guest_fmt = env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
-    if (guest_fmt) {
-        uint64_t host_perf_cap =
-            x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
-        unsigned host_lbr_fmt = host_perf_cap & PERF_CAP_LBR_FMT;
-
-        if (!cpu->enable_pmu) {
-            error_setg(errp, "vPMU: LBR is unsupported without pmu=on");
-            return;
-        }
-        if (guest_fmt != host_lbr_fmt) {
-            error_setg(errp, "vPMU: the lbr-fmt value (0x%x) does not match "
-                        "the host value (0x%x).",
-                        guest_fmt, host_lbr_fmt);
-            return;
-        }
+    if (x86_cpu_pmu_realize(cpu, errp)) {
+        return;
     }
 
     if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
@@ -10445,7 +10477,7 @@ static const Property x86_cpu_properties[] = {
 #endif
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
-    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT),
+    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT_MASK),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
                        HYPERV_SPINLOCK_NEVER_NOTIFY),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3e2222e105bc..aa3c24e0ba13 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -420,7 +420,8 @@ typedef enum X86Seg {
 #define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
 
 #define MSR_IA32_PERF_CAPABILITIES      0x345
-#define PERF_CAP_LBR_FMT                0x3f
+#define PERF_CAP_LBR_FMT_MASK           0x3f
+#define PERF_CAP_LBR_FMT_SHIFT          0x0
 #define PERF_CAP_FULL_WRITE             (1U << 13)
 #define PERF_CAP_PEBS_BASELINE          (1U << 14)
 
-- 
2.52.0

