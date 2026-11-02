Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618457;
	b=xZkVpD4zYIyC3FERDyJ55Gvtl7fDbRo80bDmSEyau49QKXgeyySST0KCEqZvAuHDFA0G
	 BWJwB4ccEfCyqNdIZuyH1luCjuB27ely0BOVJv0jXT5SOF9KheLAn8yXt3RBhIwUS0u+F
	 a6wvr0VHrRU2xu3tiEq8bORf8oBqAA0uYmx2qIITNMmB+aCt87LKwhmhE59r117RN5MU6
	 6Ik6CBbtenHR/M+h3j5YwMbVKxQUY9ArzowyhooJsTEMuAmGLaCn8UP2nWRrIJxFGjzkF
	 fwHpt1AnYSCxhvgxjRjbNwGCw/Z1VGcDDN9jS+agNshiSsZCeLvb60PUMevsxzRsfLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=606lkFpezYKYJdK+zrK/Eu7/dLW3DvaWcJV8piNdwZg=;
	b=kMiTLuVbNsoQFJQzLyyacmHi+4Bmr52UC1+EmK8JAZeIGLiIOld+UbJi48kxsmZkoAUu
	 4OVTYwId6GBVHTdnSDUriYm9zBmIODM+ncHZWgyeFwjNV+QqoS6RCRUebWV12HYaVnQQi
	 O1WGt27Lri3G03cvuZp40J1j+z7XtQxJn/uMOKmyBwFYc5EWtIwxSyW/Au3PKTe2vIw8y
	 DmBGkFYjI1yCWJl5ON73cUBQrS7tVjsnQloTRb/Re5vLGzYLUiQJ+St0Fnj7q0/CtTDxA
	 bY5nqqJqlLikkhRDe7t2PJCwcITFdc/dD//pF8jdvvmp5ujeQ2uDdx/taid/mBVXSAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cz8kvan9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74897606A32E
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 11:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74897606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cz8kvan9
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so4432928a12.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 03:20:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793618456; cv=none;
        d=google.com; s=arc-20260327;
        b=YZ/edSIuASDvKDqY1RkqKpXlHNilSDVMeiVWsiZt8JL4VXYlSDccmhnaQbcpBQdGwE
         cwhrEGY/2TGoiGD+LGQXpBLVOKrZiot5NkIO/0ayyEh4cJq/MPbET3ds9Vlt+4nPdcZK
         PHDNsgqE9l+vOAGcLN1Ti8cFiLfhb3E06lIQCiQ3KLrsSocY6yJqJquiYIsEe075P/R2
         L8OA9vIOEN4fHI7yjbaLXKGjqO1/aWTkYu2BDRIlrv5guRnAhOeEXPTlAsqMLl+tqP3K
         NU3RgPoW2rlMQtcnfXvYFH6orxCRN8mFFq8ybthTQS+y+Ni56spfRr9px8UzXxby0kSJ
         ReLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=606lkFpezYKYJdK+zrK/Eu7/dLW3DvaWcJV8piNdwZg=;
        fh=iDG6dxF45Ui0gr+N6GGP0vb7VYV7ZaGnw35zrvA3qb8=;
        b=J/SL/o0wXkYN/6UpOXI7/8DDOXZh7bQHWgrCASt7XdvS0DEYgQTtbukB+YmaNmWtZh
         tLoDQHVQ7LzSp+FpfwpLRQWerAb/PlF211FGI16YO/cV6sLUzW04ANhvdGeJvLRzlq18
         IivAsc+EhTBo/69jL4EAe1tQj7o4wTlXwYp+cD3BivhsEDYHUrr0Im+StLbvZ6OjJmX2
         R78pFr7uilY6dVPfypHuy6FUj6DU+30Tuq6s69dupaPKZsgTU1v7t5IeewnGGGLejWAM
         3f9WnUAyH2RgteFIeHZhQ6j8ifIv0q1z1f0lkD6Q2YNqZJHKsf1bqax+Lb24m0+mpx/s
         7VBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618456; x=1794223256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=606lkFpezYKYJdK+zrK/Eu7/dLW3DvaWcJV8piNdwZg=;
        b=Cz8kvan9U7ghHmfRmsbOeJpVu5wzp5B/h08oQ14OfR4KbP21dIs7vuolbU22MO04IS
         S3kvGSujcyQRwEQaUpX7zC/gNpfqynK9yOUymmrv4wriSn6nshxGSd9/mrDY6yjupicd
         s5krV55vS4JyoDGFiiv7Bh8RCXGXVKCe39BBOdSafGJHGnALhJwBX+AB+eIPeOBJFl/J
         Pkm/kPz2x1JYWTPKKcvUi3kr9eeK7rNzy+ZtUEvs4BzJp1JuXBvLioWtAgNgTCB0S+tO
         fOJPIQVgXcksBrjMKcU9+b7G58rEYWvNjuOEQT+NyGg/FtCnYe2piFSecvzj1r799aC0
         u5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618456; x=1794223256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=606lkFpezYKYJdK+zrK/Eu7/dLW3DvaWcJV8piNdwZg=;
        b=FJtCpDbpPxC35greC3VAxl23PeM00m9pSAZyma0YWxL24mYOO4h6FFzIhREvIau3Sp
         gyA7TudFnz4G3MQ0+A21JXqNtXkhMGOWIPjLmOheBZLODryAB/aZxjGwyOwyYg4OvOZI
         a96kbF0Uquc7OWeAFo9BKiEfHXQZVv7gZB5NdmV6GpBEK9o5tQdJ895kO1wIdCjHieF6
         L96qh8jYoAM9FwXRNkY+Iy5mNb60D8/Wxq3cni3vtoqWsDphtMdi932epAWYMxwSez2T
         uw3wJCLd4aC+KF7L69Y97qsnD3t1ZXkW62zFQ9VC9K4xpCDFT4bGAQWJyLKSotc6dElG
         1RWw==
