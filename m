Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77EB3F166C;
	Tue, 31 Mar 2026 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952734; cv=none; b=NeGsiKnpF8HqCLgFQ9bnbWV1t2r7g+it3B6Pxp7LW8kwKq7XApqhGfwxeZulMXjY3sZ3VceQFMaG/eZOGBtsZqxcHPc1ROCEhBy3PAM/JVQsXD+fyeZOuVs1quyuNCNJEzZg+LYtEPpazpl+pUSwQ3Tpu+chmWEeW8My39I0Mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952734; c=relaxed/simple;
	bh=MWxD5Xud8PaQBgEl6/Iq/BRIAtIx2Iez6G4dgjXjk8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD7Pkvug9qAKxjX5JMWwdMEWeI1FPVRl2MLn33OlRZNAsbm21todsKLdgFG7+NZ6kAtG3ZGIOvfdEs/7M/r4WgOqnCj1UiDEu/Ck9csWSr3JEhNJF6IjjmLzntsJg7L+JPr7AxyBfs/p/wsW2xJlRs0NmbKzCLp3XwADYkMok28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqAYG12Y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqAYG12Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774952733; x=1806488733;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MWxD5Xud8PaQBgEl6/Iq/BRIAtIx2Iez6G4dgjXjk8c=;
  b=FqAYG12Ye+ctlUbyDhJKj+oiIqEN7EGhXewr8PEnMVpgm3IAe+kIFYN1
   oRJajDjGNK3AqQBD761b8BC+JqtjR4bhETQIg6wsMfPp2ibaQOdsYQMpn
   XrMWbEsqE9ZzURiaEdw+DWx1Vme8MTvvilszkCIO8lYer9l6uuJ37wgYP
   O4+BpOh80Ol9NmOLbshb6ZK2tGtscMa1dYC77+gRYZZrVvo+EVM2MCcoy
   6HIbNJER9me/8T138nZ8XwcMooIIUSAKL5TND9mCwtdbh/v6rquuqZQPY
   85z+FvTHSbQ2d820bSBJs9ePQ5frAsVgpv/89iK30+uVU1mLb4+ns6KI1
   Q==;
X-CSE-ConnectionGUID: nvfMS2HSQW2gIL6A1MwPBw==
X-CSE-MsgGUID: +rAj18jJTCCZPZXN7U4Q2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93348673"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="93348673"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:25:33 -0700
X-CSE-ConnectionGUID: nyYvKD0YQhWBLeGY0Hx2IQ==
X-CSE-MsgGUID: iyOAf8RtTXyVfKGA1VNvtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="223445893"
Received: from unknown (HELO [10.239.158.60]) ([10.239.158.60])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:25:27 -0700
Message-ID: <67d66d1b-8ff9-4ca8-914b-1c9d57fd892c@intel.com>
Date: Tue, 31 Mar 2026 18:25:23 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/22] x86/virt/seamldr: Add a helper to retrieve
 P-SEAMLDR information
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com,
 kas@kernel.org, nik.borisov@suse.com, paulmck@kernel.org,
 pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com,
 sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com,
 vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-6-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260326084448.29947-6-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/26/2026 4:43 PM, Chao Gao wrote:
> P-SEAMLDR returns its information such as version number, in response to
> the SEAMLDR.INFO SEAMCALL.
> 
> This information is useful for userspace. For example, the admin can decide
> which TDX module versions are compatible with the P-SEAMLDR according to
> the P-SEAMLDR version.
> 
> Add a helper to retrieve P-SEAMLDR information in preparation for
> exposing P-SEAMLDR version and other necessary information to userspace.
> Export the new kAPI for use by tdx-host.ko.
> 
> Note that there are two distinct P-SEAMLDR APIs with similar names:
> 
>    SEAMLDR.INFO: Returns a SEAMLDR_INFO structure containing SEAMLDR
>                  information such as version and remaining updates.
> 
>    SEAMLDR.SEAMINFO: Returns a SEAMLDR_SEAMINFO structure containing SEAM
>                      and system information such as Convertible Memory
> 		    Regions (CMRs) and number of CPUs and sockets.
> 
> The former is used here.
> 
> For details, see "Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
> Interface Specification" revision 343755-003.
> 
> Signed-off-by: Chao Gao<chao.gao@intel.com>
> Reviewed-by: Kai Huang<kai.huang@intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta)<kas@kernel.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
