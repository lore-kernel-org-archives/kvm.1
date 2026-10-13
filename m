Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848637267A;
	Tue, 13 Oct 2026 05:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791868833; cv=none; b=q4EvZuOK4zD9znWIDi8A/g6c4ajmoIhUVdXLAoKzx1GQl70+Mk6NN2j8VKYfLZstyfW8iSemyi/i+sRzAQ2NYT3a4W5TZu5dvXXn4lHXPpK+taps4SOkFDYA20sEyp0hmd2pLzkymAlq9YNk7RBNVduCT0f5k/QtgDJQ/e3d6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791868833; c=relaxed/simple;
	bh=bJ4qCk+aRfvG+x9NsAdPUiJUDZbzFtJqi4KD93nq8tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Na/UeK6BS/ooOFxUY18egIufZ0rZgglx7toJXkpfoGy+G4M/15WgbMxwNIDaBwueYKBRQNGn0r8aQ9ieFWVRi0KVVzDVn8E8bdAv+qde3hGyP+N0dgNzdu+rhDwy2Rq2Uu1pCnrI8eNSJmzvnVt2m2+iQoyC+Sl+nvWq5DCF05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9VSsCkc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9VSsCkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791868831; x=1823404831;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bJ4qCk+aRfvG+x9NsAdPUiJUDZbzFtJqi4KD93nq8tc=;
  b=l9VSsCkctTuZzuAnDcN5UkZKd9soUnxVlKZS8UF99g0OeyJPC5gqDbgW
   79i75MWAF1BjFzRUlYEHXY9y78wInPbICprHZGEMMYMRE9tNGk/CZKLXm
   Rd3ctARkAAKT1KW/OT8dSDM2yOnZtPxcdH3Tv9xt435TwzKIMmJ9G/tNU
   qPDZtRiYD20j//I18yceq3U+GiXn6qWZ57yk1+HRYjR0mb3EXrXyKCEg2
   w+Z1S/0fzvikI15VgSb2NABkzE35eiihlxrdzUVxzK7+m1JCQiN/nvXxy
   r4cCvK0VNm9ZDZoTNjCS7Qpl4C3/vz8/KR7xc8/aEAk4iPSeWO54HTPVM
   A==;
X-CSE-ConnectionGUID: b/w84lNFQJi1yHP5DomtcQ==
X-CSE-MsgGUID: 7X3Eq53vSXO5dFUEXX0EOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="592677"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="592677"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 22:20:30 -0700
X-CSE-ConnectionGUID: eOYLd4auQRqemWzCmuisWA==
X-CSE-MsgGUID: R0lyd1DoSDSZM5apUZeS4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2911501"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 22:20:26 -0700
Message-ID: <a578b2ff-52a4-4959-832d-a84b24ccb80e@linux.intel.com>
Date: Tue, 13 Oct 2026 13:20:24 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: TDX: Set SIGNIFCANT_INDEX flag for supported CPUIDs
To: seanjc@google.com, Changyuan Lyu <changyuanl@google.com>,
 rick.p.edgecombe@intel.com
Cc: binbin.wu@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, isaku.yamahata@intel.com, kas@kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
 tglx@kernel.org, x86@kernel.org, xiaoyao.li@intel.com,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <213d614fe73e183a230c8f4e0c8fa1cc3d45df39.camel@intel.com>
 <20260224212939.2081828-1-changyuanl@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260224212939.2081828-1-changyuanl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/2026 5:29 AM, Changyuan Lyu wrote:

[...]

> -----------------------
> 
>>From 18b967b718911c09872c3717d8ab083fa59c4a70 Mon Sep 17 00:00:00 2001
> From: Changyuan Lyu <changyuanl@google.com>
> Date: Fri, 20 Feb 2026 09:55:28 -0800
> Subject: [PATCH] KVM: TDX: Set SIGNIFCANT_INDEX flag for supported CPUIDs
> 
> Set the KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag in the kvm_cpuid_entry2
> structures returned by KVM_TDX_CAPABILITIES if the CPUID is indexed.
> This ensures consistency with the CPUID entries returned by
> KVM_GET_SUPPORTED_CPUID.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>


Hi Sean,

When I was preparing the v5 of the TDX CPUID patch series, the internal sashiko
reported a issue:
  > @@ -2359,6 +2359,15 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
  >  		if (!entry)
  >  			continue;
  >  
  > +		/*
  > +		 * Reject entries whose index doesn't match the expected one.
  > +		 * This catches userspace passing a CPUID entry with the
  > +		 * KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag cleared when the index
  > +		 * is significant.
  > +		 */
  > +		if (entry->index != tmp.index)
  > +			return -EINVAL;
  
  [Severity: Medium]
  Does this unconditional check inadvertently break userspace VMMs that provide
  valid CPUID entries but leave the index field uninitialized for
  non-significant leaves?
  
  Since kvm_find_cpuid_entry2() ignores the index field when
  KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared, VMMs are not architecturally
  required to zero the index for non-significant leaves. This check forces
  the index to be exactly 0 (since tmp.index is normalized to 0) even for
  leaves that do not have architecturally significant subleaves.


I think the issue is valid, so it needs to know whether the entry
is a subleaf or not. I think it's more reliable to do it via the information
reported by the TDX module. i.e. my patch set will rely on this patch to set
KVM_CPUID_FLAG_SIGNIFCANT_INDEX for entries that are indexed.

Will you apply this patch?
Or I can include this patch in my patch set. Also, 0x23 is still missing in
cpuid_function_is_indexed(), I can add a patch to add 0x23 as well.


> ---
>  arch/x86/kvm/vmx/tdx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 2d7a4d52ccfb4..1c039eab2f3d8 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -167,6 +167,7 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
> 
>  	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
>  	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
> +	entry->flags = 0;
>  	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
>  	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
>  	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
> @@ -174,6 +175,9 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
> 
>  	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
>  		entry->index = 0;
> +	else
> +		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +
> 
>  	/*
>  	 * The TDX module doesn't allow configuring the guest phys addr bits
> --
> 2.53.0.414.gf7e9f6c205-goog

