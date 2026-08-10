Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE951360EFA
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405303; cv=pass; b=DqDjoMLcDxIdEXMCum1d6x0HgtwRS36TFJG3mGwFB8pwme+rF9w6upYrErKpsFORLFHFrFXhwI1AktsGSUCAS671D/0vr0tmmCpUcMXxMdx08VnH16icn4AoYMphCEbyO2UB/HuK15D29BrMIpI1aKb1kKG8ANPuzPg6n5/3x5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405303; c=relaxed/simple;
	bh=Q7a7K8y6K91AYZoCZj24dpjtc+/Iv04y0vXjPDlyobw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bqks+G4hOA4/zAJ6ouTXmPB19zbKDinO//lIyzDYYDRL0bqOrZMWc2wPXQZAso8xYtvBDxr36/mJ7rYLu+yrBnOV/v4FSNw+BUUlvy6BwOAio+jBXqAs7+ucHF/Cc/OQjwd7AVd7zYZx3yHRIS2qvfdnlQsB1eb2k9uDoan4cYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQyPdqP4; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQyPdqP4"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383cb94f742so2677706a91.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 16:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786405301; cv=none;
        d=google.com; s=arc-20260327;
        b=HYxH9qzDQpoDZGYzyKw/IdEmy3PwJGZ0qceqDfkijX0azweoRDoEMP/SlZDl5+OisG
         U6HaoBeyHT9oOmPqcMoFc8C94ISMvXCovcGf5KGRilW77/CLBoUE4Jrp8TuU8tHG0k31
         o/QyO4hMnAbkcyGvHpeNeAXOEK73ZmU99qutI4C2O7BW4vhjAMxypNK3BpAQqH5o7rJf
         Ww2ZXZK4VlTEPUe+0uTCDSeQQLCikyF6zL/Kz+2DY/EhD5LEKseWLZoX9HQQESRCRmfh
         VJJELGuatwuditCVrklqIw/Q2GQg5k0WSsCzTa1Jly0Xm0KEVIAdtvh9BVUtDplAOEHi
         QqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Dp0b2gqcZ26DbJ9BVPOHI0R6Nl9LEyZ50URFATgNWEw=;
        fh=aRzWpwemBlQUqF15DHoE48cb9dFbOa4tHykLeApwevQ=;
        b=h2OnlqVbUSFutKQYcl2i5Ly0Ktb1oBOHf9zRbFuhGGvUhsW/7wZ9cxpIHv4aaO1Lx9
         vbrS1Cp23GkC6bENA/4IChl13f/QDg6FY+e5REroQef2u6XjA/WOcfGUXf2mHKDBtljT
         e2KkMz/Hf6+plQB9r9BvZO18igp/KzsppfheXYH1SgdLPvsDofDqiJhujQI6oW/mngIG
         nlec9RSgyyZewPYz95oUQTs+kXTlPhzPzmvb9Q/851ZmdR1UDBB0jtDBfSA+fHS1HsSu
         6oYvqPjzfh4p08VL58jaYll8z5qNhkEbXf/Y92kgGDLmao2IjGtgDz5TxOzZfp29tQqv
         onvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786405301; x=1787010101; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dp0b2gqcZ26DbJ9BVPOHI0R6Nl9LEyZ50URFATgNWEw=;
        b=LQyPdqP4GZ8lLHBCCdYZFm/N6NARUQf3GUvgiFL7Y/MtLviQbE4D+YA2n/woBmbPf6
         t1Q+/iRZNn5DQt5ybMTXgnIgD/JbG5kcleW0jFxGA/6myHIObPivRzb/NkJUCMBrM3mh
         HIgfNJF/WvY4KWUaqp2gESE+bC74dDkRNKbcItQER1hV75+w5NRjRigkE7inyNwb2FuT
         7yrXn+5aaznLFwHvffVboVzLv1u52qr+j0SdCxdEDOd6UiN8NIwkE7R4D5hHXhvZV+Xr
         Yxo7dYhAz3lRnRlPqQ9J+cZVijp/Hv1+dkNBNGlY4G3dLZJ/mNRSBcvGXOhqnONwmHo0
         7+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786405301; x=1787010101;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dp0b2gqcZ26DbJ9BVPOHI0R6Nl9LEyZ50URFATgNWEw=;
        b=CQfKLA8siHIDmocCd0MCf/KD4T+TdLWAUNZvdrA2upaYMv7X7L+QR+9RgADIsq306X
         /3jRzwy1W+wRqrTOFjE9CUQNUviMGYcwovzagJ73BLgcH0cAvpWHgzWVzaJBlMxBqrAd
         mqmgxrPUlxS3A9B4icYQuV3Z1zLtTWIQ/3Zb7EUFrthHpd1ccVKywmpKRci8vuXkOoej
         Apb6QknQsP7LQxoejl2cFJwzyjbRZY1gQXj0hikoavrUaWiUxmQeCNSVfvo+vqvmDmT5
         lVeLNp8bk7y9UkGybcVOkX6ClZy4nAgITYjdg77s5zVT+UANv4JEbEyhgdejYOeKANuD
         XFCA==
