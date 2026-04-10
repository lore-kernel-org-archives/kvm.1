Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882823AF657
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859244; cv=none; b=jVSl17s2p9uUs/zrXlk6lhnkAmNzuDbMrY29nmJxCvXZEKoDuzwHETtdFCpF7dDV4qca2ntJ9CFwRFzaLvzQxtw8EwJlajPKBXEnXn4TYFuGtd7AboyqNCFD2qSWKiY+2EAOOQkbwcUrY8nVd4PsfZFCTaadmXkbk42y1RCkfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859244; c=relaxed/simple;
	bh=ET6mFTHOo6wnlNTCkc0iNUgWyvCGTQ6doGao4UgNNdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM9+YRjnZFmVfQp1lyuYwkB8ea5ZAeJjTBK6cJ8m4aN3nHkwIssgnyJMlTsiTSErrYf07cA+XNHIfm3Wp0DDRXHlmwVLGXlWDQThnzNf+KXoNNoazFOnzX4DpGzvAQaxC9XIOS1SdgGbF6d/3StFCRV7B3pJAzlAFQcXevpWxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mY9jr9My; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mY9jr9My"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12bfe0ae81aso26657c88.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775859243; x=1776464043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nkby0p1S+URUi/N/OLJoRbgH0B1BrgPxmsmng2j8o1s=;
        b=mY9jr9MyZuqG/9Lp86AoFHOhLo2glnayJF32TR9d1uG6vOrbzURporzs9/BW6bxG4S
         qT+Tr+BQpFZbsLb2qdH96nOgRTq2HHNEZnYmcJcYEKL3MqChaOZOYwWM+S/hXSvWYZ92
         ONS6KXpe6RWZ2vZPIPqNOyZfdg/Deshc/uFOI/FHEPVOm+hLjxxRFXcCWsRJPvnIWkE0
         mWj+zlYuOlVL8qB5l3cTbfVCnfgXCFfCxPS13x9OpUqsQzDptz7R2uVq3nwE8rah7CEh
         dKaGeWqqRNhe0oSv109hRWkHOo08/ByxIFRdRBY6IMcNTYHAcKWRgtHXXcYq44fXNNvr
         qnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775859243; x=1776464043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nkby0p1S+URUi/N/OLJoRbgH0B1BrgPxmsmng2j8o1s=;
        b=PWv7J2pcHgduSUAb3BOqwkx+smsTjPllMFoGLSsyGuZpfj8vKTb9apXSLISKe4RFg3
         18GYnhv/0aM9M8KU0KbWQkuUwa1QvZ0ZQV/kprO2n+jWpLpk/SLuAUxPSuDfzgl0y1bc
         K6ZV01nvx5uqJgip6c9iIoHcqWafZWFPU87oTYKnBsVIdos+XaNwk/FNgzJK733/PfG7
         zuMr/AJUsn55IqFufSmoIKlLogaa/K6uyYxYbky7ZHo9diqru1Ln5gAMrrMus7ZM5K+2
         c7T2kgJIGd76CVGZqxZpZahM2iXkTlVv0KdaYdQ+OhoGdVfjX3HjzuRIDCNGMZV1G0xx
         HNoA==
X-Forwarded-Encrypted: i=1; AJvYcCU9TUQ+pHmApxMs1OJOTqt0YQZ9JzPqRnEcgC+3MB59O4UhdxKlcmMAEO22ngeH7NY/p1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxON8217qBTvdiGcVqcaLBl08xLvulz7S/gtKDSIik/osiBu5Hj
	0AxWCxgPc/d8g8je1+b1WzyL2/+aCMyNb8BJodyteY3FP+d7XrRO3lNTXGIE96zFqQ==
X-Gm-Gg: AeBDievW/yA72JocVNuk6gF78PxlVHmB1AUAw9gjOG4vCl8UWO0VyskKQ7/ukVvncbf
	5eXLBhhJN3cihic3fQlraO/P128sxjY5k+BQJa0mnoVygiJkRvt8AFmMGK7WSg7RxIJCtBxDCB8
	AwAB7BpVyr5+3TQ0TppuL77c2USbUctqaFTW8cdZzhPZcYCXlz/TeMRy3I/ZI/z8QZHQC8bPUvH
	y/NeS0nbxbLVRzH67EiyyFPIom2TkXZeaG0vqG1XHPP0GEMLPBeRMxXz2fvlnkqkF4IZak+pW0Z
	eHaX1ulzjuPAsPCaj55pHTvAitMFSLZCsKiAOPG0XROMlkLF6kHdxlr4YdJNFCLsHKMV8nKvVAo
	BX6NIHnBn8v9LPoUyOqztfla/ZNn/DSZab1oCSj/ucydcAlMaTWy+S+JtSmTocUr774UNsg02jY
	iYGiZPVioFTcLoXgvn9GRS4/asCZJZ9vUHxex7Y6ORw5fs0C53xSLWVFqYPxXRoBq+tKHckaFa
X-Received: by 2002:a05:7022:660b:b0:12c:635:82cc with SMTP id a92af1059eb24-12c28efd0d8mr412864c88.22.1775859242046;
        Fri, 10 Apr 2026 15:14:02 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5621d7d2esm5922507eec.20.2026.04.10.15.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:14:01 -0700 (PDT)
Date: Fri, 10 Apr 2026 22:13:56 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <adldbL7MXjjn19Qx@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <d3wmnc43r3mir2emoitj432j3bfdw362dqmkvywa2qvu5tskb4@oqjkseil5i54>
 <af4h6wh75qdvgu27td43ndlxdyb5drq2pf7tssdsln3q5gce6f@6su7ylrgomhz>
 <ab2Dkn605sRbpK5S@google.com>
 <ab2KDEatYbSZJVfC@google.com>
 <20260410141355.GU2551565@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260410141355.GU2551565@ziepe.ca>

On Fri, Apr 10, 2026 at 11:13:55AM -0300, Jason Gunthorpe wrote:
>On Fri, Mar 20, 2026 at 06:12:28PM +0000, Samiullah Khawaja wrote:
>> > > > > +void iommu_restore_page(u64 phys)
>> > > > > +{
>> > > > > +	struct ioptdesc *iopt;
>> > > > > +	struct folio *folio;
>> > > > > +	unsigned long pgcnt;
>> > > > > +	unsigned int order;
>> > > > > +
>> > > > > +	folio = kho_restore_folio(phys);
>> > > > > +	BUG_ON(!folio);
>> > > > > +
>> > > > > +	iopt = folio_ioptdesc(folio);
>> > > >
>> > > > iopt->incoherent = false; should be here?
>> > > >
>> > >
>> > > Yes this should be set here. I will update this.
>> >
>> > I'm wondering if we are silently losing state here. What if the
>> > preserved page was actually incoherent in the previous kernel?
>> > I understand we likely need to initialize it to false here because we
>> > don't have a dev pointer for DMA sync operations at this low level (though
>> > x86 uses clflush).
>> >
>> > But when is it set back to "incoherent" again? I don't see that
>> > happening during the driver re-attach phase?
>>
>> This can be done during restore_domain as the domain has a reference to
>> the dev when it is recreated. I will updated the walker and add this in
>> the next revision.
>
>The only reason for this tracking is for DMA API debugging. It might
>be better to just remove the DMA API from this path and use a direct
>cache flush. Then you don't really need to care, the successor kernel
>never writes to this memory so it can just free it in a normal way.
>
>Otherwise you have to remap it on restore so you can unmap it on free.

Interesting.. That makes sense. Since these are not going to be written
by the successor kernel we can keep incoherent to be false.
>
>Jason
