Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92C4C680B
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213814; cv=pass; b=u9t1jaIXhwua2zOGsp4JalaZmyfxX062oNKX9wSVkBbRoYiGA91cvgzTNm5b7/S36B7GMjGivrwcz1u4FZnPf8gkjnYdpqJtJD+XNjbIczGoGQPRdAQJJiHnhu+hfyMigYvHg36BThlGbUI5HZXIckEMY8Y4J89sC5SPR9sa1FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213814; c=relaxed/simple;
	bh=3BMrnTWZwyr6lX8M+0judiPrKn45ns0kyGkanT5/PWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kO8LSAXCCv8TQ8DcqcP5MmvfpwE7FU1kASC4Ly44RMT2HzLnVS16DMx/nG3BgMJs+CUubuvPD9jrn59vGKZ1oSz7ceZf48e9lbdbYjYEa5YlGtlazwrCn8I2wKYly8RC632aRpYWlrD6IXUrPgKFcUYqMxUriflBAjggaoZ49ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kEcvYCs+; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kEcvYCs+"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-82656756187so621941a34.2
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 08:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791213810; cv=none;
        d=google.com; s=arc-20260327;
        b=nenYbVpNeGIakljBpoI6cjpTQATt1HU/P4edsE+bl4encwmqRCuxaSscQrMFHLn9uv
         qABfOHPKcKrAJ44fGaxrv+w1i0Z1Mdv50gaMKkfozJDFr3m2jKFV1zEdJlT2r7L5rNO6
         P0TBSYvKV9Q+waIX3ZYuT9Se5uSjzulVW8tByKlNaflMvXGsEmvgiE1R5KZ/Wh8sGWb+
         CY9lIEQ8+EUbaZ47mkca4szh/a/dm/sB3iwxyIaUEUwka23rzJUVjLNx4aowdi9C87Tm
         1WDve9Q6J+2q2DNiLcCJnNpnCmuIXfqGzHyBpLx1bFUbF+g9Va0dvyp4yTnOmQr1EFYu
         XwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MlekscLQcc45qbwdnWHjJzOVHRL8WZqGEQw9YVgtc0=;
        fh=89uUFKehSxmOlyhe/HwM6Egn/gbiecrFc1z/ygqNUT4=;
        b=RKfuLr5/PryOk1JsWTNK2OL99+zmYjITNBcBV+fDzXJCEpMF5SbWtGA9ysP9n2aF26
         QOrvbx+iHk5Y52r3n8Pw1hNpKXXBkqXS0lATjnXzfRcSo0hyR3ZBo9dmzKTP8trV0PYK
         EwgZ9g0lfpm5xz7s/WdQXyWfmUY+jcT47T9ElzItLD9nFckIURN+Cp8X68z0+Urae606
         B7vPrMy++yvrXSxksny3rLXfyR5q7GgLI30JShogj11WZLeVflA5M6f4cm+Pf5gBKTnG
         kh8e8iC0WyB7t86SMIb9uSX2HTVGaZwTgjXn1gLSHn3BdLpEmzf478y4BHsJmTqAipG0
         G1iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791213810; x=1791818610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MlekscLQcc45qbwdnWHjJzOVHRL8WZqGEQw9YVgtc0=;
        b=kEcvYCs+yoMQ0MIrKv6Pd7uDS5T1NRSIlF7cZCieAzfe8feWF2E7+3KNrpwsBHe0KM
         BmHhsQtKBkWP81YrCed9Pg+fxUrQJwLFNFUem6XPTdqeF+Rvmlv+ZkleepsPT5HR8bJj
         UYSzfi2qZeUVvFrLrxBGfZ4xgnAvva1OU0kGuCgT5y5gh1ub8YueEBdiwmMUqcRykYmc
         G2tDkHmYSTEFgVLbR4UCTsHv5VpVpPYps13Nu7IXWwPhJAR/MUHhlobg7dK39UzYXrCD
         Wu906NwoSV1oVBUC64PW8pFJwp3uhg8Y4KHU3tilqjzLkwb8PMdiM/NINaPQxpou6bXq
         f0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213810; x=1791818610;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MlekscLQcc45qbwdnWHjJzOVHRL8WZqGEQw9YVgtc0=;
        b=NyVMt1wCRSUvLtQTFBPkRunrogvI/snr4JITWYk3DgCrAY/2HTxoAFLTlOIXpuiT0R
         B3IL/w5AdFMZdNVFjKdOUGd1LWQ34n2vXj88bfQ525YtZr2+RFPqU0DMGaAhK7mVTaOR
         +VTlZEiNWkRsguIh15jMGYwX5J5AoQMkIgJG9IUl57M2RXExU+Y7jv5wIov0XRi2nKrv
         Yk2eWNa6YYai29P9fOqHKoQOSlHMLadN+f/BLHDp12twzm3p2K3EeuToaJYhsI2AW3K7
         uEfXAu8myLjI45Dtgh+nB0glFb5m0f6+K7cZxRBRHgwgKx6z9/5MUwSBnka2QjHWX9tR
         4KAg==
