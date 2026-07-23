Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B503DB328
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847404; cv=none; b=SO2fIG47mcYiFadiQK0eFnEpdF2b9q15N7qceJ5iOgf3BZ2rijS3+/3r5T8YahijxSKrhIW5Fu+Pk0phcZcgp0cBfsiYWNpi+S7wQ5fnNWPKUm/h25P9pkxM9hxyAV8OM6YDPcem9bSWW8+fqyE1TVmV6LBWrFjWJahoL95p0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847404; c=relaxed/simple;
	bh=cWf66b+vhjw0szDxSVuIc1pS6p0vCZiZkYMfI3opvuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYdRuIK3HhEwVmFOBNtjg7R+bb/oeQ4iGBgozEF07cF/V3tZphiV+SjOsnuvIBXkxURI0bUxrJ7ciWedh0OaWJeYplsTxXvNwLj3OgfP6JiQf2OXqt3jIe0jYbWadyr78fw64/K/njDUwMtDUdJee6dcVhpt9ssgcPfywHlyZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qdCR+21E; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qdCR+21E"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51bfa429aa6so9030531cf.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784847402; x=1785452202; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpdYfO2GUSLBiSa6MSguWwX6UOJE2iVOhfM84BSexIY=;
        b=qdCR+21ENo9CFDxmDS8dh2Fy/SwcNVq7gj9yzyMIrRy7RUP8SII1jCOVgnr7GlLtvg
         sHs8Ymoi0HFEjvISk5mwy4BzS896qW8KdzoU8cH7kRKT6vhMdP6TbNId6KYXU/mI5M2M
         NIErgvI4/t8bMlW1m9X9tDq/bnaEtTa6e09WeVXCFNov+HbE+u47ldmiSz9J/DVU6rnx
         tYgcSAs3KkqjunEcxMS7EV9xfLuKbHjv/5njutScKVHtmACzgaDMDUp5UsSioybcdOHo
         UlCJZ9sr+QwfLkAUTXOtzJjv9lAHpyYW9OWTL32qVSfrNJgt1dMFkWQX1qSojEktU5zD
         QuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784847402; x=1785452202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FpdYfO2GUSLBiSa6MSguWwX6UOJE2iVOhfM84BSexIY=;
        b=Fg8RQEmknecB4T4fRxOBMZ2XdJUhBXEDubF4DkO84WZqg9dXPcXGX6CstsG3ybcL2w
         ccZ657AgeSwTDN3KYgXSXuYunxKyqsKn03GvQEEBSnzuBjEeaczKes6mvt9qyUc+KHi1
         OUZmhKQ+jvRx4MbD74V3yTK8D/kAq7m6mfachk/4XhKj5abNdNiQFeCSnYtA6ILbpnZp
         Vx5pnPq2ECN35wVjQW4cCcTp0DVvZ1gIBh2SkIvEiDiCUxfxl1GMoG92ym1Gi9RYC6yP
         0S/JtfdPHksl5YnM0cZQejyYWpPf2m5FPojPe5nSh6eNQOoH/pZ4rYVI99CjHCxDrAcl
         BI2g==
X-Forwarded-Encrypted: i=1; AHgh+RpNfo+rpE5Dn28BvCXcT45eAWKcIAVf3zrX+3zgQLxWaYp8H5AH6EsIPvrdKpU9GSnMljY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypf3iNlm3Y6YoIsRe44jxx1jmWLN627guzeG5BgELoTDBoOc0j
	DdrZ46NKKo/tFt2Ny8QabqORMD6/+rteOn543wmZyDgxM2pF5CsZwKiB7uDRXkJrQ94=
X-Gm-Gg: AR+sD10/9YDQq3mkPGN35qLe+PpJ2ADMdb1RpXBrg9CpZ4Vxm8RVvv4GWqhnMPmZAGp
	ZXWcEPM2Tw+Ayu4HVKjkgLGSWpoWmxlf1q/5JvYqAc1AkKVe1H1642vI5XFyoNcwjl+KlCfZDFu
	qu6DA/x4SxHeLPwCsRmywY3P4xCdNEG3wNnOBynLqV2iKv7dsLf8shsKmRjYzGPk9POIEo/CFF6
	7yZyUkJGX+2R0RSppPvkPyJ+HiCTTPofzacEdL89+s9DWtjGlOZrX5yjprCyq5inYIKOwo91YFr
	QOWMpTdIuYmHl9Nkq9k856EOgsVQ4fhEbL2R532CHVcfIUFGwzSPevGI8jBbR4qOtJzuLlwHZl5
	JUXIvj/MP0LUy7Mh8icKYjtoI91G1UbAdQPaQO/prBI8nXRWYNcl1uljyOJbdGo8HZDDiEHLsud
	v/0MLeQDHv8vMFA5LrI+cJB/uC9HwZzMVW6jF7R7EJrM/8MaANyCUFMEp1Gg==
X-Received: by 2002:a05:622a:353:b0:51c:f8f:13b with SMTP id d75a77b69052e-5283edce92cmr47173041cf.23.1784847401808;
        Thu, 23 Jul 2026 15:56:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b5d70sm54929666d6.4.2026.07.23.15.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:56:41 -0700 (PDT)
Date: Thu, 23 Jul 2026 18:56:36 -0400
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Sean Christopherson <seanjc@google.com>, Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Neha Gholkar <nehagholkar@gmail.com>, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
Message-ID: <amKb8sBroYNOiZhy@gourry-fedora-PF4VCD3F>
References: <20260629163337.1264881-1-hannes@cmpxchg.org>
 <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
 <amIcXrS7nGX-adpG@google.com>
 <amIrDncrL4K-JRBO@cmpxchg.org>
 <amIxyy4Vg_TTE8Y4@gourry-fedora-PF4VCD3F>
 <amJKOPczNMb96NJv@cmpxchg.org>
 <amJQAs3Bm99ZR_sF@gourry-fedora-PF4VCD3F>
 <amJgdSXxFk24e94p@gourry-fedora-PF4VCD3F>
 <CAO9r8zN2mPsFiRTPYOPTq3gTVZwsj5hODke4asTTY-jXpSioxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zN2mPsFiRTPYOPTq3gTVZwsj5hODke4asTTY-jXpSioxA@mail.gmail.com>

On Thu, Jul 23, 2026 at 03:30:52PM -0700, Yosry Ahmed wrote:
> On Thu, Jul 23, 2026 at 11:45 AM Gregory Price <gourry@gourry.net> wrote:
> >
> > Walking this all back:
> >
> >   - MPOL_DEFAULT is the default policy
> >   - numa_balancing=on means enable NUMA_BALANCING on the defaul policy
> >   - shmem was broken and did not respect this
> >
> > Johannes' fix is correct, and there are no additional changes required.
> >
> > Users enabling numa balancing while running KVM with shared regions are
> > not getting what they're asking for presently - that is a bug.
> >
> > They should get the performance hit they're asking for (and then either
> > turn off numa balancing or set an explicit mempolicy for those tasks /
> > memfd's).
> 
> Does it make sense to add a pr_warn() or pr_info() to help users
> figure this out when they see a regression?

I'm not sure in what scenario we would do this that doesn't simple
reduce to "You turned numa balancing on".

Not against it.

~Gregory
