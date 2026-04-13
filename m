Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E463112C0
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098550; cv=none; b=G3v51ANl0yG+DOVkbehVz42qkri6umU3D7BNHqS4t6apAR38cQwQoisX1GpzXxaP6vKjzcFMgqhfdDDVZHj3rFC502jHo0Gg8Wdxl1wAd2VKD42emoVbfK4Gvd2rnhb7qi8gZd2DstzL9occdYjKFViHdaZU6wg3S/DXXmAfiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098550; c=relaxed/simple;
	bh=IFX/sd70GB/OyEU++22WH2LmwkHyzc5ytEPoWJ/ZF3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UmtHlaQD1FC/6uNLkDz/DsJCzbpaVLEz82qHeVdAY+T7E+QpmUOMQ8VYxa0jas2NsAFlnKJhTg8sQopJ6R6kYJdbutUZgvrsLH9xuwTA4JAAk+/0X9LZ2vi2He7t0lv0LES30ATi/iCxJJuEr2n5BQw3YkEn15F6LCh5dbMoVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaEDllKp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaEDllKp"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b6ccf298so2631546a12.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776098548; x=1776703348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=591w7KaD0ZXd0J+hjRAXxTj9gsC6Fb4Gv7lYMSBAQwA=;
        b=IaEDllKpZzIKQOk6mAdNt0Lkgn4Sdg5kiDX6b6Sv92Dun3k3QiVtX88ca70eLBodyn
         u0ipP1/3EJND3SBYIkEifg26imMLStrSv5me3KkoZ/k4cbo2WMaKiLJyhq6zzH0svRip
         m1WzzuPSKs4WN814QVqXjzvnaBbBGXlR97qNOu83mLO+BheZoyJTKatNKLnCvFwzu2kv
         ZHlPO35PRhplVWBdIp1/gGzFoJqVBCrbTKM9HTI+pmFe9lakNYwrkXa9yiRRESqdErVf
         UpYINMa4YsWidJwOxkSHEaRPyV0d5QHNnF0NsOADHTRT2fwbDsFpTzMohmWjWmoEy34W
         ztQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776098548; x=1776703348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=591w7KaD0ZXd0J+hjRAXxTj9gsC6Fb4Gv7lYMSBAQwA=;
        b=ZwXhe/XO5mZnt4a6emWWYmyJK2kV7IvyPQoocn6ng99LzkFs4mO8EvIrhQI2jMdfjk
         REuxPMygsIr+z0/fm41FCpMkGCaaoI87wQ8fK8TvUC0a3Z8I+iidBzMTWGZCP4WntzKQ
         YpXcMJh/cUS/vV949MdOWXft0uZSWcxpjLDtHu8GX+kc/TPppTUElRMlpepkwg5mjmVK
         JoXt/dKSWjpXHCsm8PgU9+jkzhp/Y417SWY/L+lT4P2/X8g7gPhVxIlufqPVRQOR7mx7
         0a2197LcYXCa72D2Xq5RUH3YJPFUevM/tFq5Cmb/aJrdkCmL2WpEKuGnpmoLVO9TDew0
         G5kw==
X-Forwarded-Encrypted: i=1; AFNElJ8E1fHz0nFbBM3wsbni1uWQnXTIjzSWLFM5gZs11+E2QH4Wzb0fopHuF/2RIcGQFc+tz/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+JkkM1ZU1imx9yDY4DNGXvUUASiO5d6GcwdqajX6zSXA8n8y
	RXDVQYG+MznmdoUllONnT9k50P32k8zYLH7q/uAVIT4fia6Lj3WAn534wb95G0IeGKRqAX2XnL1
	HJecqCg==
X-Received: from pfbkh38.prod.google.com ([2002:a05:6a00:9466:b0:82a:5ddb:b051])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:916a:b0:82c:e83d:a9a3
 with SMTP id d2e1a72fcca58-82f0c18a855mr11872515b3a.22.1776098548074; Mon, 13
 Apr 2026 09:42:28 -0700 (PDT)
Date: Mon, 13 Apr 2026 09:42:26 -0700
In-Reply-To: <202604131813.Sp3bcsFp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202604131813.Sp3bcsFp-lkp@intel.com>
Message-ID: <ad0c8lNL5ZoSRZI6@google.com>
Subject: Re: [kvm:queue 12/12] arch/x86/kvm/svm/avic.c:240:39: error: passing
 argument 1 of 'is_sev_es_guest' from incompatible pointer type
From: Sean Christopherson <seanjc@google.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org, 
	Farrah Chen <farrah.chen@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 13, 2026, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
> head:   8f65c76d62f1f07d68b8a14829a59049311547b1
> commit: 8f65c76d62f1f07d68b8a14829a59049311547b1 [12/12] Merge tag 'kvm-x86-svm-7.1' of https://github.com/kvm-x86/linux into HEAD
> config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260413/202604131813.Sp3bcsFp-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260413/202604131813.Sp3bcsFp-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604131813.Sp3bcsFp-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/kvm/svm/avic.c: In function 'avic_deactivate_vmcb':
> >> arch/x86/kvm/svm/avic.c:240:39: error: passing argument 1 of 'is_sev_es_guest' from incompatible pointer type [-Wincompatible-pointer-types]
>      240 |         if (!is_sev_es_guest(svm->vcpu.kvm))
>          |                              ~~~~~~~~~^~~~
>          |                                       |
>          |                                       struct kvm *
>    In file included from arch/x86/kvm/svm/avic.c:31:
>    arch/x86/kvm/svm/svm.h:415:62: note: expected 'struct kvm_vcpu *' but argument is of type 'struct kvm *'
>      415 | static __always_inline bool is_sev_es_guest(struct kvm_vcpu *vcpu)
>          |                                             ~~~~~~~~~~~~~~~~~^~~~
> 
> 
> vim +/is_sev_es_guest +240 arch/x86/kvm/svm/avic.c
> 
>    232	
>    233	static void avic_deactivate_vmcb(struct vcpu_svm *svm)
>    234	{
>    235		struct vmcb *vmcb = svm->vmcb01.ptr;
>    236	
>    237		vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
>    238		vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
>    239	
>  > 240		if (!is_sev_es_guest(svm->vcpu.kvm))
>    241			svm_set_intercept(svm, INTERCEPT_CR8_WRITE);

Ha!  Not my fault :-)

The resolution should have been:

diff --cc arch/x86/kvm/svm/avic.c
index 2885c5993ebc,7056c4891f93..adf211860949
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@@ -226,9 -237,6 +237,9 @@@ static void avic_deactivate_vmcb(struc
        vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
        vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;

-       if (!sev_es_guest(svm->vcpu.kvm))
++      if (!is_sev_es_guest(&svm->vcpu))
 +              svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
 +
        /*
         * If running nested and the guest uses its own MSR bitmap, there
         * is no need to update L0's msr bitmap

>    242	
>    243		/*
>    244		 * If running nested and the guest uses its own MSR bitmap, there
>    245		 * is no need to update L0's msr bitmap
>    246		 */
>    247		if (is_guest_mode(&svm->vcpu) &&
>    248		    vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_MSR_PROT))
>    249			return;
>    250	
>    251		/* Enabling MSR intercept for x2APIC registers */
>    252		avic_set_x2apic_msr_interception(svm, true);
>    253	}
>    254	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
