Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A763218B3
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081690; cv=pass; b=jQdnLL7bnKHQxtodul4EbkwNPGN8ykBsYddWK9XGjpdmNUFMJIj1LbelCAuIGgLRk1isg9AO8K1/mqb9qSM65n55eAulOtAGS+a4EOz7e2b5gTDsB0x5b7uZswOm51fSxN9lodWTQN9wcrZpFpVBdUQZgMRiz0lV3vis30fIlA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081690; c=relaxed/simple;
	bh=8bvEhWBFcZC/sTgL+S8JOOfOsF9rhRC6lUJucNPXAUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASdQ1Ew27Wcu401Qe7kJHHmGjsisqdCc/G8bgKqF4WYS8LApUB5UKQaUBAQX+UcrVOh5VL2V731gmmYdfA0xXJuHP7bM1W0Pw/UVVoBrq1i/6K8TBiSufOl6LYuLbcGwn8vTpkXEsvsptx81s+4s3ViI46tDshJwEwn+k9duJko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jzRkdjwj; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzRkdjwj"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6501547d7edso4141425d50.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 05:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776081688; cv=none;
        d=google.com; s=arc-20240605;
        b=hAwAkcIIs8jbgo4i4jU9D6vbSTJCmG0twHM2WpTlEHBFccC1JDVJJ1T42Tcn1qBGlV
         BlQUjBKQJzBg1aHPaSayLigf0mE/wxTzWnJwHSIRq2vxT6fSgHFo7pE2atPVYpGimEkr
         CrlQIIJBs6QiHhBqRPwEWPVKT5BgcE4/zoDH/z1Ud/Thp2nOcaRRx8q4RpRkZMxGElS0
         mtWl+luSJsLXKxA+wxfzjd1GSY5Wlo5BumTpqpDQwsqUti1bHWWlRaB9KR6EypG3GVqP
         ykAVOft7DTjLjCChui2A3BVmP0rYpObkVXdEzUtQndxBN/qFHaRbascYB3dgpr3rnt/e
         qiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kg4fpig85e9+P7TZRqwVS3sXGmsWpc/MTnaSigaxjmI=;
        fh=j0YkZTpcPnNeq/hKSpYAtWRCD2+lb1k8/t6cLKgSs64=;
        b=Jcu44/u8VvGuuMWL8geA3jXsCSDBKSIl9P9ghmQQ0cBh37A8PYEZw9yAaUoBU4tNwh
         +QFub4ilcMr9F3dDem3LXckqcNIdNKiFZzZWAV06v8sWRngPMpH6mlN8O1WjtTFzv/nu
         dUxftXQJHsxfiSN5Z8wcOSUP4iusJRhhzdqjoj+5L/5Vz40rB3sN7szL4j5saetx148l
         2MOA3Y+iAxOkiSPIyh/jE0gpQnEKN9kQb5BfGWGVNuTcRQt/S21r+bobMzreH1uVPqj1
         Xirh6yNUtZvYQJiL8X1mwT8T8BskaAHPGtO9Wq63rxfvqRKLPx5Stest807JatT1P/FW
         zoFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776081688; x=1776686488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kg4fpig85e9+P7TZRqwVS3sXGmsWpc/MTnaSigaxjmI=;
        b=jzRkdjwjNDGrA/CsgFNx0TL6QNdi7eoWgHFgSwX7THvekOHI4dA8vjF6cjq04pvuTe
         s8cZst8Pj5VkoxE1rsrYqjPqHaG9g2QJxhsk6SwvE87bHT5jPxsi3H263fTDrMt41qmT
         rcI+3HbWukjrX39Q0QXoX/7bVRPDR86vZfKRYXedacGBMwEOuxWXYFW8W5Rx4dj148vT
         6YTj5QGhWsczEYK5u7DYCMOMhOaHa10UWDKy1eO09NaoImR1vK6EItAxc7lZQ4PmUuMn
         S8N41kKWTaTT2fsGw1irwV917sA9u5t8QhAQVh9QBUYuvbAoCR4Hgf6FD9SUqIXUcMVc
         rvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776081688; x=1776686488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg4fpig85e9+P7TZRqwVS3sXGmsWpc/MTnaSigaxjmI=;
        b=lSUVQ6bzu4OarrBT/ddHv4g5q/otYZM7OR9/hLe4lweu1FgEHaRQn0u0lhGQOkf51c
         rneJAVWRRCz6I1rQHKNzJWMwp4iGbtmiQX8CX6h/UJPZO8vtj6nkx6GDdbhiDweipjCA
         N34o7UElx1zqrm8ZuamDGYg4ayYQFxSsZjYtHXCqP0p+jJOqs/FQHTNlcpUqyZqrVezi
         YpSnssMx7V4XDK3Rp0nSfJ2g/RuXnKgHzu3DlKX50lNV/HOfb0pIA87E3C8qQ58JNxj2
         PcNhqc+3r1rfDTG6mnwTMzc3ht/nsq2+IyrlIDCG5QYAgjTm0+tnvEca+ucLa7+2lfNO
         hcCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QxQdnFF//bCQAGGW0RaFHvw5JZ/6AgXMf97qb782NPUzABzMdsGtFRKm6MYtJdqpnjFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrGeXebrEl8q1YFVuoy9rm2Pkniz5QV2BG1V6oZlHOjySTPS6h
	FtbAzY7IZkCQPuf1A/G+OSdyP7VynrnduXftI4fFMDdYOo0myBgLnwNSulqjXUXzsNMGzY5Brnc
	iAuCYh4ShOgZ3Of9B+NUrJ3dXFj/S3/Ci4W+egLByXw==
