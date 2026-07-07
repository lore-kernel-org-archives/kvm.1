Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C8441030;
	Tue,  7 Jul 2026 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449846; cv=none; b=fm3M9dVGw7SvLOhvl/Y/0/trEe5T36kNj02S5pskFKfm54kHqQmbKi7vEhjur5TUMmKwZSv5Xg0FVug0LNY23ry1+WIIPHvKQPuUWdSRAgK0YLbG/N5dlM1ojj2sNaAN+6Ic5Y76w0KNA42XyAZIG3CQak2qZfM3pR8S/RannrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449846; c=relaxed/simple;
	bh=zI3l1mHOP6dwsM+3U35AdhOO98qNzfGzgzCO8hdq3nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItNtrFXwn/iKney7PUWnpjsENONij/4iZZ6CCRHYHCgR2vgS1YAHA2cruEHJWWsx8wLCoTo2xda24q/dds/o/T2dA6zKevCLUPw52Mgwj8EF00Dx/6LPkyHn8R005fsj0R7Kx4cI/i/ApAbSHwtbOWJ+4UxxVyQ8YKN3WmTgPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmRXCsxD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmRXCsxD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449843; x=1814985843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zI3l1mHOP6dwsM+3U35AdhOO98qNzfGzgzCO8hdq3nQ=;
  b=lmRXCsxDori+RgdCALxb8Ufp2whG3vUsaMY0+PEIEsKX6Zn9d+HXGT+A
   8Cjd52wxmDWLnT0Nkem35hY+9tnpDH4OObVVc+qKFXMqjXQtHS0B2p3hH
   ng/ReK406ottCdqH92f/tNKSTQEroj9HRuzS68HNkHEQudrzCqc5Ajx4W
   b2/TUBFA3vxVKkchxs878OVvoiKa052NIoixgH90PYZhbg6L8ukT5uKEa
   vA/SR8KCns8IfX17LZ2+8ZBzFTn+AbnafGzg31xO+Qjt2APkvpNHPq+9C
   0Lq4ZHP579VIeIFS7aubWo7G0TWt3eiaOLaCxYFU533ILhqA4BWcXI8eU
   A==;
X-CSE-ConnectionGUID: NaCY0QluQ7qGC9/R6wEQtw==
X-CSE-MsgGUID: YaBL6AAOSE2Aql+OE5LsfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713886"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:59 -0700
X-CSE-ConnectionGUID: QEPVMb1ERqK11p/LT0GVWw==
X-CSE-MsgGUID: xNqgEkdZTM+ietkj5cgyBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279310"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:58 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 09/15] perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
Date: Tue,  7 Jul 2026 11:33:59 -0700
Message-ID: <20260707183405.15571-10-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707183405.15571-1-zide.chen@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Now that KVM has switched to bitmap-based PMU capabilities,
num_counters_{gp,fixed} can be removed from x86_pmu_capability.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/core.c            | 2 --
 arch/x86/include/asm/perf_event.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 65349819ba43..5bcd2a48d2b3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3132,8 +3132,6 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	 * base PMU holds the correct number of counters for P-cores.
 	 */
 	cap->version		= x86_pmu.version;
-	cap->num_counters_gp	= x86_pmu_num_counters(NULL);
-	cap->num_counters_fixed	= x86_pmu_num_counters_fixed(NULL);
 	cap->cntr_mask64	= x86_pmu.cntr_mask64;
 	cap->fixed_cntr_mask64	= x86_pmu.fixed_cntr_mask64;
 	cap->bit_width_gp	= cap->cntr_mask64 ? x86_pmu.cntval_bits : 0;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index f59a3d466195..4b035629903c 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -300,8 +300,6 @@ union cpuid_0x80000022_ebx {
 
 struct x86_pmu_capability {
 	int		version;
-	int		num_counters_gp;
-	int		num_counters_fixed;
 	union {
 		u64	cntr_mask64;
 		DECLARE_BITMAP(cntr_mask, X86_PMC_IDX_MAX);
-- 
2.54.0

