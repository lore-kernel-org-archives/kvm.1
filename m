Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793841854;
	b=eSGt7IXr4yhlYDzHQKiNLw5u1RhEE1pDzCCOnLm/aO3tscxyt5zDM59LzgSGyoMFufvc
	 jLrsJ11JXdQ+UQbxbR/2QXRQMZFchYi4M5S/o0kaIKGnOmSHEYRgqvtl9Qzlj1nwIb7iP
	 /edff79zpbUiD25j+2U5bw3o8c6t45PJOn8vdyjVWx4PW/B3gzdwpYYoJ0vmSssgIFZeZ
	 oUOj7um/xbBNmUD2P4fxF3Usq17SS6QZuT3eYt0bkA94BGa4qqd87Us6N05Pkgqu+9GTx
	 nPaMRFVrobqjRRXYDAN/Q+kitBGagaqFGOFVKQcz3mMVBVAPU0FDJcBzEgcVlxwCcgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=aHZGNhfCHVFgkveUXMTOksl91+7DPQTNESRRKH+WZGg=;
	b=I96yBWFoY0Wip8vR9ZPYDePmIkXlAKdESeAqTHUsvph3CqldWZisfeSDqe5btbbBAU1W
	 Ln/2W5rEZJhTWVztft5HyM4mXlqSJjP3sz7tFVQyd/Dzn2R81JOzUR/OUAg3aelApA+ro
	 l0MvF+TCTOTwRufBpxg18tLOl1DEl9MpH19TyRkjXzcfWSnK1Jps6siXP/EqRd68wTOGK
	 NSTDX6PZrNiJLVPYud8h7AaZyOvWdrXZTKzhFX/zb/egYWVwVZ8G2WJQ4Gz8crvAPKZ2/
	 yNIr7JF7ukTL07QrfX21miUAQoKmpqQDisT0Fh87jge7Pfq5cTIuRo8oG9FYXJSbPcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jBmIZ3CU;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6511606A32E
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 01:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6511606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jBmIZ3CU
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b08364cdc7so1272937a91.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 17:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793841853; x=1794446653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aHZGNhfCHVFgkveUXMTOksl91+7DPQTNESRRKH+WZGg=;
        b=jBmIZ3CUT45RaBBUyjrVB+Q79krXovtcFNifPl3Xi4zaCLl3NJugHftPLIYAYIEfOB
         azYKEUEp47Ebzd4snD2d3tb6fT5LYKoJS1BQ6qkzsYVPb1djl5omru4i05UYTBcs6m84
         3eOU97D4sIn3B0drLGskysLtDq578i58ZghvodBYK14j2VnlcuZx52AkTO1LiOJjh+It
         N5A/jNeFCuMlsEKzUN9heNfjaFQ7KXaw8FWDvSHkbAC9MQom2zVC7OwfvYPbcKMAeDRL
         mIvGARwQQvBr/fGBK7AR9+g6siwOpP5rZc9jbi5pFsWS+hnClobTiqKR7evMdgREjGRV
         XM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793841853; x=1794446653;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHZGNhfCHVFgkveUXMTOksl91+7DPQTNESRRKH+WZGg=;
        b=TkFQZipJ9Q2EqJURm50ICnCZEoR268IvbNqpb6PGcks+tRADaeTPI0pjS2qa9CE/Bw
         a3Mpy5fRWqHVtt04Br2wnXVGKQA7TrghkwsIiadTp3NzxDPOE/h0IqYBVJr9hPvUKrLA
         7BKQEpmrWlXi4KmD10jlK3v9Cb3uv6N9nolLZlKYaa2j+Qa6AY6pXp1od7Wq4hgTdJD0
         NJjXD27nq83wC1Z9pW7Kq3HODeA22h3L4JlZdd1hcnSvlabMLypJlNSG1NMukWtVZM2I
         4cNxBh5UpDY4gvkwyRWKMbtPGND5Ix4vJB1QkJGwmrSlXW5GSREqI/QXu+5IADUQevU+
         ESuA==
