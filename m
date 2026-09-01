Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689E472090;
	Tue,  1 Sep 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255786; cv=none; b=glzXrrzacP/QDZwtpjr+eOzbcfYyUNgKf3EWJFNsb+eJ08V+LwjmVB70ec6NlR86Rv0dhSXuQub0OuIkXG9u1DP9V2uJHQ9+BOyyuPZ5QeGlsprjzxXKau1AfIQ4RpBhQKljwCeNfWIPSTdT3+Whk68FUsUd+m4lA4CuGQwZL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255786; c=relaxed/simple;
	bh=At7uUX6bgo/7NrbZOxkqjQZ7s/k7Lq+IPTntPza4H7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3fwp3/AtICYKIHWQG9TqZLIlAiX6kjsyrARwln6aiHqTZw9yVFnw0fArkOAm+u1/LRNmyCZQrSmtSK///S0GjRk/wyvgh7Sf+GGjjLlpShb2xtQ2IBVcYcunsF1Eu7XIB8fBNG0L9py9uR8YdtdXYBROCArXflqYnzUylq00L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbXORP6N; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbXORP6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788255782; x=1819791782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=At7uUX6bgo/7NrbZOxkqjQZ7s/k7Lq+IPTntPza4H7c=;
  b=RbXORP6N1QoQ0Cs0h18JqSBRVmnB8dAKQIuj6BZQPdLiEevc8gsvAHhO
   1q2ThLjoiReROZcOcLVqwx9xCFObMgNq2XroNeaHqJgT/IhnmyowKFIWZ
   Gl1b6yPXjUgxvFUocB/7nl7RKueKL33tTZ7S/p1VmYyhpjRW8DcRxwRnK
   ChCnHnfMaMFyzyzsuLw2fxI6DNJS916QhKQJiTe7CaK7me1ZRw/EUVjMu
   O6xUiZzOD/CZKHTthMhLi/KO5iuJJO0kOM+RMpC+QGK8P6R9e97I2L3yl
   Xr8S7SDQ1p8y34eQp6ylUAIsWxMTs+EAnd9iKqJpIIEj+C81lzkS2/fAf
   g==;
X-CSE-ConnectionGUID: 6VZSwelvSBuwA3svfLZRIw==
X-CSE-MsgGUID: BX6lFrKZQj2YZcBw4rw8/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="76230441"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="76230441"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:42:46 -0700
X-CSE-ConnectionGUID: 2C2DWwvuRUq3zxxHR6YIPg==
X-CSE-MsgGUID: Cu1LVUPcTTKi6qY3ukpvfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="292557408"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:42:43 -0700
Message-ID: <2f27443d-935e-4486-babf-51d93c391369@intel.com>
Date: Tue, 1 Sep 2026 17:42:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
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
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <f7a3b14b-d31c-4a46-99e0-055761d631a9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/2026 1:01 PM, Binbin Wu wrote:
>>> So if the approach in this series is taken, I think we still need such an opt-
>>> in interface to tell the TDX module that the VMM is now filtering the CPUID
>>> bits so that the TDX module knows that it's safe to report new host state
>>> clobbering features.
>> Yep. Can we think about what it would look like? Easiest would be a bit passed
>> in TDH_SYS_CONFIG. But then arch/x86 is saying how KVM will behave. Ok to me,
>> for the simplicity. Could come with a nice comment.

Can you just treat current KVM behavior of allowing userspace to enable 
any configurable bits as the bug of KVM and backport this series as 
Binbin suggested below? Instead of introducing more opt-in knobs.

> The TDX module is initialized before KVM is loaded. I guess the upstream kernel
> doesn't support out of tree KVM code, so we can assume if the kernel has the code to
> opt-in the new host state clobbering features, KVM must have implemented the TDX
> CPUID filtering and validation?
> 
> Also, do you think it's reasonable to backport this patch series to stable/LTS
> kernels as an alternative?


