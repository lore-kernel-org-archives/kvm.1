Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1294AA1F4;
	Wed,  2 Sep 2026 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366123; cv=none; b=lXKwXJLvWsi00Cf0BrYDIwvWpX1cXDj2DzTFzMYorzI27LsQtqP0w3LvPeWsA7ZjeK61Q8SZh8qhfPP0qUAQvRMKsJL7Efj6aHcYUnoW9rfiUd3R1Wh4JDpAJsAiJltgSgEK8K0VnRP3Gw+zvL+oAJlCrwkFEagNmY/YJQfbctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366123; c=relaxed/simple;
	bh=55i9H9tDMdH2byrpctztzTMpsxuCSTbIS62SOEQ+puU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnKp9GoiWP/u7mFIQYVIcVrLx/YNrhZnS418G28BNWssY/X9uRJ5sgfabfLNV8wQ5OT1VPxM6Zwe8hU/BfT7tFRS1Un17eQfmweuc14goZV6FOQWuqJzLpc/Cmug/olsnT5ncsL3AnJE9pi5ssXlR6581JUrtEM7L7EkZqBOn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jm+3aC9H; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jm+3aC9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788366121; x=1819902121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=55i9H9tDMdH2byrpctztzTMpsxuCSTbIS62SOEQ+puU=;
  b=Jm+3aC9HinHj7nnjuWZzRXxIwvxR8mfQbDp2pExmbLog9Yqh6dZxgEO3
   zi2VOPlZ+QoWnWmIPXOXf3RQCa55ZSKCx5BKr1Lrp0o2dM7T/MaDdp81E
   SZKW2+jw6Ax1eU+ZOFfPuDdx5nKF4P/jKBYD4jkbVijFMkBsdFF+K4uL+
   TWZQ54oYLWLAGmaADFsHuXAbnM8ZW6/ZZFxYTuL+DReU0XzrwMc4kug7H
   l33ey4Ze1ud8uWjIVCSHaF/mjjiaeVQDr9Gz4E5qZwTnats9kkP2ugL3s
   0wE5LLNUEa5fX2G8Pn8kV3UX+Rqofd1ceFvEUSueZ/8Lweeh0rvJ0kCv2
   g==;
X-CSE-ConnectionGUID: bY9gsjmzSCSNAy0Rfx2Tog==
X-CSE-MsgGUID: T0V7MuvFS+y+OrombfI9zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100346370"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100346370"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:22:01 -0700
X-CSE-ConnectionGUID: iXEWMELmRweJpTyRqqOzqA==
X-CSE-MsgGUID: z7LrHK36QbGsjB6+7R2FJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273621189"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:21:58 -0700
Message-ID: <ab4c62a9-4459-43ff-8543-4f26cb3829e9@linux.intel.com>
Date: Thu, 3 Sep 2026 00:21:56 +0800
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
> 
> Are we sure no other VMM needs an opt-in, before finalizing it though? Binbin,
> can flag this to the TDX module team?

AFAIK, no other VMM complained about the host clobbering issue.
I will check it with the TDX module team.
