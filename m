Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC235E944
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787067; cv=none; b=nimGb4sDE6X90vpG4HOlhPOlstVEaa3s74l9MPVbJqdIst3dVmS5c8vrWYpwjS1oSO5X3R5YyFp8OKJNjKowOVkEoz4J1+spls0aRv0q+sGhifoZQDHkW58vBBbghAufvw+bBYunymvdpIiYTLOJZAkpzBDpz8bYSkAM/jSaHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787067; c=relaxed/simple;
	bh=Y3S3VK8sM/eNaLuLr33gDAR5girMSkc8/FoweTN6Ru8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DO4Ny8k55pNrd1I6YvcnqdCZQMEpbvAf5Lr7thajQinl3lhq5vbDAa7lCVYrIodXkA6nV/v12krzszJrkOcV29F/yRVP3vc7H4F7jRIQohzS0CnTDLAcYrLBfsFBCtlG+IrPMZmbtM1eAgJ3B7fa6tArCAe+NmKik16lrxQeS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itYJH3Xo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itYJH3Xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1D41F0089C
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 06:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791787065;
	bh=AikhUb3k8PSWeJgGwE14z5CoR9UYFfng1STFIj76CXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=itYJH3XoE+kuDPBE33Xhx+lJJusmrhNLsKPtCWBXI8Nn9zo9O37X9z6dz+AM9LH/1
	 vAaVXDUXhkLKdA9Yixc81MH816zcsrqaC+6RFjWGQAUoLwUiP7KB/pql/VfGtx25fE
	 JASDHgVQBMyxIfZbFjZZz2GcgFqHkDWNFIfFIFwPV+f1tILtLRM3zD1RdsgwaAiesX
	 OnSDNEXOjiUfm85EIVype0GCRTuNFuxe+itwYruomXl9NB7zoaI8LRAi2hphjkVpHw
	 NzaWxP7oM4bI1HUFGFjgsNi+GWbnOVjM7oz2eOZM4d4iw0xQpR+6k7mcFP4Y979UaG
	 y1EIppZALdljg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so2290785a12.1
        for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 23:37:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwWUcQ5Fc1RUPZ2D2y0IUF/tOFIYtqiZyMKAK65yv7DqaRr3jZXvusJ49AAVU732jEXPNw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwyYsH1wdfyZl4clOeZQsDsjdTQ/XrK0crel/oOtuv299CLisY
	mXYSV5i+Hyz/SyuI1vgaOd5l+NaJwXYFjV6yWewu0UA79mrEdlWlvGu15pPvvsB0Ki++3KuPZ6u
	heG7cll/EeRxy2KPG7iGosIKCOsVPRiw=
X-Received: by 2002:a05:6402:1ed4:b0:6b1:ba86:5f55 with SMTP id
 4fb4d7f45d1cf-6b1ba86636dmr2219044a12.35.1791787063963; Sun, 11 Oct 2026
 23:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929102821.36112-1-cui.tao@linux.dev> <20260929102821.36112-5-cui.tao@linux.dev>
 <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com>
 <9a59af62-3e8a-12f5-4e6c-38c1953adb37@loongson.cn> <CAAhV-H6cgiMQn=1oct6KHaLADwWQJ7Ow3iT14_Gj5BQxMW22Sg@mail.gmail.com>
 <be33489e-fec4-ba52-45d9-6323b14da593@loongson.cn> <CAAhV-H5yXR8vN0NdiHWRTbGOsrqrVxZFd9g9QdaZGhdLR=BA7A@mail.gmail.com>
 <3aada818-e1e1-a802-2547-b8e41618df32@loongson.cn>
In-Reply-To: <3aada818-e1e1-a802-2547-b8e41618df32@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 12 Oct 2026 14:37:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4YrpPmQw=qsp1GqdD5tyG6k+-tBe4g1Y-HO5kgEyu4dA@mail.gmail.com>
X-Gm-Features: AclHuK-7fXYykh9eRLkclJYi-Ox_9u0k7E3K67RbFTGL5j7WMd9tYvkXLJd2ipY
Message-ID: <CAAhV-H4YrpPmQw=qsp1GqdD5tyG6k+-tBe4g1Y-HO5kgEyu4dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tao Cui <cui.tao@linux.dev>, gaosong@loongson.cn, zhaotianrui@loongson.cn, 
	loongarch@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@xen0n.name, nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:03=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/9/30 =E4=B8=8B=E5=8D=884:52, Huacai Chen wrote:
> > On Wed, Sep 30, 2026 at 10:33=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>
> >>
> >>
> >> On 2026/9/30 =E4=B8=8A=E5=8D=8810:24, Huacai Chen wrote:
> >>> On Wed, Sep 30, 2026 at 9:53=E2=80=AFAM Bibo Mao <maobibo@loongson.cn=
> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2026/9/29 =E4=B8=8B=E5=8D=888:43, Huacai Chen wrote:
> >>>>> Hi, Tao,
> >>>>>
> >>>>> On Tue, Sep 29, 2026 at 6:29=E2=80=AFPM Tao Cui <cui.tao@linux.dev>=
 wrote:
