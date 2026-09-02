Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5D33A708;
	Wed,  2 Sep 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356357; cv=none; b=KNSb9fxuWQ8u2nnOUt3BvOBN6KAeeXlAfhbbNyqFYDYeuGhL8ck2tmcBAEEAOa07c/PiFFBRnAohu1vruGk7wbh4Oj5KuMQSvJ8bkzIHG/lnLeQiqHiHCLWMtRPxt53YZht036gr5GAyj7KTDoEKQkp6UMeOZD3rp1vmMRoD0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356357; c=relaxed/simple;
	bh=m2cgfjeYTUH+l5b6BxYg57dZkIziC7id9lu9aHjLSnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nopV3VWg0fTJOyM9ILr/BKu8JHny6bJ92vrE9L7P7sfmce4JJO9j6Zw0qb8MlSCQMehbLwXQhTcRS4kIwUe4NKZMmA2sY3N1LWvJR+jvrCIO3l+rbFDl2b2qSFmNv8EW6eNTDnNYehfJgkssSAbYKhWGO9PiEYMaeFzvN5KxC44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PI/s/53j; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PI/s/53j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788356356; x=1819892356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m2cgfjeYTUH+l5b6BxYg57dZkIziC7id9lu9aHjLSnU=;
  b=PI/s/53j/eK1kshMgvdfrml4la9LXMmbE4Da60la0dbZ2+Z/RpQ/BVmt
   eBgaUtBbT2kw1a78Q+uR2GvFDhiIH5UImc3Oa9IlnILQyXaFKEQ8qEVht
   fPOn9lgHszMn25aeOCKXzPPzgVn5N3M2rIo0KUxk3Lkze8mbfA3A7046L
   TVUqNAEJE1wNT0jE4hw3HpMmXnZBrpXPwFnICDFOKydDgWnww47dFTbXQ
   mAvo3soi1nvVoPlpLWxSG3f7J2PdxL79FU4n8nwMBx8hjuh0KPFhyKW38
   GEtOVmyMSL/8kYs90Z/9j5pKuM0CjpTm2xwM3gOu5g18AvZjRzQ8uKk/S
   w==;
X-CSE-ConnectionGUID: pazSwE6oRkC7KRgdMcGGYw==
X-CSE-MsgGUID: RAB4LDSIRKuubPSCAm8jrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88692121"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88692121"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:39:16 -0700
X-CSE-ConnectionGUID: DTXngitjSJWVIXQsNv0A4g==
X-CSE-MsgGUID: JWtBVwRQTwarpY5bWk0ctg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="263249547"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:39:12 -0700
Message-ID: <f4594d40-cc15-41c8-99f1-2db590bba2ef@intel.com>
Date: Wed, 2 Sep 2026 21:39:10 +0800
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
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Cc: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
 "Gao, Chao" <chao.gao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
 <6f8f2c59-3336-4ed8-837f-57cb706ece30@intel.com>
 <69c42183261acb4150961cabf6318b92765b6562.camel@intel.com>
 <91c9e314-6b92-4f90-a2df-ed21104f84bc@intel.com>
 <e4b9509c4e4b91277a30f88cb7ca76c8ba016997.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <e4b9509c4e4b91277a30f88cb7ca76c8ba016997.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/2026 9:13 PM, Edgecombe, Rick P wrote:
> On Wed, 2026-09-02 at 18:29 +0800, Xiaoyao Li wrote:
>> So the proposal is making TDX behave as if the relevant VMCS save/load 
>> controls (if any) are set around TDH.VP.ENTER.
>>
>> In fact, what matters for host vmm is just the VM_EXIT_LOAD_XXX control. 
>> So the proposal becomes "If there is VM_EXIT_LOAD_XXX control for a 
>> state, TDX needs to restore the host state after TDH.VP.ENTER. If no 
>> such contorl, TDX sets the state to INIT state after TDH.VP.ENTER".
>>
>> It's a fancy idea. And it provides a clear rule of how TDX handles 
>> states of a feature so that host VMM developers don't need to read the 
>> TDX module API to figure out what's the value of a state after TDH.VP.ENTER.
>>
>> It's helpful for host VMM developers, though I'm not sure on TDX module 
>> developers.
> 
> I don't think they have agreed to it yet (Binbin?), but I think it mostly works
> this way already. Why do you think it is a burden on TDX module developers?

Because it can bring confusion to TDX module developers. VM_EXIT_LOAD_XXX control
is used by SEAM VMCS to load states for TDX module execution context. And I think
for most features SEAM VMCS doesn't set it (I don't check it though).

SEAMCALL is kind of a VM exit, and SEAMRET is kind of a VM entry. To automatically
save and restore the host state, what TDX needs are VM_EXIT_SAVE_XXX, VM_ENTRY_LOAD_XXX,
and vmcs guest state for XXX.
