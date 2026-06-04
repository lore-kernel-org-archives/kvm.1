Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF603AE704
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542273; cv=none; b=P8WiUEEun2NUQh5s24OIrOlmh4YPhXLq+7lliqsCPe9ezNxC+GopZq1mrjBrueBNCVzZ4JuGOBXsdRuW9wMC1u/4EG1//5kEtfUOc/1ynmmQU8gJ0IoZtIFJtz4DhM7r8YCgIUHZnWSckG1q/PbK7+t/fyFxLHFQtEfMlqlkf7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542273; c=relaxed/simple;
	bh=UcJJg82JVluhCHJi+UtWFBLvpeA9hmqR4IFs/vLhXhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXaI/hF9CFGgxnNp1ho2UyR7j2gA48bGkiaJeFHohDongWIsiEhK4xSWBErlmw+BbiLYtNxIS2QfMQxY5+32ED5bcqDhQOhahhEXiGWeQ69VVe3MGvqaJBbaIbi0HWqXorhPNLjUOQtNS/DQDHupkrHRkju5yKyTsB250+kdBbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdTdmXQ7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdTdmXQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780542272; x=1812078272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcJJg82JVluhCHJi+UtWFBLvpeA9hmqR4IFs/vLhXhQ=;
  b=TdTdmXQ7jwkN+ycih0/l37lAalZmCxJdmb30ik9CJbZzdVdd+LrWT8ou
   rZtvU6dQRU8br6m/YU9SQ5PPGpfgFOXPDohAcTf3kntPN/bvTp16zPBtD
   dXN1dRYefpfn9aLx5lW0xOvWd41pA2RrBJpoDQwiUmj6cZx2pk6pTfyWe
   N+wkGTUbDtCLIWK5pBl4PSK0Ees4ZB3hamPZQ4lbJ07P/P4yIDAqsr38s
   7VC9JKcDP/v22cfwPZc+NzocVf1n9vYnh/87Bh29gn7Xba1d0b+Z+5SAW
   cQl8REvNUvwZyOt/HIH1UAjhAcDW7anWTL/Jmv0hl35LtC3T43PErYRJc
   A==;
X-CSE-ConnectionGUID: +h/osVCXRTCG9TgKSHhRQQ==
X-CSE-MsgGUID: xQCVXOYrQDSHC1bCXtkLFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399653"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="80399653"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:04:29 -0700
X-CSE-ConnectionGUID: S4XIG+G7TO6LBqQpWrUG2A==
X-CSE-MsgGUID: rYQ6ogK7Q9mxYOQqKQ82CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241915853"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:04:28 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH v4 6/6] target/i386: Add Topdown metrics feature support
Date: Wed,  3 Jun 2026 19:55:46 -0700
Message-ID: <20260604025546.19378-7-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604025546.19378-1-zide.chen@intel.com>
References: <20260604025546.19378-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE (bit 15) indicates that
the CPU provides built-in support for TMA L1 metrics through
the PERF_METRICS MSR.  Expose it as a user-visible CPU feature
("perf-metrics"), allowing it to be explicitly enabled or disabled and
used with migratable guests.

Handle IA32_PERF_METRICS in the KVM MSR get/put paths to save and
restore it.  Migrate IA32_PERF_METRICS MSR using a new subsection of
vmstate_msr_architectural_pmu.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3: New patch.
---
 target/i386/cpu.c     |  2 +-
 target/i386/cpu.h     |  3 +++
 target/i386/kvm/kvm.c | 10 ++++++++++
 target/i386/machine.c | 25 ++++++++++++++++++++++++-
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c978e957df6a..c4de8639bd48 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1620,7 +1620,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, "full-width-write", NULL, NULL,
+            NULL, "full-width-write", NULL, "perf-metrics",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8cc3c2f139e7..ed5069bb5fad 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -422,6 +422,7 @@ typedef enum X86Seg {
 #define MSR_IA32_PERF_CAPABILITIES      0x345
 #define PERF_CAP_LBR_FMT                0x3f
 #define PERF_CAP_FULL_WRITE             (1U << 13)
+#define PERF_CAP_TOPDOWN                (1U << 15)
 
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
@@ -507,6 +508,7 @@ typedef enum X86Seg {
 #define MSR_CORE_PERF_FIXED_CTR0        0x309
 #define MSR_CORE_PERF_FIXED_CTR1        0x30a
 #define MSR_CORE_PERF_FIXED_CTR2        0x30b
+#define MSR_PERF_METRICS                0x329
 #define MSR_CORE_PERF_FIXED_CTR_CTRL    0x38d
 #define MSR_CORE_PERF_GLOBAL_STATUS     0x38e
 #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
@@ -2101,6 +2103,7 @@ typedef struct CPUArchState {
     uint64_t msr_fixed_ctr_ctrl;
     uint64_t msr_global_ctrl;
     uint64_t msr_global_status;
+    uint64_t msr_perf_metrics;
     uint64_t msr_fixed_counters[MAX_FIXED_COUNTERS];
     uint64_t msr_gp_counters[MAX_GP_COUNTERS];
     uint64_t msr_gp_evtsel[MAX_GP_COUNTERS];
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9b6407794e43..777510e52843 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4368,6 +4368,10 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
                                   env->msr_fixed_counters[i]);
             }
+            /* SDM: Write IA32_PERF_METRICS after fixed counter 3. */
+            if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_TOPDOWN) {
+                kvm_msr_entry_add(cpu, MSR_PERF_METRICS, env->msr_perf_metrics);
+            }
             for (i = 0; i < num_pmu_gp_counters; i++) {
                 kvm_msr_entry_add(cpu, perf_cntr_base + i,
                                   env->msr_gp_counters[i]);
@@ -4941,6 +4945,9 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS, 0);
         }
+        if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_TOPDOWN) {
+            kvm_msr_entry_add(cpu, MSR_PERF_METRICS, 0);
+        }
         for (i = 0; i < num_pmu_fixed_counters; i++) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
         }
@@ -5297,6 +5304,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
             env->msr_global_status = msrs[i].data;
             break;
+        case MSR_PERF_METRICS:
+            env->msr_perf_metrics = msrs[i].data;
+            break;
         case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
             env->msr_fixed_counters[index - MSR_CORE_PERF_FIXED_CTR0] = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 05aa38a8a43d..2ec6ca1428cf 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -659,6 +659,25 @@ static const VMStateDescription vmstate_msr_ia32_feature_control = {
     }
 };
 
+static bool perf_metrics_enabled(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return !!env->msr_perf_metrics;
+}
+
+static const VMStateDescription vmstate_msr_perf_metrics = {
+    .name = "cpu/msr_architectural_pmu/msr_perf_metrics",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = perf_metrics_enabled,
+    .fields = (const VMStateField[]){
+        VMSTATE_UINT64(env.msr_perf_metrics, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool pmu_enable_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -697,7 +716,11 @@ static const VMStateDescription vmstate_msr_architectural_pmu = {
         VMSTATE_UINT64_ARRAY(env.msr_gp_counters, X86CPU, MAX_GP_COUNTERS),
         VMSTATE_UINT64_ARRAY(env.msr_gp_evtsel, X86CPU, MAX_GP_COUNTERS),
         VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_msr_perf_metrics,
+        NULL,
+    },
 };
 
 static bool mpx_needed(void *opaque)
-- 
2.54.0

