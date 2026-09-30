Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3F36728D
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735121; cv=none; b=kmgbY+iu9WndBHQ0x6OPyfz7n2w5vCuZm1g6nqAKTEX/UhfJwCS3g5iBRC9cVuFtF7Mqkp5YN5FVeSIwh3hZOk8hYDGWLoBRlckGGaZ+43Rvl2vPpRmGuSRzCKxJZuIwWYN6dA5yy59FYmpEePTZscWQY4P2LsiboC3eooxGovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735121; c=relaxed/simple;
	bh=bYRlKTcoFwKQ2KHz1JhTq7AVbFEVD0LoNrwsEKjw0Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE9OWmB8aknEzGAWuL681KTvuAqFlTW9FWjEcDTX84S863BXxnxeIOt4NW+E9dlGyvtxPLNXtxVP2duqmsQ5QQNNCLRmmfvx9ceerPw0wW8+3TqtceciPauBwJX2nnVu+7F3gHyki+Ae8huMFyJzzvq8ACzJiPPMUGJJ+NZku60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UchEL4OJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UchEL4OJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547C11F0089E
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 02:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735120;
	bh=rPht3GyBw4XvyTWzSaHacF1auRO6YZ8+3fv5BvKiRJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UchEL4OJ2eb6Emb3r0La0ehNque5+HDT+jzqZ+64y6pOVzl9I0LI/mKCAX0IzMYQG
	 lusp0EG36fPTInDEUGcYHDC4j8HaX5QbcoEk8Uu0qZnS34VmVSSwcOzw9wYb9G9QS6
	 hW+FAt4xt/ctVR2ucSlJcix2E0oayR9wqYfyD6jMOXrQhx9hp9i6rr0zGE6K1qQ2QW
	 Y8FRDagSve64ug7RsyTLfC6+vtyHJv733W5IPMjK6plF9Ko9IXsgBS704xONachya5
	 h+GdBy1ga4c1qm8IbAVFAXgoRzXnqlnX7mSKO823isTDfAkT7ZARsqhy5j7Z+XDnNI
	 ggPQ7dEiSh4YQ==
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac6fa788e6so4513039a12.1
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 19:25:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx1NpyScHPWQIQdoi6t5yzH5uQsrvPM5yR5zCTyUGqMD23o4kWVSGgoYPjw8MJSBmwvRV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJk2ts8sAcSnMuZHtdhRRy7VRd3t/+leKxjUU++rYwK1I/IosR4
	u64jBVk9luXyFs06vmGR4oN6pbaS3EPYR1Ln9js5QRsQ2C+TOGcHCB5rhfIuMOwztBBsi6WmUDU
	NWhShHe/j/Q1pkNlMUfCocpsiOBN/rO8=
X-Received: by 2002:a05:6402:4402:b0:6ac:a828:428d with SMTP id
 4fb4d7f45d1cf-6ad4fd41bbamr563140a12.26.1790735118964; Tue, 29 Sep 2026
 19:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929102821.36112-1-cui.tao@linux.dev> <20260929102821.36112-5-cui.tao@linux.dev>
 <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com> <0c8125ab-9c66-42e2-87dc-208956bd4d9d@linux.dev>
In-Reply-To: <0c8125ab-9c66-42e2-87dc-208956bd4d9d@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 30 Sep 2026 10:25:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7TSLNXp7LEW2scsxGKT+eGazG=DD-UNcakBf2gSHKBJQ@mail.gmail.com>
X-Gm-Features: AclHuK9RPd_ifzoKLfqW7fYTpepEL9xT5f1AfW-zUpVpxC60OpbJyEJikru22cI
Message-ID: <CAAhV-H7TSLNXp7LEW2scsxGKT+eGazG=DD-UNcakBf2gSHKBJQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Tao Cui <cui.tao@linux.dev>
Cc: maobibo@loongson.cn, gaosong@loongson.cn, zhaotianrui@loongson.cn, 
	loongarch@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@xen0n.name, nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:15=E2=80=AFAM Tao Cui <cui.tao@linux.dev> wrote:
