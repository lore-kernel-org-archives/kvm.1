Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741349;
	b=jIos8IJSZHy+TCBRXcycrew23tg5/vU0ZEaGSoGzTlRwj9g+EuoSIjcDSedY70By0Aj/
	 qp2ogUKtLc8OjLHtHQJG+ocuvc14/srASm2JFH9wpJrW2XBbPlG3uwKWMWi4qfCCfAnDm
	 tgiNR+P7RROUmqRNIFNgNLEjBDjN9JRI5adetgnY1CBtB6RbJwIXXrJON2ZqeRPRcp4gQ
	 I5HKT4PPB/3HLpHNbJt4XlNFCB8pKT25wXlnN9b0R0rzYkHegO0BALQUiiVtsTVyFhBvI
	 02a4MGJEyddd+uoZWFT2XrXRbyNF1hj9hhmjtl2UslKpL3cbEYQ1bpyX8h2/mRzSHqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741349;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FryCPV6dFhaNBS2FzHkvnox8LzXstJsdfMOSMM+Al5Q=;
	b=mZOfLHMmehgHLmGMSzZQH8NsTuw8kDOQvli0IbE8+O+q7Tpzq+eX8D7AkbJmWO3tSkK/
	 MZMvno/8PAVbnLg0VwM8tE8ZXXgXQPceMCE3oOG4SzIC/kyX/MrVzdx4PhCEusDUBen2/
	 J5JnaBzLcFDEYy1+Wl3/xqJWvcgkLZ6bq5SB/hAfMsf8SYM5U1Wh4CDN0Hfj9Ise+Vo1s
	 pbObNiXbcTP80jMjqG0CsdEONchdfdXbciIimsZ2LrIUP7finvoexPkGwX+zQpNPG+yp+
	 CAafCrRryD4NboBp86cCNeukV5tfsAqmotm/rGgheG9UWQQ7FvXbMW22wSnxD755vnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IFmBaHQF;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C19606A31A;
	Fri, 23 Oct 2026 07:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8C19606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IFmBaHQF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792741349; x=1824277349;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xuijno0Bdbu0DND06k74jWdZLj1aF9+y13Pr7DMHy9U=;
  b=IFmBaHQFzKRNbsiI0AMiMm6FHZuJ3uinzgdFjameB/X5mPAKCbpOX4s6
   mbieSUKQeodL9YRFn0F4IL/vXF0O0YdsqPNLHVyGNj4q0XRllPDfWz3R+
   YOHnf5a3M+5+X4Hyjv1WCQu1AqATzPfuow46ESiWzYZ6ZyTuQ/xXm8AVE
   wur8mJWBECrBMff7kwZJp+GwSuEUhBQbQKxpH32PkWFJkZr45st4S2zhp
   zWBMKBRqJTR5c/MbnDICPPzCpqDb1SClVEShhO8v0ORl8/yC3xheOVy4m
   8tSAbRDNCmwAgl3KngWausXNPmtSrMSHd4C2XcVOGdpTQwqIBhqFAXZ4p
   g==;
X-CSE-ConnectionGUID: /XGwlVfAQRS6FifhgXgLJg==
X-CSE-MsgGUID: oerb6HMlRM6zplVPa2b8Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1505637"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1505637"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:42:28 -0700
X-CSE-ConnectionGUID: AP0gb5XxSp2jrgSbI4CJxA==
X-CSE-MsgGUID: UwVA0tSdQ6aiQXJHPaGCsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3947445"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.140]) ([10.124.240.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:42:25 -0700
Message-ID: <e6f1608b-4096-45b7-959f-26829e1e23c6@intel.com>
Date: Fri, 23 Oct 2026 15:42:21 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] KVM: TDX: Report only KVM-allowed CPUIDs in
 KVM_TDX_CAPABILITIES
To: Binbin Wu <binbin.wu@linux.intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "dedekind1@gmail.com"
 <dedekind1@gmail.com>, "Maloor, Kishen" <kishen.maloor@intel.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-5-binbin.wu@linux.intel.com>
 <b69f075f475bb8c09c74cff621ae23f76da50795.camel@intel.com>
 <2bc913d2-4286-4484-a872-3266326db0a5@linux.intel.com>
 <b196cf9f65fe1e52aba7b867b7c2687c40caa337.camel@intel.com>
 <cdfefb02-acb0-4890-80a6-19036f03ea3e@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <cdfefb02-acb0-4890-80a6-19036f03ea3e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/2026 10:20 AM, Binbin Wu wrote:
> On 10/22/2026 1:19 AM, Edgecombe, Rick P wrote:
>> On Wed, 2026-10-21 at 10:15 +0800, Binbin Wu wrote:
>>> On 10/21/2026 8:39 AM, Edgecombe, Rick P wrote:
>>>> On Fri, 2026-10-16 at 17:14 +0800, Binbin Wu wrote:
>>>>> Note, the change is user-visible, as some bits that were previously
>>>>> reported as configurable no longer are.  The ABI itself is unchanged: KVM
>>>>> already filtered unsupported CPUID bits out of KVM_TDX_CAPABILITIES, albeit
>>>>> via a denylist, and the set of configurable bits already varies with the
>>>>> TDX module and KVM versions.
>>>>
>>>> I'm not sure what this is saying, the change is user visible but there is no ABI
>>>> change? Can't be both... so I think there is an ABI change.
>>>
>>> My understanding is KVM_TDX_CAPABILITIES reports the capabilities supported by
>>> the TDX module *and* KVM, this is not changed before and after this patch series.
>>> ABI-wise, I think userspace doesn't care how KVM do the filter, denylist-based or
>>> allowlist-based. The ABI requires userspace to consult KVM_TDX_CAPABILITIES, and
>>> what KVM_TDX_CAPABILITIES report can be changed. That's why I described the ABI
>>> itself didn't change.
>>
>> My model is that ABI is the user visible behavior of the kernel. So if you are
>> running a kernel on a machine, and upgrade the kernel, then the behavior changes
>> for your (potentially misguided) userspace. That is still an ABI change.
>>
>> I think you are thinking about it like a spec - that if the new behavior
>> conforms to the spec, it is not an ABI change. I think it's not right.
>>
>>>
>>> How about simply noting that this is a user-visible change and dropping the ABI
>>> part to avoid any ambiguity about the scope of the ABI?
>>
>> Eh, if you want. I'm ok as long as we don't declare there is no ABI change. And
>> then the patch ends up breaking userspace with a log saying no ABI change
>> because of the docs. It could come off wrong.
>>
>> We are making a potentially breaking change here that we think won't impact any
>> users. It's a sensitive thing.
> 
> Rick sent me a link about the discussions on "what ABI is".
> https://lore.kernel.org/lkml/alpine.LFD.2.00.0812011210030.3256@nehalem.linux-foundation.org/
> 
> I will rephrase it in the next version as following:
> 
> Note, this is an ABI change, as some bits that were previously reported as
> configurable no longer are.  However, the semantics of
> KVM_TDX_CAPABILITIES are unchanged: KVM already filtered unsupported bits
> out of KVM_TDX_CAPABILITIES, albeit via a denylist, and the set of
> reported bits already varies with the TDX module and KVM versions, i.e.
> userspace can't assume a fixed set.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
