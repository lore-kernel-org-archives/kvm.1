Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BE381AF9;
	Mon, 24 Aug 2026 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596486; cv=none; b=SI+EtFK4mAUZ7lTVi2OnwXbCuPPdQp74o1zdnBVW2FvszQVtbtWP33syPFfHfzXWiZlHeO24+vWNTBgdCAUv0pvt2HZpF8eOiwnyDnmg21vCRqm2EQKkjZzXhEdRbwhR4Q8UZyqB1ymuMkVKXPM9uXi1jKfa8VRzT40bsge92XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596486; c=relaxed/simple;
	bh=CuZt0Rc9B+EClwRdkLTVpAtCNgLiB4yiFij9GDs5fOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT9/d6+yfEDxbr9HrR6wY8KJ4RyqQatzeLHTOcln7ez3gVnriyvXdTzKAwovIcwRINrT5DduqvGid1z8W43yoWZfRQKmxjUCUbsty/R28iipko+Uzn6nQzawDlcfIWnL4FKwISMYXtR137VFd3qegLHhdMyucOB4T1//Bp2LUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCog/+TC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCog/+TC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787596484; x=1819132484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CuZt0Rc9B+EClwRdkLTVpAtCNgLiB4yiFij9GDs5fOQ=;
  b=GCog/+TCSfJuUy2/OS8K/ZIf8bem3Hj8HHQhX235mtNWoowjAumthjYg
   ZyLlB/H5iVDXA9VeWKQh2GMNKFzJnKyf/ZhdNyM3xlldbyQ82EouUweEN
   7a+rt/zatSIBmEw+BEQgicNM67Ej2cjX9l5xvtzpI96BCClpM18+3cV+k
   PtqFeU7CrRu5JOSTPTw0GLurW5JAyeJKIymlYD32fOF0Q+qdiomfitgJa
   UC25At825UAIZh82AD/+vjS5j5mjiXBVOYHnj79/Ix4hWHyNwNSvOHXrF
   YsOL0UFBLQN4BAV/EkdeGE4HUEz6MOmG1epU6o8PPKhzSKsdwMryHo85I
   g==;
X-CSE-ConnectionGUID: dnb+S0RHTVOq3Zx9RQKKVg==
X-CSE-MsgGUID: 7TYlxiO2QkWlqH9EWLRwzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87930230"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="87930230"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 11:34:44 -0700
X-CSE-ConnectionGUID: 42OdAisfTsGhwJMmn4G5/A==
X-CSE-MsgGUID: 4Hozz5qqR/io36bv/Ko0fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="260927713"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa009.fm.intel.com with ESMTP; 24 Aug 2026 11:34:40 -0700
Date: Tue, 25 Aug 2026 02:34:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	chao.gao@intel.com, artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org
Subject: Re: [PATCH 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Message-ID: <aoyOv2mJqUyjdO5R@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-3-yilun.xu@linux.intel.com>
 <27321cc1-5428-4590-a88d-b2824659c89a@intel.com>
 <aovmxjpVFqOR3QXm@yilunxu-OptiPlex-7050>
 <22bf174e-788b-4038-84e0-c6bea351830d@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22bf174e-788b-4038-84e0-c6bea351830d@intel.com>

On Mon, Aug 24, 2026 at 08:15:41AM -0700, Dave Hansen wrote:
> On 8/23/26 23:37, Xu Yilun wrote:
> > On Fri, Aug 21, 2026 at 07:38:42AM -0700, Dave Hansen wrote:
> >> On 8/20/26 20:29, Xu Yilun wrote:
> >>>  static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
> >>> -				 u64 nr_tdmr_pa, u64 global_keyid)
> >>> +				 u64 nr_tdmr_pa, u64 global_keyid,
> >>> +				 u64 addon_features0)
> >>
> >> addon_features0 is just a copy of the global, static, not changing
> >> get_tdx_addon_features0() return code, right?
> >>
> >> Why pass it around as a function argument?
> > 
> > I thought that we need some place to explicitly see the TDX ABI
> > definition - what are the inputs the host should provide to the module.
> > 
> > The addon_features0 is the *option* the host should provide to the
> > module according to the ABI. The global, static value for addon_features0
> > is Linux's policy. So if we need to explicit the policy by the code,
> > this helper and its arguments are good places to show the boundary.
> > 
> > But yes it does add boilerplate to the code, I can drop it.
> 
> I'm not arguing that the helper should go away.
> 
> What I'm seeing is this pattern:
> 
> int helper()
> {
> 	return something;
> }
> 
> int func_low_level(int arg)
> {
> 	// use arg
> }
> 
> int func()
> {
> 	int foo = helper();
> 
> 	// use foo
> 
> 	func_low_level(foo);	
> }
> 
> When it could use this pattern and just call helper() twice instead of
> obtaining its return value and passing it around:
> 
> int helper()
> {
> 	return something;
> }
> 
> int func_low_level()
> {
> 	int bar = helper();
> 	// use bar
> }
> 
> int func()
> {
> 	int foo = helper();
> 
> 	// use foo
> 
> 	func_low_level();	
> }
> 
> So that's what I was asking. Why pass the result of helper() around when
> you can just call helper() twice?

Because I thought func_low_level() mirrors the TDX ABI. This SEAMCALL ABI
is defined to get 4 inputs from the host, while helper() is the Linux's
policy (enable all add-ons) to generate the 4th input. Embed the Linux
policy in TDX ABI implementation feels a little off to me.

But I don't have strong preference. I can drop the addon_features0
argument.
