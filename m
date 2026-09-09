Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83863583ACC;
	Wed,  9 Sep 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971973; cv=none; b=Iw+Fv0BtODg8YK/LhTKDYrBJ5dLhxImAD1fC32MsHNJzf/WB9b6tOSuf7aPLitBQ+5a0kPcgG7cAahhDrkXONErWHJzWBzylKpD+CyGSYZAf+6PgJyJ/g7ML2MPtwIadgxzKMhkI/IeekW3ZGQKYJwGGWQiNYOMN6zVyIYpCfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971973; c=relaxed/simple;
	bh=obXuPcRvkWnzIqN2joo9otws3rNTJVbnzqTcEFBqsOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2zY82ecG+a7o312KHDC1QJWf+1/RFpDFGaVFfAbvTTLtRoIP5UZY5dFlEx1cCv2bHDeSE0W6XBCF4rgFegLTMJg88d0BAZ4bRYPVTsFqmqLbsDkEPtkNS6IiDJxCJdBWmtu0diRwXIwS4sF9GwJajk2KY1sHRfc3LIWWPrkOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2uq2HLz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2uq2HLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788971972; x=1820507972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=obXuPcRvkWnzIqN2joo9otws3rNTJVbnzqTcEFBqsOc=;
  b=b2uq2HLznKciKEpcZrnbxqOe94bmqm8kN8ZLa47uUrz/PgYW42SYok4/
   fdBlhn4rDjNWwM8AhoZZksGqzO20PY0T+OpGVrGrtdb85/AgxOm0l7eNu
   EbGl815/2+a6DReev/KXO9GGkmVPOOcDs11bYDr54AcjgCk6Uba83JI9e
   UP+tXUamKQq2joLlD7+ocL3BD5vOCQy9afXD8v8yAKrYTnKAceYFpnEha
   RlFFvr5PuSbW9NAcO2VgCczLv4R4tbp5wQa0ueBDeNqhtDPSWgrUFlctk
   6heLyM/UtXm+oc3ieiSFdsMENBOdAO+U1A/HkjXWXcSUPRZXRHmoZ2YeA
   Q==;
X-CSE-ConnectionGUID: 0vG9qwnAQwq4d1ePdZPkCA==
X-CSE-MsgGUID: Fw8+/4U1QKOFmbWnkAmnQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100568508"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="100568508"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:39:31 -0700
X-CSE-ConnectionGUID: HabaXO0NQt61xU7HEnWKBQ==
X-CSE-MsgGUID: Qk+eQ6riTfqE8EPsCXm74g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="273343716"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:39:28 -0700
Message-ID: <9abeed40-bcdc-48d9-8cbb-cb87154bb9f6@intel.com>
Date: Thu, 10 Sep 2026 00:39:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Cc: "kas@kernel.org" <kas@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "seanjc@google.com" <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
 <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
 <d8012e9acbe3c733b082c87fdbe9f229a8f7750c.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d8012e9acbe3c733b082c87fdbe9f229a8f7750c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/2026 5:13 AM, Edgecombe, Rick P wrote:
>>>> In the end, they might be disallowed to be configured to TDs because KVM
>>>> doesn't allow them for VMX VMs. This is also the point I want to discuss.
>>>> Do we really want to make such restriction that KVM cannot enable/allow a
>>>> feature for TDs unless KVM first enables/allows it for VMX VMs? What's
>>>> reason behind it?
>>> Sean mentioned it that "generally speaking, KVM shouldn't allow features
>>> that KVM doesn't support for non-TDX VMs" in
>>> https://lore.kernel.org/kvm/aj1fi_0SBxMK5WOB@google.com/
>> For existing features, it might make some sense. But for new features, I
>> don't think so. It defines the enabling order for new features that we must
>> enable a feature for non-TDX VMs first and then TDs. And people might want
>> to bypass this rule by abusing the TDX_CFG_EXTRA_F() when only one line of
>> TDX_CFG_EXTRA_F() is enough to enable a feature for TDs but more effort
>> required to enable it for non-TDX VMs.
>>
>> Maybe I miss somthing. I would like to see stronger reasons for such decision.
> I think "generally speaking" means, it's not a hard rule.
> 
> As for why to prefer it, I think we would normally want regulars VMs and TDs to
> work similarly. Especially those that have some of the virtualization handled by
> KVM. But TDX module's behavior of a feature can conform to KVM's only if KVM's
> already exists. Take for example split lock detection. The normal VM KVM support
> initially went through several iterations of design. Separately, TDX ended up
> with a different solution. Imagine if we had enabled the TDX arch one, before
> solving the general KVM problems. Then we would end up with two different
> behaviors, or a worse KVM behavior as it tries to conform to TDX module's
> behavior.
> 
> So we need to at least solve a feature at that level before deciding KVM's
> handling of it. This could be done while enabling the feature for TDX only, but
> often would involve solving the problems for normal VMs too. In the end, it's
> the generic KVM behavior that needs to be solved before enabling the feature.
> 
> Ideally we could consider normal VM and TD at the same time. I expect we will
> start doing that after this series is in place. Not a hard rule, but a norm.

I don't think "split lock detection" is a good example. We are discussing
virtualizing a feature, or allowing a feature to be exposed to non-TDX and TDX
guests. While "split lock detection" is not a virtualizable feature and how KVM
handles it is all about how KVM fixes the architectural flaw of it.

Generally, I agree with your point that we need to think at higher level before
KVM deciding to support virtualizing a feature. But after the generic level
consideration is done, there can be different orders:

1. allow a feature for non-TDX VMs and TDs at same time. i.e., in one patch or
in a single series.

2. allow a feature for non-TDX VMs first and then TDs. This can be due to by
that time TDX's spec for the feature has not been defined/finalized.

3. allow a feature for TDs first and then non-TDX VMs. This can be due to it
requires more effort/patches to support virtualizing a feature for non-TDX VMs.

Usually allowing a feature for TDs requires far less efforts than for non-TDX
VMs, because most of the virtualization work is done by TDX module. E.g., for
TDs, KVM usually only needs to add code to restore the host states that are not
restored by TDX module. However for non-TDX VMs, KVM needs to do more: emulate
the architectural behavior of the MSRs, context switch states, and the nested
handling, etc. It's likely that a series to enable a feature for non-TDX VMs
spends several Linux releases to finally get merged. Making TDX support depends
on it seems not that necessary.
