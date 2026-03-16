Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1574139D
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692280; cv=pass; b=mxWyXJYsKQ28TUUasnuh4c/lu0sF048eCErGeCtAc0mZYnV8R7vdgLxSxq2l1G7L8CP7Pwvq/pDRUQsq73GoJyq6hh+DjvKRRu6/zv8hvRjs/nDSTvYigVgoUW57yQueOIl54xHw2uuRd8pepV2HsiK6rQXrJOvwsOMFHU91lVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692280; c=relaxed/simple;
	bh=zflpxtRBylCX5rFH1aSVW9cpbT8IuiGQT38tsF8ylXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J08Pk5C2EzMfSeJx03b/dY9t6r4xMqI1F/CwDDkmp9xM182kw/aW6sU/LLSHjwZhipSswcpCtbnHp2BFI6RqLM6NNDrsYCJutg+JqFL4D9NnEwuKym3Yx/geUopUer6GHySZlfXBZW7qESyHYZMnKM16xe4Ju6Dg6JE9Nb8H4iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8ri1ixT; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8ri1ixT"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56afbcd8adbso2243752e0c.2
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 13:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773692277; cv=none;
        d=google.com; s=arc-20240605;
        b=DnixMMCLvEtcd1MIA8zVb0HCOHgJsGb90RdIwO0OJHnD+dKDDCdOIV65HXyP6VRpsS
         cKqsBc8sTD08TmO0yRioOGDhZJJOVfeL2RMJQDwQWOs9akRfINi2CvIS2eYHeBEvhuQC
         bYhmi7BEfigDuKqxax0iLPy0cBamrqbJoTSO58xNVg9/KPM063c/ju232MKNq5gRleYO
         juwOFnRKAE124Y5amniO71vFSnssxa1EEODUwlZEWvnRuy8blwBZQnnEqW0WBahCXhEn
         2dlrYc1YUu99e10BTbRPHnLP1iKLwQ5WumBveKzcqOTSPxGaQlDeukAlpLRTv64rucvj
         Otwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z9Q6fH9c6L1HLnK289rjhbhnEGeVoiRSnOJS5fAspJg=;
        fh=mBP4xk6pHU32W/9qP+zLQc/9x/QaYNdU1kP0bHaZJRI=;
        b=jxUwoJCXap7qE2Q0mMLUsVLL6KcbXVzwI3aiuHSbx/NzwfUIzE4W/SJ1V/fXgApPnc
         /Mdz8BV8dH64mGIxoHMgtxDtIIsjEEsm5ISiny/zYdJQf4fB96yt8JWoI2WTlaQm1m16
         2CWJVQWM4IQVZXVzIM59Zal/W7BgyTrHQ4FK9JQxXmVtZPSrMoqs60NXNuTTPblMr71s
         a72Z3RYQ3XYPbwWdDFEd2+lzhm6DRmVvxsZTOZXMzA2Y2ADJitCYfmKufbxEiMExybXu
         s3ALay419IPL7cL/OniSIgxmDMIMUzfQbDAV3JinulGjai8tC/9wn6ROijBRRdkhZdtA
         lYwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773692277; x=1774297077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9Q6fH9c6L1HLnK289rjhbhnEGeVoiRSnOJS5fAspJg=;
        b=u8ri1ixTDzIQxdC3TGqvVvkrleLPHqqfAiTWEMbkICgOCrTocy+FVEorLtqAypQIic
         5boB45tp0hc6jK/YeBee8DIFKK4YxE1N0ZXalfQgebLxDTMyg8Eczngrtz2N5RXIzF4R
         4T3UxnW6isTBqY/HVwtx7jYJax8o5dROVjGecgTlveQyodatP99tEM36/6B/nTmgyE5X
         u/TsJTNAG/vdazyTnRFyKJZT6pt1AsJz6CWn49k/smcHUze4VxuHLMrvc0vTTQQs4j9W
         rqtqLNe2Ev8ubOK6VuZRtPNHxuOy0wlLlwBi3WFOBrq045FYCjrRT2KXvdv6y3dNI+zb
         gWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692277; x=1774297077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z9Q6fH9c6L1HLnK289rjhbhnEGeVoiRSnOJS5fAspJg=;
        b=OwiKPxGlqBj3jP4oBeEv+ht4bn6602cpwHz8Y/fcC0kxu+4vqgim6iofWInDi3zDZu
         ZtJjEf4OoFoatluErmTTwpetK5mVJICEGHIJpfJtdcrTGyl9m8eNuPKiNneSFHRi6TUJ
         Ie+0N+UVUZycSuA6Ilnz5Na/7mhBLjJJR6sQXryeWZ78X7JQUUNd9jsyRh6FuEMbCZpO
         xn3diY8Gk93IoZvw4XTq4XcG6jfA5oJ9K5rWl++n2bA3c9libBm4xwuPF6IWrIj4iT7w
         wbSrRBQhGGx/l++oyh3rtOV05iYejWvhJ3mcOuy82hA25EV68UDB0Ms/KWRFcjkRZY00
         T1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUQW1bClD/w6TPl7QrLSnfzYPY0IBCIJdL7hymQAuyNW2X8N/+k7rDSDXbHMrqkEXoZ2wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9kf9xUy/7jiL0rK7gvmPRjq5DG+Xa3GFXcjqbiKvfCvrveR66
	TPMNVAEov3xAzNVcqEkftW4EIWrtM03J1bZ5TpVR9kYfDhHb8EPIy6QabAoiyOc3tilsj9BdD5o
	ZB7mZAv6kYW6nrHMeU2+O8wUFDDBdJYSdXk/pCuNc
