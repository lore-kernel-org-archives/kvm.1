Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4242A7AA
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064515; cv=pass; b=YDAHooZpIU38KfpTI5Jlw2BjkKN0SLiG1s3r1g6FXXsMgvmpgKJWbgJGqu40QlRKHOB5+7TF7r4viVAyJ5F5cl1GQhy92qSqxVP6unFp/ajE8JxaDDPvs0ddOMXSTyDlJEz4WAapIRZ9lkZ6TgQdLFOTskBc2IstoCyGATK1KmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064515; c=relaxed/simple;
	bh=eZkUTOGD+AYOSxk3L5lcF0sPdVB8UXTaRCEjJsgG/nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRqfVHmK4koeQXVtj2dv2n1/FZ3H+LFtDo9L7ODwP3/Rs2pTJibnl/4NL3ypfWEughzOgTin0S8L76eGhGSiUU3k5WhALLbOR4lvwk+5h8K+sK4Rx5a73t9nGjRvwwYZVtDZ96/O1lV+6NJsID57+oPDaejyRdrDLKuNjvnf3vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vt8JDdtz; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vt8JDdtz"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so220a12.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 14:28:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784064512; cv=none;
        d=google.com; s=arc-20260327;
        b=ASQk3UcYLCpNovSeRWMbWGNg01KIbmaSAoLXbqChBPpc9wtnF/A6KijkyuXx/MAByK
         ZHGuvYTNDwzzHs3qPbukezWQqnMfvydA4H82iORWgrrN2bgdTyYuNLyjfrJ0bbZSny8H
         cyZsrmky1zTaFxqiOppVkA1m6jHM36HOJ/976QL24Mz4x3036LR6oTV1XgwN4OkhrTTz
         leelMaGOOcN1Q0BQqebRuoucTvMnNbKEDvsd9uGaZ4pP6zbMU0r5oEOfoHIUtPrv7Dim
         6D3qxl7uulHw/+JMegH/YsCZvRxpWVVA3YOesoTpRz1tTitvnKoxkYxrCNFW+jz8P2iX
         NOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eZkUTOGD+AYOSxk3L5lcF0sPdVB8UXTaRCEjJsgG/nA=;
        fh=2YB86ZUzqdi6Ngc7nz1GDV7v/vdGQeegDiLxi9RWbFE=;
        b=NDPmtvq18wOnYp0hQqnevdIlLV6HD2yS+PvhXAwBpzKiX0xkeLOAN0l6pg+3C01muT
         c0kPHtGsVNEYPLHxSJJGAjKZ6mZ/Dzy8aQN3OQRmurWphwdbg/PYc3brjvPBzLpy0YsE
         WNyjyBJB9jJg85dtYYjWtbHbRz0H1j/O9oFDD4Dhb8L1wHc8+R6daWH8a8oSqGlf3yZc
         THZ4VpbhQ1QG/Jlqt9Cvj33A4pPpyxcmpuIjm/ANJyVOAXwALfN4Qp4tGbxqgMLZQg+g
         HRm7dqiyUGDjYWu8ZuMubFXlspDd+ryAfQGQ3QOLvuKpuutmI4tU6opXO8FAKfTkHCdh
         D/FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784064512; x=1784669312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eZkUTOGD+AYOSxk3L5lcF0sPdVB8UXTaRCEjJsgG/nA=;
        b=vt8JDdtz296YRZ6oZj+y0alnaBR++qyAOX3YIsWmNnXe4Yf+PA20c/qtjYBhIm9Wp/
         Mm/YKiZFEvWj+LGT79Y3k4Em9NSp2KmPNRxZgNvzjfqZaG0l/jalnmkRMHgEsKCaysK5
         mbBPTgJDJmaRW50WdXNZdvelijuZghu9BLeBj4CZu0a8MmCv2ymJ8u9d8le2hDqSUSD2
         jnFbGLp3p3c3u8xoKME0lZwE3333Jt1LrT37I3r89DOQECET5gaCtxCIDESArVylgf71
         2q5RXk84JUI8JZeEHz70kpv97u3fyq7a2FIIzUdi9/+kMmkf5iI6w306GTiCcRz46855
         O21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784064512; x=1784669312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZkUTOGD+AYOSxk3L5lcF0sPdVB8UXTaRCEjJsgG/nA=;
        b=cJYo95OUgrZ/POtl40+DTl4jvdRo3vZy290SiDL7+6lXiF1mjZ0o5jCBhFRvMYBc8I
         Vhc6c0n5MC/La9mJ8HFYiDnyNTwJAx3UddsLYEJQ6dXzvsezYGNysDQ5N57pH8gFT/o1
         AlqOoqSnyaWvpC5jvSzVfIzBnET2sL11Aw49/NTQbS6i/SKGa5OMAn4fANSBniILEG36
         Y2yo2ieNj0bUx/dzugVmJNQhXR+G2rMmKTRLTIb8HD4MunEtW1+WZRwfWjHnMcbANUYs
         wWnodei4YHUGf1nphgie7FKCERluvrxdzjYrhFQjHhb+Z1YRaZ2Kc/ko0ISOEj5eBMQT
         TzRA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8mI8aEJQEFcITbA2OUV6DdxFIdw3yt0ua7CJPTu+uKrCBrnF+WIXsVKL4pT4Dqo1rqGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HJqZVbruZHZYWEUtghLJpklDzGY8LYO5PxgIrvS1N02b4B09
	YPSxpE94iQ8vuRTnvW5nIOrVjv2OaJtu/nVjQVvg5Ra7ps1oJzJjFTmBzBJBCdqUpD6EEVdgmzi
	R8S/jszx/1fEPcYOP/D5mM8UdVZHNK/Q/TgHWFo3U