> >>>>>>
> >>>>>> From: Tao Cui <cuitao@kylinos.cn>
> >>>>>>
> >>>>>> KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
> >>>>>> invocation: every call overwrites pch_pic_base and registers the s=
ame
> >>>>>> kvm_io_device on the MMIO bus at the new address, while
> >>>>>> kvm_pch_pic_destroy() unregisters only one bus range.  After a rep=
eated
> >>>>>> init, MMIO to the stale ranges computes its register offset agains=
t the
> >>>>>> new base and silently reads 0 / drops writes, and the leftover bus
> >>>>>> entries persist until the VM is destroyed.
> >>>>>>
> >>>>>> Reject repeated initialization with -EEXIST, tracking the state wi=
th
> >>>>>> a has_init flag so the check and the MMIO base update are atomic
> >>>>>> under slots_lock.  The base is only committed after a successful b=
us
> >>>>>> registration, and the real registration error is propagated instea=
d
> >>>>>> of being replaced with -EFAULT.
> >>>>>>
> >>>>>> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read an=
d write functions")
> >>>>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> >>>>>> ---
> >>>>>>     arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
> >>>>>>     arch/loongarch/kvm/intc/pch_pic.c        | 12 ++++++++++--
> >>>>>>     2 files changed, 11 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loong=
arch/include/asm/kvm_pch_pic.h
> >>>>>> index 887b0431fd20..679132d840e6 100644
> >>>>>> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
> >>>>>> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
> >>>>>> @@ -53,6 +53,7 @@ struct loongarch_pch_pic {
> >>>>>>            spinlock_t lock;
> >>>>>>            struct kvm *kvm;
> >>>>>>            struct kvm_io_device device;
> >>>>>> +       bool has_init;
> >>>>>>            union pch_pic_id id;
> >>>>>>            uint64_t mask; /* 1:disable irq, 0:enable irq */
> >>>>>>            uint64_t htmsi_en; /* 1:msi */
> >>>>>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kv=
m/intc/pch_pic.c
> >>>>>> index 7a704f18880d..a884a043feef 100644
> >>>>>> --- a/arch/loongarch/kvm/intc/pch_pic.c
> >>>>>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> >>>>>> @@ -282,16 +282,24 @@ static int kvm_pch_pic_init(struct kvm_devic=
e *dev, u64 addr)
> >>>>>>            struct kvm_io_device *device;
> >>>>>>            struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;
> >>>>> Why so complicated? The below is enough, no?
> >>>>>
> >>>>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c
> >>>>> b/arch/loongarch/kvm/intc/pch_pic.c
> >>>>> index 2b63b0c2c7ce..7855d78304b7 100644
> >>>>> --- a/arch/loongarch/kvm/intc/pch_pic.c
> >>>>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> >>>>> @@ -281,6 +281,9 @@ static int kvm_pch_pic_init(struct kvm_device
> >>>>> *dev, u64 addr)
> >>>>>            struct kvm_io_device *device;
> >>>>>            struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;
> >>>>>
> >>>>> +       if (s->device->ops)
> >>>>> +               return -EEXIST;
> >>>> This can work, however I think that it is not a good idea to access
> >>>> internal structure field about kvm_io_device. If so, there is no use
> >>>> about API kvm_iodevice_init(), just s->device->ops =3D &kvm_pch_pic_=
ops is ok.
> >>> I'm a little not agree. :)
> >>>
> >>> I think kvm_iodevice_init() is designed to do more work rather than
> >>> just set the ops (though it just set the ops now), otherwise its name
> >>> should be kvm_iodevice_set_ops().
> >>>
> >>> In addition, even if kvm_iodevice_init() is really a setter, there is
> >>> no getter for the ops, so when we need to access ops, we can only
> >>> open-code it.
> >> if so, you can try to add kvm_iodevice_get_ops API and check the
> >> response of KVM community.
> > There is not a setter, so I don't think a getter is necessary.
> why setter is necessary, getter is not necessary.
> >
> > Moreover, you said "no other architectures directly access ops", but
> > in fact, __vgic_doorbell_to_its() from arch/arm64/kvm/vgic/vgic-its.c
> > directly accesses ops.
> If it is used by others, I have no objection any more. But for me I
> never write such code.
OK, Tao, please update your code, drop the 2nd patch and simplify the
4th one. Thanks.

Huacai

>
> >
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>>
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>> If adding has_init is redundant, maybe we can set s->pch_pic_base wi=
th
> >>>> INVALID_GPA in kvm_pch_pic_create() or some other methods. However I
> >>>> think directly accessing kvm_io_device::ops is not a good method, no
> >>>> other architectures do in such way.
> >>>>
> >>>> Regards
> >>>> Bibo Mao
> >>>>> +
> >>>>>            s->pch_pic_base =3D addr;
> >>>>>            device =3D &s->device;
> >>>>>            /* init device by pch pic writing and reading ops */
> >>>>>
> >>>>>>
> >>>>>> -       s->pch_pic_base =3D addr;
> >>>>>>            device =3D &s->device;
> >>>>>>            /* init device by pch pic writing and reading ops */
> >>>>>>            kvm_iodevice_init(device, &kvm_pch_pic_ops);
> >>>>>>            mutex_lock(&kvm->slots_lock);
> >>>>>> +       if (s->has_init) {
> >>>>>> +               ret =3D -EEXIST;
> >>>>>> +               goto out;
> >>>>>> +       }
> >>>>>>            /* register pch pic device */
> >>>>>>            ret =3D kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr=
, PCH_PIC_SIZE, device);
> >>>>>> +       if (!ret) {
> >>>>>> +               s->pch_pic_base =3D addr;
> >>>>>> +               s->has_init =3D true;
> >>>>>> +       }
> >>>>>> +out:
> >>>>>>            mutex_unlock(&kvm->slots_lock);
> >>>>>>
> >>>>>> -       return (ret < 0) ? -EFAULT : 0;
> >>>>>> +       return ret;
> >>>>>>     }
> >>>>>>
> >>>>>>     /* used by user space to get or set pch pic registers */
> >>>>>> --
> >>>>>> 2.43.0
> >>>>>>
> >>>>
> >>
> >>
>
