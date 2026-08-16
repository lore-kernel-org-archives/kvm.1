Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586FA3E4C6B
	for <kvm@vger.kernel.org>; Sun, 16 Aug 2026 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786921339; cv=pass; b=a65l9N94IlVnkZ76cRWdocDXFNx2s6u6Y4ipyPaC8VfzEbotZgPevJZ+0XUGyGcAaz9vuxY8EFvEnSq2oEm0m9Qffy0JKst8fNQq3Hu+Zq7JZlZU0W9MuT1hwOZE52nmOCdj6D3TduxAkIP1FbClwNR8Z6wLrD4CRTHdHIgGR8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786921339; c=relaxed/simple;
	bh=TfZcEuGOfr1J68VSYUvGJF5oR+xbrzPMOaOCm+qrrgM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZhBU3R2BBBUgxt2p5r3PqZs/Nqm3GwnqzUGhC+ENND3hxSAg+zo21bqo6aerkp0Y3wJ3sQwM8aXEcMaG6LYl5MSUrBJLvPXvABQ0VBH4ftv2HyDSGu9hggqurA4nl0wL7olsR5WIb7k8wSObaqpE0YbZiagvKRdcgm0dSoKlFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBuIbwah; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBuIbwah"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2222727a91.2
        for <kvm@vger.kernel.org>; Sun, 16 Aug 2026 16:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786921338; cv=none;
        d=google.com; s=arc-20260327;
        b=F6XnVIahPPUdFdvRgaU3fOE1/46WogXftKGF+s5u9EToaPgBK16eMArZzRjMqNEQcc
         9NcRWXc9JTNknFpcIJLlMxV7oXU2dmYMzlZ+V+Bg0Nh7RHxy+WUtYLEcEwgxN1We0UYl
         DoZtKUdv0GuW7F9Jv4ElemKAh8uQ3FWXvRMPS1C4w36mf1AwOLh2sCkUzI18HhxydGYI
         7S+qQBA+jyoo4mF+PgzSNVAauredsYGe2f5TZtB/JK0r9OSU9SO+xNwNW2I2sVUM4X5r
         bvTu4mBRHkiqPQOZPxclgjLFyjaxMco6rwa2X6+6caLGcjtYf8SlxWnNlSh/CGIpShJo
         q2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5ZNfUxpi7veRTWLY2tYd3MK6swZzgBzgGr9g7FewAwE=;
        fh=bS0nGujWUbOZRqMQhdSYg5kwyWCGZMq4bB6bkrbde7A=;
        b=jyDcOUhywyDex6ow5ZcH5LvY/PAhSOlMPkS+WZhH07u2+O6rzDVOjihnwa2k0pyHBe
         P4vwsaiTAtdcrB07kvHfdXa4Wyc4NcGykCOi5njN2/4uErPDJRVWyxee+d5WZvX2c2dZ
         CIZPFjeC83IBd/o72QMuFoA8LKi7W3XV/osPWxGu8yg9neHfPMgo2UbvzTuUY+4ejVbT
         eFQaZ+0ULdIVEFyIPtD2e0p5tIMUl1Y4uswbBDBXLHp8koiH3F8CMaF7cB6joKyXqOf9
         ZhKkv1MIx1UfObAwckUg95jRhGcikGKMlv8ZYqq8RLVZwHlUrzubB4vE/Y+hvnAe7WjG
         DOng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786921338; x=1787526138; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZNfUxpi7veRTWLY2tYd3MK6swZzgBzgGr9g7FewAwE=;
        b=nBuIbwahTDk+YN/O6xtX38CC9NT1+mhcKHwDCSJWa4cUFpiAiCiECz8EZtYRqgGr1d
         4KCb92ZcJbRgyBMdE2fzPjjNsosPYKzH77W6rA7f79C1c3thYUJ787LVMvT8QdwFBKbt
         DXwi1TD84u/bsYwIt5li/8rpskNoaBPl3H/HHvhRfwycri1o6Qk68XYWSIHKEs3LWkMY
         SKtSRs1/7SvRKgd0aKtIM97RBwhWiLgyFr2MIstcJLVP6nCHeco0Is3LF3S1VWnWdFio
         xxAtmKuc/sw7WMPEr2xvXKPPorBjZJA+Hs2chq6IjAdW4HwUM7QsKP0tfoD7lXC6HfHk
         GSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786921338; x=1787526138;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ZNfUxpi7veRTWLY2tYd3MK6swZzgBzgGr9g7FewAwE=;
        b=VruGF5FzHkmtF9xin4wmMHr3nsulTmQ7AzsvwldAMa8wqQ8sXCcP2n0OcZp1qKxlA7
         g+O3bgg0nbfQZG3s9j8PfB4FW8Rz+6r8XUSiqKbYxlZJKU1e4SKTNK0XGhCTnMeyHvsC
         CEjPHeFtsGbvecJR6TYBz5ew6/yGZ4ybW3bRJywiAl7q3Pwvct7bg+w0FdUblqZBC+zm
         WFJg1F9S/dN81kH9AK705Jnf40FnFGzFc85qp/MocbS/H7TBdq1XyUsTcQYQUlhy8A1L
         41RUnPhh+o3JtKneBnIslpCyTMdZT74hGr5USJ9PqevEcdygitvzA7MSxeDJhpXXOscs
         YMiw==
