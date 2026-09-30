Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB13655F0;
	Wed, 30 Sep 2026 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744338; cv=none; b=ZN19tMeIbFftCHZvjWQXBwGJ/T2amuSmL1we0dASorfbr4+C5G00a/o7zrYfWC/fNv50xaBp1uDKSArUPLCbaxhBasO18NSNKwO0uhFBBIvkR1YjcLKHINSAyvtyUTlvcApXzvrQThaOMk8NHGYUusYrXRyjabb3OcZdTlVzxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744338; c=relaxed/simple;
	bh=hsZf5e5VlChxQ4CGYkUa32v3Wq/x9KRIHBAF+yDaivI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maBQR+XkSu4zM7LbfoXHiFlj/WLrmTv1dSgVLswv5nviJyMwF8n6XR60RRdCgJ4KIveq6kwpo6cpx85tf799WJZlsrkpcKjFQoO2WVt8o4xd52rOSEBy9OS73EkfQNk4i8wYFHJoVQR5ojxA54/6XUn70dpv2yISnFAukhBTxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DazCyFsq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DazCyFsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790744336; x=1822280336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hsZf5e5VlChxQ4CGYkUa32v3Wq/x9KRIHBAF+yDaivI=;
  b=DazCyFsqrX8t6Ysfj7MmL+8PpTCJcKXby79MkR+ULaLt6jTok45TILUy
   b1bnEy8sVchrUh+kuXO7tw6sUe97XzcD+2aJGSKdRN72ZrmD9tzNqadS1
   DQasyk+isCqUYjeyTLkOiOqN/o1VNwFusNAqsm6T/d3nejueOWN0SiqOo
   Osau9sqlr6WXpeeL4NRMnCP39iW5DjCNW1WWtZwOMQnCDzbAC9z8HYmP0
   9Pl85NPGTYMf7WxpRI7aM/dDxcDu+6s9WxrN3NAAYCOOLJZB7yKlvXksR
   zkD+J8GVU6u/EuHBYS2CsuEyZ5Lei3OR7O0GRuk33QAlH7tJ7WO19XVsU
   A==;
X-CSE-ConnectionGUID: KvLmHe7xRYGlZE+4SCD8aA==
X-CSE-MsgGUID: DPEZDdK+SjiHWwFZYbwJDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91571941"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91571941"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 21:58:55 -0700
X-CSE-ConnectionGUID: lD/5/ZTQTdCv4l+AeE3xFA==
X-CSE-MsgGUID: PLGWriYCTImlgNcZbwGS+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274186275"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 21:58:35 -0700
Message-ID: <e5ef8765-5f9b-4784-9272-bc438d148433@linux.intel.com>
Date: Wed, 30 Sep 2026 12:58:32 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: TDX: Synthesize SHUTDOWN instead of returning
 -EIO on unhandled EPT violation
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 James Houghton <jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Sashiko Bot <sashiko-bot@kernel.org>
References: <20260930001127.3170009-1-seanjc@google.com>
 <20260930001127.3170009-3-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260930001127.3170009-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/2026 8:11 AM, Sean Christopherson wrote:
> Exit to userspace with KVM_EXIT_SHUTDOWN instead of returning -EIO from
> KVM_RUN if KVM encounters an EPT Violation due to a guest access to a
> pending page.  Returning -EIO implies KVM is buggy, and most VMMs will
> respond by completely terminating the VM, versus rebooting the VM in
> response to KVM_EXIT_SHUTDOWN.  I.e. give the VMM the option of trying to
> keep the VM (from the end user's perspective) alive.
> 
> Ideally, KVM would probably exit with KVM_EXIT_MEMORY_FAULT, but KVM would
> need to extend run->memory_fault so that userspace knows the fault can't be
> handled.  This scenario specifically occurs when the guest has deliberately
> disabled #VEs on unaccepted memory for security purposes, i.e. the guest
> literally disabled the mechanism that tells it it screwed up.  But, because
> this is fatal, and the whole point is to NOT try to fixup the fault,
> jumping through hoops to return MEMORY_FAULT instead of SHUTDOWN doesn't
> make a whole lot of sense.
> 
> Don't bother bouncing through KVM_REQ_TRIPLE_FAULT as
> tdx_handle_ept_violation() is a top-level exit handler, i.e. there is no
> need to worry about failing to actually exit to userspace.
> 
> Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
> Cc: stable@vger.kernel.org
> Cc: James Houghton <jthoughton@google.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/vmx/tdx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 29d4751f37fb..e3723f1222fc 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1939,8 +1939,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
>  		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
>  			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
>  				gpa, vcpu->vcpu_id);
> -			kvm_vm_dead(vcpu->kvm);
> -			return -EIO;
> +			kvm_prepare_shutdown_exit(vcpu);
> +			return 0;
>  		}
>  		/*
>  		 * Always treat SEPT violations as write faults.  Ignore the

