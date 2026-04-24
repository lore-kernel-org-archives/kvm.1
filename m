Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604A3BF689
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031720; cv=none; b=F3W/4jdC7Oa03kqMDNbapZ6e1QNWs2ocujHfe3akKXrBoE0umWFzIu0wHDQgYm7v+AvTOpeVkYPV8ccWM7S6JDNAOkokLns0TgBqaDOMKZeukdnsW5vX5ACB9Os9lURcponOHrvE7NqnpWYLUYgMScracSfN5hpsWuBqckJn/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031720; c=relaxed/simple;
	bh=NJlVrRT3rKyX8Zx92hAAkUo94p/tcoww3dztI4rs/68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2u1iL2PFty2DnHwMS5cco8nqn6v152bCc48u/Qcwf9qMhNAiFybs4a+VJZ+iy+YkSWf0R8E3DJtP5UxnJ0zbfAM9X59r6NJejzg6x1Uf3cSHCq0oi6pfxIkWYxDovN8Y/HyjLVmOh6lzr72qUPCA3aKN7Pskm6b8/s2QiZkeGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0HeLhpR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKlOJeYC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0HeLhpR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKlOJeYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777031717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nEN+2szXTqM9oTIsUX5r8HOMqWdfRhmjKH5pfjGEKMA=;
	b=e0HeLhpRZEGYs2m++mNc43sQdLDXtnGQELjh6D+uOTXxcPjdktF3BsaOCZ6T6EXWqT8QXo
	r5AalDEE+ZedIgN7LqHGTPZ+I9AuIkJ0IH0vjb5ck2h1btqEtAw/SgaD0e0UIkWRvvkuwL
	CFtoHl2jC3KjW1lXVoJffzW6z3QN3N8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93--_Ag1DS7NPOj5uq73quR4g-1; Fri, 24 Apr 2026 07:55:15 -0400
X-MC-Unique: -_Ag1DS7NPOj5uq73quR4g-1
X-Mimecast-MFC-AGG-ID: -_Ag1DS7NPOj5uq73quR4g_1777031715
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8ee9a11aa75so782185685a.2
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 04:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777031715; x=1777636515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEN+2szXTqM9oTIsUX5r8HOMqWdfRhmjKH5pfjGEKMA=;
        b=VKlOJeYClQ/kyFiv2qD0g4gVw79oOAR9qCfpows4tavsuThP5zUhf5WvQUQChq69xc
         qMdT7Qi8sihRiggkvyZB0mq0Y0KKFxBCBZhlFjArEnCPoSUhZABmiOrEx9b3INenTlVg
         bE12T//5Tv+UJTST8J1fTMx7K0bpfD8RRpRnkQx+giMPWTcsm5meGvQCGfnk0qVRGamv
         FsNXIfC87/h7DASEMr/25OjlTDPB6utLMMDhjHaEMZPHyhZkI+2VHx51Z3F614rJ/onH
         C6N2zeZMt8P+6jWvOZH4q2Df/JRFaR17cE+lRR8j1Nwor5weobleR95TUu/JH2j+Seec
         K4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777031715; x=1777636515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEN+2szXTqM9oTIsUX5r8HOMqWdfRhmjKH5pfjGEKMA=;
        b=bHokYy7+HhlUJNGDHJzI/xTHBITanDDcH+SeX8wnkEBcSKUA4iyrMUS10mDtruY81r
         6sMAmV18HPqcCGRqRe0FKBwkQK2G1KwA4TlWmlijb9I7ygfEy3Nt0WR8PzW7NVL5ODia
         1BV/ar8onLsURIbZc6ECvoDoL/6YMbhl305AeGpJnGadOvaWskFpFAWCBRv5uTDBaZW7
         PnHwvBb5lMMJhtqcfPHfXYx6KEqJgKNkHoaAeiKmKW6sSpg6Xy/B3m78s7oBqykjgK5K
         QMan8Bs/FR/TqIoSunBs1dZ7LgX4TW4poxogzOcu4T3fCGzTxMxuoR8O673SXDoIob5o
         49PQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uaFWbLaosZPqBbN31iVsVuKewsXVG5yBkEYh5Df1sZ+7npG7TUisaIpVM2nbyGEo9PUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+g/Q/TrxJ3Q4FiFuVqtPx5XhZerWnW/AchiVE/0pWLvOvrbPQ
	q3TD2bsp4QNtfgbfn+yOKydKaDgKaClOniW6FdotN9hE58ouA73+JjXPIHEErOLPgKUUa+q9VQv
	I8A1CqmfAjQ/hsnqaVdbsXvVe0m7BSVArUkZZIsnFThUlc8lWys/viQ==
