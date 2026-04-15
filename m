Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895C2FF657
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776295644; cv=pass; b=HOKnM+FXK6KBT0+WY2/EIw4lvkuOFZr9kOaDe5JTXiL8vejoj87xcUPIfQbJDazqDceM+TU0T4R/ONp9Qv7gFFFfUkEkDoGND6eKm3FRJ586/V6I7Xx8soRgIliChOwStgt5q8NwlMEhIRwPZHhttFNTWJISXwF9TXyq4bIOfDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776295644; c=relaxed/simple;
	bh=x+QG3xhCQwRR1qC6hXy7NcWy7080+KY3YK+kXqaECJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMOHoS0dx6M54MY+3VpdjW8ST0yJdEmmTRDCKYHctwy2bExlVzIXnY4ha+JrQNdlxBBklrBrHwDgY8TMoNNmZEM38+OD5UsLKIdH+Gk/FEffL7YDRz6w1H3nZmFT7AHVqwLcDIknajb8QN6yb+HxW62cDrU/pdat1YLQnL/LC7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dL+d9MfN; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dL+d9MfN"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a3342d301aso73696966d6.2
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 16:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776295641; cv=none;
        d=google.com; s=arc-20240605;
        b=BLdOM6Y4QjQk1em+yDg3x43GWnHhDPfL9UQojp6j8eWi+YBjY7wmjNWi50unOdxwUJ
         zdwUZH69ZFeIK5lW2lWdAPqgnb/Xv7RUHdfJRBNBHkUsKVhmlqzKKSlWdfn9egclCG49
         4lxZf5SNc/GoBBaVplK/RXwxYmuWlMXRjnhGnCFCJFRlwz/A9jM0pdvQa0pU/Vj7cKLo
         FTtDnfq6ZmuQMNMRcdZFVgorVWLWs7wzP2xbCV6T7uNEwCuhnm3awdLeTj8c2XhO4cl+
         33ll/Mm/u9JEPtvy7nBKu+B2ls20rcoXepwlASi0DG7rFxCMmLdf3ahHuaAUOgAeMCRM
         BP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x+QG3xhCQwRR1qC6hXy7NcWy7080+KY3YK+kXqaECJ0=;
        fh=t4wjTIcRo2x/La+yqZ14sHjG2lTsq49eV6sOT6MXGd4=;
        b=D5dxfvbzFz5giyeecyfcJXvrhWFUKSJS5gbY4/LL8McsDn8vxobwKeuV9FGO3sNJ9C
         beZmJqEButp3rzrlpUBeTAPeTXatWG6oub/JCNwZLoIBfGiBnIQ28z0ySthKJHu6kqug
         J/4+QVJK8rQRaH8COwI5O522A3kt5mcilJt0MvNQXa8KUcdj4xC8OgXCFNl1+fK932CR
         gDxPFPVYjQnIF4VMN+IwtU+n2o7D6dKrJcZDxlGIvtw+oeUf7ogQz94RUjYP9MviRITG
         W9sKavil0aXlp6LmghCb5vnJ2XlXCOC0yl+KIREefXbe2mp4g7Mf3c4Qg9yFe99ykQ7g
         5wxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776295641; x=1776900441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+QG3xhCQwRR1qC6hXy7NcWy7080+KY3YK+kXqaECJ0=;
        b=dL+d9MfNdURvdvkphCHpYVxv0litJXnk611BN0/udn9aq+wqz1hZ9KL8XmvE8Yrbrs
         QjZein2swuHU8KgO8rkbQpZhZmuZzhcxSV5Zr3joFvuZD6eHSOf0xB7yF9kiAgf21EtD
         GmhUgpM0MosFlw8iAJzjUMTSzHV27KdDExCEEQ1iz04lFohDkLNvuLVOOvTaqxRPC7lb
         qb0kDN38oMLc0L6uf58EDwMz/W09u/WZ53MWUFn3dhEY3e4PBAlkF8XQCbMo1fcxI2d0
         El0Umg9/rkNArY4GCUiIXxWHKUy8HBv5Z0gWbGXBNlGKgtD/em9I0iERhQpuRI+c3i4x
         cwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776295641; x=1776900441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+QG3xhCQwRR1qC6hXy7NcWy7080+KY3YK+kXqaECJ0=;
        b=Rv2y7acLNyYd2PtqCjyASVTD/9r7nlzr+mOk9+YUwlLqyBrpGiOuTmfCJKO+VqzrQH
         H+9R/ZbN+tJC1zZvPzjSTa3qbMstOxNBxYKFkM6KDdoDgTQgvGaevH9GwW1ITn8PYG8C
         Jz0ad6tE7pDlOZFl9etcqj0K/Hk8uyhBPu8V5t0OFFEZm631zC03+N9KMhxsShExPRpi
         qixkW5GR46SkU4sHdHtd1PHTLeu5yyy6kvpQFcv8BjnAkWFVD9w7rGkPGpHbCSk1NRij
         x/X3IUzelROpPA3gj1ApKSa9uhrJ6dXX0R2dOaI95RV1Z5QBISHRR1H5QMsoebEefjng
         eF/A==
