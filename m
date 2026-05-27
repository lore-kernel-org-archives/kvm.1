Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215383BADBD;
	Wed, 27 May 2026 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867366; cv=none; b=AsQ2LxCVBDzKD4T5xqUPqGL61moyO25SvIfFuiIkXI+Pclvw/7aGUQjDJxDwXxarc1PfHn/yP3wi5UD75uwIQha41591zYL7ImFr5K3VjNQ43/aHErisku2CuRVCIfACEU/iuynVLaFcttZnyXwG+jNPDB41zWhTXJR1umo8OoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867366; c=relaxed/simple;
	bh=jJxmfr0ZMSUiNYT3VY0T18Tgkm8H53Ln35tUn9VNEo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNO77ffCNcnuDqa96haisO3Sa+LlgXRuN4ngXXJuDJfZSV4oZdm6xF1bBxe5JHViZRBMfQlJoLIx/bd1aaU22JBSi6kHIdgcW8n1Q8d2jX1lqyappWe9Py+4ZYcOgkGnjgnpZgb6Dl1bGeeUXGrBvNgpa48iOAUSzp9YaHR2y9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfJYtQ9B; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfJYtQ9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779867365; x=1811403365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJxmfr0ZMSUiNYT3VY0T18Tgkm8H53Ln35tUn9VNEo8=;
  b=mfJYtQ9B27ntx9D6yB6Se40EDicLtFDnDQk6FHetptkYRE/OTnGk9YvH
   pIllCbZPyeA+Cr3Ot/n39s9V7rPQiLFzwhHZLPZnovMa/y8GASrvx4dsh
   q0Jiv4mT0ZQJ+Gz2vJhkmkdQUY0V+FumdMrohSbHAstB1D+Elbo5NbR5C
   JfWkHBD0olCigHR46PKzbxDDpzVuBT42RxN/QUSPOTWcF8pokCcb9mb2A
   74YByut/HHMnI+2k4fYhbTx+i3fbL7FUp1eBWOqkJ9kmsedvK0knq64Ie
   wG+lr6TonA80Bh4+s8rsvZZIJCt2TjBHlsdMu9j41P4Jus4PUFfHQP/FY
   w==;
X-CSE-ConnectionGUID: Ggg5nnEZQM+ERNsFgKEo3Q==
X-CSE-MsgGUID: 6t/5ydbzROiCyKWK31O5cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91262460"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="91262460"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 00:35:57 -0700
X-CSE-ConnectionGUID: HBTTigcnQZWB+8uBXCA3NQ==
X-CSE-MsgGUID: GzTNo3lbTouJ4duTUdVwBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241995879"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 27 May 2026 00:35:54 -0700
Date: Wed, 27 May 2026 15:11:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Message-ID: <ahaZPjf+A7ms0Ba9@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
 <b25e03ad-0bf4-482f-86ec-eebc6ac03d95@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25e03ad-0bf4-482f-86ec-eebc6ac03d95@intel.com>

On Tue, May 26, 2026 at 11:05:48PM -0700, Sohil Mehta wrote:
> On 5/21/2026 8:41 PM, Xu Yilun wrote:
> > Add reading of the global metadata for TDX Module Extensions.
> > 
> > TDX Module Extensions is an add-on feature enumerated by TDX_FEATURES0.
> > But for the Module's integrity, Linux requires that all features that a
> > Module advertises must have a complete, valid set of metadata, and the
> > validation must succeed at core TDX initialization time.
> > 
> > Check TDX_FEATURES0 before reading these metadata. If a feature is
> > advertised, a failure in reading associated metadata causes the entire
> > TDX initialization to fail, otherwise skip.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > ---
> >  arch/x86/include/asm/tdx_global_metadata.h  |  6 ++++++
> >  arch/x86/virt/vmx/tdx/tdx.h                 |  1 +
> >  arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 16 ++++++++++++++++
> 
> The top comments in tdx_global_metadata.h and tdx_global_metadata.c say
> that these files are autogenerated. I believe the script lives outside
> the tree. Is there a plan to merge the script?

No, the plan of auto-generating is deprecated. Now we switch to manual
update.

> 
> The generated code is optimized for space instead of readability. Also,
> I see odd uncommented assignments u64 => u8/u16 all over the file. I am
> assuming the upper bits are expected to be zero.
> 
> The patch is hard to review without the script. Can you post a link to

Yes, it is. A new plan is to refactor the file in future.

> the updated script that led to this patch?
> 
> 
> >  3 files changed, 23 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
> > index 40689c8dc67e..533afe50a3f1 100644
> > --- a/arch/x86/include/asm/tdx_global_metadata.h
> > +++ b/arch/x86/include/asm/tdx_global_metadata.h
> > @@ -40,12 +40,18 @@ struct tdx_sys_info_td_conf {
> >  	u64 cpuid_config_values[128][2];
> >  };
> >  
> > +struct tdx_sys_info_ext {
> > +	u16 memory_pool_required_pages;
> > +	u8 ext_required;
> 
> The name ext_required seems like a boolean. It is also used like a
> boolean later.
> 	if (!tdx_sysinfo.ext.ext_required)
> 		return 0;
> 
> But, IIUC, is it actually a mask that lists any feature that needs

No it is just a bool about Extentions needs to be initialized or not.

> extensions to work correctly? If so, it would be good to give it a name
> that reflects its usage. Maybe:
> features_requiring_ext or something better
> 
> As Xiaoyao mentioned, the struct requires a better explanation in the
> commit log.

Will do. I also plan to change the patch organization: instead of the
old auto-generated patch splitting style, I will switch to a human-readable
style and fold these metadata readings directly into the patches that
actually use them (e.g., DPAMT and TDX Runtime Update).
