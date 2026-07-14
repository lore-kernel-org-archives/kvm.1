Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9441E6BE
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065425; cv=none; b=NyQc+i821ueWCtneaECdbvsyTz8eQqT/p0pwNBkArThB920jh7QpYrx/uJWp2nillI+vGe2rsRWEUZ5i3zTHNOhkv+ue2fMutHtcOKH/nmMliGv6S2n4F4xiq2tL2PSzkkirqqM5qmnRKzYBRvyUlQHfKVasjKMjDrP5mlZ74NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065425; c=relaxed/simple;
	bh=RjU9zrWvBW5YBPoWNvBVsh+sMXXy4MuakoooZHUyvGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1IhQjRHJX8AztWUsk/kwZQ5MGqIBU5gI3B/L+AJBFIxIyoXN32Kx8vsETHkBXjp49uxE5j5Vhe3pf9PZ1HoqY5ZAYYytG/nI0otZntslRKQeWabfBMTEFyA7+2SaCmZczN6VrQi8qH80bW1PBRuJgVEU5J4pgHihO/wy5VpUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWh4gPyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWh4gPyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E2F1F00A3F
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 21:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784065424;
	bh=RjU9zrWvBW5YBPoWNvBVsh+sMXXy4MuakoooZHUyvGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PWh4gPykTb6Frpx0DoD9zrIcy7PMYGbAZU2PwsGRVeCTCodAOGHwGgmLkjv26dbQ0
	 WqGb0FllDnWTEpZFTHUUu/uZ6RGtl174ftbxPjOVy2hJIUThYlXbQI7M8Ft8e89D1A
	 +GxsSZF6RObHi+iufxII6WuVWhPo5XdK79VN/hBRFhzUPc/ISpE9jTCbgbYfrvV6jY
	 Sj3OiD28W9udLViM6CUE+Pv6GYYxtnuC30T8jaq73SagXog7eVrMAAkq1EnG2LcxQK
	 HLGniIjNsXHBMCFysB3i/g0cxaCWBiGfKnKbPNnkiIYUrtAdifAKQeYUiqodiVAhx7
	 kuMmzjdyBrxdg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so7237680a12.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 14:43:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqOuWqeD1dRa1tHDLDPofnOiwf4S71/xPTSTEnpjdCXP8GNDC5r47cMTM1tWHmabzNDKPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Oqcu3ogiG05VvIjXtCbNE2ozkiNyck6AKpjnnmgEatOrl1Cx
	y7+ONOQA2br9Y5wfviZDBmFzqOAX8K/94wu5cqLmw94x7u2eTKWnvsp0NO35dlyjOOsjphpbfn0
	B3VTw4/npjZ/daSuhGf1WygkivJCX/Fg=
X-Received: by 2002:a17:906:6a22:b0:c16:e3b:7d6 with SMTP id
 a640c23a62f3a-c1661938c9dmr306054466b.54.1784065423187; Tue, 14 Jul 2026
 14:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com> <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
