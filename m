Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F913EE1E5
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005576; cv=pass; b=EaONHuTh8U8V1uu7xNaHlfaKHBasqB3e1dHoM3Z77GSHIOTWX2EC/kOJ3LQereqnCYPb8vOpsg03WnIm1TiNRzSvewb2a3WLvIhaKr7AexhJd815ZyjUVFrtdg16Rx+Ze/P8Y+za4/piVghwxqpYMeMOq/6sYwU0lbtdpsPdXFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005576; c=relaxed/simple;
	bh=DKrK8uziOsnu81Z21mMms2SVn4MRmNDPf9W6rlN6ndc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4ZHoTzx7S02p6LK+RfvUU8qdQEY6u0/W+H4n/V16qrtVal+Ik0juMcmznP0wzTiL4HVDxMft8gAFttGsnwu2P+WUzCcCVJXF/REA2QffAhH+z6WJSe6KslpukJRNhHAYRRUBb8/wXEdaVjGOVLq0V/Zr0O4SyopywsF/vdOlrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LyDaFaej; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyDaFaej"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so3696a12.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 15:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787005562; cv=none;
        d=google.com; s=arc-20260327;
        b=SgaQl4xsPsKy3i6CPyhWk8AJHJaeTaN9ieHTujENmj32jjnby3GZvwZj/PYmHSHJvp
         TPutZdUOthHgKfQRoObRQFwSyAqD2ufFWZZ7GMHjm+q51EmzH7YBJwIFHahycLf6jR54
         3PVu5cBbQuwrQ85m78zPCmNS9O0QtdSNCjgydUzNw7uy+J0Dh0Kk9TT3pIyUTuq6IY1j
         VyWPs5cdPP0Ax2rlo3Vwh4HGfMeML4rmOAc2kf7i/HWWMJSxUumjZ1e5Wu2Wr16pJwNo
         hf4dWyMC2uJGlbE7V1gsA57BWNX6ez0pqy0dWxz0k5G8+IyI5uAQq0f8Do29oROhBEI9
         NaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hENxuN5mzaES0wxF2BepwjZBV79XeYKjjyJElzU8XaI=;
        fh=f+5nZ/ESp2hIKI7D29s+oxzDMVcDlHJK0No77p3KmmY=;
        b=Q+P/CubGMUeSAuVbtZsvEkket6ynVlbYNmAQ1WJGFRtDhEKd+/n39Bar/BU9cdarJh
         4c6P9Z/506BhZXsyouyORZJKmgm+7TA2t1q9wwpDCuMetXJuX7KgvvDzw4acD25LYaUD
         qQrbD1iP7d43Vq3r1IP0jrvlInCDwmlNe73g2FASy9yNZcWqWO2CHlBMr/U/+mRzI9V7
         FRbtHif2BtTkoDEwlotVDeo3q1QA4PSG6/X+sYWhltqUOjkkWdy2fTGKvcWsXcJPVL9P
         jY9A1/68y1692DVRHlUEKwkOtMWp44PCkniWyPE2ctZ1v+0HLnsvAsUJgGaMADEBly84
         l8mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787005562; x=1787610362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hENxuN5mzaES0wxF2BepwjZBV79XeYKjjyJElzU8XaI=;
        b=LyDaFaejC43f5Ln2SZZWwjS7JztdgTDE4GuLU1gCD+uxwYua7WAKtuz/XO0/tnzL/e
         KvAfUTUeVDqQaUvHTpXqFh/4vaongrGuKRt12E4qon9DaLp0peDJSwDx+7krtn1WEe47
         dTpgSRiF1Rq6tExmCkybbkjmRWNc9/WEFhlXKe1iV26HIqtrskKODDjZKVQQg5QPW/+d
         Gk9Lf9tnbaiX0ILVXnrh+OXY3GeDSfCXZo++0CkND0ZNdrSkqoEjYXN4eyjC1tB2sMx2
         H/xrMaYlU8TFZ1ae27oI5Vqu3ymqieg3G7zi7o3y8lGuBhz5ScB49I/S96TCdc4zr+OV
         Axsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787005562; x=1787610362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hENxuN5mzaES0wxF2BepwjZBV79XeYKjjyJElzU8XaI=;
        b=m7RMw8i9sJOGx62IlQVAEqCZAD3IFDWOrTtLpzJhQI2WXtxUhP3gLs9SX49rerJM6e
         GJ3PG6flVc9KiED+nqk6UV+8MvlZw6n0WhApNle4s3XSmr9nGpcCbkRWHQu628GQQHW4
         hGC6ycMbFL0OOAnwVQ4niy5/L4Vt1Ux0dReFDQe+fqrtF8AhmD+LamvnQxOuTXMI8r7j
         vymSoy7OxmswUgFgVS/tQGYLCeKR4tGVuCNRXXUDqLLtTSMexFWzzAkCPgdhXCJncuSd
         lHhS+nLvb5h2DPDuRsejnfw/xDfrH/ASV3vDtqCDObu8xHJy+MLM0YKjF/PAXCbyn78p
         PtdA==