X-Forwarded-Encrypted: i=1; AKwUvBxR7/4ydoV9Zkp0xk6BPgmkeklgS+A1CLmgBDauC9BOUpNk9Jet3wAaLGztOpfuVAlp1Lc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJAdqjoj/Ox30y69auHbsbTb3b77jXFp0NJGCZ3SKBNMOEQT7D
	d7TqoHB/OtCkwjnK9KO8GPI3XrnjQ03t7Wu7Qbxyah0cQt6spgaOCqV58XACxpzsKwlbEACGH10
	j1dfKEk+cmGpHUtidWPckWz/9ia9vckU=
X-Gm-Gg: AYBFou1lsR/iluW3LzVA1qC/C2kAIGe/IFq1Dvr//pieuBJ/WMP0Hb59OjCApShg5w1
	6Ml/TnVhGMMJHMbT5XS1PXkyJXYkqncF6OZF4x3t/A6w06knhjYIqE1P+HZ0QP3SoI0XTC6H75y
	2YhuzqYBYHESAxoCNPvzrYuhsvc4xyd7JM4RyyjifRNAt6AjCjaYXzsMoxor1+EnOUxtw4EpIs8
	54A1qVWFzUnd7zmLzjHkUkSTCBEY6MZsJvGzaEgAodq5YTbwAiVK8MeBsH+09HYBe+XCOknqI+i
	aEmHQU7uP8O1kLun7EQCyayIXjgtzolJW5UFtRvkZhfPmlWxiU952TjGVhO6WEn+8EflMN/kfcU
	hdjJxcIbCux/vBua2qBGxxFoPPSJS7LZBTmUgGw==
X-Received: by 2002:a17:906:eec8:b0:c41:4964:90b6 with SMTP id
 a640c23a62f3a-c4ca7ab11b3mr826426566b.36.1793618455509; Mon, 02 Nov 2026
 03:20:55 -0800 (PST)
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
 <CAO9r8zOmH6yzcNbUOF3FoNsac8rtx47rp5wByOFfGgaBPaLxug@mail.gmail.com>
 <CAHCio2hTSuTf4HcJ=+wb=_EQvi2as9QMwfRMG5tUkdCmex=yJg@mail.gmail.com> <auNvmlmXeWPh_HKT@google.com>
