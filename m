Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635636;
	b=kcAqqH/vBWtI37mxs+/F+YKM7eD3Be8mMaNkCm+VEpqOWZrsAAYBmLAkWiS6qpdP9QIb
	 MWjHFzECwoCq9UpqKoVExaDRXpmBV18lDX31IIr/W08X7Q89lZYTANGtWZMeTKTHTQ1wL
	 R8s21LfWQ9nYSOa38l+1KDoWksGaiphYHeGcx5xHKAjr6GkurhCTdZROU1sY62mhhIWhV
	 dGM0q6F+v9iTdLacqSvLqRWg7/koXYlhaw+jIEmxm+lHcPxDL/VfSqMj/h2No0rdfXG+D
	 u9s4dn2KJM18ZUP64Q9Nl/4Bg+SONBVXKc5gBLc6ouasqHPmj3mdR6BraoZ3JxD2QKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635636;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gRgsvRbmzx9WhUVzRKlapA61VEA/n0x8CCdbVbELBuE=;
	b=ciBAAcpJULL6PTBVI5QHt5xmrE8a+NLLhmWM4YL87bSiGcSiCPg1Llx5ve9EanpwZmHB
	 g6SyeGIJSHI+V0U7D16C/0H89eT6dNga2NSNM7pMCd87KLE4NIgJf+zkpYv9njkVeMiKo
	 p1WuMnfRnTTcpbQV+ClqnrvK6qsluQKKni0kd/waBsAatCtc7wAqEBLGYD0jz636mpbzv
	 NHodGKVERWfmUxPeJazbjgdpgbGyKJn0XFcnUuDrlt3mwM8mJ/LIfLH/Lu6wLhs3Y6RtD
	 e4cdUqpuRXOQBDjvX1lVYoIdJTeV6dcMj5HiTdorgZFRL8JPkHar278Otfj8lDeb48g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GdMmP9qA;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71E606A31B;
	Thu, 22 Oct 2026 02:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB71E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GdMmP9qA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792635636; x=1824171636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xYMCFXnTAz0M+rlOpJnTWLxwklR/oq1vvWcReqauUHo=;
  b=GdMmP9qAa9g4Dv5WdHbg/wmNDa5YnzUVPsI/ZS6PRLxewMrTCXqU74+K
   Z6iJxRG4w/brl/Y+aEZsKBwecqyWAlb3o4T1x8qEvGeA9y2B7qEO4V0W+
   8Uabkagy/arwg9ji5cvtkZa+KH/WTs2bmB57NYZ+p02rN1S+pvsqYaS73
   zA4XxZOThZFFq/28iH6Mq9HTNdZbW0pRlpsEX6VBgQW5uSgUJsqROUbHT
   D4kv3ve1EpS7x/rJ5oLlCfJAkzEfPqbIlx0yXUsxfEt3cgizishbY8hi7
   EG+Dto61r2WFWvzGesjkys7ITCIbrQJhfjkei9uezim9JyP61+a0qsRN1
   w==;
X-CSE-ConnectionGUID: vAlc43eCT/2UslbgtqW8kw==
X-CSE-MsgGUID: go3ZqPZvQD29PtnsO3gmNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1274621"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1274621"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 19:20:35 -0700
X-CSE-ConnectionGUID: TXHai4yBQ/6Qr8RZ1DQMhw==
X-CSE-MsgGUID: NsM/tIH7QM6C/EK52GLUqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3723991"
Received: from unknown (HELO [10.238.0.148]) ([10.238.0.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 19:20:31 -0700
Message-ID: <cdfefb02-acb0-4890-80a6-19036f03ea3e@linux.intel.com>
Date: Thu, 22 Oct 2026 10:20:29 +0800
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
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "Maloor, Kishen" <kishen.maloor@intel.com>,
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
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <b196cf9f65fe1e52aba7b867b7c2687c40caa337.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/2026 1:19 AM, Edgecombe, Rick P wrote:
> On Wed, 2026-10-21 at 10:15 +0800, Binbin Wu wrote:
>> On 10/21/2026 8:39 AM, Edgecombe, Rick P wrote:
>>> On Fri, 2026-10-16 at 17:14 +0800, Binbin Wu wrote:
>>>> Note, the change is user-visible, as some bits that were previously
>>>> reported as configurable no longer are.  The ABI itself is unchanged: KVM
>>>> already filtered unsupported CPUID bits out of KVM_TDX_CAPABILITIES, albeit
>>>> via a denylist, and the set of configurable bits already varies with the
>>>> TDX module and KVM versions.
>>>
>>> I'm not sure what this is saying, the change is user visible but there is no ABI
>>> change? Can't be both... so I think there is an ABI change.
>>
>> My understanding is KVM_TDX_CAPABILITIES reports the capabilities supported by
>> the TDX module *and* KVM, this is not changed before and after this patch series.
>> ABI-wise, I think userspace doesn't care how KVM do the filter, denylist-based or
>> allowlist-based. The ABI requires userspace to consult KVM_TDX_CAPABILITIES, and
>> what KVM_TDX_CAPABILITIES report can be changed. That's why I described the ABI
>> itself didn't change.
> 
> My model is that ABI is the user visible behavior of the kernel. So if you are
> running a kernel on a machine, and upgrade the kernel, then the behavior changes
> for your (potentially misguided) userspace. That is still an ABI change.
> 
> I think you are thinking about it like a spec - that if the new behavior
> conforms to the spec, it is not an ABI change. I think it's not right.
> 
>>
>> How about simply noting that this is a user-visible change and dropping the ABI
>> part to avoid any ambiguity about the scope of the ABI?
> 
> Eh, if you want. I'm ok as long as we don't declare there is no ABI change. And
> then the patch ends up breaking userspace with a log saying no ABI change
> because of the docs. It could come off wrong.
> 
> We are making a potentially breaking change here that we think won't impact any
> users. It's a sensitive thing.

Rick sent me a link about the discussions on "what ABI is".
https://lore.kernel.org/lkml/alpine.LFD.2.00.0812011210030.3256@nehalem.linux-foundation.org/

I will rephrase it in the next version as following:

Note, this is an ABI change, as some bits that were previously reported as
configurable no longer are.  However, the semantics of
KVM_TDX_CAPABILITIES are unchanged: KVM already filtered unsupported bits
out of KVM_TDX_CAPABILITIES, albeit via a denylist, and the set of
reported bits already varies with the TDX module and KVM versions, i.e.
userspace can't assume a fixed set.

