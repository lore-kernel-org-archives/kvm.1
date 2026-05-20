Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46144370D56
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309335; cv=pass; b=Gr0FHxu8U9GXGdQzV14pj33UfflobW9VsWVIulwxBf01hhvKQfEcZ4lCwZzzYLTvPgXjDxc9Y3E1CkaB4w7zRhU0cviiMbzuVba0Yj8q7zqa7sE+FqTmTcu7zXPwPfQHX/sSJ9Tr+zsEUfRNqAaLG54lirWEaDxfRjhr3SOrasI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309335; c=relaxed/simple;
	bh=UfnbwtuocpefoEJwGQVdq2On9IxQDWbOXLMcN0R2rQ4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvvbTFBYSK7w2a3MqBKVA7JlD15OuHrnomsmXOfxwIpOGPctNn5Xi2sspjPKW6mz1HO3J/RhWQd+xEfJDgXjLKzwQGiO7AXQejTDmh5laegnn0+tfx40HeCIzwZTOfpKWPMY3Kk/thWGLgSq2bPP93wydREu3BheSNYS6n87BH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUUtZQSy; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUUtZQSy"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so6921702e87.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 13:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309331; cv=none;
        d=google.com; s=arc-20240605;
        b=NtqtqwsKbbgOh7FAuYKsaWVCH5vJzalairUrKtsVTikon8C5Mk+ZPzGhubMZ3JSXBF
         Rh5psHFU6hfeSkKOKGxXfYqs+9Em7dLMoeZIv0VLGBPd1i0OmOLld478J+aluJ+0fqmz
         0kj4zfrusIld9T88l5y27AnFXlIxmUFVe56FZyWHPrUIchxoQbmR51pQC/Ipz4XnEW84
         4BX5fBredwHQ2BHTaUTZupaCXJQbjkMMncrRn/9drBEOKFabzWlAI97pSmVtSR1Lkzi1
         Km3Bc2Y9spIYBy387zh08As30kXCPU1W5eUQDYympFP7qlqvz1FuAa7PlUvv1kSiVyPj
         I3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y7Uhb594XOL1gZOtZrSL5VavWJB1z/5+87hhs5G/QCo=;
        fh=p4uFTietEQDMUWCMyrc8m8v8aY00nCW147k4NrBQjfA=;
        b=JyH8JsnjsR7CobdN3rIrKfo5452mqu0tC2JnMXrhELZp/txwmzWfYpBnlBMoLX0Mnp
         g7M64DQObD5Fu3rZHl4ZusV3eAhE0d/AcOPIS8Hu4SbdoI5cWdRvoZagd+rsiIUFLElc
         r5kG5nU86CSHjFpVeYqc2Mu0KLAg8Wf3i8HqmqdIn7BLBiiuAVBBHjZTHHSoI36uQaXa
         hrR3ed0+nve5eDN2NadxU3Dv5MqzY1+00E4b1IP1FqcNThDXVR/RZf/bML/XK+3D2idX
         r25qnh2HmbNbj7hI+UlU0A8Woc+nfPtqg9UPaTy3rdPEk9AoDLcZAffWp2Dh5eUR06Xr
         c54w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779309331; x=1779914131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7Uhb594XOL1gZOtZrSL5VavWJB1z/5+87hhs5G/QCo=;
        b=bUUtZQSyucw0ZiahrlwRi1nayWMYp3PHUWX9smKeB2yRk/7jTg4SN0Vdqe5ybWd4Aj
         zdaX86CmYV+ulIb9h5j+jckh8afuCXP5n+ddwtFyebE/nM9pll7Hm2YbHp7z5GrChMJl
         fUgOOx6NOsDu/yVF8BR1zwQYBCV7QrnCX/IFKHb6UlrVGbBgE0SE7LmS66vnz+Ttolvx
         DsvisWioCK0PHRKC669oDeOsUiGlJXxqt/uhw1OiuB9JkCBTdw7ZbE63sPbf+WIf3g56
         kK6CkvA3/yzCOY/LfAsn4cDaO4zIjmT0qmBbQTtItwy3g39l9mkz5rVhj+UB9JNBnaFQ
         vxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309331; x=1779914131;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7Uhb594XOL1gZOtZrSL5VavWJB1z/5+87hhs5G/QCo=;
        b=pvMea4Z1JQ2EKiq1rg1YMv+Kx4F6MA80ovEMa0hpd5Bq9NlhbphCN480oplFiUo3il
         V2xqGVcvkwjFYMaa8NMBlG/yCvXtnw8ZVy8QUcuDDbgZ3Zk7ybygqLck9XYA8JLZxoU9
         qo3YbzF+cM3hYAGiWQatA/sCfVb+hynMjOZRXef52HLv6dFBdNJaVn1SvCpinua9Bc7p
         4eBk2sPCQkZbi18hA+tIHl5/ArVygrgqaY6I/+1s6TnptbJT4VHulGUXlMEY/ffvGw2V
         4WVc8Udgd2itA/xbLr477ktTPmXAijclcu9YTC/Y7Y14s6k3gK8F7/ReJiYecDfZSGAd
         ieQQ==
