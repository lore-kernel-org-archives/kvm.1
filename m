Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A03E4C88
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260981; cv=pass; b=TAT80eM83GZX8fXIBAffUkji3HyerI1AWs9s4f7OvuGA68BwGffeTJHmWoVKQSw3crUWRTlDQD5TQduGaBKktzTgBOEoM7nmbYxsA7N6jESCezeuY4nMLhcwp/ReHx3OOaJS69cAHuFe9A9LuxCAm4cojnkYjAIh1hsNW7ltOWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260981; c=relaxed/simple;
	bh=gcTSzRaGTbutrkt9X+KlfCvLxA9mYQLFAjncxzTeeQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVQfz+nH62A+yqbdMple09JFbYb+YsTBBdKZ2DiKDMFNXBaBZi851uVvxIlWX+Bm/2sM7GOM2IZYJoYDGF5GJCZb+08mll5xoM9ia7Na24k1xDdjlfhhjgvP7PgaS+EfEs/rqLNv3fGPUZq5lMvooKPf6BcIFiWFaAEVQNcXAB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSBPb9o+; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSBPb9o+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e96502e447so6063875ad.1
        for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 11:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792260978; cv=none;
        d=google.com; s=arc-20260327;
        b=KQfNOXUWfvvwzjjEks3uDpCmq2Sv5qzrdN48NaZu+nQkrLCyenT2kPgRa5IgwwVsld
         hO2Oa3IUVTctQEJCxgeXbq1/cmNlWZogr56t4ydvWO3M28x6Bmayg02mpXGa66mW1YnG
         u1dJQDat1Bf69J1M9HB6NFhjJrENTW22ZUdsfPJlH05pjf4iBqu8+JkSopG6odTQBWtU
         +7+0zAlRRnqHN5srgIfLN4Xwez8nwqJ6BxwT7uGheobeIADno45FobORmhu1jyhJaaod
         FMjK/kImsDr8l8SgkWECpp23EwpGnzOBa1i4MRFHo77Zx0pXFNmHvOUogIwLi+ACyNpi
         OhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gcTSzRaGTbutrkt9X+KlfCvLxA9mYQLFAjncxzTeeQ8=;
        fh=lJR0E/4aP9tLgou7VliTPNkmfeD3xvAX1rBtkRoQid8=;
        b=WxvsfyKjSnR/O4fHu96rND4euv6aEcubb9lOOOMy5xwX3Haj5bCzqsK08/93OJ3iBF
         kWTl+aSMoridX0mWD2vIwOjp3Q9LC4Xa/GcA/UrDtpSb55cm8xHF+orx1Yt22wD4swgg
         C1ngSTpqt9GHjYjNZ8sNR9+YrOoK3kmeBIGT9NsVnP5MdsiyJDBC59TQPXn7weOAIjBN
         a8tYGcYiiF7BBATqR6vECgbH54DGmvCMc3ix8yHiBae8joVyY2G7Q9hD8ZNXAuUNyatE
         67TqDwMwaMbAtxmLnZVXI5hSU8kVZcqNqdA1ABMx/+k0lTNNErZHqxVjdopfgpWdd9E/
         +8eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792260978; x=1792865778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gcTSzRaGTbutrkt9X+KlfCvLxA9mYQLFAjncxzTeeQ8=;
        b=RSBPb9o+qHBLqf7bPx4y/6eKLwAKmZ+JOdHhySY5dPsZkHK0gGqeGdhpkqiUEfDWTn
         Xz7PgRs27MXpUKTwyE0U+VoeDSTiyToGowF+EzRalz22KGX2leouQlNL31ubIAQqxe0t
         Z//bjUPSCLxz7263vGceb3XbzHMGXb+Pu6OuAeab8pQXlAc/GOQjk1OQHlREVugWF6Ug
         ThgM3qTgDvB0YPC3gEOKxnbYRarTHjvnzPkWed7+rinme3a3Tw8oBwrwogQ5AAbFU7u9
         0b+amr8eG62aakcybZAT3IUX6asuL/0b8FIjFpEn4h/+4MSt13PLy0JYa1UD3EcNtg5s
         AQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792260978; x=1792865778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gcTSzRaGTbutrkt9X+KlfCvLxA9mYQLFAjncxzTeeQ8=;
        b=EwApmbPuntxUgknBVAC2nOJE6GDqaVHmBuyUMcIukwD2E5E19xhc0V6yrg5IrRwv+M
         XygQbnkw9TY4VrgXL9pOiDjrRa+3aDTaCegelkMl6RRNc4HhKcgq1F3JGhI9x3WiBnu5
         NmBgsCbmyOwuJ9aF6gWtG5PPbz5XEbrX5UgFx+4mcg3gLbHadUoKINNGhqnVguaUlZM3
         /CvEuNTRWQX9fX5hGozkMZdt/rTl+MTTCI6frRZivTX2yAzfNqYBBwd6R4PlFK/41BTP
         lTrGGg3CgArHaLVQdZa45TvCiK/6P2JO8y2aduJ1oVzzHvaX/BBflq/+XohVQKLiYUph
         TeKA==
