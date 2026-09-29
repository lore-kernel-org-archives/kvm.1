Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16B3783C3;
	Tue, 29 Sep 2026 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641200; cv=none; b=WfG+GZX67zN+tx0RNg9XFUoxyEmlOvLnEWa2lK+j6Um2gQfzMGA3hSDRSRB4DBFJZgD92a+IPpxndiShG4wBNrcszEMicb+dJImQs0q6Be63owT5x5BZCMb5pKeSzxWqd6u+cor3OOHnmgmZRwjwO9DWFbo41tbzBMMQp6MSolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641200; c=relaxed/simple;
	bh=BwX/BkX3f9mp6+4BYNr1evnobdAgb5wrMhB8WZW8+kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wt3TfGisS7G0fQuZzpi6e6iEC2vsW6YAkia5ta3Xn5MxiOJrT0kT2Xxr4+rNRUGwsEUs5FIgEVBkSnqQvJJYvpaJoLadXnk1uWRCoeCmJ4enL2W178ytWe/fyRBNHSVyKbbyOD/sz0VQj9s55SLu5zmKhaN28J94TWN6coPqt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiMYr9TV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiMYr9TV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790641195; x=1822177195;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BwX/BkX3f9mp6+4BYNr1evnobdAgb5wrMhB8WZW8+kA=;
  b=MiMYr9TVJjcKAl7gB/drQLnVtyVMSIPOS8cqpEXLy3cqp17weVTWDTbs
   LQNLS3yyriecsRr0FFaHYhzKRDl4vPQDxM6X939EauKTOkb4d9GK5njYq
   +tmodC/KXaBQcD5k5SuSU//8b9PEJGWTa5eOTq28eiPqAX3qvHOYx/eDq
   aUAOt/8pnWNjIp0cJxNeUZ+gwaXNKQafAFAkp9Nq7OmGj6JglU3F0+iMk
   A5bz2OHphutTfS7rBIw/ZEtqO+dKvdaQTiQwux7xev8V78vpL7BOFRYDH
   X2ubrYXQBTt2TH1kTVWkPX/NfO8l5HK80JWXeeZSIv4t0OQnAbkHHs9ZZ
   A==;
X-CSE-ConnectionGUID: vacoaxpLS6iE3F4MZtuCEw==
X-CSE-MsgGUID: 9kKMZqG0SPWi14+rjOlNvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90217401"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90217401"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:19:50 -0700
X-CSE-ConnectionGUID: loBOEpsSSz+EoBHEJL2QQw==
X-CSE-MsgGUID: Q37POYIVSFuGXM6GZHxmYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="275340580"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:19:46 -0700
Message-ID: <c824aec5-119f-4054-ab47-96839adf08b1@linux.intel.com>
Date: Tue, 29 Sep 2026 08:19:43 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Maloor, Kishen" <kishen.maloor@intel.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
 <39047bbc-757d-4131-a25c-5a7743fd591a@intel.com>
 <062f5365-7eb5-4e04-9c84-f5ecd566f019@linux.intel.com>
 <eca53031-fd47-4471-9d05-d73295a0f57e@intel.com>
 <8bcba51e-2a3b-44b8-89cd-aebfd1e50cfd@linux.intel.com>
 <de109514-91b8-49a6-bbbe-c1f7f1ee407f@intel.com>
 <c612e6cd-ca84-4c37-af72-9c13eeb1f3ce@linux.intel.com>
 <c2b669f099174c5d67593d5446a02abc43eff40c.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <c2b669f099174c5d67593d5446a02abc43eff40c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/2026 7:58 AM, Edgecombe, Rick P wrote:
> 
>>
>> My consideration was maybe some userspace could set this bit.
>>
>> But userspace is expected to consult KVM_TDX_CAPABILITIES for the configurable
>> bits before invoking KVM_TDX_INIT_VM
> 
> If a guest is already using it, then even if the bit disappears from
> KVM_TDX_CAPABILITIES it could cause a regression when it doesn't get configured
> in the guest.

The precondition is these excluded features bits are not in kvm_cpu_caps[], i.e.
these features are 
- Obsolete or
- Not supported by KVM, there would have been issues if a guest is
  using them.

I will add the precondition when describe it in the change log.

> 
>> , regardless of this patch series, there is no risk to break userspace, except
>> for CORE_CAPABILITIES, which is the only
>> special case as it was defined as fixed-1.
>>
>> I think there is no need to add XTPR to the allow list either.
> 

