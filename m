Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E729E10B;
	Wed,  9 Sep 2026 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918378; cv=none; b=O8gUsIHjwKEFZLngdN4zw+6qi5WSMihUA6xHjiatMLnGdTTfc+5RFLO81OBwZ7A75pAYV627/iQ+J60ecdYFV1QUBAb/F52lvHY2u1FS5Yhetdh3J+9BwdBsTVXc1HJWLfUWmvyv2n3bhehvqySgPVtQsJgzqEOe5/XbU/gYJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918378; c=relaxed/simple;
	bh=frpjCyjjwleTkBONKacPzZynMNQ8qasYf8qwAOrHBMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiBUOOIhAtJk9sGXhHUbpC7J/ZH4//w0cQNbSCRuYo5o5ZDrn5n6gIkaxxwwI0K1XB0NyKoJNceKK1wALklJqgRyQKFOUqlijNLb5ppSCmFFs5Vwti1JC3AJ4HM87NdQRp8/PdUt6D9K6NhPZP5dd+OXHHmwBRjIj1KDDj2Lo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpYffBiE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpYffBiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788918377; x=1820454377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=frpjCyjjwleTkBONKacPzZynMNQ8qasYf8qwAOrHBMY=;
  b=NpYffBiEDVmB7SXmz7RGxYwGoHRk2JidA0DysrRPCNqgW4miSxE4Cw3J
   dW+CW6RiTi/0moMr9wL81n2QrJhr34V6BfEjwczgHJLc6m9UGkSxqfij1
   hz0s8cZrNK16ZqwbBM+b7YKE/LaGmTQK2gfVUq3CzfJ+LMuCBIuy/JrW7
   DZn3F0rn1+h65MBlQWt4Ljp5Nqi17JcjZE4XwrRpFIgBa5foRq6s/EeMR
   D+x3WOv3rWTRGVaH+n4gVdPJw1OnssPIqyhnoj+AN1Czol3R+T6VII9HG
   WY3vBz/GCh3hCe7tB17OfupjkoCsOXSnBov92YnsPr4og7P5IQ/9Hp2So
   g==;
X-CSE-ConnectionGUID: F36Va1S9Sd2grLpRZ/AzIg==
X-CSE-MsgGUID: nLHhgMyuQSiXERgqJLNKSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89538629"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89538629"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 18:46:16 -0700
X-CSE-ConnectionGUID: 3OtRwPwpRwC37QFLGoJUmg==
X-CSE-MsgGUID: x7vvAODwSa2mI2wYQ9S6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="271158425"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 18:46:13 -0700
Message-ID: <c6b240bd-3c45-4abe-b17c-72a1a7da582f@linux.intel.com>
Date: Wed, 9 Sep 2026 09:46:11 +0800
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
 "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
 <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
 "Gao, Chao" <chao.gao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
 <1deddc78d14326b378ddd62ad99c21d66da401e6.camel@intel.com>
 <f7a3b14b-d31c-4a46-99e0-055761d631a9@linux.intel.com>
 <2f27443d-935e-4486-babf-51d93c391369@intel.com>
 <328ee2d79d462f516a14b7460ca468752620347e.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <328ee2d79d462f516a14b7460ca468752620347e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 12:09 AM, Edgecombe, Rick P wrote:
> On Tue, 2026-09-01 at 17:42 +0800, Xiaoyao Li wrote:
>> On 8/31/2026 1:01 PM, Binbin Wu wrote:
>>>>> So if the approach in this series is taken, I think we still need such
>>>>> an opt- in interface to tell the TDX module that the VMM is now
>>>>> filtering the CPUID bits so that the TDX module knows that it's safe to
>>>>> report new host state clobbering features.
>>>> Yep. Can we think about what it would look like? Easiest would be a bit
>>>> passed in TDH_SYS_CONFIG. But then arch/x86 is saying how KVM will behave.
>>>> Ok to me, for the simplicity. Could come with a nice comment.
>>
>> Can you just treat current KVM behavior of allowing userspace to enable 
>> any configurable bits as the bug of KVM and backport this series as 
>> Binbin suggested below? Instead of introducing more opt-in knobs.
> 
> Ok, so if we are agreed on the other branch of the thread, the only big question
> is: Do we want an opt-in for future clobbering CPUID bits.
> 
> I think either is ok. I don't love the precedent that we asserted that no new
> clobber bits could be added without opt-in, and then we would backport changes
> to allow this anyway. But on pure code, the backport would be simpler in the
> long term. If you guys are strongly in favor, I can agree.

Had a discussion with Rick off list.
We can defer the opt-in design or backport decision because the patches will still
be correct and an improvement in any case.
