Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6046331EB2
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786341807; cv=none; b=eMB2DllVZ33TXahkYw7oywWIu1WxRomeF0SNE2dgR/RgsJoykzROqGIcWI5EHFpRDdVeUZuSqBheO59tW7qS8u4ioeh2cjQcZL2ZmXix1q4IETK0aIy+YAl7dP2GNUmuhyKUAKTWLz8h1E31udjnw31Ejr506NGzJ77GjtgSr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786341807; c=relaxed/simple;
	bh=k6O2Mlu+mRAzJ6x0Cx850xbeHLyzwaswUb9BNo3+V4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=so3vsoH5kfwd03J/AE6qAbKhtc6OSLDoHirYg3+oDYABldkpIwjoZTU5qC5zhXOfYsbZYBrRnAHtzIouW46+eedajfGSFsc1ZUwcHRIa8HXPPnDxKwiRIshmZiNJHxq4VTsVD8m2TPIVlsvX1yQHXLjGcuIIrtJDuzgTqTyMm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlJuKzrR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlJuKzrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7B01F00A3A
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786341806;
	bh=rXR+qj7duh6b8eQmQaG58v6sjW7yYzN2OKKfq8LbiwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LlJuKzrR6NlfXbfJbjrNgbpSrWD2cXSlDIwBWRGru2IFVbZVzi0dJTIN+cMH1cRlK
	 yGJa4OXfyVICnkQoyKOe2Cz//O+idd6QXvF6gVgPLwbEPp/F6t63IOb7FPFykDFXX1
	 W9OkXjFmom+4O/GPqtPBGk2mL1ynZCFgVVRcLXAHEcq1etzsBFAUY8UkUCWacfY6mj
	 6ihgkSnXMOO1jJA+vdjoN+1M8H5cPeJ6MtytfmmbFAqJiHhKXRvUtQFQOVwgv69jG9
	 0wSkn0vQyOBgALV8CG5VNJFCI5nvpnNUA8O/PYL7tzvMv0oWWbNileZY+RrglfGPm3
	 IlljSOZQpjEEw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so2128617a12.0
        for <kvm@vger.kernel.org>; Sun, 09 Aug 2026 23:03:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpcbf8CxEeWctPUV8oUBqgtkjvwtXk62fdGxXt0w1uTwkJEQJ7+/i2aHa8R04dZ5v9Ks7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1d12gg7XBV+ju30e+T8R/p2Klb6U+eEeS/HP+86XbDb+7862
	BgZMFHKXUVaG4ga23aIHCdcmvvOPazKtJIwpoyb07Fbp5rza2ad8RZo+S4jnBgGqGpjUomQOcvJ
	bqfsvVRGbDZezMdW5++a4eVMdRa6+3Ck=
X-Received: by 2002:a05:6402:21ce:b0:699:fbe4:16d4 with SMTP id
 4fb4d7f45d1cf-6a14f26904cmr17151278a12.18.1786341805064; Sun, 09 Aug 2026
 23:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805054549.287648-1-cui.tao@linux.dev> <CAAhV-H59uR_WFk5rQDYm=s2_iyr1Gr0D+tE248hrfe3d+2ycog@mail.gmail.com>
 <4B35E5A9-3CA4-4AE4-BBA7-74ACD1316B6C@linux.dev>
In-Reply-To: <4B35E5A9-3CA4-4AE4-BBA7-74ACD1316B6C@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Aug 2026 14:03:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6N3FgPAMzMqFKM3+AMhcz4YiKZUmNidDYXGeKVO8L=tA@mail.gmail.com>
X-Gm-Features: AUfX_my2gN9WXYIFXBO2d_oaf5eZdl0QT8dyubMq8l7Q8hIJSjHgsdz2CY_GPZo
Message-ID: <CAAhV-H6N3FgPAMzMqFKM3+AMhcz4YiKZUmNidDYXGeKVO8L=tA@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KVM: Advertise already-supported capabilities
To: Tao Cui <cui.tao@linux.dev>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, kernel@xen0n.name, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 12:08=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote:
>
> Hi, Huacai
>
> I missed my Signed-off-by tag for this patch, my mistake.
> Could you append:
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> If it=E2=80=99s not workable, no problem at all.
Corrected.

Huacai
>
> =E4=BA=8E 2026=E5=B9=B48=E6=9C=889=E6=97=A5 GMT+08:00 12:06:36=EF=BC=8CHu=
acai Chen <chenhuacai@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
> >Applied, thanks.
> >
> >Huacai
> >
> >On Wed, Aug 5, 2026 at 1:46=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote=
:
> >>
> >> Several LoongArch KVM features are fully implemented but were never
> >> reported through their standard KVM_CHECK_EXTENSION probes, so userspa=
ce
> >> cannot discover them.  Advertise the ones that already work and have a
> >> real consumer:
> >>
> >>   - KVM_CAP_STEAL_TIME: steal time works end-to-end (host-side record
> >>     plus guest paravirt side), and the probe returns kvm_pvtime_suppor=
ted().
> >>
> >>   - KVM_CAP_VCPU_ATTRIBUTES: per-vCPU device-attribute ioctls are
> >>     implemented (CPUCFG, PVTIME control); advertise the discovery cap.
> >>
> >> This adds no new functionality; it only makes existing features
> >> discoverable via the standard probe.
> >>
> >> Signed-off-by: Tao Cui <cui.tao@linux.dev>
> >> ---
> >> Changes in v2:
> >>   - Drop KVM_CAP_IRQFD_RESAMPLE: the only consumer is VFIO INTx, which
> >>     needs IOMMU/VFIO not yet available on LoongArch.
> >>   - Drop KVM_CAP_VM_GPA_BITS: the cap implies a GPA-width setter that
> >>     LoongArch does not implement.
> >>
> >>  arch/loongarch/kvm/vm.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> >> index 1317c718f896..0a51931d6f6e 100644
> >> --- a/arch/loongarch/kvm/vm.c
> >> +++ b/arch/loongarch/kvm/vm.c
> >> @@ -122,6 +122,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, =
long ext)
> >>         case KVM_CAP_IOEVENTFD:
> >>         case KVM_CAP_MP_STATE:
> >>         case KVM_CAP_SET_GUEST_DEBUG:
> >> +       case KVM_CAP_VCPU_ATTRIBUTES:
> >>                 r =3D 1;
> >>                 break;
> >>         case KVM_CAP_NR_VCPUS:
> >> @@ -136,6 +137,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, =
long ext)
> >>         case KVM_CAP_NR_MEMSLOTS:
> >>                 r =3D KVM_USER_MEM_SLOTS;
> >>                 break;
> >> +       case KVM_CAP_STEAL_TIME:
> >> +               r =3D kvm_pvtime_supported();
> >> +               break;
> >>         default:
> >>                 r =3D 0;
> >>                 break;
> >>
