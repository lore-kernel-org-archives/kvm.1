Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C107368279;
	Fri, 27 Mar 2026 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581346; cv=none; b=sXiO3mzVtNyVLPc3YL6ODvFlViUdm1y7bxiMxN23DIzy83v1VfzmAIP9CF3JKopRTA/O4/2VQaCMFQS5AEZvHKYKs8F1nUVwuroVPYtNc+xzYR8d1g8SgDZJ7FTn6IhyqPW8NozWKkoB2UTJ39ZlVkBaSaZAU+W8ZRB3OM9qTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581346; c=relaxed/simple;
	bh=fQPlU7/Z7DRYjinTle+GkOZKLOiZiZPrCs7WOMiVU5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOrZfNrE4+T0IVDIDMZnqc11qbhNjR0fCIF6m8g9utrsZGCcutH9TITC0+IGDsYh1e35xwofqH+9q53cQfx4jE607B6z88BQT3wDCpNM7yRXOmRiT4kIZurBID1DtKJZcMEP1D2uw7SSaYiAN8NIht+yoUa2sXRNY+qtzP6Hu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rzr4cZNh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rzr4cZNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774581345; x=1806117345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fQPlU7/Z7DRYjinTle+GkOZKLOiZiZPrCs7WOMiVU5A=;
  b=Rzr4cZNhiOE9ReHtZlBTRhNp4NlTPr/Qx6nsb9b7T/uZNxJuqY0oP6+D
   eANvBGDzv+2d0m6Qpt7/YLqMrCe4GpFUbu3KuO0CGqob5fUPKEGcPFgZy
   pUQVmPQq2X93YvRJ6V0STbF6GO74G3PhQxGfB04tVU+frkKgyPuKTBtpu
   2IXBnuSLSsrxw4GcE0nUfyhZeKLc24p2hINb198KbnwuU6q8BW/Z2dUKx
   cAZnACMc1d1Iy/m7WZijz8ahqTRIQUSUpipRoHuytdqtPcGm6K1eIY/aW
   LUAYy4poTX87EZSiFxLyAusIHcUT6Z+ocvmM00Stav/ZMEarDM1ekPDRi
   g==;
X-CSE-ConnectionGUID: p/ZheyfASxO2rOPjstAViw==
X-CSE-MsgGUID: RqIuDgRBSZygwQCEOQujDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75620422"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75620422"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 20:15:45 -0700
X-CSE-ConnectionGUID: fgdNJfD2RxeE8wneYslVhA==
X-CSE-MsgGUID: TYwQd9FQTXysIQeRRWnxqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="248232807"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 20:15:42 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5xff-000000009if-3DD9;
	Fri, 27 Mar 2026 03:15:39 +0000
Date: Fri, 27 Mar 2026 11:15:12 +0800
From: kernel test robot <lkp@intel.com>
To: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: oe-kbuild-all@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Subject: Re: [PATCH v4 2/6] KVM: x86: Move guest_mode helpers to x86.h
Message-ID: <202603271150.0WNYfBuF-lkp@intel.com>
References: <20260326031150.3774017-3-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326031150.3774017-3-yosry@kernel.org>

Hi Yosry,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3d6cdcc8883b5726513d245eef0e91cabfc397f7]

url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/KVM-x86-Move-enable_pmu-enable_mediated_pmu-to-pmu-h-and-pmu-c/20260326-191518
base:   3d6cdcc8883b5726513d245eef0e91cabfc397f7
patch link:    https://lore.kernel.org/r/20260326031150.3774017-3-yosry%40kernel.org
patch subject: [PATCH v4 2/6] KVM: x86: Move guest_mode helpers to x86.h
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20260327/202603271150.0WNYfBuF-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603271150.0WNYfBuF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603271150.0WNYfBuF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kvm/svm/svm_onhyperv.c:11:
   arch/x86/kvm/svm/svm.h: In function 'svm_mark_intercepts_dirty':
>> arch/x86/kvm/svm/svm.h:520:13: error: implicit declaration of function 'is_guest_mode' [-Wimplicit-function-declaration]
     520 |         if (is_guest_mode(&svm->vcpu))
         |             ^~~~~~~~~~~~~
   In file included from arch/x86/kvm/svm/svm_ops.h:7,
                    from arch/x86/kvm/svm/svm_onhyperv.c:12:
   arch/x86/kvm/x86.h: At top level:
>> arch/x86/kvm/x86.h:169:20: error: conflicting types for 'is_guest_mode'; have 'bool(struct kvm_vcpu *)' {aka '_Bool(struct kvm_vcpu *)'}
     169 | static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
         |                    ^~~~~~~~~~~~~
   arch/x86/kvm/svm/svm.h:520:13: note: previous implicit declaration of 'is_guest_mode' with type 'int()'
     520 |         if (is_guest_mode(&svm->vcpu))
         |             ^~~~~~~~~~~~~
--
   In file included from kvm/svm/svm_onhyperv.c:11:
   kvm/svm/svm.h: In function 'svm_mark_intercepts_dirty':
   kvm/svm/svm.h:520:13: error: implicit declaration of function 'is_guest_mode' [-Wimplicit-function-declaration]
     520 |         if (is_guest_mode(&svm->vcpu))
         |             ^~~~~~~~~~~~~
   In file included from kvm/svm/svm_ops.h:7,
                    from kvm/svm/svm_onhyperv.c:12:
   arch/x86/kvm/x86.h: At top level:
>> arch/x86/kvm/x86.h:169:20: error: conflicting types for 'is_guest_mode'; have 'bool(struct kvm_vcpu *)' {aka '_Bool(struct kvm_vcpu *)'}
     169 | static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
         |                    ^~~~~~~~~~~~~
   kvm/svm/svm.h:520:13: note: previous implicit declaration of 'is_guest_mode' with type 'int()'
     520 |         if (is_guest_mode(&svm->vcpu))
         |             ^~~~~~~~~~~~~


vim +/is_guest_mode +520 arch/x86/kvm/svm/svm.h

0b97f929831a70 Sean Christopherson 2026-02-18  509  
0b97f929831a70 Sean Christopherson 2026-02-18  510  static inline void svm_mark_intercepts_dirty(struct vcpu_svm *svm)
0b97f929831a70 Sean Christopherson 2026-02-18  511  {
0b97f929831a70 Sean Christopherson 2026-02-18  512  	vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_INTERCEPTS);
0b97f929831a70 Sean Christopherson 2026-02-18  513  
0b97f929831a70 Sean Christopherson 2026-02-18  514  	/*
0b97f929831a70 Sean Christopherson 2026-02-18  515  	 * If L2 is active, recalculate the intercepts for vmcb02 to account
0b97f929831a70 Sean Christopherson 2026-02-18  516  	 * for the changes made to vmcb01.  All intercept configuration is done
0b97f929831a70 Sean Christopherson 2026-02-18  517  	 * for vmcb01 and then propagated to vmcb02 to combine KVM's intercepts
0b97f929831a70 Sean Christopherson 2026-02-18  518  	 * with L1's intercepts (from the vmcb12 snapshot).
0b97f929831a70 Sean Christopherson 2026-02-18  519  	 */
0b97f929831a70 Sean Christopherson 2026-02-18 @520  	if (is_guest_mode(&svm->vcpu))
0b97f929831a70 Sean Christopherson 2026-02-18  521  		nested_vmcb02_recalc_intercepts(svm);
0b97f929831a70 Sean Christopherson 2026-02-18  522  }
0b97f929831a70 Sean Christopherson 2026-02-18  523  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
