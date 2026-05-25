Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF93E869A
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703089; cv=none; b=KB/KvgdXZVnyJ+O/ZAfvt9vi1cp21gm3bfYt5t/FEgXSd/Kj/2d1UTbRQYhcnYCX5SYdapO6AHAcdr34HE02NEsZKUmiTCpmZjes6DaId5ke73ZwNSF6PmF7BLsyQSeingIrNe1MgSkKevj0OUey0mysMr5og7bG8gTN6epEm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703089; c=relaxed/simple;
	bh=YIcoDH61ho33Opg/5ey4o2PjDEXs+ZoLPSygOU57BGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvu3lU6BiAwwLt7zGiApzcqNxbAKYWALCAjbohdHiSng3mEGkS1x+pCPcqSvur3bx2TUQlb6fyl6Fn6vLhXXx6/1MFBgwx4onnAIKvQbVHPoI5bxuasxDvQlHfOl+MYNJQfOS7RGLVYNmVPGQ6Pd9zQhXWkzx/Z2ppsZi4AnzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/edijR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/edijR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB071F00A3A
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 09:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779703087;
	bh=YxS4MMEWBaJECf1wnCAqzr9MgHb+NMNn0Vdz7r7z4Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h/edijR5JzEWcmsdOXrus7Xrv+QxQpqqcfh+Fee5PX1Dk+54Lppw7gqlXDBZFPIsD
	 ekoU+cv2nGp1RBl1awP/Z/sgVDJwl8JzNxzIcClQJVxbSD7TtxEcISukmKn5fBGrx+
	 cXXTDtH9+9vLy8J3Agq+v/UHJq+B8/wbx0kZ6vJe1YZXNXFpEyXkLX1rAoWqWOCYKi
	 thngM1P/HzxO6ShG9kDqwQcfpFpbO/kDpm7aCcPmbVyXkrQTXwUVRa9bxLnzd26KxJ
	 jRikXqptDjKSpyBwdcDv7vlcag4d3pJXc8T+LJQtsD5N12wUg8pwq1TcSzm4Y1GOtA
	 ukFk/eSpf9UqQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd8d0e4e341so1308219066b.0
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 02:58:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8zJJThiKhQLLM4gMNRz/OBBNzG2MiDPogWMZVgR6kcEBcGVliej5Q5OAVXTEvN6CvCquw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9XRZ0Gtk1+8TpdEQkvCV2dLuOjAA/xQiBMfGD4FVSDgjHQbZ2
	obuyLQORsAhQCCV3fWX0PZPA1QqW95e5qqRMBjCLRQSuqvRhfmHt6Hk9Plue3tujz3WjIpBD6Ra
	2+eOoCiIozuyYKyqVunV/S6HtRe0nCNQ=
X-Received: by 2002:a17:907:1ca7:b0:ba6:8f34:b419 with SMTP id
 a640c23a62f3a-bdd23602369mr823876966b.13.1779703086116; Mon, 25 May 2026
 02:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518094521.138692-1-zeng_chi911@163.com> <20260525092633.1706633-1-zeng_chi911@163.com>
 <75a7525a-28d9-fdcb-a696-e56942530e7c@loongson.cn>
In-Reply-To: <75a7525a-28d9-fdcb-a696-e56942530e7c@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 25 May 2026 17:58:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4__A=SQmrijs3OgeSpSFQSrCVL_2CrF0pzwRbvY_MH_Q@mail.gmail.com>
X-Gm-Features: AVHnY4Iy13hSDGD7Ws8vVYlghEQ3qzYuRGg3aDmaK06HHSU3Hm_ofRtZ-3qip5I
Message-ID: <CAAhV-H4__A=SQmrijs3OgeSpSFQSrCVL_2CrF0pzwRbvY_MH_Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] LoongArch: KVM: Add missing slots_lock for IO bus
 device register/unregister
To: Bibo Mao <maobibo@loongson.cn>
Cc: Zeng Chi <zeng_chi911@163.com>, zhaotianrui@loongson.cn, kernel@xen0n.name, 
	kees@kernel.org, siyanteng@cqsoftware.com.cm, maqianga@uniontech.com, 
	gaosong@loongson.cn, yury.norov@gmail.com, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, zengchi@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 5:53=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/5/25 =E4=B8=8B=E5=8D=885:26, Zeng Chi wrote:
