Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37949F139;
	Wed,  2 Sep 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358876; cv=none; b=HCFZTNa69aserl1xq5Aab+fDJNHvc4YcS6Grj9AjmR/YbmJAnlRrCjnxZ0vOzAMrXrA9JOQ8UkUCLczU8tn0qIp3VUOFjSoJK7B9gLTz7teEQBYw8Y7cZP2SNiEC8L84OxWt6gqyogPHuAjUFXGXG+XcmKuw1O+XP6Ixo1heBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358876; c=relaxed/simple;
	bh=m0rLce1W79fRe2ou3Um2VrL9VM0GPMQCnQDCJzPqdZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6ZiK/NWaLLmJeYL3kzDzBOIyk6bdj+KdtE1yLwm847jugsX2a8HQcPwpVA6lnG1ZoEZJLNLHwBzry+eR9KSCCcMUOhsfnvMv8mzuJF/YoN0p6V0q7vufv+ihuSGRqe8UY3UwwrtpB/iTXmBLv5yqnJTkKDaRdt8PIBQB2Rv1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2UOWWO3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2UOWWO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788358874; x=1819894874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m0rLce1W79fRe2ou3Um2VrL9VM0GPMQCnQDCJzPqdZw=;
  b=B2UOWWO3u71Hd56U9OU3IzYm0JlOgiKI0fEdRBKtqBfrOWmjTbnNNeYu
   gbvbta/8OG8wQbxXSIIcN7SwsZbtzm2cXlv0CpTuujtR/uhm4U1q3UTRb
   x9XbPZKNAv8RIy0VUtWSSYvW4SPbiaSBQcnrSqzs+agOfi/bzXdrc7k6D
   LjIoSe75ayilQnxWNyPVlIt+2QRMG7dfwxmcizUp1ABrw7D5kafYD4Cs0
   XFSyPlaPQcoSNRoHraU7ddJsANoukkpj7e4h+UziGMcOSyV2uRiYhsv5b
   eQS80fsGwPyYfejIxeluRS4hwtsBOAZAY1APL41KAQ7Iy94NvYV2NL3G7
   w==;
X-CSE-ConnectionGUID: JFGRhhWVT/6AIu+qHDk0KQ==
X-CSE-MsgGUID: rKrEdcBJQt666TLQpRM6JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88841761"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88841761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 07:21:13 -0700
X-CSE-ConnectionGUID: DuJU3tPlSkShLdxIqeN4LA==
X-CSE-MsgGUID: us+kolL+RUuA6XEsNqfUmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="294276987"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 07:21:11 -0700
Message-ID: <eb6e479a-409a-4111-b531-47af967d7989@intel.com>
Date: Wed, 2 Sep 2026 22:21:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
 <6f8f2c59-3336-4ed8-837f-57cb706ece30@intel.com>
 <69c42183261acb4150961cabf6318b92765b6562.camel@intel.com>
 <91c9e314-6b92-4f90-a2df-ed21104f84bc@intel.com>
 <e4b9509c4e4b91277a30f88cb7ca76c8ba016997.camel@intel.com>
 <f4594d40-cc15-41c8-99f1-2db590bba2ef@intel.com>
 <9920cbdf0f5f0114fba0e1eb2bb2931c249e9c41.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <9920cbdf0f5f0114fba0e1eb2bb2931c249e9c41.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/2026 9:53 PM, Edgecombe, Rick P wrote:
> On Wed, 2026-09-02 at 21:39 +0800, Xiaoyao Li wrote:
>>> I don't think they have agreed to it yet (Binbin?), but I think it mostly
>>> works this way already. Why do you think it is a burden on TDX module
>>> developers?
>>
>> Because it can bring confusion to TDX module developers. VM_EXIT_LOAD_XXX
>> control is used by SEAM VMCS to load states for TDX module execution context.
>> And I think for most features SEAM VMCS doesn't set it (I don't check it
>> though).
>>
>> SEAMCALL is kind of a VM exit, and SEAMRET is kind of a VM entry. To
>> automatically save and restore the host state, what TDX needs are
>> VM_EXIT_SAVE_XXX, VM_ENTRY_LOAD_XXX, and vmcs guest state for XXX.
> 
> I'd think we could avoid adding options for configuration that won't be used. If
> we did have a clobber control interface, matching VMX bits is an interesting
> idea.
> 
> I'm a bit torn between wanting to fix the area once and for all with a full
> solution, and wanting to get this increasingly blocking CPUID bit fix in. 

> I'm
> leaning towards just do the bit filtering and give the save/restore guidelines.

I agree.

I always believe the bit filtering introduced by this series makes KVM
safer and it's anyway useful, while how TDX/TDX module save/restore host
states can be another separate topic.

> Then we can do a save/restore control later if we find the guidelines are not
> sufficient.

