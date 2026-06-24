Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73658261B9B
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339948; cv=pass; b=Rp1P3FhCsroLa7en60OKKP9pQ5I4WWst8BNFMzjQgL2Wo5AxQAtEE12ro3p0WTBstwDAaU7FD86gYgcc48The9kTGS3rnO7DKtXBpxL5dSTlgt7pIXBYTs4uijpg1Berf9cfO4TFncyfde26Pm/Fc7993REG5aY2ughRhKEIjMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339948; c=relaxed/simple;
	bh=RU91htVYuTl4zBdXuu6mQj5pUyKWdyfCeWXJbQ/VXGM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXBSyY1ozbi3+7XxNvHXnFVV7I7IgYwFfPLQhRw1cmvkTMSaWoVG49GBRiK+vw4QYrZRzWgh+hE6QkFc9XiqAFvgvyITj/INGqk/Te3h8ncH2YVy35h63uATth1eeH/ZEmOB5G1ozFJR2NBZqHJCAweYfZlDPxJtiqYdIDJvmqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtjRnL4N; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtjRnL4N"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1363fe80fe8so3137615c88.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 15:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782339947; cv=none;
        d=google.com; s=arc-20240605;
        b=YPUnVEJ795MuCNvDfcJI8wxTlz2OLgvOa4JuM/ggbzFuCrFhGixPPRcOdoEhMyxyDQ
         Ny9sYTCF04sWdkwwOE0/r6E0JN5VmmKMZiIfvhvgIrBlcEHgHdTHQjzlKLnBLudsr+1E
         QwmrOOHzTwCL6xK4MPMZvT0xW++T7Z5qBGToNYzIa3VRmk7d2Byj3ZRLHY0PB9lD/Fbm
         SrcAiKu2Uc/+pY5B4eIADB6qu+sVg/o2UojvdPThG/KJrBDvg3v51MOs6ch1Fewsg6Wr
         WXV6ryHODs40fm4qmK49kxjGAxX6b+IPG6Te515Y6CNxmTgi/7G6TKXZXh4u5Dx8dyCl
         ZDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=RU91htVYuTl4zBdXuu6mQj5pUyKWdyfCeWXJbQ/VXGM=;
        fh=Je9mn1NcbM415mG8toVURbtglH7InKVhcRjHqhzckzc=;
        b=aSVlkYypIYnWvKB7c1RnoZHBVgEEsGxQzYDZlOpyKf4IW7i7QATpNp3op6Vz5VlDgC
         Qko+kF4SYjw+way8FkSv/5ktQZESP6alLql+7idXPHs331LIh5zgZVlsnNkE4fps/+Zk
         GPpDhtZbL2cwsHE4VKDWziNdQRb+fS+c4qlsDi4R+Vx937A3mRVcfNc41Tma0GsKDX3n
         FDFgXaNMMjz0eUh0jwYaM3uLhFeNyYJZ0176EmN6340P1q4ouvRqCUuhczZIYmjrg9/U
         EDKHuB7JD1w1mKPRtIzeR6OArelnDzGkeD7VIEN1suGTPtPky+7YbFhQF/aDLEbqSvSa
         U/hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782339947; x=1782944747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RU91htVYuTl4zBdXuu6mQj5pUyKWdyfCeWXJbQ/VXGM=;
        b=BtjRnL4NLOQHm6ekPigJHihQMZyqkfwE187HWVqOiBGwwKIE1Qk3sMCQzy4rb1uZkZ
         5ZxOJRHjm7M0X/oqUhavAKyEXAjDRI0mptK4KtMIm7/ba55Q0NvWHEc+D1sEMIFaY4Ww
         gzStZLmHYB5rM2R6H07IYNdIqdirzZd0BXAZ5HjHmPdHKRZLSwz324z3ZKutOs9iOUx+
         TF15jvN2D5BytHT36+GapYNvTc/7+8N1f/dBzXSEKcDHMsLe7KLsksLCZ9I7cGIuDf5A
         bFB48Qpig/RVX5NAYFClMMPfjISEPC6Ek9oTsnV/zRWWNWchO145heeetXQaOppkHAxq
         f/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782339947; x=1782944747;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RU91htVYuTl4zBdXuu6mQj5pUyKWdyfCeWXJbQ/VXGM=;
        b=UFGTs6njlOlxVvQYIBBTKfXqizKGMPPQ24Uj+7XOHL851ij+jSNrz08hrSwqGIPQhi
         MwByAbRMoEHbYFKT3FSQ4vEMrJeXu85RQ4ek2cTSIdqnpWKMOLa7gK/DALw8Zs9MzkWw
         /oZA9tgzKRx7Xbpnqx7ciX2yegTQCzJVllGjJhIspzJa8bB8URAZCo3Mj/Q4fH68Mpbi
         OzisRkIDobB/TrcmoVmDSg2VYP35YCEyLTjDk//pT3s/la4BmzLZ4N9GxoTh7HowcT6r
         4CkBZdaR/VZknNYAbW4AhSOxMc7GGWqMaaQFOrkJxsb284D4wjwkHX/wyhIUruJEMBKt
         ohPg==
