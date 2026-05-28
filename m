Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F353F0A95
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973263; cv=none; b=Iv7smrTqEmrp2yJaWXNqbN9rShGH1OPdB46jyLVBp+e/J7FWy/igtc6f0Ys4xeLC1IDMI1F0zp6jOardyPArsM8nomyKDQT+1tEJOSihgmJ92wC5l/TibVMkbr7GtHICcMjSbXZ9fd7v+KDb95jD2StbInSkcHSqiw60o/3ik4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973263; c=relaxed/simple;
	bh=BomnCaWw3yF6MWCixmAUHRDKEuHyoU2SOULQoPH2OqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ODMryeVn3zDHxgBCZ/xUaa7JIBzMmHL2TMSTLDgNeQ1Hxq7qKR5elZo2Mw93cbWRWVBkYS2vbHyp0ze4H/LMTSMdoLZZD30774zLbOm6uLNHs4PSiOWwspXsu83MKB5MTdNQTXKF7gHuO/Boxnadn7M+zGbvY+4YegqSsapJxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/O3XE8F; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/O3XE8F"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba3245a43dso144507865ad.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779973261; x=1780578061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvB2rHH5Zh/6yFKETh++PPYrvjeDOz8ZuprlUZqaUB0=;
        b=T/O3XE8Fxk5Rx1p+plrjDfRvJEB5VqDCJFjIDLbciwmq2wuK1c5RbGaUGhkiwAhMGO
         CWCmQcnK0YPvaE+Cvu8jMQm2NpAEn+bekI6mPxWWc2wfSnYjLkKS2p5iZP9yFndcSopa
         AssnVMfE5lqUUrc5KEY7hmDcaKkgCNJhuUQZeIlk4FtQKPuvFofgap5UZgrC0EVkUrsT
         s0KvOiZDofrEVdg6/kxRpQEAWa9/bU+mcwnl7TVTxhGqLJ8j0udFgtyw+vq24VK76ckH
         1AEdGKnRS/61Y37I/QFTiyafZMQPRcfGkYRG7m9PMW1AgpKazYDRkvlFUrx72t9Wg49Y
         vCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973261; x=1780578061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvB2rHH5Zh/6yFKETh++PPYrvjeDOz8ZuprlUZqaUB0=;
        b=ENZQe3MwX1ee7fohWO5RR1RjHeuvJYqFa5ZxYaOgtN0VXuN149toI7i75jg4EplDi/
         vH4EndYUV7hu2gEaS87RpVnOV7DRfy5lzKypvJIPpwAHQGuc5+Pb19TOmm0CYEvum9lH
         JI4DlBp3qX8T/D/P3HP4CagIo0zcuGDCa47S3o6WVjYYtGPQ3YQoGUEzwTzJIuB1mmjC
         VEFvHuGhW5duOyPkUiwPC81FXEy1PdpoXSl0v2CqWXEj1DAOyHP+LUi3Bz7bcJhiJxOy
         caAYo66W0z5OXDgJd+iEMl4CFTcyeoDKvn9uoNXc6bWnTKUPQ7J/t5+pz8G8ancbDv8+
         ejog==
X-Forwarded-Encrypted: i=1; AFNElJ/HCFIglFhpGeMl0K5aP09STaaG+k1aO7/rmOA5t4Lt2Ojkkn1cqDJTAgi9z7cEdCelgUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ4aUCgm6F5HWoLFf6QBabu8VMFTg5Z4MpRqmRqv3Gh9JPpzuF
	ffAaWv6jSRg9t7p/KFUriFfV11gUTHLu3+O8BVHIrNpFWTp3NPRwihJWvxaYXrjv1gLuawlqhnY
	Hxyrx7w==
X-Received: from plpw23.prod.google.com ([2002:a17:902:9a97:b0:2bd:e92a:169b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b8c:b0:2be:1db0:f166
 with SMTP id d9443c01a7336-2beb0346484mr302553785ad.10.1779973260553; Thu, 28
 May 2026 06:01:00 -0700 (PDT)
Date: Thu, 28 May 2026 06:00:59 -0700
In-Reply-To: <20260528071712.1407929-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528071712.1407929-1-xiaoyao.li@intel.com>
Message-ID: <ahg8i_Zv9TRk-UzE@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/run: Use separate "-accel" option to
 configure the accelerator
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, Xiaoyao Li wrote:
> When configuring accelerator via machine's "accel" property, it cannot
> pass additional ACCEL_PROPS. For example, it hits following error when
> configuring KVM with "notify-vmexit":
> 
>   # ACCEL="kvm,notify-vmexit=internal-error" ./x86-run x86/apic.c
>   #   qemu-system-x86_64: Property 'pc-i440fx-11.1-machine.notify-vmexit' not found
> 
> Switch to use separate "-accel" option to configure the accelerator.
> 
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

This breaks my setup for specifying kernel_irqchip=split.

  qemu: -accel kvm,kernel_irqchip=split: Property 'kvm-accel.kernel_irqchip' not found

>  if [ "${CONFIG_EFI}" != y ]; then
>  	command+=" -kernel"
>  fi
> -- 
> 2.43.0
> 
