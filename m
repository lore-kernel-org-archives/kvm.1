Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9493A7F74;
	Mon, 30 Mar 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857042; cv=none; b=L4Dx3jLQCInqYWu2r4iG1xVwHe7Vj5m5HSAnpH7FhQ+D5DFqrVAymrfvZXGfhAhBMO9UYzD/HR/r0Ue1apBsoo/ioEpVas4nnbkq2SMe+hEq01Y3UoPCPT562EZqU5azBwo9Uw7mA+urHfeY+3BOhauETy1DNGagxYTaAWrAFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857042; c=relaxed/simple;
	bh=PiqY889LgWIFkgy64QEXf0fNl10xIm5k8j8z4gckHog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSZsND132PrfHodL9y/ta1vYs/ABsD4YDAB0zMPoU1FAEMsmBfPpTqmyJbIeEWLgczRcWme+1ztcpRILO5O5N/E/c0KMb2p05x3l/2uHpkuRv9b9L2Pa+XJuDbroxeFkGymi5OpEGn8J2Jr4FBsK1f/EuauB12KFtzyXCkQ3MJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPK+V+ee; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPK+V+ee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774857040; x=1806393040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PiqY889LgWIFkgy64QEXf0fNl10xIm5k8j8z4gckHog=;
  b=KPK+V+ee4XD39KoTlzjnkP8DYv7aTkcJzIsEq1GfpvoMNQJdclOLx8Xx
   GMaF9IdTHqGcCJcD/Uku6ZCG5CUbq1skFor/wC+q6Mxr4339TboXPhNPf
   y3X1Z39oh62wk3UKy9wz3429KEyyzm+nMy+MqF8JRmBH7URqKQcS3NGZy
   IzYTBR/BRV/C7mbdKKWf49GPwcVbUhp4cEecz6hwlnmZS9z2XYgvVbxAf
   SQYYWLy+TJNZG5leui0co9K6uh5FJgnJwbNsVKjb2vpS7LwGdnJXlPUgR
   CTudDE8JJjLIc/f4QStsK49j8zR05MRyU+anAp8a1GnB+z0e4kAWef5FV
   w==;
X-CSE-ConnectionGUID: r0+1M4wARfCEXk01WAplVw==
X-CSE-MsgGUID: SdaLfyDbRT2YqQBOBiygdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86535292"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="86535292"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:50:40 -0700
X-CSE-ConnectionGUID: bKF/FAIKQWWW1FZgYCMAFQ==
X-CSE-MsgGUID: siJjBhNRTiWlFjG6FstUpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="263912729"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Mar 2026 00:50:36 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w77OK-000000000pd-3V3D;
	Mon, 30 Mar 2026 07:50:32 +0000
Date: Mon, 30 Mar 2026 15:49:48 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v7 1/9] KVM: x86: Define
 KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
Message-ID: <202603301501.N2sdlIQ9-lkp@intel.com>
References: <20260327234023.2659476-2-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327234023.2659476-2-jmattson@google.com>

Hi Jim,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3d6cdcc8883b5726513d245eef0e91cabfc397f7]

url:    https://github.com/intel-lab-lkp/linux/commits/Jim-Mattson/KVM-x86-Define-KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT/20260328-110805
base:   3d6cdcc8883b5726513d245eef0e91cabfc397f7
patch link:    https://lore.kernel.org/r/20260327234023.2659476-2-jmattson%40google.com
patch subject: [PATCH v7 1/9] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
config: x86_64-randconfig-016-20260330 (https://download.01.org/0day-ci/archive/20260330/202603301501.N2sdlIQ9-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260330/202603301501.N2sdlIQ9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603301501.N2sdlIQ9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kvm/svm/svm_onhyperv.c:11:
   arch/x86/kvm/svm/svm.h: In function 'l2_has_separate_pat':
>> arch/x86/kvm/svm/svm.h:626:18: error: implicit declaration of function 'kvm_check_has_quirk'; did you mean 'kvm_check_request'? [-Wimplicit-function-declaration]
     626 |                 !kvm_check_has_quirk(svm->vcpu.kvm,
         |                  ^~~~~~~~~~~~~~~~~~~
         |                  kvm_check_request
   In file included from arch/x86/kvm/svm/svm_ops.h:7,
                    from arch/x86/kvm/svm/svm_onhyperv.c:12:
   arch/x86/kvm/x86.h: At top level:
>> arch/x86/kvm/x86.h:429:20: error: conflicting types for 'kvm_check_has_quirk'; have 'bool(struct kvm *, u64)' {aka '_Bool(struct kvm *, long long unsigned int)'}
     429 | static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
         |                    ^~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/svm/svm.h:626:18: note: previous implicit declaration of 'kvm_check_has_quirk' with type 'int()'
     626 |                 !kvm_check_has_quirk(svm->vcpu.kvm,
         |                  ^~~~~~~~~~~~~~~~~~~
--
   In file included from kvm/svm/svm_onhyperv.c:11:
   kvm/svm/svm.h: In function 'l2_has_separate_pat':
   kvm/svm/svm.h:626:18: error: implicit declaration of function 'kvm_check_has_quirk'; did you mean 'kvm_check_request'? [-Wimplicit-function-declaration]
     626 |                 !kvm_check_has_quirk(svm->vcpu.kvm,
         |                  ^~~~~~~~~~~~~~~~~~~
         |                  kvm_check_request
   In file included from kvm/svm/svm_ops.h:7,
                    from kvm/svm/svm_onhyperv.c:12:
   arch/x86/kvm/x86.h: At top level:
>> arch/x86/kvm/x86.h:429:20: error: conflicting types for 'kvm_check_has_quirk'; have 'bool(struct kvm *, u64)' {aka '_Bool(struct kvm *, long long unsigned int)'}
     429 | static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
         |                    ^~~~~~~~~~~~~~~~~~~
   kvm/svm/svm.h:626:18: note: previous implicit declaration of 'kvm_check_has_quirk' with type 'int()'
     626 |                 !kvm_check_has_quirk(svm->vcpu.kvm,
         |                  ^~~~~~~~~~~~~~~~~~~


vim +626 arch/x86/kvm/svm/svm.h

   618	
   619	static inline bool l2_has_separate_pat(struct vcpu_svm *svm)
   620	{
   621		/*
   622		 * If KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled while a vCPU
   623		 * is running, the L2 IA32_PAT semantics for that vCPU are undefined.
   624		 */
   625		return nested_npt_enabled(svm) &&
 > 626			!kvm_check_has_quirk(svm->vcpu.kvm,
   627					     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
   628	}
   629	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