In-Reply-To: <auNvmlmXeWPh_HKT@google.com>
From: Jackie Yu <ufo19890607@gmail.com>
Date: Mon, 2 Nov 2026 19:20:44 +0800
X-Gm-Features: AclHuK_Vt_8677gatmhuZp3hBbCkC_mRm_NI_r0ysp6uGX788AWs5GAwddQIgy4
Message-ID: <CAHCio2gdqdyGcGHN+dN9hzoj_0-XSKYFS4ruFrLU+DMG-4XooQ@mail.gmail.com>
Subject: Re: Some options abort RFC: KVM: SVM: Rework ASID management
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mlevitsk@redhat.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean, Yosry, and KVM folks,

Sean, thank you for the reminder. Sorry about the earlier formatting.
We will use plain text for future mailing-list replies.

Yosry, thanks for clarifying. We understand that by "missing
emulation" you meant the INVLPGB handling needed with distinct
per-vCPU ASIDs, not a bug in an existing emulation path in our tree.

We agree that intercepting each guest INVLPGB and issuing a separate
invalidation for every ASID in a large VM may undermine the benefit
we are seeking. Using per-VM ASIDs consistently, rather than
switching ASID allocation models based on nested usage, sounds like
a promising direction. Our production guests do not run nested VMs,
so direct execution before nested use would cover our use case.

Your suggestion to change the INVLPGB interception policy when
nested virtualization is first used is helpful. If EFER.SVME can be
set before a guest runs a nested VM, the first VMRUN seems like a
more precise trigger. Would KVM catch that VMRUN before entering L2
and enable the necessary intercepts across the VM before any vCPU
can execute an INVLPGB requiring nested handling? Could those
intercepts then remain enabled for the VM's lifetime, rather than
switching back when the guest leaves nested mode? We realize that
interception would still require correct nested instruction handling.

For context, our experimental KVM4 configuration used a VM-shared
ASID and separate, out-of-tree guest INVLPGB passthrough. The
madvise() latency measurements were:

  Workers             INVLPGB off      INVLPGB on
  64 mean              21.624 ms        12.505 ms
  64 P99               32.760 ms        21.518 ms
  128 mean             29.553 ms        20.459 ms
  128 P99              39.628 ms        28.160 ms

These were single sequential A/B runs with 64 allowed CPUs; the
128-worker run was oversubscribed. The results measure madvise()
syscall latency, not IPI counts, and do not quantify any additional
flushes from vCPU switches on a physical CPU under per-VM ASIDs.

We can share the benchmark source and run further comparisons to
help evaluate that trade-off. Would the maintainers consider
consistent per-VM ASIDs, with direct guest INVLPGB execution before
nested use and interception once nested use begins, a direction
worth pursuing?

Best regards,


