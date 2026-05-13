Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74133909AC;
	Wed, 13 May 2026 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674809; cv=none; b=BBRbHbTGzWScsF64trNA6KiNKKtYtaSLZYt0QDerjpZu4lQGpECcCRyfYHG+Z/fUn5sbbTK4Xw4HVvmfnRtgfWVUO1Mo89LG4Jg4XYO/+6m1hEMKdx5VJb479K8tojP0+qLQ09kWvzZ5X2G5k/mKuVFNzx7nuaio5RnRyKLwg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674809; c=relaxed/simple;
	bh=ilTLn9hFirZTlDt1M/PjcaUpolcNqVrg7Z/KqucVhq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yw5eRw0FPU0a+lIOVIB44yoF4sZbksABWgLh93r7sk4+E8vIHPKRXgfcs7gy59K7iNLC0xJEgA4caMbv8xt00rrSQQEGGOWhjYWkW9LzHdT7fFra+UtpH5Zq9ebKERXJTBSa+nuoOS5YIV7IjzXp3aZz2cyh4scGJBZdQLHVR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1a01a0D; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1a01a0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778674807; x=1810210807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ilTLn9hFirZTlDt1M/PjcaUpolcNqVrg7Z/KqucVhq8=;
  b=S1a01a0DHF5umWhjsn5wejA4ZyDOB3yWlPhPfkcEJsqBCxJ33wt1BE2k
   8RCBA4VNSn8GgTKLixvqVCFVmLr3GLt2EKtwkY+uyZA0QD4cg6sukMagX
   rOx2NnKRUJjKsiqGAx0mpetoTvATuuxCXGqvYlU8nzpSz5l0G8ov2H+UA
   ElOh+pEM00T1colaRcrTqJ9IoMJHdrKS7zOEB8Hd+bsUvAFiqfLBQHHXG
   vtCpWy1iat0MhhOFDKPwelBFIjyl+xWBPI/7hIU7ZxiA1Bg9vtglxky2+
   o12dMXQ3Y+U56aXzesFaBZhrzhbA6PxRHmML73j6lxloO8pnmaX7wd8Gw
   w==;
X-CSE-ConnectionGUID: 4MpMVQNjT42I8Oq3XuYCWw==
X-CSE-MsgGUID: CDpvFHcVRR6G6ruZ0NRzvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79631108"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79631108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 05:20:07 -0700
X-CSE-ConnectionGUID: olTkcd/rS2SDtOMZgvAUjQ==
X-CSE-MsgGUID: 6CqpcZ0/Ta+41KSNHST6Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238174767"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 05:20:04 -0700
Message-ID: <0ade3fe5-4834-44a8-a0d4-eae088c4aade@linux.intel.com>
Date: Wed, 13 May 2026 20:20:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
 <4365e457-3d3d-4bc0-ac11-b3d4dfe8ccab@linux.intel.com>
 <20260513110805.GBagRblQVSjxemzwsQ@fat_crate.local>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260513110805.GBagRblQVSjxemzwsQ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/2026 7:08 PM, Borislav Petkov wrote:
> On Wed, May 13, 2026 at 07:02:53PM +0800, Binbin Wu wrote:
>> My version treated it as a bug fix, so I tried to minimize the code change.
> 
> I didn't like
> 
> 	BIT(X86_FEATURE_HYPERVISOR & 0x1f))
> 
> in your patch. I'd use BIT(31) as it does.

It was suggested by Dave in the v1 comment.
https://lore.kernel.org/kvm/1a1b0f7c-aa3f-4758-8e17-bc2176c52952@intel.com/

> 
> But, more importantly, it added yet another place where we test whether we run
> on a HV. And it is high time we unified those because we run more and more on
> HVs nowadays.

Agree.

> 
>> There is one case not covered by setting the global x86_hypervisor_present at this point.
>> Xen PV guest will not go this path, so Xen PV guest will not see the hypervisor bit.
>>
>> But maybe we can just ignore Xen PV guest case today?
> 
> Nothing changes before or after this fix. So Xen PV can be handled
> completely separated from this.

intel_get_platform_id() can be called in Xen PV guest during normal boot.
Using x86_hypervisor_present just doesn't cover the case.
 
My fix was intended to skip reading MSR_IA32_PLATFORM_ID if hypervisor is
detected, I used cpuid_ecx() instead of cpuid_ecx_native() so that Xen PV
guest can also read the hypervisor bit using xen_cpuid() (Xen PV guest has
overwritten the pv ops) to make the coverage complete.


> 
> Thx.
> 

