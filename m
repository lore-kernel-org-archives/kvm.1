Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762133D47AE;
	Fri, 20 Mar 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028303; cv=none; b=hyxStgJd0Wf2lK2t2krti4WpKm7FCyZBhjBtP40EOHqjYFexkNlJO5McPlJngcdBKe+Jc88I29D9TIcubygE+PMctqroPpCjBPi0Pt6KI1jqkGT9g2U7MdWfK8//Tck25TvUjGwSBLwc19+NwZn+LefIoDvrb32lRKibJ3zQT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028303; c=relaxed/simple;
	bh=ppN1pcijQS5lCkx1/zvJhvMeWfiX6dzR3kQZB5HVrvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC5AV3Qaex2hjZXam0SvJXoWHz2ZUptZ5PkIEaBKzaN6O/7ovO5svd9O4PZUF+RS5ftzHPE4D0XPC4Oyami+iet8TYjSqYJu8YSXJTnkDK5ZI4sGF/VSOZgY7msFsE0INtwGvanZFfLlo4Q1ojIdPSIM1UqA6xEhcKuG8ZsJGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UX1dFMNg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UX1dFMNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774028300; x=1805564300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ppN1pcijQS5lCkx1/zvJhvMeWfiX6dzR3kQZB5HVrvw=;
  b=UX1dFMNg6OcWhHtRcusBexa36QAfeBX1F0PQdRetQVAN1dGKkJRu3jxN
   MLvqSYHu9UZWIxTyeC7Wgcd4MiSw2NiA81RUb9L2YKxgIM/a8+OT0LDVm
   GIpow+3zNPT3cI+brs6dbaDz9igZnAG95/tR2vP22TmLTgXABzpDU7Pbr
   KKBDeZPM0pEJXxvP71DMX7trN1MaLbmRPyTbkQsEHjHudcMN4mgMjhmcH
   UaWmoCwoVMsgvlYw4rSJ4FHlAP7Sb/c3Ur3fApfYgGZFAdkQDZ4oMc2cl
   Kib52t3TSLZFo2KOewnrKcvqLU76MaLQWsapynaWt9aVNBMYwDR2fOjok
   A==;
X-CSE-ConnectionGUID: Mwtef2lzT0GOYaP6GRXP7g==
X-CSE-MsgGUID: xcRYcVRLQHSTEcq4zShXHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="79024068"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="79024068"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:38:19 -0700
X-CSE-ConnectionGUID: hgi0J7GmReqfDbRWOQfZWg==
X-CSE-MsgGUID: qo1T3zduR3WkSNP86jYu6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="228286340"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.109]) ([10.125.109.109])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:38:18 -0700
Message-ID: <c8c15f0c-6fd4-4a1f-98c3-58467b46afe2@intel.com>
Date: Fri, 20 Mar 2026 10:38:16 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kas@kernel.org" <kas@kernel.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
 <seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "Annapurve, Vishal" <vannapurve@google.com>,
 "sagis@google.com" <sagis@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005703.8983-1-yan.y.zhao@intel.com> <abvR2A19S4ZtpAli@thinkstation>
 <abvlOcnY4assk8DW@yzhao56-desk.sh.intel.com> <abvxiuJfK2eM_1UX@thinkstation>
 <e3acc801e4e939a0a4794ba777e72f26b27af0d2.camel@intel.com>
 <ab1EcZ3G_Nc-929X@thinkstation>
 <d614658f2d1f3213b0d8ed404c51b3c4bfbe5d7d.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <d614658f2d1f3213b0d8ed404c51b3c4bfbe5d7d.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 10:31, Edgecombe, Rick P wrote:
> On Fri, 2026-03-20 at 12:59 +0000, Kiryl Shutsemau wrote:
>>> I feel like we argued about this before. But it would be more correct to
>>> just drop level and make it 4k only until huge pages? Otherwise we are
>>> tweaking dead behavior.
>> I guess. But you add one more thing on the list to remember when adding
>> huge page support. This kind of stuff is easy to miss.
> I guess I'm fine either way. I'm not sure Dave will like adding dead branches
> though. I suppose huge pages is close enough that we are looking to merge prep
> work anyway.

Can we add something that will BUG_ON() or fail to compile when the huge
page support comes around?

I'd much rather have:

	BUG_ON(level != PG_LEVEL_4K);
	tdx_clflush_pfn(pfn);

That go implementing a level argument to tdx_clflush_pfn() now. Then
nobody has to remember. The list to remember is in the code.
