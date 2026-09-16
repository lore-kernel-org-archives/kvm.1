Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5602356754;
	Wed, 16 Sep 2026 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535866; cv=none; b=cmv1pjmLmqQFtpNBkXxhNwp907412M0wzF5N4Ax4S9oKNeLhD7Iv0gl2+SywuhWR8p1ZSPuVpeiawN1frNoHQAZl5yZpN6N46MTDgmdMAl6LOI2QuejQ74MKENiUePN8c8reZ3WXDapinKuthpXL7u0n+o52suZMQ99G6ew8pNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535866; c=relaxed/simple;
	bh=QUu94teIx4TW3x6nbYKlORv1Ri6SBezqVAFqs1gpUZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LugLLTKqBuBZmXJgGw7iRVxZ+/q502d5pYsV5VnBMz4qvLgaOdXtVVAKxW2XZbWml0D4yZmGS7C0fXNxr7VgyqBxDJtv3TuBfDznWCQPnfuKjEfZ+k6RPaFP4nt3EzzZxfVjGQSj7fFEzQ7v0mtNPIZC0O0EIcv0G5v3xJmSwfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ps8zn5Mt; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ps8zn5Mt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789535864; x=1821071864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QUu94teIx4TW3x6nbYKlORv1Ri6SBezqVAFqs1gpUZU=;
  b=Ps8zn5MtujQ+DWVKDJHHoIDZ9+iu+Vke9dEqd7kWHuzSWVGycsp1a7tC
   qdf9ICSj6CNSbIAiWwKEx/uLdyaLGEihlXGuRXf3Z9rnJwXrUkKCAOCKo
   /ygvjp9kC2qhlL0UdQzIo+LzqnvUKhJniFMUedsvqCECf62h1XMlplOFW
   M4xnF/B3I/CNCLyWZKI/PaNo0bGJc+ju9RQNRDq7wmBPlPxXlRqmGhLNJ
   1YgD0/oe69uAbH6OQbGH1HWkg3biJ4aq+ZljwQVt079iQAIjuzzSoA+ci
   THdK049ykSv48MY+y92XAdBG7nl95XFUwQU2WVPzKVs+gt2jm0K+X0nUp
   w==;
X-CSE-ConnectionGUID: LiJBtV1cQpWaGL8rYf/1lw==
X-CSE-MsgGUID: IGX3E98tS0q69p+jIBYedg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="411276"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="411276"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 22:17:41 -0700
X-CSE-ConnectionGUID: frUvfdzMTPSc4HoPQQIhJA==
X-CSE-MsgGUID: coPjhrOMSg+EJ9PvaN/ueA==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 22:17:39 -0700
Message-ID: <c6ccc8a9-8699-4355-8148-c9b3b60e7419@linux.intel.com>
Date: Wed, 16 Sep 2026 13:17:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Xiaoyao Li <xiaoyao.li@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "seanjc@google.com" <seanjc@google.com>
Cc: "Gao, Chao" <chao.gao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
 <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
 <d8012e9acbe3c733b082c87fdbe9f229a8f7750c.camel@intel.com>
 <9abeed40-bcdc-48d9-8cbb-cb87154bb9f6@intel.com>
 <aqHdwkOFVR4XoS2M@google.com>
 <c967dc3eb6b128055e415bae45d1c14a52dc4acd.camel@intel.com>
 <94b3473c-7e44-4f6f-8721-b43ff4e2c423@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <94b3473c-7e44-4f6f-8721-b43ff4e2c423@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/2026 10:53 AM, Xiaoyao Li wrote:
> On 9/10/2026 7:18 AM, Edgecombe, Rick P wrote:
>> On Wed, 2026-09-09 at 15:29 -0700, Sean Christopherson wrote:
>>>   Yeah, *ideally* we'd magically enable everything everywhere all at once.  In
>>> reality, different VM types are going to support features at different times. 
>>> More importantly, as Xiaoyao points out below in #1, unless we enable
>>> everyting in a single patch, which is probably a terrible idea in most cases,
>>> we'll still end up with staged/progressive enabling, i.e. we still need to
>>> have patches that selectively enable and advertise a feature only for the VM
>>> types that actually support the feature.
>>>
>>> This is all quite similar to Intel and AMD feature enabling being done at
>>> different times.  The biggest difference is that Intel and AMD are mutually
>>> exclusive and so KVM_GET_SUPPORTED_CPUID always reports the correct
>>> information, but TDX already provides KVM_TDX_CAPABILITIES, so AFAICT we still
>>> get accurate reporting for TDX, just in a slightly different way.
>> I think this actually surfaces another problem with TD-first enabling.
>> KVM_TDX_CAPABILITIES only returns the directly configurable bits. Then recall,
>> KVM_TDX_GET_CPUID returns the actual TDX module's view of CPUID bits to
>> userspace. Then userspace calls KVM_SET_CPUID to actually put them on KVM's vcpu
>> so they can match between Qemu, KVM and TDX
>>
>> So if a bit is enabled for KVM_TDX_CAPABILITIES, but not yet in
>> KVM_GET_SUPPORTED_CPUID. How should userspace interpret KVM_GET_SUPPORTED_CPUID?
>> It can ignore it for TDX, but that is how it can find the PV bits today.>
>> If we have a TD first feature, it could be a documentation update on how to
>> interpret it. Or we could stuff the PV bits somewhere else for TDX and say to
>> ignore KVM_GET_SUPPORTED_CPUID for TDX. I think we don't need to solve it before
>> we begin filtering like this series has.
> 
> The PV bits reported in KVM_GET_SUPPORTED_CPUID are the bits supported for
> non-TDX VMs. Only some of them are actually supported for TDX. I would suggest
> reporting TDX supported PV CPUIDs in KVM_TDX_CAPABILITIES as well.

I would leave it as a separate task if we want to report the PV features more
accurately.

Currently, the CPUID bits reported by KVM_TDX_CAPABILITIES only serve the
purpose for enumeration of directly configurable CPUID bits and the userspace
VMM (e.g. QEMU) will follow the same structure and layout of the CPUIDs reported
to construct the input for KVM_TDX_INIT_VM.  If we report PV CPUIDs in
KVM_TDX_CAPABILITIES, these values in KVM_TDX_INIT_VM will be rejected by the
TDX module.

