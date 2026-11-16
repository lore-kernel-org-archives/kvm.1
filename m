Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794873007;
	b=y9qlMADP+2rmhtKeeI+4sEMPU8v7wBcUA/mNJ8vzM6DgwW9mZhYPb+6aQObqRAqueFU9
	 qqYc+yODQifJ4Tw903Kv4X23lLd9nZbCaNMsVfKmz+m0rDAxYCcPf7HynFs9me6VO06DQ
	 cVAMyBKzuf8EhZAi0KhcN7yawUGFrTKwnh0HZJkAKsv0MnCR1Dxrw1kIZpB7LW27tKGEV
	 rsdzvdYMJzgF3moLTdGaCqI28Yw5PPfSjUz1SQ/0JvexNZMJy7b65eem5bJJJcK2palgz
	 4Ooocbv9Nph0VUGFBhrJ33NmVvmb4U/htFjsQAIr5EDapH4tK2M4XV1FGRLDY1U2hwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7FRS3DAvrAxtXcplP2lI1BU1rJaQlAKpU++3t87iHlU=;
	b=pj2RClIRC3s3mwBeG5cdiC39C1HWDKHuHkPbCB54ZIyXG2cHpEXKNS8H4lZfDR3OIK+N
	 fmm+vH/T8Fq29u+uZJjb0xZJIAkirqScg86QHl16A5ON0HaFBYAL+ivl5i1Jc8neyqi0t
	 +bF3qSqy00Vo8RypX0XspnEh0hE6ZEtOux7caUOaX51khgHBf9S1kPMxhxx8U9oENTMqF
	 eAwUxecbYXKZuoSZvYrCDq0Ilc2XY8uh/tHM1XGY5+r/YMZ452l4IU5Obk8ETNoiVvGJs
	 +J3emMb59hH/lSvj0XjDd8e1BzFrl+ovYTwAVDn790StxnuBITegXeESHHxAin2UAvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqvemtLw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE61606A33D
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 23:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAE61606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqvemtLw
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso73170066b.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 15:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794873005; cv=none;
        d=google.com; s=arc-20260327;
        b=fE9EJXK0N6uYuOE0Kh+bPtc0QivQz/k8GlxqEgumDVlE+DEe/JoBYTglpAsvlzKlR3
         BZ0Mn6r/+nIJPqVK5NMBj1DiuoGt4ka2rvaCzuf/JXgIJUYpYMfnKsPy8rTCjNrk7tZe
         rJtb7NyKeGr3deyDQBGXSZJ/Mo7hwxq3vA5YzkJkPu2dtlCtnT+X+LW4LY2il1F5njz5
         p/q0R6BLGA9ytusuXzKjdC42piRoOr9XcMVRz5LzK3ChViHPvOMSJIQS/I8xSB2bmWEh
         nhY6DYhg/P9gAKeSBzd8EYU8xRYM48WqwAMXWQAZDYr3KB41v29JnysuYoh7sWcNhCuZ
         oDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7FRS3DAvrAxtXcplP2lI1BU1rJaQlAKpU++3t87iHlU=;
        fh=HvEUGrgbcoA2bQtFpdsqTukduOdmf+5eSA76u+gbEJQ=;
        b=f2g6vGVLxx2OMFzXnnEDwruFt24swO0g4L4AydAUyPJ4H+nGH2YY9aI5WAxpWX6l+h
         G/n/F4zTkFnzfjb1UZut6y548/GUKO3mIFnyOPtUSUmmlmgPp1XDJYrbKAwLfk4nqV50
         HG0q4PQCyfqjSBHi+fzHkcnHqBCObPS08E0/EhNxftP3NjPRtQ2HPvpZ2sX5tj72x5Zp
         IeHkD1t7KMMhSERmchNT9tzQWqhsjrcfngxF4eVo8yW0EPYHXYfYuhX7ECYjHNyKyJkA
         9BrJSPoByJrr8ditkL3XOVQrPyaSTtgAPJ0CpKP29Lm8VtaRKfih5QBcEyQMC/O8iA8h
         BlJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794873005; x=1795477805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7FRS3DAvrAxtXcplP2lI1BU1rJaQlAKpU++3t87iHlU=;
        b=pqvemtLw2O71X7r23B62BRqkqr+ryl8tzqCUbYwgOY8P9YRUtcY5noeVc0Q4rLsNBQ
         zijkKIPLCDKO8bwiCim25UesGTSY9PgIFy7BY5BexbxUgvRf4JviUfuZfwg9GXzqBt2K
         12vOGr/NdO1pwsLaG3ylr9O5p99suJ0iugumHnc1JuF8pJLItmDdUyWamNXb2XRMEg/z
         4dCCrKpaSZ2JqSVMkI3zctHREdE479RxMTlpS7La3NKrdpxrC18LucQoJEAcVlEHQgTx
         qHYkh9qIJQYZ+wruOEwWz6f+6CEzqCq6PifkKVZ2SbtA0cgN0/sgUvGuZ9HBEZgOK3Yj
         GyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794873005; x=1795477805;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7FRS3DAvrAxtXcplP2lI1BU1rJaQlAKpU++3t87iHlU=;
        b=VPEKSH4L/WFymVZMFWO6xxV3rNJe5tm2SvRw5fY+tZp/ln4J2cIWQFK8B6g9l4zWFb
         n41G/eAA2zkGvGgmf5fzDlstmtr5qjmDA9vKInrWWD4Zdiafnwm8O/w5s5Cza0PXRNU7
         YsYxDGDeVIygruHdmV4xDbPkUsyQOtnB4GVTfCSkQCSVYbyCpwFiGDM8BVA05hRbnCzv
         Qfi6MOewGVSjOrBSi6BjGdgwO1I0WTllWH8mxUojBwYOZTsYXQ9F2piL8crm+nycwEIg
         9VoEy0Lfhj/ZopTjg8/LoJTjmHfgFCf+QvQ96qleh3TBn4zW50Z5HtyF4GW6N9TlTD1I
         N4zw==
