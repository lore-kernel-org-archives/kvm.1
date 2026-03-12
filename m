Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757A285CB3;
	Thu, 12 Mar 2026 03:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773286953; cv=none; b=tiQcQPx1MJSDuiQWrYqMTarZnTm9YE1ZLJAG+Vm2ppvZXKNFNFa+OpWuUgnNRx9znm18M5mnj21gGusld2oQmqWYTN9KO6JrRNC3uDZ8ppv4K6yR4p3uAjFKY7NN5ki+YAjYprxYs3bS0nXIXShZ4LAJpaRaEqdYAHz5EeBTVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773286953; c=relaxed/simple;
	bh=k66SwT2CrRXnmYea4HwxTf4zjYXWkJzLCeBRb9Ce94o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGCr/3RXsKzKE/NfN0+ZaRBrEOOx6/E5wO33nIwJ6jHuzxIyrmgE14+Xblul8yz1hOxZFwbVHWp9Ftg4ZJvd3ldKQoC/i/fLf29Ig56kKtpaoetQ8JAr0jPr1maCuaUgon/T9UA8SlKQDQWnvO12HABvI1rLKaWJtI8IZSzNJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKBB9Eu8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKBB9Eu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773286950; x=1804822950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k66SwT2CrRXnmYea4HwxTf4zjYXWkJzLCeBRb9Ce94o=;
  b=IKBB9Eu82LDu6GhPoJ90irLipRyds+IPDfgTm8Cv2QrNwwqkvEn387RS
   V2GXTyozoQf6HCMzcSbuOwiOt+7qYk9hv27VfqCCrvgVGjpild0A3oMrQ
   Ras569sAYOUygoks5TUOEyLh5J4k4EgycpmqjiLcAh6YiYl7gPtIa8Mvh
   kWNwcPQqpvF2gRPvi66h48jtLqEahVJU3A046NllZ5VDoNUcu9veLLnc2
   2OMzMCC2IypCgVpUBQQiQPyRkq7yHDSd8A9335YMpcvdtPO+13biaVSzu
   YSZMHRkPZNumbGEVKGfosg3nq6TC55QME0U8UngQ6zS7XWogLcntmsMQo
   Q==;
X-CSE-ConnectionGUID: +vXZaaPKSVuIQXYEiu77Ew==
X-CSE-MsgGUID: zhMm5wESS5OHdDKEHYR8NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="73386656"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="73386656"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 20:42:30 -0700
X-CSE-ConnectionGUID: pg2FiJu1QE6WIsmaAzNCaQ==
X-CSE-MsgGUID: MKFyLNCXToKe6fDbqnVz3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="217277110"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Mar 2026 20:42:27 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0WwJ-0000000021n-43fx;
	Thu, 12 Mar 2026 03:42:23 +0000
Date: Thu, 12 Mar 2026 11:41:27 +0800
From: kernel test robot <lkp@intel.com>
To: Kim Phillips <kim.phillips@amd.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Borislav Petkov <borislav.petkov@amd.com>,
	Naveen Rao <naveen.rao@amd.com>,
	David Kaplan <david.kaplan@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Kim Phillips <kim.phillips@amd.com>, stable@kernel.org
Subject: Re: [PATCH v2 1/3] cpu/bugs: Allow forcing Automatic IBRS with SNP
 enabled using spectre_v2=eibrs
Message-ID: <202603121136.bc8zNsHS-lkp@intel.com>
References: <20260311130611.2201214-2-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311130611.2201214-2-kim.phillips@amd.com>

Hi Kim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7726ce2287804e70b2bf2fc00f104530b603d3f3]

