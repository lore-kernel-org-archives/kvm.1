Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15309306D3F
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702173; cv=pass; b=HgFgRGXdEzzf5qI1Hlwox2Nnce1bT9sNwHk5apemuze99e9c36bTpkZ/SbXMCPH7GK84ozLM7I7ve5fdGHWI0e6zoOuuY6EOezcpujBQOmz6R3xKsX3aSSxoXMzeiFE9aBnCIVPNqAjLDmrFZvrBIIwbDW7pJlzholeeo5dSQ+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702173; c=relaxed/simple;
	bh=gmAuTwxlMWJ7OGYz8VtUGLfVc7D1t2W3tIu9G/RHjhM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a10YHetL0JKeFXhaQRNM+0GZiCtohEfx9IQJGX/RA3H0rTT+wPODx6sLr7G0zuN1Rnu5I5a9ycLGU99ePdNRSKNOyxC1yvDjEqiRCVKYNGVcTBH1HxGaRkyhSl+GtqjmfTInDiBQMvjdaZi9Zz86vjxzp1JT7Vos/P57nrikzyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3lllMXi; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3lllMXi"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13981833e13so3087709c88.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 06:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781702171; cv=none;
        d=google.com; s=arc-20240605;
        b=AVFION+F4LUaX6GiGe68K3RCWXuC40O1xwVA9/Te+zP5wq4272YyooDAqguUJ63n62
         wKanCWDyQAy83LLA/90+jUDJd43ScKfBkm8JMDc7IGbiNxNSAwmY6KoqkbrNc/mAeY8r
         hD+m4YekOl6xb9wfyRudLusKaUmA0AL6wdqmyVjyIXvwTx48UozMi6syvYhUClkwmHSN
         ToQ5DY7CzKX99lBoUJ3uLLzFkfa6qb4sseHNR51fD5+eK9NFcO4dMLi5HeWstL+O0ph3
         vPQ1O8nKnowOuCUqcuw8kGuS4IDurcbJQz8NqCEQo1uOh0+dtrLxoYbkhrhIezczNZ/B
         opyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fub6QquxlM+JuEtju5tAKgjI7OpBkhLjLUvWM+isojE=;
        fh=l0H2rJHdaRtSLhCN72U72y2idkHCtRgndD0DuLsjvu0=;
        b=bYvmdgNntbYK5SDUiGExUk4BkN9jt64e0qOmYscdIVPUmZ0Z74/VtmbGNbiDchUtvk
         j1PxDX+Sukwbt5VtDl6y0B+dO7/0DgJzz0TccO+JObmJ3H2oL4SsCqY6vm3xt+LogoUw
         XxcW2IEUvy/qtrpmwRrJ9mUqh2yLEXl4OMnHOkHxt24KJIlaHKl/aj+US1TQ4GOSmQiJ
         JUU/lNhbBTZPaln/y81vDX7I0+8256h8qLukljuaNEwA8Kx9ZbcTLUk0ZvIEPgkDVVH/
         /sSc6pC19ijlUyNwpkKCnSe5wCoKPA/4nIumDY50THEZ0J7FGzPt74KBqlFIkarprL2a
         6A0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781702171; x=1782306971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fub6QquxlM+JuEtju5tAKgjI7OpBkhLjLUvWM+isojE=;
        b=t3lllMXixpPsBSOBBpg25tZ4CJbsjqRmEBUJbzISeFi5nR1m1COsk81aoAe+unsStx
         Ialy9hkyhIyH/1uUYdRI1AWR3GwjaFnPRpMwguPZSlVAWvIPa7lsA314nvc0raPX9t/j
         yBkuysrg0g0SDOscuWrme1a7bFLu8PdjDOrIdYStKDk7eCbBy4A0k2eV6a8RyvfOrHEs
         FUZLwWSBDOZ7deOr5ga9kRSbKVDyP+F2AAPSTY/YsqmWSlJElUYqNoX19/eaM/iyTZ9C
         Xmt1w6eQN7OMoObhYl3G4RP1OoaHVBjDuI+n3hzCRu6m++TOa1iW+wfNOaoGNvZJRbzn
         Cv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781702171; x=1782306971;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fub6QquxlM+JuEtju5tAKgjI7OpBkhLjLUvWM+isojE=;
        b=sesEj6MAuLJv25Xhn1mfV+PW1U8WLkBljy/eL7Lq8565PQCeavo0eChaV/WWFDRsxF
         6rPJ89lXluAnBKkh6WD/OcTU9zMdbwv5IAjaebrXMGSs6IDw31NyX1Qj71wQnOg7KGmL
         B8vjwqAlRlf5W1hg+Zqg4PEkjvTNfPAIJqcZrwA4FKWP3SchzopwF7F4EnzlBdt6uroG
         EW2XR7rw9RcSdQPH5/+wKaT7kaCD/gPKPKG8dJborPe4KsZsht4PBqQq9scXe3NDqKYm
         9Lr1SjcM65ePmrQXp1PB8OZj00mSu6d1eg9jBxdVrR9n4XGsF/YZBkx+OFwfz2ub0IWM
         OIVA==
