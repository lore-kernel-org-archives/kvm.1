Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D33D6CCE
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474521; cv=pass; b=oXVlFw9ECZKzmiFhiHf4XzMwqsyPUl/MW8L+jtJPL15Fl4SFO+7dh83d61W96guysFBLnszb/Iiw6Tu0pzq5KO99Qc289A9sOkn8T6vP+0R3NvMIupOJkQChqQk0plaphExTaE4+ULcPs9W8WFTvqcZUqgBn0+odjmHHMBwrx8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474521; c=relaxed/simple;
	bh=PK5DpGIYIZ4Q5mypA8J7nQL3JpavjxnvYneVp4Wv71c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nawyaCgHYJBQry4V/MANYZ3PGbyBIYWRVG1woJfSYMgM9vZZMoXp9uHI3dID/+NBQS4OiQgLSoLlw2ebJukXoV4407hH8KHzMC5/HgLJ7P9x+rXW+zSQGeWxenF/eC9UBdg9s5CdCtubJk/YDVbRdOtqDP+UThDyUvNVQIGlHYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvA8cOKC; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvA8cOKC"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so224666a91.3
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786474519; cv=none;
        d=google.com; s=arc-20260327;
        b=AQ/ppznggtB8UwRmjAB1PiPOTCSDppYs+KNTZb3q7G4FvUU0RQU/nihWe1zDEr8DVO
         9VTV3Rm2bI7NqQSjiqlrSe9FAToU2OC6BQQ+4rgceKoCH4BVN+amzK/bhDEuTJTB7fXS
         ExU4y8qAcb1pqceHC6CgFU6RgLoNhgiNDwOnqhue95PvocMxs+B/1gNL4P3roAqfdESP
         1H+rJe52j8PqgudLQnDgrlDewPYvsJuMknBO4PAkjcX69DL8R12WTWgBnB4ShwT8X/fs
         rG1A/W4xjwaJqgAQpyraCQzRyETQck9umrSOeD3jFsfBdz4u2lFOgGqmV51ZR+gfCvAd
         RfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PK5DpGIYIZ4Q5mypA8J7nQL3JpavjxnvYneVp4Wv71c=;
        fh=XA3qe4weTgpkfpfQnxFl2RTtCQY5h+A/AwIFHnZOcPg=;
        b=J9AMIEvPQ0U14BfY/XPTT/Oi+y5uVGwIW40V+R/DM0ewjIjz0sjqQeoFiGEdc0CqOv
         e0sF6/orx4JouteyERhNBf58oyBKZnvKgC5pP9FAuH/LvkMZIgMBkRvwq6eTFC5rh9qY
         5yVNm8WQukGNcIY1jvd+FNERcXpowhMonffbjBdUUx+qq06ryirhOIuQpBypNLyn2Oc/
         a2WJTMRIv4Pe9XCZouN5CJg0IS7MxiuKZSAFM879wxYyaUq04wVTTeLk+lSlhOUPb0D/
         WHewJD3Nq8QHfdq3u3PYxy7hjPOWVsHp5aTvP0s00Nb4dplGPkJWN+z275e3sdaKeo8w
         zFxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786474519; x=1787079319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PK5DpGIYIZ4Q5mypA8J7nQL3JpavjxnvYneVp4Wv71c=;
        b=MvA8cOKCCXQQlEI5MpSTG7Uni96YcPS5b/rfl+m9QzwZ1k6yGDSnhcD5xe8meOnssX
         Xs0Pr8pUP4mCgH1sBCVHw7bmve95hnxFLe3DncNcFRrJA2JIGbtAVbfry5z0a1Ab+mNI
         IgK8R9sRjwIR1fvw8R9WTX/fWpLuPoVEQZpFQNK+i24csuxgw/43lNUo7K3VmfphX6c5
         x3tVIMLV1Gxw1UdGkArwhiAMJERGpENe+zSp+zEUY2KLf7F1VBCg9VutYYWuBru7qC3+
         qrJ9hWdcklkm0d6YOqad+x6T1VLz5HHA139/xswx5aDGzlj+eybfBSs4kV9otrqwGUeJ
         cwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786474519; x=1787079319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PK5DpGIYIZ4Q5mypA8J7nQL3JpavjxnvYneVp4Wv71c=;
        b=WKpU8VzhiK2Qr0Wb1bfM9X8+gJXJ3Oj/gr0ha9K/mm9JqBRzQg5QzrVk3gxo1PxryB
         IlyzK8YhLuKSnSez26+ODSdxG73v8l0PIjZr9sjz688coI3RbFTwZJswQmxGphkhfEId
         RgPRPSxKlB5C6P1o8RaOq/IWqPIjo/ON40W9qRbmKNAHOl3nApGvdDPwPHeKDFEURTZt
         ITV2Cbq/G12z7zUXrvlNPGKMX9qZ1UMgkGiLhAVrr9rpBPDq27Cmn/VJKY2Ke3Vvk6qT
         07gDhaijy2dhscpkeZ0k4OZ1RYuimkCpNTTaE85QCjmxrpXKrR9/hr160xt6dbG6wjGf
         slnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8n+htd9usWe88eBbnuL9lEUk8gi2jVXSlFove3XrY8Uwc2VeEmCxLSH6VGwIy3dxrq48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZXtYC2GyHMq3zOyWmcVgjtadpSRaE678lkuqeGrD33cZ/5J0
	vDkA+QklKsRaNd/ONQq2lUy+ezt/9U6rDFewdZgeAZXFw68yPsUzUzyQXESRQ4y6AraTrq/mMcN
	uU+AlVzzi2iN1yR7MfWNVlTFhOnmV7cCoiMC8gt/l
