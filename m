Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A8234964
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617423; cv=none; b=dBOSTlLcF8KFOihnlaXe3sVzGblM9XT6JKCz5FWziZkY42gyW9+7X+OfCARLZKCIFETm/IJWxRJfvSAlc+F98CTefwoNeko1ZNCQAlhXwVYdRE08uG/0BNXZBWKzyZqf2D2wJnRt8QUlxhv5zpIbOtydKLIVBiLb7Q5U1aHckPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617423; c=relaxed/simple;
	bh=3+e0GezlsvyH/S6izkE5dDoIb4To1n7k6LVkzTpZXkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9BJBADs9CJ01/FWoU7V2+IhB0a8KKQnRc+alVgxngcyRRfr4zcKc4KMx2+Pu0CyvPutpeCCTUXvmgzJR5+fcURNZkDYtfzztXrgqGm/EzvohSMDH8yHoT9qg1lvJD51bSL/3ulD22PTV6FEisd5aUXEBajhU6U00/nxAiZ/yaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9YgdOcC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9YgdOcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791617422; x=1823153422;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3+e0GezlsvyH/S6izkE5dDoIb4To1n7k6LVkzTpZXkw=;
  b=f9YgdOcCzvVfMZAO5kgT3Vo29NFbA5tRlxY+4F9LOeESS+BG6sov25KT
   CUY61wn1SCZXSwrQqCNFMYdmppQYa3yAqHItTBp50vXcCjR/MNrYXD8Ko
   T4498789s+mtqv02NZ2wD+vtxFXfYNki/Rtgi/n1MmVWnfStB2srKZxnQ
   CvixJoaltEos/5GKd8F7bgJc9DyPJQLZRTIlXSwEbKVrih7E9IolOm4sm
   ibKwpf5u6QZeOUx0ynNmu7k5p/IaQ6bAFsLDTmTe6oJSsSB6/dOFDPqnh
   PLj4R2812LHAD5fyT7NkpAxkUgXxgSEkeguaPC0/baaYcFYKeFt6t8UQY
   g==;
X-CSE-ConnectionGUID: 0PABWRzbRmKun3rGSUVwZA==
X-CSE-MsgGUID: lnS2rhUeSjyzbFObMiIItA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="415169"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="415169"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 00:30:21 -0700
X-CSE-ConnectionGUID: iVZtBE0CRnKwIkiAGsIn7g==
X-CSE-MsgGUID: ckTGE4KDSJaVtUsGVA/gYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="413957"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 00:30:20 -0700
Message-ID: <09a9a670-b2e8-401c-b862-461927e46b29@linux.intel.com>
Date: Sat, 10 Oct 2026 15:30:17 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 22/23] KVM: selftests: Add support for TDX ucalls, via
 TDVMCALL_REPORT_FATAL_ERROR
To: sashiko-reviews@lists.linux.dev, Lisa Wang <wyihan@google.com>
Cc: kvm@vger.kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-22-7c62a5d8a992@google.com>
 <20261002091337.9BDF91F0089A@smtp.kernel.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261002091337.9BDF91F0089A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 5:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kvm: selftests: ucall global state poisoning breaks mixed-VM testing
> --
> 
> commit 742d058040571d70e8a67c18a52e7026f4abe945
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR
> 
> This commit adds support for performing ucalls on TDX by utilizing the
> TDVMCALL_REPORT_FATAL_ERROR hypercall. It replaces the default ucall
> operations with TDX-specific handlers when a TDX VM is initialized.
> 
>> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
>> index c003df3c7b8a8..c1cd32d684646 100644
>> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
>> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> 
> [ ... ]
> 
>> @@ -37,6 +57,11 @@ static struct {
>>  
>>  void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
>>  {
>> +	if (is_tdx_vm(vm)) {
>> +		ucall_x86_ops.do_ucall = ucall_tdx_do_ucall;
>> +		ucall_x86_ops.get_ucall = ucall_tdx_get_ucall;
>> +	}
>> +
> 
> [Severity: Medium]
> Since ucall_x86_ops is a process-wide global struct, does modifying it here
> without an else branch to restore the default handlers break mixed-VM testing?
> 
> If a process creates a TDX VM and later creates a non-TDX VM, the non-TDX VM
> will inherit these TDX handlers. When sync_global_to_guest() is called, this
> modified state syncs into the non-TDX VM's memory, which might cause the
> guest to incorrectly issue TDCALL for ucalls, leading to an Invalid Opcode
> exception in the non-TDX guest.

Is it a possible scenario to test with TDX and non-TDX VMs in one process?

> 
> Additionally, host-side dispatch via ucall_arch_get_ucall() relies on this
> globally assigned pointer:
> 
> void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> {
> 	return ucall_x86_ops.get_ucall(vcpu);
> }
> 
> Will this cause the host to dispatch based on the last initialized VM rather
> than dynamically checking is_tdx_vm(vcpu->vm)?
> 
>>  	sync_global_to_guest(vm, ucall_x86_ops);
>>  }
> 

