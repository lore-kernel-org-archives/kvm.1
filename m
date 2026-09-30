Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07E35C6B5
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735079; cv=none; b=nRGLS6SB24w8Qkn3Bv+zPWxHISP3zyQVZxdIBkojhVWp5/JruJFXV/fRHKzb/o+OTd3pZNxCn/aRTjp71KXeU53U26GoQjJ7p6xZ6E9p0VDpUTBi2+Xk56saLaJ8KLV/1Y0uSbKalwcXudo0IUIeDO+hsuujFjxOnk0zIWKNDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735079; c=relaxed/simple;
	bh=T/Vc0FO3Y78JP1HjR48TNugIRYRKGQ7fcbDo48P4l6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLxIvThE4cHXfuLq6GvfrSwFB663FL3ZplTmu2sFXsJ+x9lF0sex0EI+VIGB9dthcMnDrSLDM5yrQI/+pkXNtJiJVExjtAX9fAvLfWpugGr/zV6JlCmyYEmdKHvItvCbF8ZhrVB9Q5lA3EDd26Sb/PdXdulHnhROGJfjvbTGbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6MUWZwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6MUWZwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1936B1F00898
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 02:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735077;
	bh=yLskajVvDe8GkqlSQ3k+ndQ86crIezLD99VL1pkAZ0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j6MUWZwasaXiU8BXTJ4jzHrrxnlsTHO5ZclduJWjO2MtamwOScatVa5MVI93fvtMK
	 djugwvoPnzKdGX1/l/zDIeIBJCNlONlpO+xKk488LTQm5lbD6TUoOghi8psAG5bMmZ
	 iagYN/eo40xahKpYoC6sBHxNgnp3YTe/NnmY54qU4m5tImC2N8V4AakXok2trABoQO
	 9BQ0/iVrqDA57048aZpke5r4NBoGtf37EUQcabYZCqOuxlwvK2lmeFCypmFR6t+gWw
	 Bh/UEVH1l37EpbZ85oRslI3a3YTNoDqJuHzQ0f7K5yOwJf1dPqG0vZKtbFaH//3SAL
	 fn66dfZAbGVXw==
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac5ef2610aso2130170a12.0
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 19:24:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzXQIm5hWQOmuoApYCzlEAqKafGtkRN1A82N1dM4seIRuHzLZsHhi5r6HIjtuRn3OJROPI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL09jRBSfbg6kfD5Kw3tzw6X+WRoHwM+h+0TWVlYdjZ7fVxcNci
	6p7rJtkVr2CKAUqn1XKYEs/AJ5TEfT7PM2x4B5MLUGbqI6VmnfruRyLlDv2/v/3+pjmGL4rMukh
	0kT1uDIwXGmxvoPTrs+rsntTuWHN/1ww=
X-Received: by 2002:a05:6402:2551:b0:6aa:12f0:166e with SMTP id
 4fb4d7f45d1cf-6ad59bc4afdmr560739a12.16.1790735075706; Tue, 29 Sep 2026
 19:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929102821.36112-1-cui.tao@linux.dev> <20260929102821.36112-5-cui.tao@linux.dev>
 <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com> <9a59af62-3e8a-12f5-4e6c-38c1953adb37@loongson.cn>
