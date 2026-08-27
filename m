Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C127AC57;
	Thu, 27 Aug 2026 04:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805160; cv=none; b=OSnHPi+OJuPeY5OYcCFfaLevB4kE9plxEHPKMWMVNkclR4Q2L32WkcqsxgxFYZdEOnUbya5aIvGB1KWAJUMUsBoSJIF3WhfkkJiHDy5aHGHBUdBRTsip5VcZfs/VhedxGQNaMOATWNnqKJj38LGz9RJsRjGxnluojZ8Pm5dSPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805160; c=relaxed/simple;
	bh=5hfhg9q3wLr3F++5GOEFn8FlmrSeQCrLD/p9jYvA+Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTonJJS8RCwJmYpFKaPyR1d2EwuLYS+rCd0RGixvZR5zXNg3xTUMxf5IXJFfp3YgTFIv1om5tTDuXhf/tH27h2ntDIPVBvkNPQILzkhwOICry7N2RCs0At255vRwH5CR5/3WrmtCNR665xP9oO5epGY+lzIkzECjt2EkuHocq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyYtU2LR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyYtU2LR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787805159; x=1819341159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5hfhg9q3wLr3F++5GOEFn8FlmrSeQCrLD/p9jYvA+Tc=;
  b=ZyYtU2LRbs5dOuHeNCKLsjJxxvruT/eisWhigWuboKnhFvWtrcSm+6fW
   VvqVwGpj1JRtiYQAWeNxOnLL42gEoPAVftJlDOVKToqIci9Ct1GFA+d2z
   GR94aL2QOs+6I3BA/0J1WlDslzukEJgNrasvTIQF0dXJvoXerwCuV67ld
   dFrgFukBSV8TB9mgYeN0iBfPGujV6zribkMeMoVETPe+AGSBK8f+pbiSf
   6F3YnGf/eR4bFZM/35zB9pn5WtuEyDuSvI1I/YyVUB7oQOOVn3MEn9F0Q
   UUUBxjz/yoq2k4owfGYvanQhGzD34eq3c9rMqlazLoVqCWqrOt3aoM+/L
   A==;
X-CSE-ConnectionGUID: NaFgEe5YTNOb77FkvpnOBA==
X-CSE-MsgGUID: mk8ZE7dPTBO8QinP1XbNZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88352856"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88352856"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 21:32:38 -0700
X-CSE-ConnectionGUID: bAH64PyqQvmVyGp2r/Suug==
X-CSE-MsgGUID: ln06QeogQleILQL+aJHCeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="271559179"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 21:32:38 -0700
Date: Wed, 26 Aug 2026 21:32:24 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, 
	David Kaplan <david.kaplan@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Nathan Fontenot <nathan.fontenot@amd.com>
Subject: Re: [PATCH v5 1/8] x86/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
Message-ID: <ffboocv2eruaxnu6nuhpawyqycab2lhxhrl32e5toco6gdql3i@5y5o7ng6t7ow>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-2-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826223510.3669875-2-kim.phillips@amd.com>

On Wed, Aug 26, 2026 at 05:35:03PM -0500, Kim Phillips wrote:
> spectre_v2=eibrs currently enables retpolines when SNP is enabled,
> instead of AutoIBRS (EIBRS) because the commit that disabled
> AutoIBRS if SNP is enabled stopped short of enabling
> X86_FEATURE_IBRS_ENHANCED.
> 
> Change the logic to enable X86_FEATURE_IBRS_ENHANCED, and move the
> decision to switch to retpolines in the default/"auto" case in
> spectre_v2_select_mitigation().  This allows the existing
> spectre_v2=eibrs logic to work as intended.
> 
> Condition that switch on CONFIG_MITIGATION_RETPOLINE being built in.
> Otherwise spectre_v2_select_retpoline() returns SPECTRE_V2_NONE and an
> SNP host with AutoIBRS available would be left completely unmitigated
> against Spectre v2 in the default/auto case, which is worse than the
> userspace indirect branch performance loss AutoIBRS costs.
> 
> Also emit a performance loss warning for using AutoIBRS with SNP
> enabled.  AutoIBRS is activated for all three eIBRS modes via
> spectre_v2_in_eibrs_mode(), so use that helper to cover
> spectre_v2=eibrs, spectre_v2=eibrs,lfence, and
> spectre_v2=eibrs,retpoline uniformly.  Word the warning in terms of the
> eIBRS mitigation enabling AutoIBRS, rather than naming AutoIBRS as the
> selected mitigation, so it reads correctly for the ,lfence and
> ,retpoline variants where another component is also active.
> 
> Fixes: acaa4b5c4c85 ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
