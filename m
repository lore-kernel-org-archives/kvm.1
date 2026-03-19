Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685793EB816
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951713; cv=pass; b=sbWtXgY/7UKbPBmcRSeia8HfccuInyAipFDgGrMwqPtpg1EPtV++4BJriQQlyob5xCulXZnCLtMx6RwjH+nSJ+SkFKRd+SvWuhbKxU2zVIuNo2lf7Gmj/R5e1QOloPQDtkwWoh2yP2cl61IsQPDgrcsEQapE5x9WJdlGRdxZ+tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951713; c=relaxed/simple;
	bh=gJZ/ykI70v2d5+uiVZh0tHoPfumRLIsDtM1+w8MD0d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VM+J4FE3a+Q4zyFaTdvsPqMweBNPkw6bHuSudC5Z7z4gEyRd7Fs78cOKFuOJHDbYjugK9mX6MjqSeIv1wAg7BDFtnArCaXpVGLo1dUHyHB9zS0/LrdCsn2YilrtKXAVp/42pe9+1ddd3mqOgzE2ULSy9qoCgqJWlfCTAeXXBcvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DsPHk6VE; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsPHk6VE"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a10d130b37so458455e87.0
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 13:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773951708; cv=none;
        d=google.com; s=arc-20240605;
        b=h+ibTIFLT6W/uhWsNAG6js2Ww92Oj4oO7IJccRy8Qc0WoYVcMiX3rsXaAqaaz4EkQy
         +BOsHXzqbdJLS+DPtW467j63+kF0MUX0lawaqHxs9ljvT4Hfk0CcC2zSAnT710OU8pt9
         fv0bvDuogUJxUaERjj6MAZI9Io0Paz5FhCn2tj0wIMroZqLgTbcYlR2NXJzl2AIIYdDM
         jbPeCNxSztMffpb87GTMLHxksFn2Zj3YJpHrqQohtL9zWJQJjyDbdllRDgl4xTD0K56H
         WsP82wBXul1bbTkMrYoSRn8AtjK4Adh/Omd1Lmxy0e98zSTQRteZON1wNMl7bkTyRZVX
         zy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ljrMEbLtSu+dBU/7p9GqjBQQtzMNMj2KKmPXYNYtywg=;
        fh=lu17ImqnQ4SZ8J4fyTIxHY5twcywqiAFrjmhHCRqLAI=;
        b=Z0l/83XLJ95DWuumKwV8oV+QmftTgFEdNd9sp1xM2sQP9BQ7+Z19kbZsrntBDPGi4o
         IQDT/0ejGFgSK2jQXcemHi9CZqzpQzCvnrz/RO+Dzl6pUHryIj4RAy31w8acCmDu+fnX
         0U8a/59TgPXNGvyfKOz/8YxNlJpEtslyNK+3FiET5DPREYBHESdFIG0YdFL7k0dLEfFO
         BEuoF1zz77Xun3uKcE3RWCd8ixFPzbPKeSUnGaxFfL2FozkwQGEIjudzSckSZm+c5Umr
         /ujSnucUT9I2X7S1G59SrDYvI9CH36gdaKAEgiNGqfwPy6hdwcpHweZ/uVzLX3oWAGD7
         ythw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773951708; x=1774556508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljrMEbLtSu+dBU/7p9GqjBQQtzMNMj2KKmPXYNYtywg=;
        b=DsPHk6VE/Nh3Kvkbu6PXbyoJ3vQMpw6dk/PlwrpnJVdVnDrjljLzPBu/kIpvyh9UpN
         GMncxmpmWfr8eKg5W1yjUOka6ks9xHbl+XPaLeseYFIiBSGtDa5+OsbYUZRw/Vm4TCzc
         Rd9L33kWREcuon/WRU98P9/AO/EYEFH5t+VWCxwy6tXZp6obDeP50Gu52wuEUUVePnLk
         OkAT1Rhe47B0Is/5z1pLnHbg2wCMBjRw+2Xbpxz5zu05naTko/jv+QY+OkiHKgHFF901
         stB/8fI9sPcJanJoXFeBLjUjtJ94cwtrxT5DyPbU06Qj8vg33HM4Aa7id60gVYjpEBRV
         VBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951708; x=1774556508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ljrMEbLtSu+dBU/7p9GqjBQQtzMNMj2KKmPXYNYtywg=;
        b=oKEH9ANSXvykGnqp2hbxpBab8xW4NSaOeLyxTKQQoiFGMKMjaXEwFyQ+OgHJwzn08z
         hst6YAjniZCIaprDAs7qUg3Fh7w6w57UD03pFNPyy77Ai4HCDykaLtDEk1avhyPW24yu
         r6/c/bfz/Qq6MAsf6HQqsh5lMTJokbpXo5jyNCqguYy407hydFrOyqc0wQesKLFOFr9j
         JxPEOKyg4ABv48cI0IfbHL4lDoDcQ7XseBMWssn/4smBOCCP5+WNcl/gfmoypyDFapyB
         OBlAiUWPoV7unMchYmbH9shaQnxcStQiaohjrYw/n95QKpSoKWiNYNHL6wvpD5IYjDmw
         Q45g==