X-Forwarded-Encrypted: i=1; AHgh+RoedzI5oH4tNXixpZ9WlZRwAm9WVWBYnORhHzKX2VTjDvt7Fv1HCwMkx+2e5zLL6jssdB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLfVfnjfYvJUtnuwUN1dDlBt/d0Iu1OGm5//jIrlfdKNQl53Wr
	oXqrGiphr3kpFWsX2/N/COGlItjleWWT1AKA7MaxalkzyAY7V2xzySUJGhQj2wVj3X5EYoa2/vj
	haa0KOVVzg2mv95oqYJLw4H3tPZMz6KsrchXwdA+r
X-Gm-Gg: AR+sD12jB+RRcgcPcTn1yN39PJIpF7Oi7Q0+xNjfSGYNAKPoaFHi9qKaEjjdhtTHHZE
	4DGcgI8xrHG5Py3qppxMbOiCgLSmtfBBDky9BDfl2aBDqOywfaeKoq5bieznzhPl4ld8FbYRl9s
	KTzoVSHdbstKuGFdVXdxn3YWiN9i2OQa7E5WxtHS88eus9uhl9SMkxBXd+ld2TigBCaAVTnRJg9
	k2/icNhY7mXzFCA8UdLjt2W3O86fM5oHh9VvrDqZiOwlIzO3rg3SChXQaxbq0u6tbgpMuCj11y+
	WbhSQTnZ9Ut3o2Hx5H35tXHw4IgocJhIRKekqWisUifq
X-Received: by 2002:aa7:db55:0:b0:698:ac70:31b9 with SMTP id
 4fb4d7f45d1cf-6a3eb34835bmr2896a12.5.1787005561938; Mon, 17 Aug 2026 15:26:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com> <20260806233609.212337-22-seanjc@google.com>
 <ef3b56bf-8df0-4a40-82c7-bd2d65eec71e@yandex-team.ru> <aoMVy4VB1sq4T-ys@google.com>
 <0d1f0afe-74f0-4adb-a7cf-2d4efd001de3@yandex-team.ru>
