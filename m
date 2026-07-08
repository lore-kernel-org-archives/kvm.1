Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7096399CE9
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552238; cv=pass; b=SK2JhZRNqF6tEnLV13qCbulhMytAf1p/vVHnOFs0OYxMVJ7Zo43YX7mgkgjEFY3tHLTbKlLFQIXP2EJViIsoOrNKtjwlg0nsGhrYTxT09LwxAdhUyVsVECSBYSY+QPg7WSq54CGWAqSprmN5McSry4Sy9Xd5KFkUcxd6GBoemXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552238; c=relaxed/simple;
	bh=fuSekuBjKILqAPLvqOFzDcr92zIdJEnUZcXyUswaVxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAtgqZANu0XHoBLUeAQpUYJCyoqd2bZmb5j1Ptcmet2gB10ROwdCiqiUKKxfu8rdoVD9//1UnoQXWlpqNA9IVrp76gJHoNZ9ezDPHrSeehS9it39pQ3jy2yzSASFY7pgtqn+kH0X8wSi3pBFnGvSypqVrZn71Yoq25zKpJeYXvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=beVxdG3x; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beVxdG3x"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb6bdeaeaso3627e87.0
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 16:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783552235; cv=none;
        d=google.com; s=arc-20260327;
        b=sqRyS3BVzJvAhnGfIh3XrPIQSLVkiUL1E21tQ36Dq29DyPNT7IZGIp6vOAq4cVGB5o
         ZECQJYl2cktPKWjqHXl/Jm5DpANZ6G+RZAvf8e4WAmGw/uGnZZPBUndbjweGIAzrXQ5c
         /AqYlcSoXfdiBeiLAs/2o27d+6OJ60b1XpqwJYuN3FCd5Zb4qZHSI2YVh3Ml39aPGROM
         ZOQ0BTNb7r06jx7Ra6lzWM4WnoJ1miMpQg6qi/1PmXOZPegnxMDY8t03WtLCc8vERHFK
         9p1uBvUyV6gqKfbxw42msdKV1NK/OqGfOYeji+Si5AVGuU0jpTwt7sxjRHp9ixBHQegs
         XlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W3OmbKP/PUEUuyDu0vTsEzSc6oVHraO2SRuCrscetMM=;
        fh=rv8K98lW7b1Sx43IkesK0eAFSX8FpQX/pPZGOLQVlY4=;
        b=mtYl3SVwfxV2TOY0fCj/SWxdxW1sNAur4bFyoWmLOXSMK/CksbzgZLOBNIPhWjdnFm
         xPl0/udv5w44TmCiYPJrDlCQefwFlumjuWDpOzqQVjG5mhRnuk2TWz9C0VEV8ohlZ3PR
         CCygjMwzfAYSxQA+SEuWfLmCERq1vqA7G4dlSI2Yth3glOVizsXoqCJpiYpe7NfP18S7
         a4EYdb5ig99964d3j3TD6ldjf/Ayt0rsbl3GLOpvFi3RX2+M2frRIHFGtCVhxm/pXIDD
         NuABL7CKux+e72i63Yfq8xA7pc2g0ntS4xCwqsjucc4SjMPnHz6/O8thVgpPJO9jBGYC
         tvEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783552235; x=1784157035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W3OmbKP/PUEUuyDu0vTsEzSc6oVHraO2SRuCrscetMM=;
        b=beVxdG3xawHPthCJiWmX+sw9aID0ep1xD6d2wJqRw54FIRweb09XLi32PK96loe5Ka
         Xl8RUSJxAyp8foCeWZJ71uXWRXHHiv/s1mLsG610WsPqPLtJMQj6nbULiMIW97v8rSV0
         e24K702x+JlXYDZeil2Vj4nEToILfZjvp54nf5u03NfVXkI1FEqJkw598amK3nKuHGWZ
         5+IATdiCoKy9VvWHbYLq/TTvogh/tusDEaPB3Vh5SdxfJUDx2BJAQitKPfZEE2VjS5Jf
         CYkGEfGezxOKyAri3pryYVmdTbkkGlp4LWBTLHNa1fO+xkFMNh+JVs6mWjBPedu1CPYX
         6ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552235; x=1784157035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3OmbKP/PUEUuyDu0vTsEzSc6oVHraO2SRuCrscetMM=;
        b=T6KO7VCLjR8DfprJwQy40DQoU4iK8sMSQMjst4vbgOdMcPgqOim1NqBp1IYIZmVJPF
         XAmAabVKw2I94FZMdE7/prF8rSkwT9lsFW4JyP/Euv9wuvfsqF7f4lwFWeBHC/lBXfLZ
         JambzYiWsrTEcApfllTKrjeIpoaGHCmhoVnEmE4T4qaXS+WooY+rcSJ9AG6aa5ZIvCc5
         GBLN7cwsuUe/M7c0NPlDaq8A1QQ9eLcwXv32xJ+etVrBB0z3h7h2hlwq25YROLXtBxUq
         LYYx7j7HWzDAFRuwf3rIZ96qw4xPx+l3aF51m5cDYAzQlMH0MpBmn0iONbEM1LZaTIGW
         cyuw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2rnUm5GYuJvPbGyY/jHoE2etQlV5G/1jHlJYw06VqoZAIE9SRGOJTAXT7qVQgl3JfKUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvoW749yP7Mpa6PLH05sKBPUepMqSbXUsaB/Kw0TuCtq7+RYk
	QkoZ/sDBhlwYMtPw9tFnxGT1G/vwcZdWjxKgsKCwrSG+9xJfuEyG1gNa7qTnhotnQgWwp69TQhb
	VsW8Z0JOBPUYxwhDSFo5YvyrcK1rIuUF/tNzRCZs=
