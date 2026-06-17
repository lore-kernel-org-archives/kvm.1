Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720373803DC
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702255; cv=pass; b=G7YdZNt+o9zJMJL9oOEvL6wrUV2IC6kriyui48O6TekIRb6cvC3nHOZy+3wo5q26Can/F53WmNWK/I7ZbAMyJuPZvgfd9GKLr4QGZPHDiuc8eQUSVWFo42xX3fI2O3WnOEo53AW5KPwXylzOWdqju3qpz8lT1JW+cEZdrs4i/IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702255; c=relaxed/simple;
	bh=+CNdrODz+Hv1rDOvnESn6HIq5tpRJ8ga6baCyPTW/es=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aU/VyEJuc2caYZP88XoGgOH+PEMJWlOkd12Qk+GWAE20wFPmVlXxe/IlYbPfSlKCBSEGUiP+4113pQAzg99xi/Z6z7jcRtRy0eC18ooU1BgWf0mKFivrYaChvL9vA7ajl+G5Aw8V5UEXnDO0jAEF8RWFsNv975HNbiuJSaQUgQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcV5UTdI; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcV5UTdI"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13986d61b4fso1923976c88.0
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 06:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781702253; cv=none;
        d=google.com; s=arc-20240605;
        b=HLXC3kK8zQBVXnvNPVEK9X8+1DVOjb5b1/CjOKzBvJOevNl4uY3Va2puJDuc1wzS8a
         RDTL7OeQnub9iE113Q2yqWTvkPzrmoqMF2LunDxSsE0syzQ4YQ1iLVVP8rjvs4QxnL0q
         YpQd61Qx98wF4HOLqY0XFdPKJBDj8NAqPBxykNhZqTWhCGJie9+8Kg9UiWewqLJsPyaR
         +IaISP3ezZxVEVuC6Gj2vlClexZvfiQ+KcWgiRBrfYThvNjY2WieF8EBLXhPB5+rrw8g
         jdk2zqtEaFcARSckqx6ovDudkgMPKKRo5wG+HPC0sZyKGkaRD6uziouau31Qv/fW5qwk
         eI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=RwC8e8Lmq0O5HhDIZSANNcyMzpbq38LuCnVbAdWRbDE=;
        fh=uDAoM2KIVRkYDcQ8iKBn4P6/u3CCyDOp+2ynGyfmrsk=;
        b=ZVzb4uBbmXRxoCs4QUG3giTzwrhGMepVc+F3YQ/TBxvL3w0VvgwoD8b8R/2n27oQQu
         bFIQgeeyzcITS3RANoBqjiZYO365/ZAR/WiI2fZffzOHtlhTirambTUZ39TzPrUtwSbb
         EbRfKs+BEv856HX43NwN+GVU1tciji9MM6Lfvid7Xr8LVxmpQyeJaqXMCJaNwWKHADWv
         HMTUv7QsJxZ4vfBdt8UEvYCRpU3hTBxXqKT4Tb3GYoNI7y7mIgXr2C9jTlzIiKB0WG4k
         /kJGifBHoeES/daaGkJSSe1R7m7crg6dLLLjT0FdQIjYnXSHJpDNnlkPm8FMH9NmDeMX
         qB1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781702253; x=1782307053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwC8e8Lmq0O5HhDIZSANNcyMzpbq38LuCnVbAdWRbDE=;
        b=JcV5UTdIH5wDmKUoCv0OTOTBJ59kHnXj2E34i8kFr97BAYoqMTOB2EUVh8nIMWNU7B
         qzLPy7YS1Jj4DFODl5OU8LyBHIhkFCXVf+C45EZT2WfWt9lOW1URoePkrFOOLSNnpTmA
         2DaGxH730lSBMasYeIhl5RIaLwLMgnyi+BZoKNJOql54iv12eYGCdMZFXlPcifviJJaD
         jGW05a/hes+cSra1vG2Qdz0FYu4EwO64GR1dOeshBvnlyPFRrdqz1vSobET7J1G39dFp
         9Gcd1Z13q+y8N1gJ3OluDpYNs5p54adS6wM6sbq4k3A09zHVZL0PcVUx7sxNsH10HqeG
         asQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781702253; x=1782307053;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwC8e8Lmq0O5HhDIZSANNcyMzpbq38LuCnVbAdWRbDE=;
        b=OcjcjXOCrw8Zp3BSLqATtUZB+xefLx5sPAkmUfWW5KSLXPzNJVFfFgDhqEZ8HBrD3G
         ZmuReAyePOcQxNz/GAOw3ExDfGRj2oCp0rDVm077W8Ceykcs5PNk1R/c/GhK33kJsfka
         Q62uqw6VGYZwvaQMZro7YfL6wtQsX7Cm6SvJviAFZbYkHtFZ8CPZo3tLBIpnjQ8/ERMl
         YLLiENkbaNlfRmC4x+8PqwdpcVs+N9skFArFqhio5F63Q/AnzLRB4GWnVdcifseV0h6n
         M9VH8WFEgwYXbh/SfEujTjDe388fklGFPEddq4LYDvYwoWiWAUWq3D1J3+FcV+v/z61o
         /EvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wW4TQIo6bMcVAqTg8OjRgcmRVr0NR8WSxJ3yjFV+7zrYXceN1xECaVdY7T03mrGltJeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymzdrR/DbSYuloDtfZReTEqEnwKwvPfBUv1qGqlyayL95pZi+l
	3bZPrkIEP/SZhzEd4PQ8Jn9AyZEOx2kQbV5A+RlCxJhSGYwB+wHX/BI5xQDfRtSxDdr9/Dratuh
	DIFp+HPwWP/9KKx1b6YHRx3pxC/grnI+HiRR9j8e1
