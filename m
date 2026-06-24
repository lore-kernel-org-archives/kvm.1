Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7206D370AED
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307139; cv=none; b=W6VN8H+jM2i6z+8LwURwYgxnaQglHuhxePtnabIrIbVRDO0rNEmKnXSaGCwQnfX5uKrwnsCQB9CjgOjHXcbe5WQ+4+JjPQp/dxCAGwZ70axXpuwtAx2LDONSmznRNDuPWjA8XdQf8TLbBpU8d3zDn/ypCrHa3BVESHRC6wxpuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307139; c=relaxed/simple;
	bh=mGE1tYmA+kGSWiPrxyKwfqxTfPW+ZKg/3dyYJzL4koY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PuN6MDi5pcS3eqMTQqbSfPEDBbmTA9p7H67EnIKP84JK3k5vGJ3uVPx2gZ3xbF17pLVdJrTDINWhMZyLu+/HWh8UASOwZNp2JExhsuSjy7s13W/C8xl0T4klN/ilSwicRMkqSYeuIoYJ7/nIoVBEeh1H0yEeLxGo3CHRKVB6xhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dB/Mb/Yo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dB/Mb/Yo"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37de7fa80f5so477407a91.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782307138; x=1782911938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NmQyG4j72F26xg99WCY2R6hMRcnqKtCzrcEzc+lTkJE=;
        b=dB/Mb/YoVmIUfFUyw1xuxYh3nK0ww90CGnUF8YWIT4F5SaDhOAMlmQjvqxbKFRRAhx
         5LMIqLguh54ecpGvIEdxn+htccRUN3rStCszo84dlKHWfo49Lz9SG6dxO2m8prCpwrBc
         fiqLFqSsas0TC8QhjIiwVEjyRCEkGh/5qAGMZcDJKxrL/TqwdbZepVM9SNSwrKHNQ54O
         jJH8TvmQrOLjEyFUj7zcWoxPAlgeA4/1vHw8PTjqqB4a/EA2AQx0nh/jtivNFchIcuga
         /X+xsairUY9ofwI6SdX+e8pGm955bD/QQzzjv+uhGwYdqqlMRB5LYnezDIzT3cxWyhM9
         4nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307138; x=1782911938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmQyG4j72F26xg99WCY2R6hMRcnqKtCzrcEzc+lTkJE=;
        b=Flxb6aGbkMSd+HWSAmAHaViF4+cBdqiLuicSxJeKdeVmgepfCGCxAl67x53s/6OOsy
         oX49LYcI/D4WMTvaygJEQ6eAh+DyBtzNV+hy780sehm6b35VlaepDhbJyMs1Xj8Nw3vG
         bl8OKt45osRBjU4AvLmNVQHL/8TLv/Ri7Fic/DmALrREZOx4s4BDpgCA20xRAKBIIAUB
         CxbZsRqM36nUqPN/8NEITnDkssJr0izMTqJtpWNDhjlZ4lykBzlkJVq1nj5m2lvf3nyR
         2jLxHosLkK9JVGG91r3hHl0TgLeytZgjdgLOcB4LdrMPaH3HxIGcoCv/OvaCFxQAvOUM
         xO2Q==
X-Gm-Message-State: AOJu0Ywz/8knwXAdzUZDV4XFghQ2EYWyn1jsDDAoboLGWBjfbwRKp1NQ
	ImXPpDbTZrn/tPb+ssJvH90Un6Eu/UAIDrydhg+D50mXHll7jSSBOwIId3hpKzMug+0MwDENqKA
	6EGpmoA==
X-Received: from pjex8.prod.google.com ([2002:a17:90a:1648:b0:36b:c172:1497])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fcf:b0:369:b9db:b885
 with SMTP id 98e67ed59e1d1-37d4e438f45mr18290838a91.15.1782307137525; Wed, 24
 Jun 2026 06:18:57 -0700 (PDT)
Date: Wed, 24 Jun 2026 06:18:56 -0700
In-Reply-To: <3948934a-eb84-418f-b29e-c1176b47370d@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618185515.2021642-1-seanjc@google.com> <3948934a-eb84-418f-b29e-c1176b47370d@redhat.com>
Message-ID: <ajvZQFzfYKcfgiJo@google.com>
Subject: Re: [PATCH] KVM: x86: Clamp the EOI vector if its OOB instead of
 bugging the kernel
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, Paolo Bonzini wrote:
> On 6/18/26 20:55, Sean Christopherson wrote:
> > If KVM handles an I/O APIC EOI exit request with a bad vector, clamp the
> > vector to 255 and hope for the best instead of bugging the host.  In all
> > likelihood, a missed EOI is survivable for the guest, and it's most
> > definitely not remotely fatal to the host, i.e. potentially panicking the
> > host is completely unjustified.  Arbitrarily use 255 for the dummy vector,
> > the goal is purely to ensure the vector is covered by the bitmap.
> > 
> > Opportunistically ensure the EOI vector isn't negative, as it's a signed
> > integer, i.e. the "greater than 255" check won't guard against setting the
> > vector to a negative value (KVM uses -1 to say "no IRQ" in many flows).
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/x86.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index d9d51803b7b2..fda09e03b960 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -11212,7 +11212,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >   		if (kvm_check_request(KVM_REQ_NMI, vcpu))
> >   			process_nmi(vcpu);
> >   		if (kvm_check_request(KVM_REQ_IOAPIC_EOI_EXIT, vcpu)) {
> > -			BUG_ON(vcpu->arch.pending_ioapic_eoi > 255);
> > +			if (WARN_ON_ONCE(vcpu->arch.pending_ioapic_eoi < 0 ||
> > +					 vcpu->arch.pending_ioapic_eoi > 255))
> > +				vcpu->arch.pending_ioapic_eoi = 255;
> > +
> 
> Yay, it's my turn to say "why?!?" I'm not going to go full Linus on
> it :) but I've been waiting for the moment for years!

LOL.  Well, well, well, if it isn't the consequences of my own actions.

> If this happens we have a much bigger problem: the vector is set in
> kvm_ioapic_send_eoi() and ultimately comes from apic_find_highest_isr().
> It is simply not going to happen.
> 
> Unlike pending_external_vector or highest_stale_pending_ioapic_eoi, this
> cannot even be -1...255 so make it u8 and call it a day?

Ya, that's waaay better, especially since pending_ioapic_eoi defaults to '0'
anyways.
