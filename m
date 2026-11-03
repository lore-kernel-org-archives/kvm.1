Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697929;
	b=tAbuP5MMugOxeL72lCHlyr6fq75IdsR1cpl++376AV7N19sg2fZnVEnKAjHrSjx9GXBN
	 I3922RTjrZ+J5sR9Dc5FcTKd6bgK645d0LCr2XMBQyVJHaU4VYeytf05O+VtqzU2RVQBU
	 ehhOBeq02grEuMidKdowQozQr6+2qOYFFhx2z9f+DGU2PYdRIYasWMs1kPkEF8xGoVfdI
	 no3LNJg6n9ykSbmWXHR4ZaLBw23klAWXfvwquejcaCnN6feCjw3bvv+GfHwT0MZNPg6eg
	 FP/K8K7jhoTkRz86fnE4mXit0e1lXzG1PlBwZEGmLQaJT5/5JwYRtrs5IKW8L5ULzog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697929;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=VzjsOwpA7+tDGhVV1gOZnFASbF1Yw3cdRY+PIzifsHM=;
	b=4vSBDb6lmAK1XyfIlXttIWbmvYglqCtcD97D/JECYQLcL3/NlMsrM9zkJJ8mbQstGO7h
	 /Adqhw+HbewmvDxK8lYSRTd6Nav9QHUArfoFcjmV51jdqXqmXpTdH4guSXj2FvnT68D60
	 Po6szfdM+9VcKxMgrhyc8EXcBkCJ1/oaIAob4vU2GhA7h7T4xMpsgwgFP668Zypadbh15
	 oDXIMdayprPOo0dsDnUMo2GC31vvQpm6AefYoPc2IHfxarBBg9Q5jboXraP6R+eg3t46W
	 WVLOOMtO6BfcMCnpwd2j35g74t7MT3siVtcTFNcPauZynkkRLuVYujhTo76miB/IwtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eAHuIoQt;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CD606A326;
	Tue,  3 Nov 2026 09:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eAHuIoQt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793697927; x=1825233927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axBssC8auNsg/gQjNzUNBr0llMklPS1mEy+A5Zk0qHM=;
  b=eAHuIoQtLPsChkAFLGK2sAQ5RCXbR5EG0BopHzkFh8trwEPAo4wIG9T2
   pX+CKUL+ByFfQhlIZeBi5XXtaqpvowcuTR54FY+O44360Vd5MbTCPDsOs
   juUdeKyaZS4AnNoQGQWTPILiL1VRgZccvFEhw2JD9HBUrwzcUQHDucSR8
   7Iv6kVKgQOWisQqKiS1A8ccC+jDveJwVjnwbE4WIf32flcWPPPM0klmNE
   Jic4n89r5pNo9C+IjnqdufD5VxZITv9ncMe2z37XaSXU5lAwxRGsHBpWV
   ME4JSV/uDHkW3r0SxJuQuFYKaDit7wQHGgCzD2YofJoajC2aQZVcAv+IK
   w==;
X-CSE-ConnectionGUID: BnriHMpdSG2qUHvC7WUfVA==
X-CSE-MsgGUID: IU/T2jQYRkau75x561PNTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2442660"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2442660"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:25:27 -0800
X-CSE-ConnectionGUID: 6uSocVP+RB6asO/i3BzVvg==
X-CSE-MsgGUID: S1uYRFcLR9m/wi3L8sVdmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6375782"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Nov 2026 01:25:25 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOAle-00000000iYK-3nYc;
	Tue, 03 Nov 2026 09:25:22 +0000
Date: Tue, 3 Nov 2026 17:25:06 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: Re: [PATCH 17/45] KVM: Introduce NR/NW/NX memory attributes
Message-ID: <202611031642.2wbBv9l5-lkp@intel.com>
References: <20261102174512.8903-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102174512.8903-1-pbonzini@redhat.com>

Hi Paolo,

kernel test robot noticed the following build errors:

[auto build test ERROR on kvm/queue]
[also build test ERROR on kvm/next linus/master next-20261030]
[cannot apply to mst-vhost/linux-next kvm/linux-next v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Bonzini/KVM-nVMX-nSVM-check-unconditionally-whether-CR3-is-valid/20261102-124045
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20261102174512.8903-1-pbonzini%40redhat.com
patch subject: [PATCH 17/45] KVM: Introduce NR/NW/NX memory attributes
config: i386-randconfig-1010-20261103 (https://download.01.org/0day-ci/archive/20261103/202611031642.2wbBv9l5-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611031642.2wbBv9l5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611031642.2wbBv9l5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'kvm_vm_ioctl_set_mem_attributes',
       inlined from 'kvm_vm_ioctl' at arch/x86/kvm/../../../virt/kvm/kvm_main.c:5483:7:
>> include/linux/compiler_types.h:702:45: error: call to '__compiletime_assert_799' declared with attribute error: BUILD_BUG_ON failed: sizeof(attrs->attributes) != sizeof(unsigned long)
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:683:25: note: in definition of macro '__compiletime_assert'
     683 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   arch/x86/kvm/../../../virt/kvm/kvm_main.c:2736:9: note: in expansion of macro 'BUILD_BUG_ON'
    2736 |         BUILD_BUG_ON(sizeof(attrs->attributes) != sizeof(unsigned long));
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_799 +702 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  688  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  689  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  690  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  691  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  692  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  693   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  694   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  695   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  696   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  697   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  698   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  699   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  700   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  701  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @702  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  703  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