X-Gm-Gg: AeBDievpbwISZJYzfG48AaWGUSFzL9uSbAJAsF1EN2RWYZvf8zUk0jlqZVmxUHbPwi0
	kHF6RSkvDdeVQrDbjUO8HuaLughDRx6HLV5SBXSzRBU/WDei3gn8YghL2hr6SK3KQStX6Ar1Kjy
	hD9bW2Rcp255Ju2MXjXEaG6ulSAvwAp8SWReWTbnuQ5ssySlZcLvGXnrgx2OIfIbu4dhnuy4D3w
	foD9DpkyPR4tlWsRBeOn1qFvH2oQDS3LJj0rLk4qdErE4kp/rugtZEQLIdA1SKa41N50ma9K+AF
	iVhNzxsBATNygUujoib1Su8DF7SYiYJaIWomXGHqgGA4BvsIonW2ksLrXvbjF721O7JISD71QLK
	CzQ==
X-Received: by 2002:a53:c946:0:b0:64e:d95a:c89e with SMTP id
 956f58d0204a3-65198b72cb0mr10328423d50.41.1776081688070; Mon, 13 Apr 2026
 05:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413112151.61261-1-anisinha@redhat.com> <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
In-Reply-To: <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 13:01:14 +0100
X-Gm-Features: AQROBzB6Oyv06TxOpxsHTGPZS_Pb6Ys_6ks3UaFd50xNIqUWB6VUhjVDXJYsvBQ
Message-ID: <CAFEAcA8wJY6o3x1HNZrPu-=JG0Jyu_gJ+SKpcLHwHXvz+ZDGDQ@mail.gmail.com>
Subject: Re: [PATCH V2 for-11.0] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Misbah Anjum N <misanjum@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Fabiano Rosas <farosas@suse.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Apr 2026 at 12:37, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
>
>
> On 13/04/26 4:51 pm, Ani Sinha wrote:
> > During refactoring of kvm_irqchip_create(), the refactored code was returning
> > early from do_kvm_irqchip_create() function if the required capabilities were
> > not present in KVM. This was not translating to an early return from
> > kvm_irqchip_create() as was the case before refactoring. This is because,
> > do_kvm_irqchip_create() did not have a means to notify the caller of the lack
> > of kvm capabilities. Fix this by making do_notify_irqchip_create() return
> > EOPNOTSUPP error when required capabilities are absent and then the caller
> > can check the return code and return early.
> >
> > Converted some calls to exit() to assertion checks in order to make it cleaner.
> >
> > Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> > Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> > Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> > Suggested-by: Fabiano Rosas <farosas@suse.de>
> > Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >   accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
> >   1 file changed, 16 insertions(+), 13 deletions(-)
> >
> > changelog:
> > v2: converted some exit() calls to assertions.
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 774499d34f..c78bf6a56f 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
> >       g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
> >   }
> >
> > -static void do_kvm_irqchip_create(KVMState *s)
> > +static int do_kvm_irqchip_create(KVMState *s)
> >   {
> >       int ret;
> >       if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> > @@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState *s)
> >               exit(1);
> >           }
> >       } else {
> > -        return;
> > +        /*
> > +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP capabilities are
> > +         * present. Bail.
> > +         */
> > +        return -EOPNOTSUPP;
> >       }
> >
> > -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
> > -        fprintf(stderr, "kvm: irqfd not implemented\n");
> > -        exit(1);
> > -    }
> > +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>
> again changing behaviour ?
> previously it was doing exit(1) on returning non-zero.
> Now, it will assert on returning zero ?
> May be split the patch to keep the exit -> assert changes separate ?

I think for 11.0 it's probably best to do the minimum necessary
change to fix the logic error introduced by 98884e0cc1. For
that I think the v1 of this patch is OK.

There do seem to be some cleanup opportunities that we
have here, but we can do those in 11.1.

-- PMM
