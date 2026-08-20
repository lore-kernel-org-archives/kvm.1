Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1293191CA;
	Thu, 20 Aug 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215742; cv=none; b=c2Wtr1YUrkbiMFcafy98xcLaeSDdMdvSyw3neg/aUMsL0E5Aj6QQMcv/UBhgcv9G3X3XX9TcTA4nl65e+x3Q5R+LsoOZ5gT8iDaC5nz2bD4kDbxp4up+Q7Wm5D+GFYz5tBcb7ELg8SSMA771gcnkMJ/qb/qV9Gbiljqc8cqpMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215742; c=relaxed/simple;
	bh=k+VrWgshbzW13mrb1Xhl43rLpGsuAuxT0KDf1lCSJuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdx/0ayaSQOKd3nUqrGIFKUGqKhLKbXjY5PrtRQLbpCsxyNvlz+JaFzRhhK21R2OKuuWWuL2ZhX6zxcV5vqIoSZy992ul747cI2uCZzVDWv8OLSAZ15ylP4CZ1YHIBhYcVrlaG5owjBUf/gxaP8nFYQDFaWlUgVC55nZTD8K3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaIQk1zd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaIQk1zd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787215740; x=1818751740;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k+VrWgshbzW13mrb1Xhl43rLpGsuAuxT0KDf1lCSJuU=;
  b=NaIQk1zdFF4xR3k5GuOD8tOe0aHq46hOH4VyBuHgRFoTMelbqIxvxx0W
   iBNnLlzLSaJf7D6141a/nbuWAXxGjkfZitn+1S7XUizrM3pZVYlkePORv
   C9qq+Vvkvnnx/zFF7SEdjjKBtMFDzdYHZsLJB0PZsKE+TeX13AU5Dfymf
   iCfR+jnGIY9Rcp+QxDaUHzqgWsZIFYznJXFvGlEgUO7keNPwCOTk+pNz6
   O402FDFEU0bmkaJQLy/a1aZf0QsunfoE4sbNdcS32G+K9ahzgf87vPydz
   oUQMn8e5fta6Zren3748ftzV/UbWWCxB7swFFIzHk2Cy/iCTW/Q97U/nh
   w==;
X-CSE-ConnectionGUID: lzv+GxxGRySX/3wGsgOlvQ==
X-CSE-MsgGUID: PQJxp6ItQbOyQcnp4PLB2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="105126352"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="105126352"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 01:49:00 -0700
X-CSE-ConnectionGUID: VZFxgRf9ScGzcP97G0e5bQ==
X-CSE-MsgGUID: 26iQytwFTEy2kCeT+6BQEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="259757534"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 01:48:57 -0700
Message-ID: <09b7c7a8-96ce-4f53-b239-73c436b16df9@linux.intel.com>
Date: Thu, 20 Aug 2026 16:48:54 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] KVM: TDX: Enable Notify VM exit
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 nik.borisov@suse.com
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
 <20260819094903.3060020-2-xiaoyao.li@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260819094903.3060020-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/2026 5:48 PM, Xiaoyao Li wrote:
> Enable Notify VM exit functionality for TDX guests.
> 
> Notify VM exit is an existing feature supported by KVM.  Userspace can
> enable Notify VM exit through KVM_CAP_X86_NOTIFY_VMEXIT when it's
> reported as supported.  However, KVM reports the support of this CAP just
> based on the hardware capability but doesn't differentiate between VMX
> and TDX.  This leads to the issue that userspace can enable this cap for
> TDX guests without getting an error, but the feature is not actually
> enabled because KVM doesn't call the TDX module API to program the
> relevant TD VMCS fields.
> 
> Enable Notify VM exit for TDX guests by:
> 
>   - Invoking TDX module API calls to set NOTIFY_VM_EXITING and Notify
>     Window in TD VMCS.  It's done in tdx_vcpu_init() where other TD VMCS
>     bits are set.  Since TDX vCPU cannot be reset, it only needs to be
>     configured once when initializing the TDX vCPU.
> 
>   - Adding corresponding exit handler for TDX Notify VM Exit.
> 
> Notify VM exit can happen when executing the IRET instruction.  If the
> IRET unblocks the NMI blocking state, bit 12 of the exit qualification
> is set.  In this case, the VMM needs to restore the "blocked by NMI" state
> when it decides to re-enter the guest.  For TDX, KVM cannot manage the
> GUEST_INTERRUPTIBILITY_INFO and it's TDX module's responsibility to
> handle it.  Extract the common part without NMI blocking handling into a
> helper in common.h so that it can be shared between VMX and TDX.
> 
> Note, KVM uses "pre-production" terminology for the feature formally called
> Notify VM-Exit.  All public versions of the SDM refer to the feature as
> Instruction Timeout.  This will be remedied in the near future, for now,
> use KVM's terminology for consistency.
> 
> Note, #2, there is no enumeration bit for Notify VM exit by TDX module
> because all TDX modules support it, and allow to set the corresponding
> TD VMCS fields as long as the hardware supports the feature.
> 
> Fixes: 161d34609f9b ("KVM: TDX: Make TDX VM type supported")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