X-Forwarded-Encrypted: i=1; AFNElJ+h/8d4v+qUdnIVVYya7trNNjE+j2ownxerHTEm2J/BZDV1OJ46Qy9gNW5JdCHWVQrLlR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoU/BMK5b/nfymyJuz/5HbWCXygiqCC7hs1LoCbdktd11pM94
	qVP0FdqxN1ZboefEtKYyd2oJhs7GmaxQab3zSm/DfZVmulCYMGiw6blfKs37QTsYRdTfVS+XYzO
	iVxzynXeICAug1Jp+BPnEeIqlcYMi077bMWsnAPKT
X-Gm-Gg: AfdE7clEpeZtntL5X0S4dOjBmHCZVQt2fDSbE7/zeqz1/ODDQZHNiR0nnWr/iEx0bmu
	sQxi/ETQ7s24EqQHhEmlwZbVjAjLiaqMUYsU/1QdSzv6skMJSBokbjYKWGR4zoOGTTSES6xkM/e
	HeQhLqw3+5FFa9eD0mqZKYyxNtrjFgMdSJccLBHGrbpbh6WKSQQzb3Yf9KXq/JBH1dWGnz3UvZi
	5UdfTQUt9KjKhef9X90vvTXdjCczv+Sd/jayGpKgRDFQfdZB79Dd6Rwu64XuvoJqIVDJ1ByYQ7r
	GENu6WnARhLOIfYBaYsY1CQdwWYc5O4dXD0WybZ2aESbBaj0JoXk+3Xbl8P39Ddnyq9Jew==
X-Received: by 2002:a05:7022:906:b0:137:e6a9:b998 with SMTP id
 a92af1059eb24-139d0c99607mr4114854c88.31.1782339945380; Wed, 24 Jun 2026
 15:25:45 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 15:25:44 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 15:25:44 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajwMYCSrPlxg-Fok@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-18-9d2959357853@google.com> <ajwMYCSrPlxg-Fok@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 15:25:44 -0700
X-Gm-Features: AVVi8CexQH0jh1eCpdBx_tPh-SkjHNyZ1QVX7X8uuwzX2_PG5elQvyIsXuHuijg
Message-ID: <CAEvNRgE8HZDOnexMJeim6TjmxGG1AUXFY2+HH1YyKB=aM6D-DQ@mail.gmail.com>
Subject: Re: [PATCH v8 18/46] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
To: Sean Christopherson <seanjc@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jun 18, 2026, Ackerley Tng wrote:
>> When checking if a guest_memfd folio is safe for conversion, its refcount
>> is examined. A folio may be present in a per-CPU lru_add fbatch, which
>> temporarily increases its refcount.
>
> Under what circumstances does this happen,

It happened 100% of the time in selftests. Perhaps it's because in the
selftests the pages are almost always freshly allocated and so the
lru_add fbatch isn't full yet? (and that the host isn't super busy so
lru_add fbatch doesn't get drained yet).

I've not tested without this beyond selftests.

I don't think we can depend on workloads to drain the lru_add fbatch?

> and what alternatives are there for
> userspace to work around the issue?

The thing is, the refcounts don't come with a label of who added the
refcount so we can't really return a different error for lru_add fbatch
presence. All folios get added to the lru_add fbatch even if they're
unevictable and eventually not participate in LRU.

We could make userspace try fadvise(POSIX_FADV_DONTNEED)? I think that
has other problems, and this kind of makes userspace have one more user
to guess. Userspace already needs to check if the page is pinned for
DMA, and if it's not pinned for DMA, userspace already needs to retry
because of other possible kernel users...