> > From: Zeng Chi <zengchi@kylinos.cn>
> >
> > kvm_io_bus_register_dev() and kvm_io_bus_unregister_dev() should be
> > called under kvm->slots_lock. The unregister calls in ipi.c, pch_pic.c
> > and eiointc.c were missing this protection. Add it to match the
> > register side.
> one small nit, the mail tile is [PATCH v2 net], I think it should be
> [PATCH v2] :)
>
> >
> > Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> > ---
> >   arch/loongarch/kvm/intc/eiointc.c | 6 ++++++
> >   arch/loongarch/kvm/intc/ipi.c     | 2 ++
> >   arch/loongarch/kvm/intc/pch_pic.c | 2 ++
> >   3 files changed, 10 insertions(+)
> >
> > diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/int=
c/eiointc.c
> > index 2ab7fafa86d5..2b14485d14a7 100644
> > --- a/arch/loongarch/kvm/intc/eiointc.c
> > +++ b/arch/loongarch/kvm/intc/eiointc.c
> > @@ -645,10 +645,14 @@ static int kvm_eiointc_create(struct kvm_device *=
dev, u32 type)
> >
> >       device =3D &s->device_vext;
> >       kvm_iodevice_init(device, &kvm_eiointc_virt_ops);
> > +     mutex_lock(&kvm->slots_lock);
> >       ret =3D kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS,
> >                       EIOINTC_VIRT_BASE, EIOINTC_VIRT_SIZE, device);
> > +     mutex_unlock(&kvm->slots_lock);
> >       if (ret < 0) {
> > +             mutex_lock(&kvm->slots_lock);
> >               kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &s->device)=
;
> > +             mutex_unlock(&kvm->slots_lock);
> >               kfree(s);
> >               return ret;
> >       }
>
> I prefer something like this, however it is only my personal option.
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -645,13 +645,16 @@ static int kvm_eiointc_create(struct kvm_device
> *dev, u32 type)
>
>          device =3D &s->device_vext;
>          kvm_iodevice_init(device, &kvm_eiointc_virt_ops);
> +       mutex_lock(&kvm->slots_lock);
>          ret =3D kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS,
>                          EIOINTC_VIRT_BASE, EIOINTC_VIRT_SIZE, device);
>          if (ret < 0) {
>                  kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &s->device=
);
> +               mutex_unlock(&kvm->slots_lock);
>                  kfree(s);
>                  return ret;
>          }
> +       mutex_unlock(&kvm->slots_lock);
>          kvm->arch.eiointc =3D s;
>
> @chenhuacai what is your option?
Both are OK for me. If we want to minimize the critical section, then
this patch is a little better.

Huacai
>
> The others look good to me.
>
> Regards
> Bibo Mao
> > @@ -667,8 +671,10 @@ static void kvm_eiointc_destroy(struct kvm_device =
*dev)
> >
> >       kvm =3D dev->kvm;
> >       eiointc =3D kvm->arch.eiointc;
> > +     mutex_lock(&kvm->slots_lock);
> >       kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device);
> >       kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device_ve=
xt);
> > +     mutex_unlock(&kvm->slots_lock);
> >       kfree(eiointc);
> >       kfree(dev);
> >   }
> > diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ip=
i.c
> > index 1f6ebbd0af5c..4fa0897d7bdb 100644
> > --- a/arch/loongarch/kvm/intc/ipi.c
> > +++ b/arch/loongarch/kvm/intc/ipi.c
> > @@ -447,7 +447,9 @@ static void kvm_ipi_destroy(struct kvm_device *dev)
> >
> >       kvm =3D dev->kvm;
> >       ipi =3D kvm->arch.ipi;
> > +     mutex_lock(&kvm->slots_lock);
> >       kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
> > +     mutex_unlock(&kvm->slots_lock);
> >       kfree(ipi);
> >       kfree(dev);
> >   }
> > diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/int=
c/pch_pic.c
> > index aa0ed59ae8cf..175a630aceb4 100644
> > --- a/arch/loongarch/kvm/intc/pch_pic.c
> > +++ b/arch/loongarch/kvm/intc/pch_pic.c
> > @@ -481,7 +481,9 @@ static void kvm_pch_pic_destroy(struct kvm_device *=
dev)
> >       kvm =3D dev->kvm;
> >       s =3D kvm->arch.pch_pic;
> >       /* unregister pch pic device and free it's memory */
> > +     mutex_lock(&kvm->slots_lock);
> >       kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);
> > +     mutex_unlock(&kvm->slots_lock);
> >       kfree(s);
> >       kfree(dev);
> >   }
> >
>
