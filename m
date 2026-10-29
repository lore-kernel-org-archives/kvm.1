Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254123;
	b=KYrn0M7PGAPfffeGfHbP0yWyKFnZDT8sKfyT1pJCFNGycX2CW94xmoRrhotfCkDqi7pv
	 zfyKBlQDhlkGKeWO4sB1N/KpOViyKn2m5LezQw4bNBZ/6FGz8/IiH4sHna4WzT0EWGpY+
	 6gGw+FMnli9ZwlW8QO+j1kGmuMQSr3sagSgAoyqcmpFEL/oelphhnsD3nFYeAVP7IobEZ
	 pWniuvKPR0MF7I5QA4JSYap2h1ePIdDUAlGWS6/2Rxj7Rt+6vN/vAJjn1mq8iYFKtSYZ8
	 eIneEjUvRN7SpaTwXQNB5vd7N8AhzrHpJCP6+SyPJYXRZRGC0HeEIf/G/4Fbh8aQbjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254123;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BLsF4wpJIbbZrsEJG2k18QoV1d35CQVAhY/liIukYqE=;
	b=zEpbJ9jcnkD0o2Pe2jN4tIbrawt60caOgxaMRcF2GHEZrtlvqSCyId9EIDim3vDx2hBX
	 yf3UIeoB3723tZa0Ccd1Z+duk5LcQ43eNZZXOHOslrRN5UwXN4fpO/cdRCn7abht7pDKa
	 gX53yJw/Qodv5keqGnVYE/GeelPrrVQDcxTbNLJwGCcg36xZfHhAG6hZKXOzT58pdwd1Z
	 HA3fqotR6I4JNtSpbsIYdr5ZJNWMHFKBhnHKYyTctgpEPu7U94MAFMmZT3j+3falsfxvk
	 UBftI402+Cja0TF6fSkdhnIHt08OVMRQj0UbJiirHyBmdluIpngEQEEdswXzit+HI0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQgMrEJZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF048606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQgMrEJZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B3F1F01825
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 06:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793254122;
	bh=BLsF4wpJIbbZrsEJG2k18QoV1d35CQVAhY/liIukYqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YQgMrEJZzc8pi4dcwarVaeo2sgT3M/8Our5ktvUS+6+MI7klOA7i8w/DD7odYGRKc
	 JyCtblT0aCTwoMDTIw+pH0KKAurCdhvGKipsEaebCU7bC0pSuGaC/EI3X4yu1dg3jf
	 ZI80sS/iNCRBW0aAEVaUFCNZUCLPylNv9xPzcQ9BtIYN8L02TI+Pxs3nnM95Uk9MOP
	 6FcfF3zqR5M2/5I2XSg1QcOiGR4F1/v25FnBYPg96LrYt/JjS9jnJp/3etHzF4uIv7
	 5A6WdsbDhcKexNHYMxL4be05zNo47V08PK+OKi48w9R7l+r23+48tC1eyo86jLT+gb
	 z8HboJsrzRJ1w==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso300267666b.2
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 23:08:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw3o4zNhdeOo6KC4zzChUM1eM+WJ3eVyGpA4eKXljj/gW4QjbuKUipRsMv3GA48DLGy4AM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoDRTzT/MIlNxXLfN676Hw+B3SCKP8lL+Ny+vd2creF0CCOoNy
	GLQYDtpSMipuupuZXlx5L4JUK100hxox/qmU+A6oG+Jowb6jRBFWnUCO36RwawevgijfHd7kI67
	LKVc+EZ/OPeJmlT7kkE12zx8hQR3HPvE=
X-Received: by 2002:a17:906:c14f:b0:c43:6d40:4f84 with SMTP id
 a640c23a62f3a-c49bddace89mr391035566b.4.1793254121218; Wed, 28 Oct 2026
 23:08:41 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHCio2jc9++n2Qoa0-sNkObZsWOybSwK1X2aBjFirchjRTBZsQ@mail.gmail.com>
 <CAHCio2hpL+Y0iYdGXs5zKA-81+w_9pHs+tZPe2uaYKs8yOCz_w@mail.gmail.com> <CAO9r8zMBcU_s3Dpc99jse=n7Njhy8Ly-daf6--YXVD+Cw_ed1w@mail.gmail.com>
In-Reply-To: <CAO9r8zMBcU_s3Dpc99jse=n7Njhy8Ly-daf6--YXVD+Cw_ed1w@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 28 Oct 2026 23:08:30 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOmH6yzcNbUOF3FoNsac8rtx47rp5wByOFfGgaBPaLxug@mail.gmail.com>
X-Gm-Features: AclHuK_-Q0Jz4mRR6smK73VVrzxuJ8LSDbRfF-XrsvhphW8oweFG2CIgPW6zY3w
Message-ID: <CAO9r8zOmH6yzcNbUOF3FoNsac8rtx47rp5wByOFfGgaBPaLxug@mail.gmail.com>
Subject: Re: Some options abort RFC: KVM: SVM: Rework ASID management
To: Jackie Yu <ufo19890607@gmail.com>
Cc: jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mlevitsk@redhat.com, pbonzini@redhat.com, seanjc@google.com, 
	thomas.lendacky@amd.com, vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 1:15=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Wed, Oct 28, 2026 at 6:37=E2=80=AFAM Jackie Yu <ufo19890607@gmail.com>=
 wrote:
