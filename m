Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD883FBB6B
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989070; cv=pass; b=jXCdpaMR+0hhb0riYZQC7MXLT4zcWqjQo1N4e2x2p1ryLIpUwa1wwPrBy1AIItgI9Iad9/jYVufQbNO6i/MqAEt6Ls8Fj3IdpSRqQcCZ7/BzATsIhI55qBFS11w4RdaSgIjn+r+21uOBjnj8iLiOliTqdDGOuRdR8qtpmhlTykA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989070; c=relaxed/simple;
	bh=TYGgerHQAvTuX/2bbQtOFJYi9wnvk3u5v3k+r6y4dEU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4aQon1zdw+YBvj7mCySIwdzXn8Q3DIDf/+nubOGwhKvoBGyKG3uDfUFlu6W3CKQIbFjPZ/alWfPdpFErBhafNmt0v7gDyjHlk9QIPzJuwUwwjOFM4Kz3StXjzz1PiY9/HtvlShO3LRCaCPrQSYfEpaGuYvm8hznfZ40ve8AQDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BViPx1uI; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BViPx1uI"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-133466cf955so34259654c88.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 10:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779989069; cv=none;
        d=google.com; s=arc-20240605;
        b=SwsSA8kiXPu/ewUKSvZeuPhxseXOLZhni84LnNnszJ39CVNnfh0wWSjKj5Ha0wYsF7
         +XaWh9yWxcO986fR+imtb02T1pjKAhVZE8R9xG2RSyTVXQWLmeGz/c7Kzu5ujd35t28d
         Wz2fgXLltK4s2Lsyf3+KOLCHCHzqByXTcDcR2ITkuAshAMAUmuaEAfxZuH3NOeLjZ4F7
         /MriT1/gUDc5BfmdLx9Q5PKpCvDFZTDlvmS60LeLnJUGTYVcLzcv4lViOiWLvfCYGJhq
         jUb6n3O1a2LE7lUktJtZOUi4iFDnGsG3c0IfaypwnPRj3hWMAUH8Eyt0vJf7XUmaMuc4
         hJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=59Bo69A7riDgsnvr0KNrrBfekLr4ldEdSVQekRHR9g4=;
        fh=a/B0iV5LWklS7QUR0cRnqbJdAtXzyhd2Xbve3+VFDMU=;
        b=MOzdTx/5WGUi6Z0OdRCrFl3xmusVKlFMQAJo4rSPfVRA/9fTtPXgqPFRmOoiMv0Lc/
         qkwbc+gYBzu/j457ilXNrtFb2arwoTwGPm+kWC+uJJIIyW7WhGGWhi/2La5b//ZVC56u
         ltSwEjhf/5Z3+faSvoyC9bSV4Q0iyvMKQX56yfXzdKbh2UMikX1mtMjue6c01Ahau8em
         E1Vti6mibXWtkCTitoinf/zDU/ZUj2B2f2sew3rMLFZmWrfPF2uDOVkdd8rKtClbAhDE
         G7SpMwu7dDWxF08g2Ig9FnlJBF9tKAPYm7A//gO5pW1+WQY+7nOjmwtty+b2UaXbFH0y
         FhKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779989069; x=1780593869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=59Bo69A7riDgsnvr0KNrrBfekLr4ldEdSVQekRHR9g4=;
        b=BViPx1uIwklgizWMTLFGdy9OWEoOYvwXKzwxN3MuPBtDYQsVWWvSXD8XVlRC6aKWq6
         tdpn7pWxJaJPNUYK4oBeZVhGpjSdSQvhLS4nnj3qFx0iVK8iFVG3MNTqhcPuKBO3R+lm
         tjGnVKpZKqDwerTRaG022NKMZzfrFGb/dZklY1GFUelH+oH8DSIdnetdn+4brjznHhtw
         2nehWVTvcRPXBo95FINefObTgB05NY/rQsHq1UeX0k/BnOHFr0+bXJrYFGitwCa1ZOzu
         wtKCrIzzsDjEOk8dbcsUZ5Tuo6xF4QTDzQlm5ySzxyQr0pNFnwP7lCVCO9TUE9B7kDS4
         9apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779989069; x=1780593869;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59Bo69A7riDgsnvr0KNrrBfekLr4ldEdSVQekRHR9g4=;
        b=DH6BYp6B02I5UCqDXqdUgGkiQ/VJgPk/ANKv/mUfpBJ06mbo01dcus5XQdL5CltxpS
         AaT2bcEbN7ACcqiiMycq1oq8BDT57FxFNyhJSvtpWhyNc7adTY//S76fU1kaEoWH+0o1
         IJLh6FR3txZS97L0o18RCy5HforawwgZvrY35tMjJh82Q+OH7VCzDEgdVxW11PUYFn0q
         OUmgl5dYhrCy8vbwohcKOEDz1jWVp9ZgysVdi/iYJ+f24rMgsx+XnZCqIKd8ug32xeLn
         4t+TsHLSeJd39OnDTw8MvwInOxXfImMCUNkpVTvwrH9lEziKieeJGWAGps1UWtW69M6C
         uOHQ==
