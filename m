Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286178;
	b=1QYXqU5gdx3jfUIZZPTUsJInzpOp+NCDR/oo3v8rSPGVPLr9Z3bKHNjK0/+fSjJrZrqz
	 y+X3w02Ffxvonh4zTYz/l/xOr2sU6KmxJGs8P5u+xt7YFLOt9MXOKAXKFk7WOR5sSOSLw
	 a5FVvA+QTZal+YfolSzrE65d7CEsBl6AbKgOLf9U7EGRi2F2J7OHf7Bvodo9Z5q2egvMv
	 r0T5h00rwhUOXTKgtvpAFcvCKET89G4VskHYSO6SVlaw0IFO8HN9RTODPIhfWaRu+kf5a
	 5CTgSvyC/PtToy5TQ4XiZjWzX2Ezvo42LpYo+j+RbK5tUajxbALXZqVEN3ptJLkS5fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286178;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Bu/CWKPDCcsa9kOSXMtobSt/utwZ/evlDx4NIEJ/cvE=;
	b=cqwQY1ZZIzTvpDaDv0a1pxoj9kmaRPRc/6i73HC5+nQ1sKtvXSrLLEPA6PYRG0AE7EFD
	 YLNtFFvqQ0hI0TGXYu6gUv3cKn+F2XkUkT7hgulGA3Z+6HYZv5pY3IimRQOiPQWRKR0jV
	 Xs/lIuI6zTltciphStPVnim7SPtC1ZlXvQ/RBgkZUNcfOH5am2PN060fKltm7uEh0rB3w
	 KETuVpBM84dQIBTzMnaEjgn4j7nIZC0DaG4G8ca4fETsOtMcGt4cU63rl0oBPWP+8m62v
	 bHFV9ebPeVS+HLIUzUvYBKwQLFwxH4m/x+HcPXzgrw8UnPlG80m29eH/F5ppdQ+NV+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IrqAVrc/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521A606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrqAVrc/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AD91F031E7
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286178;
	bh=Bu/CWKPDCcsa9kOSXMtobSt/utwZ/evlDx4NIEJ/cvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IrqAVrc/3yeH5FEpEO724htUWgSvkDudxC4qcPzM03VjfvOnCABLjhSLcO0/2IhQa
	 8jKOPp+/cQhezq7XUUHDljkZ5yDky1S07TMTVTNcr9VEf+kWV8o+T5+0/5R8XnQ0pi
	 ac0A3hYjAQA2GFwc4hu/2+3cAsVIsplqvh4FG/7jV44dxcAGiyeMDyRBmhTcpLaLDI
	 qeB1mQM7YKWqlNuT9no/tlMJg/3y2ickke5NB2Jm+LkR97g9hFYlNjruBceZ1HnW10
	 5eeoedBZtBYJSALrQDyPeuyCL1sOtUqdPcxfXHm5nN0kEq7NN6giVuV1DRrqMlIADG
	 QuBUBZmbcbfbw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso359932666b.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 08:02:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzVYO6NLYMA456NROEH81gMrN9kxYuRbMlRnrtmaH6QUVWkfRljieBoRz47l7qKeXXaLg4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLC6iO/g/M9+P3PcpNgrFEPkNVvdGov+lTmqx/jT/YBv1xjA++g
	ypgEit5dblptHIIm+N6Q3Io2NHYB1zFeLPsQz9fkwPrr9r5Y/2UcM6UkrQLPMT3YbHOXgnhGXuo
	ycgwPOm3jw6+JLSXiawonHGCkEOR4SEk=
X-Received: by 2002:a17:906:ee8b:b0:c29:659e:2fd2 with SMTP id
 a640c23a62f3a-c49bdf309a0mr458971366b.27.1793286176883; Thu, 29 Oct 2026
 08:02:56 -0700 (PDT)
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
 <CAHCio2hpL+Y0iYdGXs5zKA-81+w_9pHs+tZPe2uaYKs8yOCz_w@mail.gmail.com>
 <CAO9r8zMBcU_s3Dpc99jse=n7Njhy8Ly-daf6--YXVD+Cw_ed1w@mail.gmail.com>
 <CAO9r8zOmH6yzcNbUOF3FoNsac8rtx47rp5wByOFfGgaBPaLxug@mail.gmail.com> <CAHCio2hTSuTf4HcJ=+wb=_EQvi2as9QMwfRMG5tUkdCmex=yJg@mail.gmail.com>
In-Reply-To: <CAHCio2hTSuTf4HcJ=+wb=_EQvi2as9QMwfRMG5tUkdCmex=yJg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 29 Oct 2026 08:02:45 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNohnNE66PVMyE-RAnKYGEfvPpzupLgCO+s0OtAdNPCyw@mail.gmail.com>
X-Gm-Features: AclHuK_9AtQI9Cq9L71bVvMpHX8tQ3tsB8oPsV8KkVS99aJp2maiwZdom2yxf3U
Message-ID: <CAO9r8zNohnNE66PVMyE-RAnKYGEfvPpzupLgCO+s0OtAdNPCyw@mail.gmail.com>
Subject: Re: Some options abort RFC: KVM: SVM: Rework ASID management
To: Jackie Yu <ufo19890607@gmail.com>
Cc: jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mlevitsk@redhat.com, pbonzini@redhat.com, seanjc@google.com, 
	thomas.lendacky@amd.com, vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:57=E2=80=AFAM Jackie Yu <ufo19890607@gmail.com> w=
