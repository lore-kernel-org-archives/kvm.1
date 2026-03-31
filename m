Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4993CF034;
	Tue, 31 Mar 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950698; cv=none; b=pAKfga3jdmkBmQjyZsjyGmpbRtLFYpWs/LUN+jCdJpznbGCsJPe9wR7ug6S0sF8y3OK05z/8Xxqj8mJTmCf013kC7DCaL7LZ7ENWa84b2gS5YLSVAdszoLs0Zh04axHt+z7qVr/ZZMqZAp78HghdG4eZNgiY1MHD4TzJjiYTfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950698; c=relaxed/simple;
	bh=zC/XH9x3T6AByR7y3dQUQovxjNsWGhMtgeQ4cgnecIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVMTNbVGgTmY3UvL8YI18p9Hvlyt4aDTRi5w+61vUKExoNjWdJUi5KOeqx8AAoQUa5yk7jdrvqI3isLewlSQPJMshJCK5Fo3xdVXgWFwwq/RM35SIWILhFWqa1xu2wP+2YjNzbWe7izk0n41yhC1TovnjP2EBWr6iLpciRqifmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwnqXGcJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwnqXGcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774950696; x=1806486696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zC/XH9x3T6AByR7y3dQUQovxjNsWGhMtgeQ4cgnecIk=;
  b=NwnqXGcJ+fBQz7Yf+eTYiafH4Xv50A47BMsPHaucmoBSZMfh5IS1I7vl
   QLFnJzV+v5Pr2cSqM2gLLhzn2EviNMOJP8wEBZsEeG+cFdm/R999JfPOa
   kZ+ufJfwg9ExQubkX5g43rXNK7NrRxtEqEbmU1zFIIukCLmvZ6ehgxWfl
   WorMH6qDwGKt2heFvmjGDVFs9dXLbwjxn3QmuTCWgBzha8SLyqb5DosQH
   7IDTxPebwN+lzQC8HW/s0Kb3f5yEjEtsrkY1yuPFfdfPB9s2z5GP+vm8W
   +f22L5ugSghXjHUOA3byt/TLl1Ukk3wkAVjIuG9wQGZ3H9J/Y4Ntoa2ge
   w==;
X-CSE-ConnectionGUID: adBdAwzsShCZxWc3xpLM1Q==
X-CSE-MsgGUID: y/eOKUhUSjGtp8LyUG3U6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75975314"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75975314"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:51:35 -0700
X-CSE-ConnectionGUID: Ry+slhW2QHyMEuYdpyrX3w==
X-CSE-MsgGUID: 4hfr+qsHQ6WLJvNt1IOM/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="231133646"
Received: from unknown (HELO [10.239.158.60]) ([10.239.158.60])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:51:29 -0700
Message-ID: <b010e305-d558-43d3-92a1-25070364fbaf@intel.com>
Date: Tue, 31 Mar 2026 17:51:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/22] x86/virt/tdx: Move low level SEAMCALL helpers
 out of <asm/tdx.h>
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com,
 kas@kernel.org, nik.borisov@suse.com, paulmck@kernel.org,
 pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com,
 sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com,
 vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com,
 yan.y.zhao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-2-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260326084448.29947-2-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/2026 4:43 PM, Chao Gao wrote:
> From: Kai Huang <kai.huang@intel.com>
> 
> TDX host core code implements three seamcall*() helpers to make SEAMCALL
> to the TDX module.  Currently, they are implemented in <asm/tdx.h> and
> are exposed to other kernel code which includes <asm/tdx.h>.
> 
> However, other than the TDX host core, seamcall*() are not expected to
> be used by other kernel code directly.  For instance, for all SEAMCALLs
> that are used by KVM, the TDX host core exports a wrapper function for
> each of them.
> 
> Move seamcall*() and related code out of <asm/tdx.h> and make them only
> visible to TDX host core.
> 
> Since TDX host core tdx.c is already very heavy, don't put low level
> seamcall*() code there but to a new dedicated "seamcall_internal.h".  Also,
> currently tdx.c has seamcall_prerr*() helpers which additionally print
> error message when calling seamcall*() fails.  Move them to
> "seamcall_internal.h" as well. In such way all low level SEAMCALL helpers
> are in a dedicated place, which is much more readable.
> 
> Copy the copyright notice from the original files and consolidate the
> date ranges to:
> 
> 	Copyright (C) 2021-2023 Intel Corporation
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

[...]

> -static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
> -			   struct tdx_module_args *args)

Nit: Maybe take the chance to align the second line?