X-Forwarded-Encrypted: i=1; AKwUvBz5+kh99xPdHNwF36P2k8hOVaJz0jJN7jU8eDXF2ezLfaB1J0tDb4ucatdotD7kkFkRyFs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dHLDUv696f+6NVc0/onVjQJl49R+vii32V9kH8HBqYQu+GQbL
	xpn+i+jTSxGM2w0qrYGGaJQhii92rP4V52GfHBoGGt+VF2xfBiqrOlJKxIIuC17dljm8QP7XxNx
	9XuyBSg==
X-Received: from pjbgn10.prod.google.com ([2002:a17:90a:c78a:b0:3b0:b36b:66fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164f:b0:3ac:9ed8:f310
 with SMTP id 98e67ed59e1d1-3ae8984da7fmr16296612a91.49.1793841852497; Wed, 04
 Nov 2026 17:24:12 -0800 (PST)
Date: Wed, 4 Nov 2026 17:24:11 -0800
In-Reply-To: <CAO9r8zO=_BEefcwX6vzP7own7EmhLwrRCD=hFOB+Lejm2B=BNA@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <CAHCio2jc9++n2Qoa0-sNkObZsWOybSwK1X2aBjFirchjRTBZsQ@mail.gmail.com>
 <CAHCio2hpL+Y0iYdGXs5zKA-81+w_9pHs+tZPe2uaYKs8yOCz_w@mail.gmail.com>
 <CAO9r8zMBcU_s3Dpc99jse=n7Njhy8Ly-daf6--YXVD+Cw_ed1w@mail.gmail.com>
 <CAO9r8zOmH6yzcNbUOF3FoNsac8rtx47rp5wByOFfGgaBPaLxug@mail.gmail.com>
 <CAHCio2hTSuTf4HcJ=+wb=_EQvi2as9QMwfRMG5tUkdCmex=yJg@mail.gmail.com>
 <auNvmlmXeWPh_HKT@google.com> <CAHCio2gdqdyGcGHN+dN9hzoj_0-XSKYFS4ruFrLU+DMG-4XooQ@mail.gmail.com>
 <CAO9r8zO=_BEefcwX6vzP7own7EmhLwrRCD=hFOB+Lejm2B=BNA@mail.gmail.com>
Message-ID: <auvau8T6K5ZrUaTx@google.com>
Subject: Re: Some options abort RFC: KVM: SVM: Rework ASID management
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jackie Yu <ufo19890607@gmail.com>, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mlevitsk@redhat.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, vkuznets@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026, Yosry Ahmed wrote:
> On Mon, Nov 2, 2026 at 3:20=E2=80=AFAM Jackie Yu <ufo19890607@gmail.com> =
wrote:
> >
> > Hi Sean, Yosry, and KVM folks,
> >
> > Sean, thank you for the reminder. Sorry about the earlier formatting.
> > We will use plain text for future mailing-list replies.
> >
> > Yosry, thanks for clarifying. We understand that by "missing
> > emulation" you meant the INVLPGB handling needed with distinct
> > per-vCPU ASIDs, not a bug in an existing emulation path in our tree.
> >
> > We agree that intercepting each guest INVLPGB and issuing a separate
> > invalidation for every ASID in a large VM may undermine the benefit
> > we are seeking. Using per-VM ASIDs consistently, rather than
> > switching ASID allocation models based on nested usage, sounds like
> > a promising direction. Our production guests do not run nested VMs,
> > so direct execution before nested use would cover our use case.
> >
> > Your suggestion to change the INVLPGB interception policy when
> > nested virtualization is first used is helpful. If EFER.SVME can be
> > set before a guest runs a nested VM, the first VMRUN seems like a
> > more precise trigger. Would KVM catch that VMRUN before entering L2
> > and enable the necessary intercepts across the VM before any vCPU
> > can execute an INVLPGB requiring nested handling?
>=20
> Yeah we can do this. For example, we can have a static branch in the
> VMRUN emulation path that flips between a synchronized path that
> enables the INVLPGB intercept, and the normal path. The static branch
> might be an overkill.
>=20
> > Could those
> > intercepts then remain enabled for the VM's lifetime, rather than
> > switching back when the guest leaves nested mode?
>=20
> Probably? I think we can only switch back when all vCPUs clear
> EFER.SVME. I doubt it's worth optimizing.
>=20
> > We realize that interception would still require correct nested instruc=
tion
> > handling.
> >
> > For context, our experimental KVM4 configuration used a VM-shared
> > ASID and separate, out-of-tree guest INVLPGB passthrough. The
> > madvise() latency measurements were:
> >
> >   Workers             INVLPGB off      INVLPGB on
> >   64 mean              21.624 ms        12.505 ms
> >   64 P99               32.760 ms        21.518 ms
> >   128 mean             29.553 ms        20.459 ms
> >   128 P99              39.628 ms        28.160 ms
> >
> > These were single sequential A/B runs with 64 allowed CPUs; the
> > 128-worker run was oversubscribed. The results measure madvise()
> > syscall latency, not IPI counts, and do not quantify any additional
> > flushes from vCPU switches on a physical CPU under per-VM ASIDs.
> >
> > We can share the benchmark source and run further comparisons to
> > help evaluate that trade-off. Would the maintainers consider
> > consistent per-VM ASIDs, with direct guest INVLPGB execution before
> > nested use and interception once nested use begins, a direction
> > worth pursuing?
>=20
> As I mentioned, I (not the maintainer) have no problem with per-VM
> ASIDs. We probably want to make sure we don't regress workloads due to
> the extra TLB flushes when multiple vCPUs run on the same pCPU tho.

Short answer: no, I don't think per-VM ASIDs is a direction worth pursing.

I actually really like the *idea* of per-VM ASIDs, but in practice they jus=
t
don't work well.  Having to flush when running a different vCPU with the sa=
me
ASID is generally acceptable for SEV+, because those types of VMs aren't of=
ten
CPU overcommited, and they don't support running as nested VMs[1].  Neither=
 of
those holds true for "regular" VMs.

E.g. when running KVM as L1, having to flush on every vCPU migration become=
s a
major pain point, because L0 typically has to intercept the flushes.  With =
per-vCPU
ASIDs, we have to line of sight to eliding those flushes[2].  That should b=
e a
win for KVM-as-L0 as well, as it'll remove any "artificial" TLB misses due =
to
technically-unnecessary flushing.  CPU overcommited vCPUs will still suffer=
 more
TLB misses due to cross-vCPU TLB pressure, but they won't get hit with a pi=
le of
misses if a vCPU is bouncing between a small set of CPUs (many setups affin=
e vCPUs
to a pool, versus doing a 1:1 pin).

And despite ASIDs being per-VM for SEV+, that's more of a clever hack to av=
oid
having to add new ISA to manage encryption keys than anything else.  Maybe =
AMD
intended ASIDs to be per-VM, but the reality is they can't truly be per-VM =
since
there is no separate tag and invalidation mechanism for host-controlled map=
pings.
I.e. the ASID is basically VMX's EPT root and VPID rolled into one, and as =
a result,
it takes on the properties of both a per-VM thing and a per-vCPU thing.

INVLPGB itself also has problems.  It's a broadcast to the *entire* system.=
  Even
if there's no work to be done, *all* other pCPUs still need to respond.  I =
haven't
done benchmarking, but I wouldn't be at all surprised if there are serious =
noisy
neighbor issues if a misbehaving guest is spamming INVLPGB in a tight loop.=
  E.g.
Maxim measured the impact of ringing the AVIC doorbell in a tight loop, and=
 found
he could degrade CPU througput by something like 40-50%.

And then if the guest does something that forces KVM to intercept INVLPGB t=
o do
the right thing, I suspect Yosry is right and performance will tank.

So, outside of very specific setups, per-VM ASIDs and INVLPGB passthrough s=
eem
like a lot of complexity for little-to-no benefit.  Add in that per-VM ASID=
s will
likely do more harm than good for most other use cases, and I'm not inclind=
ed to
take on maintaining per-VM ASIDs in upstream.

Sorry :-/

[1] It's actually possible to get KVM functional when running as an SEV gue=
st,
    but it's hilariously stupid and completely defeats the value added by S=
EV.

[2] https://lore.kernel.org/all/aHWjPSIdp5B-2UBl@google.com

> Other than that, I don't want to rework my series to go back to per-VM
> ASIDs. So if Sean and Paolo are okay with per-VM ASIDs, I think this
> should be done as a follow up work on top. Just my 2c.
>=20
