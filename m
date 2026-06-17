Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FC3B7752
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702028; cv=pass; b=nmsJ+y96IFQZHEiYyYrRjoAns2V9m5MHtQgFf2pmWwhcwwuRBW2rLL9cbB5BalQwyyRowWLM5JzrKWGB0EUHNNH0HJMhkn4HZGYUDa6glwRBqDKThObIW1vXEr4fn+yNilQlfHnEjOzoyysfKHHnWKA1VKhqU3zBsOhptvxfdAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702028; c=relaxed/simple;
	bh=etk5TEpxc/Cbokv32elfaJQtcuFnx/QCHFl6IdRsRsE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UySSI8evJGb4BBObKbgKPQJ2LWR4eT5PM0FBYa1wfnNILJ4ukF2Cv/93iTkIj7//32+rfcvxSBLuHWn/3XHMcrLd8oR10Rpuka1rfQLEqZegD5rVpiZF1tNuYR7AwdqGgxF0m7wXocyyJ8K1rEUo/wAXw5JsmOHygG7Ds4S5cDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WURSLT8G; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WURSLT8G"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1370417c01cso7435155c88.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 06:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781702026; cv=none;
        d=google.com; s=arc-20240605;
        b=bpMWQtyBWEtnL2WzA03smkueX9sV++ViZPOaPtuaAPrJWQ04W43RTegDa2uMzx7cWt
         6zbj74vrmM2tjiQlvFmaL29W0oAZQzgIqiW+YBf6QrG4z5H+4iskzgzoekkyzS9+OVSs
         UKNyKOPQ0oj/jiiMYNhc4P9nrUUYAMjfTkSrm6lbO/v5hL2EDa0egSCH7R9Lv+f8Kvuk
         j+W8A42ks1bk9KqkewGHFlhmXF13FoZTOEWS5VFjksLiq64T7h7+LC5fls6B5f43yu6H
         54OplwJYRMamJ4qYecmhSYjlUw2RIvIE96zffAGJyRJCK75GvwU5ycckA3onAloTITSZ
         LTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=etk5TEpxc/Cbokv32elfaJQtcuFnx/QCHFl6IdRsRsE=;
        fh=/byEEUTcP1Uwd2xFQECV+KKI4PI36WWxobS7a3OtOFk=;
        b=CwLISTobtOK8e8FtNQOoYc4Ye0fhXfm//vSlTdeeoLIEUs2pLBr1wakf3jEZTNdBEr
         TPx0nXcLHPBihqMNMMmOMo/TpvU06v54w+SgUcAsF+ZaaeKM8jI54BY0XmZS6/xYElTB
         2i1Tc48fS3/6yAYpq5x0FIl+2x5EnrnAvxQ97fnyF8ZQDfcCWFZPlh73Mky1evA6iqRe
         YlFbNVlwgm5F1peyR7A0CAkG/ouftXmt9cD60A5QFmFjhiPtL4n8e81JPOTfgnpeBYYx
         hq31a40WoMBfdEf5clKozqnqNaGbHtjI84nNLSM6Rx9vL4oBWyLZgJbjohi1rZyJpmuZ
         w+9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781702026; x=1782306826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=etk5TEpxc/Cbokv32elfaJQtcuFnx/QCHFl6IdRsRsE=;
        b=WURSLT8GJavJ/M1WIL1iPJmkZhxu6BXJTy9IFCf0E6qJfOOVjG/LVWkh3jKTQlBpN8
         6fhHige+n2UKYumtYzhOAfhAitRgXxPA6J3L0au6sl4uelyExcsX/XZF2W65ywE5ppZT
         EeRrYlxUrQMA9gUvnKIdoA3NoO2AFOx/N4Jlc6d3aNVG3r7qdHBivE2KQrHxa6cOzKG7
         qlAJ4EseWc5D/f+ZrLOcN4HjQnwj5BLLSoOq468s8JM3rVoYA6wGKZVedDka0i+m7w6w
         JJrQyrBoQOphObbLwqeNXPNcfjSa2R31fUoaleVQ5Aa4c7Rpnrvxe5SA0moU7hTKKr0H
         wAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781702026; x=1782306826;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etk5TEpxc/Cbokv32elfaJQtcuFnx/QCHFl6IdRsRsE=;
        b=qY/32O8QrnOxnMpB1t32s/QixXvEd6gSbwM0tJ8ElCOLTh/fCCgXJ0eq2+Fn+AC8fr
         WvOjleP2WX7IVIImgtOgt/f+XocirpH89peah2ZSlZpgvJNwvu2Eekf/E0WLj2DKqniG
         D3gzJOdaKq71wD8DcH5TXpD1ZugBg6sjHHcRMyaoTrN+dywmcU0OJZDxq1KV5hUWhJ7b
         0u7/gc/O41SmklaNp7X6KYPgiJcjRnePCtbUdAajJRn9p4UmRWF67o9nS0SC2QdssFZY
         I60eG7FcubMqCTtTSw9bu+i6LewWtwJLoDFMBUYnUEeykWQAzSWv8uQAu5aZFfvBo3Sn
         1wbg==
