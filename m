Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFD33C532
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780250; cv=pass; b=HLsmPBEuwyLCPBFZ7aelZgE2dU058/BC3h8dwjPiiDpwxkjyzZaAE19P66FADWRvPwYzT3sxdFFGMByIOLw02cwGT59VGn/uQAwaEdVZV5ua8nlW07tCfzcnuaQHWBvG9gCP3nYhKFk3d3wKnKNu4Rj+izy3qudaeDMOk0q2nB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780250; c=relaxed/simple;
	bh=Vse/+ZdVAP3JLjTJrQOypdpCOuZ74Ygw+49Q04bTh7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrG+2oyaOlesJYT/2QYE44omrPcQX3WVD5sV8fZMp9KPC0WV9bXCPS410aIfQd8GpQgQWHaSO88kvmUKrHnlWGyA+qyxptwYlcb4dmykEm142rW77hFIM8x58Aj834H6bFvOvca2wI4F1jN0NvXoZoioW+lLi5AEDu1glMa6vtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPM+8YNi; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPM+8YNi"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d864c23bdso5521cf.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 10:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778780248; cv=none;
        d=google.com; s=arc-20240605;
        b=PEheiVzweckAIT5OmwwpiMCnUcfJoJJ65OLosIwisxQobDrT6JsfS4OJIVRiRc6/ZP
         2UfOpZXOY3Vr3a/fTW6mYmAG883BHE5e9F8P27bk0qMTS0FzOZcMXeMb1lTIU0FtWsRe
         q5HfpaYIAeLFDWu8ENRuh68iC6DEngG34X+xPC6kTpvKNWLrmIQGfbW1KZ9DKMeLGC4d
         jgNSDaB68bpWJmt6bjgK3ESbLy63Iv/hyo/SHZGemnjS7FZ5XU2KvRKWIZtGaGYxdfe5
         x6Jn80vqjvPkQXjDR5uowop5dYn7X3HXd4dDN+ovuiLDu/Zedv6CKTTQLx6YSTn5fG4u
         wMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmreA23cwcFZxYn98K9SrDczn/2oXXYgf5RnrI0M3NI=;
        fh=LeBL/1irh6+zWzQZtyIjsj4ROBZYqfPPaAkJr/967fw=;
        b=jMhxaZCbKRyUzk1t5lKU40aFyFvW/jpzTjOaScpZfSTxsfjYXher3wdO0HQy6gT0cy
         gAyCUmR7miJ57kDnWdCkckB2s0dU6RhXh8XI4B/77GRE1g6mzAR+Y8tBvgkSxMrygdY/
         b5hk6LO0uKkZaQSezRQQ10sP2VSuEobNoKcb4vJTdkfmbIVRkdxLk5u7ZhmhEPVDk10I
         TYzcFtgzmCqIrchDFm+gM+iLJ5Ac68ePVU7yHFNUu9/FfRoxO9vsNknphf5Gj+J/4sM1
         fRQPcDHWZWRUbSWhrESdlkXnyVCzSTGYYbcjpRC3mc2lrkzv8HDb5RrK7/ZnbwTcsB4f
         YHOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778780248; x=1779385048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmreA23cwcFZxYn98K9SrDczn/2oXXYgf5RnrI0M3NI=;
        b=BPM+8YNicDUdgJxTQhQQibN69qGofIOLfCFyoYIE5aSpd0TYlte42tPTmR6v9nAydF
         FN9j/T0yVLwcrsjuM3SmNA+2Tmp31J93Swm76pI1FiayZlFBK7LsapjhesRe6MnRAQRg
         rwEbCg0CZB2meg/NFqtHra7o5IQnU0eEwI+RhUSXplcjKFSX+NvvMGpeiNVVO2IXaBR/
         Aec80sCNytpap71V+2UvWcjx9l9L70dO6MY3Tfi08o0GxOOlfKqty3mdWSq7xkqPL366
         I4IUVd+owxYdX1tJsPqeMNjE3pHIHvqvjFaBGFtZM6GVk4vvyrL21gbK6oVOXzvkCB34
         +4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780248; x=1779385048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmreA23cwcFZxYn98K9SrDczn/2oXXYgf5RnrI0M3NI=;
        b=ixQWhFluExmW6RCG29ZcsTlwPVTmD2B/cQ6eRfniNpobNcGp399ugG9QWETWeuOW/4
         xlczzcmK0TvGFLa/Km0E9wfbf63D3KldCuUDZp1cPO67AverqqSBPoIAFnzTi7qrgtpf
         Xnvls/waFmK4SZhTejT9FtRq/jnywwy+BOc51ILHUeNVuljInVQU2P4Eg/GZbSkeNJCm
         zl8MRx3isEAlcHlZYeBa64pcR8lzgoV5Rot+lot04sSs2aVLUwgEHZjtpLFJfWKmztFe
         EuRSwVpQFAZL8AsFxOmbZS4nwwzW40fwWTF/J53UmHZbMpfWKO6SyU4qipLQ9rFHj09F
         wdqw==
