Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35773AE713;
	Wed, 10 Jun 2026 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080480; cv=none; b=AU3TDnLK97OuYvJ9N9/azR68VoYYVP/+bq/S2iPlmGuREW9eJSPCkUmJbJjIprJCD1SWgIjBAypo6f1sq/LAHh+Sqd3UVYLnYsikd+Lq9KRg5Bl4psagVbpesPSZBn1XraK0B/44jPYTa7IBq3GIMNuhQJNHOfqvxNG/ABIXTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080480; c=relaxed/simple;
	bh=PPVeDOSDXrnMWp7tNZLhyZLJiQOtz/9d+t/nlGj5jX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQspJLloj/szb3Gf9OQDeAKM4TO7VdASPle+8I2KmtUxkB1detn6etWnLsiT6r0VLMwp7J9x9p8TwxcNXVOOl37er86UcHICLUuZfAVsDt7fLKdsk+VM4TF4BWzop6suOz0dx0BCBuZmLivFsnFUmyw79Y7sAERsj44Ytd+/pa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTM35nJ+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTM35nJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781080480; x=1812616480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PPVeDOSDXrnMWp7tNZLhyZLJiQOtz/9d+t/nlGj5jX8=;
  b=kTM35nJ+xFcSSro4kxLdcOu413znRkD3Vquufkyim/xM/Pc20ExB+KFg
   eQwZ9PJ8GqeKHFacQ8IGp99ZXi6PK/KYBcFzgug780oXW4uDZXzWErNrp
   Ecn1RaQLg7V5Z9RiByoF/ZgCsHGpXt9vHn6nlTag0qOdIlrD0Yali73al
   y6IfcPRwEW0QVup3HOVeKNDUcdeodSrmFBTvZcEodK9Zu8TgfPwaJeUCc
   Ov8ijdWoAU8IToyb6VGbTQqm/+7ne8bahwCWxOaz177rc31AR/mg3f5HG
   kfwON/PWsmMQ2vmQs8nHzKaWtlS6sKP4ua2RXMWjjPcTqnOK1dBBb04oV
   w==;
X-CSE-ConnectionGUID: JMkXwqMYRa+iEwG8yH7IOA==
X-CSE-MsgGUID: 2c5Jjd8tSmiAY7FjFJ5urg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81845084"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81845084"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 01:34:39 -0700
X-CSE-ConnectionGUID: BPQqV6s2TciNEngtMYXryw==
X-CSE-MsgGUID: qjh8GI0RTyOrDe31He1RDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="241680088"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 10 Jun 2026 01:34:35 -0700
Date: Wed, 10 Jun 2026 16:09:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 03/15] x86/virt/tdx: Make TDX Module initialize Extensions
Message-ID: <aikb1oPW3Dzcoj9K@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-4-yilun.xu@linux.intel.com>
 <1f6bf040-6a90-47f8-93dd-0e36d4f256dc@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f6bf040-6a90-47f8-93dd-0e36d4f256dc@intel.com>

On Tue, Jun 09, 2026 at 06:14:22PM +0300, Adrian Hunter wrote:
> On 22/05/2026 06:41, Xu Yilun wrote:
> > +/* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
> 
> Reads slightly better without "the", so taking Tony's suggestion
> one word less:
> 
> "Initialize TDX Module Extensions for Extension-SEAMCALLs"

OK, included.

> 
> > +static int tdx_ext_init(void)
> > +{
> > +	struct tdx_module_args args = {};
> > +	u64 r;
> > +
> > +	do {
> > +		r = seamcall(TDH_EXT_INIT, &args);
> > +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> > +
> > +	if (r != TDX_SUCCESS)
> 
> There seems to be TDX_PREV_FEATURES_ENABLED which is unused,
> but could it turn up here?

“Yes, but not now.” from Module team. It is some future thing
under discussion.
