Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A154774
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542270; cv=none; b=nxSak3jNwnVD4ceg9vBpMInqkwffa4JzDBTFYO3/aD6O/ePGRg3s56LCM/emaKQxRA2aslMHjOj/wjE+RGPPj0GnxaZYasI+zA7FqDRydqxhJVTX+mD7Lvii3m9BwNilwYssHkDwsFIIT2sZrDqg8r7d7IazbkCEFdBheMxOOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542270; c=relaxed/simple;
	bh=SsU12Cc1lmr58sWFD3Tq8cy68WtLDRSM/iuRPaEwHhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktuuRlPqJ4W0q29+qZIyN8v68F5SU8SvLoI/SeGTKaKPKW57rLp/r0eNKAbZ0wtTrrC++x7pZEWFQWruBWEgbHvKooZLS9faW1jRfNw2b7i0znYNNqfkjItxrjBbnKLcaZJ7HE+WBZXNhSO/J57qheUEWFzWDzA9SltQjjyGLvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxknvzlS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxknvzlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780542268; x=1812078268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SsU12Cc1lmr58sWFD3Tq8cy68WtLDRSM/iuRPaEwHhI=;
  b=LxknvzlSNnqHszHCy4uoka+5Iuq2yAUxb2dCjXyGmHiki69iiS/CGrhi
   slZkVgru3L9u3DCz3TgIgxDkOS62zgySYux6wU6sh5vNoMBdUbNvy7m+j
   Bx4oMF8zB7ALGR6uXdtxXp7emdL+p4nw1sJhTKxoEY+VMAZfXp5NFkgFy
   UiD/AMrzxkKoijMUKh2lzVvtmfNL4um2DseXpe2N2Dc+sGFOR5WX0fNho
   qfZPprkh0i+yg9aeLkBsGviLRhm0vHffr/i12J5wcX/lPBU01L+DSm0pM
   TEGMUwYFzeeNYAQGsqM9AdXMdHJGSw5OHrOg84ytrd45Vss4MWPAvbmYG
   Q==;
X-CSE-ConnectionGUID: ETEG7gcTRYS85M49nbneIQ==
X-CSE-MsgGUID: HGDerQwpRYSJwFhXWN/WCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399617"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="80399617"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:04:28 -0700
X-CSE-ConnectionGUID: v8FxMUj5R66shtns7kjqFQ==
X-CSE-MsgGUID: MR5E26xSTHGPjHGYs66sqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241915835"
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
Subject: [PATCH v4 0/6] target/i386: Misc PMU fixes and enabling
Date: Wed,  3 Jun 2026 19:55:40 -0700
Message-ID: <20260604025546.19378-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains a set of fixes, cleanups, and improvements in
target/i386 PMU and MSR handling, including Topdown metrics support.

This version drops some patches that raised more questions in earlier
reviews in order to reduce scope and speed up review and integration.

Patch series overview:
Patches 1-5: Miscellaneous PMU/MSR fixes and cleanups.
Patch 6: Add Topdown metrics feature support.

The KVM patch series for Topdown metrics support:
https://lore.kernel.org/kvm/20260226230606.146532-1-zide.chen@intel.com/T/#t

Changes in v4:
- Drop PEBS-related patches to reduce scope and accelerate merging.
- Drop disbale BTS support patch.
- Reorder and renumber remaining patches (now 6 total).
- Add defensive assert in kvm_init_msrs() in patch 5.

Changes in v3:
- Add new patch 13/13 to support Topdown metrics.
- Separate the adjustment of maximum PMU counters to patch 4/13, in
  order not to bump PMU migration version_id twice.
- Re-base on top of most recent mainline QEMU: d8a9d97317d0
- Remove MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR in patch 2/13.
- Do not support pebs-fmt=0.
- Fix the vmstate name of msr_ds_pebs.
- Misc fixes and cleanup.

Changes in v2:
- Add two new patches to clean up and refactor LBR format handling.
- Introduce a new pebs-fmt command-line option.
- Add a patch to avoid exposing PEBS capabilities when not enabled.
- Trivial fixes and cleanups.

v3: https://lore.kernel.org/qemu-devel/20260304180713.360471-1-zide.chen@intel.com/
v2: https://lore.kernel.org/qemu-devel/20260128231003.268981-1-zide.chen@intel.com/
v1: https://lore.kernel.org/qemu-devel/20260117011053.80723-1-zide.chen@intel.com/

Dapeng Mi (3):
  target/i386: Don't save/restore PERF_GLOBAL_OVF_CTRL MSRs
  target/i386: Support full-width writes for perf counters
  target/i386: Add Topdown metrics feature support

Zide Chen (3):
  target/i386: Gate enable_pmu on kvm_enabled()
  target/i386: Adjust maximum number of PMU counters
  target/i386: Increase MSR_BUF_SIZE and split KVM_[GET/SET]_MSRS calls

 target/i386/cpu.c     |  11 ++--
 target/i386/cpu.h     |  17 +++--
 target/i386/kvm/kvm.c | 150 +++++++++++++++++++++++++++++++++---------
 target/i386/machine.c |  32 +++++++--
 4 files changed, 161 insertions(+), 49 deletions(-)

-- 
2.54.0

