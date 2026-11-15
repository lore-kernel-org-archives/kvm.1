Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794744844;
	b=UzdOMpb3ISi3Y1O/i3Uh94jPhr3665QNBpW1WZ1etubtMdQ7WAc7fxa/Ijo7/O/5Vn4X
	 GHqejlf61ID97J94yPQ1Ya7HRqe/yT00QQgJOBEH6k3A62bzOfc/JIZCGlho3jKZMhk1o
	 H0jmqe6uxE/GdD6itrSGDCkYtob4Jc5x5vgepILktVt8/7V+aSaNtywndCqT50lSycHSn
	 BgGm0MU041Mk3WGMCjOCGUudsUTWW/Zkhcrj2Em/g52NyUNy77fsXBXgQcCKXFwxhQnqc
	 F6A8FmLDSCWtOCFvA2SR73rCL9PukhUk6Cl/Sl4nys6GQX0WRC7qhbpdIvqpI0uPM+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794744844;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=wx4o9KhMMhGe2lC66yefkiagWdJ/G57Jci8LHd80gYc=;
	b=zt5UDB0BUDZipMSFNFIlWMRYTqxDxwPwd0aFBIePWFoNXDRt1klgSjSLOzyUInz/YOIK
	 Kar0ryOJAK7JeJbi89AklfgoIoss7L1xZGjm0PHZwBm3KnopBCmTwvet/mcYVsE+6PT5T
	 boEVvanz7r/oO+jfLRP53XsvkueTFA04v8VLBG3FNefT+SYEzFGY8HhudPUuXqllCyL2N
	 SAC2n4WIkdoVqH3qmAsmV8EciYVhTUetkvv2SUzE/4LhHNCoVyQZLMZvzsCbS3E8ZKE4q
	 I/J888mS66H8oqmE2fVF02sqNjJ2kegKf96rLJCCh2m2van6/CR/1qNAlj6zKY+szwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BNpwSmbu;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AF606A31F;
	Sun, 15 Nov 2026 12:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 014AF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BNpwSmbu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794744844; x=1826280844;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=2tdBK2yIisb0pL/TcklAXTTAVZexaZv+CEL227tiS34=;
  b=BNpwSmbukYkb54j9+9GfJHOA0YNcSqq2Fb5QZMVEExmmm17CpS55HN3m
   6/BbjpBKwljXb16fS9kV220pSh3Vnq00EjhRforCns9eZ9BEa48/MEIxj
   LCorD+BKZ0DJ8iex9DsJTzog5OUlJFISMMVKAbqvGzuAHn9ijDHbjdjjl
   XKc+TD8fMTeYw17tf7CdS393Dc8k8P43devNiCC2bsvB73pzJV2TXA5On
   2+7hHCCeO+gigr0pJ9nKNARAbqDUZQ555JKZJP/mZsML5rJ6FOrSZQ5wZ
   OjQmriw0K4mKCPU7SzJuxBjvySoXjuuGU5G+OSzIy6mctscbCgEll5hn/
   A==;
X-CSE-ConnectionGUID: F8EMhlDpQQ6Kx6OQRd/JVA==
X-CSE-MsgGUID: 5epI+I15RtSoNlh4zGF/5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3485748"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3485748"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 04:14:03 -0800
X-CSE-ConnectionGUID: j47z+FVjRkGDKZzr4gnFeg==
X-CSE-MsgGUID: pwldXXnGST+dX9jqj4dg+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9649856"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 04:14:01 -0800
Date: Sun, 15 Nov 2026 20:13:57 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Kevin Cheng <chengkev@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, kvm@vger.kernel.org,
	seanjc@google.com, pbonzini@redhat.com,
	linux-kernel@vger.kernel.org, yosry@kernel.org,
	Kevin Cheng <chengkev@google.com>, yi1.lai@intel.com
Subject: Re: [PATCH] KVM: nVMX: Synthesize advanced VM-Exit info for emulated
 EPT Violations
Message-ID: <202611151806.4ddbcfeb-lkp@intel.com>
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
In-Reply-To: <20261029024005.575065-1-chengkev@google.com>


Hello,

kernel test robot noticed "kselftests.kvm.nested_tdp_fault_test.fail" on:

commit: 1a01388ba3bd52d1535b10bb5974059f9418cd9e ("[PATCH] KVM: nVMX: Synthesize advanced VM-Exit info for emulated EPT Violations")
url: https://github.com/intel-lab-lkp/linux/commits/Kevin-Cheng/KVM-nVMX-Synthesize-advanced-VM-Exit-info-for-emulated-EPT-Violations/20261029-024005
base: https://git.kernel.org/cgit/virt/kvm/kvm.git queue patch link: https://lore.kernel.org/all/20261029024005.575065-1-chengkev@google.com/
patch subject: [PATCH] KVM: nVMX: Synthesize advanced VM-Exit info for emulated EPT Violations

in testcase: kselftests
version: kselftests-x86_64-05441d697f7f-1_20261105
with following parameters:

	group: kvm

config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202611151806.4ddbcfeb-lkp@intel.com

# selftests: kvm: nested_tdp_fault_test
# Random seed: 0x3ccb3ded
#
# ==== Test Assertion Failure ====
#   x86/nested_tdp_fault_test.c:84: (exit_qual) == (((((1UL))) << (0)) | ((((1UL))) << (7)) | ((((1UL))) << (8)))
#   pid=10529 tid=10529 errno=4 - Interrupted system call
#      1        0x0000000000413921: assert_on_unhandled_exception at processor.c:786
#      2        0x00000000004075e6: _vcpu_run at kvm_util.c:1770
#      3         (inlined by) vcpu_run at kvm_util.c:1781
#      4        0x0000000000403902: run_test at nested_tdp_fault_test.c:275
#      5        0x0000000000402c09: main at nested_tdp_fault_test.c:302
#      6        0x00007f102953aca7: ?? ??:0
#      7        0x00007f102953ad64: ?? ??:0
#      8        0x0000000000402d50: _start at ??:?
#   Wanted EXIT_QUAL '0x181', got '0x581'
not ok 40 selftests: kvm: nested_tdp_fault_test # exit=254


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261115/202611151806.4ddbcfeb-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