X-Forwarded-Encrypted: i=1; AFNElJ+qBFPk/XifY6RQlwKe6S1+onblE8q3l5tsI5HK1zzLldVOQG9ZiD2+sWepQ8qaBsnXJPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPrHNAWnGXgCuEjHBqbvvbGTVDznONa0fHrD5D1C6CF0hE7Bg
	FK/hmIlrNcGnzRmdURqkr/vSkQEMQwIcWOvH7yeaICTdLCdPNcvKOWTtabmo4XVwsJJsmRrE09k
	phzVWrG2IFEF2ejeBdyfFASPWdMIzT1HWOd6BhvhV
X-Gm-Gg: Acq92OGyO4UFPf8mxF6UkjIS7IgNkdyUebpQgsSC0VHm4beGMzpO2lwcRN016wRPWFZ
	GXkS1WFvPqUK9xxhmu2+EDdWH/4xlG/M3d6YiAJ9c1vauQZimuvc+y6O9a2AReB+jyVkFXvXYr1
	+ymZ9JXXpW5iwEyfzEUR+xO+mvSUvAw1eAuMXuOU+D+d3g0l8hlbskT4qMHR3Jo1bdUuygpHgXQ
	1AAVBHPg3Tz1TSh+cJn53gTsEAAjgfGGkPFFCXGMOV5fPnIiUwlmuW6cjG7XcajGsaS0tK92kb2
	4e+SGtJh0tRmtD00kQ==
X-Received: by 2002:a05:622a:8f0b:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-5165a3be35fmr434751cf.2.1778780248098; Thu, 14 May 2026
 10:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504224142.1041477-1-rananta@google.com> <20260507150925.11e9681e@shazbot.org>
In-Reply-To: <20260507150925.11e9681e@shazbot.org>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 14 May 2026 10:37:15 -0700
X-Gm-Features: AVHnY4L3_suYXUMuFI-gc4DyBTvFzkaApDG0hk3249nk2DtaN3QwnMlqQUOHEoo
Message-ID: <CAJHc60xK+tGz8rAhO_cNPCRR=A50pMD=sPwNeJWJ-BcLFABQWQ@mail.gmail.com>
Subject: Re: [PATCH] vfio/pci: Use a private flag to prevent power state
 change with VFs
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, May 7, 2026 at 2:09=E2=80=AFPM Alex Williamson <alex@shazbot.org> w=
rote:
>
> On Mon,  4 May 2026 22:41:42 +0000
> Raghavendra Rao Ananta <rananta@google.com> wrote:
>
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 3f8d093aacf8a..0e4a73e541d3a 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -271,7 +271,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_d=
evice *vdev, pci_power_t stat
> >       int ret;
> >
> >       /* Prevent changing power state for PFs with VFs enabled */
> > -     if (pci_num_vf(pdev) && state > PCI_D0)
> > +     if (vdev->sriov_pwr_active && state > PCI_D0)
> >               return -EBUSY;
>
> AIUI, clearing the flag in the out_del: below can be lockless because
> at worst we'll deny a low power transition, but I think the test here
> for any state >PCI_D0 does expect memory_lock, right?  Maybe this
> should be something like:
>
>         if (state > PCI_D0) {
>                 lockdep_assert_held_write(&vdev->memory_lock);
>                 if (vdev->sriov_pwr_active)
>                         return -EBUSY;
>         }
>
Yeah, that makes sense. I've applied this and other suggestions and
sent out a v2: https://lore.kernel.org/all/20260514173449.3282188-1-rananta=
@google.com/

Thank you.
Raghavendra
