Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC1273D6D
	for <kvm@vger.kernel.org>; Sat,  2 May 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777753540; cv=none; b=VN225dUVR+CvEH+NX9FIjkBDVWDIEf9AkyAE5/PeYqFdaYc8vofPeZ7ViOZszkZ1496w7E4oBnL+TvrKqMG/uC95PLqbuimpwh64lGNAfj6zvvC1/zQv7SK+eAjNXZRcj9NPUvHjqKlwxU0l9XMiXki5MNnEwQ+y2/mPnixxzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777753540; c=relaxed/simple;
	bh=uuArgmr5eklzqswRp3TstvzVwhQnnvwL6uD+hBsuFaw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JUdAABYKuKz1jgz4BhkAhvFR7Hk7dUsUCOZ64sXgBw/gwOHvBY40GbkCaIaLqcfXnRkMrR3j+RPc0CW9/T2i8TSdyiCsEqiJ9gMDMya3sljcMwyyjqwA5DJpALp0kn4CfRAlKWNspxDOcmRKJ0waGlXsixlt8Pn6/1NGptOrRgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCLe/QT7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCLe/QT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777753538; x=1809289538;
  h=date:from:to:cc:subject:message-id;
  bh=uuArgmr5eklzqswRp3TstvzVwhQnnvwL6uD+hBsuFaw=;
  b=NCLe/QT785GJo9T6Ul8F7qAAVboyo5ttaB8dBLNzuNxnlF3YY3pDK9tn
   6VoZTgsOX/FvX8/oqpmdA2qxaZ8dhlvKM9eq/5iH0QEjJQJSgk9jrARZL
   R2+Ol/YW+QsWjeypjnNzjODtfuV9WDyfRxaHLSE7cWKVoQHRr1TWwvWxE
   y1ohbU7J7KfcszUDUtJ0ppOiFBJ65mxYPL5cdmGX7tF3BbBs30bwI6HYy
   asGWMPlV50LnxIt+ZwUPtYD3AE+oc324qPG1Gr5UsQSjm3GUYdAPKg/8j
   MX2/n7mNabicPgMfI3lj3mV7mlYJyN2dXe5jAePoyNgqxw1okYOsqrgVI
   A==;
X-CSE-ConnectionGUID: cEcrskRqRNKa+DKSm4ZDsg==
X-CSE-MsgGUID: 3Jcu1HLwR2SdbLjeY3KrCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="90053041"
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="90053041"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 13:25:38 -0700
X-CSE-ConnectionGUID: zWSQFuZeSPiY6we/pMrhkw==
X-CSE-MsgGUID: F10fvyZvRzCO7IbHCO5Jlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="235038348"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 May 2026 13:25:35 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJGu5-000000001mr-0i0d;
	Sat, 02 May 2026 20:25:33 +0000
Date: Sun, 03 May 2026 04:25:14 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 Farrah Chen <farrah.chen@intel.com>
Subject: [kvm:kvm-mbec 23/42] arch/x86/kvm/mmu/mmu.c:5596:82: sparse:
 sparse: cast truncates bits from constant value (ffff5555 becomes 5555)
