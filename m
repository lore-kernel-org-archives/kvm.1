Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67F390991;
	Tue,  1 Sep 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258073; cv=none; b=sAoKNSsyBdogjTN1lc4z7G1rBo6XavMjkYgB2uniqgvenJznFcKdgnCI7K1rQm/qTJtOpGtGqT+GGIVdsSNqoKOICh3Uz5vU3YpIeNDjHSFzGRrLG3CV1MdO+TC4/fdJVD6TPlrzb9L46hgaGQ+fcu3mD0a1Jvut2rDQ8BUN0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258073; c=relaxed/simple;
	bh=ATsfCEkVoLTs3EoyAFFd3IqUgjuL78CTgUxpZ+m1Jbc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lPZqQDtmdVn8PKn0wIiu0BE43jvKJ9T/+FWC844bneX7xxcqGWkzdWrFV/Mm2+qaz4hrNbcUABPscBk/+z+nciQAJkR2rxQrWySPTHsTjvQCx/P1mbid2evcPQTwjGmzG7LmsTTpgCVYCilCpfSdaXmbHoez4/qaAW+Cp1hftU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fs4cynkT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fs4cynkT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788258072; x=1819794072;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ATsfCEkVoLTs3EoyAFFd3IqUgjuL78CTgUxpZ+m1Jbc=;
  b=Fs4cynkTgv+s9aa+k06TaB7XMpJL0UYUbICquonhWkqwF89ekW++y2u2
   NRdSG4jYe3b/R57QJZuFociGw+p8GXUUQ2ZZzPLlXWNM3fFlm1qIU+H/w
   t1/BdleQ1ITLJsSCdGP0Iu8UzhBtQDRppdNVN1MCU3Maotd3sJXVRUPwL
   tZG7HKIBsnwJTik40pdsytaZOiLA5LSQs3bfijV599pEJWgVPATJpdKeB
   DB+ewNyjhxALHW8ssTLUWIzKWHt6uVQleSKebp0nY6HiDrdv26Wm6CqUQ
   aGC6rAnECFXE3VfydNQaFff8JWIsHCbIaGQVL7ELI9PW42FSKA7Nko6bP
   A==;
X-CSE-ConnectionGUID: bKx0C3yrR9uiVc7lQg593A==
X-CSE-MsgGUID: g5usAFx7RT6VE2oDRCc9Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99341303"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99341303"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 03:21:11 -0700
X-CSE-ConnectionGUID: TkGjgjj4RMeQgJKnWq79lg==
X-CSE-MsgGUID: 7Oi96cqeQiGMbHNBi0fJ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="269635423"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 03:21:05 -0700
Message-ID: <cc98e036-9269-4bf8-91df-d46ca684e6be@intel.com>
Date: Tue, 1 Sep 2026 18:21:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
 <andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
 <1deddc78d14326b378ddd62ad99c21d66da401e6.camel@intel.com>
 <f7a3b14b-d31c-4a46-99e0-055761d631a9@linux.intel.com>
 <2f27443d-935e-4486-babf-51d93c391369@intel.com>
Content-Language: en-US
In-Reply-To: <2f27443d-935e-4486-babf-51d93c391369@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/2026 5:42 PM, Xiaoyao Li wrote:
> On 8/31/2026 1:01 PM, Binbin Wu wrote:
>>>> So if the approach in this series is taken, I think we still need 
>>>> such an opt-
>>>> in interface to tell the TDX module that the VMM is now filtering 
>>>> the CPUID
>>>> bits so that the TDX module knows that it's safe to report new host 
>>>> state
>>>> clobbering features.
>>> Yep. Can we think about what it would look like? Easiest would be a 
>>> bit passed
>>> in TDH_SYS_CONFIG. But then arch/x86 is saying how KVM will behave. 
>>> Ok to me,
>>> for the simplicity. Could come with a nice comment.
> 
> Can you just treat current KVM behavior of allowing userspace to enable 

well, I meant "can we"...

> any configurable bits as the bug of KVM and backport this series as 
> Binbin suggested below? Instead of introducing more opt-in knobs.
> 
>> The TDX module is initialized before KVM is loaded. I guess the 
>> upstream kernel
>> doesn't support out of tree KVM code, so we can assume if the kernel 
>> has the code to
>> opt-in the new host state clobbering features, KVM must have 
>> implemented the TDX
>> CPUID filtering and validation?
>>
>> Also, do you think it's reasonable to backport this patch series to 
>> stable/LTS
>> kernels as an alternative?
> 

