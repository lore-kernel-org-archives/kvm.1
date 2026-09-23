Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7939DBCC;
	Wed, 23 Sep 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162522; cv=none; b=tv3C931niTfh999z1ogipmtHAzvmTH/vAppZs/pI5vALxZrVa+eXlik+6dSxw1zCclA1/vdCAQEhYYOnGm1E9cV8CFZh81qvyEgH24QV+GDYPWOcVhj2bART4lmRl60dmj4x8GD+3j9uqWz1p3suEB2HKMBdUMCuCbUrYNoWHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162522; c=relaxed/simple;
	bh=Pr660aS4bVkfNln4yykafGscIXeG9uN1DEUCpemTFxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlJFaW1yosfi7GsMuZw/iVwXxhjLuHlm5AnJmD+ruqX3sin4GeMMHQrNcQH0kLIFGQN7mftjGtZx8WCeWUjHg27eoOChIpAiZEqvEu6ukt9ItsjcuAbciyR3OTkz2bzunWxV9rIYKkvTktDXDcADVcyCffzsOS3ZX4WH1MhKZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iitKzCxC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iitKzCxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790162519; x=1821698519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pr660aS4bVkfNln4yykafGscIXeG9uN1DEUCpemTFxI=;
  b=iitKzCxCXBuj9pAZbOPlh+9eNN6dOK8e7FpSueK6U+fdo/Btx9O+wuH3
   LJ/5awiOmtlNIED2R/nYV3nBXwvgutruNIEnVSnjbPJg5Rko+2sp+VafI
   JR6906VP6eG2RkxJPGZQv22uEWcRr0cVSgzQKPHhdq9g2TRYcE9Y8E5uP
   Isr1vwTPb69zGAV2KnxiMlWGxFHlgmHnxBlDr02Pxz1yq43iOHbKAHWqP
   C78XDVuBRfmaStxekdCRsaIjEunlaJde+Izvzk4vKATJxX30s9aj1BcDa
   TR+aqxav9Kc9M43yymkze0Yq9xh3DQyRYU6xC42cJR9nh7KC+GzTsz4U2
   A==;
X-CSE-ConnectionGUID: Io8cgIWqRRmFVInGM6Ok9g==
X-CSE-MsgGUID: jtp7Tj8WTW++cf0xu3BfeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89764925"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="89764925"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 04:21:58 -0700
X-CSE-ConnectionGUID: mlqSSGXpRQOaGilqglGU4A==
X-CSE-MsgGUID: IPapp5nNQPCiEwStt7XeEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="273741697"
Received: from unknown (HELO [10.238.208.182]) ([10.238.208.182])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 04:21:55 -0700
Message-ID: <2cc4bbc3-11d3-48bd-9a9b-a9659fc101a1@intel.com>
Date: Wed, 23 Sep 2026 19:21:52 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Binbin Wu <binbin.wu@linux.intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Maloor, Kishen"
 <kishen.maloor@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
 <a8ce5d830a04d99ec47cdc727e1761bd4031d544.camel@intel.com>
 <5ff81fc4-d144-4b2b-8375-d2f63e0dd618@linux.intel.com>
 <419b23f264af219da3be93a9d246b5401bbbaf13.camel@intel.com>
 <a436a059-b003-4e84-bd11-014bf2f17e97@linux.intel.com>
 <5168e058946a61f3be1cdb13f886dd632739d312.camel@intel.com>
 <ddba739a-b4b5-4c0f-84f1-803857f34179@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ddba739a-b4b5-4c0f-84f1-803857f34179@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/2026 9:17 AM, Binbin Wu wrote:
> On 9/23/2026 9:09 AM, Edgecombe, Rick P wrote:
>> On Wed, 2026-09-23 at 08:57 +0800, Binbin Wu wrote:
>>>> But directly configurable bits don't have any direct conntion to tdcall
>>>> queried bits. Userspace can still set those to whatever it wants regardless
>>>> of the allow list. 
>>>
>>> I didn't quite get this.
>>
>> VE bits don't query the directly configurable bits in any case unless userspace
>> sets it up that way. So they are not involved in the problem we are trying to
>> fix here.
>>
>>>
>>>>
>>>> So the argument is basically there is not expected to be any reason to allow
>>>> them, so save the code in the allow list. It's a "there is no point" reason.
>>>> Makes sense, but I couldn't get that from explanation.
>>>
>>> I think "not just save the code"?
>>> One argument is that if these bits are reported as allowed to userspace and
>>> userspace enabled them during init, and the guest doesn't opt-in the #VE
>>> reduction (KVM doesn't know the real setting), it would cause problem in the
>>> guest.
>>
>> Userspace is allowed to cause problems to the guest. We shouldn't try to prevent
>> it. 
> 
> But userspace doesn't know these bits are not supported by TDX module and KVM.
> If KVM report them as supported, and it causes problems, we cannot say it's
> userspace's fault.

It sounds like a bug fix to existing KVM behavior.

Current KVM doesn't allow HLE/RTM/WAITPKG because it might cause bad effect on
the host. But for those #VE related, though KVM doesn't support virtualizing the
features, it doesn't cause any harm to the host when KVM allows them to be
configured to TDs. It only causes problems to TDs.

For normal VMs, KVM_GET_SUPPORTED_CPUID and other KVM CAPs serve as the
interface to report to userspace if a feature is support or not. If userspace
exposes a feature to guest when KVM reports the feature is not supported, and it
causes problem to guests, we can say it's userspace's fault. But for TDX, there
is not interface to report KVM's support capabilities. After this series,
KVM_TDX_CAPABILITIES can serve as the interface. So it looks like a bug fix to me.
