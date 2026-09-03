Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01F39A7F4;
	Thu,  3 Sep 2026 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417208; cv=none; b=SY8ognhJJnHUq7OiBiAc9ns7CM/N4uJGvmnpOR3h4EQbPx6eRnoafqSs+W+OO/LTOmu+edhXnPzaFCanNdo8+6GAH1ZuKzjPVNWc6EZzvDJlYNaR42RUk1wLm8nv/K9SzE6eGWFhgeoYDbeIr135PZNRzAhN5/mq0yuV+LLwKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417208; c=relaxed/simple;
	bh=l67HJQJWW8LGIUTo0j/VFo9QduDcCzK1yZJbhIpMIRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJdlXOrw/Y3FDgTcWaeA6/vqybIifeqK4LrWF5jzOelahSIlCEQwTpfcHbcN7y+y00XK2decxv2e2GuigJjXnhT9/+t4cm1Hwy2C5uwLf8tcclg3BTHujx3S1CBQHWeprD7Hr7xq7/QcW/OrAOuWNkTB7J8tDINQfUowy3YdylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrneCZDe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrneCZDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788417205; x=1819953205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l67HJQJWW8LGIUTo0j/VFo9QduDcCzK1yZJbhIpMIRI=;
  b=nrneCZDebtxu43Nj0uVp6Ac0y2/s2hn7YSJAL8zQ7UTgI6AtEl+SxDVZ
   xOf458yn/xLHiQqtDyurYuM4KA8HkOAZzQR744FflHiBepzdtFpqaoUUL
   fg6sfQqTTmOA77Tgh53O4GjTzNrYdboSxYeiZm5acgWqxw/5U9c1H+Zw3
   WoT66K2pTC8KiD751WEl/p2qJNMIQLmK/z4a2vXyVCZKUI3BSUGuw2EUI
   pqRv1qJl8pBPsHhWlrDa7v5eip9+IGxTRAs54sJLfBn4dmbhaSJwda70R
   NieL4utRrruk+0ga+CUzKjKANEaPEqmbIi8s6rAcHRsUd7c+xGYdGyilJ
   Q==;
X-CSE-ConnectionGUID: +ZG9SvYwRO+5TRi8zRtxfg==
X-CSE-MsgGUID: wnW8nOFtTDOHCymQpExbGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100244139"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100244139"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:33:24 -0700
X-CSE-ConnectionGUID: /8HGsM6USGaBpEFm2lGPBg==
X-CSE-MsgGUID: lvzr3SXxT3Kk77OQduz6TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="266377190"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.231])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:33:20 -0700
Date: Thu, 3 Sep 2026 09:33:17 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Peter Fang <peter.fang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <apkUrXh4FJJua4mN@tlindgre-MOBL1>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-5-peter.fang@intel.com>
 <bf51e3d3-cf28-4155-9915-683bf6c848a4@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf51e3d3-cf28-4155-9915-683bf6c848a4@intel.com>

On Thu, Sep 03, 2026 at 02:21:35PM +0800, Xiaoyao Li wrote:
> On 7/29/2026 8:29 PM, Peter Fang wrote:
> > A new TDX module ABI reports the TD Quote size limit in a metadata
> > field. This size used to be fixed at 128 KB.
> > 
> > The guest driver's Quote buffer is shared with the host VMM. The current
> > fixed size may be too small for Quotes using schemes such as
> > post-quantum cryptography (PQC), where larger certificate chains can
> > increase the Quote size significantly.
> > 
> > Allocate the Quote buffer based on the reported limit. This avoids
> > wasting memory on platforms that do not require larger Quotes. Older
> > platforms fall back to the default 128 KB buffer.
> 
> I think we need to justify why using the value reported by TDX module
> (i.e., QUOTE_MAX_SIZE) is safe.
> 
> From "Intel TDX Module Extension for Quoting" spec,
> 
>   QUOTE_MAX_SIZE that specifies the maximum size of the buffer that must be
>   allocated to contain the Intel TDX Quote received from Intel TDX Module.
> 
> So, TDX module only guarantees that QUOTE_MAX_SIZE is big enough to hold
> the quote that is generated by the TDX module. But for the current tdx
> guest driver, it doesn't know how host will generate the quote. Host can
> generate the SGX-based quote and we need to justify the QUOTE_MAX_SIZE will
> be enough for such case.

And can we assume the TDX module provided size does not change after init
with a TDX module update?