X-Gm-Message-State: AOJu0Yxhd+Ior3gT2MO6DZrMD6LFd7z8Bg93uwiW8Wx8kOqoL08gLfqz
	hNK05kz0MGVhuV0L8BKFjqdnnW6dqsmXLhJjeT0zuTSl2j/ztcG+JiCLZnMqhyXyvRTKhwlxU2a
	1/cpJEYdNYeeCyBfIPttoP7vI9uIOs7oh0isK+864
X-Gm-Gg: Acq92OF3xLOe2agfWj1oRGBx8Ttv9IfB3hZ6ClYTRanhTM4v/IOLUESnhit62vXVpt2
	bd5a1oB56itMHJ2cmGXFx9k53QSgEGNQtDLFOvAWsbcrhRBDBNi8tIl40lEeWCek2WyGq4VSJf8
	vQLs7CB7uj9DnC9unSK0mPzRS1cqTLGzXuOaSHcbz7umlfb890/APLXGKtg5wjZuvnVenhdYWmd
	EsHWhlYDrq2gVVvCM+U8lpO/8EjPLHpnkI9SXBe9d09MJ9DYx7VGEt+aj+lobsAOi4KPt/++6EG
	5Ym3mVKPJ7vTfKNDC/dZF8ap0C3EZs9qnk+H2z0hsSEn+iqwmGAOKBQFrASF43SdoqriI/oZ87B
	WsDEE
X-Received: by 2002:a05:7022:100a:b0:135:fdeb:4776 with SMTP id
 a92af1059eb24-1365fc779e3mr10817211c88.34.1779989067927; Thu, 28 May 2026
 10:24:27 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 10:24:27 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 10:24:27 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260528021117.107984-2-seanjc@google.com>
References: <20260528021117.107984-1-seanjc@google.com> <20260528021117.107984-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 May 2026 10:24:27 -0700
X-Gm-Features: AVHnY4K9M5a9AdHwVjEQNLSgtEMKxjAYAyyvSACKymVHjkgRYK5_0CLTuJiOe2E
Message-ID: <CAEvNRgFAt2NSbK91Oc95iKA7eLo-3Pw==2X0PQvbonhVM_bZ7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] KVM: guest_memfd: Treat memslot binding
 offset+size as unsigned values
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index bf9659a7b0f6..a1cb72e66288 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -640,15 +640,16 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>  }
>
>  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> -		  unsigned int fd, loff_t offset)
> +		  unsigned int fd, uoff_t offset)
>  {
> -	loff_t size = slot->npages << PAGE_SHIFT;
> +	uoff_t size = slot->npages << PAGE_SHIFT;

I get why uoff_t is chosen for byte offset, but why is uoff_t also
picked for size, over size_t?

Not trying to nitpick, guest_memfd deals with lots of sizes, byte and
page offsets so I'd like to derive a mental model for using these types
in functions.

>  	unsigned long start, end;
>  	struct gmem_file *f;
>  	struct inode *inode;
>  	struct file *file;
>  	int r = -EINVAL;
>
> +	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
>  	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
>

I never knew this was meant to show the concept/typing relationship
between gpa_t and byte offset, gfn_t and page offset. Can we add a
comment to explain the presence of BUILD_BUG_ON()?

Also, what's the rationale for picking BUILD_BUG_ON() over
static_assert()? static_assert() could be placed outside block scope
which makes this relationship declaration more general/global. Putting
it in the function makes it seem local (seems to suggest trying to
assert some guard for just this function).

>
> [...snip...]
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
