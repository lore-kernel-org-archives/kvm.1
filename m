Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2EF306746;
	Thu,  3 Sep 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402160; cv=none; b=IG8V92/6ez6KZRX5IseLxE5urHepXDm0cm1dZ26bbxc4cSAR2pDpRjSoB8cGMucQ2IWBIDCgStuB/qkdeTI8fm3vNlH5kJcg0KmsPQnAatILAe60cG/TyDe70Rpkr6tdvQNUdVFtAO73Bc/9rBnXGW/442GngF8c587YSOud0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402160; c=relaxed/simple;
	bh=2FylJuc1bUlmzziQDSOEpFEiKXb4o1cAdJT/La54P+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLlbMl+kWcALsuIcc4hE8sOEH1WoaG4iVb4Zt3CK5ENoX76X4dwRE3kz2j2FGc1oqVWwELApGPGZ0N3kK7CUmvzabkMKwYvDYreIlG2g4PQyb2xloZ0lx5HgN3a76DheNXykhjQ4GcoGtBWESyuIF0IoRnaGanCdDg+KWNsPt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHoIPTYq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHoIPTYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788402155; x=1819938155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2FylJuc1bUlmzziQDSOEpFEiKXb4o1cAdJT/La54P+s=;
  b=oHoIPTYqiWBBBHAgYGyhHriSxh/zDgkWH35ouOD+nIPndGxDrdti4JvA
   iPtADDal5HlQv5/g0iwqLKKnrmcBGHoRo5zh2vjesAHyU1A+bh00kV9LF
   75Scp9xsVdxMN3lfNTs1Nif7Sxei1NLg176g2sY+IFGwhaXboOxv8gQTZ
   pLg5+mBcvWQqm09Q3zbDV/xTfJBZfdb0Hduwe3SPuWMCJesf4H7Qy2KKM
   NnfjpavksZ1t3BE5sYrbayVqsiKVRNUs0iBo++ptcfqfd+aOxXujWBf9K
   ty6K0J1kU7iJgzJrO4sBzeeD2MKDPqlF86hLiIrUahphCPIs9wHmjHbLS
   g==;
X-CSE-ConnectionGUID: 0+KKFTcVTOyqdtmnzg/Qvw==
X-CSE-MsgGUID: VfuEullkSNuFRrcOtsPF1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="111646160"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="111646160"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 19:22:33 -0700
X-CSE-ConnectionGUID: aS/ziKItQPSC9lAYFzYSAg==
X-CSE-MsgGUID: YD2zS5i2SAKWci+n31q1Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="299450316"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 19:22:31 -0700
Message-ID: <d47c8cc6-242b-4ebf-89f2-0909abdaadd5@linux.intel.com>
Date: Thu, 3 Sep 2026 10:22:28 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] KVM: TDX: Report CORE_CAPABILITIES as configurable
To: Kishen Maloor <kishen.maloor@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-3-binbin.wu@linux.intel.com>
 <73beeef9-3ecf-49fc-87e3-6fa30f8f56d3@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <73beeef9-3ecf-49fc-87e3-6fa30f8f56d3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 1:43 AM, Kishen Maloor wrote:
> On 8/26/26 8:18 PM, Binbin Wu wrote:
>> Reporting CORE_CAPABILITIES as configurable keeps userspace able to enable
>> the bit across the fixed-1 => configurable transition, and lets userspace
>> infer that the bit is no longer fixed-1 so it can adjust its expectations.
>> ...
>> @@ -147,6 +147,12 @@ static void __init tdx_initialize_cpu_cfg_caps(void)
>> +		/*
>> +		 * KVM does not support MSR_IA32_CORE_CAPS, but older TDX specs
>> +		 * define this bit as fixed-1.  Report it as configurable so
>> +		 * userspace can know the feature is no longer a fixed-1 bit.
>> +		 */
>> +		TDX_CFG_EXTRA_F(CORE_CAPABILITIES),
> 
> Would a mask of the bits that are fixed-1 across the modules KVM supports today
> be worth carrying, or adding to the allowed set?
> I assume it would be hardcoded, just as the allowed list is.

This version doesn't include fixed-1 bits or other non-"directly configurable"
bits to minimize the code footprint.


> 
> If a module update later made one of them configurable, userspace would keep the
> ability to set it -- something it has today with the denylist. And since such
> bits are already enabled in every TD running now, continuing to accept them 
> can't turn on anything that isn't already on.

After discussions with the TDX module team, there is one potential backward
compatibility issue regarding x86 feature deprecation. I raised the it as
in the cover letter and there were discussions.
https://lore.kernel.org/kvm/1deddc78d14326b378ddd62ad99c21d66da401e6.camel@intel.com/

> 
> A bit that becomes fixed-1 in the future and configurable after a subsequent
> module update would still need a patch to the mask, just as this patch does.
> Is CORE_CAPABILITIES the only fixed-1 case so far?

Actually this is the #VE reduction on fixed-1 bit, which changes a previous fixed-1
bit to directly configurable.
There are several cases of this category, i.e. MCA/MCE/MTRR/CORE_CAPABILITIES.
However, CORE_CAPABILITIES is the only case that KVM doesn't support for non-TDX
VMs
I will add these info to the change log.
