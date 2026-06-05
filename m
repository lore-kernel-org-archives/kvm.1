Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD323B71B8;
	Fri,  5 Jun 2026 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652255; cv=none; b=LNPcMU7hdFEToCBnyrbtGTEoYjOPspBA66Z73tq2gC3Ioij0v3wAjtycwyfaaHSPugLgbd2SCgp+FOp7LCXP7tSWvT9IruEi9a+e+n8cL5GpBkBR0+5ksRHP+Y0a+iwAOI5XeL4xDPEXVZfcosvrLlCsBf6lwwH44cA5b8DGKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652255; c=relaxed/simple;
	bh=KbOhqR/e8XwQiy3HYYMOtHP0SENwQ+y2ZWdAmV6kBpM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=R1F6Es619kFIIRPxSbu1AS/B5AKihzJ8GWsFl5o9Ct7CrlNYrTvqEYvgRnwc1768OjaPfY+dFhAo8dhU6AKH3WuF+s3w8vTis3ygKh8j9njfvFm3o0NdDXhPG0oVT3ot8XZwbC8fil9YmTv86N6w3NeSU074sWzDR7tKI979Wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcYO5ExO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcYO5ExO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780652254; x=1812188254;
  h=date:from:to:cc:subject:message-id;
  bh=KbOhqR/e8XwQiy3HYYMOtHP0SENwQ+y2ZWdAmV6kBpM=;
  b=RcYO5ExO/UX07w32c0DrY0MwVHkKuKjAmZAmk4DBnXdZ37J0s5K+JY/v
   tglJ0x0OwjBVF0/pFJOro2f7gbQyIuZUIGBMFxa4dEE2JGX1/MoCROUfB
   PipamrE2/KNpx9ivWYXUdyKgtN3m8KJuWF7ZZKmwlRf5vzJHaENOTQRVD
   NZBrPITqD79964T44k7crIXdecODBG7gXnabLOzu79KRtNwHgTQC828FR
   SsOZeqXxP5mEp+0IvBSSs/ohNTwkCFik5ryY1LlFjIysCdWI8rb/VFKtr
   VVuREoLLZJNLWKQVLDYwGoNpPwO0nWwNHFfvgMCni4jkmaFAykoavlE2h
   w==;
X-CSE-ConnectionGUID: rF4hTHdnSBGbo3g0isJ5mQ==
X-CSE-MsgGUID: 1zbDOQ05SAKyMbgVKzcFXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81545549"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81545549"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 02:37:33 -0700
X-CSE-ConnectionGUID: kDaLCwSsSWWTZdKddjVREQ==
X-CSE-MsgGUID: UWCzhlejQfOC5W+S3DAacg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="275038652"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Jun 2026 02:37:32 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVQzY-00000000FoQ-3KhM;
	Fri, 05 Jun 2026 09:37:28 +0000
Date: Fri, 05 Jun 2026 17:36:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [mst-vhost:balloon 8/39] Warning: mm/page_alloc.c:7270
 expecting prototype for alloc_contig_frozen_pages_user_noprof(). Prototype
 was for alloc_contig_frozen_pages_user() instead
Message-ID: <202606051752.lZNueWoo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Hi Michael,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   b145636d693114d343a0a47a4400f5b31e211fec
commit: 2edc4a8a3ed54fe5fd742e60ff3cba3b7dbd8316 [8/39] mm: add alloc_contig_frozen_pages_user for cache-friendly zeroing
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20260605/202606051752.lZNueWoo-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260605/202606051752.lZNueWoo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606051752.lZNueWoo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/page_alloc.c:7270 expecting prototype for alloc_contig_frozen_pages_user_noprof(). Prototype was for alloc_contig_frozen_pages_user() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