X-Gm-Gg: Acq92OF9pltxZi6LMUnzim13qoh2rouTONNS3QvdS0/bdZM5atrMEbCNLPxWoV31EOD
	ckaa0hfi2a/W4WehLfVdaKXvXRkWeARnPRU7mSc0RyLQKPL3C78bMubfQ/3Jk7PPwXI/AK0rZ7H
	BX3z+ZsKN4UA0suTIhh+freIn/eQWXe4+uoqkt6S564GigSF8o55Z32y3Di7JFNvyHUCsvj3NeL
	/thvuT9HB6wXsRfxbBbn28rNjqddvDDSljVx67RYEnGtGseN8oDLlxvcgvaBSz9r4lq1awEuonh
	Z8zHrKUwclqc4KwMD160bxVjwN58
X-Received: by 2002:a05:7023:b0a:b0:137:fac1:c062 with SMTP id
 a92af1059eb24-1398f666456mr1449795c88.7.1781702252499; Wed, 17 Jun 2026
 06:17:32 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jun 2026 06:17:31 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jun 2026 06:17:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-3-a5bc7db5a9b2@google.com>
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
 <20260602-memory-failure-mf-delayed-fix-v4-3-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jun 2026 06:17:31 -0700
X-Gm-Features: AVVi8Cdef2qXnvj8kjBvz8bXKzlY8rIYk_kwyzXVJwqQ7pJ9jLNjcBvloKBgS-0
Message-ID: <CAEvNRgE2iqYpEy8F4df2b=zegzqmJAgVJs5xz2KD-jxe+0GNMQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mm: shmem: Update shmem handler to the MF_DELAYED definition
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

> To align with the definition of MF_DELAYED, update
> shmem_error_remove_folio() to return MF_DELAYED.
>
> shmem handles memory failures but defers the actual file truncation. The
> function's return value should therefore be MF_DELAYED to accurately
> reflect the state.
>
> Currently, this logical error does not cause a bug, because:
>
> - For shmem folios, folio->private is not set.
> - As a result, filemap_release_folio() is a no-op and returns true.
> - This, in turn, causes truncate_error_folio() to incorrectly return
>   MF_RECOVERED.
> - The caller then treats MF_RECOVERED as a success condition, masking the
>   issue.
>
> The previous patch relays MF_DELAYED to the caller of
> truncate_error_folio() before any logging, so returning MF_DELAYED from
> shmem_error_remove_folio() will retain the original behavior of not
> adding any logs.
>
> The return value of truncate_error_folio() is consumed in action_result(),
> which treats MF_DELAYED the same way as MF_RECOVERED, hence action_result()
> also returns the same thing after this change.
>

Thanks for explaining here!

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> [...snip...]
>
