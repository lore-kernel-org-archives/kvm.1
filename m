Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E148C8B2
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137295; cv=none; b=Zj4PbJB7tfBdkh6uPuV/BWqxJj63YvfTZMjM5pctNcDF8It5IzoiiNxaYZT8BcEYs/nAcBbkHVVao/hACKHq3CpNED/m91E+uAd2gFb/M+t37BeGWEQhcoCzgiJk4y7C3n5sVsv19vx/0NTY6XtZoVmzuai5eOh9DR2GwWwbSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137295; c=relaxed/simple;
	bh=smtV0x0tSrvbooxlb8DQX67sofExrkLcTBABJIJV6Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWVbP/Pb3Gmwdq/jVHLLgKrpECOsABWUYlpFji37qKHejdrDz9MRjkwPYm4IsYWqacYJb8Pdj5ThAXv5HLEIEuBJKQW/MzKXrVye2p6NRS9yolOrPnCXjGELRa473D+rhRIcqY6TQADySkk/CFxOrpz+aE8J7Mh4rZOYwJ0WiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spwdd1rQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spwdd1rQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B961F00A3E
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 17:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784137293;
	bh=s5GhKhxLV/U51lTF1/rLwa7GLEgA1N8qBJ9WWTgvNLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Spwdd1rQjjt1VfB1YXu52VChsIgZmarwZRrscAOrfpQYgN+3ygJ0unJaRXGdYTEWt
	 XtpRvHrliyO7EFOszm/bPcoR8NyHhmYP8XcTrcOHchZmSIFoh1TzmCGMtvE05ORc9/
	 9J6PkK371+wSZ1G3iXfB9ovxcxdGrEaYpnyMNqjq5qM9faqx22L4PF1+1tjtUhFEZU
	 RNBpiVP4IHouTxwZkI9FPvyexDHiCFR0L4mQw2QE/Yuu0eRQSKkcnxvsCs7eIbxBbS
	 hDRI2ZdXS5pC4+YLbc7IxFNYmItlxGgb7epylqlNTqxqySrr5nlKSLcaV5BkGgC3XV
	 ZDAn+nP/Rx2fw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c16794450aeso125905166b.2
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 10:41:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrzGqPQSLfsqfHaoDKTybfppBRjROabiwuqBtX5vOaXfYA7AN50u3cawrob8BpzAceKfqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGgY4MRRIXVUBKH1c1TwLDf+GIqqWK+qNZQfN4/NvpMK3a+7US
	+z7fNGb94gDJmBR1BZKgZWZoVKT64R+UhbxNoTakSNXCiZHFY6jiZyuWv+YunmJZZ2BuulFqobd
	WwsyI2wEePJnULMWGtFL4hy4IdTiIFD4=
X-Received: by 2002:a17:907:3ccb:b0:c16:12b6:243e with SMTP id
 a640c23a62f3a-c16618b0bb3mr532597966b.44.1784137292485; Wed, 15 Jul 2026
 10:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com> <albJNb-akQJ97Yor@google.com>
In-Reply-To: <albJNb-akQJ97Yor@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 15 Jul 2026 10:41:20 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNEazPF=uVfwNZWXcCg7Kzp7Q=so3uvuWCvCTqJxek1DQ@mail.gmail.com>
X-Gm-Features: AUfX_mxZ8fNpSgC7-i06XXBz09I14NQVtliOil_Fe5a4Lto0Mo4n0jfQQeVLurQ
Message-ID: <CAO9r8zNEazPF=uVfwNZWXcCg7Kzp7Q=so3uvuWCvCTqJxek1DQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Jul 14, 2026, Yosry Ahmed wrote:
> > On Tue, Jul 14, 2026 at 2:28=E2=80=AFPM Jim Mattson <jmattson@google.co=
m> wrote:
> > > > > Note: QEMU currently hardcodes the number of ASIDs to 16, so this=
 change
> > > > > doesn't help QEMU VMs (without making a similar change in QEMU).
> > > >
> > > > I had a discussion with Jim internally about what our VMM should
> > > > advertise as the number of ASIDs, and based on that I think passing
> > > > through the hardware value may not be the best idea, at least not
> > > > without some disclaimers.
> > > >
> > > > Jim pointed out that AMD CPUs will ignore unsupported ASID bits, or=
 at
> > > > least earlier ones did, even though it's not mentioned in the APM
> > > > (last time I checked). This means that technically KVM can ignore t=
he
> > > > higher bits of the ASID set by L1 beyond supported ones (e.g. if it
> > > > uses a hashtable to multiplex L1 ASIDs onto several physical ASIDs)=
.
> > > > KVM doesn't currently do so with or without this series, but it cou=
ld.
>
> Deliberately ignoring ASID bits would certainly be a choice.  I can see w=
hy
> hardware might make that compromise, but I don't see any reason why KVM s=
hould
> do the same.

Right, but KVM could decide to start doing that in the future and
still be architecturally sound.

