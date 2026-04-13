Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC445274B5F
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096890; cv=none; b=dOCh8HJqwqiL/BZvHG/FmZGJ01iCRLcGooZ1coi4LNAG1eafnGwe6JlDfDbvmcp10JGtiFvLvSgm3YWBuHJlIXJuDTRYryxEnspbiWz4X0XuVIM0QtUZugShhN2n5J/NSoVKjTSuhegNQl9rAflBFcZEBgS6PjBU4VWDyqaeHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096890; c=relaxed/simple;
	bh=KwJnsfDVINndOM5bFo6JPKjv/O2GkMXCR1zpxYqr/xw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Uah7kF9m+ug4KIlVb9mOSf3Xub0Vkgq+FNuxZlwyiuwLiUyvjJYwRtugLMI5ZY2dtccSw/1kNlEMqTmMi88VVfVNhJDmSdcMDS8KWjhigZ5VLAwPDKZZj11KdkofS8P+6/QVJrEMVWh4jxZhSQnNMnNcJCqPqDUZ4yci+/v/CMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W95j+dbT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W95j+dbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776096889; x=1807632889;
  h=date:from:to:cc:subject:message-id;
  bh=KwJnsfDVINndOM5bFo6JPKjv/O2GkMXCR1zpxYqr/xw=;
  b=W95j+dbTBnIi3ybjdIXkcVL73uq0mYoIj2jinbMlu8P000ayrZLIULt/
   8fM5bUJQMnQHBWz2Zn2Dh4SpW6WLAkEgFqnkH4UCnLSx9T9Q1tXuSCm75
   TL7qsaW4M09ZeRhJsWQ+vxR3TZiQfjFUVg9OGnBF4GqSUI0qAMLANxNTN
   eTU04Yx8+/+k2Volg7ICo1wdW5O8Kt/P/kCQ3XXptSiBykrjfwn6ezHbR
   5iu4Rd4QC/GmfuAfydDe4VDdHdEQZSeJTA/p/NCQ9mTg5Fh+skxPWp9PE
   mMUew27zS2yuiod5DFJQnQYvynLOHcvjqUWkUHzlLW/ABdHS/uVKqfrgZ
   Q==;
X-CSE-ConnectionGUID: DhvezloFR5KNBQIWkjYBWA==
X-CSE-MsgGUID: wTm4lFOHTzmMYFSzuwwJPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76913366"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76913366"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 09:14:49 -0700
X-CSE-ConnectionGUID: ER17XR+MRUWK4srW4M4f1Q==
X-CSE-MsgGUID: JYwRxmELTAaUsoeObt0Aag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="230073802"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 13 Apr 2026 09:14:47 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCJvw-0000000006f-1jAo;
	Mon, 13 Apr 2026 16:14:44 +0000
Date: Mon, 13 Apr 2026 18:13:46 +0200
From: kernel test robot <lkp@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 Farrah Chen <farrah.chen@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [kvm:queue 12/12] arch/x86/kvm/svm/avic.c:240:39: error:
 passing argument 1 of 'is_sev_es_guest' from incompatible pointer type
Message-ID: <202604131813.Sp3bcsFp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
head:   8f65c76d62f1f07d68b8a14829a59049311547b1
commit: 8f65c76d62f1f07d68b8a14829a59049311547b1 [12/12] Merge tag 'kvm-x86-svm-7.1' of https://github.com/kvm-x86/linux into HEAD
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260413/202604131813.Sp3bcsFp-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260413/202604131813.Sp3bcsFp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604131813.Sp3bcsFp-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kvm/svm/avic.c: In function 'avic_deactivate_vmcb':
>> arch/x86/kvm/svm/avic.c:240:39: error: passing argument 1 of 'is_sev_es_guest' from incompatible pointer type [-Wincompatible-pointer-types]
     240 |         if (!is_sev_es_guest(svm->vcpu.kvm))
         |                              ~~~~~~~~~^~~~
         |                                       |
         |                                       struct kvm *
   In file included from arch/x86/kvm/svm/avic.c:31:
   arch/x86/kvm/svm/svm.h:415:62: note: expected 'struct kvm_vcpu *' but argument is of type 'struct kvm *'
     415 | static __always_inline bool is_sev_es_guest(struct kvm_vcpu *vcpu)
         |                                             ~~~~~~~~~~~~~~~~~^~~~


vim +/is_sev_es_guest +240 arch/x86/kvm/svm/avic.c

   232	
   233	static void avic_deactivate_vmcb(struct vcpu_svm *svm)
   234	{
   235		struct vmcb *vmcb = svm->vmcb01.ptr;
   236	
   237		vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
   238		vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
   239	
 > 240		if (!is_sev_es_guest(svm->vcpu.kvm))
   241			svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
   242	
   243		/*
   244		 * If running nested and the guest uses its own MSR bitmap, there
   245		 * is no need to update L0's msr bitmap
   246		 */
   247		if (is_guest_mode(&svm->vcpu) &&
   248		    vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_MSR_PROT))
   249			return;
   250	
   251		/* Enabling MSR intercept for x2APIC registers */
   252		avic_set_x2apic_msr_interception(svm, true);
   253	}
   254	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