X-Forwarded-Encrypted: i=1; AKwUvBxeAWRU9RciLecSeJnF/WsRdpOQqhbJKv8Ixc7Aub0a2hrgFUPNGxEqOe9VTc2vrbi72bo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiKYWN6qROQijbCRoA8i2h77U9h7YPiJPZWe4vqKGjn4JpG8YX
	3i1WR/fXR2hJWHhLCjDeLEy9DRWFuXjHRVoTHIAGfjvsv7atiHb4zPK3ZvFlEt5+Lwx2oF4I1Xr
	9kKwmLlcvK/Lz+TwlMNCVPJnoLG0V0jY=
X-Gm-Gg: AYBFou0c2zMhtlpVjcrD2dsa5KYRykIngOse+EK8k892S1Cs6lC7+rnEuU/Fq2ddnvr
	yNY74Nf/CHuD5ivx7gmopUyajzK8TwArXEFNHyX4WMz2SLm8O1uFLIPwY41LPl0o73rBriYrJPQ
	xP3eaUiYN2FpWMjHQe2Xn7WoB22MVVtF2bnOlT7k/Bg2O4s5PdICESkj0gj2jHapYqxUSvGWHGM
	8fOo/et0Bhrj0+rkV3ryD4CIk1sVp2NVc60k+hlX1RdjGS8FNNC2RaSS6EXChtSURtrR6fy1z7X
	RHEFZms/akTjDOIlAtZqKihjMZ89bJgPt8s+1ylkSqXzOz+ARh583+qsXEbwWXjlPye7aNpzX3u
	+UMESGZJ2P7p81zVWIA==
X-Received: by 2002:a17:903:f84:b0:2e8:1f8a:9113 with SMTP id
 d9443c01a7336-2e9a6f58265mr30097085ad.40.1792260978190; Sat, 17 Oct 2026
 11:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015145053.3664509-1-jiri@resnulli.us> <20261016234354.GA664420@nvidia.com>
In-Reply-To: <20261016234354.GA664420@nvidia.com>
From: Dionna Glaze <drdeeglaze@gmail.com>
Date: Sat, 17 Oct 2026 11:16:07 -0700
X-Gm-Features: AclHuK_VfiECrlJzL8WxJydqMRSqCDHROeCkJ1kn-iT7JVYpxgerlwtvN-75yu0
Message-ID: <CANwfdvXFLJpC4Bc1PwRoUUP20fu2K8b+FHZ1JLLFXAikC-cBaw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, david.quigley@intel.com, 
	lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, James.Bottomley@hansenpartnership.com, 
	aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, pgonda@google.com, 
	jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com, 
	jarkko@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:43=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Oct 15, 2026 at 04:50:33PM +0200, Jiri Pirko wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> >
> > Linux has several attestation interfaces tied to individual technologie=
s.
> > That makes evidence retrieval, measurement registers, device state and
> > kernel consumers provider-specific.
> >
> > This series introduces a common attestation subsystem. Its goal is to
> > support platform, TEE and device providers through one model, including
> > TPM2, TDX, SEV-SNP, Arm CCA, FIRME, Caliptra and PCI/TSM-backed devices=
.
> > This first series implements the common subsystem and a TDX provider.
> > Existing native TDX tsm_mr and tsm_report interfaces remain independent=
.
>
> To add some more colour on where this came from for others..
>

Forgive me for my following "I still don't get it" responses below.

> About 3 months ago we started looking simultaneously how to support
> roots of trust (ROT) HW in place of TPM and how to respond to the
> feedback on the netlink proposal for the TSM SPDM.

Given that I was tagged on this thread and not that one, I'd
appreciate a pointer to which you mean.
Is it https://lwn.net/Articles/1079098/?

>
> We began talking about generalizing tsm_mr to handle more than just
> "tsm" into a broader set of roots of trust, including TPM. In this way
> it could act as a multiplexor for any measurement user in the kernel,
> like IMA for example. I see others have independently come to a
> similar conclusion that IMA needs ROT agility, but I also know that
> DRTM needs the same ROT agility too.
>

