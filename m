Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5030E82D;
	Wed, 23 Sep 2026 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126234; cv=none; b=Ij9DRRvfPncyhGC4GMAOyMDHNo/I8MwDDNWqDhJiWHnLets1izKm9pLXKmJoDlMXi73EISbDNp1cL27jDNRW+3oxARdJtIvF6HO8T4pPxm8uJR2priRxmjp2zLOe2t8iGLSWU/udY9MdKCcc0TG3ucjblJTZAcaoa9lMIoXgNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126234; c=relaxed/simple;
	bh=rISwRDfIka2ykQycQxwOWFfGe9m5G7fX1PQYgwLwS+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aL3V+MoUfxzNRIuFKjfHF7Wd20gG3+Wos55GF/TtapQbWhsZ5fseP5Q/lcDZtM0jGZCEtIVSCwvAIOUm309Lp+rb7dHfUDiUPWeN5bvHTeaO4X2LLbC/dORVbkITFJ2h/RTfbHKEBdqmTWanQ3452h5upVHL33rfE9nJkt646mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxXSPjG7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxXSPjG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790126232; x=1821662232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rISwRDfIka2ykQycQxwOWFfGe9m5G7fX1PQYgwLwS+g=;
  b=mxXSPjG7aUKk+qVddaaVCxAmGRuF/2dljnO7y1zJyHm4n52IxG2uZ8ct
   FQ7xk7DKFY6OAlBviLbWYUMwXY+rbcFgW0NKMqHJ4q8xX3FJP8+jMpQ2S
   YSBaQdfexAL2nM1BwV3jpGXFvnfjE5qzJkpaAFIioTjqPDXJYGOmJSq+J
   7FhGA/1mIT0YJcbGs57/UO/bVszUJFFTOFCUEiMEebCiPXciS0fua+JKb
   4h1KUIyXhhDoDIiBCTYDNyxBHZv3uo/GHkbNbn7oagPeImxgpBX+e4auF
   VQrhePTvMfPZZnxACvMUa9xIH7zUFPpqcYO6Bbh4w+EjnnbPMScOWJCPQ
   A==;
X-CSE-ConnectionGUID: NEZOAbjlQ4e5fQGdHyjglw==
X-CSE-MsgGUID: B810Pr0EQ/+0LMuVjx1iCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90893282"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90893282"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 18:17:11 -0700
X-CSE-ConnectionGUID: G3+vdjSDTIKGG05c/kqT+Q==
X-CSE-MsgGUID: Sea6fTbRRU+iGsy7ttEHww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="273566513"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 18:17:07 -0700
Message-ID: <ddba739a-b4b5-4c0f-84f1-803857f34179@linux.intel.com>
Date: Wed, 23 Sep 2026 09:17:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "Maloor, Kishen" <kishen.maloor@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
 <a8ce5d830a04d99ec47cdc727e1761bd4031d544.camel@intel.com>
 <5ff81fc4-d144-4b2b-8375-d2f63e0dd618@linux.intel.com>
 <419b23f264af219da3be93a9d246b5401bbbaf13.camel@intel.com>
 <a436a059-b003-4e84-bd11-014bf2f17e97@linux.intel.com>
 <5168e058946a61f3be1cdb13f886dd632739d312.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <5168e058946a61f3be1cdb13f886dd632739d312.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/2026 9:09 AM, Edgecombe, Rick P wrote:
> On Wed, 2026-09-23 at 08:57 +0800, Binbin Wu wrote:
>>> But directly configurable bits don't have any direct conntion to tdcall
>>> queried bits. Userspace can still set those to whatever it wants regardless
>>> of the allow list. 
>>
>> I didn't quite get this.
> 
> VE bits don't query the directly configurable bits in any case unless userspace
> sets it up that way. So they are not involved in the problem we are trying to
> fix here.
> 
>>
>>>
>>> So the argument is basically there is not expected to be any reason to allow
>>> them, so save the code in the allow list. It's a "there is no point" reason.
>>> Makes sense, but I couldn't get that from explanation.
>>
>> I think "not just save the code"?
>> One argument is that if these bits are reported as allowed to userspace and
>> userspace enabled them during init, and the guest doesn't opt-in the #VE
>> reduction (KVM doesn't know the real setting), it would cause problem in the
>> guest.
> 
> Userspace is allowed to cause problems to the guest. We shouldn't try to prevent
> it. 

But userspace doesn't know these bits are not supported by TDX module and KVM.
If KVM report them as supported, and it causes problems, we cannot say it's
userspace's fault.

> But here, I think we are saving lines of allowlist in preventing it. So the
> reason is to have less allow list lines, not to help userspace. And that is
> worth it IMO.