X-Gm-Message-State: AOJu0YwYdiTh1Z3PvTTHwgXC9j+onVFLBq0R5I0mO/aN/pJPraYlnybG
	gY+o3u6u9XVtCJpi7aqljmVz5n5NtOBiUrWrOMZQVv4xo0rhP19c6qAPGMThTGMaYA0eB0C75vT
	4+OrO5UrZA/+9VA5Ghk7pJkGzXvHx9Bw5GtHywZfi
X-Gm-Gg: AR+sD11WOsSroYjSVsSk4Ct8Xy8YG7U3MFOlc/BSibH+iYZH/9tt24KTNYMJwDjCslV
	c7rpBHOkQQcQadTBXggrHfJEo3gnPuhf/EdPCnh1SSot+AsDxhsnFTM8F9wVq/yek/SIAxVO3da
	kKTDuNqVS95uDaAXfScg8Rno5aDkucRjMEcaWUu3XCF+b+WMfHC8oAPmwTIuIus8gfST3j8fs81
	28nIHL2Fi59OpfXZPDoJlJ48B4Z9LWnFETIz4BJP+76C+Ht1a3wiPFCE32SYYm1CpSqrN3Fc4FH
	F1rar2N1Cz4CmGWeCcTJqrLaEiKtUZYyzmBTE/M1EAm3X+7Jqc7qoKeRVUBFObPlOUXciaLkzmh
	uqTDMJHKeLRG28XDqs26260Bi+3zlLWs8H6A=
X-Received: by 2002:a17:90b:268f:b0:38d:c74d:29c5 with SMTP id
 98e67ed59e1d1-392cca64db7mr5320468a91.19.1786405292124; Mon, 10 Aug 2026
 16:41:32 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 16:41:31 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 16:41:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <dd9ebd52-7171-4353-8c83-9363019d55b8@kernel.org>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-16-2fc18ee6d3ba@google.com> <dd9ebd52-7171-4353-8c83-9363019d55b8@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Aug 2026 16:41:31 -0700
X-Gm-Features: AUfX_mw6OlaGLLkL3HyJwIpviYhrAvoZYVarJDuu-bVxocdCtMCbumdkufhLAM8
Message-ID: <CAEvNRgGSK9tO_-TvQvXoMwVwGygh5WjjBUOY-zLOA5yP2DwS1g@mail.gmail.com>
Subject: Re: [PATCH v10 16/41] KVM: guest_memfd: Zero page while getting pfn
To: "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 8/7/26 23:52, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> Move the folio initialization logic from kvm_gmem_get_pfn() into
>> __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
>> kvm_gmem_populate().
>>
>> With in-place conversion, the existing data in a guest_memfd page can be
>> populated into guest memory through platform-specific ioctls.
>>
>> Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
>> might contain uninitialized host memory, which would leak to the guest if
>> the populate completes.
>>
>> guest_memfd pages are zeroed at most once in the page's entire lifetime
>> with guest_memfd, and that is tracked using the uptodate flag.
>>
>> Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
>> kvm_gmem_get_folio() since other flows, such as a future write() syscall,
>> can get a page, write to the page and then set page uptodate without
>> zeroing.
>>
>> This aligns with the concept of zeroing before first use - the other place
>> where zeroing happens is in kvm_gmem_fault_user_mapping().
>>
>> Don't mark the page uptodate again after populating, since the page would
>> already be marked uptodate before the post_populate() call.
>
> The downside is that __kvm_gmem_populate() will now zero+write. I assume we
> don't care about possible performance impacts?
>

Would we rather zero in kvm_gmem_populate() only if !uptodate &&
gmem_in_place_conversion && src_addr == 0? That could work too.

Previously, without in-place conversion, populate never reads memory
from guest_memfd so there was no danger of leaking uninitialized memory.

> Worth spelling that out.
>
>>
>> Reviewed-by: Fuad Tabba <tabba@google.com>
>> Tested-by: Shivank Garg <shivankg@amd.com>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  virt/kvm/guest_memfd.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 030af0855f8b0..41950c8105b5d 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -1079,6 +1079,11 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>>  		return ERR_PTR(-EHWPOISON);
>>  	}
>>
>> +	if (!folio_test_uptodate(folio)) {
>> +		clear_highpage(folio_page(folio, 0));
>> +		folio_mark_uptodate(folio);
>> +	}
>> +
>>  	*pfn = folio_file_pfn(folio, index);
>>  	if (max_order)
>>  		*max_order = 0;
>> @@ -1108,11 +1113,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  		goto out;
>>  	}
>>
>> -	if (!folio_test_uptodate(folio)) {
>> -		clear_highpage(folio_page(folio, 0));
>> -		folio_mark_uptodate(folio);
>> -	}
>> -
>>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>>  	if (kvm_gmem_is_private_mem(file_inode(file), index))
>>  		r = kvm_arch_gmem_make_private(kvm, gfn, *pfn,
>> @@ -1159,8 +1159,6 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  	}
>>
>>  	ret = post_populate(kvm, gfn, pfn, src_page, opaque);
>> -	if (!ret)
>> -		folio_mark_uptodate(folio);
>
> In case post-populate failed, do we want to re-zero the pages?
>

I believe we can't re-zero the pages. When SNP fails to populate it
could be because SNP didn't like the CPUIDs userspace set up, and after
the error userspace is expected to check what SNP likes, then
retry.

IIUC zeroing will destroy the message SNP wanted to leave for userspace.

Michael should be able to explain more here :)

Btw Michael may I also get your reviews on this series?

> --
> Cheers,
>
> David
