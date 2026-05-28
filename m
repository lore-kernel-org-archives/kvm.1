Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269622652D
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952614; cv=none; b=q9aSiHDvw8xeNe8GBa77ffzc8naa44Dspi2W2j3/CSL1LYj5WdaZDqQJdjgFlUHXfPnHfpOw0YBz5bj3aNfKddNrMDVc5EE4BfgOdl/HUj+yYcic9RXCV1olSqWn6ZcMZsIL9T2/kYHkCEMUUlIWunqoF5BQknspMf7sZCx9Kcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952614; c=relaxed/simple;
	bh=Og6xRmXzxJDi40fZ6FCs9p6oBUcYwM/x5jqD7w15xd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akv1QHpss+b8ehJjKaWvebqbQURQ2CLog13n3Xfh2OPSqAuFD9jtHcAXrW/4lug9lBBnC+On31hvu5TmcjpoB6jp0kyQfCe9o34z/BrMmoHXDjbZ4z9oE03jaDVMN5iCqpz9fPfcj/mHUvc1FNgK13VY6Ds1WBhaRyZFlJxayG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJ9tydS1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJ9tydS1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779952612; x=1811488612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Og6xRmXzxJDi40fZ6FCs9p6oBUcYwM/x5jqD7w15xd4=;
  b=DJ9tydS1z1b65WIIPL4PIcPiLAOsitgNs4QVg6YANCD2N/pMvDFSr8X0
   zlI0EAQM3tjrRtddPEkts9lL4VaM8d/YHDS9CrFDsAS3aExhQZOxZ5Ucx
   Qd+q20j/DlTzuJUxSAQPCPhefZG0ogaHDHs2RRNBu/P9gHDWk86U4DzrI
   m/hNfvvqhMnw1UZuwl0XIIDG8hXPGkyXuQaBax1fGCThLDo+Gz+90HL/8
   cjuwBG4f+Dh8PRFu5gBlW/MCaJ1fnxT3XWp3SWzTOzKhXP9mIWHAqQGee
   ElFfkGeux1xv2IGIVfMJyX6VRCP5hjEsGNXOizrdwI9gCz1G8R+FmrbFg
   w==;
X-CSE-ConnectionGUID: e7eUoUA3Tz6iOZIzufyXvw==
X-CSE-MsgGUID: /owHqAZ6Q3a3u3CXelJ45g==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="79939311"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="79939311"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 00:16:52 -0700
X-CSE-ConnectionGUID: qDwKBy9nTS6MALj3o6pY+Q==
X-CSE-MsgGUID: 2x/JHt9cQsiAmNtwJCt0dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="241637532"
Received: from unknown (HELO [10.239.158.62]) ([10.239.158.62])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 00:16:50 -0700
Message-ID: <eef665f7-45d7-49ae-9cda-e8eb51a0ed4a@intel.com>
Date: Thu, 28 May 2026 15:16:48 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 2/2] x86/vmx: (Re)Add a nVMX test to
 validate load/save of DEBUGCTL
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20260527151232.4058615-1-seanjc@google.com>
 <20260527151232.4058615-3-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260527151232.4058615-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/2026 11:12 PM, Sean Christopherson wrote:
> From: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> Add a nVMX test to verify that DEBUGCTL is/isn't loaded/saved on entry/exit
> as per vmcs12's controls.  Validate all combinations of legal values (only
> three bits are supported, i.e. there are only 8 unique combinations), for
> both the host and the guest, along with '0'.
> 
> Validate that:
> 
>   - DEBUGCTL is loaded from vmcs.GUEST_DEBUGCTL iff "Load debug controls"
>     is set, otherwise the guest should see the host's value.
>   - DEBUGCTL is saved to vmcs.GUEST_DEBUGCTL iff "Save debug controls" is
>     set, otherwise the VMCS should retain its previous value.
>   - DEBUGCTL is *always* zeroed on VM-Exit, irrespective of guest controls.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> +static void __vmx_debugctl_test(u64 host_val, u64 guest_val)
> +{
> +	u64 val, rand;
> +
> +	/* Validate VM-Entrywhen save/load debug controls are set */

missing a space between "VM-Entry" and "when".

But I don't understand why we need such a comment at all. Does it 
explain the purpose of following vmcs write is to validate that the two 
vmcs bits are allowed/supported on VM-Entry?

> +	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
> +	vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
