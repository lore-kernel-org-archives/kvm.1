Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC572D23B9
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532843; cv=none; b=dgjAVq/a/U98qMJi+PXYJEeGeuQvdeXaC77YR0RgihpDfKcmyQpCRCUTm/N2aqxO+KFtDHERDw9MIaU2NHl2bS+Yz4o4zuDiIPbzOYhLfWlky0v9ABzpESuioBNGRpcmrR12NgfBb+l022bA2bOt5a0/qp7ynwHYPSWswk4CL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532843; c=relaxed/simple;
	bh=R2qjRSF1i2y/V2Z2P5Pzcmiuk0ptlQQTOh3dgzCRo9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEiSCfyLajLozUI4nUOzQKkYFZnQKIxR3CUfJtqDpst4Gn4r+YnigrRtwISXgdBoKtbdAtLnz7xU0rGGkETeq2Szot+2fB/m4ZBSIrQRkXKGtMSC0RsQurIl7pHFdsm/9Z7pAyM2OojcVLsqWy4S2EQJdQoqvgPrLpeZyAlR4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N23Nojfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N23Nojfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE511F00AC4
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532842;
	bh=hUiyUAoOWKaGpWXxaXPvAXRcAVxYUReDYqjWUP8JoAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N23NojfbdNV+TQeYvWZXaAiOgEa6hlVrL6F2c/MwRs2L8UxWsnzLFsj17QEwYskmH
	 FsD6qCUOEZO3XV8OIBw2fgdqrJOBuMlUmqL7vpNHj0UMV7ilmx9bVwC3rlHsJIWcEm
	 KnJzRraVGiqvkYawQ4WukJDNhGqwlYjF8/Xxs2Ejw+sdY+vPO5baOmsTBthsO7/ZdG
	 ZkCywUBubSED9D8s/MyvrP5fjPv21GWHgzAdYWdWorTL5X5J/V9CvvayT2i+v/TdxK
	 YYdAeB1PRN7298dkm5sFGaofkH+vTQIWPKWdOF/h9NENOEc2TXLQBOKgTTMSThdfUl
	 mvRaz1yTnvspQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15bf399d3bso117534766b.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 10:47:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqsySUf8ughjhL1gYsWNjM99YE6MZX4qjw8nAUl80HfNGAZgL0BGAibuPi1VtG6ekVqZTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPov2EqYgS4S4OKs4Uxy13Qx5n+Z/XwcDafR8YC1W55Su0+g8F
	jPrC627qDKbazJa1B4jDXpeR8G1DepRyIJ7qPbB+emxPb5VfbHMU3VN5IqeLd0anGaXrxjqX6Y/
	8DJWA7kFlSWYsPVvYjReDtfsca3iuckI=
X-Received: by 2002:a17:907:7ba6:b0:c12:b2dc:4834 with SMTP id
 a640c23a62f3a-c15ce122523mr216670966b.57.1783532840871; Wed, 08 Jul 2026
 10:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <ak1-vF3qUjeszzSC@google.com> <56649d82-bce1-4fac-b639-345376d219be@open-hieco.net>
In-Reply-To: <56649d82-bce1-4fac-b639-345376d219be@open-hieco.net>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 8 Jul 2026 10:47:07 -0700
X-Gmail-Original-Message-ID: <CAO9r8zP6vh4dP9j3RDahvm=diwudyfYvUfGtW763ehXavtCi1g@mail.gmail.com>
X-Gm-Features: AVVi8CdP_-1puD1pl8-y1R8k-j76lh-ai0pFWFixOcI7FBje8BxKg6yV-KAPQJA
Message-ID: <CAO9r8zP6vh4dP9j3RDahvm=diwudyfYvUfGtW763ehXavtCi1g@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 5:53=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.net=
> wrote:
>
>
>
> On 7/8/2026 6:34 AM, Yosry Ahmed wrote:
> > On Mon, Jun 29, 2026 at 08:52:03PM +0800, Tina Zhang wrote:
> >> The SVM DecodeAssists feature is reported in CPUID
> >> Fn8000_000A_EDX[7].  When available, hardware provides the length and =
bytes
> >> of the intercepted instruction in the VMCB, allowing a hypervisor to c=
onsume
> >> the decode information directly instead of re-decoding the instruction=
 in
> >> software on relevant VM-Exit paths.
> >>
> >> KVM currently does not expose DecodeAssists to nested SVM guests, even=
 when
> >> the host supports it, and does not propagate the hardware-provided
> >> instruction length and bytes from VMCB02 to VMCB12 on nested VM-Exit. =
 This
> >> leaves L1 with an incomplete virtual SVM CPUID model and prevents L1 f=
rom
> >> using the same hardware-assisted decode information that KVM receives =
for
> >> L2 exits.
> >>
> >> The missing virtualization was observed in practice with Hyper-V as L1=
,
> >> where the absence of DecodeAssists prevented nested SVM from being mad=
e
> >> available to L2 guests.  The fix is not Hyper-V specific.  Complete ne=
sted
> >> SVM virtualization of DecodeAssists by advertising the feature to L1 w=
hen
> >> supported by hardware, and by copying the decode-assist fields into VM=
CB12
> >> on nested VM-Exit.
> >>
> >> Add a selftest that triggers a nested page fault from L2 and verifies =
that
> >> L1 sees a non-zero instruction length and instruction bytes matching t=
he
> >> faulting instruction.
> >
> > Taking a large step back from all the discussions in the other replies:
> > Is there a measurable performance improvement? Not trying to say we
> > shouldn't do this, but we should at least see what we're trading this
> > complexity for, it's obviously not straigtforward to fully virtualize
> > decode assists.
>
> I don't have a meaningful performance number yet. My current
> understanding is that the main value of the series is more about
> architectural completeness and enabling the Hyper-V L1 use case than
> about a direct performance win.
>
> The practical issue that triggered this is Hyper-V as L1 in Hyper-V
> appears to require DecodeAssists before enabling nested SVM for L2, so
> the visible benefit is enabling that nested virtualization
> configuration. Without exposing DecodeAssists to L1 Hyper-V, the nested
> svm cases like this (L0 KVM + L1 Hyper-V + L2 KVM) would be broken,
> because the Hyper-V doesn't think the platform have the nested
> virtualization capability, although the hardware supports it.

Interesting, that's basically running QEMU in WSL, right? Probably
worth including the motivation going forward.

>
> I agree that fully virtualizing DecodeAssists is not straightforward,
> and the complexity needs to be justified.  My intent is to keep the
> implementation biased toward propagating already-available decode state:
> hardware VMCB02 bytes for hardware exits, emulator-provided bytes for
> synthesized exits when available, and only using an on-demand fetch as a
> fallback where no decoded state is available.
>
> Thanks,
> Tina
>
