Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD03A8738
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542273; cv=none; b=kO1rVsiXa0wShHoMohoBqzKDsIx3BtOGONkFr8c0LQ/5SIYh8/PTxNy2jclqtxp/DYGxlzHSCEaXOhtKMfPNcBcXWjXf2P1F3y7lWz3CQlrSsftdMrOHUjzp31t5txpzu+PS3Fc8CEon7M4CoxIlkUu4oJ5TTjSJ5ACl/QFnxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542273; c=relaxed/simple;
	bh=EnVdVvtdOT57CZwQs5OzrqwYpQxvUB6tX6ySs6DnbNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmF069bjut5pzTU1SY2dMoBQ4QsB6dPH6Ap/f9czP35cKGRCVqz4HcrHi12zBpysZVvexfPYl5SMtBz3kmOL+XlFrhXDRpQrm3+A3W13JsAgvp863L6CAyUS7X+XcxmjoEkaJ9nd5jjOhmHqhOekPVY79BojF8OKTwOSonjsD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9W29xOp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9W29xOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780542271; x=1812078271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EnVdVvtdOT57CZwQs5OzrqwYpQxvUB6tX6ySs6DnbNY=;
  b=N9W29xOpAJSLF/yt0OMvTpjyY54oZwntVhsEGTV1Bd2mjTUXjyYoQXdM
   dPdHv7wbt7dmlbFVF7cEOpCLL4U4gz7UU7yRfDjXv3+xiaaWko8PoQZa4
   Qgq8KW5h2nJzOkyxYXXmdAUE04zzBrhgaHkmRM2P59QTvr7RVHdMZP2G4
   9L8prtXWTrbg05aRb+GTK5uK5rElC/vOpaJOfgZwWdEtfbAYAPKvJQhpO
   NxzSWaDswFrsE8ixhQwvzNteNHwLycCaI74YNSOBn4WrHq8npBUN+sKgx
   6ChQtvK3mAvDrH/WCxm6zGiRn+zy4G/nV4KSjr/+mmTBOLycUU4hFV2fL
   Q==;
X-CSE-ConnectionGUID: 4ApaRj+NQki2wWd5FEiYrg==
X-CSE-MsgGUID: jsRyp8pCROC1gdfi0mvoxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399641"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="80399641"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:04:28 -0700
X-CSE-ConnectionGUID: QWvo0l2dSrCG04oBhBJRjQ==
X-CSE-MsgGUID: fIuHYvqQReK5djpPG8CdxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241915846"
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
Subject: [PATCH v4 4/6] target/i386: Support full-width writes for perf counters
Date: Wed,  3 Jun 2026 19:55:44 -0700
Message-ID: <20260604025546.19378-5-zide.chen@intel.com>
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

If IA32_PERF_CAPABILITIES.FW_WRITE (bit 13) is set, each general-
purpose counter IA32_PMCi (starting at 0xc1) is accompanied by a
corresponding 64-bit alias MSR starting at 0x4c1 (IA32_A_PMC0).

The legacy IA32_PMCi MSRs are not full-width and their effective width
is determined by CPUID.0AH:EAX[23:16].

Since these MSRs are architectural aliases, when IA32_A_PMCi is
supported it is safe to use it for save/restore instead of the legacy
IA32_PMCi MSRs.

Full-width write is a user-visible feature and can be disabled
individually.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- Move the MAX_GP_COUNTERS change and migrate version ID code to
  [patch v3 4/13] to avoid bumping version IDs twice in one patch
  series.

V2:
- Slightly improve the commit message wording.
- Update the comment for MSR_IA32_PMC0 definition.
---
 target/i386/cpu.h     |  3 +++
 target/i386/kvm/kvm.c | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5288c92fe52f..8cc3c2f139e7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -421,6 +421,7 @@ typedef enum X86Seg {
 
 #define MSR_IA32_PERF_CAPABILITIES      0x345
 #define PERF_CAP_LBR_FMT                0x3f
+#define PERF_CAP_FULL_WRITE             (1U << 13)
 
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
@@ -448,6 +449,8 @@ typedef enum X86Seg {
 #define MSR_IA32_SGXLEPUBKEYHASH3       0x8f
 
 #define MSR_P6_PERFCTR0                 0xc1
+/* Alias MSR range for full-width general-purpose performance counters */
+#define MSR_IA32_PMC0                   0x4c1
 
 #define MSR_IA32_SMBASE                 0x9e
 #define MSR_SMI_COUNT                   0x34
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5c953a0f3a60..a99c1dba83f2 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4270,6 +4270,12 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
         }
 
         if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
+            uint32_t perf_cntr_base = MSR_P6_PERFCTR0;
+
+            if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_FULL_WRITE) {
+                perf_cntr_base = MSR_IA32_PMC0;
+            }
+
             if (pmu_version > 1) {
                 /* Stop the counter.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
@@ -4282,7 +4288,7 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                                   env->msr_fixed_counters[i]);
             }
             for (i = 0; i < num_pmu_gp_counters; i++) {
-                kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i,
+                kvm_msr_entry_add(cpu, perf_cntr_base + i,
                                   env->msr_gp_counters[i]);
                 kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i,
                                   env->msr_gp_evtsel[i]);
@@ -4844,6 +4850,11 @@ static int kvm_get_msrs(X86CPU *cpu)
     }
 
     if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
+        uint32_t perf_cntr_base = MSR_P6_PERFCTR0;
+
+        if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_FULL_WRITE) {
+            perf_cntr_base = MSR_IA32_PMC0;
+        }
         if (pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
@@ -4853,7 +4864,7 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
         }
         for (i = 0; i < num_pmu_gp_counters; i++) {
-            kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i, 0);
+            kvm_msr_entry_add(cpu, perf_cntr_base + i, 0);
             kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i, 0);
         }
     }
@@ -5218,6 +5229,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR0 + MAX_GP_COUNTERS - 1:
             env->msr_gp_counters[index - MSR_P6_PERFCTR0] = msrs[i].data;
             break;
+        case MSR_IA32_PMC0 ... MSR_IA32_PMC0 + MAX_GP_COUNTERS - 1:
+            env->msr_gp_counters[index - MSR_IA32_PMC0] = msrs[i].data;
+            break;
         case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
             env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
             break;
-- 
2.54.0

