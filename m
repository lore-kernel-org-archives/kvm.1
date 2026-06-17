Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB933F9A08
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702340; cv=pass; b=RFjr8tLGgu9z6EGFNW72pK98DEjbmS9aEB0EaJtEEwxpNNZl/UwpOYzjdD9BP0TViah7QU5BMfkkTS7TqURwwfaTikQxVAWzpO1cTZBLq16seRIe1Uhso0BtLz1Yvkw2B2ZJ04T7GBEzPi2fUhYgHFDd/70UlI3jsCi9vRGqgpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702340; c=relaxed/simple;
	bh=e7bU8MJb5s+ub36roUmBLbpiDK10cOGBN2EWwm2KP4E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktFRGgdKyQpo9ADym47jZ+F3k/5dJsDvFvhIkaHLTOUbBbFNn3sQ3P+EVsjANHGaMJ4pE+pyPDJgWxNtJN+anz4Kw7/LManPnf3KKoG1oNOHdg7iFfSZgNMVNS7EBRxjY/3WmC9Pq0kQS+/UzJ0w536ToqM9rt/YHYeFo7N6gxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYxJEKLl; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYxJEKLl"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-13809223fd4so6235086c88.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 06:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781702339; cv=none;
        d=google.com; s=arc-20240605;
        b=hqF52VQzIWjChtvP8wP3W9Ear7BIEWQmM/W+oEd86FoCwYhAMKhF4VwMfKqfQO0A19
         duPxJcz4mWhGYLyJyiBPrMrsi6yIOKH4kY8Qw3cAqNgZytzKQ67txe5JCe3edLStZfYW
         k6pMQmQHGIWvg7RRQNTDalmI7r1LSd+MkrKhrebkgnC7kvMfKCenG9NMvFRGNGXWE68o
         rwu1hHKzOGmePct8Wh42WY37UYdTUKkGBk5XRLXA20Dr56MTevARByGV82nbVu/elRTW
         J1XS1aQwieNrxJse6HMluRynid1vUQmF1YAiXvvrLAq6HxNV+nIFf6l2NezqqYhYvL80
         ju8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=TXAYl00t3pBUlh7QAs2TCcfP6P29I/Yz3jzTX2aYa7Y=;
        fh=QYEPHVdBfODay6nq2+iBg1nr4wXde7Wo6a+EwO3Sm5A=;
        b=dQDQIYQSxHp1laHNsvzCF4/vzOqt7hrTNyAlupHq64fV4yn9LQZ2nxMc0SJqwt/d7u
         F3wCFVQEZTb4+zHZUc0zNHkC4G99qtLTKFcqew4wcQftBF/ynBfFcpHQ4qqETA0xx1TC
         tDUckkQO6AF7MRhuPgp+zwgYBjODFg+EF9TSjgYT9Qh11OkeMSdiDPTHNl1UwE0Rkl8q
         r9P5Jxw2kwmLjDtPkcpkflaiE0+xZgvi2+04FBQOBw4QUnSo2jNotaxzAgBd4otaXcih
         bRaiq+Uq+tDR6AMYO+kwlNodvsusS1AcrKTwCv5s/K7/BZ1VQDyMO2NfayG7V+aFG8CW
         1yNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781702339; x=1782307139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TXAYl00t3pBUlh7QAs2TCcfP6P29I/Yz3jzTX2aYa7Y=;
        b=CYxJEKLlaHA7qaL362OFwfsiLymTqSAKK9bclU6AEHeTJUxU1bLzZA6g2XB6LF2IPV
         jFzbK7ikFrJ9BFW0iPve+8385Pt/xl+BOI8UXDkDNN6VdEoasWbkvU516YIV0qdxuvk7
         PpHLP59QoksY9tGuURpcfrPmECv5BfQnUVAP+kix2m5frMSV2xmyN88E4h0gRlbzhNte
         sWazsFGeqZT8a0e2CYGNX8SzPFDKj1qXxM9aGfdpeCQCA8XzhpSNbOP5sI4h5I6HF7nf
         pIB+fDjr6DWP67i+XbZSbu7varKGTcVq5Abwh+5hr0JruO42uV9/Gva4vuOhR3XV0xKy
         iqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781702339; x=1782307139;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXAYl00t3pBUlh7QAs2TCcfP6P29I/Yz3jzTX2aYa7Y=;
        b=NNE8z7mMh5AEzmk0hnfnm8n8Cq+eNVi+Q9b89563v0gyeLekCWSn2yiVO05WcYJ8UM
         Zf/f82Gdsr6Uvjnb0Yl3+8yYkJ5wvrI22XEbkkoZ3czVWgMJ5tCSqqOGQiZZbxUBPupm
         SZX+EMmSTfOYA+8bE9bSi2NuCEKQG6McZ5AxmMwDPZsdefHUB9rd9PckxQBHi6BzcBtE
         /qWilirGUy6XHvDHfNiiOusR7M5S1o9+1gXHd9kjYARPS8l4z9ir9zZN2xKbn281NsMy
         IMSeABttzJhp0MU+Nkg2NxLVCetb0/KoPHGrOs5m+szGxD7/od5EyF6Er3vrOkBhVgLq
         kyIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QZ0SqxV+TtO9ITzM/rjA6y6GSkqCi3fTzZPhoRA3jxf6freed0FNtOWbtn7KgmgMiEMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqa1bZOls4L5Lh8/WRQFKPnuJEGP7sDdpMp9xRU7zMTJzVz5nn
	ZdLSf/EUlNrii5l6ve3I+wHi0qfeRpLysTaJZrHKAl9e2WMvInuZT30/Y+cj7nte7eDmUyQsEGh
	iaWpw8xuecGkQTlm+/BGuAxsvpSc9D2unOKBMwt20
