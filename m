Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C0340298
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729540; cv=none; b=hQE4KdM5NM5t0e/3JVA3eeQWVfvzUP1vGJEQGxig5xFhCmGrERpJZydDhSFNBiYdf+sBy/fnR993Fv0OIC8132XjfabD/pH1BL9XqHT1TzzwFWnuydwqL1Bi5kUbe6eoSmO2RLPHbQT9NebtpH3kTTQunjFfUvanThoUVDLIE/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729540; c=relaxed/simple;
	bh=vVCpStKwQBNd6wmmES6LAq19FbAIYM5QSaveHdu6a4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfH476J+VQyewsJLlTlqiJu1RPTSkLbJJxgZOuId+uH2PXTBaGC20zHJyx2d2E3vv4uyp409c5NJlKDU29YSCI5ZR5IM9pZdCxmf43k5+AG538QmsHIwkWITqbgo2azb6B3NIR3OmEUE2EgZYbesxspoQpI2qq9WzxrGJqC1M0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kCoExa8N; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCoExa8N"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dfb24dfedfso29263825ad.2
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790729538; x=1791334338; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oI98Ayhzw4RbFHO2K+V0agJoQQc6JpmcneVnzd6gbtU=;
        b=kCoExa8NufZGvKDeCG5KjJcv9LkzdSY4JzgTn0jV1vWaRAoBGw5DKCDOaIbpJNblhy
         1UBKGHm/sMDNTu0zUwE8BA1dZWkeP1R2B8ltrGHsI8ieKQqCypjwdWwqwd3bB4BD3dD+
         pQY4NxI3rTYr46kLP3qWl81YYEDfHB+X+U05BnJD33vhagQkTzZBJc3tVEhpnYdiqeFX
         XjnTXWXH0Ow5RpLwAdRg62z/FmXHfPKCpBJfAyy2lZe3DfC+XysS2MQsnNWLQRIVMDT0
         swDjSXU8pZ2JSj//WvualktmHSQLgKV3fEYSJvfWidtCDllV50wV/cjunHkKbEWTTHqI
         GATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790729538; x=1791334338;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oI98Ayhzw4RbFHO2K+V0agJoQQc6JpmcneVnzd6gbtU=;
        b=e9wNq47fkCTMKKE5evU0kfZW9+tY7+o0gPAny4Zv7gZUdMc6VF5tDcJmJF7pi+xrRA
         MN3F+jCY2bNALfG+kY371r61Rzf9gjs1HMya55O7nsAFr1VO3FT4G7uNAxJ957UnKMHC
         bMlTzBpMe2XjBvjzDy41+XQVjg63Na6F85miYD29iN9woevudq14Hy/5DoGnfwoN7zpn
         vWGHDlh4Rq5HmtBS78aS3+bRtzQUe1/LsVRIXyepCIjPHCXgP7ej3UFDcAIsDTivL/C+
         NpfG2ggeHDUJPTtx2Yxj1/ZeJGDXSE7E900SkHq/SAyxHljamgWC0AdoIeJVZPJ4JOyI
         MN4A==
X-Forwarded-Encrypted: i=1; AKwUvBzrh0GjnWEJTVD5U+TEdnpKRGZF5F5JNBlCMD/mUO2P8cpGeinjESOjfrE1H6sMfzvdlzA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKp0psLzNHJqnbBilGcejex9oUvPTbQg68WyQ6vj3HAoSVH79Xy
	dKrM3MUiPopiTsbKyDw5jP/0LE+Vj0/oMniO7xPPPdtNYt19C4Z2uL9P9xFShGibvXvfkOjs2GA
	vacCCjg==
X-Received: from pjyp16.prod.google.com ([2002:a17:90a:e710:b0:3a0:d194:5942])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5281:b0:3a4:6f87:c0cf
 with SMTP id 98e67ed59e1d1-3a4c00ced30mr726463a91.53.1790729538108; Tue, 29
 Sep 2026 17:52:18 -0700 (PDT)
Date: Tue, 29 Sep 2026 17:52:17 -0700
In-Reply-To: <20260929202434.174501-3-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929202434.174501-1-xiaoyao.li@intel.com> <20260929202434.174501-3-xiaoyao.li@intel.com>
Message-ID: <arxdQWchYIct3TPT@google.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/2] x86/run: Use separate "-accel"
 option to configure the accelerator
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 29, 2026, Xiaoyao Li wrote:
> When configuring accelerator via machine's "accel" property, it cannot
> pass additional ACCEL_PROPS. For example, it hits following error when
> configuring KVM with "notify-vmexit":
> 
>   # ACCEL="kvm,notify-vmexit=internal-error" ./x86-run x86/apic.c
>   #   qemu-system-x86_64: Property 'pc-i440fx-11.1-machine.notify-vmexit' not found
> 
> Switch to use separate "-accel" option to configure the accelerator.

FYI, this breaks the intel_iommu test when running with ACCEL="kvm,kernel-irqchip=on"
because that's a split-only test:

  qemu_params = -M q35,kernel-irqchip=split -device intel-iommu,intremap=on,eim=off -device edu

and QEMU doesn't munge things together:

  qemu: -device intel-iommu,intremap=on,eim=off: Interrupt Remapping cannot work with kernel-irqchip=on, please use 'split|off'.

Given that I'm pretty sure I'm literally the only person the world that runs KUT
with ACCEL="kvm,kernel-irqchip=on", I'm going to apply this as-is.  I can filter
out the failures very easily, and unlike the CET/LAM issue, this doesn't cause
problems for ACCEL="kvm,kernel-irqchip=split", i.e. there's no loss in coverage.

If this impacts someone else, or someone really wants to figure out how to splice
all of this together, I'm happy to revisit things.  For now, I just want to
unblock the notify-vmexit stuff.

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  x86/run | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/x86/run b/x86/run
> index dd38f14c871f..a68d469dd1b8 100755
> --- a/x86/run
> +++ b/x86/run
> @@ -43,7 +43,7 @@ fi
>  pit="-global kvm-pit.lost_tick_policy=discard"
>  
>  command="${qemu} --no-reboot -nodefaults $pit $pc_testdev -display none -serial stdio $pci_testdev"
> -command+=" -machine accel=$ACCEL$ACCEL_PROPS"
> +command+=" -accel $ACCEL$ACCEL_PROPS"
>  if [ "${CONFIG_EFI}" != y ]; then
>  	command+=" -kernel"
>  fi
> -- 
> 2.53.0
> 
> 