>
> Hi, Huacai.
>
> =E5=9C=A8 2026/9/29 20:43, Huacai Chen =E5=86=99=E9=81=93:
> > Hi, Tao,
> >
> > On Tue, Sep 29, 2026 at 6:29=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wro=
te:
> >>
> >> From: Tao Cui <cuitao@kylinos.cn>
> >>
> >> KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
> >> invocation: every call overwrites pch_pic_base and registers the same
> >> kvm_io_device on the MMIO bus at the new address, while
> >> kvm_pch_pic_destroy() unregisters only one bus range.  After a repeate=
d
> >> init, MMIO to the stale ranges computes its register offset against th=
e
> >> new base and silently reads 0 / drops writes, and the leftover bus
> >> entries persist until the VM is destroyed.
> >>
> >> Reject repeated initialization with -EEXIST, tracking the state with
> >> a has_init flag so the check and the MMIO base update are atomic
> >> under slots_lock.  The base is only committed after a successful bus
> >> registration, and the real registration error is propagated instead
> >> of being replaced with -EFAULT.
> >>
> >> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and wr=
ite functions")
> >> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> >> ---
> >>  arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
> >>  arch/loongarch/kvm/intc/pch_pic.c        | 12 ++++++++++--
> >>  2 files changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch=
/include/asm/kvm_pch_pic.h
> >> index 887b0431fd20..679132d840e6 100644
> >> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
> >> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
> >> @@ -53,6 +53,7 @@ struct loongarch_pch_pic {
> >>         spinlock_t lock;
> >>         struct kvm *kvm;
> >>         struct kvm_io_device device;
> >> +       bool has_init;
> >>         union pch_pic_id id;
> >>         uint64_t mask; /* 1:disable irq, 0:enable irq */
> >>         uint64_t htmsi_en; /* 1:msi */
> >> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/in=
tc/pch_pic.c
> >> index 7a704f18880d..a884a043feef 100644
> >> --- a/arch/loongarch/kvm/intc/pch_pic.c
> >> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> >> @@ -282,16 +282,24 @@ static int kvm_pch_pic_init(struct kvm_device *d=
ev, u64 addr)
> >>         struct kvm_io_device *device;
> >>         struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;
> > Why so complicated? The below is enough, no?
> >
> Thanks for the suggestion.
>
> I agree that a separate has_init flag can be unnecessary here. v3 uses
> s->device.ops to track whether the device has already been initialized.
>
> The other changes are kept: pch_pic_base is updated only after
> successful bus registration, and the original registration error is
> returned instead of -EFAULT.
The return value changes can be kept, but why keep the pch_pic_base updatin=
g?


Huacai

>
> Thanks,
> Tao
>
> > diff --git a/arch/loongarch/kvm/intc/pch_pic.c
> > b/arch/loongarch/kvm/intc/pch_pic.c
> > index 2b63b0c2c7ce..7855d78304b7 100644
> > --- a/arch/loongarch/kvm/intc/pch_pic.c
> > +++ b/arch/loongarch/kvm/intc/pch_pic.c
> > @@ -281,6 +281,9 @@ static int kvm_pch_pic_init(struct kvm_device
> > *dev, u64 addr)
> >         struct kvm_io_device *device;
> >         struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;
> >
> > +       if (s->device->ops)
> > +               return -EEXIST;
> > +
> >         s->pch_pic_base =3D addr;
> >         device =3D &s->device;
> >         /* init device by pch pic writing and reading ops */
> >
> >>
> >> -       s->pch_pic_base =3D addr;
> >>         device =3D &s->device;
> >>         /* init device by pch pic writing and reading ops */
> >>         kvm_iodevice_init(device, &kvm_pch_pic_ops);
> >>         mutex_lock(&kvm->slots_lock);
> >> +       if (s->has_init) {
> >> +               ret =3D -EEXIST;
> >> +               goto out;
> >> +       }
> >>         /* register pch pic device */
> >>         ret =3D kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_P=
IC_SIZE, device);
> >> +       if (!ret) {
> >> +               s->pch_pic_base =3D addr;
> >> +               s->has_init =3D true;
> >> +       }
> >> +out:
> >>         mutex_unlock(&kvm->slots_lock);
> >>
> >> -       return (ret < 0) ? -EFAULT : 0;
> >> +       return ret;
> >>  }
> >>
> >>  /* used by user space to get or set pch pic registers */
> >> --
> >> 2.43.0
> >>
>
