Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62F3F5BE1
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456408; cv=pass; b=rjDPsQZsxKXqV9vMP0nUEsfzN2W9VtvxKfLXxyALDGmhu+g5/lj3GaM6ckF7kIweR+kAk3Rcdz8p4XD5RlZ1H6DgiBR+JRyJf7UQKqXFef5KzuQf1lNXkDNxuTqpCCXcQcaZaV9cKCsEK0n9O5sR4fxWmMIyVHdLJdbVZMtwht4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456408; c=relaxed/simple;
	bh=FUPxX+FnPgniZBlm8hxuYZj/Yv6KejUVM0c2K8usLxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fjy5omdQPysYY5tBHbaI9s7csTPbTNqStHSMit5eLUQ16P4qHntR4XBlBR8lkqxXcE/WuPxQr7kpq0NoLKmwLt1bVp4AR1Mv1nQ0ohyA5fT9mVQDWUh1PWesYHkNa2CCLQ7TzTFezc2UJ9MaIIlYSKVJI5IAdM3xHk/mlc+kDQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLSlz244; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLSlz244"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so84104a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 13:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783456406; cv=none;
        d=google.com; s=arc-20260327;
        b=JnbfAkXtgmdoQ6j+Ogblh1B4+/tmvEmlNZJokZWydJS3m9VtGrHJBHPCBDdM3DFqWn
         PK3EBVgDgdf8Zz59v5ecepNEHOVorW0jVpseXrDqY+BZUWjY4hMFcK08+Ydwi0dSiBjr
         BRwcywnhqNjTZdWPAnZ+VWuk4v+s4em3ULX1qyd3ml87oa+oqyHJR2+6AKsKkjp8tn3W
         fwYNdyUEDO1LLqJ7drz9aB6CXFTK6y9c03MILKlBWcIbkfxNcgsiLQ29+6K866pLUCfQ
         C3sO+tAjfAAbZS4H46BRqaw+bMtZMm4+w1K2c8WECzPpo3wExg1cJ8BHa0f2q20xR5dC
         2HcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jSweCpb6asuGCMbQKK1bSMgdQBG8UhSu6mrgIEhFEkM=;
        fh=QGOSbqHXNfEsRJMiKxygMPdMi/b4ceHqXBD9WVzu7fQ=;
        b=UikTd8AhdikATeyNGLCbnNcQH3Pt0JUJ67be+lfc5vtKuWO2PdDSj79xLFkFEV3qJ/
         N2In8lbjWBr++40KueXbqYnehsqc3E2gLy8dv2uGlMUNrz+JAM+vDaFYmmvMc5hv7Z2k
         AzCKsvoYTKwG7oSO2nzRqeDdhjXYfDEB82u9PxEcKJou50jlwdZZrjDR0dnDgPVCSoVb
         KjZn8S2PU2/KeDD2CC8k06dtWEnA/182XNAyiDZU4kDujTN+sOraVGI7l961ieKRPgBB
         HBKE58Po87edMwnWXmvOJesc1ZUCEfOTQgFKYVoKKH2MGi5Y1HmIpP40UQ9GgIYMcnq8
         JgGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783456406; x=1784061206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jSweCpb6asuGCMbQKK1bSMgdQBG8UhSu6mrgIEhFEkM=;
        b=CLSlz244q9rGcI42Vi6Hikiv4N/hQH9Lf+XhvhgSsWFU1cQ5Q3GETp2j4cixhQLfOo
         Ie/JVTJ+QPf7NrlQW7Kj6alqcYG8dLzYZ0M0arWxqMVwPC+nfDxAV0qtnYD8aX1Ud+j5
         gDXWlbc/IO2l5jehxH5BsDzaMYzp+iodRgl1i4tXqIhgXS7xn3Mx7VsKq4aZAivX0Ec1
         ZCytH0TnTEi2HpaKaz7wtR+DdU4xtbNc5pOf/mYTU8ddvoA2aqnEhCF1UyhP2MRHQK9P
         wctB8nJ57zs4+nPbEvIXVN4FbljQ/Bd5MY/ApLIKVfOZrv+5GPQNNJ8GdUz1EXgMJEB7
         TIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783456406; x=1784061206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSweCpb6asuGCMbQKK1bSMgdQBG8UhSu6mrgIEhFEkM=;
        b=jI49wzg00JRkdOmELvIZvsOVUjevibR2xtUJXVYFf8A/D3aAJS6pLazoId2+v2dDaw
         ecfyKLLcezUVvRU9OiEskeTpx7l4FYeHB9rlsQJbuJwAFWhn0MTNyjBCm4n6oXiBFwrk
         4fmtnSXxPNgbV0f2qGjPrRMFbMlG61qpey2N81OMBcp5/UmzW0Nd0iGWB0W/E73BdQn7
         wVFGCTQgP85gVYYBb2LJal4ieWfu6svN78h2PBvFFJAKQbwuz2r0kdbfrRqtQnuP1P9t
         jWwXk1iWglpN8hpjwkP68u474UtDBGN3CSIUESyS+LWLnPwWn1ONSpzZJqqHOn7yH3Aw
         KUjg==
