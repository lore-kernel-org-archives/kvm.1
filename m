Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73B276038;
	Mon, 15 Jun 2026 05:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499738; cv=none; b=RibgSRDPj4OQy5zE4p6gC/WOmTgwXGTiBJClHy1URaKZDfb2wuzuoxpdzvHVDUDACgShfk0aBsZocNfNINdZ1v3N4B6bsFxEFcQE89Mntf1LHJCZHNN6k09KW0KG4vgPFgv+lbpubjNR04zZ7x6zb9Kn0R4fhn/ApkGBwB9KGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499738; c=relaxed/simple;
	bh=3DrKQsLYWR6wjNHQsjH0/DabI5iLJ1JTtSQG9YnGfz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxLVm8/mXgEvU1ZNOoD6t3qAh1MwHdijyynRjCPrP0mqpWNJfh3Wil85F7rzLL3OO1M7HENqikacUUzypInIdT/4+/TNTivdLUm0ECUyJvORzCllRglwGMH3Wzpu0slH/2zNHtUFzGPoB2oUlI6p7UwU4b61yrw28JSXlWWeeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhHheUae; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhHheUae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781499738; x=1813035738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3DrKQsLYWR6wjNHQsjH0/DabI5iLJ1JTtSQG9YnGfz8=;
  b=VhHheUaegKyvczpwRC9jN4q4xOP0QHcsiqBVq/trV0V60n3n/cfiOKrS
   LCefF2EYmIDbdCmNapGu2mpopEj0xyDqnb6O/Dg9GCA7aBqspdVL9gJU3
   EYwJF1vFu2c16KUQhdHjEdeoXm0ryaCf2QJkU1ROl8SyQEADseI708oIO
   65tbCJ68rGPlyu6OrZLncsoXshvj0q3qAvyDaCZBaYygIOxMxCcEK13Mn
   qFTon5UnaJjOtGkggyMvUlfaA2LC0MlqHahddjbhMdYZHkQCJ24ek0k4w
   prz6Ejw95q3znCAJ/GOe5RUolSXBvuz8NjPsFByeV08dbKZ8cEAZBUjek
   g==;
X-CSE-ConnectionGUID: aHdbqtmrQpWSMFba6fNQkw==
X-CSE-MsgGUID: 3Mv/vpnrRda2jytlr5TMAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82244192"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="82244192"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:02:17 -0700
X-CSE-ConnectionGUID: ETOUKiY9S5eI6/OE4+z9Ew==
X-CSE-MsgGUID: yENGTqYbSbygwdbfwoS/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="271049706"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:02:15 -0700
Message-ID: <3dd7d432-6cf4-4cd1-94c8-53dd19da9feb@linux.intel.com>
Date: Mon, 15 Jun 2026 13:02:12 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/30] KVM: x86: Extract REGS and SREGS runtime sync
 code to helpers
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-2-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Extract the REGS and SREGS portions of {store,sync}_regs() into separate
> helpers in anticipation of moving the register specific code out of x86.c
> and into regs.c.
> 
> No functional change intended.
> 
> Cc: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/x86.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index cf122b8c3210..74b8f98dcb24 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12687,7 +12687,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  	return 0;
>  }
>  
> -static void store_regs(struct kvm_vcpu *vcpu)
> +static void kvm_run_sync_regs_to_user(struct kvm_vcpu *vcpu)
>  {
>  	BUILD_BUG_ON(sizeof(struct kvm_sync_regs) > SYNC_REGS_SIZE_BYTES);
>  
> @@ -12696,13 +12696,18 @@ static void store_regs(struct kvm_vcpu *vcpu)
>  
>  	if (vcpu->run->kvm_valid_regs & KVM_SYNC_X86_SREGS)
>  		__get_sregs(vcpu, &vcpu->run->s.regs.sregs);
> +}
> +
> +static void store_regs(struct kvm_vcpu *vcpu)
> +{
> +	kvm_run_sync_regs_to_user(vcpu);
>  
>  	if (vcpu->run->kvm_valid_regs & KVM_SYNC_X86_EVENTS)
>  		kvm_vcpu_ioctl_x86_get_vcpu_events(
>  				vcpu, &vcpu->run->s.regs.events);
>  }
>  
> -static int sync_regs(struct kvm_vcpu *vcpu)
> +static int kvm_run_sync_regs_from_user(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_REGS) {
>  		__set_regs(vcpu, &vcpu->run->s.regs.regs);
> @@ -12718,6 +12723,14 @@ static int sync_regs(struct kvm_vcpu *vcpu)
>  		vcpu->run->kvm_dirty_regs &= ~KVM_SYNC_X86_SREGS;
>  	}
>  
> +	return 0;
> +}
> +
> +static int sync_regs(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_run_sync_regs_from_user(vcpu))
> +		return -EINVAL;
> +
>  	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_EVENTS) {
>  		struct kvm_vcpu_events events = vcpu->run->s.regs.events;
>  

