Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3875D23504B;
	Sun, 29 Mar 2026 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774773080; cv=none; b=s7Se8s6Gicf92t0WaIGskKO3fM/ZOrfcaQ8+9vJbdSR52ljXw9/LNwnw+3REjvDlsbh8Leeo17qBkinxQkuJdVIyJ25bLPvhvtVAAFNkTlLgnqLYL+cNUrjeIBbn465vq0S+gV+MWNL2W+2cycaidj8370M+JhYowU6b0oXYRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774773080; c=relaxed/simple;
	bh=Au+Q3of3G+nBR4O2vf6lL47OuLlK2dXAtQfUacqWsTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gf1fn26RhHU5NY7X+po5hMI8ECSJoCCDP/E+dXB1+h5X00wcO9h1VaZTjwmTbKD0M1PcTRMnXBegVAZX+jUe0vTPR05DCBeV8PHjGLGnBEHdWhLw83P477W6hAWun8vu7XYbukQikRr6uXNIjfMaUtjPYpqZ5UqMOs7p+1TWK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPlnQIm0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPlnQIm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774773078; x=1806309078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Au+Q3of3G+nBR4O2vf6lL47OuLlK2dXAtQfUacqWsTU=;
  b=EPlnQIm0X5zAgMVvFnjhIACD24EyWOcEWprPjrV+xBIOPUKxDS/gxZBx
   lOScIuX8vocWyBtjg5kgvjczz/NljerAO+frpmc1N9XyNsI7UOSYSRJlJ
   TDzbO2XD4aKKxmDa6XwZtg5t4AVkbF88GYT49WlisQYKzhlMxBxC5BvrU
   LNuRfRZymBKkDCXagLCpaw4VoXMNEBYEeQDWsWahy583nFnx90zOWHOIz
   ts0tY3HwaLv22EIx170iqrcJoPyRKTnRqOlz1EYYfEM576eOl2HBKkrdH
   Pn5DGBUipzPuBeviQT/nVdXk6LCAXcvddadYfVQ92+w/8fiYJL5W76NGf
   Q==;
X-CSE-ConnectionGUID: CTcDaeYmQ4iXAkYTYhcg6w==
X-CSE-MsgGUID: vEHhQo6xR0qnfihxqZRNAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75853950"
X-IronPort-AV: E=Sophos;i="6.23,147,1770624000"; 
   d="scan'208";a="75853950"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 01:31:17 -0700
X-CSE-ConnectionGUID: K/+ZsszvRKerW6VeGwKGoQ==
X-CSE-MsgGUID: NBbbEPjeTK2XIdIyT0uUew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,147,1770624000"; 
   d="scan'208";a="230542677"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2026 01:31:14 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6lY8-000000007sL-30xG;
	Sun, 29 Mar 2026 08:31:12 +0000
Date: Sun, 29 Mar 2026 10:30:33 +0200
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
Message-ID: <202603291021.Yc83e9lC-lkp@intel.com>
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
[also build test WARNING on kvm/next linus/master v6.16-rc1 next-20260327]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/18341265598-163-com/vmx-nested-Set-the-SGX-feature-flag-only-when-hardware-supported/20260329-093645
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/1774322860-25106-1-git-send-email-18341265598%40163.com
patch subject: [PATCH] vmx/nested: Set the SGX feature flag only when hardware supported.
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260329/202603291021.Yc83e9lC-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603291021.Yc83e9lC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603291021.Yc83e9lC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kvm/kvm-asm-offsets.c:10:
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
