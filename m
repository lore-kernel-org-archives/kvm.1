Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715148;
	b=jrepdKO/yYA48JfPE58LzwdCV+gLfkNFdbHHY3kVhgYHIMnEPhhooPIsM3ikcnJQfdZC
	 ChPTjT4v6UoutOvjKT/FG90ngsu1o6PxctjD/P8+mxGA8YgquAjKr7kES/tQd7LULmZlu
	 tr/FwANsCKe7eFkEpm4LghkAYWXTzxDSSfYBi7bPrj6E4wjR99dcO7Y2avBrSiGoVpwOE
	 9+Sbcpdt6Ac0pILyJ5Yp1vC05hEkQhR5S79N1FQfkQZW5jKa/7q71iL9CGcB+wf6mQAoS
	 qlWIwr0bxKgKDe5BX7ozuoGnT3YCQDpzHkSY9F4bpa2BQRDPnxtRTgj5yxM10YZlHQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715148;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Eesf9lxozUdMnetwmPu754uA3KVkBfzDrE0eDVDJ2UA=;
	b=qOA6eiifRPrWOIK3Adl3voHQDfOeRUmjj9nWoP5aKDLmgCVGMKZOV9F97/zPyxm45V7+
	 h9SWJkmwgmhwjSfp6UoItWB64u/bMukCHPGccL2oqaraqK6HbIYV79l+i+NTi4CtavTXf
	 r0POsk7ayoAYcMYOLAJIWfEKnPq4dQjnu5IxYJJjnRWkq7D7BUrlu+zg9qoUhKCTse49w
	 XReP9t3yLPTsPKa/hTSkb05mCB/19y8NOP50A3JgVhWUrvTvgabaRLnY8S3Fpc7+uDSNP
	 HAAxmWFkrLdVVq9rYxK11XyjU19j97ScTJbWuvg1zBFM4G/QW1Qc8DekOz5ZiLO3gKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ao9p2MRl;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD3606A327;
	Tue,  3 Nov 2026 14:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29FD3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ao9p2MRl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793715147; x=1825251147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AG9SejqizuSU9dqiGUfetYq9cDG0DMmqEfppslJdVyQ=;
  b=ao9p2MRlVc+rEMMS7zGs4/BkK9K1gel2XDzq21nLsul8sQEv8xum1xiX
   eqCZkA80LaNUjjG4+kBiyrYMmD4NDdtUe0CA/Kj7P5FEB3Q08WJmeCD53
   Wb2zyiYn+YLIuDm+As+1kIJtXdMH2WCHvT38+PqnvPbz+8f6pGREOMJP/
   R3DKO0VSxKoiKVTL2A6Psus5z81nRpqID8rDuB11dng5s/p3JLljDJ+PW
   T3zh0nADi6oh8IlTBHdR/up1Q8ED7TPgmA4D7QwI7aHiB5JeUNm085dOX
   KzCkTa2LIHABKPAo2NChA84vSx5LpsLgBAyt79ordxJNODxjipdlFuq6u
   Q==;
X-CSE-ConnectionGUID: Q6NQfskeQi+IjOdqTv+60w==
X-CSE-MsgGUID: GFU0r7K/Q4OgiC+MYvdT6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2330219"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2330219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:12:26 -0800
X-CSE-ConnectionGUID: XVV0O7VQRoGkq64OU6944Q==
X-CSE-MsgGUID: p799BbrCSLmxgZkZbDe1pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6759732"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Nov 2026 06:12:25 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOFFO-00000000iou-2DnN;
	Tue, 03 Nov 2026 14:12:22 +0000
Date: Tue, 3 Nov 2026 22:11:50 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: Re: [PATCH 24/45] KVM: Introduce a generation number for memory
 attributes
Message-ID: <202611032129.t2hEI0s4-lkp@intel.com>
References: <20261102174512.8903-8-pbonzini@redhat.com>
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
In-Reply-To: <20261102174512.8903-8-pbonzini@redhat.com>

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
patch link:    https://lore.kernel.org/r/20261102174512.8903-8-pbonzini%40redhat.com
patch subject: [PATCH 24/45] KVM: Introduce a generation number for memory attributes
config: i386-randconfig-1010-20261103 (https://download.01.org/0day-ci/archive/20261103/202611032129.t2hEI0s4-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611032129.t2hEI0s4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611032129.t2hEI0s4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   include/linux/kvm_host.h: In function 'kvm_mem_attributes_generation.isra':
>> include/linux/compiler_types.h:702:45: error: call to '__compiletime_assert_523' declared with attribute error: Need native word sized stores/loads for atomicity.
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:683:25: note: in definition of macro '__compiletime_assert'
     683 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:9: note: in expansion of macro 'compiletime_assert'
     705 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/barrier.h:69:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      69 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   include/linux/kvm_host.h:2640:16: note: in expansion of macro 'smp_load_acquire'
    2640 |         return smp_load_acquire(&kvm->mem_attrs.generation);
         |                ^~~~~~~~~~~~~~~~
--
   In file included from <command-line>:
   include/linux/kvm_host.h: In function 'kvm_mem_attributes_generation.isra':
>> include/linux/compiler_types.h:702:45: error: call to '__compiletime_assert_523' declared with attribute error: Need native word sized stores/loads for atomicity.
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:683:25: note: in definition of macro '__compiletime_assert'
     683 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:9: note: in expansion of macro 'compiletime_assert'
     705 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/barrier.h:69:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      69 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   include/linux/kvm_host.h:2640:16: note: in expansion of macro 'smp_load_acquire'
    2640 |         return smp_load_acquire(&kvm->mem_attrs.generation);
         |                ^~~~~~~~~~~~~~~~
   In function 'kvm_vm_ioctl_set_mem_attributes',
       inlined from 'kvm_vm_ioctl' at arch/x86/kvm/../../../virt/kvm/kvm_main.c:5624:7:
   include/linux/compiler_types.h:702:45: error: call to '__compiletime_assert_804' declared with attribute error: BUILD_BUG_ON failed: sizeof(attrs->attributes) != sizeof(unsigned long)
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
   arch/x86/kvm/../../../virt/kvm/kvm_main.c:2795:9: note: in expansion of macro 'BUILD_BUG_ON'
    2795 |         BUILD_BUG_ON(sizeof(attrs->attributes) != sizeof(unsigned long));
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_523 +702 include/linux/compiler_types.h

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
