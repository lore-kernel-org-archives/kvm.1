Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861220;
	b=nZnZxQxwH9Km+6zKvgn805ExTVzQfxxhBpRDIfFAQ8PnhCbXRpTrU2zUP3HFwaIAEhfd
	 Y/SGSy+vihAGnxiolP15+kZ8ZfxFdcy3xIz5YbrLFdIMOsoc8EB4w1WWqkJSGu3AuEHQC
	 suQQqls4r6Hp9XB5eOnqKbVd/T2CCYOwambfvSw/w3aMXWW0EwLZOfyfOb6InJl+sPnol
	 +tgiJBDoL4zBJRiYpTDOwvV8E/meu4kRWs+nVhzungY68nNCmsHw8zsZFzUiPMxou7EOP
	 f5bLndmXBTVKIXKp0M1rRM9k5yz9mlq+sx826dEUGzUuUOdSm+9f/x2r+ys38dpksZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
	b=0JE2A3ccjt/Urhu6Fe6jzoUn70BHpEgQJkQ8qwqZ9lxHwP5oNVtxbfzOJb517F4YFRry
	 weSCoGyDgMXaToNpYAwcLfaBCKU3CfQdfW+4TvkpL4noy38RBHOByx2A6VJyHGw2j1a6X
	 VOyD7LY5odSF3W9mBTze025kvcx5B4PF1jvC5CV7E6KpRiiSNA3ow8fPgqguWUEiBDKJ9
	 xq95gLavOIve8aAUOstsbosAj0YGmACoRwXldHC4+6qOdAonvj7zVdj1mewFdnGsVm80i
	 ttUPPx1RTZcz91uJ9IR1mCb73mFif1EOoJcAqSEoTrq6aNrCHrJJrsjsYFvUUiKKrhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=W8qlgedU;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C9606A33F
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 20:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B3C9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=W8qlgedU
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f20b304c0so449914985a.3
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 12:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794861219; x=1795466019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
        b=W8qlgedUXT2a/t6lhLP87IFTcy14JLKYa/mLodRolDlr9xZZQGxtW5Noy7E031dblU
         MZyTiD0CS6csrzNdM/y/kT9cZThOJzBfJnBjyuudT36134JK9rL5Y+cJlR9PkLw6In16
         I1GQFmpXC+GQjLACTJo0WVW99izKDBVRyEpioO38WVT6BB7yoB56iiO/mZo9HLJwUqYy
         WRepiT2m5sdFzS0WIaIky8pQ9PM9gsPwA3F1oZ8AlieRWNRm9qrQr3NdwmjMdkz0t3US
         NP5znb8aU6kvol1hpUX4T2gg8E0YcF+imIMZKWdgwp2eC1/JJZ5bvYf6eHZddNlll3GG
         nyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794861219; x=1795466019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
        b=e1ezkZEoCleq0Sy2nQ9BRwxU2H9IJYIzozGAg9viO2axPKkKfF8CkXFiVzwUZSTZGZ
         4u5gXRZPDYk1jBatdA12t2VcHfnl0f4nHEkIZc0Zv0thbuiPZRJSGwRDfTvZxfdJAfP5
         vi5L1y54PauOCq8nSW1AgEROt44qOTuw3hjQ9Krt9pHiJ94gNrFzXuWDVH9t0lzxQzW8
         vQ78yxZTkpxaeuXjhgTNyVq9+L8MLrZ7SKpE9BG4DGw4hFC49KQzl5MUNjeSUDKMsZ1X
         M5iS/4DPngPgYaN7DAk/QbkDYewQYUW05Fg827XfEfnp6ni+NpA8LdthN9RW9QOHDmKu
         iQPQ==
X-Forwarded-Encrypted: i=1; AL+hErHsqSpMjNT48MN7ez5u5FXreP5Djw1YSX03/ZsLcf5Tuql0ElQ5eKchgJ8ZRWLGl2pLdms=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nNOo/KLBykCyvxHa7bqnPsbFKP7q6PioCOZGD5iFHx+TRwhxX
	BupQMTYMDcr29sdL8GAeZLLog12jPXJpZYJuxAmMiQqE0XqOKwdMkkoLliN3x45HHrE=
X-Gm-Gg: AYBFou3Thpxq0yNRl19+gBcniioHJ2jNmAFn9U0pqFZzfFGRHOfA27LmykMt7sw9WSF
	WogVSyuPOmzh1jn7P1LkUdZwzNTniopD4sW/SSfFwpiyrtSPy5wXjE8oTpJyW0E49Xre0zlkclq
	1yyILXLHigaR5jlNGOIP2i7b7T92Je7TK9B0cmtwWqwRfpBSmxr+p0yiHw8va+ONL7eyCVOKZ/y
	mJiEbRU4jYwV0bkmNRU46dP8NI20bDmyLKIUYej5WF7ib7WiGz56+z2cQ2MRfvCgM2F5HigNHMT
	Wwr7+DfE7KpUK5j6m92VjyEWr4GkubpDyy0oRXS9JPem6uPVsdptWf6u5G0IkoCfWNuZph6QI6D
	HJs+QZ2kxzWam24A9lqefya1n6lYhJGloHQc0dtEBr9wc9MoyYkP+m+W8tssNAZehVSOdpBdTSB
	fZgJA38jks8dPAqnTFMrWE+C+7jpM0602SQm72GcI9TP0HM4+F7L+4j5rDao2SqZFCx9EOEpo0e
	/rWYZfuiI8x6hMu27N11WiD17aad6U0nYszd4JN+BwMLP1sU6An5XZtcTr1nxLUfIIR5b9Y+QeY
	ICtjhQ==
X-Received: by 2002:a05:620a:46a6:b0:949:733e:ddd8 with SMTP id af79cd13be357-949733ee766mr1034555085a.54.1794861219140;
        Mon, 16 Nov 2026 12:33:39 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c804f9esm930800685a.11.2026.11.16.12.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:33:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT3OT-0000000ARJs-2rZa;
	Mon, 16 Nov 2026 16:33:37 -0400
Date: Mon, 16 Nov 2026 16:33:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
	will@kernel.org, linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
	mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
	harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 5/7] iommufd: account the hw_queue page array to memcg
Message-ID: <20261116203337.GA2481588@ziepe.ca>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
 <20261116195213.GF2452510@ziepe.ca>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116195213.GF2452510@ziepe.ca>

On Mon, Nov 16, 2026 at 03:52:13PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 06, 2026 at 09:18:27PM +0800, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> > 
> > IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> > that a user supplied queue region is physically contiguous, and the
> > page array for that check is plain GFP_KERNEL.  The size comes from
> > cmd->length, a u64 that is only overflow checked, and the array is
> > freed again as soon as the contiguity check fails, so the allocation
> > can be repeated concurrently: a 1GB region costs about 2MB of
> > uncharged memory per attempt.
> > 
> > Every other iommufd allocation that scales with user input is already
> > charged, and the pinned pages charge the mapper at map time.  Charge
> > this array like the rest.
> > 
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> > ---
> >  drivers/iommu/iommufd/viommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I'll just apply it, thanks

Jason
