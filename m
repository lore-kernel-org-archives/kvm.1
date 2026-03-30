Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206737998A;
	Mon, 30 Mar 2026 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843951; cv=none; b=qRpMgI3wpYZsbxigTsNiYyBOlDzels1cm/T8zf9gOHvvNfbPfU24XDQ+wN+lb8HaTjBSf8ihhMpUVtuPLaHdPb5iCAEHWfnQxQ4LUds4SptHWrwOcP/3nigpOymY7KIHB7Y2CrFHTRTYVAfj7Mm+TH1MTZd8YtWMpNc/ujUSJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843951; c=relaxed/simple;
	bh=O0bSZX3JUKFDSpPMlS8JSmszt9CmVzs3vVTM6vBDhHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu0w420bb6LOdF0V4Odx/Msx9WmHrGo4lDLxr0gbdgtdwAHqUGNcGCsaXv/b98u5CqY5e3MzMHdxOe94jdPS+V6de5a7XiFTjiY4ANxeLjX1Eu5IYRq4GjPbJ+/QfwxbtTGjuF8p3ZZrALLDfnRT5h8vX7cSHLx5rzLo8e9bVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ci9dRH/i; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ci9dRH/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774843948; x=1806379948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O0bSZX3JUKFDSpPMlS8JSmszt9CmVzs3vVTM6vBDhHg=;
  b=Ci9dRH/i+VAYMC0YNX65FEpQOC4VNQ6Q5GzZXkBhFLCDaWFSO3798Sim
   vtRe82OxllmxsUsSaCW8U6MEC3eDr3gupboRxfwO8TJSDNVW65tLuYCkt
   TOiCnPLzurlj9vWkOb63XQPD6RE70MPXoh61BMjDzeDmCfNNQKfjMLMD8
   RQQhUUGa7PVD4lZ6za0QHX0401KNWYWLX3jZrcR5qP4XU5u99rnfmuj7V
   RlF5fXMuoBzLQ1VXlTgsbk+YJr06GBicXzUPLlb+ZKgfnIiotdw9sdjyS
   X14mzIx9VQoVrO4Nymd63u6XeqzxZ1QqKa8GvvxGAnZAV0xw91JP0nNEA
   A==;
X-CSE-ConnectionGUID: u7tVUiy/T8WwcQ1mrPml6g==
X-CSE-MsgGUID: rVyGr9rbSNeFVLZ0k5YosA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75893567"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75893567"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 21:12:27 -0700
X-CSE-ConnectionGUID: lRj9odjLSW69kS9s4uaACA==
X-CSE-MsgGUID: HcvSfGWOQXaossdY2ugkQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="221533104"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Mar 2026 21:12:25 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w73zC-000000000eX-2PRO;
	Mon, 30 Mar 2026 04:12:22 +0000
