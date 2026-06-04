Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF24222590
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542271; cv=none; b=PLoFySeR9cpqmiqY/MB8tiPphCZE7/tWNtTUUnC7qk6+u7YeD15nukCSqZ64wFpkszslAXkyBRk7vOsbVfhgO6pSmFA+3g+IXhq6tqRvVoTYaMTaHJZokMcUj6jZxWovuEAICXce3H7i3IUb53DizcdB8g7YnIhHvxesx1KEx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542271; c=relaxed/simple;
	bh=4SPDUVFod+VWSgwd5Iuz4sLihxemNPrvCyTioHMz+Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Legfra5tWGwct/6xd07kbOTIfS+jr03SeyzOG6qmc9nWOKSmqLIkmkxl5Y+C3ZzGRL/+GOIcFilt/q8JceFxdOhoHaN+MCg5VdFivEgSMMJKAgI++mxq8MeftnWEAwg0F8rq8PLhWBaTiL2EKLdZYkn97sTUCWBzytThx78I19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuV1M57i; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuV1M57i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780542269; x=1812078269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4SPDUVFod+VWSgwd5Iuz4sLihxemNPrvCyTioHMz+Gc=;
  b=RuV1M57iRGt1+BMZ7/VtQnZTHb7W6oTr0ACteeOcAgtcUxh89SgukOrI
   TQc6P51Lu/HoiLj/M0bNBQph4nlEuG3H/yEolRO8vzkUYClQzZpx/ueOf
   uFF0mUdokjQF51hsunRGmekuLdN/+GSFdAEJ/3p/g3K9TZJ6iqmdX6dwJ
   zyu1zNrgZzMGls8hTbFnu2Uv0Xs/v3HzR5eMBFAPgfRmWU4E5xu4oIw9m
   mN6Ds2J77HpwbeFeI0IxY/wfLxCvZXpbF+FwzqwXNcKpBXsOvZhHRap4r
   LKcRSrkaa8gI7A0kMKaOSfe0CTvfGJwuuTLpb2R7RSKa+wPHglG+Ci6fE
   w==;
X-CSE-ConnectionGUID: a3Y9kQK9S3GFddDc/VsBXw==
X-CSE-MsgGUID: PfqKKCeMRBSc5zPyBDuGWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399623"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="80399623"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:04:28 -0700
X-CSE-ConnectionGUID: PrRGKT41R1O5bZ9TULc3Lw==
X-CSE-MsgGUID: Lk4f/j0wRPy6u1VvWazFqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241915837"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:04:27 -0700
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
Subject: [PATCH v4 1/6] target/i386: Don't save/restore PERF_GLOBAL_OVF_CTRL MSRs
Date: Wed,  3 Jun 2026 19:55:41 -0700
Message-ID: <20260604025546.19378-2-zide.chen@intel.com>
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

MSR_CORE_PERF_GLOBAL_OVF_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR
are write-only MSRs and reads always return zero.

Saving and restoring these MSRs is therefore unnecessary.  Replace
VMSTATE_UINT64 with VMSTATE_UNUSED in the VMStateDescription to ignore
env.msr_global_ovf_ctrl during migration.  This avoids the need to bump
version_id and does not introduce any migration incompatibility.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Fixes: e587632c228e ("target/i386/kvm: support perfmon-v2 for reset")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- Remove MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR as well.
---
 target/i386/cpu.h     |  3 ---
 target/i386/kvm/kvm.c | 10 ----------
 target/i386/machine.c |  4 ++--
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6b500737c3be..ff44487d0b6d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -507,11 +507,9 @@ typedef enum X86Seg {
 #define MSR_CORE_PERF_FIXED_CTR_CTRL    0x38d
 #define MSR_CORE_PERF_GLOBAL_STATUS     0x38e
 #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
 
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS       0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL          0xc0000301
-#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR   0xc0000302
 
 #define MSR_K7_EVNTSEL0                 0xc0010000
 #define MSR_K7_PERFCTR0                 0xc0010004
@@ -2104,7 +2102,6 @@ typedef struct CPUArchState {
     uint64_t msr_fixed_ctr_ctrl;
     uint64_t msr_global_ctrl;
     uint64_t msr_global_status;
-    uint64_t msr_global_ovf_ctrl;
     uint64_t msr_fixed_counters[MAX_FIXED_COUNTERS];
     uint64_t msr_gp_counters[MAX_GP_COUNTERS];
     uint64_t msr_gp_evtsel[MAX_GP_COUNTERS];
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a29f757c168a..1ac1803e8a2e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4290,8 +4290,6 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             if (pmu_version > 1) {
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS,
                                   env->msr_global_status);
-                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
-                                  env->msr_global_ovf_ctrl);
 
                 /* Now start the PMU.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL,
@@ -4335,8 +4333,6 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             if (pmu_version > 1) {
                 kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
                                   env->msr_global_status);
-                kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
-                                  env->msr_global_ovf_ctrl);
                 kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
                                   env->msr_global_ctrl);
             }
@@ -4852,7 +4848,6 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS, 0);
-            kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL, 0);
         }
         for (i = 0; i < num_pmu_fixed_counters; i++) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
@@ -4895,7 +4890,6 @@ static int kvm_get_msrs(X86CPU *cpu)
         if (pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
             kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, 0);
-            kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, 0);
         }
     }
 
@@ -5218,10 +5212,6 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
             env->msr_global_status = msrs[i].data;
             break;
-        case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
-        case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
-            env->msr_global_ovf_ctrl = msrs[i].data;
-            break;
         case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
             env->msr_fixed_counters[index - MSR_CORE_PERF_FIXED_CTR0] = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 48a2a4b31907..e0a5a5da6f5a 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -666,7 +666,7 @@ static bool pmu_enable_needed(void *opaque)
     int i;
 
     if (env->msr_fixed_ctr_ctrl || env->msr_global_ctrl ||
-        env->msr_global_status || env->msr_global_ovf_ctrl) {
+        env->msr_global_status) {
         return true;
     }
     for (i = 0; i < MAX_FIXED_COUNTERS; i++) {
@@ -692,7 +692,7 @@ static const VMStateDescription vmstate_msr_architectural_pmu = {
         VMSTATE_UINT64(env.msr_fixed_ctr_ctrl, X86CPU),
         VMSTATE_UINT64(env.msr_global_ctrl, X86CPU),
         VMSTATE_UINT64(env.msr_global_status, X86CPU),
-        VMSTATE_UINT64(env.msr_global_ovf_ctrl, X86CPU),
+        VMSTATE_UNUSED(sizeof(uint64_t)),
         VMSTATE_UINT64_ARRAY(env.msr_fixed_counters, X86CPU, MAX_FIXED_COUNTERS),
         VMSTATE_UINT64_ARRAY(env.msr_gp_counters, X86CPU, MAX_GP_COUNTERS),
         VMSTATE_UINT64_ARRAY(env.msr_gp_evtsel, X86CPU, MAX_GP_COUNTERS),
-- 
2.54.0