X-Gm-Gg: ATEYQzzkPucvcBJYcmQ7IwOBautlSm8uqjwrV7jnR23YYChgVeAj0ZmWbSfD+x2hzyy
	y23Y3B9W7k4ZDCvXUAU2YGDn93xvGfKrU1vgqNXmTIjcAOU9dcrDvDzszV3GBncq8roIczMjOV4
	pY5r59bY1U5v8lvpoN3pWkGgEbu6DhNM2DE/n4y2bSp+1BsJr13qsFACpHHnSMKE9ksKiVXHn5a
	K1N+kwP+JjC5q/DB2FaQM/ORly9u2ji700YsgvuOt3hKsAUz+3tDJr6zoeYP029y9CpokbtA1Xr
	TqFPdXEO
X-Received: by 2002:a05:6102:2914:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-6020e545dd6mr4815388137.29.1773692276401; Mon, 16 Mar 2026
 13:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316182025.3383443-1-mhonap@nvidia.com>
In-Reply-To: <20260316182025.3383443-1-mhonap@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 13:17:27 -0700
X-Gm-Features: AaiRm500IMKzdT9Uk7XlTKlfOo9LWN5p_UCslJHzbBodrkrMtGSMmsrWtG5rUj8
Message-ID: <CALzav=dkiHkA6f9xv3HAozsoOz39ruLVB8yCMLB6nw-+hX1cHA@mail.gmail.com>
Subject: Re: [PATCH] selftests/vfio: Fix VLA initialisation in vfio_pci_irq_set()
To: mhonap@nvidia.com
Cc: alwilliamson@nvidia.com, dave.jiang@intel.com, ankita@nvidia.com, 
	kjaju@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 11:21=E2=80=AFAM <mhonap@nvidia.com> wrote:
>
> From: Manish Honap <mhonap@nvidia.com>

Please use "vfio: selftests: " instead of "selftests/vfio:" to match
all the other changes to tools/testing/selftests/vfio.

  $ git log --oneline tools/testing/selftests/vfio

> C does not permit an initialiser expression on a variable-length array
> (C99 Section 6.7.9 constraint: "The type of the entity to be initialized
> shall not be a variable length array type").
>
> vfio_pci_irq_set() declared:
>
>       u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] =3D {};
>
> where `count` is a runtime function parameter, making `buf` a VLA.
>
> GCC rejects this with (tried with GCC-9.4.0):
>
>       error: variable-sized object may not be initialized
>
> Fix by removing the `=3D {}` initialiser and inserting an explicit
> memset() immediately after the declaration.  memset() on a VLA is
> perfectly legal and achieves the same zero-initialisation on all
> conforming C implementations.
>
> This fix is self-contained: it touches only the existing vfio selftest
> helper library and carries no dependency on any other patch.  It was
> originally included as PATCH 20/20 in the CXL Type-2 VFIO passthrough
> RFC series [1] but belongs on the vfio list independently, as noted by
> Dave Jiang.

This should go after the "---" below. It does not need to be in the
commit message.

> [1] https://lore.kernel.org/all/20260311203440.752648-1-mhonap@nvidia.com=
/

I see you also included a new selftest in this series. I'm glad to see
more usage of VFIO selftests!

Can you please Cc me on any future changes that touch
tools/testing/selftests/vfio? Or better yet run
scripts/get_maintainer.pl and it should add me automatically. Thanks.

> Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO self=
tests")
> Cc: stable@vger.kernel.org
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>

Aside from the commit message nits above:

  Reviewed-by: David Matlack <dmatlack@google.com>