Sean Christopherson <seanjc@google.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=BA=94 00:09=E5=86=99=E9=81=93=EF=BC=9A
>
> Please send mails as plain text, otherwise they get ignored by the mailin=
g lists
> and don't get archived by lore.
>
> On Thu, Oct 29, 2026, Jackie Yu wrote:
> > Subject: Re: [PATCH v2 00/29] KVM: nSVM: Optimize nSVM TLB flushes
> >
> > Hi Yosry,
> >
> > Thank you for the quick response. Two clarifications from our side:
> >
> > 1. About the boot failures: no emulation is involved in our
> > experiment. Our out-of-tree changes enable direct guest
> > INVLPGB/TLBSYNC execution by clearing the KVM intercepts, without any
> > software emulation of the instruction. The failures occur with this
> > unintercepted passthrough combined with static per-vCPU ASIDs, so they
> > are not missing cases in an emulation path. Under the per-vCPU design
> > we did not attempt to intercept and emulate INVLPGB at all.
> >
> > 2. We do not use nested virtualization in our deployments. L1 guests
> > in our production scenarios run without nested guests. Therefore, the
> > ASID-replacement behavior you quoted from the APM does not affect our
> > current use case: with one shared ASID per non-nested VM, an
> > unintercepted guest INVLPGB would be scoped to that VM's ASID, which
> > matches what our per-VM configuration relies on today.
> >
> > Regarding the direction: we understand that with per-vCPU ASIDs,
> > correct handling would require intercepting INVLPGB and re-issuing a
> > flush for every ASID in use by the VM, which you note is unlikely to
> > perform well on large VMs. We also note your point that as long as any
> > vCPU uses nested, KVM must intercept INVLPGB anyway because the
> > hardware replaces the requested ASID with the current ASID.
> >
> > If we read the situation correctly, the practical options seem to be
> > either (a) a per-VM shared ASID mode restricted to non-nested VMs,
> > with unintercepted guest INVLPGB, plus mandatory interception whenever
> > nested is in use, or (b) always intercepting and virtualizing INVLPGB
> > under per-vCPU ASIDs. Either way, direct passthrough would at most
> > cover the non-nested case. We would appreciate Sean's and Paolo's
> > input on which direction upstream prefers; we are glad to provide more
> > details of our configuration or run tests that would help decide
> > between these options.
> >
> > Thanks,
> >
> > Jackie
> >
> >
> > Yosry Ahmed <yosry@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 14:08=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > On Wed, Oct 28, 2026 at 1:15=E2=80=AFPM Yosry Ahmed <yosry@kernel.org=
> wrote:
> > > >
> > > > On Wed, Oct 28, 2026 at 6:37=E2=80=AFAM Jackie Yu <ufo19890607@gmai=
l.com> wrote:
> > > > >
> > > > > Hi, guys!
> > > > >
> > > > > Jackie Yu <ufo19890607@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=
=8828=E6=97=A5=E5=91=A8=E4=B8=89 21:36=E5=86=99=E9=81=93=EF=BC=9A
> > > > >>
> > > > >> Hi Yosry and KVM folks,
> > > > >>
> > > > >> We would appreciate your guidance on supporting INVLPGB in ordin=
ary
> > > (non-SEV)
> > > > >> L1 guests alongside the proposed static per-vCPU ASIDs.
> > > > >>
> > > > >> The 2025 ASID rework RFC proposed one static ASID per L1 VM and =
listed
> > > > >> "enabling INVLPGB virtualization" among its motivations [1]. The=
 June
> > > > >> 2026 RFC v2 changed the design from per-VM to per-vCPU ASIDs [2]=
. In
> > > > >> the October v2 series, patches 2-11 establish static per-vCPU AS=
IDs,
> > > > >> while the remaining patches primarily address nested TLB flushes=
 [3].
> > > > >> Our question is how guest INVLPGB should be supported under the
> > > > >> per-vCPU design.
> > > > >>
> > > > >> Some of our workloads frequently discard and repopulate memory u=
sing
> > > > >> patterns involving madvise() and memset(). Broadcast IPI-based T=
LB
> > > > >> shootdowns are expensive for these workloads, so we are interest=
ed in
> > > > >> making AMD INVLPGB available to guests. We use a small benchmark=
 to
> > > > >> approximate the resulting shared-address-space pressure:
> > > > >>
> > > > >>     region =3D mmap(256 MiB, MAP_SHARED | MAP_ANONYMOUS);
> > > > >>     memset(region, 0xab, 256 MiB);       // Initial population
> > > > >>     start N workers, pinned across 64 allowed CPUs;
> > > > >>     each worker repeatedly reads pages in its own slice of regio=
n;
> > > > >>
> > > > >>     repeat 500 warmup + 2,000 measured iterations:
> > > > >>         start =3D clock_gettime(CLOCK_MONOTONIC);
> > > > >>         madvise(region, 256 MiB, MADV_DONTNEED);
> > > > >>         record elapsed madvise() time;
> > > > >>         write one page in every 64 pages to repopulate part of r=
egion;
> > > > >>
> > > > >>     stop and join the workers;
> > > > >>
> > > > >> The benchmark uses memset() for initial population; subsequent
> > > > >> iterations re-touch pages rather than repeatedly calling memset(=
).
> > > > >> The numbers below measure the advisor thread's madvise() syscall
> > > > >> latency, not worker throughput.
> > > > >>
> > > > >> In our experimental KVM4 configuration with a VM-shared ASID and=
 our
