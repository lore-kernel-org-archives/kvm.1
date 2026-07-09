Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8231AA92
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783556924; cv=none; b=BSMbn4rM7V9+C8PExE6ocXmxujhbgcuLcbAguKajE3jzFe9+Xo5rpxSIFnXrHc4ABU7pgwbzoxOOFJQEZ6K6Drr08PDK1hG+5jdgJqshIOzwVbsl0n11fflLWREaVWGGVZpu3vsEDame4mjBMVukXvHtAVxK4pwYhlkoVw5J9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783556924; c=relaxed/simple;
	bh=oDrT+qwnPXYMSJlA6nbtvalAzvpNSDIDPMuaCTIpmp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FAFWyTfIeat8yt9tHQU7MdrqHk3U/XzL9m5eiIXqirPCFBfX5xwSNrnPfl0oWqJpS73tb5VvHv9zrtmD7xjKtV1WmijJfqtOleCj+1H5tvQq8X7pjAZHC3KgNWFo/+Gazsz3r3wtR/woJepPAN9g+jDZZTX79B/2yGbmFSOselc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnfUURIg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnfUURIg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ca860baea9fso495101a12.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 17:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783556922; x=1784161722; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qXo0u7sq+UykXL0ZkW0Yzl8hnbD+Qy12wTSGdkB6L5g=;
        b=rnfUURIgdfpC2MHRGdv/GlScyCLnyZ0S71HQr15noAGl0vbNS1YMiyPZxl+yZighKg
         5EDHIlfxioQhcwuw9XoaiQRnsgrEMv/teeTjKa2ZsOKP7TxWWD7Z5hWrUos3eLO3hwdN
         Zs1Xbd9X98kDbKTKsVcTRbs12akchtHviDhkHmlykro8BNO638AXx28E2fyVyKYO/gKr
         g5Z+0lafQ7g+RxAch4CcqCANesjVrIIoRZX8IbTQykVIyOsAO9gj5mYIpm3Oumr/23SI
         jFAY+YnjKmp+0XtajIiIsRevtiUN6AvSt08UaqBWwADrpMM43/yQr5On6DHYlS6mUXaz
         0UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783556922; x=1784161722;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXo0u7sq+UykXL0ZkW0Yzl8hnbD+Qy12wTSGdkB6L5g=;
        b=edXuRjehzshGXeOcIkqssW0jPAMeD+B67lrsrs0htXSzZaI1pbPIv+HgVa0GU/whlf
         P1kMW0sRhvKYmqS5Qula7SSBDt4KPwdhhu8hZTHiv1PC2fiAiASWHgpckag3P8zFbLwz
         k0BsXOcbPxZOJFKnx5+mFg6cDjzPm0K9gbGTNgi3EQohmoWObhE2IWsxI/Lbl/cXTfy4
         9mmARByQpG+BcU3LXPGCJW3aCrolN6zjqr/i7nxl/e/eutKln9H2RrDZ74ojxQT+dQvV
         BUvVuiu1lkId5CJnkvraclrwbe2MhAhPY/sOvXj3yYYLAdcCcOpvGCVacW9jMJZfGONl
         UXoA==
X-Forwarded-Encrypted: i=1; AHgh+RoU6urZtg826QASq19zgrQ2dQFCa95EKcO2gJYaHRbjnCwNqS4QD/iqs5IYNHqFoc1GNy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjjQDFUAlq6w+Iu0ThwSd07Ry3WViVU9yJ2igM8UnVfV8PoNnu
	vWr015KAPy1mioso2u5cp6a2l8an0eLO98Np5k3+/la89Hj1bBqDzLgiLjCQ8LTw+vd47+e4nhu
	YUOHgYg==
X-Received: from pgbfm1.prod.google.com ([2002:a05:6a02:4981:b0:c96:4086:38b5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e86:b0:3bf:d0c8:2a8b
 with SMTP id adf61e73a8af0-3c0bcfea250mr5870183637.20.1783556921833; Wed, 08
 Jul 2026 17:28:41 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:28:41 -0700
In-Reply-To: <CAEvNRgEFvh8T=v9jzxyYcc3NQzS2-uJctNuZix+mNQO8gwc-RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com> <20260630222607.497895-11-seanjc@google.com>
 <CAEvNRgEFvh8T=v9jzxyYcc3NQzS2-uJctNuZix+mNQO8gwc-RQ@mail.gmail.com>
Message-ID: <ak7rOdtcYyZ4zpN7@google.com>
Subject: Re: [PATCH v3 10/12] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 08, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> >
> > [...snip...]
> >
> > @@ -1902,6 +1905,7 @@ struct kvm_x86_ops {
> >  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
> >  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> >  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > +	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
> >  	void (*gmem_reclaim_memory)(kvm_pfn_t start, kvm_pfn_t end);
> >  #endif
> 
> I suggested CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM_MEMORY before looking at
> this patch.
> 
> Considering this, it seems like gmem_invalidate_range is a true
> invalidation request and .gmem_reclaim_memory is too late for
> invalidation as you explained in the commit message of the renaming
> patch.
> 
> Perhaps the new .gmem_invalidate_range should take over
> CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE, and .gmem_reclaim_memory should
> use a new CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM_MEMORY?
> 
> Are they both invalidations in your opinion?

No, definitely not, I just didn't want to add another Kconfig.  And I still don't,
but I agree that lumping .gmem_reclaim_memory() into GMEM_INVALIDATE doesn't work,
because the behavior of sev_gmem_reclaim_memory() and sev_gmem_invalidate_range()
are completely unrelated.

> If we're clumping SNP configs together,
> CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE is also only enabled by SNP...

Yeah, but while I don't like a Kconfig explosion, I don't really want to end up
with CONFIG_HAVE_KVM_ARCH_GMEM_SNP_HOOKS either.

Oh, wait, isn't CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE going away?  I was going to say
we could bundle .prepare() and .reclaim() together, because conceptually they are
two bookends for updating out-of-band metadata, but that doesn't make a whole lot
of sense if .prepare() is going to disappear.
