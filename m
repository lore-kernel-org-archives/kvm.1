Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547235F5EA
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542272; cv=none; b=sxohIL5mJZQuw1spupy1vIzcM2lJIQYrpGegD7zZZm6kXGAEkHYH/OFuNdomOtIrRLKfxKvjQK5H+/EwQ5b58BEdr8/O2GwRDZCnSLAFteLWoWbo3mdK6Xr9nl5WwBFylEH87z7+pjz/Q9fx8hZBARNi3szcF5lHywzZTBY7qSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542272; c=relaxed/simple;
	bh=PMzI3YZ0L+NAo/l8+Nt3RSqvHcB4Y/+2l1U9Rw+fXbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lit38mIJsKdNkQoZGNXfH4Tc1obepieZMl1znDEke4olpeboDcDzp6qBOwOg9JMhMIKC5uSIIFp0yAt8FSF7Egd8yl08vb9QLpHatSGvVmw2UNPVcwTa4C1Nbc4turg4JZ6ExA3PfTSNZZYJGHP4A6vnoOXLijuuaZbxA+56quY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuZNgc4q; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuZNgc4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780542271; x=1812078271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PMzI3YZ0L+NAo/l8+Nt3RSqvHcB4Y/+2l1U9Rw+fXbQ=;
  b=IuZNgc4qHpUHJ235UGQxBeJJkCX04XxNhXVH54fyD8LjuUkxtqVPmiNq
   UjOECdh10KaNfYkw/uuggVNzLdqfhhRhvNJNT8bzqR9tEg1WF6W55itF4
   P3HGjYU6rIxHcU5QGV8wF8zuefbR+NFn5ztGyoBU7wpJeknJLoQE6cZbg
   woPhgOgVABzQrPgukBeaJvjvZSBuEUaCW47HSa340Irh8oJGAyaomQTlO
   CdhVfR2H46xyz2WZJlpZT4/O9UDq83snvCeZXHZlQdoyf32mIbqexw/9m
   tpwX+4gdMDOZ+OwndIRiYieTr6TSqj+UqZ0I4stKWB205V9ojGQtV+j7e
   w==;
X-CSE-ConnectionGUID: u3cv77/+TJCoWIYenFe71w==
X-CSE-MsgGUID: 7Y2/bKaWSVCtz11ckNzBSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399635"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="80399635"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:04:28 -0700
X-CSE-ConnectionGUID: QhnE5wOERjaep8zYLB+3pQ==
X-CSE-MsgGUID: GXcGaxnBSbaVjZcxxO0idg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241915843"
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
Subject: [PATCH v4 3/6] target/i386: Adjust maximum number of PMU counters
Date: Wed,  3 Jun 2026 19:55:43 -0700
Message-ID: <20260604025546.19378-4-zide.chen@intel.com>
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

Changing either MAX_GP_COUNTERS or MAX_FIXED_COUNTERS affects the
VMState layout and therefore requires bumping the migration version
IDs.  Adjust both limits together to avoid repeated VMState version
bumps in follow-up patches.

To support full-width writes, QEMU needs to handle the alias MSRs
starting at 0x4c1.  With the current limits, the alias range can
extend into MSR_MCG_EXT_CTL (0x4d0).  Reducing MAX_GP_COUNTERS from 18
to 15 avoids the overlap while still leaving room for future expansion
beyond current hardware (which supports at most 10 GP counters).

Increase MAX_FIXED_COUNTERS to 7 to support additional fixed counters
(e.g. Topdown metric events).

With these changes, bump version_id to prevent migration to older
QEMU, and bump minimum_version_id to prevent migration from older
QEMU, which could otherwise result in VMState overflows.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 target/i386/cpu.h     | 8 ++------
 target/i386/machine.c | 4 ++--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ff44487d0b6d..5288c92fe52f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1751,12 +1751,8 @@ typedef struct {
 #define CPU_NB_REGS CPU_NB_REGS32
 #endif
 
-#define MAX_FIXED_COUNTERS 3
-/*
- * This formula is based on Intel's MSR. The current size also meets AMD's
- * needs.
- */
-#define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
+#define MAX_FIXED_COUNTERS 7
+#define MAX_GP_COUNTERS    15
 
 #define NB_OPMASK_REGS 8
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index e0a5a5da6f5a..05aa38a8a43d 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -685,8 +685,8 @@ static bool pmu_enable_needed(void *opaque)
 
 static const VMStateDescription vmstate_msr_architectural_pmu = {
     .name = "cpu/msr_architectural_pmu",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = pmu_enable_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_fixed_ctr_ctrl, X86CPU),
-- 
2.54.0

