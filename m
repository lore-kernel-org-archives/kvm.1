Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794643687;
	b=ES515OduRFTwgkt84par5+0iSR/0JOKdWS3AwpxUsJ1KZ7pcaUySjQEsxgziLYfoosVI
	 2AK38r+Mk7j8cDZgZX/f8yKhNgBKK1wc9Ib68dELaC1P78txUH1iUn8ix+q79masa1S9z
	 +HbrJ+bfPvDW5PJYBUnv3NH+Muo7UQgLGlUAqopKJVwrH/CxMsO+yUUzy5GeQmrVcT5/9
	 2Zwliw93ofwUbqyOTd2d0f7gCgXBp9NFfUKnqDf1idTnd3tJCPqRnixPRCPrEfB9r+5qj
	 mEv3GbFh3Ou2XYLQY1ugDJcMDfK62Ygm1iD0mIzMOZasUpMAIJTjd42wq5KmVoje0bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794643687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=AMvfvtuGPCIX4hwXez9m9TR/hOp92TjyZdeouklQZFI=;
	b=oEXwLVqaVVNF7VRiqKMT8/FcTCu3QAnhx0SDe8QsM63fg2g7cL6+NiR0lEVcSQzPnKXe
	 Hwit4jkqVLSwF0S86eN/sopUnkLBLMJfE3pA9uGnMOFIpxKm0NnCeNdL+QX6L74QOlrIo
	 AvP2H1+fIin+nzbEnj1NtPMDnsoGCtfvnRv3VrL4HIQhVdgFIiA/RZjzQwCExnIxD92CJ
	 dv+5lgqsXCqy18pJbhnhGqIh95iRvrJ1al5o97zkB/JqZbc1fR3lFbxT198t+MaUFoMGB
	 m4dL0AglxpbppT1PBd1VEXTc9oS2lxRGMw14g3+HR1PzrfdFr1ALvB3+JIUYnn7aMkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="cQkbF+b/";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028D606A32E
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 08:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1028D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cQkbF+b/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794643687; x=1826179687;
  h=date:from:to:cc:subject:message-id;
  bh=9RrjyNNU8Fx7Fz4gw1ab+JcI5Ul7RVjRZks5ZBos2v0=;
  b=cQkbF+b/hrh77MZ9ZP2QdpYnJwySOjUQov/6a0nuIDxniDf+aJpYsKjO
   Tapdj2IA5YQK4zgQc7PY8QZYFqUyfeTNteS+fauj3EY9qJAGQ8+XrSdGf
   vftUlv3cFNRwNML4dnYFyiJfnx4/ZNFD7ewYwfvJd8GT1h9nvOfDIrS9n
   ZdDTIt35mlwPtcSr+UKO9og1gOoh2xg6Af82Mjg0YvdB8y8V0+9AogSur
   Alp5BArx1+vMS9Tk12yY3ySVCsup2Ed9Ibq+HyF3XC9SkZBqmHFav6Sud
   B0TuAOLvNsG5/0WFeQQm1b9jL4y1llGzyZnB7I6ScnwF4GZM0pGKHOGLW
   Q==;
X-CSE-ConnectionGUID: vQ5o54ffTrmh02MYTvE+Ag==
X-CSE-MsgGUID: cyA0culsRXua8G9SEUIjhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3324824"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3324824"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 00:08:07 -0800
X-CSE-ConnectionGUID: DC3T8hBDTWmzcnLyTX5R5Q==
X-CSE-MsgGUID: YTnOhEkWQnO099y+6Ki0lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="10833011"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 14 Nov 2026 00:08:04 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xS8np-0000000158w-3Ofo;
	Sat, 14 Nov 2026 08:08:01 +0000
Date: Sat, 14 Nov 2026 16:07:05 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kvm@vger.kernel.org, Farrah Chen <farrah.chen@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [kvm:kvm-memprot-v4 26/54] ld.lld: error: call to
 __compiletime_assert_775 marked "dontcall-error": BUILD_BUG_ON failed:
 sizeof(attrs->attributes) != sizeof(unsigned long)
Message-ID: <202611141509.8iHcv46y-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git kvm-memprot-v4
head:   e71c4e83c03926c300f6c43e79b783d47ba8b588
commit: fd506bfd91720a0465a26f9baf6d9ee57c81b847 [26/54] KVM: Introduce NR/NW/NX memory attributes
config: i386-randconfig-1003-20261113 (https://download.01.org/0day-ci/archive/20261114/202611141509.8iHcv46y-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261114/202611141509.8iHcv46y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611141509.8iHcv46y-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: call to __compiletime_assert_775 marked "dontcall-error": BUILD_BUG_ON failed: sizeof(attrs->attributes) != sizeof(unsigned long)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