In-Reply-To: <9a59af62-3e8a-12f5-4e6c-38c1953adb37@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 30 Sep 2026 10:24:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6cgiMQn=1oct6KHaLADwWQJ7Ow3iT14_Gj5BQxMW22Sg@mail.gmail.com>
X-Gm-Features: AclHuK-TE0uWia9P8XfCiePUNf6Cgo9jrD2TpIkY4hX1tK5Ypqp--kGmfvoTiW0
Message-ID: <CAAhV-H6cgiMQn=1oct6KHaLADwWQJ7Ow3iT14_Gj5BQxMW22Sg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tao Cui <cui.tao@linux.dev>, gaosong@loongson.cn, zhaotianrui@loongson.cn, 
	loongarch@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@xen0n.name, nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:53=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/9/29 =E4=B8=8B=E5=8D=888:43, Huacai Chen wrote:
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
> >>   arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
> >>   arch/loongarch/kvm/intc/pch_pic.c        | 12 ++++++++++--
> >>   2 files changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch=
/include/asm/kvm_pch_pic.h
> >> index 887b0431fd20..679132d840e6 100644
> >> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
> >> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
> >> @@ -53,6 +53,7 @@ struct loongarch_pch_pic {
> >>          spinlock_t lock;
> >>          struct kvm *kvm;
> >>          struct kvm_io_device device;
> >> +       bool has_init;
> >>          union pch_pic_id id;
> >>          uint64_t mask; /* 1:disable irq, 0:enable irq */
> >>          uint64_t htmsi_en; /* 1:msi */
> >> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/in=
tc/pch_pic.c
> >> index 7a704f18880d..a884a043feef 100644
> >> --- a/arch/loongarch/kvm/intc/pch_pic.c
> >> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> >> @@ -282,16 +282,24 @@ static int kvm_pch_pic_init(struct kvm_device *d=
ev, u64 addr)
> >>          struct kvm_io_device *device;
> >>          struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;
> > Why so complicated? The below is enough, no?
> >
> > diff --git a/arch/loongarch/kvm/intc/pch_pic.c
> > b/arch/loongarch/kvm/intc/pch_pic.c
> > index 2b63b0c2c7ce..7855d78304b7 100644
> > --- a/arch/loongarch/kvm/intc/pch_pic.c
> > +++ b/arch/loongarch/kvm/intc/pch_pic.c
> > @@ -281,6 +281,9 @@ static int kvm_pch_pic_init(struct kvm_device
> > *dev, u64 addr)
> >          struct kvm_io_device *device;
> >          struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;
> >
> > +       if (s->device->ops)
> > +               return -EEXIST;
> This can work, however I think that it is not a good idea to access
> internal structure field about kvm_io_device. If so, there is no use
> about API kvm_iodevice_init(), just s->device->ops =3D &kvm_pch_pic_ops i=
s ok.
I'm a little not agree. :)

I think kvm_iodevice_init() is designed to do more work rather than
just set the ops (though it just set the ops now), otherwise its name
should be kvm_iodevice_set_ops().

In addition, even if kvm_iodevice_init() is really a setter, there is
no getter for the ops, so when we need to access ops, we can only
open-code it.


Huacai

>
> If adding has_init is redundant, maybe we can set s->pch_pic_base with
> INVALID_GPA in kvm_pch_pic_create() or some other methods. However I
> think directly accessing kvm_io_device::ops is not a good method, no
> other architectures do in such way.
>
> Regards
> Bibo Mao
> > +
> >          s->pch_pic_base =3D addr;
> >          device =3D &s->device;
> >          /* init device by pch pic writing and reading ops */
> >
> >>
> >> -       s->pch_pic_base =3D addr;
> >>          device =3D &s->device;
> >>          /* init device by pch pic writing and reading ops */
> >>          kvm_iodevice_init(device, &kvm_pch_pic_ops);
> >>          mutex_lock(&kvm->slots_lock);
> >> +       if (s->has_init) {
> >> +               ret =3D -EEXIST;
> >> +               goto out;
> >> +       }
> >>          /* register pch pic device */
> >>          ret =3D kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_=
PIC_SIZE, device);
> >> +       if (!ret) {
> >> +               s->pch_pic_base =3D addr;
> >> +               s->has_init =3D true;
> >> +       }
> >> +out:
> >>          mutex_unlock(&kvm->slots_lock);
> >>
> >> -       return (ret < 0) ? -EFAULT : 0;
> >> +       return ret;
> >>   }
> >>
> >>   /* used by user space to get or set pch pic registers */
> >> --
> >> 2.43.0
> >>
>
