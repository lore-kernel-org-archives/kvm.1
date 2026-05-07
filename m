Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551E344D86;
	Thu,  7 May 2026 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189203; cv=none; b=NlB73NsClAoEfga9kTyH/qK5TBH/zMxyPPabuHNuQpti7SaKK4V/G2t66armB4oOEHJ7oBhk0MpSKkxqgQGeyxU5XC4dGHu5DqfxuMghy6YeIs++xarm4iAcldMNrs5c85ECX/5+NIuk3kZGlcAyGaE19hKULyq9iy1Rlo30QxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189203; c=relaxed/simple;
	bh=rVWiIO8GAMs4uV1pDYNtDWy1Here0ynutD/CS72c9WA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jj8mGDMz6o5ejmDG+1sAUGEPWbt5YFfYAmgdK0lLOWq98VdP17jzxfhC6uZMlzSlOiGO7W93kpFcGBpzuV7myzsPpgOCUstuJ69Dx3Vf1CQqJ3V4SCeEl9zZVw+kD8F3iuR/vFTLRERhiK7bxmOiIyDBN3AasS1GyUj188vj0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O40zOUYT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O40zOUYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778189201; x=1809725201;
  h=date:from:to:cc:subject:message-id;
  bh=rVWiIO8GAMs4uV1pDYNtDWy1Here0ynutD/CS72c9WA=;
  b=O40zOUYTcH+hms6wjTLccCwrDryO0J/yxxRxEmPF7pSq4q/U7Bp7DGPJ
   Q+x7gTZg6OmrH8vzLNrGzIy79hMNMUjPWxqvCCENv3aMObYhzuQza2kSP
   obos6aBg0hAQcsFMd3kP4QWEyVhVcFJsM8UEuPsC4x6Ceqy1iA+wMPFp6
   C2bBB+wDmR2lIxW0aqLmWQb/J5FZRE5BFS2GLLqkSv1WVVAN8w8qUafOr
   GP4D8/QPfj7hshiHTjga3mZdIqCsVBL4LrWBteUA5NXAbp0ZLVNDht0+9
   VVoXYWtFiXvCK7pi55EM/sf3AVuprqR/JxdGYbLPNKno2SrzM8ePXVq/x
   g==;
X-CSE-ConnectionGUID: VQwYeBTGShaqK2+iRhMxrg==
X-CSE-MsgGUID: M4CSJ7vyRaukYiRb+JPlzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90613776"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90613776"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 14:26:41 -0700
X-CSE-ConnectionGUID: HAElt25yRx6Li1dwiHrElw==
X-CSE-MsgGUID: hOQETuFEQCuChI65WnJS2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="232033842"
Received: from lkp-server01.sh.intel.com (HELO d6e19f2f5857) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 May 2026 14:26:39 -0700
Received: from kbuild by d6e19f2f5857 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wL6Ev-000000000SH-0PAu;
	Thu, 07 May 2026 21:26:37 +0000
Date: Fri, 08 May 2026 05:26:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [mst-vhost:balloon 6/30] Warning: mm/mempolicy.c:2444
 function parameter 'user_addr' not described in '__alloc_pages_mpol'
Message-ID: <202605080515.6jRN5wN7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   9f56ee36fbf6a6d336dc6a9eaeb4f8a67cb42a31
commit: c4289f5a4e563611a468b4b5379025a4aa4a7c12 [6/30] mm: thread user_addr through page allocator for cache-friendly zeroing
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260508/202605080515.6jRN5wN7-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605080515.6jRN5wN7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605080515.6jRN5wN7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/mempolicy.c:2444 function parameter 'user_addr' not described in '__alloc_pages_mpol'
>> Warning: mm/mempolicy.c:2444 expecting prototype for alloc_pages_mpol(). Prototype was for __alloc_pages_mpol() instead
   Warning: mm/mempolicy.c:2547 expecting prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
