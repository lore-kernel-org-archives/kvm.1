Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87523909C;
	Sun,  3 May 2026 03:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777778823; cv=none; b=Rli2/VbpC7dhrMz0s59Ol6b2aV7PjbWqUZqq1EuKC5GdpJLUgzCUyWkL9lHmlUi2bqj0aUTeCoHSVe5+E/C8DOubFa8/8YM6HLPH3ImMO61jVkzZh5UCxSU9mN8kbF67ayjBHw5Jl//mNV+ZXkGuEaXaZvmHluMnf8957pudZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777778823; c=relaxed/simple;
	bh=ShNDtoLBYzDk3lm8mhIExWjIgbBm+p5S+tmhFn8bv1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqF9jnVeNQEhUvLEnTV9ES2JmohEK4Ex/2YM0xNkkeaDbhu3ROIdHngWaDaNO3QrK9bmly+v5s/v9ioI0OUNYJdV61YIyQfV64CSQyb+Q8fOFtIUPDisGHhSPiLuO9oW0e8dnC3ANmiAZkAlEaj8aumrlX8kBH1jLd0nIpZzWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klhthHut; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klhthHut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777778822; x=1809314822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ShNDtoLBYzDk3lm8mhIExWjIgbBm+p5S+tmhFn8bv1U=;
  b=klhthHutUI4W0n5FkW6fu7meZ9akyGR9TRmjOt0pUgkW9E6sBE7tEmY1
   U+PRXv59Nz5WgQA1EUDLZBwBdp2utlzHn4ZuaPE7VVCeYcmb+bdF5+j9O
   JAuYKmASiEFOXQoiJiTJKKmaAHLQYzhr69Zs/+pVTr6ygTLgpl0/MFLFc
   psOXLl3lNreGvGY/JsPhedRaCkWmXTceU66eWcEopOpqyYXGDowDF+n8w
   VSIIdz33bQM714guRLEuyunaEsfwyV73sBkqsacO/ATtREkPd+VLaBUnV
   Hht+FNRE8FmBYk/wKzzCh+5d9COLrW1NgoIRNmtlHaWJDbSzKtw2nGNZX
   Q==;
X-CSE-ConnectionGUID: p/+0ktWESAaimDih4x8VJA==
X-CSE-MsgGUID: dM8qV2VQRna/lkHDp5YdHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="96111886"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="96111886"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 20:27:01 -0700
X-CSE-ConnectionGUID: PCMA6x7IQm2Xg9DcXQBatA==
X-CSE-MsgGUID: 7oZB5GQPQj6AxWUfKMcmfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="240182795"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 02 May 2026 20:26:57 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJNTq-0000000025f-24MX;
	Sun, 03 May 2026 03:26:54 +0000
Date: Sun, 3 May 2026 11:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: "shaikh.kamal" <shaikhkamal2012@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, pbonzini@redhat.com,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>
Subject: Re: [PATCH v2 1/1] mm/mmu_notifier: Add async OOM cleanup via
 call_srcu()
Message-ID: <202605031109.uxckW5L3-lkp@intel.com>
References: <20260429222548.25475-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429222548.25475-1-shaikhkamal2012@gmail.com>

Hi shaikh.kamal,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0]
[cannot apply to akpm-mm/mm-everything kvm/queue kvm/next kvm/linux-next v7.1-rc1 linus/master next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shaikh-kamal/mm-mmu_notifier-Add-async-OOM-cleanup-via-call_srcu/20260430-202943
base:   v7.0
patch link:    https://lore.kernel.org/r/20260429222548.25475-1-shaikhkamal2012%40gmail.com
patch subject: [PATCH v2 1/1] mm/mmu_notifier: Add async OOM cleanup via call_srcu()
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20260503/202605031109.uxckW5L3-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260503/202605031109.uxckW5L3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605031109.uxckW5L3-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/oom_kill.c: In function '__oom_reap_task_mm':
>> mm/oom_kill.c:523:9: error: implicit declaration of function 'mmu_notifier_oom_enter'; did you mean 'mmu_notifier_release'? [-Wimplicit-function-declaration]
     523 |         mmu_notifier_oom_enter(mm);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         mmu_notifier_release


vim +523 mm/oom_kill.c

   515	
   516	static bool __oom_reap_task_mm(struct mm_struct *mm)
   517	{
   518		struct vm_area_struct *vma;
   519		bool ret = true;
   520		MA_STATE(mas, &mm->mm_mt, ULONG_MAX, ULONG_MAX);
   521	
   522		/* Notify MMU notifiers about the OOM event */
 > 523		mmu_notifier_oom_enter(mm);
   524	
   525		/*
   526		 * Tell all users of get_user/copy_from_user etc... that the content
   527		 * is no longer stable. No barriers really needed because unmapping
   528		 * should imply barriers already and the reader would hit a page fault
   529		 * if it stumbled over a reaped memory.
   530		 */
   531		mm_flags_set(MMF_UNSTABLE, mm);
   532	
   533		/*
   534		 * It might start racing with the dying task and compete for shared
   535		 * resources - e.g. page table lock contention has been observed.
   536		 * Reduce those races by reaping the oom victim from the other end
   537		 * of the address space.
   538		 */
   539		mas_for_each_rev(&mas, vma, 0) {
   540			if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
   541				continue;
   542	
   543			/*
   544			 * Only anonymous pages have a good chance to be dropped
   545			 * without additional steps which we cannot afford as we
   546			 * are OOM already.
   547			 *
   548			 * We do not even care about fs backed pages because all
   549			 * which are reclaimable have already been reclaimed and
   550			 * we do not want to block exit_mmap by keeping mm ref
   551			 * count elevated without a good reason.
   552			 */
   553			if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED)) {
   554				struct mmu_notifier_range range;
   555				struct mmu_gather tlb;
   556	
   557				mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0,
   558							mm, vma->vm_start,
   559							vma->vm_end);
   560				tlb_gather_mmu(&tlb, mm);
   561				if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
   562					tlb_finish_mmu(&tlb);
   563					ret = false;
   564					continue;
   565				}
   566				unmap_page_range(&tlb, vma, range.start, range.end, NULL);
   567				mmu_notifier_invalidate_range_end(&range);
   568				tlb_finish_mmu(&tlb);
   569			}
   570		}
   571	
   572		return ret;
   573	}
   574	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