> > > > >> separate guest INVLPGB passthrough changes, we observed:
> > > > >>
> > > > >>                          INVLPGB off     INVLPGB on    Differenc=
e
> > > > >>     64 workers  mean       21.624 ms       12.505 ms     -42.17%
> > > > >>                 P99        32.760 ms       21.518 ms     -34.32%
> > > > >>     128 workers mean       29.553 ms       20.459 ms     -30.77%
> > > > >>                 P99        39.628 ms       28.160 ms     -28.94%
> > > > >>
> > > > >> These are single, sequential A/B runs for each worker count, wit=
h
> > > > >> 500 warmup and 2,000 measured calls per run. The process had 64
> > > > >> allowed CPUs, so the 128-worker case was oversubscribed. The
> > > > >> measurements show a useful latency difference, but do not by
> > > > >> themselves establish INVLPGB instruction counts or IPI reduction=
s.
> > > > >>
> > > > >> We then experimentally combined the October per-vCPU ASID change=
s for
> > > > >> ordinary guests with our existing, out-of-tree L1 INVLPGB/TLBSYN=
C
> > > > >> passthrough. With guest INVLPGB enabled, a one-vCPU guest boots,=
 but
> > > > >> otherwise comparable two-vCPU and 64-vCPU guests fail early duri=
ng
> > > > >> boot. Keeping QEMU's +invlpgb setting while adding clearcpuid=3D=
419
> > > > >> to the same guest kernel allows the multi-vCPU guest to boot; th=
e
> > > > >> guest logs "Clearing CPUID bits: invlpgb".
> > > >
> > > > I imagine for INVLPGB to work correctly with per-vCPU ASIDs, you ne=
ed
> > > > to intercept INVLPGB and basically issue an INVLPGB for each ASID u=
sed
> > > > by this VM (nr_vcpus or 2 * nr_vcpus with nested). I can't imagine
> > > > this would perform well on large VMs, not sure if virtualizing INVL=
PGB
> > > > would still make sense.
> > > >
> > > > Regarding the boot failure, I would guess there are some missing ca=
ses
> > > > due to the complexity of emulating INVLPGB without a shared per-VM
> > > > ASID.
> > > >
> > > > >> These controlled boot comparisons identify a problem with combin=
ing
> > > > >> static per-vCPU ASIDs and direct guest INVLPGB/TLBSYNC passthrou=
gh:
> > > > >> the multi-vCPU guest fails to boot when it uses INVLPGB, but boo=
ts
> > > > >> when its INVLPGB CPUID bit is cleared. A one-vCPU guest also boo=
ts
> > > > >> with INVLPGB enabled.
> > > > >>
> > > > >> In this configuration, an unintercepted guest INVLPGB targets th=
e
> > > > >> invoking vCPU's hardware ASID, while sibling vCPUs have distinct
> > > > >> ASIDs.
> > > >
> > > > It's neat that INVLPGB will automatically use the current ASID and =
not
> > > > ASID=3D0 for guest usage.
> > >
> > > Hmm, actually, how is this supposed to work with nested
> > > virtualization? The APM says:
> > >
> > >     A guest that executes a legal INVLPGB that is not intercepted wil=
l have
> > >     the requested ASID field replaced by the current ASID and the val=
id
> > >     ASID bit set before doing the broadcast invalidation.
> > >
> > > If any ASID passed by an L1 guest is replaced by its own ASID, then i=
f
> > > L1 is flushing L2's ASID (i.e. a non-zero ASID), passing through
> > > INVLPGB would do the wrong thing and flush L1's ASID instead, right?
> > >
> > > Seems like if the VM is using nested (on any vCPU), KVM must intercep=
t
> > > INVLPGB anyway to correctly handle the ASID?
> > >
> > > The APM also says:
> > >
> > >     Two forms of INVLPGB intercepts, conditional and unconditional, a=
re
> > >     available to the hypervisor. The unconditional intercept traps al=
l
> > > guest
> > >     usage of INVLPGB. The conditional intercept traps only
> > >     illegally-specified INVLPGB instructions.
> > >
> > > When I read "conditional", I was really hoping it was conditional on
> > > the ASID being zero or non-zero, as KVM really only needs to intercep=
t
> > > INVLPGB with non-zero ASIDs (assuming the ASID is shared to begin
> > > with).
> > >
> > > Am I missing something?
> > >