X-Gm-Message-State: AOJu0YwqBevj48U2tTcteYIot7zmaPP/NI1R7zqCJEtWIfs4uGj4rklJ
	rz10rqqNs6D5YxN9jn0W64doswMjfO6wMTC0araP3GmWxWYY7is20j3UUKsga4FuMUA/IY5CDqI
	FTcDaKr7ZZSwltuMEIU4h5nq1YwDR6i9CA8xJtNGaq5J8ToxsgvttZI5F0FAQfA==
X-Gm-Gg: AeBDieuxwowSACjOq5ivkEMwR7eHgsp+fd7yAWoGu91X3krbRSg/4kUmwnB6/hpZLsv
	HtI3+vzLL9fUCfaVVMs7zedAu/oSnbObrIji37mhcvNOMDgA0FPUdtmIc2eUliwGeNBN1MCgWaF
	P2cy+63JrgxnKJdYFm0UuUx1NC2KwfmWXgmZ/i3C0iwaVBfuO0AthEcMxOfxZz6CoXkPbJIGif1
	eeUl6YYbfEzExBxlTCQYqVTCgopbQ6UAE3rLD1muCR3pMmXvEBG7F+G1fvqC3JKQ/mwOgxJECmh
	mOLkeOTCAS6dARuhzLO0xsZlHr4Fu3R/SG4kH6l4Ln/UV16i77vTrjFbSpE=
X-Received: by 2002:ad4:5baf:0:b0:8ac:ab13:8f15 with SMTP id
 6a1803df08f44-8acab1391c9mr232004096d6.7.1776295640870; Wed, 15 Apr 2026
 16:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318155413.793430-1-steven.price@arm.com> <CABpDEukEO4Y_fg8fv5Nr1_Pw_qOK=2UmioXk=WyPEzoEprPcGA@mail.gmail.com>
 <d661a24c-6619-4734-96bd-075d3416e809@arm.com>
In-Reply-To: <d661a24c-6619-4734-96bd-075d3416e809@arm.com>
From: Alper Gun <alpergun@google.com>
Date: Wed, 15 Apr 2026 16:27:08 -0700
X-Gm-Features: AQROBzCS-xITaK7ztBjux37Usj-fD7VQebkqcRVamG9jxnrdFdKeF2d2D3KViso
Message-ID: <CABpDEumAVf02uOS5Bj07EDyuU=z9FV-iocQU1j7gFM5z0BeV_w@mail.gmail.com>
Subject: Re: [PATCH v13 00/48] arm64: Support for Arm CCA in KVM
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 4:01=E2=80=AFAM Steven Price <steven.price@arm.com>=
 wrote:
