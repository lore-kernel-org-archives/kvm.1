Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419DF374A03
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936329; cv=none; b=T1MM5G+Eh994jV6HZwuMf/84qDtKorZAf+SM8piB8aN+opLg8a8gJ7Tv1yL4YJwV7iYpxsp6nAuhDl2EA26UCmm5r+UmT7/kwwkYaYK1n/F1dhHI9MIX/AecNwGLrLLquAU9UKqVDl+JmlfyFjiv1os9ERhXYejSgxMOaWU4akI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936329; c=relaxed/simple;
	bh=PcSEF2MK/cHXB+Kv/gJgOEiv9hBkttCriZtxCNKAB2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MoVokAgkyVXLyo+ubunW1tzaaWJnbCtxriLZLWzBTHUqrjFMnThgqibAZIqTQyopcvfjSab6jkNpQlofl8XvC8jS72EkXU8sVDWCckVhC+5BRyPa5FvBYk+dUFV0g/C/z+cSyYgAw/OaY4vxkeHAEmK9Ub0mXmTGTZqES1abx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c5REi2am; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5REi2am"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8620ee0971so980108a12.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782936327; x=1783541127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ULfZXJnLyQ1iTfhcSHKWEGPX6blmvdMahynjzwdjn4=;
        b=c5REi2amcx4O47eXfCZ6wCVQyPvjZ611Xf98Ib8CUo2gw6pupVbGO2ky8ls4A8nz4N
         U7yBQoog8R7YuiwGWojTktf8o7p00J1KuA4aHB7cQV1q3i9cRKqU5MC79B6AcM6K9bhG
         xcopJl7khCvY3vrHZG883oXhVPE1Vm5wmSapLgURFatjevIQ6JiZhBEW6pGgraSmAf5E
         sWL2mDqS2x03cu1hZfUAtIRdhgqzu/U/oFgriLR/XBARZ6uXSOx1BJgafDq3zxtP+0qs
         co8JR+WpR/o0ZbEMck2TVNoRy9fKnNMNQinuQwtbFOVod4VvF39xX78uVw8RytkTuTJn
         1ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936327; x=1783541127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ULfZXJnLyQ1iTfhcSHKWEGPX6blmvdMahynjzwdjn4=;
        b=F/oFG6OLa+2T77FuDC0Ojz7rI6gKWGgdIk7jXqlK0KA6+LpMVZgZMOhxahCyDsg48P
         +xiWR3edOl8xZYfScf5h1NXZYRv6juJx1ZctS9xptdn+MItyqpPBI9bAXmLBtYozbhD7
         4UqqKF+Np9GqZrlKn2gf7/Adogkc5meMCsUXJ7FkpH3uoL1GrGnTX+fTk5XQoOYldPPH
         zPxNfrJt+3cV0r4VNmRSoONLCo9u9Px9qd8+Df1Mok/UoSW32yUuAFnwcg3kNHB7iwcT
         lmmzSO/M+fXSuwB1Y8cF4w61+jOrDPybyc7TQW3gGwBtVGa3Z7oY/ZXrMNz5QBErcVQ7
         Jt2w==
X-Gm-Message-State: AOJu0YyAx98f9B8R0D7CfJSTojxpjS4ljiZSrubZZWgMa1+Y18cFyswX
	bkR1F6W4Z2cowgeONgifXupcJPu+/PHHN8G8SzT7eO5/22s7s1VIBUV+bQWg7VuQtYUX9pn2WuF
	u2E4jAQ==
X-Received: from pfbfv4.prod.google.com ([2002:a05:6a00:6184:b0:847:9651:d996])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4516:b0:842:5a8d:303a
 with SMTP id d2e1a72fcca58-847c0950567mr3079095b3a.37.1782936327311; Wed, 01
 Jul 2026 13:05:27 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:05:26 -0700
In-Reply-To: <20260701194621.4BD691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-2-seanjc@google.com>
 <20260701194621.4BD691F000E9@smtp.kernel.org>
Message-ID: <akVzBqcJt-H8XCZQ@google.com>
Subject: Re: [PATCH v5 01/51] x86/apic: Provide helpers to set local APIC
 timer period in hz and khz
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index aa1e19979aa8e..8d3d930576fd7 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> 
> [ ... ]
> 
> > @@ -796,6 +796,16 @@ bool __init apic_needs_pit(void)
> >  	return lapic_timer_period == 0;
> >  }
> >  
> > +void apic_set_timer_period_khz(u64 period_khz, const char *source)
> > +{
> > +	lapic_timer_period = mul_u64_u32_div(period_khz, 1000, HZ);
> > +}
> > +
> > +void apic_set_timer_period_hz(u64 period_hz, const char *source)
> > +{
> > +	lapic_timer_period = div_u64(period_hz, HZ);
> > +}
> 
> [Severity: Medium]
> It looks like the source parameter is accepted by apic_set_timer_period_khz()
> and apic_set_timer_period_hz() in arch/x86/kernel/apic/apic.c but is never
> used. Was it intended to log the frequency using this source string?

/facepalm, yes.
