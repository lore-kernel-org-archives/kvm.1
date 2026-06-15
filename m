Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11CF2F7F00;
	Mon, 15 Jun 2026 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500410; cv=none; b=cyU9wbRWMDuEuSkSUnpfQGsZk3yUE8T3fcBobKIvCaWLsfPLouulF9u/X5YtX2o9JppHYLkhcjGAaJXtLwlI+MHnMwlDAsDxWekrdl+0vTX952vd3AgXvS22jXCk1gfYIVyAovrts5epxHlHr3WpZOKFbD+BWpYaAm3AWuxDoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500410; c=relaxed/simple;
	bh=8ptWM84yVkNPkPv/TK5u8Fpcbw3idFe3zmrK5Yd5FxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kolhvau2l9KiPmQX8n4DartVUrVkbMejKuIXQvPfNFXGd5NWATeNVfAvJuz2ewDW21AMkx8Pa4ql1Zc7S9MrbbvShyihZiUCfH1mjJEu9veCUmCc/8wXvUhpvfYtAtt1GI01Qi0ex+Y9fqx6xBXDb+tHEwM19hvOK03m+5FCwlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SS208MCj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SS208MCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781500409; x=1813036409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ptWM84yVkNPkPv/TK5u8Fpcbw3idFe3zmrK5Yd5FxY=;
  b=SS208MCj9cppDLioIGf0drmv2nUvZQfK2J3t4a2BbrFMazmkepwGbRK0
   av7Mu4MA2spXfKntQX0cfggx1V3g8E6h4suMXS9LXk/SHBvoIJ+4fnuFt
   BvPmoQvcJfHpGkdhurE66Zc/bPCSPEAhg3mEd5z5+GFINYIM+Wuu8Ya7f
   p6CZeJrJOMlAd6XY2M+RhRwxN3rbI3pZ2FqLt6uR6PK8l7luHOQTjSdsx
   CBpfDtdE5cnL1A7rhZrliOpUtym1o2COc2OZSvFfbNyNjhCehJFM9PwvA
   miufHzjIOVu8aDKI8r5oi72uRVbcQR9yoXnjLJ0nG/ndGg82AaPG+ReHe
   A==;
X-CSE-ConnectionGUID: I/C1rGh1QR+hVmqbtQMKag==
X-CSE-MsgGUID: 110T0xKUQIuWRAo8fI7ZBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="107662827"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="107662827"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:13:28 -0700
X-CSE-ConnectionGUID: UqFznRSzQK+awcTU87+UTA==
X-CSE-MsgGUID: KAdC6pKnRFadvZ3CoxJ4nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="247459531"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:13:26 -0700
Message-ID: <01e58880-844c-4e5c-825c-ed7c3ab65454@linux.intel.com>
Date: Mon, 15 Jun 2026 13:13:23 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/30] KVM: x86: Rename __{g,s}et_sregs2() =>
 kvm_x86_vcpu_ioctl_{g,s}et_sregs2()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-4-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Rename the KVM_{G,S}ET_SREGS2 helpers in anticipation of moving them out of
> x86.c (while leaving the ioctl dispatch behind).  Having globally visible
> APIs named __{g,s}et_sregs2() would be "fine", but ugly, given that
> __{g,s}et_sregs() will NOT be globally visible.  As a bonus, this makes it
> a bit more obvious that the helpers implement newer versions of
> kvm_arch_vcpu_ioctl_set_sregs().
> 
> No functional change intended.
> 
> Cc: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0f48cd630c32..0fa8a9e3b8b2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -133,8 +133,10 @@ static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
>  static void store_regs(struct kvm_vcpu *vcpu);
>  static int sync_regs(struct kvm_vcpu *vcpu);
>  
> -static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> -static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> +static int kvm_x86_vcpu_ioctl_set_sregs2(struct kvm_vcpu *vcpu,
> +					 struct kvm_sregs2 *sregs2);
> +static void kvm_x86_vcpu_ioctl_get_sregs2(struct kvm_vcpu *vcpu,
> +					  struct kvm_sregs2 *sregs2);
>  

Existing code uses the pattern kvm_vcpu_ioctl_x86_xxx, is it better to
align the pattern?


>  static DEFINE_MUTEX(vendor_module_lock);
>  static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
> @@ -6623,7 +6625,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = -ENOMEM;
>  		if (!u.sregs2)
>  			goto out;
> -		__get_sregs2(vcpu, u.sregs2);
> +		kvm_x86_vcpu_ioctl_get_sregs2(vcpu, u.sregs2);
>  		r = -EFAULT;
>  		if (copy_to_user(argp, u.sregs2, sizeof(struct kvm_sregs2)))
>  			goto out;
> @@ -6642,7 +6644,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  			u.sregs2 = NULL;
>  			goto out;
>  		}
> -		r = __set_sregs2(vcpu, u.sregs2);
> +		r = kvm_x86_vcpu_ioctl_set_sregs2(vcpu, u.sregs2);
>  		break;
>  	}
>  	case KVM_HAS_DEVICE_ATTR:
> @@ -12210,7 +12212,8 @@ static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>  			(unsigned long *)sregs->interrupt_bitmap);
>  }
>  
> -static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
> +static void kvm_x86_vcpu_ioctl_get_sregs2(struct kvm_vcpu *vcpu,
> +					  struct kvm_sregs2 *sregs2)
>  {
>  	int i;
>  
> @@ -12480,7 +12483,8 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>  	return 0;
>  }
>  
> -static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
> +static int kvm_x86_vcpu_ioctl_set_sregs2(struct kvm_vcpu *vcpu,
> +					 struct kvm_sregs2 *sregs2)
>  {
>  	int mmu_reset_needed = 0;
>  	bool valid_pdptrs = sregs2->flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;

