Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5138734D
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875022; cv=none; b=er3Gd7WX033Wc7aU+au9gCSizSr3DugBjGzH7rL+lh039rYCFaIqvgTdGDR/pBPMvnK4i1b9Vg3D4qg5IqUHEKkrFYWQ1oj7RQHbWN/hQ3u6yFhqwfwE7KIKiSGa3l0e8HFhKQkk+sd3AVpjc2NyEJD1XJjo66FAieLMpqbKQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875022; c=relaxed/simple;
	bh=d74VuPv51HM6qqQdsAJpS0oOjrN6rqzlsUg+q5PK+9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts6wV7far9NRSChYijcLQ32TFjIp0EFZ1/NVJ9hlemO6rqgU+qiu0/UdOtcTMbA7LkZZRXJp0lJM99fjhY7wZU2SlFB2qbAGwBK2jaEdKWoJOqPoN4o/eG4PRxSsdaakV9kfKovTPJ5AjYIRotx7h1Fkm11GT91GZw2YbU2auIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Oq63Fmhw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Oq63Fmhw"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-915ab38ac14so280155885a.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781875020; x=1782479820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejIXCVtWJLl7FRI++hzl2QTJwTEMZ8h29eav85XZ9+E=;
        b=Oq63FmhwZ8BFdidlsyg6EzfckItfCBcXUxP70J89HWqxxKTxj3pN+AbVGyvApwyfKh
         jDZgVbqvtPLRNZvF8uAwJnfHnNW5gQFicEPamcvdLyG/0YshGPHA7Mkxa7rHBGHGNwSV
         qPQgnwZ+lQ5+BXYHEjjhpXl/1K6iKfcj3YZrvSCZ1lW2zNDFfD3R4Q2/XohyYr4k/VrF
         CGQf5WvB0o/JjHFeBpfiTzOOq46K/91evBRjferI1v/TmkX0JnuITN9QHO6Twjj1zeZ4
         TXlssna5A+bPyQ+x/1OKpq38h8YgViycCworEW8iRdyTxE5ar4EunVQ7xmlzVIO2ncYy
         ZWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781875020; x=1782479820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejIXCVtWJLl7FRI++hzl2QTJwTEMZ8h29eav85XZ9+E=;
        b=LFhauRNNQs9Gb800dvGdp+xH7lqqc0j+jkRXfpDSd1Y5BzaBzNDQAd0AlPb/ht7oab
         77Idd5uihuHlGns9GqldeIL5ErRlceBBcceAl5oXie52jy3/ubxECvnCq5uABigq5dJf
         DXiBYC1l6b09K0HBiodBT7tePcn4Sh1tV7SiLZFWy14tWiSwzM4/6NyIHUWnKwzr/BbM
         BWkrEUcAmFUV6L9b6pvr04SC/+rb+ht0TOmwylXlg/yfc3n3WVHx86IihoSJoaWHoUX9
         wWVfsGOQqCIBDLWZG/JOWYpev4fPOABy7D/P0PB50z1MmMM1Daq86aRg8S2obmP//sqC
         b00w==
X-Forwarded-Encrypted: i=1; AFNElJ8b1SNc3rgHTSrti9YiZhuARFZYOMVB3v0zbVWIUJhmcU5HV7lQG4P24LQiuUau45I0at8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8dWP4fpL/55FYz45dRKEBW21Kt2hup+k0W6g3vTdvOrFJ5GAg
	cpo1hLUrMEZO8f8I31biDa/AjGx8kF40DQvliO9L5M3jy7OcKVitQa6ublJwI/Yn4uE=
X-Gm-Gg: AfdE7cmB6gRFpXVuft5OIS2fcVF9Zl92sxYSj0Kj4n8lK+Ys7hFQCAzynAqA64q5SX+
	mJ7o9bWRf9ZYJDQkvXO7IBi0wkGl8B3YWwTp0qigPKyz6sT8z/4EMVODLd1dxbnEtl8UVpEdw6E
	Yq8XdxSU3CO6kNGncsvPdCaCAspkzM5HME/Gt3m6KXDe2txFsWK7myLleRvY3YeBa1y2+nuiCRN
	vknXqMo8+b7ljGpJsJ0g0n1haWIwXMAt8oKp48QvVnW5exRg7+TCg0wZJiMPPO0GuR27mx7Cb5q
	/NLuVmHmFelqlaWz/JY1HdvmPyoe1ldceDa6lKZ9bUmkqmtfjpYRQEm35UfanoF1R6qShqMHTNs
	98hKbU3zzcSyX02UVic1Azeib7iDs4B3vDdaCCIS3RXt79FKM85gBiaeJB+y555/Hunwuh1CK7X
	Zv55LTwi7KcXxu1/8PVjWPBX8nSOIL+g0g4HpRyC9uPntbjIy4Hpcl96+DD0ypEsj6zLfwsoNvw
	7YhuA==
X-Received: by 2002:a05:620a:438a:b0:915:4211:baa1 with SMTP id af79cd13be357-9209139787bmr522382085a.33.1781875019899;
        Fri, 19 Jun 2026 06:16:59 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a133621bsm235489985a.11.2026.06.19.06.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:16:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waZ5e-00000004YKj-2eO9;
	Fri, 19 Jun 2026 10:16:58 -0300
Date: Fri, 19 Jun 2026 10:16:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Anthony Pighin <anthony.pighin@nokia.com>,
	linux-kernel@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org,
	linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <20260619131658.GA1068655@ziepe.ca>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <ajQI5jMJpxyNZCLN@casper.infradead.org>
 <20260618153049.GG231643@ziepe.ca>
 <ajQRY7tHShCEz8vg@lucifer>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQRY7tHShCEz8vg@lucifer>

On Thu, Jun 18, 2026 at 04:56:06PM +0100, Lorenzo Stoakes wrote:
> > > What you're saying is that offset 0 of the opened file might correspond
> > > to a PFN that is not aligned in any way?  I had assumed that when trying
> > > to do the mapping of (2MB+4KiB to 64MB), that the offset specified to
> > > mmap was 2MB+4KiB.  But you seem to be saying that the offset in that
> > > case would be 0 and someone needs to know that it corresponds to a PFN
> > > that is misaligned?
> >
> > I do expect that the pgoff space is usually aligned to the pfn space,
> > most drivers do that or could be improved to do that. There will be
> > some off cases, but maybe we don't care, and VFIO should be fine.
> 
> Some stuff has weird assumptions about pfn=0 at start of the range (DMA for
> instance).

Do you have a pointer? I'm drawing a blank what "dma" is?

Jason
