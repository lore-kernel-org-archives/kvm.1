Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9C3D9DA8;
	Tue,  1 Sep 2026 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253757; cv=none; b=LlGZNmXFDK+YDr+1AJPVKgRilfMrtM2X8P2omBoRRBDL65OpJ957uQY4/tSCUqZ4Np19BpqklIZRqrckFk1hJKXV72C3CuEazEK1LchGSQiczmiCC47/tT7vRpzdhfQZQxg78M/e69YJOkTErUENcssIo/F9hb435AfziW5osAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253757; c=relaxed/simple;
	bh=Y4/T1t0/5d6DPMYU2oiJY3HMTFglW1Px3HhcVyu7rSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2GwfbDgLCuJqH9V3HCKyCGuqXamceJN1vdZyDnVQEu8pvqx7W3coULU/MZwx+xtQa/lTkhbyWaSM8JpQDbT/IbH6NuAjeB/ZuQBAsnHf7KmFQI3deQkymBvrc+H+592f1RFp+kDyzIsp5RWVtyJDADM4BN0TymIK+e1SdnarTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu/fLs6z; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu/fLs6z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788253753; x=1819789753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y4/T1t0/5d6DPMYU2oiJY3HMTFglW1Px3HhcVyu7rSs=;
  b=Yu/fLs6zM9o+BIupHyb2n5t1P31MqSfGvho/jCD12mpG1zHZP8SZt0Nf
   3SvGcp8X1Qnl/u6NoMTRiz6aTvo7NWK5GbGKcfEtMJhuBKyrFuDETFZ80
   USf6N09liswdhIsBlD+hOPFSuF2GXP6RKnc0GQgj4cC383iLK99UtF4pl
   Mz49TwuVE+arfKrTQYNXCSu7KI6UKtRprVIGx6KioBugCzjkafn7ydEsw
   NR4BV17KBk5wQZm5CY+dWjU/ChGchu5lQbjNe7tXjGWWytYXMM1FBxzP4
   jYP2FZvBAN9hu489u6gL6HjglJn2b6TZNnu/Gz8HC7DYEnLy3OB3Xbn0D
   Q==;
X-CSE-ConnectionGUID: tERUTOmzTnix5rB1bos1bA==
X-CSE-MsgGUID: fvSMTp99STO/HigwlzJVrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99334602"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99334602"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:09:09 -0700
X-CSE-ConnectionGUID: HJSldBdbSn29p67N9lRijw==
X-CSE-MsgGUID: e7mjZsjxRtibTToC8EiwNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="265321379"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:09:05 -0700
Date: Tue, 1 Sep 2026 12:09:02 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
	pbonzini@redhat.com, dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com
Subject: Re: [PATCH v3 3/4] KVM: TDX: Filter configurable CPUID bits
Message-ID: <apaWLqbWq2boIGld@tlindgre-MOBL1>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-4-binbin.wu@linux.intel.com>
 <apZ0X8J31bVCoc9E@tlindgre-MOBL1>
 <09c2f755-d822-4aac-993a-878d58c3b47b@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c2f755-d822-4aac-993a-878d58c3b47b@linux.intel.com>

On Tue, Sep 01, 2026 at 04:42:20PM +0800, Binbin Wu wrote:
> On 9/1/2026 2:44 PM, Tony Lindgren wrote:
> > On Thu, Aug 27, 2026 at 11:18:36AM +0800, Binbin Wu wrote:
> >> --- a/arch/x86/kvm/vmx/tdx.c
> >> +++ b/arch/x86/kvm/vmx/tdx.c
> > ...
> >> +static u32 tdx_cfg_non_feature_mask(u32 function, u32 index, int reg)
> >>  {
> >> -	if (has_tsx(entry))
> >> -		clear_tsx(entry);
> >> +	/*
> >> +	 * For a leaf/subleaf/register that will never be repurposed to hold
> >> +	 * feature bits, it's safe to return TDX_CPUID_ALL_ALLOWED_MASK, i.e.
> >> +	 * leave the TDX module's CPUID config mask intact.
> >> +	 */
> >> +	switch (function) {
> >> +	case 1:
> >> +		if (reg == CPUID_EAX || reg == CPUID_EBX)
> >> +			return TDX_CPUID_ALL_ALLOWED_MASK;
> >> +		return 0;
> >> +	case 4:
> >> +	case 0x18:
> >> +	case 0x1f:
> >> +		return TDX_CPUID_ALL_ALLOWED_MASK;
> >> +	case 0x24:
> >> +		if (index == 0 && reg == CPUID_EBX)
> >> +			return GENMASK_U32(7, 0);
> >> +		return 0;
> >> +	case 0x80000008:
> >> +		if (reg == CPUID_EAX)
> >> +			return TDX_CPUID_ALL_ALLOWED_MASK;
> >> +		return 0;
> >> +	default:
> >> +		return 0;
> >> +	}
> >> +}
> > 
> > How about rename the above to something simpler like tdx_get_cpuid_bits()?
> > Sorry I don't have anything better to suggest for naming.
> > 
> >> +static u32 tdx_cfg_feature_mask(u32 function, u32 index, int reg)
> >> +{
> >> +	for (int i = 0; i < NR_KVM_CPU_CAPS; i++) {
> >> +		const struct cpuid_reg *cpuid = &reverse_cpuid[i];
> >> +
> >> +		if (!cpuid->function)
> >> +			continue;
> >> +
> >> +		if (cpuid->function == function && cpuid->index == index &&
> >> +		    cpuid->reg == reg)
> >> +			return tdx_cpu_cfg_caps[i];
> >> +	}
> >> +
> >> +	return 0;
> >>  }
> > 
> > And then the above to tdx_get_cpuid_feature_bits()?
> >   
> >> -static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
> >> +static u32 tdx_get_allowed_cfg_cpuid_mask(u32 function, u32 index, int reg)
> >>  {
> >> -	return has_tsx(entry) || has_waitpkg(entry);
> >> +	u32 non_feature_mask = tdx_cfg_non_feature_mask(function, index, reg);
> >> +
> >> +	if (non_feature_mask == TDX_CPUID_ALL_ALLOWED_MASK)
> >> +		return TDX_CPUID_ALL_ALLOWED_MASK;
> >> +
> >> +	/*
> >> +	 * It's possible that a CPUID register contains both feature and
> >> +	 * non-feature bits.
> >> +	 */
> >> +	return non_feature_mask | tdx_cfg_feature_mask(function, index, reg);
> >>  }
> > 
> > And then tdx_get_cpuid_mask()?
> 
> How about:
> tdx_get_cpuid_cfg_non_feature_mask()
> tdx_get_cpuid_cfg_feature_mask()
> tdx_get_cpuid_cfg_mask()

I'd be happy with that.
