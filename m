Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8394334C5
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397349; cv=pass; b=u2nMj79gwcwZp+45P/1AXY7o3xryVlO5VWiAm4+drcBlnxNSOorqsW1gjk+xZVZ4BpnPYAD3XgFDeaxdGtxysNZt1FT+3/cC6FB2kU63nwIvwryae1o1NMDUWF/gIeraZMAMGT0/WOByPFbFZRH6bJmS5Puurmkjml2tViJ0yKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397349; c=relaxed/simple;
	bh=wN+q38rdlKIr22xrGQOunHcrcy7dQztjwHhaozPCfDU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIU6BXFvQb/J6S+DZyWuAWcaEOZe6U7XFu6vMDyS3YCs4wXZBMRCiaiXkrE8LcLCfsLl5lK1inWH5oUOuQGiMDeA1M4CKksJnsKIZgX8DSFgj/fwfoatSx8fGqPpGJweTYaw5vGVgzCSTI9hljft83ZL250dwdDa1TzRpWsf1NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sc84Gh/R; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sc84Gh/R"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cad8076b01so1837065ad.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 14:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786397348; cv=none;
        d=google.com; s=arc-20260327;
        b=mFf9bStA60FqnOEETObeE5o3pGjCv7hWtC0ExxXv7aCIctzXXMV+64tivzSHRqodYP
         ffUw0dDSOWbw0PRJyEETgpvKaRwBIaKJ+/VhoKjPCD1vAOm1umvpspATIHZcX+YgmHTu
         CJJI/ZAeLyy++QrAvhcQD+Xe3MAQsuLDsR1fvgRbEak+PzYfo5r9+hciraP0ts2k6NUD
         lvjIX83qj2/nxJtaqp/zIY77+hFCENYBxMYIleikqm4ybO1L8c4kXDX0m+9dvLhs4BxF
         nJ5yM5c4Yzi4ghMQKBuwKnksnmBEPBmb69sH2roQ7FxAnzi+kSPfG2F7sSpxosYxRYpH
         c8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wN+q38rdlKIr22xrGQOunHcrcy7dQztjwHhaozPCfDU=;
        fh=XB7+OGhW2mpX+a7rx2onJFTx8SeZ+m8/Qf7ZqhpB8a0=;
        b=iHpOn/mY0Tzl1OwS2gzIH8DFb/VV5kGpFi3JQJYet9NHeAlIa+tMtY5r+5T0h3RVqt
         EdIi8ZQncUUeAmx1YAy5TSA45T3LprhndsM6Bvga+KfPBmug6EkpiGSJp7wWNKISN4Oj
         EIhLZiwKyMEjgx3l1vKSTg4HDNOgz2Kb9dG/ui1F/mPM8yWyPVaNNyRncmzlxQWuKoDK
         LmTr7SvJR4tnGRmZrQjdgI2R+gvGAfunKIl7S1uMPiTAdbUXoR5x3Jw9mWhpsmxdLCn+
         JYXjuxU785UH4OhIkToPr52ZKJ+XQXtwoY+NCuU1gs0d+EugtLbnNPwHiIJw96mJj16o
         Ga4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786397348; x=1787002148; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wN+q38rdlKIr22xrGQOunHcrcy7dQztjwHhaozPCfDU=;
        b=sc84Gh/RC1fJT7FD4YKcWetEE7zL2nWKMj/1RSzjh/2nFq5aLkn/aYPRwl3ChtRsfk
         63ATih+/9geGVWmXhhQ+VEW8HK7suiKvASQfQoPC6JNmfrHvthl5vVxBr/HGNDwHzPAI
         VOWDGUeT6zemAzczPO8rRe2JltFMRTdBi1vluKQkS/cYOZfhEmbtsvSv+r5JzCk2E3RF
         Y0qS1GZZ5Wc1jhctkFQk+rjb2TTdPEZZCBneO3xv3rffcilua5vGRNfI1F9gPhpOgUJQ
         Gvf5du4fbcIrY7Tc+sByKjOs7hCsGOi09VBnQGOJccJjpbUCK2bk4SVwLf25NgGaLslQ
         lc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786397348; x=1787002148;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wN+q38rdlKIr22xrGQOunHcrcy7dQztjwHhaozPCfDU=;
        b=NYvkQIqG7OYba7gcDv9nwQcsUmLrao6bdDz5EiED4c8JkG2XK0qqaSRbpiRFcbdFLa
         pbEFFxCH4DcAPx4IYKEJWt0HifDfkRMFcKlzk83NdSluG/03JE+snKNx5Yl8AEad2UhA
         hU2vulxjzTxBUSMdvcmnRqRXDv5QqsQ7RYSvngEIQnrQoTHFPujS+9ROiJXiRL+TDQin
         7mnDKs+prXXeoOQ+I8MoxveRwBsxEOafkp04z7Jlv/XCaenPmllI96KvbTkPdcbpKAIu
         AbCxGODq7+ffe0d4Voi0VLIXmB2H8L+8kl9a1jKKnWJerW5Z/sW9b241275ASA0UILGy
         zaqA==
