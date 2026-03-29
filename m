Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38E40DFD3;
	Sun, 29 Mar 2026 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774775143; cv=none; b=QVhIYn0UpQz+kV0xhlYBU/AM5OwrtcRwZIU1gbuQRA5tgA2Ozr1ajHmf8BoyIyQz2ItPj0SUcqsxmPpwqm8giBhhwDbvt4r8Yvg19z5auMz5Iu3s2SYbovIJRuKaujS06egf4faYsopX2kbI7Z64wNeVjLrmNwNV6divo3Spl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774775143; c=relaxed/simple;
	bh=iapjEO86JzKTxUIvXkgpCLkatktiMO0V/CCUkfzQZfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icWiW5n6pucULLvvNws8DmlNcpkHVqwdXnEuJT64VgDKMNcxdZpI+8oLUEr45XCSm38japAHv8lqCk3JFXTZZP9zw06CZRBToV15lZwuby1AT3lqvo26SGIan0YNaHfzu6nbp0Rt+IiZ7OY2Gg9PGyQdWVeTAeN//2LII/sDyhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXklKd9r; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXklKd9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774775140; x=1806311140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iapjEO86JzKTxUIvXkgpCLkatktiMO0V/CCUkfzQZfU=;
  b=OXklKd9r7kSYdnSIvFMVMChSE+4L8qqjAwf7W8SgKrOfgfwaBsHSbIbv
   dEfu4vI7Hdf8r9nRrhCJ+eeEsli/Lx4mhn4FBID3pE/6NKl5QN1JVmV6s
   io1j4HOl6b2AXCpO1UOngGbPPpr3SMYUX1dOJVpk43hzLWjp6SNRIuSiF
   WRxi5ljTXjp+1zj24rp4Z42MxUS3/n9HKjgfjt5hg8I1tfdT2oQ52jOjQ
   qkoZPi7Jov3wmbhaKmvUZ4jwCH7g0XW0dv4mNzczMIeFGAtpwDawTwR/d
   NFJSsSm5Kz4VKMfdseZv3DFNXS3iBxTtmmaTPcQlWOqldVPGJnRnSopA3
   g==;
X-CSE-ConnectionGUID: KcW/iaLLROik1WkPXEdmVg==
X-CSE-MsgGUID: aGJiiInPSlCgyiJ5oBQ+9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="74973731"
X-IronPort-AV: E=Sophos;i="6.23,147,1770624000"; 
   d="scan'208";a="74973731"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 02:05:40 -0700
X-CSE-ConnectionGUID: /eyWRXiASgKqq6hs6IYY0g==
X-CSE-MsgGUID: /nXIVnBhR82YWZa37+Ms0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,147,1770624000"; 
   d="scan'208";a="227365894"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 29 Mar 2026 02:05:36 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6m5N-00000000CE9-3M9u;
	Sun, 29 Mar 2026 09:05:33 +0000
Date: Sun, 29 Mar 2026 17:05:06 +0800
From: kernel test robot <lkp@intel.com>
To: 18341265598@163.com, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wei xiaoqiong <weixq1@chinatelecom.cn>,
	Huaitong Han <hanht2@chinatelecom.cn>,
	"zhaoge.zhang" <zhangzg12@chinatelecom.cn>
Subject: Re: [PATCH] vmx/nested: Set the SGX feature flag only when hardware
 supported.
Message-ID: <202603291639.FHVs3bEt-lkp@intel.com>
References: <1774322860-25106-1-git-send-email-18341265598@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1774322860-25106-1-git-send-email-18341265598@163.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[also build test WARNING on kvm/next linus/master v7.0-rc5 next-20260327]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/18341265598-163-com/vmx-nested-Set-the-SGX-feature-flag-only-when-hardware-supported/20260329-093645
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/1774322860-25106-1-git-send-email-18341265598%40163.com
patch subject: [PATCH] vmx/nested: Set the SGX feature flag only when hardware supported.
config: i386-randconfig-012-20260329 (https://download.01.org/0day-ci/archive/20260329/202603291639.FHVs3bEt-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603291639.FHVs3bEt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603291639.FHVs3bEt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kvm/vmx/hyperv.h:7,
                    from arch/x86/kvm/vmx/nested.h:6,
                    from arch/x86/kvm/vmx/pmu_intel.c:21:
>> arch/x86/kvm/vmx/vmx.h:347:13: warning: 'cpu_has_sgx' defined but not used [-Wunused-function]
     347 | static bool cpu_has_sgx(void)
         |             ^~~~~~~~~~~


vim +/cpu_has_sgx +347 arch/x86/kvm/vmx/vmx.h

   340	
   341	/*
   342	 * There is no X86_FEATURE for SGX yet, but anyway we need to query CPUID
   343	 * directly instead of going through cpu_has(), to ensure KVM is trapping
   344	 * ENCLS whenever it's supported in hardware.  It does not matter whether
   345	 * the host OS supports or has enabled SGX.
   346	 */
 > 347	static bool cpu_has_sgx(void)
   348	{
   349		return cpuid_eax(0) >= 0x12 && (cpuid_eax(0x12) & BIT(0));
   350	}
   351	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
