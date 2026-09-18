Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B943A81A;
	Fri, 18 Sep 2026 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725409; cv=none; b=s4i+iaoId7M3Rojvf5F4RCxNsPIi9V13kyYvg+5me95T1UUIbzHGQ1jVe32064PgNF1Y7FgLXapY867T3SGizNbBCEqR2vUIEP95kTfjvTka5dWMKliuNfo+PubptIi8hh0aBe2MaccvYo+TGPoliMYjJsHtP8sz97qzDnwcqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725409; c=relaxed/simple;
	bh=NuH7pmx+0A8Wu/jHvV54MuVr4rgjrQerP0rzVSpk7+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7W90cBf27ctRR/5fJmOPPdv/v8Ps3x21+S7WFsNde/85QKiv5LQzsW7XpI3x+ZT7e0MYp8NoEj4HozJQqID0+ckN7WE2tPh4sW5N7oBnAFLQf71WM3+C3Ljt4yuYvYvnnNT+AMYrLxVRYq6CiNQZP1tR+MgtNxuZrs2posgaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5zEF/13; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5zEF/13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725407; x=1821261407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NuH7pmx+0A8Wu/jHvV54MuVr4rgjrQerP0rzVSpk7+w=;
  b=a5zEF/13yw2YvoP3J/m01Tgs52XcSVAYUayRW6CRiI7855INc1z2hUql
   JuCh++6GMOGZEKAszrGPbRLmqdaWgj85cwMHUrLjeRWHyM0GChu2i2vMM
   HnM7IIc1RPFsl+P8s9Xw4Zx9yz5UVYUGloSla+/uFe2LfJ9bc8ntxnGCd
   T4QNaP8n2oZ4grAPCtCZUKxyC/kYvRkjDSRzAPN2YkFzJAKF0erRjfYW+
   It+ZUYnjRetAw4BJdDtQYg8fx8wbLJ0xsTh9f2+KxaXCqe9DqgI0FB0ej
   ZpX9mVXgXgKk8TFFK6tbLft9q1jSnQCsu0a34qxFAyM5uxbTHbkNFNl6d
   g==;
X-CSE-ConnectionGUID: R+sp3ZbhQPuKsz+W5RwE1A==
X-CSE-MsgGUID: FWSrewIFR0+YCwEgPv0x2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90351768"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90351768"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:56:47 -0700
X-CSE-ConnectionGUID: nsTEGihQSAmHzty72eXD3w==
X-CSE-MsgGUID: Fq6vv3jvS7qVK+1N5UW4Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2514002"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa012.fm.intel.com with ESMTP; 18 Sep 2026 02:56:43 -0700
Date: Fri, 18 Sep 2026 17:56:20 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org,
	nik.borisov@suse.com
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX
 module init
Message-ID: <aq0KxJ34tI9ZdmSF@yilunxu-OptiPlex-7050>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-3-yilun.xu@linux.intel.com>
 <aqoLqXyeXUFkvnxF@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqoLqXyeXUFkvnxF@intel.com>

On Wed, Sep 16, 2026 at 11:23:21AM +0800, Chao Gao wrote:
> On Tue, Sep 15, 2026 at 06:26:55PM +0800, Xu Yilun wrote:
> >The TDX architecture identifies some features that are off by default
> >but can be enabled by the host during TDX module initialization. They
> >are classified as add-on features because enabling them affects existing
> >TDX systems: they may change existing feature behavior, or reserve more
> >memory.
> >
> >The TDX module extends TDH.SYS.CONFIG with a new register argument to
> >specify which add-on features to enable. This new argument is a bitmap
> >that uses the same feature bits as TDX_FEATURES0. Note that Dynamic PAMT
> >is an exception: although it is an add-on feature, it is controlled via
> >a legacy, dedicated register argument [1].
> >
> >The kernel needs to enable these add-on features when it supports them.
> >Add a get_tdx_addon_features0() helper to return the bitmap of the add-on
> >features that the module & kernel both support. Initially, this helper
> >returns 0. It will be updated to return specific feature bits as full
> >kernel support lands. Pass this extra bitmap to TDH.SYS.CONFIG wrapper.
> 
> The last sentence is stale: the bitmap is no longer passed to the wrapper.

Good catch.

  Pass this bitmap as an argument to TDH.SYS.CONFIG.

Thanks.