X-Gm-Message-State: AOJu0Yyh/8ZJjZOWLii4d5THtCU9vcL70FoIuiNO8zG6XKV1v7PVPeuC
	bHFSLEPjKhuUyQouTBNprTInKWFuLQq2Tnh7d2DCnnMYHBkjnCds9B58F9efimjoUB2WVZ50QzI
	Zaa/aG2S1Ln3o4V0xxaWaLleBawpO/lGZeLKY+x7x
X-Gm-Gg: AfdE7cm8W9I3Q8I+ijiDl093fMzSBP9EgFztb4iabNR9baWAjfxxwVMJrhkFqCqLBD3
	gEAgvKPwTo5q9Rsl52ubByLCttmALD5+UY6J81+/C4YGhzmYn6PrYZYZOZGmQZMSH82k+EvGxu0
	iH26D51jrBoyKjS+kcpdF/9GKdRrn/FvqGs5hU3QpwIW+42NVerMUMa5gIgNehkrcn4g1VnVquY
	+iFDUlfFcEXkrHvtskcZAtQhjwQ12U454TykpLjHDe8HkztX4rxi/7TDvEB2XhmRR2a49Qs
X-Received: by 2002:a05:6a20:9188:b0:3bf:96c6:78a9 with SMTP id
 adf61e73a8af0-3c08ed40638mr6931857637.2.1783456405469; Tue, 07 Jul 2026
 13:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701203311.326798-1-aaronlewis@google.com>
 <20260701203311.326798-5-aaronlewis@google.com> <ak1h748NuhCzVlJ2@google.com>
In-Reply-To: <ak1h748NuhCzVlJ2@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 7 Jul 2026 13:32:58 -0700
X-Gm-Features: AVVi8CdzRZCWoT_FeAFeEaTzsMR8As1ehb5sS665IvywfC_02YOULvK4yEqjO5c
Message-ID: <CALzav=fQvBSq9_uaHvP5JsXRWax5mzL0VPrZBvT-oP2W-Ufwpg@mail.gmail.com>
Subject: Re: [PATCH 4/4] vfio: selftests: Allow the flag MAP_POPULATE to be
 set on the cmdline
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 1:30=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2026-07-01 08:33 PM, Aaron Lewis wrote:
> > Add a command-line option to vfio_dma_mapping_perf_test to set the
> > MAP_POPULATE flag during mmap(). This ensures consistent and accurate D=
MA
> > mapping latency measurements by forcing page prefaulting to occur durin=
g
> > the mmap() phase, rather than during the DMA mapping ioctl.
> >
> > For example, mapping a 32G region without the -p (MAP_POPULATE) flag
> > results in:
> >
> >   $ ./vfio_dma_mapping_perf_test -b 32G -a "-v vfio_type1_iommu_memfd_h=
ugetlb_1gb"
> >   Completed mmap() for memfd in 0.00ms
> >   Mapped HVA 0x7f1840000000 (size 32G) at IOVA 0x800000000 in 2887.56ms
> >
> > Here, the mmap() call completes instantly, but the ioctl to map the DMA
> > region incurs the ~3s cost of prefaulting the pages.
> >
> > Running the same test with the -p flag results in:
> >
> >   $ ./vfio_dma_mapping_perf_test -p -b 32G -a "-v vfio_type1_iommu_memf=
d_hugetlb_1gb"
> >   Completed mmap() for memfd in 2887.41ms
> >   Mapped HVA 0x7f8000000000 (size 32G) at IOVA 0x800000000 in 11.51ms
> >
> > By shifting the prefaulting overhead to mmap(), the actual DMA mapping
> > latency is isolated and accurately reported as 11.51ms.
> >
> > With user-defined mapping sizes and prefaulting in place, this test now
> > clearly demonstrates the difference in mapping speeds between VFIO's Ty=
pe 1
> > IOMMU and IOMMUFD (i.e., IOMMU_IOAS_MAP_FILE).
> >
> > Running the same configuration with the "iommufd_memfd_hugetlb_1gb" var=
iant
> > highlights this difference:
> >
> > $ ./vfio_dma_mapping_perf_test -p -b 32G -a "-v iommufd_memfd_hugetlb_1=
gb"
> > Mapped HVA 0x7f4fc0000000 (size 32G) at IOVA 0x800000000 in 0.11ms
> >
> > The DMA mapping time drops dramatically from 11.51ms to 0.11ms.
> >
> > Signed-off-by: Aaron Lewis <aaronlewis@google.com>
>
> IMO we should either:
>
>  1. Only support the MAP_POPULATE variant since that isolates the VFIO
>     and IOMMUFD performance from allocating the backing memory and
>     aligns with how a proper userspace should be designed.
>
>  or
>
>  2. Make MAP_POPULATE toggle a test fixture variant so that we
>     automatically test both scenarios without needing a command line
>     flag. If the user wants to test just one scenario they can do so via
>     kselftest harness -t flag.
>
> Either way, we shouldn't need a command line flag for this.
>
> I don't have a strong opinion between the two but lean towards (2)
> until we have a compelling reason to care about the performance of VFIO
> and IOMMUFD triggering the backing memory allocations.

Oops I meant "lean towards (1)" there.
