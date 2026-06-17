Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E8317148
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724572; cv=none; b=JxX+nKRbrXGxSr+NtfGiFUDo6WK8l2nQ5/FG1Uf7EapVVI+Ukrlrprc5XxAN1DIN8XAOyuZXi+qB+ic7rZe72Q2i9uG5ETBohoxMheyvOKQPuBXgzXZX+rflvC8Aju6VOM+SVGwWf/VQ7txbOBZvD5tR4nE9/BsvYQy7DXCdSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724572; c=relaxed/simple;
	bh=h60NGC/ozGngTkscWdcApkWGD/LgFaoAy319VDmpEOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLcW5oOiLAeMqqXGugieNHHpRSaKmaC228zndOSAj6tlHmhWdMvQpfaTX8GCh8/XQP7aw3Yye7k89daiWxYCkIsh42fvy/7kMrsuCsnF8UjJyL+ul2WnIr1T+pSxGvkk7cv9SCe2NYWBIFi8ToYLnhU8ZoJXJXiY/NPEs/cuxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SbXkQYuS; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SbXkQYuS"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5176465a4a4so1373761cf.2
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781724570; x=1782329370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsWWktqv2G660ewz5kGZOgi567bNOYTEL7LINQXUsWA=;
        b=SbXkQYuSzW6yDrD4dxuLh55rtIeFqG7f8naW+vOPvgVkKjDVuAUjGX3S1MnQMIt0Nk
         RGqm10zSCHZRbo1w63lxqkbLRDTk6bUggfXA5bm+PBbxawTO3HSd2rsPvKv/gX1oNHXQ
         G4nvqw8v/DGyq3bJDWwiCGpZGkWG8A/7wPC0xJpbcZ+29JJEbgOyTclWl8pM6CGGh68p
         Xwrn/k6/4CejJTL+aSr14vWiiL4/eei5yhouq9sqn+itj7pLTcuU1GdNp+wzAMfYtT92
         Lkk2eBsUsJPHOgeaNnUnRzGJL+CoaVKeITTewMY1qPUSRPCKyOXPWUeDNc+HLBPEAQI2
         PwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724570; x=1782329370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsWWktqv2G660ewz5kGZOgi567bNOYTEL7LINQXUsWA=;
        b=qQw2tb3nazkGJZPoG6OSpmOQsMeL/Bmm1xIt1Oqd0cylLsOByomXNyknPuZwvmpICR
         w2wdJrPdJmOWD69qC4RFiKeDoW3LeiYKyxmyz60tBz+0tTnGjYS490VFCs3XQH9ne0Lu
         tp5svPYOFnumjimBQeOh4JkRv5e2lp92w2SNy/smN67wEByQgyxONULVv6MXRQkKQA1x
         hdQBC/amD+3qMK7Q8cEqjJjXvevWnt1i4fKPjLUReJDWX27G8YgTpwM+vJ+dhaF5M2bU
         f4g5gOHLSxXY1KPY7/bYESRpkbfreT/9EhR/OxXLUNfIuS5ckJRuLLpvH1ZkvQkCX8e7
         ZgAw==
X-Forwarded-Encrypted: i=1; AFNElJ/yz1IdXB/3ls7Wj/lc5qIlXgGyf2TKHTuj8Vdpy6kIV3OGYoJxro2pNumnF3IpV77mGVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wej7YJ+o8fko0f4vRh79w9OdPIw8lcdYi0OVQSG9Yk6PyM1/
	mz6dKDiMdECRqgMNwJ68cWSC1MrQKhWRXBQ7Tf3T+4uhr/t2IovlMvFv3WTAnHpfL9Q=
X-Gm-Gg: Acq92OGBZ9TWZlS+NT4eSN5qI8ChIQsji1KRD5gizupfyTNjiYQASuVxOFBe6KUk5Pb
	VSnZaav8iW+xsbc5Xu335TcSFwnoLiv3U+rNE1roIXJXcC6vdVdpPQa/JQOgoAX/xlmcyT8nilz
	tx71OqZJ/diEKKzGSHVzoosqNP4TD7KAl7wH8MLHMwzYwDMfsi/3GJDp5Zywf9m5XKAwEGFSZ/+
	3J4KM07yN9OFUBFtlmMkVz+6sizHAed1Lq3bkW2GDY9956vB0sPoEzYW+P2evg+kE8uiJsgYqza
	5gIo8F7K7s8UrmM2+xNZLlDngZ7NTY5HUTKN70PU73MoQu00k9OF2ZQa7Ptn2kf0JsYFn0gtkfU
	Kvsuhz/e23dREE9QxPaeOBSI17R7grhsyW0e7946ulz1aRYBZuu6p20oi7PGqZy0rcMy2oVLJzk
	LAQzWVBGPCmAYjErb0WPq3pLvLjqWPE2cy7cbWkW9FsxPJ3v6KKRNDAW8rnMYvgzHvHc4=
X-Received: by 2002:a05:622a:a54e:b0:517:5f04:f24c with SMTP id d75a77b69052e-519c6f3e9a9mr5534601cf.39.1781724569704;
        Wed, 17 Jun 2026 12:29:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61e767sm175111801cf.2.2026.06.17.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:29:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZvx2-00000001AOF-2emD;
	Wed, 17 Jun 2026 16:29:28 -0300
Date: Wed, 17 Jun 2026 16:29:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
	Anthony Pighin <anthony.pighin@nokia.com>,
	linux-kernel@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org,
	linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <20260617192928.GB231643@ziepe.ca>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajLontmFa1oRXeoK@casper.infradead.org>

On Wed, Jun 17, 2026 at 07:34:06PM +0100, Matthew Wilcox wrote:

> I don't see this as being something that drivers should be involved with
> at all.  The MM should be able to get this right without any hints from
> the file-provider.  Yes, that means I also want to get rid of the setting
> of get_unmapped_area in ext4/xfs/other filesystems.
> 
> Looking at generic_get_unmapped_area_topdown(), I think we can do this by
> making an additional call to vm_unmapped_area() before the existing two,
> setting info.align_mask and info.align_offset appropriately.
> 
> Now, what's "appropriately"?  I think it's based on length (>= PMD_SIZE,
> then >= PUD_SIZE), but we should also take CONTPTE architectures into
> account. 

The info.align_mask and info.align_offset do need information from the
driver based on what it intends to map into the VMA that is being
created.

Filesystems probably have quite different requirements than drivers
using remap_pfn() or vmf_insert_pfn() that have locked down pfn's.

A pfn driver often has a single already known physical range that it
will use for the VMA and that range should drive the alignment
decision of the VMA.

vfio in particular has common use cases where you want to mmap from
weird offsets, but we still want to achieve a VMA starting point that
has pa % PUD_SIZE == va % PUD_SIZE. It is impossible to do this if the
thing building info does not know pa.

I do think it makes sense that no file provider should be computing
the VA area itself, I think I made that case when Peter was last
working on this. Now that we have Lorenzo's mmap changes maybe we
should be talking about supporting VFIO by having a callback to obtain
the starting pfn for the VMA. Usable only by drivers like VFIO that
are working with the pfn functions.

The starting pfn and VMA size is enough for the mm to setup info
suitably.

Maybe other users would prefer a 'max order' callback and then the mm
would assume the VMA will be popoulated with pgoff aligned folios up
to that highest order?

> And maybe there's a CONTPMD architecture we should also consider?

ARM HW supports "CONTPMD" but I suppose it is not implemented..

Jason