X-Gm-Gg: AfdE7clnCClrUDUy+3ma77My2INd1UGLrMHXICvsd9l4mk2aBl3wl2Wnk330x9FRSu5
	G0KRGxUkArkDPL6zy4fz/DqBtQB3mHj5TMT7597oL38NSdZzQ+g/P9pvsCJLO61UyGuP42Nf9zT
	rEx3rltaSswYQXtOJT0Q0teIczzOLebhYjgnrc+uwiijWFDPnacaTdr3yvEUIq86vJvEuMOYCjR
	kAxyZdk31qDDHGuyjz3uxGuwR0DIMyDfXs7ZnhOpb+7LpJHk5bGfpxgQ1B7EiZIFzZ0
X-Received: by 2002:a05:6512:3d19:b0:5ae:aff3:3eab with SMTP id
 2adb3069b0e04-5b017608423mr8374e87.3.1783552234580; Wed, 08 Jul 2026 16:10:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526235417.2058313-2-jrhilke@google.com> <20260527003237.8405E1F000E9@smtp.kernel.org>
 <akwQUzGJBJhzdAss@google.com>
In-Reply-To: <akwQUzGJBJhzdAss@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Wed, 8 Jul 2026 16:10:23 -0700
X-Gm-Features: AVVi8Cf9fXyp5a3YiVF1dHvg0qfhetVGYcDZvQHgpDZJCeXn7xt0skskI5yc_RE
Message-ID: <CAAdrzjtQBwXZn=sx4gbUxfX5cCoirfv_tvGVPOopLQYqixTpBw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] selftests/vfio: igb: Add driver for IGB QEMU device
To: David Matlack <dmatlack@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 1:30=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2026-05-27 12:32 AM, sashiko-bot@kernel.org wrote:
> > > +
> > > +           /* Set to 0 to disable offloads and avoid needing a conte=
xt descriptor */
> > > +           tx->read.olinfo_status =3D 0;
> > > +
> > > +           igb->tx_tail =3D (igb->tx_tail + 1) % RING_SIZE;
> > > +           igb->rx_tail =3D (igb->rx_tail + 1) % RING_SIZE;
> > > +   }
> > > +
> > > +   igb_write32(igb, IGB_RDT0, igb->rx_tail);
> > > +   igb_write32(igb, IGB_TDT0, igb->tx_tail);
> >
> > [Severity: Medium]
> > Are write memory barriers needed here around the DMA descriptor and doo=
rbell
> > accesses? Without a write memory barrier between populating RAM descrip=
tors
> > and ringing the TX doorbell, the hardware might fetch stale descriptors=
.
>
> Can you look into this one? I would have assumed writel() would provide
> the proper barriers.

You're correct. For x86_64, writel() includes a memory barrier. Here's
the definition from tools/arch/x86/include/asm/io.h.

build_mmio_write(writel, "l", unsigned int, "r", :"memory")

That memory barrier should guarantee that all the descriptor writes
from the loop are visible prior to ringing the doorbell.

Thanks,
Josh Hilke
