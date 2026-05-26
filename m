Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88D35E1BD;
	Tue, 26 May 2026 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783715; cv=none; b=Y5Hojz80Uw5diP1AVXdcoDkx9gLQvs2VA46ozCpFWlEqq9sqRC5JfdKamOszshh2UCzTEt3Vg9YPTl79cy6l4MxXUpUnbboOVWaGlgR0ywyY2h4R1qzDRFWMTsf5AmRwugWV0/ZYvrMIPAxppwWkMZVrLzGPzCaddQjJICWm+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783715; c=relaxed/simple;
	bh=06O6vLti/8SGJM+uKs+UJJY3EUyrxns+/tXRJg2/uLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7oWdV2ZcQXLy28e3XyEGCjTJy2LFMt+7dp+HBR+VB/FkGWr/XvJVbeKH3KSMuvd0VpcCZy5T8sQrCkM08QwkBjKfaWirxAr9u0oi3USvtn8K8bB1DZ4EransZVdm+j8RI/iqf19AWdUyyxtXGXm4qV7I5EG9TVAd5IAqtncGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=EbSZoOB6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=furBzsQc; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="EbSZoOB6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="furBzsQc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id CE9D01300098;
	Tue, 26 May 2026 04:21:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 04:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779783711; x=
	1779790911; bh=wQjXxGFL5Lg67GSyDSM6dyIeupTs1FKFZvV2GOAivr0=; b=E
	bSZoOB6ff9yD6/VEnqTMqTzIFIge0DRBYape1xA77WJbH68HHhXCNQQevy78b/5s
	Rf/J+X1CJ461tvRk5IwaWTb7X+ml/aA55f0Mw2E9Obs2zmNaN6dvIFiursq1//2J
	Z+c0OL5Dg7frIjM6UMugBgi021oy3flGqxDidMRpbGcYCtjrAwlKsjCTtmvfPcCL
	1TTcfR+9oNdk+N2fwIXJW05luI3rDdEefK6CND2+aCX2QM97qlncn91sCvqcj8TQ
	cE7cEBh3LzbtmtaNFo0XR8ezRaiej1RQbtdz7G3jF7/s4LjJElQqu4JzMvMV03Y9
	0w32sxfKVvl0sQyM79Okg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779783711; x=1779790911; bh=wQjXxGFL5Lg67GSyDSM6dyIeupTs1FKFZvV
	2GOAivr0=; b=furBzsQc1Q4glZjGfRj6U97GnnIbyE7KdPKCsClaRU7r/S8O2Zn
	ZBqkE+p4Oi1cyypYt4K7SPcYl3GHWM+vcss94wbMfcmoXXfBej33LHI5NIcS46bI
	i8BC2L8ttC6LI+2+AM+0tRYg0adxdRI43GsGrOc4H7vshUtqLhdQKcxt1Dy297JP
	HuYDqtZWASEqyAH6LZfUC448OOS58BogHTzX6oZ2Cqmv1COvJp3RyycK5Ct3G+bS
	frY54sNqw9qVWfRUHvAIq+rx67MjlZKhSAFAdPtlzkJDumm0yQqmusFdv8DVGprL
	ArphrYaamLkD49ciIEc2rw/z9rmvJ6nhYgQ==
X-ME-Sender: <xms:H1gVahWEOl6lQaHH5I9-6Y6sQFAUA_lBCmGO4U0d615pNhOVxo0CMg>
    <xme:H1gVap-jTrAh0tuLMxPN-6CthtN9If06XsY9Ic4P2QA_Pc0zV1D0PqhLDQii7BFDW
    zzHWrocheAIDm8-t93kD-mvxs2Lxzd8i3cFDgUIowNhEsk37sHyyVY>
X-ME-Received: <xmr:H1gVanrKRxJ3h_ACpKSNg_0pRqzuNVQcDy4m0mPBOMGb2XUrv_afVUMfF3tMQg>
X-ME-Proxy-Cause: dmFkZTFVRF4ROBUmcM4hrH1rPz69sP/HFNDpACqKIdo4b+hALyZE5EaMnrNSuoBbpZNyB0
    nqeUFxhnfH+dLhiV9z7ujtcLPqsdJDhF/oYhZOfD4dZFHr6PPfvVj58Gvm4JOLxXnyKsPS
    sJ8Fhto7GS92EsPkmf30kDQzF+BdauRj/CHeYxvZTekBZsSXcKJ2uLhyPskML7OP/LintN
    W5UbK0ONoP65MQKF0161Fr7z6DSeT/aMoulLSZ+gOZaye6pXnXHnm9hyCPCV+3HxzO9TuT
    /6QGJlCHh+MuEiaxBoHdq6q8m2T2yLDq45K4OxKghO8GogTwWUPj9R1gBbFKfQ8GKhDPGK
    kieU3s1wgChMWdmysZgtYhacCwJjTE/z57h/dYC7VuMJJTJAr3umOnbTD8ZhKeVAK/8cEh
    ZR4+lpAEkWVcbRA8G9r1Z71w6ZTTqAxEIckACVYVv/xkElv/EHY/kpdclqcZWOam2IF4Vb
    QGTWLQQrkjtaQI7UUgvX6OATkjzkWsQS3xb0wJuxWecYWD4UsKkSIIsd8DZ/+40Wm0CgWw
    NR+fZeeA5kkK0hZnUX+G1qT7RifK/4jMTSucw/o05SGvIwUGMjZzxhKvoK68ucoyXPcYD3
    8ou43prSxxZOBDrMrSjdtEwtbG/73oyest4J1o8bggBD5gYBkf5re1j1axPQ
X-ME-Proxy: <xmx:H1gVao7b0dRVl-PnEE8BWR3TTrOqxqdR0NW0urHk8lYblgLi8MAIRQ>
    <xmx:H1gVao6Oi4mdwVYQ_rApI1rzMc0xQlyRtZAmJ7BK24PvP6r61D0J9w>
    <xmx:H1gVankmwyqJGA90XZ8vNzDxvZDQUHeCMoF2dwRfBU9NTGyMuWBngw>
    <xmx:H1gVavj-wl39pOMFhQWI2MabbWxzdmAg5Ao4cS-wHFETDcT2u-UB9w>
    <xmx:H1gVatC7sT6FImTCQ_qXttStSS38HVnn3YyKeSYgNdKJ-Qx-NiJVQ559>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 04:21:48 -0400 (EDT)
Date: Tue, 26 May 2026 09:21:44 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 08/14] userfaultfd: add UFFDIO_REGISTER_MODE_RWP and
 UFFDIO_RWPROTECT plumbing
Message-ID: <ahVX0DXLhqo912j_@thinkstation>
References: <20260525113737.1942478-9-kas@kernel.org>
 <20260525121111.E857E1F000E9@smtp.kernel.org>
 <ahRoPjww-xTjjl3O@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahRoPjww-xTjjl3O@thinkstation>

On Mon, May 25, 2026 at 04:19:43PM +0100, Kiryl Shutsemau wrote:
> On Mon, May 25, 2026 at 12:11:11PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] Page tables are accessed and modified under mmap_write_lock
> > without first draining per-VMA lock holders via vma_start_write(),
> > risking races with concurrent per-VMA readers.
> 
> Confirmed and pre-existing -- the pre-patch path called uffd_wp_range()
> which has the same gap (no vma_start_write() before change_protection()
> either). Will address in a follow-up that audits the userfaultfd
> register/unregister paths together.

Looking again, this is false alarm. PTL provides enough serialization
here. No change needed.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