X-Forwarded-Encrypted: i=1; AJvYcCVHxzKW0tY0/WF9IGVu+dXe61rPNH6gu0U2hSe2reXLDXeowyN0+pv/mXX2d3xFC6Q0lFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKB4fbwNEPa8oxqcPLhxw1ptUoib3MdKj0oYk0zpUqMg1Gh4XR
	hyMJIuO9iKaPhDupBeQ8O0P6N9OUB1FtiTPbX27lXHZbB5qlyyemR4vA8lZBlQbD9wYtliGQpyq
	Bwo/w2+25FuQpEEyCyQwssbKtfFsgOJ10xA9xO1Ik
X-Gm-Gg: ATEYQzxylMq+hCpSAHPYR7zFtclGtrQe2Qp0UpDma1vOMs7hiot5ZFN/VrGyWPee0Ll
	zzR4BxUlmphxzxcaQcVSKTM5ftYlNHilMRGvNsEXMER/Y5l6PimzumGRtZvY2R2Ev10oOeSnev7
	BKaAqjMxY7ARJOvNYycXfE1aEqv/vdrnr/9OVhQAy2L6UZY8CsK6I6pCTcPx9INTm+5DNJKWI2T
	1Q2DJ4ZD9NmR5qeUgl0mP+7EF0JfapoaTFZYZoP9KBXektfpV+3TW0GL9BBWLb4yGovHctgrWNm
	KgHYnFncqwj/TP0Rt9E=
X-Received: by 2002:a05:6512:39ce:b0:5a1:56e4:1c80 with SMTP id
 2adb3069b0e04-5a27dde29e6mr1741712e87.4.1773951708019; Thu, 19 Mar 2026
 13:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317214239.124857-1-rubind@nvidia.com> <20260317214239.124857-3-rubind@nvidia.com>
 <abxIxa910ddkAiLm@google.com> <20260319132908.662a32bb@shazbot.org>
In-Reply-To: <20260319132908.662a32bb@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Thu, 19 Mar 2026 13:21:20 -0700
X-Gm-Features: AaiRm50XphyzZlWIKq0VnNILJa_taP6o7rQJ_djT2NWt4kKV2KYEChexfqC_QNw
Message-ID: <CALzav=fhKgqv76pPQum2qr_6TmiSx3jX54SaFx51nJx0h=7Chg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] selftests/vfio: Add NVIDIA Falcon driver for DMA testing
To: Alex Williamson <alex@shazbot.org>
Cc: Rubin Du <rubind@nvidia.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 12:29=E2=80=AFPM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> On Thu, 19 Mar 2026 19:04:37 +0000
> David Matlack <dmatlack@google.com> wrote:
>
> > On 2026-03-17 02:42 PM, Rubin Du wrote:
> > > Add a new VFIO PCI driver for NVIDIA GPUs that enables DMA testing
> > > via the Falcon (Fast Logic Controller) microcontrollers. This driver
> > > extracts and adapts the DMA test functionality from the NVIDIA
> > > gpu-admin-tools project and integrates it into the existing VFIO
> > > selftest framework.
> > >
> > > The Falcon is a general-purpose microcontroller present on NVIDIA GPU=
s
> > > that can perform DMA operations between system memory and device memo=
ry.
> > > By leveraging Falcon DMA, this driver allows NVIDIA GPUs to be tested
> > > alongside Intel IOAT and DSA devices using the same selftest infrastr=
ucture.
> > >
> > > Supported GPUs:
> > > - Kepler: K520, GTX660, K4000, K80, GT635
> > > - Maxwell Gen1: GTX750, GTX745
> > > - Maxwell Gen2: M60
> > > - Pascal: P100, P4, P40
> > > - Volta: V100
> > > - Turing: T4
> > > - Ampere: A16, A100, A10
> > > - Ada: L4, L40S
> > > - Hopper: H100
> > >
> > > The PMU falcon on Kepler and Maxwell Gen1 GPUs uses legacy FBIF regis=
ter
> > > offsets and requires enabling via PMC_ENABLE with the HUB bit set.
> > >
> > > Limitations and tradeoffs:
> > >
> > > 1. Architecture support:
> > >    Blackwell and newer architectures may require additional work
> > >    due to firmware.
> > >
> > > 2. Synchronous DMA operations:
> > >    Each transfer blocks until completion because the reference
> > >    implementation does not expose command queuing - only one
> > >    DMA operation can be in flight at a time.
> >
> > Asynchronous DMA will be important for testing Live Update:
> >
> >   https://lore.kernel.org/kvm/20260129212510.967611-23-dmatlack@google.=
com/
> >
> > That is why I split memcpy_start() and memcpy_wait() from the beginning=
.
> >
> > Would it be possible to add support for it here even though it is not i=
n
> > the reference implementation?
>
> I'll leave the can-we questions to Rubin, but do you see either the MSI
> or asynchronous issues as blockers?

No, I don't consider either to be hard blockers.

> Currently our driver tests are
> limited to a very narrow range of Intel server platforms, whereas this
> is a plug'able endpoint we can install anywhere.  I'd think that's
> sufficiently valuable in expanding the test base to make some
> compromises.  Thanks,

Yeah we can compromise if both issues cannot be resolved.

I hope to limit differences between the selftests drivers as much as
possible, so that tests don't have to care. But I also recognize some
divergence will be inevitable if we want to support a broad set of
devices while also supporting more advanced features like asyncronous
memcpy.
