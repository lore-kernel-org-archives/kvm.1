Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4A3955F5;
	Mon,  1 Jun 2026 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308054; cv=none; b=twF8R3a5vu9gnb51XKYRU/6C3Q+OEjs203Ao2xIgZ+145PsvPeuSo5G3Ny/76Jt3s92xStdNgQtVpWmn1ZfLOcWw4H1u6pW51oExGmvpir5oy/sdKFYUAI/UOB4kcfSljFcTixfubW9vVv6edC9dbZunLS8oLCYnHkp7spb45fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308054; c=relaxed/simple;
	bh=FbI0bRlPAddTyHFXSSwTRkzWoJNkdtw0GL/zZRhWu4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLc1j8zalqTsCLhRvruzqK+IBIcen9yvrcZTFHEUACbm7HkhAqDhraGfGhooK/2DQK9feakXIu5FSCu3nXSToDQmSflWAQl5DyR5Xuxgm6KRVgEA5pD5BlwuZt1/d9Vu2r6EGZe9mixkk+rHQbCRBDcnCrLSkfmxtZvFXUNxqFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5zUpisj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5zUpisj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780308045; x=1811844045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FbI0bRlPAddTyHFXSSwTRkzWoJNkdtw0GL/zZRhWu4s=;
  b=V5zUpisjHqzxKIN5zqHW9yzN/2OvFl0Snii8NpG0xKu5JrpaPPKBOGM6
   yHWzO7owsnYMA2+ZIrKtlu3ZKOT6H8qYI1IMHS1WJy6LfHu9aVbfORCOj
   m3o0tyKKdGr+07TC59ol2LxLF6wWqnwux/BX3N1usP+qSN7p2aZOipp0G
   hT4pUU0CnyvnknT95n0fJsAkQfZX7n1Dl7h/KwhIltKgCaHzN0la5XccR
   cNNPVnIKP7EOboAq6pnYV8PsB9Cy89N3SaJThCTIxvTg1qg4N3SqzlkQ2
   fZOwTQxU+HBFbvaCRmd+S/vUxjMJIKNFH6+DMEIo5rWVeJ/SlHj/ZsVAz
   g==;
X-CSE-ConnectionGUID: yRcDOWFGSEe1EQfJQWZ0Ww==
X-CSE-MsgGUID: aNNAKr6VTuyLmvBwVRODzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84951612"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="84951612"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 03:00:44 -0700
X-CSE-ConnectionGUID: 0BGM89pkSViqMP1oK1e2ew==
X-CSE-MsgGUID: F2/YS7loQYWKytKP0S6wOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242486625"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 01 Jun 2026 03:00:41 -0700
Date: Mon, 1 Jun 2026 17:36:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Message-ID: <ah1SnuEHuFeX873m@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <2542e761-57ed-4170-8ce9-1de3fc685dea@intel.com>
 <ahbJnCFlGFwxrEkw@yilunxu-OptiPlex-7050>
 <e9b8083b-6747-4adf-9e48-ffae70dc6508@intel.com>
 <ahfJ9MW+kJp+kE6A@yilunxu-OptiPlex-7050>
 <7fdc27cc-22a8-4442-9c9b-4bace9ee0d23@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fdc27cc-22a8-4442-9c9b-4bace9ee0d23@intel.com>

On Thu, May 28, 2026 at 12:50:34PM -0700, Sohil Mehta wrote:
> On 5/27/2026 9:52 PM, Xu Yilun wrote:
> 
> > No the memory needed varies depends on the feature or the number of
> > features. But currently I see the total requirement is ~50MB.
> > 
> This is important consideration when defining the default policy. Could
> you please elaborate on how this will scale in the future?
> 
> How are the memory requirements expected to grow with additional features?

I queried the TDX module team, and the answer is they almost grow
linear. I measured the only feature - PCIe Link encryption (SPDM) - on
my hand again, the precise memory consumption is now 35M.

In the foreseeable future, the features are SPDM, DICE & TD Migration,
so will cost ~105M at most. I think the number still works with the
default policy.

> 
> Let's say a future platform has a lot more features and needs
> significantly more memory. Wouldn't loading a legacy kernel with this
> default policy lead to excessive wastage?

A legacy kernel won't consume Extensions memory. The Extensions memory
is only required by TDX module when add-ons features are explicitly
configured via TDH.SYS.CONFIG [1]. For legacy kernel, no add-on features
configured so no memory consumption.

But yes, if the features grow rapidly out of expectation, may need new
options to switch something off. I think if we discuss later when the
need actually arises.

[1]: https://lore.kernel.org/all/20260522034128.3144354-16-yilun.xu@linux.intel.com/

> 
> Maybe I am missing something obvious. The struct in patch 1,
> memory_pool_required_pages is u16. So, will the Extensions support never
> require more than 256MB?

Good catch. TDX module team admitted this is an issue. They want to
increase the size to 4 bytes for future.
