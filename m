Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DF199947;
	Tue,  6 Oct 2026 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261158; cv=none; b=LXgKHZ3HqsqbXqyQFsCZdM3kPhX3U3iQbXfcDMX6SvPXR+d03myZ43ACfaFZB+6ir2vGs1nXLZVscm8Xyf1iCpTyM2aNd6m3yaVoWtZtN6dSfBEj8TIT0piu6Oga8QZFC1t5XYIiD+L0NCAEV9HkjfVkJt7h4PPSXi4nLZyiqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261158; c=relaxed/simple;
	bh=JPU8qK8R86MxrTAJNmhAhrY3LXObu+xyI/OZL4t93TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNGeyiJcBbJ1q9pDTMOe0hD2Pb6Z3apAstaY7naS33wsUIxCE40OLAqHmKew9R9FBEbZ5bmLS8lojpjef9nkCOsFIpi9FkaBiLqM+eVRX1RqGHQrr7LCSvPjhIk0DigGq7C0EGbPkMGwUUyTYC67iIcNKD/25hG3zdZPThyrG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Li57CGY/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Li57CGY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791261156; x=1822797156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JPU8qK8R86MxrTAJNmhAhrY3LXObu+xyI/OZL4t93TA=;
  b=Li57CGY/LcVsFiZk/zIcsnrAS8pNKMfbINY6Az93q9zU9NmsGJWcZJYs
   Zf6X4wk6wpMIlTVOgr7nY8t9l3Vmz1hYs1pRC7bbjIKZb+J5xef3OcDmW
   mbgxutDb9tM+uabVq6GXC8Y8v/wznDIZyi7ZFTx70f3uoJ42q+eg9gmVP
   FfBaeNNxqYp7ZXTus/MiZbj1hkF61AliuvxO286rFYZ/eKCXUPBZOm+/O
   bO1+G+qgyaT5E4z/O8etzYKadHeMOL05P9HbcpJcOmKh8UdWE/e7xDWWa
   MHEZD0eJvsT2WmDxOQdP8R6ZBeFtja/3Af5orRNdBl06RjSx5I2/e9CCr
   g==;
X-CSE-ConnectionGUID: OlhXpDs4TFi4/5ZOZ40NLw==
X-CSE-MsgGUID: tDJISu8TRKKxkcwg37fQgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="117457963"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="117457963"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 21:32:35 -0700
X-CSE-ConnectionGUID: UCDyFfUCT2mD4wNZIGKl4g==
X-CSE-MsgGUID: cFTr4AswToeof00WTmBAHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="274825910"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.96])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 21:32:28 -0700
Date: Tue, 6 Oct 2026 07:32:25 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com,
	kvm@vger.kernel.org, yilun.xu@intel.com, xiaoyao.li@intel.com,
	sohil.mehta@intel.com, adrian.hunter@intel.com,
	kishen.maloor@intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	chao.gao@intel.com, artem.bityutskiy@linux.intel.com,
	nik.borisov@suse.com
Subject: Re: [PATCH v3 5/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Message-ID: <asR52ZRgjUqLfeI5@tlindgre-MOBL1>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>

On Tue, Oct 06, 2026 at 01:41:49AM +0800, Xu Yilun wrote:
> Runtime TDX module update introduces a mechanism to update the module
> firmware while preserving and restoring TDX operations. The extensions
> functionalities should also be re-initialized as part of the restoration
> process.
> 
> The TDX architecture supports an update flow which allows updated
> extensions to consume more memory than their original boot-time
> requirement. So the arch defines the extensions re-initialization flow
> the same as boot-up initialization: the host queries TDX module how much
> additional memory needed, allocates it, adds it to the module via
> TDH.EXT.MEM.ADD, then re-initializes the extensions via TDH.EXT.INIT.
> 
> Linux runs the updates in stop_machine() context, which prevents memory
> allocation. So for Linux, a compatible update must not install updated
> extensions that require additional memory.
> 
> Given that the memory for the extensions must not increase, the
> re-initialization skips the memory adding steps. It is simplified as:
> 
>   - Check if the extensions are supported via TDX_FEATURES0_EXT. If not,
>     skip the extensions re-initialization.
> 
>   - Re-initialize the extensions via TDH.EXT.INIT. The SEAMCALL leaf
>     will fail if the updated extensions require more memory, which
>     indicates the update image is not compatible.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
