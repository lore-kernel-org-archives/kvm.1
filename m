Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D0346FB3
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 05:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774070398; cv=none; b=eVFdSR2SOS4b1DS5lFZUYdp9EJuRK0T2IIRTRYSapvj1HbQ6zt3+QNLtFFKccnT2G5AwK4Ex6qZUr0VAbdE1w3tcLO5HHV/edJvicrebG4Z6VJvsFQpUIqJfTEaVUG8BZ4BqWecXCFY+Yi8A4rApVqlWe2qbcxaSwYlXiLynJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774070398; c=relaxed/simple;
	bh=GBqnSW9uq89sCfuA0J6JSy8lRk9vTD0tsuanrzAodm0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=vCtKsogHLAej9oLIac23slQ3Uf316cuNtq7VbxKzhSdXSBujG08mHHM+QW610mwlWdYnWlE8RkGBfU4kdJS00RMxs8MDu2K3G+Oj1FndiH41DNodIllC41jIPju05iAjPb0s/VB+tQIcWq9DZIaCy5dBcxbwVydYbSSDS5MMpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiWmc/3g; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiWmc/3g"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2addb31945aso17320595ad.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 22:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774070395; x=1774675195; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N5slH90cGMNQaJ/nUAO66vR2HM7xhu3omBUy3YIB1Mo=;
        b=NiWmc/3g78YJ3IIOQKmn6Kw0P2JnH5XPXN8IGFgqB38AEiQjp39KqmoZwYkmt+95ll
         vikpnSOFcMpbj3rsbfQq6BC2xgnlo5c8d8nr7iuPfHxqMKffbt97tJZz7SbyxXmFtbyU
         /Tz9PQeAJ1W/CjxmbMGKqGiCJAEH7xTXWoJyWVyWZgsFixVDXhZaKpghttKAc8NO6ZA6
         U8/fG3+LS2SbdS29Z9Akr0LnK00hsGBnRNExnuWFLFhLlxY9G/dDi7qkkuMa6PAW8vB/
         FmJ70tr2Va5oZZUuX/qO6ZUZWbjAkzMEYy8FwaPKC6msAmsr5c8FO9isD5voU//faGif
         pPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774070395; x=1774675195;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5slH90cGMNQaJ/nUAO66vR2HM7xhu3omBUy3YIB1Mo=;
        b=CasUAk8LfXisOgq7UKQnSA6MLq2ANi2F5dxUrAeESupTjSQrTyjEpNKWrybogaMUg6
         FCuuJkOzk5pDmyvVlFbeDitpzOTEs0FOCWBQWOIaUg4Ft6LEimT8lOqRiicsiyl7W7zD
         7d3jTS9LPCeXMeJ1uKKHwJauGe7o4femPXAwbiArQFE8u4DiX5znFvYNOnHpsAZYV2U7
         2Lb9E4e6zIu4X/1u3DcQ4Tzb7tDXMQbaqbb86RknUAK+R3IAC1BVtObqO1RRxsGpfTy0
         TzHxWBUyidnxtmQDaQtVjTCiZ6TM0r64SvU3hfXcs3skzzVlW0byCwnexHAIhQaZ+4KK
         UYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4JrCTKMGq1We+gL0TlgJke6WvLhPMQKc1q0dckWlnZwqQbB3TkNbiVzz3UEOpzeLTe04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8sHiZyTv4IdLp2VLTJh0NR7OvKS8rXz8aCPd40DJAz6mCNsC
	TceTRRzDRzm//d0rMu8IvzaCRWvNSPH5Qh3vecCaSEtaw8LGMoelzef3
X-Gm-Gg: ATEYQzyGFAKHrgvCKroTBlNetKfqhLorw1mTvNzK242w8YsvfxA6OThxB3g3HFfLgg+
	YIkA45PlWqG5DFJk4Yb8GtbHHNKgqNjwDplh1QNOGiFq7inZ0IetGyZ4XorFy+o8eN92VEMB+eu
	xXT5+ERtktC7i3idIxLHh7f7qhJe0NoEQNX4wCdhUYHlPP2n76AXt632AVKtDVo6/jcRh1NTiNT
	ajQvgRpYJzH2RMTJP4sh/bn3AVqA1OIE4/+UtafglBgNZRruPLKrQ1F44iHEH8g1raC2VbiNk/3
	XllAJd28cSQ1DAw9EEoW+3VE36Z5IpqXA67rMmpFBT2WZLqPOmAScOc9+nSJ0dTOAnT+rM7eX8t
	sOCv6khFrNfyDeA2TFIP00ZHmXtlJmTBrvKRfmTb4qjg4tC9siWJTTRGC0hrHamwlmeJ7x8uSne
	7x8e3thWvTM1UVF7IZkM4rnA==
X-Received: by 2002:a17:903:191:b0:2ae:c984:6d72 with SMTP id d9443c01a7336-2b08271e23fmr57382855ad.22.1774070395090;
        Fri, 20 Mar 2026 22:19:55 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836955dbsm52944385ad.72.2026.03.20.22.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:19:54 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: change to return bool for ptep_clear_flush_young()/clear_flush_young_ptes()
In-Reply-To: <5d24b34d8b7860dc2188408b3fa530193bcc5caa.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Sat, 21 Mar 2026 10:48:41 +0530
Message-ID: <fr5tyd3i.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com> <5d24b34d8b7860dc2188408b3fa530193bcc5caa.1773890510.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> The ptep_clear_flush_young() and clear_flush_young_ptes() are used to clear
> the young flag and flush the TLB, returning whether the young flag was set.
> Change the return type to bool to make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/pgtable.h             | 15 +++++++--------
>  arch/arm64/mm/contpte.c                      |  4 ++--
>  arch/parisc/include/asm/pgtable.h            |  2 +-
>  arch/parisc/kernel/cache.c                   |  8 ++++----
>  arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
>  arch/riscv/include/asm/pgtable.h             |  4 ++--
>  arch/s390/include/asm/pgtable.h              |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  4 ++--
>  include/linux/pgtable.h                      |  8 ++++----
>  mm/pgtable-generic.c                         |  7 ++++---
>  11 files changed, 31 insertions(+), 31 deletions(-)

LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