> >
> > Hi, guys!
> >
> > Jackie Yu <ufo19890607@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=B8=89 21:36=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hi Yosry and KVM folks,
> >>
> >> We would appreciate your guidance on supporting INVLPGB in ordinary (n=
on-SEV)
> >> L1 guests alongside the proposed static per-vCPU ASIDs.
> >>
> >> The 2025 ASID rework RFC proposed one static ASID per L1 VM and listed
> >> "enabling INVLPGB virtualization" among its motivations [1]. The June
> >> 2026 RFC v2 changed the design from per-VM to per-vCPU ASIDs [2]. In
> >> the October v2 series, patches 2-11 establish static per-vCPU ASIDs,
> >> while the remaining patches primarily address nested TLB flushes [3].
> >> Our question is how guest INVLPGB should be supported under the
> >> per-vCPU design.
> >>
> >> Some of our workloads frequently discard and repopulate memory using
> >> patterns involving madvise() and memset(). Broadcast IPI-based TLB
> >> shootdowns are expensive for these workloads, so we are interested in
> >> making AMD INVLPGB available to guests. We use a small benchmark to
> >> approximate the resulting shared-address-space pressure:
> >>
> >>     region =3D mmap(256 MiB, MAP_SHARED | MAP_ANONYMOUS);
> >>     memset(region, 0xab, 256 MiB);       // Initial population
> >>     start N workers, pinned across 64 allowed CPUs;
> >>     each worker repeatedly reads pages in its own slice of region;
> >>
> >>     repeat 500 warmup + 2,000 measured iterations:
> >>         start =3D clock_gettime(CLOCK_MONOTONIC);
> >>         madvise(region, 256 MiB, MADV_DONTNEED);
> >>         record elapsed madvise() time;
> >>         write one page in every 64 pages to repopulate part of region;
> >>
> >>     stop and join the workers;
> >>
> >> The benchmark uses memset() for initial population; subsequent
> >> iterations re-touch pages rather than repeatedly calling memset().
> >> The numbers below measure the advisor thread's madvise() syscall
> >> latency, not worker throughput.
> >>
> >> In our experimental KVM4 configuration with a VM-shared ASID and our
> >> separate guest INVLPGB passthrough changes, we observed:
> >>
> >>                          INVLPGB off     INVLPGB on    Difference
> >>     64 workers  mean       21.624 ms       12.505 ms     -42.17%
> >>                 P99        32.760 ms       21.518 ms     -34.32%
> >>     128 workers mean       29.553 ms       20.459 ms     -30.77%
> >>                 P99        39.628 ms       28.160 ms     -28.94%
> >>
> >> These are single, sequential A/B runs for each worker count, with
> >> 500 warmup and 2,000 measured calls per run. The process had 64
> >> allowed CPUs, so the 128-worker case was oversubscribed. The
> >> measurements show a useful latency difference, but do not by
> >> themselves establish INVLPGB instruction counts or IPI reductions.
> >>
> >> We then experimentally combined the October per-vCPU ASID changes for
> >> ordinary guests with our existing, out-of-tree L1 INVLPGB/TLBSYNC
> >> passthrough. With guest INVLPGB enabled, a one-vCPU guest boots, but
> >> otherwise comparable two-vCPU and 64-vCPU guests fail early during
> >> boot. Keeping QEMU's +invlpgb setting while adding clearcpuid=3D419
> >> to the same guest kernel allows the multi-vCPU guest to boot; the
> >> guest logs "Clearing CPUID bits: invlpgb".
>
> I imagine for INVLPGB to work correctly with per-vCPU ASIDs, you need
> to intercept INVLPGB and basically issue an INVLPGB for each ASID used
> by this VM (nr_vcpus or 2 * nr_vcpus with nested). I can't imagine
> this would perform well on large VMs, not sure if virtualizing INVLPGB
> would still make sense.
>
> Regarding the boot failure, I would guess there are some missing cases
> due to the complexity of emulating INVLPGB without a shared per-VM
> ASID.
>
> >> These controlled boot comparisons identify a problem with combining
> >> static per-vCPU ASIDs and direct guest INVLPGB/TLBSYNC passthrough:
> >> the multi-vCPU guest fails to boot when it uses INVLPGB, but boots
> >> when its INVLPGB CPUID bit is cleared. A one-vCPU guest also boots
> >> with INVLPGB enabled.
> >>
> >> In this configuration, an unintercepted guest INVLPGB targets the
> >> invoking vCPU's hardware ASID, while sibling vCPUs have distinct
> >> ASIDs.
>
> It's neat that INVLPGB will automatically use the current ASID and not
> ASID=3D0 for guest usage.

Hmm, actually, how is this supposed to work with nested
virtualization? The APM says:

    A guest that executes a legal INVLPGB that is not intercepted will have
    the requested ASID field replaced by the current ASID and the valid
    ASID bit set before doing the broadcast invalidation.

If any ASID passed by an L1 guest is replaced by its own ASID, then if
L1 is flushing L2's ASID (i.e. a non-zero ASID), passing through
INVLPGB would do the wrong thing and flush L1's ASID instead, right?

Seems like if the VM is using nested (on any vCPU), KVM must intercept
INVLPGB anyway to correctly handle the ASID?

The APM also says:

    Two forms of INVLPGB intercepts, conditional and unconditional, are
    available to the hypervisor. The unconditional intercept traps all gues=
t
    usage of INVLPGB. The conditional intercept traps only
    illegally-specified INVLPGB instructions.

When I read "conditional", I was really hoping it was conditional on
the ASID being zero or non-zero, as KVM really only needs to intercept
INVLPGB with non-zero ASIDs (assuming the ASID is shared to begin
with).

Am I missing something?