X-Gm-Gg: AR+sD13YZeiavEX0gZlzKBdazjHZQZo0OnVwgrnczYTQhMYOTA/qXN3ovtXmbWtJn7+
	EYpQhoIbwDUS0OPr5/At0SDJrWqlH2/JdSx+4+HQ5mWEIu3JVAlp845SVmj7Upg24tzBN7dZ2Mn
	4AGvnjt3qLDUHltOWbfgw8lSFJ5Ru4/tSsO/GQCq7A/JWLxDederRynDLFbAEHnivchntiCnVT7
	mphcoxCRbXmzxdKdSnwbUKfru83aApybrNLLPuAhK6ar5RbqdrOpmb5wrEwfQo7VvIMUGgXE9qD
	WJeoyNeuD/QiDA/NA1cjVpa8CrJRSHvuBWezyBdXSeFP
X-Received: by 2002:a17:90a:ec90:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-392ec53e6c1mr6200831a91.12.1786474518666; Tue, 11 Aug 2026
 11:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com> <20260805183702.GA72896@nvidia.com>
In-Reply-To: <20260805183702.GA72896@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 11 Aug 2026 11:54:50 -0700
X-Gm-Features: AUfX_mzn4PfVgkS4FrNbhoBz42phR-uhV7z36r-0P3XLSgGGUO-8rzrUFVLpZk0
Message-ID: <CALzav=f5oUW+B9RvOyaRGtG=6CX_4g-2Di+obFZ4O6B-chZtAQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] mlx5 support for VFIO self test
To: jgg@ziepe.ca
Cc: Alex Williamson <alex@shazbot.org>, Justin Stitt <justinstitt@google.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev, 
	Mark Bloch <mbloch@nvidia.com>, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:39=E2=80=AFAM <jgg@ziepe.ca> wrote:
>
> On Thu, Jul 16, 2026 at 02:03:16PM -0300, Jason Gunthorpe wrote:
> > Add an mlx5 driver to VFIO self test. This is largely a remix of the
> > existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> > to issue RDMA WRITE operations which effectively perform memory
> > copies using DMA. Since mlx5 has a stable programming ABI this
> > should work on devices from CX5 to current HW. The device FW must
> > support the QP loopback configuration.
>
> David I was going to respin this to fix the minor nits, do you have
> any more feedback or are we good to merge it ?

Sorry for the delay. This has been on my to-do list, but it keeps
getting preempted.

I will do a pass through it today and make sure there's nothing else
needed in the respin.