X-Forwarded-Encrypted: i=1; AFNElJ/tQj0ooY/4I2ziTZ3eNyh7HDQjCxxTeMWuBd9aQmSauPevzCWcj5OTpHwOXqMhHImLntY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPq6Su/GElyVzlAElHDp4/Gagbmujfvdh+yXS15f2IY4teK//r
	8ANQW0ikyNTuwxGhOql0H5N3now2+qUmtHmLD8oN5QocDwxjZkZKxfXCD61GNbvSdk+fg5eQ2Mt
	RQlJxvUQSa6O+SIW7r76ocJ1BkJmBBlDLNHLUnLKU
X-Gm-Gg: Acq92OHxQ3++Oj5EKCGPdzB7+sqRK+YIeY7eCUYcFC6Z49dOepKZYaWjAoIrfnascxp
	gf2BYvC4GzdOdtgNnJfiY5/B/33GSxOwHsSaQh3aeZJ3ndN6I0tDS5OGX/8ziX3XYWlyS3ELOnt
	vDwYx0WIIO3+fjywyFaOzdnyCwigB/ZTpyUSHStAg6L9T7eN6Sk8Xb0NH6u/tGhjL7MlzSis67U
	ckxT+F9uf3GmFAFhfEB1kGauNc/K036Yj2XdNuYo1ey1n5vU1xOGiDFq41ay6F18WkPVWeNArfp
	MBNqt4MhaV2UW1HO9uLdjGylOIlXopvXUgI6+SU=
X-Received: by 2002:a05:7022:6988:b0:137:f875:c1e8 with SMTP id
 a92af1059eb24-1398f69ee3cmr1393217c88.19.1781702170186; Wed, 17 Jun 2026
 06:16:10 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jun 2026 06:16:08 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jun 2026 06:16:08 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-2-a5bc7db5a9b2@google.com>
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
 <20260602-memory-failure-mf-delayed-fix-v4-2-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jun 2026 06:16:08 -0700
X-Gm-Features: AVVi8CeIxcUL2I1aQ_28O_B-smEVzCOJCXmIuSPuXbp3acKL7-ICRYmnGlJB62Q
Message-ID: <CAEvNRgHXJirznmAM3zf2LHJgDWpLOAWY1v90ZcX9_ytRzuAZ1A@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] mm: memory_failure: Allow truncate_error_folio to
 return MF_DELAYED
To: Lisa Wang <wyihan@google.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, vannapurve@google.com, 
	michael.roth@amd.com, jiaqiyan@google.com, tabba@google.com, 
	dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> The .error_remove_folio a_ops is used by different filesystems to handle
> folio truncation upon discovery of a memory failure in the memory
> associated with the given folio.
>
> Currently, MF_DELAYED is treated as an error, causing "Failed to punch
> page" to be written to the console. MF_DELAYED is then relayed to the
> caller of truncate_error_folio() as MF_FAILED. This further causes
> memory_failure() to return -EBUSY, which then always causes a SIGBUS.
>
> This is also implies that regardless of whether the thread's memory
> corruption kill policy is PR_MCE_KILL_EARLY or PR_MCE_KILL_LATE, a
> memory failure with MF_DELAYED will always cause a SIGBUS.
>
> Update truncate_error_folio() to return MF_DELAYED to the caller if the
> .error_remove_folio() callback reports MF_DELAYED.
>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  mm/memory-failure.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 2e53b3024391..3aff0c981fcd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -941,10 +941,12 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
>  	if (mapping->a_ops->error_remove_folio) {
>  		int err = mapping->a_ops->error_remove_folio(mapping, folio);
>
> -		if (err != 0)
> +		if (err == MF_DELAYED)
> +			ret = err;

Perhaps better to set ret = MF_DELAYED directly so that it saves the
reader one step of connecting err == MF_DELAYED with ret = err, but not
a big issue.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> +		else if (err != 0)
>  			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
>  		else if (!filemap_release_folio(folio, GFP_NOIO))
> -			pr_info("%#lx: failed to release buffers\n", pfn);
> +			pr_info("%#lx: Failed to release buffers\n", pfn);
>  		else
>  			ret = MF_RECOVERED;
>  	} else {
>
> --
> 2.54.0.1013.g208068f2d8-goog