X-Gm-Gg: AfdE7ckeaZ4EzhYoUP0KGhxMG+n8fSwJfntx+MGJ9GUKW3VWfy0HWihsNDl73aA7xuB
	hlAs2bafDGiwZG33O00FkDz6FnXvFnokuUpwI1m+66//++ilqEVca0/yhtucBX12XY9Y7AXlrGk
	QoLLAQZNPu5mOBr8822uSDQOPLaUyYT/P0GRQtAK50d2Jn9v+gQcuZXsmxQ0PUH8TZ/tlAnfwpV
	xlL3hmsN3TINKGWqAxZMEqCwHIoC682jKcE01BbmeMZ1cEsVS0Mn28g0wfLdp+M0uhe5Jlo
X-Received: by 2002:aa7:da44:0:b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-69cceedafffmr164687a12.0.1784064511275; Tue, 14 Jul 2026
 14:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
In-Reply-To: <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 14 Jul 2026 14:28:18 -0700
X-Gm-Features: AUfX_mwTaXeoYY5jAhGOgt3Qh-Jyu6H25OVNcCM8BC3Slr4qzEzhGKGQUYHpCyQ
Message-ID: <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 6:20=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Mon, Jun 15, 2026 at 5:42=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > KVM currently hardcodes the number of supported ASIDs in CPUID to 8. A
> > KVM guest (L1) would then do a full TLB flush (i.e.
> > TLB_CONTROL_FLUSH_ALL_ASID) every time it runs out of ASIDs on a vCPU
> > and updates the generation (see new_asid()).
> >
> > This is currently harmless, as KVM (L0) uses the same ASID for both L1
> > and L2, and flushes that ASID on nested transitions. However, following
> > changes will add proper ASID emulation and a separate ASID for L2,
> > minimizing the TLB flushes on nested transitions. At that point, a full
> > TLB flush from a KVM guest (L1) would flush both L1 and L2 ASIDs, so
> > should be avoided as much as possible.
> >
> > Passthrough the number of ASIDs in hardware instead of hardcoding 8, to
> > reduce the chances of an L1 guest flushing its own TLB entries
> > unnecessarily on a nested VMRUN.
> >
> > In practice, there is no harm in exposing a large number of ASIDs to th=
e
> > guest, even larger than what hardware supports, as KVM never actually
> > uses the value of ASID from vmcb12. Even with a separate L2 ASID, KVM
> > would allocate a (supported) ASID for L2, and just flush that same ASID
> > every time L1 changes the ASID in vmcb12.
> >
> > That being said, avoid the temptation of just advertising the maximum
> > possible number of ASIDs (i.e. 0xFFFFFFFF), in case any peculiar guest
> > OS does not handle that properly.
> >
> > Note: QEMU currently hardcodes the number of ASIDs to 16, so this chang=
e
> > doesn't help QEMU VMs (without making a similar change in QEMU).
>
> I had a discussion with Jim internally about what our VMM should
> advertise as the number of ASIDs, and based on that I think passing
> through the hardware value may not be the best idea, at least not
> without some disclaimers.
>
> Jim pointed out that AMD CPUs will ignore unsupported ASID bits, or at
> least earlier ones did, even though it's not mentioned in the APM
> (last time I checked). This means that technically KVM can ignore the
> higher bits of the ASID set by L1 beyond supported ones (e.g. if it
> uses a hashtable to multiplex L1 ASIDs onto several physical ASIDs).
> KVM doesn't currently do so with or without this series, but it could.
>
> The problem happens if a migration pool contains multiple AMD CPUs
> with a different number of ASIDs in hardware. If the VMM advertises
> the greater value of the two, it would technically be advertising an
> unsupported number of ASIDs on one of the CPUs. If KVM ignores the
> upper bits based on what it supports, not what userspace advertises in
> CPUID, then userspace would be shooting itself in the foot.
>
> I think technically speaking userspace would be in the wrong for using
> a number of ASIDs above what KVM_GET_SUPPORTED_CPUID provides, and it
> should use a number of ASIDs that is supported by all CPUs in a
> migration pool. However, this makes the VMM's life difficult, say if
> AMD decides to reduce the number of ASIDs in a newer CPU just for
> kicks.
>
> All of this is hypothetical in nature, but it's a very valid concern imo.
>
> I think there are several ways we can handle this so that VMMs can
> reasonably start advertising more ASIDs to guests without these
> complications:
>
> 1. We can just advertise a larger ASID value instead of 8 (say 16K or
> 32K), rather than passthrough what's in hardware. I assume this would
> mean that KVM is more-or-less committing to supporting that number of
> ASIDs regardless of underlying hardware (i.e. KVM wouldn't reduce it
> in the future). In this case, a VMM can just advertise the same value.
>
> 2. We can advertise the maximum number of ASIDs (2^32 - 1?), which is
> the same as option (1), except that we're biting the bullet and
> preventing the possibility of KVM ignoring upper bits completely.
> Might be too aggressive.
>
> 3. Document (somewhere) that KVM should use the userspace advertised
> value as the source of truth for ignorable bits, even if KVM
> technically supports a lower value. As I am writing this I am
> realizing it doesn't make much sense as it means that the value
> supported by KVM is meaningless. Maybe that comes naturally with the
> "don't break userspace" rule, but it could also fall under the
> category of userspace shooting itself in the foot and KVM letting it.
>
> 4. Do nothing, let this be userspace's problem, and hope that AMD
> doesn't reduce the number of ASIDs in a future CPU.
>
> I think option (1) is probably the most reasonable, we advertise 32K
> ASIDs, which is what recent AMD CPUs advertise anyway, but it's
> more-or-less KVM committing to 32K ASIDs even if a newer AMD CPU
> doesn't support them.

I think Bulldozer (family 15H) first introduced support for 32K ASIDs.
KVM still supports CPUs older than that, doesn't it?

The tricky part about advertising more ASIDs than the host supports on
pre-Bulldozer CPUs is that those CPUs don't have FlushByASID. So, do
you flush all ASIDs when one is reused?
