Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B72FD1A5
	for <kvm@vger.kernel.org>; Sun,  9 Aug 2026 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786248409; cv=none; b=FgT30q/fZFFb64SlbJqPOlN0XLF6Ei1TS1zG66z5jbpXzAtAEO/qsYnw2iDfqUGhicF4B3SFgBuGudHvqW+EBLCThyyMjWVcaMBUHrWmRbfJ/YC+88A3Izeo/FAtdxy2Cr3By4/NhlMtq+HMYDMB8taZS+W+Ip7gD34SnZXJ1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786248409; c=relaxed/simple;
	bh=/t/ZiW8n5Yeko1CynjDpmufMvwTQ0Fpx805diFf1BEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tjx7WI3RQ5uJpgvjh7AKvkyIb31dMP8Eb+RvIUkc5RA4T6we/jVw/V+aqKxV8FwHCXk2b9tMMRWVgVKbF6Ya3NaMtsjKOrw5twGOz2/HJ2duhMPTQoAjLCXzd/Kbb27gSgf75ptLe6h9qNWGJxZv2sskkNTFlJXzMGGwAFPnP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYhcmPfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYhcmPfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43911F00A3D
	for <kvm@vger.kernel.org>; Sun,  9 Aug 2026 04:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786248407;
	bh=V5oFT+Ue3upspbmCGcePUUJKyiom/9d6zgqPeC8Ttko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EYhcmPfo3vIfxjEFaNl0F8RAXvCitptUoCZrkw3fHgtUYcbu0Ez6QcnUYZv9M5+2y
	 3OVAwaDvLZeGH8G1U3zcg/Em+hgHaB0au5JcuVpstQA20ayS8LffqqKFDpUx072vIu
	 f6wcZY5La1sC9UwPCbPQEyCXEwvyj3UX7vMOyuFRhcWBUk6ykqBLCemlUIB973G2FY
	 rWqXpgXasaSsjqSXy+daMFh6raxxMdvjPJyXTAAcTBmvwRU2eAhy/fBXqzFHiYO4p9
	 QdQwHKjypy3mDmRd6b+PVr//Zm+LmQK3dFrsRLrKjck6eV86omKjZpdW+dLHhYg7BK
	 Fn2MxtRXRRmrQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a1f7f42510so662260a12.0
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 21:06:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpW3aqrr+8NqqG07+/JNnzcbL4kuy1jxlAZ82e8zqzEvwXjndd9PipzGIrTw4Oj/KMy8AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+6bB90j1aKA4OFId6EvUldUZ4LAzEY1DtsYWj3GcGD2V5vuS
	RZXNBxdO1eaJmGGnnatKcySqK8qfVZjjCdr4R/SHi6GK/SAV73IxHBEnLDVrVIBQz4JIrr5oS2C
	BT9E+INRij2Fk7xEyEisND8WKHdZa13U=
X-Received: by 2002:a05:6402:2394:b0:6a1:7718:ad44 with SMTP id
 4fb4d7f45d1cf-6a17718af13mr11628599a12.21.1786248406282; Sat, 08 Aug 2026
 21:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805054549.287648-1-cui.tao@linux.dev>
In-Reply-To: <20260805054549.287648-1-cui.tao@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 9 Aug 2026 12:06:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H59uR_WFk5rQDYm=s2_iyr1Gr0D+tE248hrfe3d+2ycog@mail.gmail.com>
X-Gm-Features: AUfX_mxxD4U35GHvV92UGyMcFQ5uCA8UBJNz6lgl71sWcqe37Jk5c_s9HxcuYV8
Message-ID: <CAAhV-H59uR_WFk5rQDYm=s2_iyr1Gr0D+tE248hrfe3d+2ycog@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KVM: Advertise already-supported capabilities
To: Tao Cui <cui.tao@linux.dev>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, kernel@xen0n.name, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Wed, Aug 5, 2026 at 1:46=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote:
>
> Several LoongArch KVM features are fully implemented but were never
> reported through their standard KVM_CHECK_EXTENSION probes, so userspace
> cannot discover them.  Advertise the ones that already work and have a
> real consumer:
>
>   - KVM_CAP_STEAL_TIME: steal time works end-to-end (host-side record
>     plus guest paravirt side), and the probe returns kvm_pvtime_supported=
().
>
>   - KVM_CAP_VCPU_ATTRIBUTES: per-vCPU device-attribute ioctls are
>     implemented (CPUCFG, PVTIME control); advertise the discovery cap.
>
> This adds no new functionality; it only makes existing features
> discoverable via the standard probe.
>
> Signed-off-by: Tao Cui <cui.tao@linux.dev>
> ---
> Changes in v2:
>   - Drop KVM_CAP_IRQFD_RESAMPLE: the only consumer is VFIO INTx, which
>     needs IOMMU/VFIO not yet available on LoongArch.
>   - Drop KVM_CAP_VM_GPA_BITS: the cap implies a GPA-width setter that
>     LoongArch does not implement.
>
>  arch/loongarch/kvm/vm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 1317c718f896..0a51931d6f6e 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -122,6 +122,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>         case KVM_CAP_IOEVENTFD:
>         case KVM_CAP_MP_STATE:
>         case KVM_CAP_SET_GUEST_DEBUG:
> +       case KVM_CAP_VCPU_ATTRIBUTES:
>                 r =3D 1;
>                 break;
>         case KVM_CAP_NR_VCPUS:
> @@ -136,6 +137,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>         case KVM_CAP_NR_MEMSLOTS:
>                 r =3D KVM_USER_MEM_SLOTS;
>                 break;
> +       case KVM_CAP_STEAL_TIME:
> +               r =3D kvm_pvtime_supported();
> +               break;
>         default:
>                 r =3D 0;
>                 break;
>
