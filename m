Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40C3E009F
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792033699; cv=none; b=Dp0EDKwmonQPNTc7Hq96/c3v1ttM/0dfYXBIXDYzNFdona8GlQn+qVjL5gv/GX6zQkn0HaXehOJyRt7XJb2Kt6WToZgtl7wuKjTCjY0LLmWzmjh7AOsBH9TkSJF+gWq/RU8422wMRXLAgxCuIaXG504yL7lENJUjg1ZWD1kH/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792033699; c=relaxed/simple;
	bh=1TlJxRh8RdYotvgR2AMuiX7apQgW6YJvRr7xE4/eEBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6ikvmrlOGVfEJy28y+qNgmpOMqFaqt9+yeTc7DTHhLi8zOoBP5jVFEWWnQSr5wxhds6YF7kp+3GlEsyEL8ypliv+g/liiOtDnHTbndTT+wSN3/E7iO3MIdQAKUSD8E6GyOFFCsZ3W811cDsCNBE1YW+4BiY3FEHkABKgYAX6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcHxaGhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcHxaGhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280DB1F000C7
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 03:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792033697;
	bh=SfjT8DL/Dv2LApscBO6xU+3PTsbFZ4cSEcwNALvRMr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fcHxaGhjtuMUc1GxzM/2dyMibXfxRL8Z/3zDHXRZo5jDoC/+esAnHcl9TWOIaz/r7
	 +2k4GEDZOUMfgSgVgStOeyxwM9pmske2+nfoO7Eky8x1tIVaJFhZYFZueLt9SoD6fg
	 N1YFn0/SQYg5OCmDPwN2Db558/icD9XlKJKLPX2lnlzCfeIf5WAs9Co7TgvPS6hHUS
	 nC4T42ep7UdLmdItg/FpQSMSmHP9Svy4pKa5WJWSRoxzQqFLldqA1HnX/ormWcI43v
	 yp5TWkaiufOSUwGt7Kq+ltGwtkSbbBcCAAb/97+WRLKCqd/y8/8D6v/vUu4SYpT7f7
	 U0adJTUaO96GA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so6940411a12.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 20:08:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwyqU1hZwcWKbXwgfIBuUyrYUKC4nA5ABx+r+ZmAVIq1aEQrNw5OWWrmEsn47N/70Q2o0A=@vger.kernel.org
X-Gm-Message-State: AFq9FYK55PApxdm1b84LaWoonxuzUmCLTk7ikOUtjnpfNQpeBzZrKbTd
	Qz3qqUfwegptlOF4sR6TLvKIHyNbJdo7tnoCFqzLza3zwIdeWVwv4MOSMcDJMS86Z3gB/b+cNY+
	a/D8jTee2KE2Xr2M0WqpOXifRoBupwWs=
X-Received: by 2002:a05:6402:4056:10b0:6b1:e034:7e88 with SMTP id
 4fb4d7f45d1cf-6b1e03482c2mr5454411a12.17.1792033695707; Wed, 14 Oct 2026
 20:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014052933.723303-1-cui.tao@linux.dev> <20261014052933.723303-4-cui.tao@linux.dev>
 <CAAhV-H5SDKsifd1GwMLU_YMny8PqwHdyuvujrAiuvkALoi3+8A@mail.gmail.com> <4c6f8e4a-93c9-4ba7-b66b-b294ffd70bf9@linux.dev>
In-Reply-To: <4c6f8e4a-93c9-4ba7-b66b-b294ffd70bf9@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 15 Oct 2026 11:08:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6pWaMguJYLaFTobW_XP10h_C243YeLnnbd24qjbYV5TA@mail.gmail.com>
X-Gm-Features: AclHuK-KJSed2cijEAX7OSiLO1HgwjY17-zsTh-CCoBr53iyxwCNWrskbTl0ThQ
Message-ID: <CAAhV-H6pWaMguJYLaFTobW_XP10h_C243YeLnnbd24qjbYV5TA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Tao Cui <cui.tao@linux.dev>
Cc: maobibo@loongson.cn, gaosong@loongson.cn, zhaotianrui@loongson.cn, 
	loongarch@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@xen0n.name, nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 4:37=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote:
>
> Hi, Huacai
>
> =E5=9C=A8 2026/10/14 15:37, Huacai Chen =E5=86=99=E9=81=93:
> > Hi, Tao,
> >
> > On Wed, Oct 14, 2026 at 1:30=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wro=
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
> >> Reject repeated initialization with -EEXIST, using the initialized
> >> state of the kvm_io_device as the indicator.  The MMIO base is only
> >> committed after a successful bus registration, and the real
> >> registration error is propagated instead of being replaced with
> >> -EFAULT.
> >>
> >> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and wr=
ite functions")
> >> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> >> ---
> >>  arch/loongarch/kvm/intc/pch_pic.c | 12 +++++++++---
> >>  1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/in=
tc/pch_pic.c
> >> index 51e4a6a39dc0..7979466de729 100644
> >> --- a/arch/loongarch/kvm/intc/pch_pic.c
> >> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> >> @@ -281,16 +281,22 @@ static int kvm_pch_pic_init(struct kvm_device *d=
ev, u64 addr)
> >>         struct kvm_io_device *device;
> >>         struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;
> >>
> >> -       s->pch_pic_base =3D addr;
> >>         device =3D &s->device;
> >> +       mutex_lock(&kvm->slots_lock);
> > Why move the mutex_lock()?
> >
>
> Thanks for the question.
>
> The intent is to keep the repeated-init check mutual-excluded with the
> bus registration.  The set_attr ioctl path holds no other lock, so with
> the check outside slots_lock, two concurrent CTRL_INIT calls could both
> see device.ops =3D=3D NULL and both register the same device on the MMIO
> bus.  Holding the lock across the check, the registration and the base
> commit makes them exclusive.
>
> That said, if you prefer the check before the lock, I can respin --
> please let me know.
OK, moving the lock is reasonable, but I don't think updating
pch_pic_base conditionally is necessary. So just move it before
kvm_iodevice_init() is fine.

Huacai

>
> Thanks,
> Tao
>
> > Huacai
> >
> >> +       if (s->device.ops) {
> >> +               ret =3D -EEXIST;
> >> +               goto out;
> >> +       }
> >>         /* init device by pch pic writing and reading ops */
> >>         kvm_iodevice_init(device, &kvm_pch_pic_ops);
> >> -       mutex_lock(&kvm->slots_lock);
> >>         /* register pch pic device */
> >>         ret =3D kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_P=
IC_SIZE, device);
> >> +       if (!ret)
> >> +               s->pch_pic_base =3D addr;
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
