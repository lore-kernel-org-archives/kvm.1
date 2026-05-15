Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675E3E2AB5
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871143; cv=none; b=bzz5Klg4Po3RxPAYcVJzSX1Bs7c/3TR2mfyypcTdtYNRWKFWYVDsJI2CcenY9DnLT/nBXCyNbr8/JdvUCPYdJqXkolk77qM7dIWTAPa1l+vddZsgqnELTzot90JwduuCVn6dcUlH+cSw6Fa+NqgyvgMZSoUP+OSKdX6P3+LR8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871143; c=relaxed/simple;
	bh=Z4YSGIKnPYxhhK3GxdivDotiOHgPe3Pu7Cbp9v7UPVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XhLL0z0w1SDBDPg9t3hOIEgniCCgYK10Ruptk5ku4iYbdIgcax8M+llS+0ozlRLvohRi56sOgsdShpgRCtUpLG4LyOlw7dOd7lVTu67lJQKsIhGVyFlYCnVaQ4no7F9/VU5nDP8T7l8i2Z7tR057AWMXF57Z7TbhfSO4x8X5a2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoGI17aE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoGI17aE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa6c3a77cso64751b3a.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778871141; x=1779475941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=60v5GYxKUN4AB8kCeUo9/kuwLODyd3tkZU1saNk5/8g=;
        b=OoGI17aEPN/AWdnLDBK2RB3RvpyZ3+lgtZyjFR6MTckHG2ivKr+C1k8hlHFGnwA0Wb
         /9lkr8e+j+VL1exchnbwHecVTbTekhX1EuJWDXlvz3iOi6HP1xt4hShYk+HMt5cM0HWE
         nZc51zXytHDonfPuH2C++4B4s880XYh9WaYgTNbXyQDHKJd5ZlvXuMpk1nOVwRs+tXGP
         rbpsovar3YPj832HtnNPf/qa6MkBmTICUcpn2bZHuvGAlBdfzElLxc0uqWhI6WRoQhjF
         bDnggCnFkfLEo6sQtaWrRumBBgNinHGUMKdFaXyPxkv4hhxb2EF/pjUV04z7fEv3E/KA
         q/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778871141; x=1779475941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60v5GYxKUN4AB8kCeUo9/kuwLODyd3tkZU1saNk5/8g=;
        b=ZVDdXTtYt+DJayYy33Pr4BZaxXXmTZzs4ip/Zr10028F1R/44htI3pfe0qe4spgLR8
         nKK9sZ70ZS888TweobsU3BOUwvLFI6ExF5nG8CS84fOEvf0xBLgtDAinohW6ncfiouv9
         xD/9Cfyn98xSc2tSzQlw+tnTz2+kEK1kM/YnC0trlBqzQ1x8i26PenFcZ3ArE43p8h3r
         IlbJEPleTe3bS5wFn3cgMa0hTl2rFunVEzBL34+gG9Ybei1l+nSpZhM8H2orBqxoL79C
         dfIm31q2HDqyhCgcCZRn9WMy6AG23SgAYPq6l5SjeOVveViLn6ijaylD9RS8x9ZUfVEJ
         TzdA==
X-Forwarded-Encrypted: i=1; AFNElJ86/POCcKx7o5Ecg2UO4P02eYMO00sr2y5z56k3fIlUvMAuXzEhdXKmshkY6p+UzhEYrhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFBkq+7k5Du72wkHqsUPk4nxMl9L58W4bLiS4Hq9B1RPpGmpf
	aRZRSIIr8d+YR5beD+v5PtcvRfizNxLLC/Esib3q+chS9iZLudRLpUB6b7vUKqZjkwnqjw1L5nP
	goSzDEg==
X-Received: from pfbmd2.prod.google.com ([2002:a05:6a00:7702:b0:82f:4183:2832])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:44c8:b0:837:6bb9:acb7
 with SMTP id d2e1a72fcca58-83f3398f093mr5717057b3a.0.1778871141373; Fri, 15
 May 2026 11:52:21 -0700 (PDT)
Date: Fri, 15 May 2026 11:52:20 -0700
In-Reply-To: <20251226062741.4014391-1-yanfei.xu@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251226062741.4014391-1-yanfei.xu@bytedance.com>
Message-ID: <agdrZMRR7oDKZNDK@google.com>
Subject: Re: [PATCH v2] KVM: irqchip: KVM: Reduce allocation overhead in kvm_set_irq_routing()
From: Sean Christopherson <seanjc@google.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, caixiangfeng@bytedance.com, 
	fangying.tommy@bytedance.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 26, 2025, Yanfei Xu wrote:
> In guests with many VFIO devices and MSI-X vectors, kvm_set_irq_routing()
> becomes a high-overhead operation. Each invocation walks the entire IRQ
> routing table and reallocates/frees every routing entry.
> 
> As the routing table grows on each call, entry allocation and freeing
> dominate the execution time of this function. In scenarios such as VM
> live migration or live upgrade, this behavior can introduce unnecessary
> downtime.
> 
> Allocate memory for all routing entries in one shot using kcalloc(),
> allowing them to be freed together with a single kfree() call.
> 
> Example: On a VM with 120 vCPUs and 15 VFIO devices (virtio-net), the
> total number of calls to kzalloc and kfree is over 20000. With this
> change, it is reduced to around 30.

...

> @@ -186,6 +175,12 @@ int kvm_set_irq_routing(struct kvm *kvm,
>  	new = kzalloc(struct_size(new, map, nr_rt_entries), GFP_KERNEL_ACCOUNT);
>  	if (!new)
>  		return -ENOMEM;
> +	e = kcalloc(nr, sizeof(*e), GFP_KERNEL_ACCOUNT);

This needs to be a kv flavor of allocation, or maybe even just a "straight to
vmalloc'd" allocation.  With 20000+ allocations, that means an order-BIG allocations.
So kvzalloc_obj() or kvmalloc_objs()?

And if we're going to allocate one massive array, then we definitely should get
rid of:

	/*
	 * Array indexed by gsi. Each entry contains list of irq chips
	 * the gsi is connected to.
	 */
	struct hlist_head map[];

and kvm_kernel_irq_routing_entry.list.  It'd be easier and faster to have
setup_routing_entry() simply iterate over the array.

Something we should look at (on top of this), is caching the previous routing
table.  I.e. instead of freeing the old table, keep it around, and try to reuse
the old table on the next update.  That would allow eliding the alloc+free
entirely when userspace is changing routing, but not adding or removing entries.