X-Gm-Gg: Acq92OEOYVZ/DJUSN8vLbHPSt4RLtRs/8+RLe8SKPb2CllMVguwOIIkAg9EzjHz6ezn
	XnHcop/NpkZrpVEB9C28IdWYEhMtfF3Of2LOsczGaEESsD8BYxQXy1rED1DrO3pgeppaAoyrDdc
	KkiRlz/4ir9O4djEf6ljAlZA2OrFvV4Dbx0lFYP+BANPwtsSq9LUT/4N9B9jFFGlBzdIu4y/jLI
	QUfpao68OvbbL6JlGd6jLFVGC2o0AN3qYhIbILS5f/3v0k0H4/1/4c+R1iQkBrHDCl0qDxrpMyp
	4OehbqSMZlZuG4xG7YW6aHS/2KVB+3G3oEeLj4Y=
X-Received: by 2002:a05:7022:f8c:b0:138:916:5179 with SMTP id
 a92af1059eb24-1398f676bd6mr1477937c88.14.1781702337644; Wed, 17 Jun 2026
 06:18:57 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jun 2026 06:18:56 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jun 2026 06:18:56 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-4-a5bc7db5a9b2@google.com>
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
 <20260602-memory-failure-mf-delayed-fix-v4-4-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jun 2026 06:18:56 -0700
X-Gm-Features: AVVi8CeEQPoqGj6Tm5lqS6hWOuYsOw4ghr_S2X43a6pbnMXpEzjcnbUm6R99GZE
Message-ID: <CAEvNRgE-karT5BYOCePr2mM2hu2AgQ39qhVN6hk=NK+XWcvAJA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] mm: memory_failure: Generalize extra_pins handling
 to all MF_DELAYED cases
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
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3aff0c981fcd..dcc56bedcb28 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1052,18 +1052,14 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>  		goto out;
>  	}
>
> -	/*
> -	 * The shmem page is kept in page cache instead of truncating
> -	 * so is expected to have an extra refcount after error-handling.
> -	 */
> -	extra_pins = shmem_mapping(mapping);
> -
>  	/*
>  	 * Truncation is a bit tricky. Enable it per file system for now.
>  	 *
>  	 * Open: to take i_rwsem or not for this? Right now we don't.
>  	 */
>  	ret = truncate_error_folio(folio, page_to_pfn(p), mapping);
> +
> +	extra_pins = ret == MF_DELAYED;
>  	if (has_extra_refcount(ps, p, extra_pins))
>  		ret = MF_FAILED;
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
