Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486B32ED27;
	Tue, 28 Apr 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394968; cv=none; b=P5EJdJwM4q7d0PdESYK+JGBZrDz/lgn7O3XjY5ftnCLY159+hV65m800IYluoZpfTi5Prylh7i6TDCTuDX0rjhImpD3FccgE4WqKi/m836dJjndlBR30ePNcyyDvwnZwsq6r0QYpM7rFnUAJwOBYl+pFJrkMTsO2mqZOBuai8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394968; c=relaxed/simple;
	bh=vt987uQbRVex++Kh8Yu7uxsLcxvnod6yMw5w4mWMTvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1gjcO555Jr7tQ5ivnc+vJ+rqtHrnUdaWLkkvR1CIXO6wXl2i2q9MSL75O56l5Xb64A98WCFkr2wjN1cvJ42M1Ssy9pObHd0tvUXMXJfKuiWOzzOX5HJto2UGbK7b8t+xLT3A1AOnvajCEOIELQYMccywWM/VrY95UA01lCSzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZTEIcrl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZTEIcrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777394967; x=1808930967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vt987uQbRVex++Kh8Yu7uxsLcxvnod6yMw5w4mWMTvk=;
  b=jZTEIcrlKMrIp1msvhui+g/I458uFZ91qFm+P98uA3VU9Ff/Ch20bmrJ
   YbVkVTTF/orbv58n4YyObcAbRDerzhOaM89Yj3Mix2VB8LWYO6+NlVi/X
   Rt3nnO/Z0CHrIgjf1RAGAPwVessALtGrF+ljYVwisvZQTs3qxpC15ANjl
   Z7vPUNcHbGbv7wrTGqEK3slTv4dPBO3BTFWH48PU+0y98zkR2qdGrThOG
   fcdOvm3nu9aT+VWpfq5JpNF2HoUcCo7Bx/G/nj69Ije0c8b5tBoUjZooy
   d2nWPv3GXKhr+TLrsWEnxOZ+DAvX7Dg30DiFukisu8E4tMIctzEA6sAKe
   w==;
X-CSE-ConnectionGUID: 9jdSVW2yRa+WoG1iSjMZ/w==
X-CSE-MsgGUID: ZdqTFRHbRVy4wB0BasvKbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="82177526"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="82177526"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 09:49:26 -0700
X-CSE-ConnectionGUID: ErT5uC0OSuWdS/OVF6EVLw==
X-CSE-MsgGUID: UWv/3S0ZTFuSOD7uwwuD3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233969407"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 09:49:26 -0700
Date: Tue, 28 Apr 2026 09:49:09 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>,
	David Kaplan <david.kaplan@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, stable@kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/6] cpu/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
Message-ID: <20260428164909.xkxdqhdsguq2wpal@desk>
References: <20260402202558.195005-1-kim.phillips@amd.com>
 <20260402202558.195005-2-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402202558.195005-2-kim.phillips@amd.com>

On Thu, Apr 02, 2026 at 03:25:53PM -0500, Kim Phillips wrote:
> spectre_v2=eibrs currently enables retpolines when SNP is enabled,
> instead of AutoIBRS (EIBRS) because the commit that disabled
> AutoIBRS if SNP is enabled stopped short of enabling
> X86_FEATURE_IBRS_ENHANCED.
> 
> Change the logic to enable X86_FEATURE_IBRS_ENHANCED, and move the
> decision to switch to retpolines in the default/"auto" case in

The retpoline switch happens in force case(=on) too.

> spectre_v2_select_mitigation().  This allows the existing
> spectre_v2=eibrs logic to work as intended.
> 
> Also emit a performance loss warning for using AutoIBRS with
> SNP enabled.
> 
> Fixes: acaa4b5c4c85 ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: stable@kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603121136.bc8zNsHS-lkp@intel.com/
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