rote:
>
> Subject: Re: [PATCH v2 00/29] KVM: nSVM: Optimize nSVM TLB flushes
>
> Hi Yosry,
>
> Thank you for the quick response. Two clarifications from our side:
>
> 1. About the boot failures: no emulation is involved in our experiment. O=
ur out-of-tree changes enable direct guest INVLPGB/TLBSYNC execution by cle=
aring the KVM intercepts, without any software emulation of the instruction=
. The failures occur with this unintercepted passthrough combined with stat=
ic per-vCPU ASIDs, so they are not missing cases in an emulation path. Unde=
r the per-vCPU design we did not attempt to intercept and emulate INVLPGB a=
t all.

That's what I meant, the missing emulation of INVLPGB needed with
different per-vCPU ASIDs.

>
> 2. We do not use nested virtualization in our deployments. L1 guests in o=
ur production scenarios run without nested guests. Therefore, the ASID-repl=
acement behavior you quoted from the APM does not affect our current use ca=
se: with one shared ASID per non-nested VM, an unintercepted guest INVLPGB =
would be scoped to that VM's ASID, which matches what our per-VM configurat=
ion relies on today.
>
> Regarding the direction: we understand that with per-vCPU ASIDs, correct =
handling would require intercepting INVLPGB and re-issuing a flush for ever=
y ASID in use by the VM, which you note is unlikely to perform well on larg=
e VMs. We also note your point that as long as any vCPU uses nested, KVM mu=
st intercept INVLPGB anyway because the hardware replaces the requested ASI=
D with the current ASID.
>
> If we read the situation correctly, the practical options seem to be eith=
er (a) a per-VM shared ASID mode restricted to non-nested VMs, with uninter=
cepted guest INVLPGB, plus mandatory interception whenever nested is in use=
, or (b) always intercepting and virtualizing INVLPGB under per-vCPU ASIDs.=
 Either way, direct passthrough would at most cover the non-nested case. We=
 would appreciate Sean's and Paolo's input on which direction upstream pref=
ers; we are glad to provide more details of our configuration or run tests =
that would help decide between these options.