X-Forwarded-Encrypted: i=1; AFNElJ8PzUxEbWFyHa2U8VTnq/UhOBtRGmNjgA5vHYtOe1GVc80GsqoztntZpwP32CFTa7SPo6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRm/Wvz3TppZhi4ZGej9Fhis1rV0WuxjkwM/zkWVGf5yLu97I
	cMXu6Nc/xdZfOyGSZAUg6IESuQ4p6SAr2Wr2KUkn6i+qn3K0PO0l4/aon8bBKo6BKjU7eAtHP2i
	scxaKy1hkhL2Us4FiXMGv+nHiS92+DX6e+7GUKSOC
X-Gm-Gg: Acq92OGfg3AKGeadq3PLH/7nTHtXr1qomqJ/dNZzDU0idV+u0RHevJF1xuRrsqifGXd
	djS7KECZoTSDGUbj7Jx1APD2QqFPhCf31tz8jvC1WLG5CmKGSavR4ftU5qFBYP8Dqxb13KDDlf0
	GayFO5w51jeVvjbdkdy6u/DK1jykG4kQQUZRecFuQ4pqgthdjf0tAXPYOYcNRX82xnYHPRZENR7
	iMuFewdZBM7Tg15e2d3hTXlTGLuZlD7fOTTWCqGLnYXfUDDPRQAT9p7SP/pDRpyymFSd4+P2Oiu
	Q11uK3p52BnZBtZG4iJs364Ia2Q5
X-Received: by 2002:a05:7022:524:b0:137:fad9:3a30 with SMTP id
 a92af1059eb24-1398f696441mr1495391c88.19.1781702024655; Wed, 17 Jun 2026
 06:13:44 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jun 2026 06:13:43 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jun 2026 06:13:43 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-1-a5bc7db5a9b2@google.com>
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
 <20260602-memory-failure-mf-delayed-fix-v4-1-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jun 2026 06:13:43 -0700
X-Gm-Features: AVVi8Cfnc-0tXLPGbgF8GaHxdvGvxKqOIRy-XHFGP0uROl7Q0KGVLFb3jhqBNAo
Message-ID: <CAEvNRgGmX9oboHx=GGdWGJYebptyr0qdCsVFgSNQ5miUt4tFEw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] mm: memory_failure: Clarify the MF_DELAYED definition
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

>
> [...snip...]
>
> - * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed.
> - * The page is unmapped, and is removed from the LRU or file mapping.
> - * An attempt to access the page again will trigger page fault and the
> - * PF handler will kill the process.
> + * MF_DELAYED - The m-f() handler marks the page as PG_hwpoison'ed.
> + * It means the page was unmapped and partially isolated (e.g. removed from
> + * file mapping or the LRU) but full cleanup is deferred (e.g. the metadata
> + * for the memory, as in struct page/folio, is still referenced). Any
> + * further access to the page will result in the process being killed.
>
> [...snip...]
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