In-Reply-To: <0d1f0afe-74f0-4adb-a7cf-2d4efd001de3@yandex-team.ru>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 17 Aug 2026 15:25:50 -0700
X-Gm-Features: AcwNN1WdnB6ezAOkUjWvrMa9sQkEiE5NQZNmLUZ6exeGRBIrQHFr5mGJRwWtIb4
Message-ID: <CALMp9eQRW22S6zSrhkxc+8PgSuOJJOB-jh_W1iyr7c0j5SBLow@mail.gmail.com>
Subject: Re: [PATCH v6 21/51] x86/kvm: Obtain TSC frequency from PV CPUID if present
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: Sean Christopherson <seanjc@google.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:20=E2=80=AFPM Maksim Davydov
<davydov-max@yandex-team.ru> wrote:
>
>
>
> On 8/17/26 17:08, Sean Christopherson wrote:
> > On Mon, Aug 17, 2026, Maksim Davydov wrote:
> >> On 8/7/26 02:35, Sean Christopherson wrote:
> >>> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> >>> index 29ca37e9a3bc..f55d0305d1f3 100644
> >>> --- a/arch/x86/kernel/kvmclock.c
> >>> +++ b/arch/x86/kernel/kvmclock.c
> >>> @@ -342,8 +342,10 @@ void __init kvmclock_init(void)
> >>>     flags =3D pvclock_read_flags(&hv_clock_boot[0].pvti);
> >>>     kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
> >>>
> >>> -   x86_init.hyper.get_tsc_khz =3D kvmclock_get_tsc_khz;
> >>> -   x86_init.hyper.get_cpu_khz =3D kvmclock_get_tsc_khz;
> >>> +   if (!x86_init.hyper.get_tsc_khz)
> >>> +           x86_init.hyper.get_tsc_khz =3D kvmclock_get_tsc_khz;
> >>> +   if (!x86_init.hyper.get_cpu_khz)
> >>> +           x86_init.hyper.get_cpu_khz =3D kvmclock_get_tsc_khz;
> >>>     x86_platform.get_wallclock =3D kvm_get_wallclock;
> >>>     x86_platform.set_wallclock =3D kvm_set_wallclock;
> >>>  #ifdef CONFIG_X86_LOCAL_APIC
> >>
> >>
> >> I cannot test this right now as I lack two servers with different CPU
> >> base frequencies, but it seems that this patch might break something i=
n
> >> guests:
> >> After migrating a VM (QEMU + KVM) from a host with one base frequency =
to
> >> another host with a different base frequency, the value in CPUID leaf
> >> 0x40000010 EAX changes and becomes the same as the destination host ba=
se
> >> frequency instead of remaining the source base frequency.
> >
> > That's a bug in whatever is orchestrating the migration, and/or QEMU if=
 QEMU is
> > handing the upper layers a loaded footgun.
> >
> >> The main reason for this behaviour is that setting the TSC frequency v=
ia
> >> ioctl(KVM_SET_TSC_KHZ) doesn't change the value in CPUID leaf 0x400000=
10
> >> EAX and these two entities are still not connected.
> >
> > And they never will be.  It's userspace's responsibility to fill the co=
rrect
> > values for 0x40000010.
> >
> > But AFAICT, QEMU does the right thing.  env->tsc_khz is used for both t=
he CPUID
> > leaf and for KVM_SET_TSC_KHZ.
> >
> > kvm_arch_init_vcpu():
> >
> >         c =3D &cpuid_data.entries[cpuid_i++];
> >         c->function =3D KVM_CPUID_SIGNATURE | 0x10;
> >         c->eax =3D env->tsc_khz;
> >         c->ebx =3D env->apic_bus_freq / 1000; /* Hz to KHz */
> >         c->ecx =3D c->edx =3D 0;
> >
> > kvm_arch_set_tsc_khz():
> >
> >     r =3D set_ioctl ?
> >         kvm_vcpu_ioctl(cs, KVM_SET_TSC_KHZ, env->tsc_khz) :
> >         -ENOTSUP;
> >
>
> Agreed.
> However, kvm_arch_set_tsc_khz() is also used at the end of migration
> (qemu_loadvm_state -> cpu_synchronize_post_init).
> So, the new value of env->tsc_khz from the source host can be loaded
> during migration via KVM_SET_TSC_KHZ. However, the frequency in CPUID
> leaf 0x40000010 remains the same as on the destination host (the TSC
> frequency can differ from the source host's frequency). Thus, it's
> possible to have unsynchronized CPUID leaf 0x40000010 when using default
> QEMU parameters.

I don't use qemu, but isn't the qemu solution for this general
situation to mark leaf 40000010H as 'unmigratable'?
