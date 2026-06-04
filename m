Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B82A2BF3D7
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542272; cv=none; b=S99ARjpWx/Kgo7FEah5qFTZhpjevvgaTzk1qNNLgieFR8LdzHUSvgEESF4UvAu3te0i94NyfAPgedjO4kVHlCFm1Bs22kovSKI0W43Q/AaFzU4E+4ZU7bbF7aRbM22KpDbysLXfe4lCqWlfrAKrPQuB3wH6/Iytg//4sfOZX450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542272; c=relaxed/simple;
	bh=Dg+3oIWy4KCI3Tz45arrb6PDGdB/pf5Iy1jWlRr0U1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gg5W6UPOe71d03p9ZgkraJUgI8bplMEsnDRfhNiAwMaF6fADSpxSjzNHuJukVC+Eak5MeUqZUcQj+LGddKWe8jDZpYFpbL1BTy/hvGqfrgVw2U8j7fo04m+++tMwry8WxFGewqzQo49MSWZGA33cpi1GNuWXJnc47p3O10d9c4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J22ypFoR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J22ypFoR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780542270; x=1812078270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dg+3oIWy4KCI3Tz45arrb6PDGdB/pf5Iy1jWlRr0U1o=;
  b=J22ypFoRKoH86vp7g4hZx9TtjJ3XuOOLxPUFu0x5Xf5MULWws191NY/h
   DcLtKSjr422MV44eGby7o0FaO1MnnSajfxgqM7hEMwwAy3rRVLWUdzyKP
   ZmkMj3ueUdXDzrjuZKlW2LyRy7ylXzrWOKZspZsr11E+UJeZ5Cbyxg533
   55aNN7LIw+OR10+AlCY10wwnDWZgJoiKxlVz2WfxpZVQX0Yy1RllnmXJu
   YAMQ1MTzQ3zp+HhKjjFsdzcOX6zegeWA9V5j21PTvufSQo2V9MQV+B/L1
   shEIwYnWLQEgTHy1x4qB7Bl6twqm7ugLXqIIV8I+SESqjEF0Rsglg5Pzf
   A==;
X-CSE-ConnectionGUID: gpceylXBSJioSGk7sOEz1Q==
X-CSE-MsgGUID: c1w2qA7lRjqMekkjVVdu4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399629"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="80399629"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:04:28 -0700
X-CSE-ConnectionGUID: KG1GvLmtTFOmATBiFYddZw==
X-CSE-MsgGUID: RKHEP48LRLawJKZMcWHglg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241915840"
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
Subject: [PATCH v4 2/6] target/i386: Gate enable_pmu on kvm_enabled()
Date: Wed,  3 Jun 2026 19:55:42 -0700
Message-ID: <20260604025546.19378-3-zide.chen@intel.com>
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

Guest PMU support requires KVM.  Clear cpu->enable_pmu when KVM is not
enabled, so PMU-related code can rely solely on cpu->enable_pmu.

This reduces duplication and avoids bugs where one of the checks is
missed.  For example, cpu_x86_cpuid() enables CPUID.0AH when
cpu->enable_pmu is set but does not check kvm_enabled(). This is
implicitly fixed by this patch:

if (cpu->enable_pmu) {
	x86_cpu_get_supported_cpuid(0xA, count, eax, ebx, ecx, edx);
}

Also fix two places that check kvm_enabled() but not cpu->enable_pmu.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Replace a tab with spaces.
---
 target/i386/cpu.c     | 10 +++++++---
 target/i386/kvm/kvm.c |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5e483e8cd25..c978e957df6a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8790,7 +8790,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = 0;
         *edx = 0;
         if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
-            !kvm_enabled()) {
+            !cpu->enable_pmu) {
             break;
         }
 
@@ -9137,7 +9137,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 0x80000022:
         *eax = *ebx = *ecx = *edx = 0;
         /* AMD Extended Performance Monitoring and Debug */
-        if (kvm_enabled() && cpu->enable_pmu &&
+        if (cpu->enable_pmu &&
             (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
             *eax |= CPUID_8000_0022_EAX_PERFMON_V2;
             *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
@@ -9753,7 +9753,7 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
      * are advertised by cpu_x86_cpuid().  Keep these two in sync.
      */
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
-        kvm_enabled()) {
+        cpu->enable_pmu) {
         x86_cpu_get_supported_cpuid(0x14, 0,
                                     &eax_0, &ebx_0, &ecx_0, &edx_0);
         x86_cpu_get_supported_cpuid(0x14, 1,
@@ -9901,6 +9901,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     unsigned requested_lbr_fmt;
 
+    if (!kvm_enabled()) {
+        cpu->enable_pmu = false;
+    }
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     /* Use pc-relative instructions in system-mode */
     tcg_cflags_set(cs, CF_PCREL);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1ac1803e8a2e..5c953a0f3a60 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4483,7 +4483,7 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                               env->msr_xfd_err);
         }
 
-        if (kvm_enabled() && cpu->enable_pmu &&
+        if (cpu->enable_pmu &&
             (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
             uint64_t depth;
             int ret;
@@ -4995,7 +4995,7 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_XFD_ERR, 0);
     }
 
-    if (kvm_enabled() && cpu->enable_pmu &&
+    if (cpu->enable_pmu &&
         (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
         uint64_t depth;
 
-- 
2.54.0