X-Forwarded-Encrypted: i=1; AFNElJ96pWz+WcD7rZZKeOuhcyYx/x5iR4MmEE7IR2ucl3d/kTMybVd3b1VsWSLNyQ9mgOwYXNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XRX6TCysF+9OHgZXGfK++M3hFz7n8U2rVbM/2FDGN5CBg2iD
	ZR1kch9SiiEecpx33fF9yOMo935SjbsA7ftUo4h7BatZZ0oxN68n9YrqqbCqERxZIQrpe/u44au
	nlLAVgKr3E9v9mKCBkIo6drH+EccWzQL0O98gZPop
X-Gm-Gg: Acq92OHGCmKClQlBUSV8Vp2Q8V3sIejinWUrg/fS4uInDq9X7AtsPcuy3XeY+4M1P6c
	mmMxJvRHGAYUsTvOh4iClbG4y03pjZQat4ao7J/JlmWZcyPmrF8XXcb/n72bhKUwh13Yf2tc25r
	xHGma0H+W9YtGpB7t0SCX8I8t9d6+zN9LkyBcqJGdjestbinkjO7FVHSBru+1xgV5utMz2ZRpxq
	3u9F6dBMWegwCsVq6fmsjxooV+AH605qH0lSnVHnbeJDKrdjbgeu7EQIIWfXs8cLWtmbAyMUf3p
	pyew2MmagVJgToBTuGV3HazRO/2VMoMxq5zFv+BLXtaRpWToqZjk78DfyUgPLIX7YKiVREo+4vQ
	pWx+M
X-Received: by 2002:ac2:5b03:0:b0:5a8:8818:819c with SMTP id
 2adb3069b0e04-5aa2ba8d0a4mr6125e87.16.1779309331108; Wed, 20 May 2026
 13:35:31 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 13:35:27 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 13:35:27 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTwOfJ=nCRoX3m5uDt=CcF_zrqGsZVBBmo4MscmPqrBxOA@mail.gmail.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-12-91ab5a8b19a4@google.com> <CA+EHjTwOfJ=nCRoX3m5uDt=CcF_zrqGsZVBBmo4MscmPqrBxOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 May 2026 13:35:27 -0700
X-Gm-Features: AVHnY4JCI2WxkpGpEfiZH45uIXCVj4Nb0JRb9mme96xXqvKAS-EEsMTVSDBkz1s
Message-ID: <CAEvNRgFqPSLKKKb9etgfqdt0y81Agu5RwRipuGw=j2y7W2Y0-w@mail.gmail.com>
Subject: Re: [PATCH v6 12/43] KVM: guest_memfd: Call arch invalidate hooks on conversion
To: Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
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
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <tabba@google.com> writes:

> On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
>>
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> When memory in guest_memfd is converted from private to shared, the
>> platform-specific state associated with the guest-private pages must be
>> invalidated or cleaned up.
>>
>> Iterate over the folios in the affected range and call the
>> kvm_arch_gmem_invalidate() hook for each PFN range. This allows
>> architectures to perform necessary teardown, such as updating hardware
>> metadata or encryption states, before the pages are transitioned to the
>> shared state.
>>
>> Invoke this helper after indicating to KVM's mmu code that an invalidation
>> is in progress to stop in-flight page faults from succeeding.
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>
> Minor nit below, but lgtm.
>
> Reviewed-by: Fuad Tabba <tabba@google.com>
>
> Cheers,
> /fuad
>
>> ---
>>  virt/kvm/guest_memfd.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 9d82642a025e9..baf4b88dead1f 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -603,6 +603,42 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>>         return safe;
>>  }
>>
>> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>> +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
>> +{
>> +       struct folio_batch fbatch;
>> +       pgoff_t next = start;
>> +       int i;
>> +
>> +       folio_batch_init(&fbatch);
>> +       while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
>> +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
>> +                       struct folio *folio = fbatch.folios[i];
>> +                       pgoff_t start_index, end_index;
>> +                       kvm_pfn_t start_pfn, end_pfn;
>> +
>> +                       start_index = max(start, folio->index);
>> +                       end_index = min(end, folio_next_index(folio));
>> +                       /*
>> +                        * end_index is either in folio or points to
>> +                        * the first page of the next folio. Hence,
>> +                        * all pages in range [start_index, end_index)
>> +                        * are contiguous.
>> +                        */
>> +                       start_pfn = folio_file_pfn(folio, start_index);
>> +                       end_pfn = start_pfn + end_index - start_index;
>> +
>> +                       kvm_arch_gmem_invalidate(start_pfn, end_pfn);
>> +               }
>> +
>> +               folio_batch_release(&fbatch);
>> +               cond_resched();
>> +       }
>> +}
>> +#else
>> +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
>> +#endif
>> +
>>  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>>                                      size_t nr_pages, uint64_t attrs,
>>                                      pgoff_t *err_index)
>> @@ -643,7 +679,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>>          */
>>
>>         kvm_gmem_invalidate_begin(inode, start, end);
>> +
>> +       if (!to_private)
>> +               kvm_gmem_invalidate(inode, start, end);
>> +
>>         mas_store_prealloc(&mas, xa_mk_value(attrs));
>> +
>
> Why the unrelated extra space?
>

Hmm this space provides vertical space between invalidate_{begin,end}
and the STUFF it wraps, like

  invalidate_begin

  STUFF

  invalidate_end

More STUFF is going to go here in future patch series, such as splitting
private pages in TDX.

>>         kvm_gmem_invalidate_end(inode, start, end);
>>  out:
>>         filemap_invalidate_unlock(mapping);
>>
>> --
>> 2.54.0.563.g4f69b47b94-goog
>>
>>