Message-ID: <202605030445.y0PllUlP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git kvm-mbec
head:   0cd666f1b567c059fb1b7c4de7d3c7a55e1d56e6
commit: 4e6f3b85892327c973fb5e7bf4633dce9ea63ec5 [23/42] KVM: x86/mmu: introduce ACC_READ_MASK
config: x86_64-randconfig-121 (https://download.01.org/0day-ci/archive/20260503/202605030445.y0PllUlP-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260503/202605030445.y0PllUlP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605030445.y0PllUlP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/kvm/mmu/mmu.c: note: in included file:
   arch/x86/kvm/mmu/paging_tmpl.h:106:24: sparse: sparse: cast truncates bits from constant value (ffffffffff000 becomes fffff000)
   arch/x86/kvm/mmu/paging_tmpl.h:440:24: sparse: sparse: cast truncates bits from constant value (ffffffffff000 becomes fffff000)
>> arch/x86/kvm/mmu/mmu.c:5596:82: sparse: sparse: cast truncates bits from constant value (ffff5555 becomes 5555)
>> arch/x86/kvm/mmu/mmu.c:5598:59: sparse: sparse: cast truncates bits from constant value (ffff3333 becomes 3333)
>> arch/x86/kvm/mmu/mmu.c:5607:63: sparse: sparse: cast truncates bits from constant value (ffff00ff becomes ff)
>> arch/x86/kvm/mmu/mmu.c:5614:62: sparse: sparse: cast truncates bits from constant value (ffff0f0f becomes f0f)
   arch/x86/kvm/mmu/mmu.c:5617:71: sparse: sparse: cast truncates bits from constant value (ffff00ff becomes ff)

vim +5596 arch/x86/kvm/mmu/mmu.c

  5531	
  5532	/*
  5533	 * Build a mask with all combinations of PTE access rights that
  5534	 * include the given access bit.  The mask can be queried with
  5535	 * "mask & (1 << access)", where access is a combination of
  5536	 * ACC_* bits.
  5537	 *
  5538	 * By mixing and matching multiple masks returned by ACC_BITS_MASK,
  5539	 * update_permission_bitmask() builds what is effectively a
  5540	 * two-dimensional array of bools.  The second dimension is
  5541	 * provided by individual bits of permissions[pfec >> 1], and
  5542	 * logical &, | and ~ operations operate on all the 16 possible
  5543	 * combinations of ACC_* bits.
  5544	 */
  5545	#define ACC_BITS_MASK(access) \
  5546		((1 & (access) ? 1 << 1 : 0) | \
  5547		 (2 & (access) ? 1 << 2 : 0) | \
  5548		 (3 & (access) ? 1 << 3 : 0) | \
  5549		 (4 & (access) ? 1 << 4 : 0) | \
  5550		 (5 & (access) ? 1 << 5 : 0) | \
  5551		 (6 & (access) ? 1 << 6 : 0) | \
  5552		 (7 & (access) ? 1 << 7 : 0) | \
  5553		 (8 & (access) ? 1 << 8 : 0) | \
  5554		 (9 & (access) ? 1 << 9 : 0) | \
  5555		 (10 & (access) ? 1 << 10 : 0) | \
  5556		 (11 & (access) ? 1 << 11 : 0) | \
  5557		 (12 & (access) ? 1 << 12 : 0) | \
  5558		 (13 & (access) ? 1 << 13 : 0) | \
  5559		 (14 & (access) ? 1 << 14 : 0) | \
  5560		 (15 & (access) ? 1 << 15 : 0))
  5561	
  5562	static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
  5563	{
  5564		unsigned byte;
  5565	
  5566		const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
  5567		const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
  5568		const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
  5569	
  5570		bool cr4_smep = is_cr4_smep(mmu);
  5571		bool cr4_smap = is_cr4_smap(mmu);
  5572		bool cr0_wp = is_cr0_wp(mmu);
  5573		bool efer_nx = is_efer_nx(mmu);
  5574	
  5575		/*
  5576		 * In hardware, page fault error codes are generated (as the name
  5577		 * suggests) on any kind of page fault.  permission_fault() and
  5578		 * paging_tmpl.h already use the same bits after a successful page
  5579		 * table walk, to indicate the kind of access being performed.
  5580		 *
  5581		 * However, PFERR_PRESENT_MASK and PFERR_RSVD_MASK are never set here,
  5582		 * exactly because the page walk is successful.  PFERR_PRESENT_MASK is
  5583		 * removed by the shift, while PFERR_RSVD_MASK is repurposed in
  5584		 * permission_fault() to indicate accesses that are *not* subject to
  5585		 * SMAP restrictions.
  5586		 */
  5587		for (byte = 0; byte < ARRAY_SIZE(mmu->permissions); ++byte) {
  5588			unsigned pfec = byte << 1;
  5589	
  5590			/*
  5591			 * Each "*f" variable has a 1 bit for each ACC_* combo
  5592			 * that causes a fault with the given PFEC.
  5593			 */
  5594	
  5595			/* Faults from reads to non-readable pages */
> 5596			u16 rf = (pfec & (PFERR_WRITE_MASK|PFERR_FETCH_MASK)) ? 0 : (u16)~r;
  5597			/* Faults from writes to non-writable pages */
> 5598			u16 wf = (pfec & PFERR_WRITE_MASK) ? (u16)~w : 0;
  5599			/* Faults from user mode accesses to supervisor pages */
  5600			u16 uf = 0;
  5601			/* Faults from fetches of non-executable pages */
  5602			u16 ff = 0;
  5603			/* Faults from kernel mode accesses of user pages */
  5604			u16 smapf = 0;
  5605	
  5606			if (ept) {
> 5607				ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
  5608			} else {
  5609				const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
  5610	
  5611				/* Faults from kernel mode accesses to user pages */
  5612				u16 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
  5613	
> 5614				uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
  5615	
  5616				if (efer_nx)
  5617					ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
  5618	
  5619				/* Allow supervisor writes if !cr0.wp */
  5620				if (!cr0_wp)
  5621					wf = (pfec & PFERR_USER_MASK) ? wf : 0;
  5622	
  5623				/* Disallow supervisor fetches of user code if cr4.smep */
  5624				if (cr4_smep)
  5625					ff |= (pfec & PFERR_FETCH_MASK) ? kf : 0;
  5626	
  5627				/*
  5628				 * SMAP:kernel-mode data accesses from user-mode
  5629				 * mappings should fault. A fault is considered
  5630				 * as a SMAP violation if all of the following
  5631				 * conditions are true:
  5632				 *   - X86_CR4_SMAP is set in CR4
  5633				 *   - A user page is accessed
  5634				 *   - The access is not a fetch
  5635				 *   - The access is supervisor mode
  5636				 *   - If implicit supervisor access or X86_EFLAGS_AC is clear
  5637				 *
  5638				 * Here, we cover the first four conditions.  The fifth
  5639				 * is computed dynamically in permission_fault() and
  5640				 * communicated by setting PFERR_RSVD_MASK.
  5641				 */
  5642				if (cr4_smap)
  5643					smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
  5644			}
  5645	
  5646			mmu->permissions[byte] = ff | uf | wf | rf | smapf;
  5647		}
  5648	}
  5649	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
