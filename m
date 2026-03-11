Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BF632C302
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213660; cv=none; b=pUyI/lnSHGlU7y3gI4oInH9pNuEdeWn4Sv42JJ8N+bHEzabYPuKf5y+PnV9jHLieFQkcFE6g2s/iTM8NybuCqkR9jXLYDibneMn6zMmNchp1Y/D2PdNfEePnESZJO5k7PJit04KazTc1A3PiIKfcZsIRbEg9Lo5MuNYKN2M4RZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213660; c=relaxed/simple;
	bh=4ZKAITOZ6IVgO7mEt+sJT3YogPjl9LQBhjgpgFwbuis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRb+L1zZUYvIpCNfr6S5ht19ZrqJQJCszGG0Lyy3nzWrl1EujjqD6eoWTkwkIzpvHOQrD/PH7IDCOTfWk4Rcg6nWf+xoFTx7c9mbBnrE9Td/sFz3qmi9PCTf4yUQIVVtNyiaoWLuJ6SxmC6m0Du75gMJNXlaqnGpt/5ikJ2fY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+/z6hzr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+/z6hzr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773213651; x=1804749651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ZKAITOZ6IVgO7mEt+sJT3YogPjl9LQBhjgpgFwbuis=;
  b=I+/z6hzrQhQQzcwtm/e/ep9fwaNEhiohf4EWswyafbXEca0RYes59via
   iSk55qSnau1D8NvMFPoNLh4XdkHYizNKDyVxsRglGdpViud0PScYF0Z6O
   EUAv83zHPehZeXcbVYtGPIrdWcG4UJeGA48wTZ+CQh/Z32BcRBm68fEts
   IRjIO6Jx8YgY4LFQs9e5IgwK9w5z5BoTqluKbrSUbeXuhEC1DL/pFT9T8
   oD8kblxk/hDZhaZudZRsuJ/DL8S2JtsVeFx0ncoqbSweIsFk7R3fqd8nH
   BJ/2YsDDUE844RUz+JN6UTStl25HlxIr5EhKRgaOQqlwhxDfFNyF/Fw/c
   Q==;
X-CSE-ConnectionGUID: C3dgWi4XQbysM2oT/DzGbQ==
X-CSE-MsgGUID: YYYEFnjjTQOIVA0bfk49ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85752386"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85752386"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 00:20:50 -0700
X-CSE-ConnectionGUID: FbK/3rBOS/yosrzZ3ZdWKQ==
X-CSE-MsgGUID: 7pFjkEfaQXuxtHZIUaCGyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="258286120"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.39])
  by orviesa001.jf.intel.com with ESMTP; 11 Mar 2026 00:20:48 -0700
Date: Wed, 11 Mar 2026 15:46:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] coverity: fix coverity issues related to confidential
 guest reset
Message-ID: <abEd8jAaSGsaRK2P@intel.com>
References: <20260311034653.59826-1-anisinha@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311034653.59826-1-anisinha@redhat.com>

On Wed, Mar 11, 2026 at 09:16:53AM +0530, Ani Sinha wrote:
> Date: Wed, 11 Mar 2026 09:16:53 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH] coverity: fix coverity issues related to confidential
>  guest reset
> X-Mailer: git-send-email 2.42.0
> 
> Fix issues reported by Peter.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  system/runstate.c | 5 ++++-
>  target/i386/sev.c | 4 ----
>  2 files changed, 4 insertions(+), 5 deletions(-)

It's better to add Fixes tag or links.

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