url:    https://github.com/intel-lab-lkp/linux/commits/Kim-Phillips/cpu-bugs-Allow-forcing-Automatic-IBRS-with-SNP-enabled-using-spectre_v2-eibrs/20260311-211730
base:   7726ce2287804e70b2bf2fc00f104530b603d3f3
patch link:    https://lore.kernel.org/r/20260311130611.2201214-2-kim.phillips%40amd.com
patch subject: [PATCH v2 1/3] cpu/bugs: Allow forcing Automatic IBRS with SNP enabled using spectre_v2=eibrs
config: x86_64-randconfig-101-20260312 (https://download.01.org/0day-ci/archive/20260312/202603121136.bc8zNsHS-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603121136.bc8zNsHS-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/bugs.c:2190:42-44: WARNING !A || A && B is equivalent to !A || B

vim +2190 arch/x86/kernel/cpu/bugs.c

  2122	
  2123	static void __init spectre_v2_select_mitigation(void)
  2124	{
  2125		if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE ||
  2126		     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
  2127		     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
  2128		     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
  2129		     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
  2130		    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
  2131			pr_err("RETPOLINE selected but not compiled in. Switching to AUTO select\n");
  2132			spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
  2133		}
  2134	
  2135		if ((spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS ||
  2136		     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
  2137		     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
  2138		    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
  2139			pr_err("EIBRS selected but CPU doesn't have Enhanced or Automatic IBRS. Switching to AUTO select\n");
  2140			spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
  2141		}
  2142	
  2143		if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
  2144		     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE) &&
  2145		    !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
  2146			pr_err("LFENCE selected, but CPU doesn't have a serializing LFENCE. Switching to AUTO select\n");
  2147			spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
  2148		}
  2149	
  2150		if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY)) {
  2151			pr_err("IBRS selected but not compiled in. Switching to AUTO select\n");
  2152			spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
  2153		}
  2154	
  2155		if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
  2156			pr_err("IBRS selected but not Intel CPU. Switching to AUTO select\n");
  2157			spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
  2158		}
  2159	
  2160		if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
  2161			pr_err("IBRS selected but CPU doesn't have IBRS. Switching to AUTO select\n");
  2162			spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
  2163		}
  2164	
  2165		if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV)) {
  2166			pr_err("IBRS selected but running as XenPV guest. Switching to AUTO select\n");
  2167			spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
  2168		}
  2169	
  2170		if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2)) {
  2171			spectre_v2_cmd = SPECTRE_V2_CMD_NONE;
  2172			return;
  2173		}
  2174	
  2175		switch (spectre_v2_cmd) {
  2176		case SPECTRE_V2_CMD_NONE:
  2177			return;
  2178	
  2179		case SPECTRE_V2_CMD_AUTO:
  2180			if (!should_mitigate_vuln(X86_BUG_SPECTRE_V2))
  2181				break;
  2182			fallthrough;
  2183		case SPECTRE_V2_CMD_FORCE:
  2184			/*
  2185			 * Unless forced, don't use AutoIBRS when SNP is enabled
  2186			 * because it degrades host userspace indirect branch performance.
  2187			 */
  2188			if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) &&
  2189			    (!boot_cpu_has(X86_FEATURE_SEV_SNP) ||
> 2190			     (boot_cpu_has(X86_FEATURE_SEV_SNP) &&
  2191			      spectre_v2_cmd == SPECTRE_V2_CMD_FORCE))) {
  2192				spectre_v2_enabled = SPECTRE_V2_EIBRS;
  2193				break;
  2194			}
  2195	
  2196			spectre_v2_enabled = spectre_v2_select_retpoline();
  2197			break;
  2198	
  2199		case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
  2200			pr_err(SPECTRE_V2_LFENCE_MSG);
  2201			spectre_v2_enabled = SPECTRE_V2_LFENCE;
  2202			break;
  2203	
  2204		case SPECTRE_V2_CMD_RETPOLINE_GENERIC:
  2205			spectre_v2_enabled = SPECTRE_V2_RETPOLINE;
  2206			break;
  2207	
  2208		case SPECTRE_V2_CMD_RETPOLINE:
  2209			spectre_v2_enabled = spectre_v2_select_retpoline();
  2210			break;
  2211	
  2212		case SPECTRE_V2_CMD_IBRS:
  2213			spectre_v2_enabled = SPECTRE_V2_IBRS;
  2214			break;
  2215	
  2216		case SPECTRE_V2_CMD_EIBRS:
  2217			spectre_v2_enabled = SPECTRE_V2_EIBRS;
  2218			break;
  2219	
  2220		case SPECTRE_V2_CMD_EIBRS_LFENCE:
  2221			spectre_v2_enabled = SPECTRE_V2_EIBRS_LFENCE;
  2222			break;
  2223	
  2224		case SPECTRE_V2_CMD_EIBRS_RETPOLINE:
  2225			spectre_v2_enabled = SPECTRE_V2_EIBRS_RETPOLINE;
  2226			break;
  2227		}
  2228	}
  2229	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
