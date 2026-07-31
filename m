Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E3372677
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481604; cv=none; b=FWnGsQUYefA3pyfzFHyLqUN7I82s8nsq0tT8+c8sUbeB3O6lHhsHGY3MshZhXLZULlxVvczG0SML2TcxH8uY9YyKg4iTOJC2Z/tuOssCox57gLBatHGgfOsSLoKxehXjQyA14j4XQWdsDLc+4g3rP75KygZoZPq/oNR6MoMssKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481604; c=relaxed/simple;
	bh=ZPmdXFnnpW1uYPCavwrjqrpVSftazrir+BDPF72Y+g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPtcgh5LStRq7+eqEBJBFMZ+RyAhcpWiYTa1WUCmTLDkpJUSxRE9vgtebVuZXcow3EiBXrFOue68LlNP4t7+xE75mIc+5yHHVifGVsFN9z7ochwBW9H3Ti2xitAUDAWyhwjqEZjyMuxhxJxfNZVB28WoLWNFPgcoE4UBD693pUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOexgIfk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOexgIfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785481603; x=1817017603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZPmdXFnnpW1uYPCavwrjqrpVSftazrir+BDPF72Y+g4=;
  b=TOexgIfkQLgxT8Gy5l/QWfKCVfIMP2Wc52USXZZVE4pBtDeW5BY7yR6+
   4R+CfLaLl6vAgO9VVv0Yhkj+04imnEnFfF/shfdvPcMZuSojnji03zf+d
   YywBRgnI+lfUEmpS3NQlnF9P4oh3v8tEqbiBaUZerF96XAeHay+q/Hzcm
   hTvkFnbpSfTWEM0Raazpl7MEVWUXUZLIppJRtWHp1ODQ62875Um6DNSa6
   DE8riJfuIok7dnVc7bIwzDtJRVJ9QI47OhTrQsPCNr1Rxv7ZpyqTll3is
   7LqX5BLoByjyiJJc8YQIHiUrYtLNUpFlddNdjPpsbvQ4k73pHZujh9XzZ
   w==;
X-CSE-ConnectionGUID: Qm0Cdme/QGO8f8daA+rbDw==
X-CSE-MsgGUID: qT75EtI5QX6fgJZ0sGl+Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97480592"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="97480592"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 00:06:42 -0700
X-CSE-ConnectionGUID: Qoj14TtJRr653khBEo1d8w==
X-CSE-MsgGUID: 4tUYOQ7WTqSHaqFU5VSDow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="290460436"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa002.jf.intel.com with ESMTP; 31 Jul 2026 00:06:41 -0700
Date: Fri, 31 Jul 2026 15:06:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v1 4/9] target/i386/kvm: Use AMD MCE status encoding for
 Hygon
Message-ID: <amxJf2elltpmBHFD@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-5-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706055530.1752094-5-zhang_wei@open-hieco.net>

> +/*
> + * Use AMD-style MCE status records for QEMU-injected memory failures on
> + * AMD and Hygon CPUs.
> + */
> +static bool kvm_mce_inject_uses_amd_status(const CPUX86State *env)
> +{
> +    return IS_AMD_CPU(env) || IS_HYGON_CPU(env);
> +}
> +
>  static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>  {
>      CPUState *cs = CPU(cpu);
> @@ -707,7 +716,7 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>      uint64_t mcg_status = MCG_STATUS_MCIP | MCG_STATUS_RIPV;
>      int flags = 0;
>  
> -    if (!IS_AMD_CPU(env)) {
> +    if (!kvm_mce_inject_uses_amd_status(env)) {

Maybe we can check hygon directly here?


Regards,
Zhao

>          status |= MCI_STATUS_S | MCI_STATUS_UC;
>          if (code == BUS_MCEERR_AR) {
>              status |= MCI_STATUS_AR | 0x134;
> -- 
> 2.43.7
> 
> 