>
> > > > The problem happens if a migration pool contains multiple AMD CPUs
> > > > with a different number of ASIDs in hardware. If the VMM advertises
> > > > the greater value of the two, it would technically be advertising a=
n
> > > > unsupported number of ASIDs on one of the CPUs. If KVM ignores the
> > > > upper bits based on what it supports, not what userspace advertises=
 in
> > > > CPUID, then userspace would be shooting itself in the foot.
> > > >
> > > > I think technically speaking userspace would be in the wrong for us=
ing
> > > > a number of ASIDs above what KVM_GET_SUPPORTED_CPUID provides, and =
it
> > > > should use a number of ASIDs that is supported by all CPUs in a
> > > > migration pool. However, this makes the VMM's life difficult, say i=
f
> > > > AMD decides to reduce the number of ASIDs in a newer CPU just for
> > > > kicks.
> > > >
> > > > All of this is hypothetical in nature, but it's a very valid concer=
n imo.
>
> Eh, I disagree.  It's hypothetical, and not a concern for KVM.
>
> > > > I think there are several ways we can handle this so that VMMs can
> > > > reasonably start advertising more ASIDs to guests without these
> > > > complications:
>
> What complications?  Advertise the lowest common feature set for the pool=
, just
> like userspace has to do for literally every other feature.

See below.

> > > > 1. We can just advertise a larger ASID value instead of 8 (say 16K =
or
> > > > 32K), rather than passthrough what's in hardware. I assume this wou=
ld
> > > > mean that KVM is more-or-less committing to supporting that number =
of
> > > > ASIDs regardless of underlying hardware (i.e. KVM wouldn't reduce i=
t
> > > > in the future). In this case, a VMM can just advertise the same val=
ue.
> > > >
> > > > 2. We can advertise the maximum number of ASIDs (2^32 - 1?), which =
is
> > > > the same as option (1), except that we're biting the bullet and
> > > > preventing the possibility of KVM ignoring upper bits completely.
> > > > Might be too aggressive.
>
> And potentially suboptimal for performance.  There might be a legitimate =
reason
> why a CPU generation advertises X instead of Y.

Right, for the CPU, but why would it be suboptimal for KVM to
advertise the max number of ASIDs. It's actually more optimal with the
current implementation of KVM, because L1 KVM has the least chance of
doing a full flush and flushing its own TLB entries unnecessarily.

> > > > 3. Document (somewhere) that KVM should use the userspace advertise=
d
> > > > value as the source of truth for ignorable bits, even if KVM
> > > > technically supports a lower value. As I am writing this I am
> > > > realizing it doesn't make much sense as it means that the value
> > > > supported by KVM is meaningless.
>
> As above, I don't think KVM should have "ignorable bits" in the first pla=
ce.

I agree, but nothing guarantees that, unless it falls under "don't
break userspace"?

>
> > > > Maybe that comes naturally with the "don't break userspace" rule, b=
ut it
> > > > could also fall under the category of userspace shooting itself in =
the
> > > > foot and KVM letting it.
> > > >
> > > > 4. Do nothing, let this be userspace's problem, and hope that AMD
> > > > doesn't reduce the number of ASIDs in a future CPU.
>
> By "Do nothing", I assume you mean "advertise what's reported in CPUID"?

Yeah, like this patch essentially.

>
> If so there's a fifth option.
>
>  5. Be super paranoid and zero the entry, like KVM does for the topology =
leaves.
>     See commit 45e966fcca03 ("KVM: x86: Do not return host topology infor=
mation
>     from KVM_GET_SUPPORTED_CPUID").
>
> IMO, the only sane options are #4 and #5, and #5 feels unnecessarily para=
noid.
> I genuinely don't see how this is any different than any other feature wh=
ere
> userspace needs to not over-advertise features across its migration pool.

I think the ASIDs case is more nuanced, at least in my mind, because:
- It's more likely for future CPUs to advertise a lower number of
ASIDs than stop supporting a feature.
- What KVM advertises to userspace is not really a hard cap, it's
actually meaningless today, and userspace can just ignore it and
advertise whatever and it would work. But, there is no guarantee this
will continue to work if KVM decides otherwise.

Sure, KVM can still punt this to userspace, but it might just make
VMM's lives more difficult for no good reason. This came up internally
when we discussed what our internal VMM should advertise. If we just
advertise the same number of ASIDs advertised by HW for the virtual
CPU, we risk not being able to add future AMD CPUs to the migration
pool if they have a lower number of ASIDs.

> "Simple" use cases that don't do migration and just reflect KVM's CPUID i=
nto
> the guest Just Work, and more sophisticated use cases get an explicit hin=
t from
> KVM as to the optimal number of ASIDs to advertise.  I don't see why we n=
eed to
> make it more complex than that.

As long as it's "a hint" it should be fine. The problem happens if KVM
decides to make it a hard limit and ignore upper bits based on it.
AFAICT, nothing prevents KVM from doing this in the future.