X-Gm-Gg: AeBDiesLf7XE/GOWsUEoTuRX/LdEwCh6aOV19MWRU8AOFVRcRr4SkZWQrXgtYSAjfgz
	Rfm+edZClV2e4zp2eqISqsrL2W3czu8TnMKUFC+65o6qvgPZ32JP7q6VOa5zx+m/oiEwGq6Ikiu
	CN7Xo/+39VMzVv30JK2p/H/y2ZLigC/vfh1UiZz5N3ZAbp2cffDKVXHeKdes8AAi41SDSP5Sj4y
	BhffHDUxUrj/9m3S1IWBCklHRgdtrVEQ7bxT7V5Bel4QLRwG/SI8FatWqYNnOt51I8tZPLiIs2T
	Gp3tHEBOXSsZ0kwyPbhe3Iy1kjH0UFazkSedFAzBdgNELLae/Vm0xyasaC9KfbkrMqGrNwxrT0H
	0RhyKQMTWy+Wg2Net9T2K4D0+8l0tXkpk+kIIHm8PrYG02tFA3LqUYLUtBw==
X-Received: by 2002:a05:620a:4513:b0:8da:358a:c482 with SMTP id af79cd13be357-8e78fa1dd02mr4607937785a.12.1777031715098;
        Fri, 24 Apr 2026 04:55:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4513:b0:8da:358a:c482 with SMTP id af79cd13be357-8e78fa1dd02mr4607932485a.12.1777031714498;
        Fri, 24 Apr 2026 04:55:14 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef12122800sm837694385a.18.2026.04.24.04.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 04:55:14 -0700 (PDT)
Date: Fri, 24 Apr 2026 07:55:11 -0400
From: Peter Xu <peterx@redhat.com>
To: SeongJae Park <sj@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <aetaH3W47iR56nQ5@x1.local>
References: <aeprnnccJeyHB2rt@x1.local>
 <20260424002625.89857-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424002625.89857-1-sj@kernel.org>

On Thu, Apr 23, 2026 at 05:26:24PM -0700, SeongJae Park wrote:
> On Thu, 23 Apr 2026 14:57:34 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > On Thu, Apr 23, 2026 at 07:08:00PM +0100, Kiryl Shutsemau wrote:
> > > On Thu, Apr 23, 2026 at 10:50:06AM -0400, Peter Xu wrote:
> [...] 
> > > > - Whether we have explored other approaches on page hotness tracking
> [...]
> > > DAMON is built around sampling. It is good for working set estimation,
> > > but I don't think it is directly useful for eviction decision. It can
> > > miss hot pages. LRU rotation will also loose info.
> > 
> > Exactly.  If we need to collect ACCESS bit (or anything similar) for
> > eviction accuracy pusrpose, IIUC we need per-page info, we can't estimate
> > by sampling.
> 
> That's a fair argument.
> 
> Nonetheless, there are some companies who use DAMON [1] for a similar eviction
> purpose on their products.
> 
> Also, page level accuracy issue was indeed concerns from many people.  DAMON
> therefore provides page level DAMOS filter [2].  The idea is finding a large
> region of cold pages in low overhead first, then do page level access recheck
> on page of the region using the filter, just before doing the eviction.
> 
> DAMON-based memory tiering also uses it [3], to avoid wrongly
> promoting/demoting cold/hot pages in DAMON-claimed hot/cold regions.  The
> evaluation result was not very bad, and a few more users reported positive test
> results.
> 
> Also, DAMON can be used for page level monitoring [5] and open to changes for
> users.  Actually a work [6] for making DAMON-based page level monitoring more
> lightweight is ongoing.

Good to know that, thanks for the info, SJ.  I'll add a note and try to
explore all these at some point.

I recall I read a paper describing damon tracking overheads when
granularity is small and when the memory scope is large (in VM's case, it
can be e.g. 1TB or more).  Would there be quick answer on whether this one
still suffers (or maybe it was never a problem)?

> 
> I understand no one fits all and the decision is up to each user :)
> Nevertheless, I will be happy to help if you have any question or request for
> DAMON.

I'll definitely ask after digging more into that, thanks for the offer!

> 
> [1] https://cdn.amazon.science/ee/a4/41ff11374f2f865e5e24de11bd17/resource-management-in-aurora-serverless.pdf
> [2] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#filters
> [3] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh#L40
> [4] https://www.phoronix.com/news/DAMON-Self-Tuned-Memory-Tiering
> [5] https://origin.kernel.org/doc/html/latest/mm/damon/faq.html#can-i-simply-monitor-page-granularity
> [6] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.com
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Peter Xu

