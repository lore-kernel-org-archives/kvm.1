Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5942223336;
	Wed, 23 Sep 2026 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122475; cv=none; b=HopHda57FDZEWDMxbMh+gV5mpln/PnsKS5GJDL0Yo+XGh7eouGKKEnLjLyDL5+k8zIcRoF23aOkz3HW0WZTHOHXZ1dHiZNVQWXVa7p/fNMzL394Y9eiwn8b8GiOc+IV30sI8JaZNBE6HR9Nno9GguKln4uVLe04Eb6+nO+VSriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122475; c=relaxed/simple;
	bh=iJLhGRbBbehh8W9wFnYVnh/lqEFJP7x3mwjmAF01Z3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpJQFUqt1KzHxxBaIodpBuz1yKnoubg9W/N7oTYnaZ+7LkQ0FoxM6bW1GLLIq84YoanWLrjv1eg+fkAHZ58Zj5SDLpAzNBcq58mzMC/L5mJdbLkHbTernDMYnziRuNfN+j0A6fY5Jl5wC+GOCXFQEqOCKDFJLhj1uld4mnunvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSw6EUrG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSw6EUrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790122474; x=1821658474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iJLhGRbBbehh8W9wFnYVnh/lqEFJP7x3mwjmAF01Z3E=;
  b=KSw6EUrGI97MaJiOFREOGLYH0mJTW2v5sURNDybSD4D9bccbmrRQsCwt
   Zm7ggWydIdOh0vZexDe8ycdxwa92Dn84RFQVd5nrCHwplBJI8KhYvEkht
   NHCD4NQjW7K4hZ3SnLmDXZDCZM+8GxJjaZPN6276dlasz+ZzVresxrGaa
   dsq9/Y+bkeikYUEbsbzDoghr8E7eE7h49WLjnytIqNUMWoJPY4Lh4fzar
   9vyHrA3h1cdHo2ZJF+3yY7PVCfxM+wtfI9VYZoiCzpFJUyGB8iPMoeaFy
   16szQns7v7Y0HsgFq6n8yDY0uOAh57DK1LPS0kDl7Bpq3wat5VqgX8m+y
   g==;
X-CSE-ConnectionGUID: 8TudpsRQThGkvWAYQ9uZmw==
X-CSE-MsgGUID: yzLdc4/dSYumcXWGpBoM6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90644191"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90644191"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:14:33 -0700
X-CSE-ConnectionGUID: E4sZTzCSTTKcM2GkQzWKtQ==
X-CSE-MsgGUID: C52nxrynSjqJlgw6GSlATg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4418033"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:14:30 -0700
Message-ID: <5ff81fc4-d144-4b2b-8375-d2f63e0dd618@linux.intel.com>
Date: Wed, 23 Sep 2026 08:14:27 +0800
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "Maloor, Kishen" <kishen.maloor@intel.com>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
 <a8ce5d830a04d99ec47cdc727e1761bd4031d544.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <a8ce5d830a04d99ec47cdc727e1761bd4031d544.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/2026 8:01 AM, Edgecombe, Rick P wrote:
> On Thu, 2026-09-17 at 15:25 +0800, Binbin Wu wrote:
>>
>> Allow MWAIT, XTPR, and HT through TDX_CFG_EXTRA_F(), as these bits are
>> not advertised in kvm_cpu_caps[].  The remaining directly configurable
>> feature bits outside kvm_cpu_caps[] are left out of the allowlist:
>>
>>   - Features forced to zero when #VE is reduced,
>>
> 
> Sorry, I'm not following this logic exactly. The guest can control it's own view
> of CPUID. Why do we need to filter the host setting them via direct
> configuration, just because the guest can change it's view to exclude them?


These feature neither supported by the TDX module nor supported by the KVM.
If the guest enabled the #VE reduction, the access to the related MSRs will
cause #GP. If the guest doesn't enabled the #VE redcution, #VE cannot be
supported by KVM since the related MSRs are not support by KVM.

So the guest cannot use these features anyway.
> 
>>  or lacking KVM support
>>     for the associated MSRs: EST, TM2, SDBG, DCA, ACPI, ACC (TM), RDT_A,
>>     RDT_M, TME, PCONFIG, and CORE_CAPABILITIES.  Handle CORE_CAPABILITIES
>>     in a subsequent patch.
>>
>>   - Features tied to IA32_MISC_ENABLE bits that a TD cannot set when
>>     TDCS.TD_CTLS.REDUCE_VE is set: CID and PBE.
>>
>>   - Features that can clobber host state and lack KVM support for TDX:
>>     FRED.
> 
> I think we can't say this quite yet. The arch isn't finalized

Oh, right. I should be more rigorous.

> 
>>
>>   - Unsupported features: PREFETCHWT1 (Xeon Phi only), PSN (absent from
>>     TDX-capable CPUs), AMX-TRANSPOSE (never implemented on an Intel
>>     platform), and RAO_INT (defined only for future processors).
>>
>> Filtering KVM_TDX_CAPABILITIES in a subsequent patch will intentionally
> 
> Nit: "patch" -> "change"
> 
> This is drilled into my head working on the tip side. I'm not sure if Sean has
> the same allergy though.

Will update it.

> 
>> stop advertising the excluded bits as configurable, as the corresponding
>> features are unsupported or cannot be properly virtualized.
>>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> 
> Overall it looks very good to me.