X-Forwarded-Encrypted: i=1; AHgh+RoU3G+eqHJjfqpWLye9jJn+TiWaABwfVts1J5NN0PKKQG8OY0Vjq6nqS2ByBF3EK7BKjgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNUjBtP0CVcl5+zX+4gaeki2yMpm/LI6giHJSLQ7SS2o4LO+1W
	w9ba7kgvyUCQP7p/OYI5JxqVSSfe8mAKdSHaTlZL8YaR3iBWEC5WlH8brukJx+g8y/2uDiUkzZt
	3BxqHaRdQQyG7fNbbr/QDJdquL5qRgyPCtpHWVM32
X-Gm-Gg: AR+sD11QUt9JWXZTNb8h1V4k6LSnLSykEUWepjq0moRs6uD7/2G4RJ7eNNsWsQoYwrP
	7Z+0HtpEkV9fDkQxDwkSDUsa8nynQxeyfKThZaYPPF+Azmr239TKop4Or5/Z4tw67z1z+dfCcYJ
	yv9Xi16oVcg/Wx7q37SKQ7T8WwaM0HPrqEvMscGqMQUrkXib+O1n+9AxPoNrcVu9Ox2b6KQ8iwT
	bPHntrf7x1MqhOrlzNeD4vNK0jazg/bKxBPgMq2U/F2Og0sVBMflqsnJEiuhkXE4okWt9H07eq6
	pNLDOu8AnuQSAv5z5S2c1SVtS+SMraqnUGzafHvSekVoumICHeXrLvYCsL2wFTKGwLZni2uBqgK
	8Tg==
X-Received: by 2002:a17:90a:e7c8:b0:38d:adae:4866 with SMTP id
 98e67ed59e1d1-3933bd2066dmr20117316a91.21.1786921336732; Sun, 16 Aug 2026
 16:02:16 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 16 Aug 2026 16:02:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 16 Aug 2026 16:02:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <beecf36b-b0eb-4691-918f-fd39f46d5d8f@linux.intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-15-2fc18ee6d3ba@google.com> <beecf36b-b0eb-4691-918f-fd39f46d5d8f@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 16 Aug 2026 16:02:15 -0700
X-Gm-Features: AcwNN1Va1JdlpRRtXfl-rgaiOwbgkg6rBN2xjp1zNZlzVot1c-IWzDKRKQ6t494
Message-ID: <CAEvNRgGtnQfhCkrWah3jNeivbHCQqRSQEXs=uqJhBmS+GVntrA@mail.gmail.com>
Subject: Re: [PATCH v10 15/41] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

>
> [...snip...]
>
>> +static bool __folio_safe_for_conversion(struct folio *folio,
>> +					enum lru_cache_drained *drained)
>> +{
>> +	const int filemap_get_folios_refcount = 1;
>> +
>
> Nit:
> After adding the helper, the use of filemap_get_folios_refcount seems
> less obvious. It introduces unnecessary tight coupling with the caller,
> though it has only one caller currently.
>
> Is it better to pass the value as extra_refs, similar to what
> lru_cache_drain_for_folio() does?
>
>

David also suggested [1] something similar, please see
https://lore.kernel.org/all/4c638fc5-5a74-43d0-b5bf-d7ef893cb994@kernel.org/,

Please add on to that thread if you disagree with the suggestions!

>> +	if (folio_maybe_dma_pinned(folio) || folio_mapped(folio))
>> +		return false;
>> +
>> +	lru_cache_drain_for_folio(folio, filemap_get_folios_refcount,
>> +				  drained);
>> +
>> +	return folio_ref_count(folio) ==
>> +	       folio_nr_pages(folio) + filemap_get_folios_refcount;
>> +}
>> +
>>
>> [...snip...]
>>
