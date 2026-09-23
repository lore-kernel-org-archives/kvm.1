Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF12701D9;
	Wed, 23 Sep 2026 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125054; cv=none; b=iIBI2MT2UvS9wPQ13i1+DuyuUdu7zG0ZcCTmOglYq08f6hCudbIKupclXrJamgwoSa6v81AGSCBuk6hG65YJ1zHjQLaTvCHRFhLJ3NDjwJwRXY9N9I3v3wGCSkySfGlIOIRgIKouDTUctSCQ+Hji5eVkLJZnamzFRespPL01iJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125054; c=relaxed/simple;
	bh=9SofpdJRs4ByDfE7G5hG2GqJKaWTqJSARWXRWJCk0Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzI030KCXzRIwWN0+YhZ6YT6De5D4pwNm+a+Fma0CREGvH2GmGPy2i7PwJkzTlFOyTf2t4Ick3zZR7B5a4ctJzRS5QFFgqlEQWAzkikOwObMOI52Slmh3Pvz3bu1tS45eZ/YhFqokaQqB1wY+F8SJ1cxhDtZrsA8vfU9HM6J49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYt0EjMe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYt0EjMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790125052; x=1821661052;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9SofpdJRs4ByDfE7G5hG2GqJKaWTqJSARWXRWJCk0Pw=;
  b=nYt0EjMeL0kpk025A36emNU56t87In2fBcRLbahDFBu0Dh5TvbWD7iBh
   8j2LLfrL5BD50ppf2zyvD+EZL7r4f5aO46auqIFzSBfAavti/ug9afoS1
   xcWb1ERBFOkBQx+wGZ3qsplox8DOwwMGALfp4X1Psth1jWla4WZ+lrGQT
   AQtJKBZnu3RBLERtV4SeZEMab5pcd5st12nCDhkkiNQh7h5JDe6oeXXeo
   GkxYMotC83V629o+3yhg/P1V1fhUk0mlbB/REv75EDH+u5zQlt8nFjrzJ
   ROKV88+UPkPI4I5JFXUKNUEZeYL0q42ywwrb95IJeyc9XyiKo6THvfkrZ
   Q==;
X-CSE-ConnectionGUID: eR+NJDfJSQ+GzCwe5wF/xw==
X-CSE-MsgGUID: EikjfNxrQdunediSUQs+dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="116303666"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="116303666"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:57:31 -0700
X-CSE-ConnectionGUID: fwUvgymWRxy1CmWuzI5zCA==
X-CSE-MsgGUID: YQrwuhPWQkm3A7sgG6ETRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="272571632"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:57:27 -0700
Message-ID: <a436a059-b003-4e84-bd11-014bf2f17e97@linux.intel.com>
Date: Wed, 23 Sep 2026 08:57:21 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Maloor, Kishen" <kishen.maloor@intel.com>,
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
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <419b23f264af219da3be93a9d246b5401bbbaf13.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/2026 8:45 AM, Edgecombe, Rick P wrote:
> On Wed, 2026-09-23 at 08:14 +0800, Binbin Wu wrote:
>>> Sorry, I'm not following this logic exactly. The guest can control it's own
>>> view
>>> of CPUID. Why do we need to filter the host setting them via direct
>>> configuration, just because the guest can change it's view to exclude them?
>>
>>
>> These feature neither supported by the TDX module nor supported by the KVM.
>> If the guest enabled the #VE reduction, the access to the related MSRs will
>> cause #GP. If the guest doesn't enabled the #VE redcution, #VE cannot be
>> supported by KVM since the related MSRs are not support by KVM.
>>
>> So the guest cannot use these features anyway.
> 
> But directly configurable bits don't have any direct conntion to tdcall queried
> bits. Userspace can still set those to whatever it wants regardless of the allow
> list. 

I didn't quite get this.

> 
> So the argument is basically there is not expected to be any reason to allow
> them, so save the code in the allow list. It's a "there is no point" reason.
> Makes sense, but I couldn't get that from explanation.

I think "not just save the code"?
One argument is that if these bits are reported as allowed to userspace and userspace
enabled them during init, and the guest doesn't opt-in the #VE reduction (KVM doesn't
know the real setting), it would cause problem in the guest.