Date: Mon, 30 Mar 2026 12:12:21 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 08/24] KVM: x86/mmu: introduce ACC_READ_MASK
Message-ID: <202603301246.a5sPkQdh-lkp@intel.com>
References: <20260326181723.218115-9-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326181723.218115-9-pbonzini@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[also build test WARNING on kvm/next tip/x86/tdx linus/master v7.0-rc6 next-20260327]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Bonzini/KVM-TDX-VMX-rework-EPT_VIOLATION_EXEC_FOR_RING3_LIN-into-PROT_MASK/20260329-124019
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20260326181723.218115-9-pbonzini%40redhat.com
patch subject: [PATCH 08/24] KVM: x86/mmu: introduce ACC_READ_MASK
config: x86_64-randconfig-123-20260329 (https://download.01.org/0day-ci/archive/20260330/202603301246.a5sPkQdh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260330/202603301246.a5sPkQdh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603301246.a5sPkQdh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/kvm/mmu/mmu.c: note: in included file:
   arch/x86/kvm/mmu/paging_tmpl.h:106:24: sparse: sparse: cast truncates bits from constant value (ffffffffff000 becomes fffff000)
   arch/x86/kvm/mmu/paging_tmpl.h:440:24: sparse: sparse: cast truncates bits from constant value (ffffffffff000 becomes fffff000)
>> arch/x86/kvm/mmu/mmu.c:5585:82: sparse: sparse: cast truncates bits from constant value (ffff5555 becomes 5555)
>> arch/x86/kvm/mmu/mmu.c:5587:59: sparse: sparse: cast truncates bits from constant value (ffff3333 becomes 3333)
>> arch/x86/kvm/mmu/mmu.c:5589:58: sparse: sparse: cast truncates bits from constant value (ffff0f0f becomes f0f)
>> arch/x86/kvm/mmu/mmu.c:5591:59: sparse: sparse: cast truncates bits from constant value (ffff00ff becomes ff)

vim +5585 arch/x86/kvm/mmu/mmu.c

  5519	
  5520	/*
  5521	 * Build a mask with all combinations of PTE access rights that
  5522	 * include the given access bit.  The mask can be queried with
  5523	 * "mask & (1 << access)", where access is a combination of
  5524	 * ACC_* bits.
  5525	 *
  5526	 * By mixing and matching multiple masks returned by ACC_BITS_MASK,
  5527	 * update_permission_bitmask() builds what is effectively a
  5528	 * two-dimensional array of bools.  The second dimension is
  5529	 * provided by individual bits of permissions[pfec >> 1], and
  5530	 * logical &, | and ~ operations operate on all the 16 possible
  5531	 * combinations of ACC_* bits.
  5532	 */
  5533	#define ACC_BITS_MASK(access) \
  5534		((1 & (access) ? 1 << 1 : 0) | \
  5535		 (2 & (access) ? 1 << 2 : 0) | \
  5536		 (3 & (access) ? 1 << 3 : 0) | \
  5537		 (4 & (access) ? 1 << 4 : 0) | \
  5538		 (5 & (access) ? 1 << 5 : 0) | \
  5539		 (6 & (access) ? 1 << 6 : 0) | \
  5540		 (7 & (access) ? 1 << 7 : 0) | \
  5541		 (8 & (access) ? 1 << 8 : 0) | \
  5542		 (9 & (access) ? 1 << 9 : 0) | \
  5543		 (10 & (access) ? 1 << 10 : 0) | \
  5544		 (11 & (access) ? 1 << 11 : 0) | \
  5545		 (12 & (access) ? 1 << 12 : 0) | \
  5546		 (13 & (access) ? 1 << 13 : 0) | \
  5547		 (14 & (access) ? 1 << 14 : 0) | \
  5548		 (15 & (access) ? 1 << 15 : 0))
  5549	
  5550	static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
  5551	{
  5552		unsigned byte;
  5553	
  5554		const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
  5555		const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
  5556		const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
  5557		const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
  5558	
  5559		bool cr4_smep = is_cr4_smep(mmu);
  5560		bool cr4_smap = is_cr4_smap(mmu);
  5561		bool cr0_wp = is_cr0_wp(mmu);
  5562		bool efer_nx = is_efer_nx(mmu);
  5563	
  5564		/*
  5565		 * In hardware, page fault error codes are generated (as the name
  5566		 * suggests) on any kind of page fault.  permission_fault() and
  5567		 * paging_tmpl.h already use the same bits after a successful page
  5568		 * table walk, to indicate the kind of access being performed.
  5569		 *
  5570		 * However, PFERR_PRESENT_MASK and PFERR_RSVD_MASK are never set here,
  5571		 * exactly because the page walk is successful.  PFERR_PRESENT_MASK is
  5572		 * removed by the shift, while PFERR_RSVD_MASK is repurposed in
  5573		 * permission_fault() to indicate accesses that are *not* subject to
  5574		 * SMAP restrictions.
  5575		 */
  5576		for (byte = 0; byte < ARRAY_SIZE(mmu->permissions); ++byte) {
  5577			unsigned pfec = byte << 1;
  5578	
  5579			/*
  5580			 * Each "*f" variable has a 1 bit for each ACC_* combo
  5581			 * that causes a fault with the given PFEC.
  5582			 */
  5583	
  5584			/* Faults from reads to non-readable pages */
> 5585			u16 rf = (pfec & (PFERR_WRITE_MASK|PFERR_FETCH_MASK)) ? 0 : (u16)~r;
  5586			/* Faults from writes to non-writable pages */
> 5587			u16 wf = (pfec & PFERR_WRITE_MASK) ? (u16)~w : 0;
  5588			/* Faults from user mode accesses to supervisor pages */
> 5589			u16 uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
  5590			/* Faults from fetches of non-executable pages*/
> 5591			u16 ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
  5592			/* Faults from kernel mode fetches of user pages */
  5593			u16 smepf = 0;
  5594			/* Faults from kernel mode accesses of user pages */
  5595			u16 smapf = 0;
  5596	
  5597			if (!ept) {
  5598				/* Faults from kernel mode accesses to user pages */
  5599				u16 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
  5600	
  5601				/* Not really needed: !nx will cause pte.nx to fault */
  5602				if (!efer_nx)
  5603					ff = 0;
  5604	
  5605				/* Allow supervisor writes if !cr0.wp */
  5606				if (!cr0_wp)
  5607					wf = (pfec & PFERR_USER_MASK) ? wf : 0;
  5608	
  5609				/* Disallow supervisor fetches of user code if cr4.smep */
  5610				if (cr4_smep)
  5611					smepf = (pfec & PFERR_FETCH_MASK) ? kf : 0;
  5612	
  5613				/*
  5614				 * SMAP:kernel-mode data accesses from user-mode
  5615				 * mappings should fault. A fault is considered
  5616				 * as a SMAP violation if all of the following
  5617				 * conditions are true:
  5618				 *   - X86_CR4_SMAP is set in CR4
  5619				 *   - A user page is accessed
  5620				 *   - The access is not a fetch
  5621				 *   - The access is supervisor mode
  5622				 *   - If implicit supervisor access or X86_EFLAGS_AC is clear
  5623				 *
  5624				 * Here, we cover the first four conditions.  The fifth
  5625				 * is computed dynamically in permission_fault() and
  5626				 * communicated by setting PFERR_RSVD_MASK.
  5627				 */
  5628				if (cr4_smap)
  5629					smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
  5630			}
  5631	
  5632			mmu->permissions[byte] = ff | uf | wf | rf | smepf | smapf;
  5633		}
  5634	}
  5635	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
