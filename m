Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793985931;
	b=gmV2grW50YkDudA8srfIf9qEwrh5vqc5jZl9jcHCZW10xpncVrUlllz4IkNbtbAVbfCl
	 D1EpyO530deUuPWY63udZXZ4DmEEbSBU999ts+xVXCRbq8AAklI/d255Idmlby5meKEfd
	 m0V77wCdQVLmKGn59aZiuIDjX9NsPscxGFL0D/Gp3F2lOmow75FMxYk8TuqrihkN1S0AD
	 kzPjcs61dB0xwmgxr56og/5wlc66FS9pMVDNDwox+Vfi5MK7FwDw1IH3troVDuuIXO6/e
	 bJdEDpSTBMkI/99jwYTVug07O9+JYPrXP3E6KWNoNeFA7UyCOhAUDR7DHJiWkemXGmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
	b=1MbCKRZWxmWdNz8Kv+tPsquDPdaMCLanjMyIsR/PAxfe58BblLbHu9THXNU2ll79HkLg
	 UKvsWXZSJQP3nVqr7bHY24JWnRyVoocSKxD8BnfzzZW7QUJ8+ANO5t79rh4EP1SA37JY7
	 XI6KklVRjjJ1UX5HqGBj4FGof9869a+JKci9dKKgagl8GbY2RIxNSxBnnNw3WhWkawLTM
	 1WlVLton+UEdwY992cpDvAsEas0KfmpT3l/87UwwEHD8mjxlWbWs/R//fMWxt9UFbe85c
	 XjkoOnysjGeacUiOVO65fOrxH3+QjI3ibBvZIPN1HojsFDUvoQdzET4q7KH88HIc9Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ewlCk/lT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6189D606A331
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 17:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6189D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ewlCk/lT
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so1385e9.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 09:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793985929; cv=none;
        d=google.com; s=arc-20260327;
        b=p2g/As/p//9AAmfw7rPKh7RICMtsLCIWzD1S7DfDHTW2V7mzYnk4YJkBFG1kL9r9gx
         WBfZzqyS8pToLHU3ntsVWF6woZHGnzK+2LN6+fbBlGhnuabYP4Xj8Olb9AjtGK/moGec
         cafTF7o/PSfSPzNaUa7A9HzncUD3bMeF9xtyCOOQwz4BBSlUWPfwWnvoaJU+dF8BpR0c
         FTCimMPQ7KiunjIDTAvhw2XhKWCYJBXQSxnd+D9Qrp5xu/I2k3G8eZzWRejGPThEhTeu
         mNWBxd5H78wO8yN5qWMUtwXxsDJhpPpHizc9HIasf7IKWwzhLTD8kM4tH0ftoTq5Jsyq
         VeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        fh=5PY7r8cARfYGgb97E9Y41f64ziqvUQAnATSbtJwrwlA=;
        b=nXMbyhg5WGRgVLNASukEPR1AzYfLWgTsOuUxTbhVWydQDazlGIWi7+sE9VJLcEhlX5
         LuEdrAQc1M/v/7VHLS3OLTItSIl7puT870n1+jTVZvArSZMJAuDHV0QYEuVWgUBVibzc
         BqQb2S+CwfJiBTmFZitkeLmfjNGH62HfEmI5zhmHQE/glAhVkKUCqD9scx5WYjCzD+R7
         u/ysUQuZIHLm76Q2G9hfgUDuBZzHWFFN4292LclYDbFVa5VKcZaDju9HappjAwnBr4bX
         RycbU12BsUVVMM/QElL4vc7efB+ozLEVYiQzsvVJC4jAWga/D9l/RYUZYB4NzCFMYQQO
         g6bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793985929; x=1794590729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        b=ewlCk/lTPeKUbMBQjEFxdvXeSJcIPNy2WZqd3RMZR0f4utguz18d1I/25cveVMzzFo
         RT7lseKNhSlQDjNcDMIS/DhwPwUeEMuf3p3QA2SuaR2YWynu3cJ86aMi1V+rohgW/ueU
         wdYBRPMGl9NpfqRBybmsYTfqpJAAsq2YUA3wBescnBCrmLOck2h5FL8JtaVfjtntUhMa
         atBGAqnYj6CPAyn1iWAem1TaZV6cbQ3Ry89bYsb3Y3ddSg87IS5+y0t3k5n/93i7MVsR
         kOjiJQAHUQ9kOMLGGhlfbBtqgDPKlex2gLuJNJ4aUDDAFXSR7PLhJYKjThP1OZfQlk1U
         nw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985929; x=1794590729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        b=N6fk5i4+yAkmkiXnIUMHx7Snuv4ATOwz19p50pqhsmbVWufGgFKMs98IBMJRJD9lWs
         +DiC/ghi7CczTXjHjaoTu2mZcBVqlC7Yy3M6eoMrvzee9NFOYoumfUKZ3+1wCvO59XeS
         aZ6atWRq7lfp0g6I9TURLipFcd6sdABVl5AyyGQY34vurXr2yCskjQz7/pFILgT2V3bq
         ATPUoYRFLMN8Yzw+vQ84ZROWsNQg8adpblylWOpwBzqEOWmTASWUBh5nRZu4tjbeTofZ
         XnceBDuewuunCUrPNsnO61BeIk//cm3djH92EOhgkMRmciAij7FxJiQftOEUbBupp4ss
         cxzA==
