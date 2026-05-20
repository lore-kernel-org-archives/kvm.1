Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE713033DA;
	Wed, 20 May 2026 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779250551; cv=none; b=edfTC6LZio+zwzAUlHhNGZBjvMh8bYvXYftR+TLMNpyBHeb7AhTIScQqK7jHNH96Gc5tYIO0/NZDLrHCKSZ9l1szZeOHrPeaETtzdvnYnXd7DmkN2QJBQtoZLldB/7U0ZVMhcm1Q96hhilK5/FrG9xqssyNl8iPlILvMYZYJhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779250551; c=relaxed/simple;
	bh=T5gh6HnIzWv6Iy2U5wZfG2McbffscTXsXbuX3f21K9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwCLlGsm7g63darh/DYd50nDq/YtkmhvRrJMx7wu9kSwEhUCXDTdd6uZrgAOCB5VGjTrfnpipbZcICIZERTo2tBHA511FupdVayPIWafS1U0Cnt0czH/paErCeD/AIHkbK1VkuF+msBnlxfqLnlWKNQQOaYxtbOTCHq5Fzt9j9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWACBDlT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWACBDlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779250549; x=1810786549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T5gh6HnIzWv6Iy2U5wZfG2McbffscTXsXbuX3f21K9o=;
  b=cWACBDlTGZmu6b6GV6oKo5OTa+kHmIIoddxPMe9tQfa8FteASS/NXcyF
   O5hCEVTaEcDE8W9j0krPbjKU3t6fdqFiDjz21PvmMBlOHEWzujRL1hNGE
   okHoysPP/FC8RoM9JBhRfU5YplXzEOg7lcpacJLPbG96l9F4TTkcYBewv
   a/QzHGmjRtx6zn/8uqX9byO47BkDk8ngzcNdfvk4EuiqI5klY+UF/SUXu
   Jnk2zHINBKGPn/HWaUjXMOZ8DmPlzKtzaEeeG3ns2LOBv4Ewosua/nmk0
   lpGm41H3CM61AG6OW75pSvAzq8Jf10B5nnha3V4zvDh5ruuTu5mHEGAR5
   A==;
X-CSE-ConnectionGUID: OFCkriXCSCiS1EdyE6XA9Q==
X-CSE-MsgGUID: IOo5OcAAS0ygdJ2kLHYFGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91607298"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91607298"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 21:15:48 -0700
X-CSE-ConnectionGUID: 50UwvDCvSsywYtl1DUQpPg==
X-CSE-MsgGUID: S2paGORbQPyezW/ivCR/JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233646785"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 19 May 2026 21:15:45 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPYLN-000000002R3-3EFc;
	Wed, 20 May 2026 04:15:41 +0000
Date: Wed, 20 May 2026 12:15:24 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	Steffen Eiden <seiden@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Michael Roth <michael.roth@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM, SEV: fix merge conflict
Message-ID: <202605201202.pnbQfWkV-lkp@intel.com>
References: <20260519202851.1339906-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519202851.1339906-1-arnd@kernel.org>

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on kvm/queue]
[also build test ERROR on kvm/next linus/master v7.1-rc4 next-20260519]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/KVM-SEV-fix-merge-conflict/20260520-043413
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20260519202851.1339906-1-arnd%40kernel.org
patch subject: [PATCH] KVM, SEV: fix merge conflict
config: x86_64-rhel-9.4-kselftests (https://download.01.org/0day-ci/archive/20260520/202605201202.pnbQfWkV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605201202.pnbQfWkV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605201202.pnbQfWkV-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kvm/svm/sev.c: In function 'kvm_lockdep_assert_sev_lock_held':
>> arch/x86/kvm/svm/sev.c:117:32: error: 'struct kvm' has no member named 'rc'
     117 |         if (!refcount_read(&kvm->rc.users_count))
         |                                ^~


vim +117 arch/x86/kvm/svm/sev.c

   109	
   110	static __always_inline void kvm_lockdep_assert_sev_lock_held(struct kvm *kvm)
   111	{
   112	#ifdef CONFIG_PROVE_LOCKING
   113		/*
   114		 * Querying SEV+ support is safe if there are no other references, i.e.
   115		 * if concurrent initialization of SEV+ is impossible.
   116		 */
 > 117		if (!refcount_read(&kvm->rc.users_count))
   118			return;
   119	
   120		/*
   121		 * Querying SEV+ support from vCPU context is always safe, as vCPUs can
   122		 * only be created after SEV+ is initialized (and KVM disallows all SEV
   123		 * sub-ioctls while vCPU creation is in-progress).
   124		 */
   125		if (kvm_get_running_vcpu())
   126			return;
   127	
   128		lockdep_assert_held(&kvm->lock);
   129	#endif
   130	}
   131	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
