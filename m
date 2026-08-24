Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0013E5EFD;
	Mon, 24 Aug 2026 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553486; cv=none; b=PhbsXKCOurWOTS/5QxkQF80vONCx6AvWqZIYlQxvvzDAsJENUoJ4VJqGPor3ij43hNiYPQyxKwV6aeir4CPXsS0fMpNkR8wbgs0C/snbAQm7ER4Zo8fIhceek9nZQIPpzzXpoIplCKekqovOTYUfQD44RAp+Pk6U1RWdGXgLlpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553486; c=relaxed/simple;
	bh=Zji7MOBATIwhOu5ymRQenMe0hgRG9Xa3GsGzdTx8pWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwZBUa3sqSKWwZ/tanGWna5EpB6rvmY6AqJKujezxOEONYdF9G1MICIx3eDkhjrS/13+7UeqW9xhpNGNki5PZlHhSR/5Bs419SrH9l3ABMAoCUdJQPNfHwoNCXKel4XceWR+MPdar0ISPL+J6ZiHwWPJFYlQHVU/edAtoIu4+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOuj4Kfs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOuj4Kfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787553483; x=1819089483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zji7MOBATIwhOu5ymRQenMe0hgRG9Xa3GsGzdTx8pWo=;
  b=TOuj4Kfs/qprN90K3r9BNvtY45j/jZ8yV17IPMF8DoKuzgFY6Nui6Coc
   qnV5Fv4gDBWWtGpC234Cshwwp9QyTAHltPOcAe9of+JrH0Q/RBCzmpsu0
   9mzEVH3FmY5QQuwJIRbGGVVHQicfAqeTKXESzA8SNu76RY6ZWxvGRg9UH
   Zq/1FSTTpGVcQ7qu6reiSeO9MkTRV2JDP5YCMUzWEV+1rjtjQYnY9GrZ+
   0ImwT4fcsLSGCieE222QYjexbpEurq2iv4I+16JMrdeYTZffDNWPeNrQX
   QEJCEOSN48QAPnaJtpl2RsdFOfHNXbaF+wYKX2k477AXFCPO8EFuOjvK+
   Q==;
X-CSE-ConnectionGUID: 0iKMHDi7SWa93JEY4w+3Ng==
X-CSE-MsgGUID: U/SSspODTwyc0ep6pGwkoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88196898"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88196898"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 23:38:02 -0700
X-CSE-ConnectionGUID: Nf6Z4V0AQZukoXl2kUlddA==
X-CSE-MsgGUID: S7ebz0ODRPyqq5Z8KvqbeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="268871089"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa004.fm.intel.com with ESMTP; 23 Aug 2026 23:37:59 -0700
Date: Mon, 24 Aug 2026 14:37:58 +0800
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
Message-ID: <aovmxjpVFqOR3QXm@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-3-yilun.xu@linux.intel.com>
 <27321cc1-5428-4590-a88d-b2824659c89a@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27321cc1-5428-4590-a88d-b2824659c89a@intel.com>

On Fri, Aug 21, 2026 at 07:38:42AM -0700, Dave Hansen wrote:
> On 8/20/26 20:29, Xu Yilun wrote:
> >  static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
> > -				 u64 nr_tdmr_pa, u64 global_keyid)
> > +				 u64 nr_tdmr_pa, u64 global_keyid,
> > +				 u64 addon_features0)
> 
> addon_features0 is just a copy of the global, static, not changing
> get_tdx_addon_features0() return code, right?
> 
> Why pass it around as a function argument?

I thought that we need some place to explicitly see the TDX ABI
definition - what are the inputs the host should provide to the module.

The addon_features0 is the *option* the host should provide to the
module according to the ABI. The global, static value for addon_features0
is Linux's policy. So if we need to explicit the policy by the code,
this helper and its arguments are good places to show the boundary.

But yes it does add boilerplate to the code, I can drop it.
