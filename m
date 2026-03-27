Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF71391505;
	Fri, 27 Mar 2026 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642469; cv=none; b=ZZwV4/8Nh3sx0CGM5pGrE2sDBrGxERTf0Iu0eFzuon4HDuzkRcmZCb81l492hMNiH0kkOn5vlcFl6+AYWWg85nXM8ZwmXwCnVgF5Dg+tqiqSs7hz4ToeNwOAMc7go//S7l4ea9VOoU8MZ0ZVV3HxGzWLELnC7sHmPUhGsWdCqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642469; c=relaxed/simple;
	bh=MXbPMHwiPCxmPzioNYa1OxwRr4A+sok4TIB984w/aek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dxiIVEtVcmR4fOg3umu4BjWKcg6EEuK+ROA2ClWgtP76qyKAGjFlrfo4dfChg/BT6g3x5gNeP6alTzfcUzfcLB8VArbPK8xaIfbsINj7cSfM/mc1NzvLARHYZnMnSJZbBu2wf1v7KfdUpMIpa19eIaDWwbF6IIindnYbaT8elp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJqRGhyr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJqRGhyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642467; x=1806178467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MXbPMHwiPCxmPzioNYa1OxwRr4A+sok4TIB984w/aek=;
  b=QJqRGhyrCeqjgsqGEqcz4i8iBlJC1LDpv6q4xx2q8c1wEcPFwOCvuNYm
   zg6JjOyu6k3K8VToaTERQEpeoRlAgyt5g3rlhULyamoYvGmsktNSbT/C8
   AR7HJLFcLafhIolIEfe32Cox1LtCxIjQASg+CSBVWjMSNyidd74MIQdU+
   1gd6ET8uz14/rpoSbKP0OgQT4VTIupupNxvkHZ13/LKk3H1QKk7fGzHTA
   Hxmj2b78dWxJRtDvPjqSPDd/raKa9M1DSzydSIBdkUHBfLFOjb0bwUTW7
   ei4E6xsE4oW/ci6xwN/b+7TBoUIINKP0EZWdBcjmwTQ5+dg3jTXGUhkKs
   g==;
X-CSE-ConnectionGUID: QpdlJcDuTbCVGSsewstZtQ==
X-CSE-MsgGUID: 6btyNax3Sb+GnEzzmO3EFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182697"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182697"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:26 -0700
X-CSE-ConnectionGUID: DtswxafaRF6T7WgP2cqVvA==
X-CSE-MsgGUID: MxNYjg5MQE+BEZsjYHf4ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922885"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:26 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	kvm@vger.kernel.org,
	kas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	dave.hansen@intel.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 00/17] TDX MMU refactors
Date: Fri, 27 Mar 2026 13:14:04 -0700
Message-ID: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is all the MMU refactors extracted from the discussion on Sean’s 
DPAMT/Huge page combined series [0]. I was thinking that since they are 
valid cleanups in their own way, we could maybe get them upstream ahead of 
time. Yan and I rebased DPAMT/huge pages on this series and made sure it 
all still fits together.

It’s not suggested for merging yet. We should go over it again for a more
thorough bug check with everything put together. Sean/Paolo please feel
free to ignore for now, except to maybe comment if you have any objections
to merging it earlier as a cleanup series.

Changes from on-list discussion:
 - Go back to free_external_spt() name. Since free_external_sp() was 
   dropped from the changes there was no similarly named function to 
   confuse.
 - Suggestions around dropping or moving KVM_BUG_ON/WARNs turned into
   patches.
   
Another possible point of discussion:
 - Is the last patch needed and does it fit in to a general
   refactor/cleanup? (Yan)

Since some of the patches were created from diffs posted by Sean without
SOB, I left them not signed off for now.

Based on kvm-x86-next-2026.03.13, testing was our usual CI suite. AI
review is pending. We'll work through any Sashiko feedback on the list.

Thanks,
Rick

[0] https://lore.kernel.org/kvm/20260129011517.3545883-1-seanjc@google.com/

Rick Edgecombe (4):
  KVM: x86/tdp_mmu: Drop zapping KVM_BUG_ON()
    set_external_spte_present()
  KVM: x86/tdp_mmu: Morph the !is_frozen_spte() check into a
    KVM_MMU_WARN_ON()
  KVM: TDX: Move set_external_spte_present() assert into TDX code
  KVM: x86/mmu: Remove KVM_BUG_ON() that checks lock when removing PTs

Sean Christopherson (13):
  x86/tdx: Use pg_level in TDX APIs, not the TDX-Module's 0-based level
  KVM: x86/mmu: Update iter->old_spte if cmpxchg64 on mirror SPTE
    "fails"
  KVM: TDX: Account all non-transient page allocations for per-TD
    structures
  KVM: x86: Make "external SPTE" ops that can fail RET0 static calls
  KVM: x86/tdp_mmu: Centralize updates to present external PTEs
  KVM: TDX: Drop kvm_x86_ops.link_external_spt(), use
    .set_external_spte() for all
  KVM: TDX: Add helper to handle mapping leaf SPTE into S-EPT
  KVM: x86/mmu: Fold set_external_spte_present() into its sole caller
  KVM: x86/mmu: Plumb the old_spte into kvm_x86_ops.set_external_spte()
  KVM: TDX: Hoist tdx_sept_remove_private_spte() above
    set_private_spte()
  KVM: TDX: Handle removal of leaf SPTEs in .set_private_spte()
  KVM: x86: Move error handling inside free_external_spt()
  KVM: TDX: Move external page table freeing to TDX code

 arch/x86/include/asm/kvm-x86-ops.h |   4 +-
 arch/x86/include/asm/kvm_host.h    |  13 +-
 arch/x86/include/asm/tdx.h         |  14 +-
 arch/x86/kvm/mmu/tdp_mmu.c         | 253 ++++++++++++-----------------
 arch/x86/kvm/vmx/tdx.c             | 147 ++++++++++-------
 arch/x86/virt/vmx/tdx/tdx.c        |  26 ++-
 6 files changed, 219 insertions(+), 238 deletions(-)

-- 
2.53.0