X-Forwarded-Encrypted: i=1; AKwUvBxhfDW3kMKpH7HCFyHTMuXjmdrjRxt5W1FdxSu4NlSe6L3p8awusyrRCbn4kYibVHa/dwM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aCFZh8GNiC2TyAAuQdbzVoNbPOTgV0SLHlVpnPIIemldUydNz
	jNl9OsG7yg1hmx31VlFneKdPq853F+nMovoP+XxOicb1j7eflfEHdEeEkoe6jYgrNac0WVOaAhB
	u2XB+6xYMzuqlCDE5VxH85RF7zL8t7lNJdrIm1y0+
X-Gm-Gg: AYBFou1xaXdap2S1iU9wMHQ7qCn9+a+tmaYLcmdR3BRMfU+vWD/P371XkQ5CM1+o94y
	JGh3Bevf3YUsRbxuyzxaabZ7B8lW1YYZsEoYEnmGubE6Nb2e6ZPVzOKr8O9GulJKJn+e07V18M/
	0xfbUF0ShfGPW69ksqwe2dwUUc2LY42qzYgdhOVm0MAQSDNkFkMWJPnCGctlSBzQP8qtR1sMZz9
	mYQM6JT2/NN4TWcJx62/E36ANRC3Bg7q+Da24jLdZ/RSTf8lPx+Uf5GffmaLiPTq+5cB7IPONm8
	/dvwoovYdGJl36n5cNFc32/4fNHfpElqXAfDzkKqFebWL/9U7+9nOfykqwCa6mTF7svnq/WY45D
	ZeTUeQBW3vqtMs8iPtm1zl6Xe8/6nBmCsNiOahxknE+m76Uey4DTJqMwMeOTbzzO/z9Dd4aFuuu
	iyxrbCzUEKmJVqQl9DZPdoKVlyQlnu02u9a9lStmg+crm4
X-Received: by 2002:a05:600d:644f:20b0:4a2:a8c:22ae with SMTP id
 5b1f17b1804b1-4b78a315689mr14125e9.12.1793985928307; Fri, 06 Nov 2026
 09:25:28 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106131829.3228926-1-cui.tao@linux.dev> <20261106131829.3228926-3-cui.tao@linux.dev>
 <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
In-Reply-To: <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 6 Nov 2026 09:25:16 -0800
X-Gm-Features: AclHuK_zmhBLd-fBLwMoqE-7QVB_DAT0nisVVyTe7VWHd67XlQDn1ECR61povKo
Message-ID: <CABdmKX0nCB2hT+iMh=BB-nC=fUBPof8YvjvO-gtEw+zcHZgvZA@mail.gmail.com>
Subject: Re: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tao Cui <cui.tao@linux.dev>, akpm@linux-foundation.org, dgilbert@interlog.com, 
	mkp@kernel.org, loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com, 
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com, 
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca, 
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org, 
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org, 
	phasta@kernel.org, joro@8bytes.org, will@kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com, robin.murphy@arm.com, 
	mason@kernel.org, aesteve@redhat.com, harry@kernel.org, vbabka@suse.cz, 
	cuitao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:23=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 11/6/26 14:18, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> >
> > udmabuf pins the pages of a memfd and hands them out as a dma-buf.  The
> > data pages keep the accounting of the memfd they were instantiated in,
> > but the bookkeeping around them does not: the page pointer array and
> > the pinned_folios array, both sized by the buffer page count, plus the
> > transient folios array sized by the memfd folio count, are plain
> > GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
> > memory, and size_limit_mb defaults to INT_MAX.
> >
> > Charge the three kvmalloc allocations so the creator pays for the
> > metadata it induces.  The system heap in the same subsystem already
> > accounts its buffer allocation;

Only if the mem_accounting param is set to true. We (Android)
currently depend on it being disabled because system heap buffers
don't have a single owner for their entire lifetime (ownership often
changes immediately after they are allocated), and the kernel doesn't
have the ability to switch who is charged for the buffer memory quite
yet. Albert is working hard on it at the moment.

Could you update the message to note the mem_accounting param pls?

> > the data pages here stay with the
> > memfd.

memfd / udmabuf is a little special because it uses shmem for the
backing store, which is already tracked by memcg under all conditions
(except hugetlb). We don't currently use udmabuf, so the lack of memcg
charge transfer for udmabuf is not an issue. But once we get charge
transfer working for the system heap it'd be good to follow up with
udmabuf.

> T.J. needs to take a look here, but I fear that this might break uAPI.

Thanks for looping me in Christian. The buffer allocations cost
gigabytes, but these metadata arrays are only 4MB per 1GB of buffer,
so I don't expect charging them to break anyone. Leaving them
uncharged is an accounting gap though, since someone could spam many
udmabufs from the same memfd and only pay for the memfd pages once. So
this change is ok with me.

> A lot of the DMA-buf resources are intentionally not charged against memc=
g.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>

With the commit message updated to mention the mem_accounting param:
Reviewed-by: T.J. Mercier <tjmercier@google.com>