I don't think (b) makes a lot of sense, but if we do (a) we should
always use per-VM ASIDs, supporting both implementations based on
nested vs. non-nested would be a huge pain. I think what KVM can do is
disable INVLPGB intercepts until one vCPU sets EFER.SVME (or maybe on
first VMRUN, because with enable_virt_at_load KVM will always set
EFER.SVME on once it's loaded).

>
> Thanks,
>
> Jackie
>
>
> Yosry Ahmed <yosry@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=97=
=A5=E5=91=A8=E5=9B=9B 14:08=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Wed, Oct 28, 2026 at 1:15=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> w=
rote:
>> >
>> > On Wed, Oct 28, 2026 at 6:37=E2=80=AFAM Jackie Yu <ufo19890607@gmail.c=
om> wrote:
>> > >
>> > > Hi, guys!
>> > >
>> > > Jackie Yu <ufo19890607@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=882=
8=E6=97=A5=E5=91=A8=E4=B8=89 21:36=E5=86=99=E9=81=93=EF=BC=9A
>> > >>
>> > >> Hi Yosry and KVM folks,
>> > >>
>> > >> We would appreciate your guidance on supporting INVLPGB in ordinary=
 (non-SEV)
>> > >> L1 guests alongside the proposed static per-vCPU ASIDs.
>> > >>
>> > >> The 2025 ASID rework RFC proposed one static ASID per L1 VM and lis=
ted
>> > >> "enabling INVLPGB virtualization" among its motivations [1]. The Ju=
ne
>> > >> 2026 RFC v2 changed the design from per-VM to per-vCPU ASIDs [2]. I=
n
>> > >> the October v2 series, patches 2-11 establish static per-vCPU ASIDs=
,
>> > >> while the remaining patches primarily address nested TLB flushes [3=
].
>> > >> Our question is how guest INVLPGB should be supported under the
>> > >> per-vCPU design.
>> > >>
>> > >> Some of our workloads frequently discard and repopulate memory usin=
g
>> > >> patterns involving madvise() and memset(). Broadcast IPI-based TLB
>> > >> shootdowns are expensive for these workloads, so we are interested =
in
>> > >> making AMD INVLPGB available to guests. We use a small benchmark to
>> > >> approximate the resulting shared-address-space pressure:
>> > >>
>> > >>     region =3D mmap(256 MiB, MAP_SHARED | MAP_ANONYMOUS);
>> > >>     memset(region, 0xab, 256 MiB);       // Initial population
>> > >>     start N workers, pinned across 64 allowed CPUs;
>> > >>     each worker repeatedly reads pages in its own slice of region;
>> > >>
>> > >>     repeat 500 warmup + 2,000 measured iterations:
>> > >>         start =3D clock_gettime(CLOCK_MONOTONIC);
>> > >>         madvise(region, 256 MiB, MADV_DONTNEED);
>> > >>         record elapsed madvise() time;
>> > >>         write one page in every 64 pages to repopulate part of regi=
on;
>> > >>
>> > >>     stop and join the workers;
>> > >>
>> > >> The benchmark uses memset() for initial population; subsequent
>> > >> iterations re-touch pages rather than repeatedly calling memset().
>> > >> The numbers below measure the advisor thread's madvise() syscall
>> > >> latency, not worker throughput.
>> > >>
>> > >> In our experimental KVM4 configuration with a VM-shared ASID and ou=
r
>> > >> separate guest INVLPGB passthrough changes, we observed:
>> > >>
>> > >>                          INVLPGB off     INVLPGB on    Difference
>> > >>     64 workers  mean       21.624 ms       12.505 ms     -42.17%
>> > >>                 P99        32.760 ms       21.518 ms     -34.32%
>> > >>     128 workers mean       29.553 ms       20.459 ms     -30.77%
>> > >>                 P99        39.628 ms       28.160 ms     -28.94%
>> > >>
>> > >> These are single, sequential A/B runs for each worker count, with
>> > >> 500 warmup and 2,000 measured calls per run. The process had 64
>> > >> allowed CPUs, so the 128-worker case was oversubscribed. The
>> > >> measurements show a useful latency difference, but do not by
>> > >> themselves establish INVLPGB instruction counts or IPI reductions.
>> > >>
>> > >> We then experimentally combined the October per-vCPU ASID changes f=
or
>> > >> ordinary guests with our existing, out-of-tree L1 INVLPGB/TLBSYNC
>> > >> passthrough. With guest INVLPGB enabled, a one-vCPU guest boots, bu=
t
>> > >> otherwise comparable two-vCPU and 64-vCPU guests fail early during
>> > >> boot. Keeping QEMU's +invlpgb setting while adding clearcpuid=3D419
>> > >> to the same guest kernel allows the multi-vCPU guest to boot; the
>> > >> guest logs "Clearing CPUID bits: invlpgb".
>> >
>> > I imagine for INVLPGB to work correctly with per-vCPU ASIDs, you need
>> > to intercept INVLPGB and basically issue an INVLPGB for each ASID used
>> > by this VM (nr_vcpus or 2 * nr_vcpus with nested). I can't imagine
>> > this would perform well on large VMs, not sure if virtualizing INVLPGB
>> > would still make sense.
>> >
>> > Regarding the boot failure, I would guess there are some missing cases
>> > due to the complexity of emulating INVLPGB without a shared per-VM
>> > ASID.
>> >
>> > >> These controlled boot comparisons identify a problem with combining
>> > >> static per-vCPU ASIDs and direct guest INVLPGB/TLBSYNC passthrough:
>> > >> the multi-vCPU guest fails to boot when it uses INVLPGB, but boots
>> > >> when its INVLPGB CPUID bit is cleared. A one-vCPU guest also boots
>> > >> with INVLPGB enabled.
>> > >>
>> > >> In this configuration, an unintercepted guest INVLPGB targets the
>> > >> invoking vCPU's hardware ASID, while sibling vCPUs have distinct
>> > >> ASIDs.
>> >
>> > It's neat that INVLPGB will automatically use the current ASID and not
>> > ASID=3D0 for guest usage.
>>
>> Hmm, actually, how is this supposed to work with nested
>> virtualization? The APM says:
>>
>>     A guest that executes a legal INVLPGB that is not intercepted will h=
ave
>>     the requested ASID field replaced by the current ASID and the valid
>>     ASID bit set before doing the broadcast invalidation.
>>
>> If any ASID passed by an L1 guest is replaced by its own ASID, then if
>> L1 is flushing L2's ASID (i.e. a non-zero ASID), passing through
>> INVLPGB would do the wrong thing and flush L1's ASID instead, right?
>>
>> Seems like if the VM is using nested (on any vCPU), KVM must intercept
>> INVLPGB anyway to correctly handle the ASID?
>>
>> The APM also says:
>>
>>     Two forms of INVLPGB intercepts, conditional and unconditional, are
>>     available to the hypervisor. The unconditional intercept traps all g=
uest
>>     usage of INVLPGB. The conditional intercept traps only
>>     illegally-specified INVLPGB instructions.
>>
>> When I read "conditional", I was really hoping it was conditional on
>> the ASID being zero or non-zero, as KVM really only needs to intercept
>> INVLPGB with non-zero ASIDs (assuming the ASID is shared to begin
>> with).
>>
>> Am I missing something?
