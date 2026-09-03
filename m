Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D5223702;
	Thu,  3 Sep 2026 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400285; cv=none; b=LQmYFa8I6rUuXzGgLM1mWbkIRRTV3kObplzdVzJiB1cLmr6cxmgBEvcJE3XzpdSze024CYt+4N3xaxI0sXgvHaBttqPVDM7t6QbVxv5SLNfu0ShN8sdGDjBeVyuNits5JuaWFK1/+LJklHHy3JXcasufPjId2l487c8a2PxUdgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400285; c=relaxed/simple;
	bh=8RaIWadECS+2y7/yh9MkgYmB0nbRAz+aqhhQmiSe6xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SywLeqGQN3H6XQG+Zh2nRXvYuQoXA27F0BL4Q1ynJ8RDKOZKGdGA3urrFFMXXXaOYAqos8dsBg62Q68M9PZC5ndmUi/6qkVq1cx3rPFLonECCoU+HpiKbUftyJ0tEqzZVdvTuq1PfsRUvTYYiJbRyV5d3paaVq11O8/DoxpynJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2qoS9GY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2qoS9GY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788400283; x=1819936283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8RaIWadECS+2y7/yh9MkgYmB0nbRAz+aqhhQmiSe6xE=;
  b=C2qoS9GYOHF0a3DqXkRxVUwYU78zgLbl1K8G587A5G8k1X/GveeEXcMH
   lvgzdoO57/zOR2LywhN3YrEiIGTNBdTcFpdAR2Wj3aVbgpSHofjn2s31+
   q7rnBGSoCeIao+i+ijrYIKGAIPNWLI25bFfWE/QxYto6schDa2Nfq57nr
   M/jarOgamc2kgKK3x57veTsBxKydzc+T2x9jpSIHuj4ForyfmWXgBsS5N
   rMLOOHep3vC8X+5BDL+SVFD2pjJZ3YEgQSrYSRZlX9r1IBWxfa1aIRwFE
   ucLT++m/4GgI0c6QzDS8zs1qOjWEjlrct9KycGYVxKiDgS/dP8Ovq6Uuj
   A==;
X-CSE-ConnectionGUID: El8NjLCRR0m1Uot3b0Rt0A==
X-CSE-MsgGUID: tDFwyZ2pQG2sS6vnq7CA3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99469101"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99469101"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:22 -0700
X-CSE-ConnectionGUID: opMajHb+QL6pkd5gLvIcQw==
X-CSE-MsgGUID: sP1z4fy4SBGVXX4gA4hX6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307770208"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:21 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	kas@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	vannapurve@google.com,
	x86@kernel.org,
	chao.gao@intel.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	tony.lindgren@linux.intel.com,
	binbin.wu@intel.com,
	sohil.mehta@intel.com
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v10 00/11] Dynamic PAMT
Date: Wed,  2 Sep 2026 18:51:02 -0700
Message-ID: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is another revision of the Dynamic PAMT TDX series. The biggest 
change from the last version resulted from a request from Dave to more 
clearly comment and name things *DPAMT* in the DPAMT specific parts of the 
code, rather than PAMT. Discretion was used, and I left some of the PAMT 
names (the API names previously agreed with KVM were not updated, and the 
names associated with the TDX ABI itself were left matching the spec, 
etc). Comments were also strengthened around the earlier get/put patches 
to clarify their temporary limitations. There were no functional changes. 
To help if anyone wants to scrutinize the diff, a rebased branch of v9 is 
pushed here [0].

Our CI AI system has gained some extra checks, which I thought were better
to apply. So that was done too. The changes were all trivial.

Lastly, based on offlist discussion with Dave and Kiryl, I author flipped 
the arch/x86 patches to me and updated them to have a single Intel 
signoff. I left the KVM patches as they were, based on my best expectation 
of Sean's preference.


We have a ton of RBs at this point (8 different people, thanks!), which I 
left in place due to the trivial depth of the changes. All KVM patches 
have Sean's ack. The following escaped Dave's RB last time:
[PATCH 03/11] x86/virt/tdx: Add __tdx_pamt_get/put() helpers
[PATCH 04/11] x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory
[PATCH 09/11] x86/virt/tdx: Enable Dynamic PAMT
[PATCH 10/11] Documentation/x86: Add documentation for TDX's Dynamic PAMT

This should be in pretty good shape, Dave please strongly consider 
applying.

Background
==========
Dynamic PAMT is a TDX feature that allows saving memory by allocating some 
of its page tracking metadata dynamically, instead of statically at boot. 
These static allocations take roughly 0.4% of system memory. The savings 
are variable depending on system and TDX usage, but could be up to 100x. 
For more Dynamic PAMT background, please refer to [1]. For more analysis 
of the savings in different scenarios, see the v6 coverleter[2].

It occurred to me that since the Dynamic PAMT effort began, RAM has become
much more expensive. Consequently, this feature is even more valuable now.
It would be good to enable it for TDX users.

Base
====
This is based on v7.3-rc1. A branch of this series can be found here: [3].

Testing
=======
Since there were not any changes which would be expected to have 
functional impact, I just did some regression testing with our standard 
automated testing for this one. I left Tested-by tags per Hongyu's
preference.


[0] https://github.com/intel-staging/tdx/tree/dpamt_v9_on_v7.3-rc1
[1] https://lore.kernel.org/lkml/20250918232224.2202592-1-rick.p.edgecombe@intel.com/
[2] https://lore.kernel.org/lkml/20260526023515.288829-1-rick.p.edgecombe@intel.com/
[3] https://github.com/intel-staging/tdx/tree/dpamt_v10


Kiryl Shutsemau (2):
  KVM: TDX: Allocate PAMT memory for TD and vCPU control structures
  KVM: TDX: Get/put PAMT pages when (un)mapping private memory

Rick Edgecombe (9):
  x86/virt/tdx: Simplify PAMT layout calculation
  x86/virt/tdx: Allocate page bitmap for Dynamic PAMT
  x86/virt/tdx: Add __tdx_pamt_get/put() helpers
  x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory
  x86/virt/tdx: Handle multiple callers in tdx_pamt_get/put()
  x86/virt/tdx: Add APIs to support Dynamic PAMT ops from KVM's fault
    path
  x86/virt/tdx: Enable Dynamic PAMT
  Documentation/x86: Add documentation for TDX's Dynamic PAMT
  x86/virt/tdx: Optimize tdx_pamt_get/put()

 .../admin-guide/kernel-parameters.txt         |  10 +
 Documentation/arch/x86/tdx.rst                |  27 +
 arch/x86/include/asm/kvm-x86-ops.h            |   1 +
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/include/asm/tdx.h                    |  23 +
 arch/x86/include/asm/tdx_global_metadata.h    |   9 +-
 arch/x86/kvm/mmu/mmu.c                        |   4 +
 arch/x86/kvm/vmx/tdx.c                        |  99 ++--
 arch/x86/kvm/vmx/tdx.h                        |   2 +
 arch/x86/virt/vmx/tdx/tdx.c                   | 460 +++++++++++++++---
 arch/x86/virt/vmx/tdx/tdx.h                   |   2 +
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  23 +-
 12 files changed, 566 insertions(+), 95 deletions(-)

-- 
2.55.0

