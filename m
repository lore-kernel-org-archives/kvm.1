Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431903B47E2
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456295; cv=none; b=PQbyDoY4xXLBKk9lsiV7hNZXTr1r22DeNVi5XP5udQhRhvIY13xsRzk/qqMxrDsH335X5B0VeaHqF4nol0JNyvu9bdOQmtDvzq7/U6ZD5BCGXgTCAN7qEnKF7n0cFJXfVqUQ4qys2P0ffEQk1T9X6cxJOd+fbGUzXI5VFDm0tWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456295; c=relaxed/simple;
	bh=rIKmiPZH+xJuZhZOOa5gB26GovqjLJ7l2NrhyuJwVQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugy/P4926wsp0eHtt1Nx3ayL19DNnUHadqgDyH/RVMHQUUqCySgR4q4+bguVn+QtYAzxAUEe/Nk+kIl7BZIwYZTZgR5KUEZdPQKdNS9xJ8Tiou30uxtC5p6aKJ4BU90YT2CS8pnfw+4YYNowlRxodpALGNP2YBU3btUZQjIkWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVhNvmYV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVhNvmYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F248CC19425
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777456295;
	bh=rIKmiPZH+xJuZhZOOa5gB26GovqjLJ7l2NrhyuJwVQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MVhNvmYVtRYjfHVevrKB59NWofXv49pNxvJWFGx4NE/3w6tq6+ZyreQp8W3oHLEOP
	 OlcqdfD/cUxO4easr2Qf68pflHOHz+8oXwm9RP3BPlm/3rZyotta62fjpBUmTo5mds
	 ut1JMZ1MRlsvJn4VC+C6N9eh/z8qNCT5BC6CG0069H97pZ29kxBYInJyqTIMZ9ANQm
	 tGSwliuK+FUUMXZr4pU+r/uEZ++OCt+0EAUCwWsBhRds/DEST8v/kiMZ3LEmpXGSta
	 uWu6ujVXapyLIQIy/UCoe5EiNuU9ot1VQSZXeD32MOE5gjNdZv0acvvZkPExl2vFA0
	 +acmrfbCFhNNA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba51e69988aso1704648266b.0
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 02:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+fcM+uga2i7Twp3+quCgofSv4wWsxR6aU6UAwdVzJL+YGFM9Qq1uf6AWP+hRUPyLrnY/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbzri0wcjyfsRpDiQ5E366SNL98e7LnLJzJY7XjM2bmZxTTlx
	jyeZq0Yo8Tl26ApQkV45NOMcvFtGU9qylLZ69pAjvyldnm+X2a8tqnpvDSI5wEeHONV0qAzGr1e
	XNXXznKWlNOi7zsHIIm50aeyc2NIeXj4=
X-Received: by 2002:a17:906:5194:10b0:ba2:3f1b:1314 with SMTP id
 a640c23a62f3a-bb8045375f5mr284382766b.33.1777456293613; Wed, 29 Apr 2026
 02:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428121813.296781-1-maqianga@uniontech.com> <0b8db33a-6c26-d9f5-b78f-d9249dd02c1c@loongson.cn>
In-Reply-To: <0b8db33a-6c26-d9f5-b78f-d9249dd02c1c@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 29 Apr 2026 17:51:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7FH0Woxh4fvgZoL8LQKzNh4fkMvC3qzdpHFiRsZH=yJA@mail.gmail.com>
X-Gm-Features: AVHnY4JFcELWysuRIi0rMPkOf97VQsUzXI3ZG2R3SP-Rmv1WXieBdpiM2-QqrFs
Message-ID: <CAAhV-H7FH0Woxh4fvgZoL8LQKzNh4fkMvC3qzdpHFiRsZH=yJA@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KVM: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS
To: Bibo Mao <maobibo@loongson.cn>
Cc: Qiang Ma <maqianga@uniontech.com>, zhaotianrui@loongson.cn, kernel@xen0n.name, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 8:59=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> On 2026/4/28 =E4=B8=8B=E5=8D=888:18, Qiang Ma wrote:
> > It doesn't make sense to return the recommended maximum number of
> > vCPUs which exceeds the maximum possible number of vCPUs.
> >
> > Other architectures have already done this, such as Commit
> > 57a2e13ebdda ("KVM: MIPS: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS")
> >
> > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > ---
> >   arch/loongarch/kvm/vm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> > index 8cc5ee1c53ef..1317c718f896 100644
> > --- a/arch/loongarch/kvm/vm.c
> > +++ b/arch/loongarch/kvm/vm.c
> > @@ -125,7 +125,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
> >               r =3D 1;
> >               break;
> >       case KVM_CAP_NR_VCPUS:
> > -             r =3D num_online_cpus();
> > +             r =3D min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPU=
S);
> >               break;
> >       case KVM_CAP_MAX_VCPUS:
> >               r =3D KVM_MAX_VCPUS;
> >
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Applied, thanks.

Huacai
>
