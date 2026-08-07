Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A041F91E3;
	Fri,  7 Aug 2026 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064808; cv=none; b=MqyE7rHvQfla1ksnV6LAYAXzrwUzaC41OCLusi+diyM4GcdTiRUI6p15tYBSAYAmk2YWmGa/FGFUwHMQgnHraay7HczzgTijfMqjVvMvuFBMunBZSqLDuS9qnC5SgMzFQIz6ldR40SyukUt9A3akO47qauB7ht+jgAycdCxjLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064808; c=relaxed/simple;
	bh=/i3dinCqnhGMOZMpOE4EZNiNA2siHqMenCoTAPc1bZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnivwiufJbvopzio+GAH6qhWBSpX67rK9QNtgWT66JVCbYAhzL36wF0NNddueAkL5h83KZpIEL5X3eFfmXBmyWPahcexSytbN17yv6fIi3dWB96WO9wv9Vcr48/9bPyreZomOLDK4w2T8EWBVxMtLlIcJMtaDRqHY4oH2GdwckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KV3DYxnl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KV3DYxnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786064806; x=1817600806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/i3dinCqnhGMOZMpOE4EZNiNA2siHqMenCoTAPc1bZg=;
  b=KV3DYxnloc3pS2jKwW9OallvtmsV5rC8bngTwlkG39R0pP7vREwlJXer
   YShNdgqxhq8eIdu5aT4qE6W7xLPIs1xkQOPI0UShH9OgEoxpMmgUaq21/
   h8lMCFEMUi+2jZapE/tIOKAc2y6ii4wqCBbcdp1Qf95w4VvCjFIEJzn1d
   mDhN0JNoKgT075FZgqTX4qQv5I47pJV0NYzXIf/AtKkVNOtxxFbXh8bco
   47/8/uzy43teqJOPy20rMn9MIJ8Q3TNPs1IoZLgreX5JGYJCfyDdJX9+O
   oV2GLNEPMwHx52fJwMJ6ZngYnfI3Olr4YTcLEnISJYlroe0r41WjTKOxz
   Q==;
X-CSE-ConnectionGUID: yJdSIxjwQeSjN4fBC+ZBzw==
X-CSE-MsgGUID: eTsskDhtRx+zeExPVB2Vog==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="112221112"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="112221112"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:06:45 -0700
X-CSE-ConnectionGUID: MXklpJPMRZSPEnWdCK28rA==
X-CSE-MsgGUID: KeBa1isNSuinRgxmkMd/ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="259649425"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:06:18 -0700
Message-ID: <caedad66-8a7b-4182-9fbb-d4abe1f1696f@intel.com>
Date: Fri, 7 Aug 2026 09:06:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
To: Nikolay Borisov <nik.borisov@suse.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-2-xiaoyao.li@intel.com>
 <82482276-0140-4d90-a983-fdfc5bc2e4a5@suse.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <82482276-0140-4d90-a983-fdfc5bc2e4a5@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/2026 9:33 PM, Nikolay Borisov wrote:
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index 545b03d9d10b..cdc0d24657ac 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -2129,6 +2129,9 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, 
>> fastpath_t fastpath)
>>            * - If it's not an MSMI, no need to do anything here.
>>            */
>>           return 1;
>> +    case EXIT_REASON_NOTIFY:
>> +        /* NMI blocking state is handled by TDX module */
>> +        return __handle_notify(vcpu, false);
> 
> I'd rather there be a private handle_tdx_notify function in tdx.c than 
> exposing __handle_notify and introducing the boolean. This is needed 
> because the TDX module handles the NMI unblocking, so let's keep the 
> implementation specific to tdx.

The initial version just implemented a separate handler for TDX. It had 
the exact same code as VMX's handle_notify() except the "NMI blocking 
handling". So to eliminate the code duplication, I changed to current code.

Sean, please let me if you have a preference. Otherwise, I'll follow 
Nikolay's preference in a v2.
