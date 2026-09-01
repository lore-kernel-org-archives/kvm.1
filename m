Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12EC377EB2;
	Tue,  1 Sep 2026 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244199; cv=none; b=mYCe8hHIp4KJ/yGYmcN3Zjqedn3R/Rngvq1PWxZTCtmu1YaOJvkeFP8KTDFJttXf72zFpD42/pgANRktKa/wBy3Xc9AtApsGKm0jlwYq/iFdyL7eXcpes9qDxcaeF/WSNIOk4+H5hktTg/9lq3UZ8A7NpOBRRxB3bpbo53Z5R7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244199; c=relaxed/simple;
	bh=I85zzhv8ES8KmFM9m5iBsjP7IQ6Oqm69Rq/End2sPks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5IKAemDyBjcR0lrepwEtb8nlCcreNMOjAviNzxLRo9u39+DkRhZ6T/x1kTwOep676tON6mKq6Z3jHLs8dJ0Kv5ejhj8ImUn4Mzl93TvfjJp0/VOtiCZZeDTfzPHeTL5HjJCeOXqAqZWLq4oWnoMvZw7ihPh6NhWZrAVSxtPy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHV7Wt8L; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHV7Wt8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788244197; x=1819780197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I85zzhv8ES8KmFM9m5iBsjP7IQ6Oqm69Rq/End2sPks=;
  b=fHV7Wt8LnTkV0Egn4xNm9c/72q4qZk8RdH8eoCZRZaETxDjllYTTq8u9
   tZO7vTPnMzdMc8ZBccgQhmcuXWs3/z/yVAYTrNeSUwdbh2pzK8ryR/uWu
   e4aLLTJUoV+N3ECzTZaziBX15F9RQhge7Ti8uDVjpLy51fPG5BsdYxvrS
   fVwfPQO1nlvRxx1s8o0MfB06dezB9tBEXg2Maa+90EyJ4E/vTPmzo1yY3
   fPbrSynb8kg6UwiO4Xx44LXM19ge7p3r79lTUCyqfqRHNejCDfY1/GTWp
   4FNpMZnpm8V8dwMG/8tMR4gqqCQcJqmQQT/uqBMdjmvrJH/iwTKlb5Rbk
   w==;
X-CSE-ConnectionGUID: GG+RbqKfQiaGnDVN48wXTg==
X-CSE-MsgGUID: Vmwn6BBXTvOHa8UuuO8BeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99261191"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99261191"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:29:56 -0700
X-CSE-ConnectionGUID: PS8fOcA0RTWSvHPvyL2RPQ==
X-CSE-MsgGUID: WSGY10jrTla2gg5y0cCAAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="274265661"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.192])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:29:52 -0700
Date: Tue, 1 Sep 2026 09:29:48 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
	pbonzini@redhat.com, dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Message-ID: <apZw3G2volNpLiBD@tlindgre-MOBL1>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827031837.2863609-2-binbin.wu@linux.intel.com>

On Thu, Aug 27, 2026 at 11:18:34AM +0800, Binbin Wu wrote:
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -52,6 +52,149 @@
>  	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
>  		     a1, a2, a3)
>  
> +static u32 tdx_cpu_cfg_caps[NR_KVM_CPU_CAPS] __ro_after_init;
> +static_assert(ARRAY_SIZE(tdx_cpu_cfg_caps) == ARRAY_SIZE(kvm_cpu_caps));
> +
> +#define TDX_VALIDATE_CPU_CAP_USAGE(name)			\
> +	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) !=	\
> +		     tdx_cpu_cap_init_in_progress)
> +
> +/* For feature bit that KVM advertised through kvm_cpu_caps[]. */
> +#define TDX_CFG_F(name)					\
> +({							\
> +	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
> +	tdx_cfg_caps |= feature_bit(name);		\
> +})
> +
> +/*
> + * For feature bit KVM allows for TDX guests even though it is not advertised
> + * through kvm_cpu_caps[], e.g. MWAIT.
> + */
> +#define TDX_CFG_EXTRA_F(name)				\
> +({							\
> +	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
> +	tdx_cfg_extra_caps |= feature_bit(name);	\
> +})
> +
> +#define tdx_cpu_cfg_cap_init(leaf, feature_initializers...)		\
> +do {									\
> +	const u32 __maybe_unused tdx_cpu_cap_init_in_progress = leaf;	\
> +	u32 tdx_cfg_extra_caps = 0;					\
> +	u32 tdx_cfg_caps = 0;						\
> +									\
> +	feature_initializers						\
> +	tdx_cpu_cfg_caps[leaf] = (tdx_cfg_caps & kvm_cpu_caps[leaf]) |	\
> +				 tdx_cfg_extra_caps;			\
> +} while (0)

How about make some of the above into just static functions for easier
readabilyt?

And then drop the __maybe_unused for tdx_cpu_cap_init_in_progress?
