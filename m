Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794723158;
	b=Va49lzgMct2SHPm+g4GeLECIXW3kNW9SzVQ2sPk5iZgXqRAjf+OD3JDTkFSQgSCBhPsH
	 n1vOaJ+XoLyEfUTTRNFfKM0bwSbaw5inM3yyvuTy/RffVawTnlrUsUF7HMjTpWPuv/7H+
	 MFzPX0rBPW/J0pl9Z/zwqbHzZ7sfLW2zJaqAllRfLvTmnWronX4w2ajJR0j3aNGQKilj6
	 be/PVxqzsfOgeRDlpEZnQCj7yZUg0Jj6yiS5K4VVfcShJV5uuDgsU1Nxe7CxfSbcJ8Geg
	 uvMJzM+BHRiGSjhObYGHtlo8M5Yyk6TyhAcYjASd8ttQQ2M9zGHbv5ZDVjLuMKCXvmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794723158;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=ytMfKLlb+8TFduX4LEm8vQBksMeHNyWpTdHQS1yNLWo=;
	b=reYJ+JwVcV22ur9P/z0J9YhApnXbpuAZFqrcOUL5wZOfoK8/WMdPs9s2CM9XS37hOBFm
	 uLV9CDbbCuCX6Ls110Gb1zJg7eHoZSdyQ5DzZHkwSiWHumz3P9gXJQY4HbPoopbc9IhjX
	 j5tySnPwDXbkIy55GPjfrSEiOEDG+vH9/wPYM4rpfxpazjcqDzq1Ys1E8CFNCin1NXO6S
	 1YDGb5M46zXH+CsiYGFEEgoTJVa7M3FuOp748QiFKan8PQg/RvQbo9LDclguFWSk960NS
	 VmvvY/+B56Qi/yFTnE9st/fn7cJ3lCqsk0vnfzAEVbYvpgEOE7OUSNxJ+ehRPgkXCUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jF+7fszk;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF0606A329
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 06:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5CF0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jF+7fszk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794723157; x=1826259157;
  h=date:from:to:cc:subject:message-id;
  bh=WaJqmMU5Rk7UxVfC5zB8/PfWhy9sfUb5n/VBggTrDa4=;
  b=jF+7fszkqVa5BJpy0Sqbr46BlTwNv3fT1b4UXG7VoQKpTS4WJEtLUDDw
   ZUVGBsqeEFXXgvbJQtnnsJO2tZ0sntva9RSr81QrOZGd7FcC9NXbJvYNd
   il5c0jyO4g6IsEi8LAg8HfZU0+OeKK1nn0Tuqu3MJ2PjBTUv5F+X5cjgG
   zJSVh8ykvxzvTgi3cN9AfkpdHckwy3hzRqJN8zER2/IKL5Tp5Jl4+UD/Y
   yrMOPMMM6ZSzUwAqxmWyf9WyFs+3q2HPp/nBWj/qPEUTFHc6rPoWcxagS
   LdtLRjLB8aSrA5qlz18Xbh5XjkWMnrHETYjyfm76Y7vMwxB//Ts8mJ+gJ
   A==;
X-CSE-ConnectionGUID: 2WSAoTHISDWGvzIdf34uww==
X-CSE-MsgGUID: Dex2OlA2SYWAl717cSbmBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3358879"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3358879"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 22:12:37 -0800
X-CSE-ConnectionGUID: DGdCookFQli8gWEKJWqs5Q==
X-CSE-MsgGUID: VpZ0NVNSSh632x+F1hF/JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9694041"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Nov 2026 22:12:34 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xSTTb-000000016Sd-3ygg;
	Sun, 15 Nov 2026 06:12:31 +0000
Date: Sun, 15 Nov 2026 14:11:40 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kvm@vger.kernel.org, Farrah Chen <farrah.chen@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [kvm:kvm-memprot-v4 33/54] ld.lld: error: call to
 __compiletime_assert_485 marked "dontcall-error": Need native word sized
 stores/loads for atomicity.
Message-ID: <202611151427.xPh7Ijtn-lkp@intel.com>
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
commit: 4764db743fe860556eea711a26ef11c74db647d2 [33/54] KVM: Introduce a generation number for memory attributes
config: i386-randconfig-1003-20261113 (https://download.01.org/0day-ci/archive/20261115/202611151427.xPh7Ijtn-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261115/202611151427.xPh7Ijtn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611151427.xPh7Ijtn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: call to __compiletime_assert_485 marked "dontcall-error": Need native word sized stores/loads for atomicity.
>> ld.lld: error: call to __compiletime_assert_485 marked "dontcall-error": Need native word sized stores/loads for atomicity.
>> ld.lld: error: call to __compiletime_assert_485 marked "dontcall-error": Need native word sized stores/loads for atomicity.
>> ld.lld: error: call to __compiletime_assert_485 marked "dontcall-error": Need native word sized stores/loads for atomicity.
   ld.lld: error: call to __compiletime_assert_780 marked "dontcall-error": BUILD_BUG_ON failed: sizeof(attrs->attributes) != sizeof(unsigned long)
>> ld.lld: error: call to __compiletime_assert_485 marked "dontcall-error": Need native word sized stores/loads for atomicity.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