+Jarkko
The TPM driver is pretty entrenched and heavily used by different user
space applications, so it seems really ambitious to bundle in TPM
here.
Consider that you have to do a lot of command interpretation to know
whether a user is getting or extending a PCR value, or whether it's
systemd doing an NVPCR thingamajig.
I don't think you can intercept commands and translate to intent for
any kind of extension to be correctly tracked by your MR journalling
addition here.
Can you explain a little more what your intent is?

> Bringing in the SPDM side, the netlink TLV uAPI fits nicely and can
> expose all the structured binary data it has. SPDM is also effectively
> a ROT without any measurement registers.
>

I would push back on SPDM being a ROT because you're talking about
different devices.
If we're Linux running on the CPU, the ROT is TPM or one of the Coco
things (SVSM vTPM, TDX attestation on MTMRs, ARM CCA attestation on
REMs).
If we're Linux running on a DPU, the expectation is Caliptra
bootstrapped the device and a DICE boot chain got to a Linux
environment without runtime extensions.
There is nothing to communicate with over SPDM to learn your own
measurements since the boot chain is available to the kernel.
If this is changing, please fill me in.

There is nothing that you communicate with over SPDM that acts as your
_own_ root of trust, with one exception I can think of that I would
call a platform security bug: a platform root of trust.
If a PRoT holds back firmware from interconnects until it has verified
the signature, and then the devices receiving the firmware do not also
have their own secure boot, then there's a physical interposition
attack surface.
It won't be the CPU that communicates with the PRoT, it'll be the BMC
(as far as I know from any architecture I've seen).
The BMC can be running Linux, and be treating the PRoT as its ROT in
older architectures that don't have Caliptra on the BMC itself.
The CPU can talk to the BMC over a privileged veth device and use
RedFish to get SPDM measurements, so there's no new device needed in
the kernel for that communication.

Are we talking about this BMC without an embedded root of trust (eROT)
case to treat SPDM as a ROT?
Any other SPDM communication would be for composite attestation by a
lead attester that all gets bound under the ROT that the lead attester
uses (presumably TPM).

> Combining the two needs together it seemed apparent that TSM is a bad
> name for this expanded purpose so we start calling this attestation
> subsystem. "root of trust" subsystem would be another way to look at
> it.
>

I don't see how a trusted security module is a bad name for this.

> The general notion is any root of trust can come with a single driver
> and expose a bunch of different uAPIs. The modern most capable one
> would be the CTLV based ioctl interface through a char dev, but in
> cases like TDX the legacy uAPIs will also remain supported.
>

What capabilities are you trying to enable, though? I'm not really
getting the picture.
If I was right about you referencing Alistair's patch series, then
perhaps this is a clue?

>>This series is different to Lukas' original approach and the approach tak=
en
>>in the previous RFCs and instead adds the PCI-CMA support as a TSM driver=
.
>>This was described by Dan in [3] and [5]. The advantage here is that for =
PCIe
>>we can leverage the TSM work for a lot of the features and provide usersp=
ace
>>a consistient interface between PCI TSM and CMA.
>>
>> [..snip..]
>>
>>Other transport mode (such as ATA, SCSI, NVMe and MCTP) will
>>therefore need slightly different approaches, as TSM doesn't apply.

I don't really know why TSM doesn't apply, and how this proposal does.

> In this way I view it as a further evolution of the tsm report and tsm
> mr components in a way that lets us harmonize the uAPI and avoid
> hardcoding things in userspace. Though the name has changed so this
> linage is not quite as apparent.
>

I don't know why using a standard protocol in user space would be "hardcodi=
ng",
if we're leaving the SPDM message construction and interpretation to user s=
pace.
The TPM commands are standardized and left to user space to manage for exam=
ple.

> For example the end goal is for systemd report to be able to
> dynamically enumerate all the ROTs in the system, include them in the
> report, and generate signatures. Without necessarily requiring ROT
> specific code.
>

What other than TPM quotes and signed SPDM message transcripts are you
trying to cover?

> This applies to SPDM as well, ultimately every SPDM user in the kernel
> should be able to get an attestation subystem cdev and flow through
> the same uAPI channels that PCIe TSM uses, also into systemd for
> measuring and logging.
>
> I'm looking at something like 7-10 ROT drivers just for the current
> set of NVIDIA ARM servers. Probably another ~5 for NVDIA non-ARM
> servers. Then a couple more down the road. It is alot of variety and
> today all this HW is largely unavailable through Linux.
>

If there are NDA'd docs to get more info on these, I'd like to work on
getting my eyes on them.
Are there some doc numbers I can ask my hardware engineering rep to
pull? They manage vendor engagement.