X-Forwarded-Encrypted: i=1; AL+hErHG5WwGvDFJnmWnrpAVwhuJ4GC4mGEm0kRhqverH8WSIRqubCu2u57tWKL8oJqiX2CXcXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AbvMsBEOz14sO80TWMCBa54kfRN8nQ99jQ0HWDivB98C2cJyU
	RoWcz7eo7GSSM6yenE5m26/7PVG8/8skBdO6mNLKOkXDheuW4J2rojsZrbld7RKlc/vgb9W4YmO
	GS/ulITrhzG4RvxDikQW/KZlHK1keQdSxpe8mjSw=
X-Gm-Gg: AYBFou2/2J/0ROgtizx9vE1/aK+HoCP5iE5ekqT1OOD43dqdXbEWfWHwIHgGrFQSOLJ
	Obl4zHxIn02Q3NbVaPE8rNeZwXhnvfPhz3KAvixzOs5/vzFocMx6KgXdvIkIOURLqY3/GfUk1Vr
	IUi2JHldTbD2DX3ROhLgdtSMrwkkG/y0RleE4kd2tcWI6HQa5synRt+f8i8k/BY+CjEmHsz7kyE
	W9ySl4a4JJeRN4Byhe3LAUyr26ilrHuhBDv6Y8Ng1EttLly+Xihll3AKK0XiaXPpiXwXAV2bGxK
	Y6RpYUdc+R4vPEQfFrnPEb44luu4UOU5p9Axng4UJSONT91coShzTX/y+/ex8v5CIrPdOSrrUxy
	HfiCrPjkhE2RkerQTgEk87Rz1y2Kd2VGTLnzOGQDiLB1j3gafECEfGUljs8Q38/ETku0b8LfX
X-Received: by 2002:a17:907:d88:b0:c36:777f:824c with SMTP id
 a640c23a62f3a-c50f320cef8mr84585466b.4.1794873005174; Mon, 16 Nov 2026
 15:50:05 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
 <20261114235828.GF3706007@nvidia.com> <CAPZV9qUvgKjoBXGjYXJzwnCmqzSfu781ZSG8zW6Fn4PokUN2uQ@mail.gmail.com>
 <CAPZV9qUMZcwVF=CUK4LY4G6Qoqd5ykCXE5ocX8VCy_f1c6+aBw@mail.gmail.com> <20261116074022.29d96bd7@shazbot.org>
In-Reply-To: <20261116074022.29d96bd7@shazbot.org>
From: Gustavo Andrade <gustavogyn@gmail.com>
Date: Mon, 16 Nov 2026 20:49:48 -0300
X-Gm-Features: AclHuK--I7eLB9wssYrjidNqtZcmf5db4-ZbJTD49xw-7f4cTL26Jgoahe2N3Nc
Message-ID: <CAPZV9qWp8rWLkdzdQ0hJ3nsN0CQXj=7epsV9UnG-x_7PvYgMXw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] vfio/pci: Wait for GB202 firmware after reset
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

I completely agree with you. I wasn't aware that QEMU was the proper
place for this, but I've made the change there and it is working
without any issues.

Thank you very much, Alex and Jason, for pointing me in the right direction=
.

Cheers,
Gustavo Andrade

On Mon, Nov 16, 2026 at 12:40=E2=80=AFPM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> On Sat, 14 Nov 2026 22:47:34 -0300
> Gustavo Andrade <gustavogyn@gmail.com> wrote:
>
> > Hi Jason,
> >
> > Thanks for the feedback. I submitted this as an RFC because, while the
> > workaround solved the issue for me, it seemed unusual that only my
> > card required it, since I haven't seen recent reports of this issue.
> >
> > How would you suggest I proceed? I am currently running the latest
> > VBIOS available for my card (Palit RTX 5090 GameRock, version
> > 98.02.2E.80.10), which is also the most recent version listed in the
> > TechPowerUp database.
>
> I imagine a better shape for a quirk is a resetfn in QEMU.
>
> The fact that nova knows about this issue and has code to handle it
> suggests to me that it's only the guest initial boot and reboot, where
> the VBIOS is run before the FSP is initialized, that's causing the
> problem. We don't want to pollute every vfio-pci reset with this
> wait-for-device action (if we did, a reset_done callback would be a
> better solution) and I also don't think we want to implement a
> kernel PCI-core device specific reset.  Either of those would make the
> device behave differently in a VM, or modify the current bare metal
> behavior that's clearly expected by drivers like nova.
>
> A resetfn in QEMU can be device specific, wait for FSP to initialize,
> and not affect runtime resets where it would be the driver's
> responsibility to wait for FSP, as nova already does.  For example
> something similar to vfio_radeon_reset(), but calling the
> VFIO_DEVICE_RESET ioctl and then stalling for the FSP initialization
> to complete.  Thanks,
>
> Alex
