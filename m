Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95E37C913;
	Fri,  3 Apr 2026 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205605; cv=none; b=f5mQwKeAfT7YMLJCoU2KE+yLT7tUdSJWDptT5Y8LitjK/D0mHjaLvWmMOwAnyzMmP1zzPrju/LdcWwzNLG/GMSAAAuVyT+ZZZsb05ejpLRDGIsE5YrrzL/H2vPXmBpDVi8wwmRxWNaK7vpdn7N9t5gQLf5tThaCEtEcjGvTrF3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205605; c=relaxed/simple;
	bh=4NpuTgtQubgd0Goa0gz+SlCjolrad5ID45WJmtv8lns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2ABJbA+3oO9xsUl8f5FjvuRHtg1flumhCb5UwR1XiAvXZFfWKZFMIOmxLzV88RxB08repfl/1YwSWFC5G4oaKGp1Gf4C7ok6c+2vciH96nH2JL/1RwS4qAbiLnO1GtQqfXsIfy9gpDQ2gbrpK9tpdpyJCTVNpWYhlURb2vf0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpAz6Hcc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpAz6Hcc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775205604; x=1806741604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4NpuTgtQubgd0Goa0gz+SlCjolrad5ID45WJmtv8lns=;
  b=hpAz6HccwDQ3GehYy70eoCg2cmKpiUf98d+C4Y2ZnJ9+7Q/EaE71NQ5n
   Qy2w+7zfuA5O9glQO6mGIcSoMNs+OL4O26sfpLFUHESReaDDiY5IV3dnI
   F1Op0aQP9TiK9njez8NnpviLtN2kxUCM1Kr8U5VC0msbbCgxfXmQiFwe0
   TJtN0ic9tMfHTCObQx+C1fEhlVlNGKcNQF5Fgf+b3EX+xiOP4rTxM4H+6
   ic4YhWijt2h6+r96DxJMF4+rIfQyQaS/lV3XS0TymcaAT9zJ6kYwVhV3G
   MW6M9xk+zZfpOtuFTGJQFT/mYb+HM7wvums1lS7Mg/G1W+EMT853YFe8h
   w==;
X-CSE-ConnectionGUID: n/obfpR/SP6/bOShlJFT3A==
X-CSE-MsgGUID: ScahsEkiQ42lp0XCjtmaig==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76156553"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="76156553"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 01:40:02 -0700
X-CSE-ConnectionGUID: iSOUjhXaQa+Zvz7mT/XTYQ==
X-CSE-MsgGUID: YTH3wLz/SV6dN90yKBKubg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="220570282"
Received: from lkp-server01.sh.intel.com (HELO 064ad336901d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Apr 2026 01:39:57 -0700
Received: from kbuild by 064ad336901d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8a4H-0000000011b-3VXz;
	Fri, 03 Apr 2026 08:39:53 +0000
Date: Fri, 3 Apr 2026 16:39:04 +0800
From: kernel test robot <lkp@intel.com>
To: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v6 01/10] KVM: x86: Define
 KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
Message-ID: <202604021052.kPiiRT2h-lkp@intel.com>
References: <20260326174944.3820245-2-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326174944.3820245-2-jmattson@google.com>

Hi Jim,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3d6cdcc8883b5726513d245eef0e91cabfc397f7]

url:    https://github.com/intel-lab-lkp/linux/commits/Jim-Mattson/KVM-x86-Define-KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT/20260330-195326
base:   3d6cdcc8883b5726513d245eef0e91cabfc397f7
patch link:    https://lore.kernel.org/r/20260326174944.3820245-2-jmattson%40google.com
patch subject: [PATCH v6 01/10] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20260402/202604021052.kPiiRT2h-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260402/202604021052.kPiiRT2h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604021052.kPiiRT2h-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kvm/svm/svm_onhyperv.c:11:
>> arch/x86/kvm/svm/svm.h:622:4: error: call to undeclared function 'kvm_check_has_quirk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     622 |                 !kvm_check_has_quirk(svm->vcpu.kvm,
         |                  ^
   In file included from arch/x86/kvm/svm/svm_onhyperv.c:12:
   In file included from arch/x86/kvm/svm/svm_ops.h:7:
>> arch/x86/kvm/x86.h:429:20: error: conflicting types for 'kvm_check_has_quirk'
     429 | static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
         |                    ^
   arch/x86/kvm/svm/svm.h:622:4: note: previous implicit declaration is here
     622 |                 !kvm_check_has_quirk(svm->vcpu.kvm,
         |                  ^
   2 errors generated.


vim +/kvm_check_has_quirk +622 arch/x86/kvm/svm/svm.h

   618	
   619	static inline bool l2_has_separate_pat(struct vcpu_svm *svm)
   620	{
   621		return nested_npt_enabled(svm) &&
 > 622			!kvm_check_has_quirk(svm->vcpu.kvm,
   623					     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
   624	}
   625	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
