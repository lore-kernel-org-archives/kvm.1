Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053AF34750D;
	Thu, 10 Sep 2026 02:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008790; cv=none; b=VSuic4AGozqH44kUT/cbSUBUZukpnwbR5zGefkAFqqM1487hshsOF3FulfxgZJHv7s95Q/smIoRyrMFC63wuR2I6n4CkrY+9flnDfPQ+kc43QoBlB5ryB/WYT780aaSiEb0lTmX4bAH3DvhfUm7aRU9wN4zpStwNsln9l6/GgX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008790; c=relaxed/simple;
	bh=ZNSDFcR9xZcUPah6kMHTbXLMt0r/jAU6wMb7+a+Agww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhYxfFvU/c4zc8DFzCbKYrM9Uz3EHDlEjqv/XY1XernBXPcIG5fVkgwpfO40bc8q9iaAbJkwOYU72vAmU2h9VqSpYxl0473b4NB1n5OsyWe7p0GcZoobBTFveh1u55ThfeRGD3NngbjvG8qR+A84j1pNdFMbMQHdY0CsVGC2qqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gETUZdRO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gETUZdRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789008789; x=1820544789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZNSDFcR9xZcUPah6kMHTbXLMt0r/jAU6wMb7+a+Agww=;
  b=gETUZdROQPaQSfIK69exQh9IhhwYYzMP5QfAWK0hGKeBfL2Ya8fcdq5b
   ilI30SziiH+VGdU3OlRp0USjzDPh9w4V6C2RWGoMpyUSfFpcCrPbQ7iql
   JIEUL9pT4h/xq8SHztGc//vmrD2rBP+bHfvr0pEzHuScgEJD/eIVpE9aY
   MNeOWNEKxYviQYTjRkp/fj7KkkTHVpq3kpl1yKR5Z8VzTPCLAPKTsWgc1
   uRz4Tw3OqpVomDMlqUgTVYQzJDbRBrYRPgdOSkI27eat8qu1FZ2Ohcc01
   7caNbtuBgQDgFKl9qvVepVkpPNJT8drfHIhLWl4V0cdpupX3c947ej1yV
   Q==;
X-CSE-ConnectionGUID: TayZ3JZgSpiX8jmdjBn6jg==
X-CSE-MsgGUID: 5AHybgb9Qu2JH5RAIdN2DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106818187"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="106818187"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 19:53:09 -0700
X-CSE-ConnectionGUID: entTxNr5TDCEv2YWLqXTjw==
X-CSE-MsgGUID: DrUr9IbpQpKwqWC2KM5Atg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="296459852"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 19:53:06 -0700
Message-ID: <94b3473c-7e44-4f6f-8721-b43ff4e2c423@intel.com>
Date: Thu, 10 Sep 2026 10:53:03 +0800
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
 "seanjc@google.com" <seanjc@google.com>
Cc: "Gao, Chao" <chao.gao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
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
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <c967dc3eb6b128055e415bae45d1c14a52dc4acd.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/2026 7:18 AM, Edgecombe, Rick P wrote:
> On Wed, 2026-09-09 at 15:29 -0700, Sean Christopherson wrote:
>>   Yeah, *ideally* we'd magically enable everything everywhere all at once.  In
>> reality, different VM types are going to support features at different times. 
>> More importantly, as Xiaoyao points out below in #1, unless we enable
>> everyting in a single patch, which is probably a terrible idea in most cases,
>> we'll still end up with staged/progressive enabling, i.e. we still need to
>> have patches that selectively enable and advertise a feature only for the VM
>> types that actually support the feature.
>>
>> This is all quite similar to Intel and AMD feature enabling being done at
>> different times.  The biggest difference is that Intel and AMD are mutually
>> exclusive and so KVM_GET_SUPPORTED_CPUID always reports the correct
>> information, but TDX already provides KVM_TDX_CAPABILITIES, so AFAICT we still
>> get accurate reporting for TDX, just in a slightly different way.
> I think this actually surfaces another problem with TD-first enabling.
> KVM_TDX_CAPABILITIES only returns the directly configurable bits. Then recall,
> KVM_TDX_GET_CPUID returns the actual TDX module's view of CPUID bits to
> userspace. Then userspace calls KVM_SET_CPUID to actually put them on KVM's vcpu
> so they can match between Qemu, KVM and TDX
> 
> So if a bit is enabled for KVM_TDX_CAPABILITIES, but not yet in
> KVM_GET_SUPPORTED_CPUID. How should userspace interpret KVM_GET_SUPPORTED_CPUID?
> It can ignore it for TDX, but that is how it can find the PV bits today.>
> If we have a TD first feature, it could be a documentation update on how to
> interpret it. Or we could stuff the PV bits somewhere else for TDX and say to
> ignore KVM_GET_SUPPORTED_CPUID for TDX. I think we don't need to solve it before
> we begin filtering like this series has.

The PV bits reported in KVM_GET_SUPPORTED_CPUID are the bits supported for
non-TDX VMs. Only some of them are actually supported for TDX. I would suggest
reporting TDX supported PV CPUIDs in KVM_TDX_CAPABILITIES as well.

