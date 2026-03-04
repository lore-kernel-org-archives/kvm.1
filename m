Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908143CB2E7
	for <kvm@vger.kernel.org>; Wed,  4 Mar 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648104; cv=none; b=ov2TaJaY6aCiWMVRKLHCQO/JAQrdPAIw7HEXSwjtvz+mQpYZXyH7RetC4ofB3IEbXWmuGKSP7XeAjeucYiTUpNCGLtyqn4H0aPVg6Me2f++NcBQb8KjG3bkkLyqTFQRiUjRls+2za/wM6OD9E16+muU6N+lhyO10mnqc4SZPHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648104; c=relaxed/simple;
	bh=N0SHoLljF/MCoB389ZwqutDCaAw1GwpReyOAlqS5GW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QOaLhwuy222roxrxaQooUFDsLF8kWutqShm1SGx8X5gmrwCj/n/YcfMZrF1qv4vBWt3JH19sNnCCs0SQkb6nG9GgKRRjHxVjxeX1rycVtvD4ja6qt2q7rvqmB0RAzWsDHrMxnalH2NLDZZH5kjucILyb9sv3pCZ7l/YGY5JkqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgmKwLxU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgmKwLxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772648103; x=1804184103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N0SHoLljF/MCoB389ZwqutDCaAw1GwpReyOAlqS5GW8=;
  b=UgmKwLxU/0QUDmzHdI+/KB0D1GZw3nAhr5k98L6an3sY5f87Hk9+XOx/
   olqjkJ09VNALNd++MD0nYkTxfzvjXwtk97uSd79VQLMBH2O1Kf0vFkibx
   uW0oWEEFtzROBi9tyrcbt291K+80BnVxbC9km3kT089Ly728aCd+9aedC
   SA6JybjU/8aUN1u6NAS7blh+YHtLtKyemOa3F5vEEcSOlO/Z5eoZX+Zbd
   ozRO2iv3QF6oDyoa+VGdJQyLwf2J2LxgRptsDCkyC50kRStIj5hFystz6
   Fo7lw5gSTZaAPl5gc/uuWk83obTFpbOjw66D9YIlCoQiD/6eXorJZHGgq
   Q==;
X-CSE-ConnectionGUID: 0T3kEGIzSqWjsTZMTGU2TA==
X-CSE-MsgGUID: wGyXrWlPT3yhpNUkbEqCGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909262"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="73909262"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 10:15:02 -0800
X-CSE-ConnectionGUID: g2Lg8O2sRgWzUlux0pcPqg==
X-CSE-MsgGUID: eb69BEjESYqikboFM3I7fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="214542758"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 10:15:01 -0800
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
Subject: [PATCH V3 00/13] target/i386: Misc PMU fixes and enabling
Date: Wed,  4 Mar 2026 10:06:59 -0800
Message-ID: <20260304180713.360471-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains a set of fixes, cleanups, and improvements in
target/i386 PMU: legacy PEBS, Topdown metrics, and generic MSR
handling.

The patches are grouped into a single series for review convenience.
Some of them are not tightly coupled and can be reviewed and applied
individually.

For example, the PEBS-related changes could be a separate series, and
the Topdown metrics patch could be separate.  However, they touch
closely related PMU and MSR code paths, and keeping them together here
makes review easier and helps avoid potential merge conflicts.

Patch series overview:
Patches 1-6: Miscellaneous PMU/MSR fixes and cleanups.
Patches 7-8, 11–12: Complete legacy PEBS support in QEMU.
Patches 9-10: Refactoring in preparation for pebs-fmt support.
Patch 13: Add Topdown metrics feature support.

The KVM patch series for Topdown metrics support:
https://lore.kernel.org/kvm/20260226230606.146532-1-zide.chen@intel.com/T/#t

Changes since v2:
- Add new patch 13/13 to support Topdown metrics.
- Separate the adjustment of maximum PMU counters to patch 4/13, in
  order not to bump PMU migration version_id twice.
- Re-base on top of most recent mainline QEMU: d8a9d97317d0
- Remove MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR in patch 2/13.
- Do not support pebs-fmt=0.
- Fix the vmstate name of msr_ds_pebs.
- Misc fixes and cleanup.

Changes since v1:
- Add two new patches to clean up and refactor LBR format handling.
- Introduce a new pebs-fmt command-line option.
- Add a patch to avoid exposing PEBS capabilities when not enabled.
- Trivial fixes and cleanups.

v1: https://lore.kernel.org/qemu-devel/20260117011053.80723-1-zide.chen@intel.com/
v2: https://lore.kernel.org/qemu-devel/20260128231003.268981-1-zide.chen@intel.com/T/#t

Dapeng Mi (4):
  target/i386: Don't save/restore PERF_GLOBAL_OVF_CTRL MSRs
  target/i386: Support full-width writes for perf counters
  target/i386: Add get/set/migrate support for legacy PEBS MSRs
  target/i386: Add Topdown metrics feature support

Zide Chen (9):
  target/i386: Disable unsupported BTS for guest
  target/i386: Gate enable_pmu on kvm_enabled()
  target/i386: Adjust maximum number of PMU counters
  target/i386: Increase MSR_BUF_SIZE and split KVM_[GET/SET]_MSRS calls
  target/i386: Make some PEBS features user-visible
  target/i386: Clean up LBR format handling
  target/i386: Refactor LBR format handling
  target/i386: Add pebs-fmt CPU option
  target/i386: Clean up Intel Debug Store feature dependencies

 target/i386/cpu.c         | 140 ++++++++++++++++++++---------
 target/i386/cpu.h         |  42 ++++++---
 target/i386/kvm/kvm-cpu.c |   3 +
 target/i386/kvm/kvm.c     | 179 +++++++++++++++++++++++++++++++-------
 target/i386/machine.c     |  54 ++++++++++--
 5 files changed, 328 insertions(+), 90 deletions(-)

-- 
2.53.0