>
> On 14/04/2026 22:40, Alper Gun wrote:
> > On Wed, Mar 18, 2026 at 8:54=E2=80=AFAM Steven Price <steven.price@arm.=
com> wrote:
> >>
> >> This series adds support for running protected VMs using KVM under the
> >> Arm Confidential Compute Architecture (CCA).
> >>
> >> New major version number! This now targets RMM v2.0-bet0[1]. And unlik=
e
> >> for Linux this represents a significant change.
> >>
> >> RMM v2.0 brings with it the ability to configure the RMM to have the
> >> same page size as the host (so no more RMM_PAGE_SIZE and dealing with
> >> granules being different from host pages). It also introduces range
> >> based APIs for many operations which should be more efficient and
> >> simplifies the code in places.
> >>
> >> The handling of the GIC has changed, so the system registers are used =
to
> >> pass the GIC state rather than memory. This means fewer changes to the
> >> KVM code as it looks much like a normal VM in this respect.
> >>
> >> And of course the new uAPI introduced in the previous v12 posting is
> >> retained so that also remains simplified compared to earlier postings.
> >>
> >> The RMM support for v2.0 is still early and so this series includes a
> >> few hacks to ease the integration. Of note are that there are some RMM
> >> v1.0 SMCs added to paper over areas where the RMM implementation isn't
> >> quite ready for v2.0, and "SROs" (see below) are deferred to the final
> >> patch in the series.
> >>
> >> The PMU in RMM v2.0 requires more handling on the RMM-side (and
> >> therefore simplifies the implementation on Linux), but this isn't quit=
e
> >> ready yet. The Linux side is implemented (but untested).
> >>
> >> PSCI still requires the VMM to provide the "target" REC for operations
> >> that affect another vCPU. This is likely to change in a future version
> >> of the specification. There's also a desire to force PSCI to be handle=
d
> >> in the VMM for realm guests - this isn't implemented yet as I'm waitin=
g
> >> for the dust to settle on the RMM interface first.
> >>
> >> Stateful RMI Operations
> >> -----------------------
> >>
> >> The RMM v2.0 spec brings a new concept of Stateful RMI Operations (SRO=
s)
> >> which allow the RMM to complete an operation over several SMC calls an=
d
> >> requesting/returning memory to the host. This has the benefit of
> >> allowing interrupts to be handled in the middle of an operation (by
> >> returning to the host to handle the interrupt without completing the
> >> operation) and enables the RMM to dynamically allocate memory for
> >> internal tracking purposes. One example of this is RMI_REC_CREATE no
> >> longer needs "auxiliary granules" provided upfront but can request the
> >> memory needed during the RMI_REC_CREATE operation.
> >>
> >> There are a fairly large number of operations that are defined as SROs
> >> in the specification, but current both Linux and RMM only have support
> >> for RMI_REC_CREATE and RMI_REC_DESTROY. There a number of TODOs/FIXMEs
> >> in the code where support is missing.
> >>
> >> Given the early stage support for this, the SRO handling is all confin=
ed
> >> to the final patch. This patch can be dropped to return to a pre-SRO
> >> state (albeit a mixture of RMM v1.0 and v2.0 APIs) for testing purpose=
s.
> >>
> >> A future posting will reorder the series to move the generic SRO suppo=
rt
> >> to an early patch and will implement the proper support for this in al=
l
> >> RMI SMCs.
> >>
> >> One aspect of SROs which is not yet well captured is that in some
> >> circumstances the Linux kernel will need to call an SRO call in a
> >> context where memory allocation is restricted (e.g. because a spinlock
> >> is held). In this case the intention is that the SRO will be cancelled=
,
> >> the spinlock dropped so the memory allocation can be completed, and th=
en
> >> the SRO restarted (obviously after rechecking the state that the
> >> spinlock was protecting). For this reason the code stores the memory
> >> allocations within a struct rmi_sro_state object - see the final patch
> >> for more details.
> >>
> >> This series is based on v7.0-rc1. It is also available as a git
> >> repository:
> >>
> >> https://gitlab.arm.com/linux-arm/linux-cca cca-host/v13
> >>
> >>
> >
> > Hi Steven,
> >
> > I have a question regarding host kexec and kdump scenarios, and
> > whether there is any plan to make them work in this initial series.
> >
> > Intel TDX and AMD SEV-SNP both have a firmware shutdown command that
> > is invoked during the kexec or panic code paths to safely bypass
> > hardware memory protections and boot into the new kernel. As far as
> > I know, there is no similar global teardown command available for
> > the RMM.
>
> Correct, the RMM specification as it stands doesn't provide a mechanism
> for the host to do this. The host would have to identify all the realm
> guests in the system: specifically the address of the RDs (Realm
> Descriptors) and RECs (Realm Execution Contexts). It needs this to tear
> down the guests and be able to undelegate the memory.
>
> It's an interesting point and I'll raise the idea of a "firmware
> shutdown command" to make this more possible.
>
> > What is the roadmap for supporting both general kexec and
> > more specifically kdump (panic) scenarios with CCA?
>
> I don't have a roadmap I'm afraid for these. kexec in theory would be
> possible with KVM gracefully terminating all realms. For kdump/panic
> that sort of graceful shutdown isn't really appropriate (or likely to
> succeed).
>

Thanks Steven for the clarification.

For us, kdump is highly critical as it is our primary diagnostic tool
for host crashes. Without it, monitoring and debugging at fleet scale
would become unmanageable.

To confirm my understanding of the current architecture: if a host
panics while no Realms are actively running (and therefore no pages
are currently in the delegated state), the standard kdump extraction
should work perfectly fine without any modifications, correct?

Regarding the KVM tracking structures (RDs, RECs, RTTs, etc.) when VMs
are running, perhaps we could use `vmcoreinfo` to export the physical
addresses of these delegated pages. This would allow tools like
`makedumpfile` to explicitly filter them out. I assume these pages must
remain hardware-locked while the VMs are active.

Long-term, having an architectural shutdown command - similar to the
TDH.SYS.DISABLE command in Intel TDX - would be incredibly useful. It
would allow the kdump kernel to safely bypass these hardware security
checks, especially when extracting host-side KVM state.

As for the protected realm memory, I assume that is an easier problem.
We naturally want to exclude guest pages from a host dump regardless
of whether they are Realm pages or not. However, accidental touches
are still fatal.

> There is also some RMM configuration which cannot be repeated (see
> RMI_RMM_CONFIG_SET) - which implies that the kexec kernel must be
> similar to the first kernel (i.e. same page size).
>
> Thanks,
> Steve