X-Forwarded-Encrypted: i=1; AKwUvBy0h7S/vVrXjYupE0al7dsja2yKPnru9xUzBbdN3uk+NiYsvyGrusnek0MG3wZJQYdbQQA=@vger.kernel.org
X-Gm-Message-State: AFuF++nsYpCyl2dNEiiHRYC/a2d4d/LPyY43Oq4hHiqASsSezR50x2Wn
	sJChWO957TJNLfk+s0fb4sjMMu3T/8DJstpLrDILz8Z20NtDUCsk3aT+kzshCGGMT4JGVD1Hx3A
	zLME7CbSj8iXolI3LgPv7Xugl5xtYv4xLdrWZcusfzw==
X-Gm-Gg: AYBFou3PGgbQY5BPV0aYcGDodWCRoLncTq6X0om77XblDu4kAYlI84qQpST0nLejaWi
	p/KYD+suJ779nWb7L9RYiYfGQJVfiXNxjXNId3Ahs4VKNe8pqBBMEyJp5nvceK8ZwqfI+sW0Gud
	QUUhOwHYDRwbB5M6tzWVaIKCz7sd8KBF0HyPSvDCNvhb22hAoNXbhnjc2zzx6Rb7838vL4AfcmI
	I62Hfd8h7Ip/1iFsB3IBgPZsgDjy5bpmuq83EnBnO9Hrb+bfzRmRAKiz4LSHQyDLlBlfwv42wVs
	HEs52nVrqb3wiBZ1pjDzNk7edf9prYD0/cv9QnmlHIrklo35ULF5n2vV1bzVt7wavhQ9RfpQ5ax
	c8V6x5TA=
X-Received: by 2002:a4a:ee14:0:b0:6d7:69c6:5292 with SMTP id
 006d021491bc7-6df34291b3cmr7901748eaf.45.1791213809230; Mon, 05 Oct 2026
 08:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002151942.491680-1-bruno.produit@trailofbits.com> <ar_PNEIvsQMQPMLg@google.com>
In-Reply-To: <ar_PNEIvsQMQPMLg@google.com>
From: Bruno Produit <bruno.produit@trailofbits.com>
Date: Mon, 5 Oct 2026 17:23:17 +0200
X-Gm-Features: AclHuK9_-Y1kA3kFfm3uCM4nQvVKm2VIHGmvvm5x70Ipyd8j9bTevti15kTGlWY
Message-ID: <CAN3w+PPqe9C8TcU4CHjwEE3tUG8k8MXXAHRQagb8iR4ehWbLLw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Cancel PIT timer on failed creation
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, linux-kernel@vger.kernel.org, 
	Dominik Czarnota <dominik.czarnota@trailofbits.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, agreed, thanks for pointing that out. I=E2=80=99ll send a new patch wi=
th
that change

On Fri, Oct 2, 2026 at 5:35=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Fri, Oct 02, 2026, Bruno Produit wrote:
> > From: Kyle Zeng <kylebot@openai.com>
> >
> > Cancel the PIT hrtimer if PIT creation fails after registering the PIO
> > device. This matches normal teardown and ensures the timer no longer
> > uses the PIT before its memory is freed.
> >
> > KVM registers the PIT's PIO device before registering the optional dumm=
y
> > speaker device.  If speaker registration fails, a vCPU can have already
> > programmed channel 0 and armed pit_state.timer through the published PI=
T
> > device. When I/O bus registration became fallible, its cleanup did not
> > cancel the timer before freeing the PIT.
> >
> > Fixes: 090b7aff2712 ("KVM: make io_bus interface more robust")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.6-sol
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
> > ---
> >  arch/x86/kvm/i8254.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> > index 1982b0077..b7875345f 100644
> > --- a/arch/x86/kvm/i8254.c
> > +++ b/arch/x86/kvm/i8254.c
> > @@ -793,6 +793,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32=
 flags)
> >  fail_register_pit:
> >       mutex_unlock(&kvm->slots_lock);
> >       kvm_pit_set_reinject(pit, false);
> > +     hrtimer_cancel(&pit->pit_state.timer);
>
> Given that the timer can be armed if and only if the PIT was successfully=
 registered,
> wouldn't this suffice?
>
> diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> index 1982b0077ddd..33d772c7160b 100644
> --- a/arch/x86/kvm/i8254.c
> +++ b/arch/x86/kvm/i8254.c
> @@ -790,6 +790,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 f=
lags)
>
>  fail_register_speaker:
>         kvm_io_bus_unregister_dev(kvm, KVM_PIO_BUS, &pit->dev);
> +       hrtimer_cancel(&pit->pit_state.timer);
>  fail_register_pit:
>         mutex_unlock(&kvm->slots_lock);
>         kvm_pit_set_reinject(pit, false);
>
>
> >       kthread_destroy_worker(pit->worker);
> >  fail_kthread:
> >       kfree(pit);
> > --
> > 2.53.0
> >
