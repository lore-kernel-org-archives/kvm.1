Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1384A3C;
	Fri, 13 Mar 2026 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432250; cv=none; b=gyf87KWmFQmotkAJrNQTuCx5ydehBrZaJga+QHavR5cU/lVuahB2FcvMnP16yrxvOy9Feu6U8H24m1rUzv+cWnwSBPy4m05LqJDtl4FOXO8Z3zpgOydAO0AqokJIi2R7lO6yIbdiwOeWKarAISW9JEwn+nEnRGCjhG4q48XeYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432250; c=relaxed/simple;
	bh=EnW5ZtRmX/4qsUpioqYFSwv9MQLoHHPj8GoMuaMXPTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZBNWcW7dxwYgZTo2BXBBbnvDaCHyszDuD3rICqui7Zf5qAQKT/pZmFrEJHFLDZF+NSj69bL4QNgELFIZWM1cOXr00yHTmNiM5iOx2krJg++48BdfwDICsLYp8iBO72LRZNwS5lX8UjG3c64t00Yl1/f5+KcT1AjqEYtLGmKie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBTPRvwu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBTPRvwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773432249; x=1804968249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EnW5ZtRmX/4qsUpioqYFSwv9MQLoHHPj8GoMuaMXPTo=;
  b=NBTPRvwutTehbYy0EFGtxSTyxSlCamKwyse5E7D7DarakCfV7LBISo4v
   YX6u6UhFBjn/Jp0QjRPCh7Q+fzdO5L+oL9xmBjCyDswpl1HGWR7mE4gWW
   GWeuLDsoAUtbBNBhwDQnm04poU+IXDOx0xF5g1+agX+qF063Ji7kMs9f7
   2OnGZZgL2ssuGg6HmxaLS+HuErRLUkNlYJQCsxWYB7yUY4C1OAhwJrJGE
   CStOt9j1iTgMNjVItxpCSFl5bVY5Fuun2OaXDok3+8JqQkacjOmxS0QKE
   kaqnNvD31d/sgmockSSin8gLukOYMrj+ol4sk2Cd/wG9h0KKi+OspdYhN
   A==;
X-CSE-ConnectionGUID: q0gzXPQVQQSHtZfb88gO7A==
X-CSE-MsgGUID: b6nxPe28QRqKPF4dMYhyLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74247600"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74247600"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 13:04:09 -0700
X-CSE-ConnectionGUID: qulaRlwQTPm7Yl5+WwQ5kQ==
X-CSE-MsgGUID: 4Oy/wIucRf+Ih28iOBrtRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="226258497"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 13:04:09 -0700
Date: Fri, 13 Mar 2026 13:04:02 -0700
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
	David Kaplan <david.kaplan@amd.com>, stable@kernel.org
Subject: Re: [PATCH v2 1/3] cpu/bugs: Allow forcing Automatic IBRS with SNP
 enabled using spectre_v2=eibrs
Message-ID: <20260313200402.gyrk5elsbtggqh4g@desk>
References: <20260311130611.2201214-1-kim.phillips@amd.com>
 <20260311130611.2201214-2-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311130611.2201214-2-kim.phillips@amd.com>

On Wed, Mar 11, 2026 at 08:06:09AM -0500, Kim Phillips wrote:
> To allow this, do the SNP check in spectre_v2_select_mitigation()
> processing instead of the original commit's implementation in
> cpu_set_bug_bits().
> 
> Since SPECTRE_V2_CMD_AUTO logic falls through to SPECTRE_V2_CMD_FORCE,
> double-check if SPECTRE_V2_CMD_FORCE is used before allowing
> SPECTRE_V2_EIBRS with SNP enabled.
> 
> Also mute SPECTRE_V2_IBRS_PERF_MSG if SNP is enabled on an AutoIBRS
> capable machine, since, in that case, the message doesn't apply.
> 
> Fixes: acaa4b5c4c85 ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: stable@kernel.org
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
> v2:
>  - Address Dave Hansen's comment to adhere to using the IBRS_ENHANCED
>    Intel feature flag also for AutoIBRS.
> 
> v1:
>  https://lore.kernel.org/kvm/20260224180157.725159-2-kim.phillips@amd.com/
> 
>  arch/x86/kernel/cpu/bugs.c   | 12 ++++++++++--
>  arch/x86/kernel/cpu/common.c |  6 +-----
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 83f51cab0b1e..957e0df38d90 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2181,7 +2181,14 @@ static void __init spectre_v2_select_mitigation(void)
>  			break;
>  		fallthrough;
>  	case SPECTRE_V2_CMD_FORCE:
> -		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
> +		/*
> +		 * Unless forced, don't use AutoIBRS when SNP is enabled
> +		 * because it degrades host userspace indirect branch performance.
> +		 */
> +		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) &&
> +		    (!boot_cpu_has(X86_FEATURE_SEV_SNP) ||
> +		     (boot_cpu_has(X86_FEATURE_SEV_SNP) &&
> +		      spectre_v2_cmd == SPECTRE_V2_CMD_FORCE))) {

This is forcing AutoIBRS when spectre_v2=on (meaning force), but the
subject says to allow forcing with spectre_v2=eibrs, which one is it?