In-Reply-To: <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 14 Jul 2026 14:43:30 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
X-Gm-Features: AUfX_mx_U-1pVuJiuRK6ErN-DQ4ieLiphbmxI1Nk6YDCNvjnDqQBrNLwAiBwZyc
Message-ID: <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 2:28=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Tue, Jul 14, 2026 at 6:20=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Mon, Jun 15, 2026 at 5:42=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > KVM currently hardcodes the number of supported ASIDs in CPUID to 8. =
A
> > > KVM guest (L1) would then do a full TLB flush (i.e.
> > > TLB_CONTROL_FLUSH_ALL_ASID) every time it runs out of ASIDs on a vCPU
> > > and updates the generation (see new_asid()).
> > >
> > > This is currently harmless, as KVM (L0) uses the same ASID for both L=
1
> > > and L2, and flushes that ASID on nested transitions. However, followi=
ng
> > > changes will add proper ASID emulation and a separate ASID for L2,
> > > minimizing the TLB flushes on nested transitions. At that point, a fu=
ll
> > > TLB flush from a KVM guest (L1) would flush both L1 and L2 ASIDs, so
> > > should be avoided as much as possible.
> > >
> > > Passthrough the number of ASIDs in hardware instead of hardcoding 8, =
to
> > > reduce the chances of an L1 guest flushing its own TLB entries
> > > unnecessarily on a nested VMRUN.
> > >
> > > In practice, there is no harm in exposing a large number of ASIDs to =
the
> > > guest, even larger than what hardware supports, as KVM never actually
> > > uses the value of ASID from vmcb12. Even with a separate L2 ASID, KVM
> > > would allocate a (supported) ASID for L2, and just flush that same AS=
ID
> > > every time L1 changes the ASID in vmcb12.
> > >
> > > That being said, avoid the temptation of just advertising the maximum
> > > possible number of ASIDs (i.e. 0xFFFFFFFF), in case any peculiar gues=
t
> > > OS does not handle that properly.
> > >
> > > Note: QEMU currently hardcodes the number of ASIDs to 16, so this cha=
nge
> > > doesn't help QEMU VMs (without making a similar change in QEMU).
> >
> > I had a discussion with Jim internally about what our VMM should
> > advertise as the number of ASIDs, and based on that I think passing
> > through the hardware value may not be the best idea, at least not
> > without some disclaimers.
> >
> > Jim pointed out that AMD CPUs will ignore unsupported ASID bits, or at
> > least earlier ones did, even though it's not mentioned in the APM
> > (last time I checked). This means that technically KVM can ignore the
> > higher bits of the ASID set by L1 beyond supported ones (e.g. if it
> > uses a hashtable to multiplex L1 ASIDs onto several physical ASIDs).
> > KVM doesn't currently do so with or without this series, but it could.
> >
> > The problem happens if a migration pool contains multiple AMD CPUs
> > with a different number of ASIDs in hardware. If the VMM advertises
> > the greater value of the two, it would technically be advertising an
> > unsupported number of ASIDs on one of the CPUs. If KVM ignores the
> > upper bits based on what it supports, not what userspace advertises in
> > CPUID, then userspace would be shooting itself in the foot.
> >
> > I think technically speaking userspace would be in the wrong for using
> > a number of ASIDs above what KVM_GET_SUPPORTED_CPUID provides, and it
> > should use a number of ASIDs that is supported by all CPUs in a
> > migration pool. However, this makes the VMM's life difficult, say if
> > AMD decides to reduce the number of ASIDs in a newer CPU just for
> > kicks.
> >
> > All of this is hypothetical in nature, but it's a very valid concern im=
o.
> >
> > I think there are several ways we can handle this so that VMMs can
> > reasonably start advertising more ASIDs to guests without these
> > complications:
> >
> > 1. We can just advertise a larger ASID value instead of 8 (say 16K or
> > 32K), rather than passthrough what's in hardware. I assume this would
> > mean that KVM is more-or-less committing to supporting that number of
> > ASIDs regardless of underlying hardware (i.e. KVM wouldn't reduce it
> > in the future). In this case, a VMM can just advertise the same value.
> >
> > 2. We can advertise the maximum number of ASIDs (2^32 - 1?), which is
> > the same as option (1), except that we're biting the bullet and
> > preventing the possibility of KVM ignoring upper bits completely.
> > Might be too aggressive.
> >
> > 3. Document (somewhere) that KVM should use the userspace advertised
> > value as the source of truth for ignorable bits, even if KVM
> > technically supports a lower value. As I am writing this I am
> > realizing it doesn't make much sense as it means that the value
> > supported by KVM is meaningless. Maybe that comes naturally with the
> > "don't break userspace" rule, but it could also fall under the
> > category of userspace shooting itself in the foot and KVM letting it.
> >
> > 4. Do nothing, let this be userspace's problem, and hope that AMD
> > doesn't reduce the number of ASIDs in a future CPU.
> >
> > I think option (1) is probably the most reasonable, we advertise 32K
> > ASIDs, which is what recent AMD CPUs advertise anyway, but it's
> > more-or-less KVM committing to 32K ASIDs even if a newer AMD CPU
> > doesn't support them.
>
> I think Bulldozer (family 15H) first introduced support for 32K ASIDs.
> KVM still supports CPUs older than that, doesn't it?
>
> The tricky part about advertising more ASIDs than the host supports on
> pre-Bulldozer CPUs is that those CPUs don't have FlushByASID. So, do
> you flush all ASIDs when one is reused?

Currently KVM will flush all ASIDs when running out, then start reusing.

With my patches, KVM allocates a single ASID as the fallback ASID, and
keeps reusing that one after running out of ASIDs. Without
FlushByASID, KVM falls back to flushing all ASIDs. Performance will
probably suck, but I don't think we care about performance that much
on these CPUs?