X-Gm-Message-State: AOJu0Yzjb4iUfLoywD+oK+lrf99d7fKavyNOOUVMWUouz0miHNtu6cr9
	Ts7xuyzEJoafV+n8ik8Gg9oo/brWxF7L4qC7Rq6TwBAJtCbGrZdk0JMuyfmJ8qEC6k+ljBK/shg
	7Aw4vAF58hVwYM4wFkHYEHQJnNWjX7n7fneQ6fI0k
X-Gm-Gg: AR+sD11wTT9/Y8VL+2V0L0zC2QpbLQUCMDTTeCIleJ9vmmtg8TGnHV1wBxPyIz/CYe1
	Y8hQrgkeDxIE2KNCIE1LsdH+l0V7Zg5HOL51pQyrHbvXSYatlG94ZdjwWhrjJ1coGbVO98Eo9aF
	jJ3qpNgQU64Av+zZ1AKwR6eghJLiMkLuldkrqCPSNiZ+FLbp9TqnTDyVZgtSLKHhx2zhilLiQ4w
	ZFufYCMVi53NcEb1jWhuBXZKd7T4GCi+4GjK7MYsFmSZLOdbCsbZ+ZflwPobgyObRcHrx8g2KLB
	B25PkWTKd4x1WoWqTm/VElWpsoFgQKCmRH0H9gSeaqGK8r0hez3NEhiQChLcK2YNQQY9C6LSR1S
	WfhYuFUGZf6c5Tq9cVu5htftl4/YNn9p1GwI=
X-Received: by 2002:a05:6a20:4321:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3cb85e6689fmr49405061637.18.1786397346906; Mon, 10 Aug 2026
 14:29:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 14:29:05 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 14:29:05 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aa545680-2fee-468c-ba34-cc9beb16f4cf@kernel.org>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-15-2fc18ee6d3ba@google.com> <aa545680-2fee-468c-ba34-cc9beb16f4cf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Aug 2026 14:29:05 -0700
X-Gm-Features: AUfX_mxwV4sMMEn8xD5iLtETNHGAZsCJNscksNcNQT60_O-j0WNrenHXqsrVJ0k
Message-ID: <CAEvNRgFSdddvuT8ZJUPOC9BCAtBgx6Vk=UbbPZ0nTAz8M52dSQ@mail.gmail.com>
Subject: Re: [PATCH v10 15/41] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
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
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 8/7/26 23:52, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> A guest_memfd folio is safe for conversion if guest_memfd holds the last
>> references on it. Any other references on the folio may indicate another
>> user, and guest_memfd cannot convert it to private if there may be an
>> existing host user.
>>
>> A folio will have extra refcounts if it is present in a per-CPU lru_add
>> fbatch. guest_memfd does not actually participate in LRU, but
>> freshly-allocated folios are still added to the lru_add fbatch for batch
>> LRU statistics processing.
>
> As discussed, what would happen if we mlocked gmem folios? In that case, they
> could also have been added to the mlock cache (which we treat like an LRU cache).
>
> But that's just a comment regarding the text here.
>
> [...]
>

To make sure I'll get the wording right, let me know what you think of
this (will replace the entire commit message for v11):

 A guest_memfd folio is safe for conversion if guest_memfd holds the last
 references on it. Any other references on the folio may indicate another
 user, and guest_memfd cannot convert it to private if there may be an
 existing host user.

 A folio will have extra refcounts if it is present in a per-CPU lru_add
 fbatch. guest_memfd does not actually participate in LRU, but
 freshly-allocated folios are still added to the lru_add fbatch for batch
 LRU statistics processing.

 A folio may also have extra refcounts if it is on the mlock fbatch.

 These two known "usages" of the folio are handled calling
 lru_cache_drain_for_folio, which drains both the lru_add and mlock
 fbatches. After draining, if the refcount is still elevated, then
 there's truly some other user of this page, and the page is not safe
 for conversion.

 If the page may be dma pinned, DMA is obviously using it and hence not safe
 for conversions. If the page is still mapped after guest_memfd tried to
 unmap it earlier in the conversion process, it is also obviously not safe
 for conversion. Exit early to avoid unnecessary draining in these 2 cases.

 Provide a drain status to only drain once ever while processing a batch of
 folios.


> --
> Cheers,
>
> David
