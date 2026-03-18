Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222212E03EA
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859926; cv=none; b=Rhl1n12HfzOy5rI84FVrly9WaRYUktCIycfG7B8wdBTBaU6bhG6ujk4ymVYhEP5/keqt1siLxjczwudS+ul5apTEQuCPv5dzjvuaGEEA6iLUX9Ww6caI/aUxSXTb5Hcim91fSiw0U/sdkZCCXpjiFF6CPvzphMpKxMHa7NTAe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859926; c=relaxed/simple;
	bh=+PoZebPl9eGyY2P4Hx8BwJJ0lFxSGwfNTcpB1F9sp9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLSTOD1yxcw9nVpgHmMXYDdvDOyDRiXN8dEopjGpRgXvw+r5mW0GjTfx4rC/KnXGgn6eiNB8sSoBVKarRO+OAByWqfma96pVhAhSTKz2y+PTK2CyhYU6Of9hkwGFgaFwRU+n38lk9qt3p1CtPdXzFykEAd4tg1vqtQoWIMSbsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OonU1ItK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OonU1ItK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aeab6ff148so12045ad.1
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773859924; x=1774464724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAVPuf1WmWbM7fHe7kDi/38r85UrwFo+QUAvxHpFr94=;
        b=OonU1ItKjR0j6OxpifFnwdILmpODM8UPuNa4Cc/Am+9D0qAaO946yX3Qv/5e9asa4+
         yHKYlSUbXMeRyOzFCp9Yhr+zUlaoMOgYkz3gPHngfE9dGQWXaJXYQK2nAviSp6hTRMf6
         2021zrNNeYWi3bM2n7xvjZEIjWGtLERiEqvcFNdLmlq/0uVwzELLqDK84Wchl6yynIjw
         sxeTY49kBtYzH5OfqqEIP+JNRg0BZf2NLWTmWrLyECUMOqzV3sd0zrIA0yAh3PrGIaHD
         fXwHFpOln4HMal0G8SgzPRh6OARLhCHqAUoa6aHaYgpCAKtgIiakoSTfajQRzXXIEjzr
         C6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773859924; x=1774464724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAVPuf1WmWbM7fHe7kDi/38r85UrwFo+QUAvxHpFr94=;
        b=BV5ff2m32x5FLUBzJbW6c2fTHehQD1LcHMuKFSGBi/7uttckOGeS6Crmibz8WQENZS
         BdtTNaSTBDD5O9k1bFN3pnmsJLaoFhzohLHERMu2SmozCLhvKD3qDLeGyP0g1m8f/otD
         CvcdQ1dgDGWY2OydOUh1nkm7TFcfAXuceY3nJzNY3S2e8HGEQmrA1nbvnRA/lWIGc/vy
         LQH0/9TDBCwny0ckZ9hnKRG5B8EvXWvPQE09mo6NvzhtrJbB2XS4WZAZFHWRDZuMl5jI
         MGx/nRHntBoM9k2EDP/HhDTTrFqG1Xk6Ph5TFvHsyskIQmMF5wkX53WhNs0P9uaHhjUn
         elYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyhRdws/O4rC1XrvylGDrwWNgXEMiY2ZeMipnTpmvdYsRAmEavPbqJqT47K9uAHylA4vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQgRpb5PO5kE6e/JZP4aQfxxd0bNt4goJK9G1+8NNfWMHAnLu
	XyMBbE19UElUvBqyeWjbC0sX8VQrttoKfT8uU1yOQceINb3vRW4pkA6N94hMcNyMjw==
X-Gm-Gg: ATEYQzwuLE+GwQ5Ot7INpBUhfS+0Rwc1m0dPY5VEkVyR4lyjMY5hHMRbo+167P6q5AG
	eXtMrGYQ3vtXHV30JlvVXd3YnczzcRV70E7oRDf/IHFj/neEWc8M9EdW557+Kwosr3SaS8bid2B
	Ax2tJ19lXvD/G+PZvwKwKuv4xOohePem2tUXjkscNcZcFL2OwhBvvx0eXs9Edly/rtHSTZK6i0i
	W+VIgaGZW8ONHk/AKFI4WximAYEik+z7Xcs+k7fkxvDCp0bDWKMA/HbIZmrgGuD/RZvsjSnGsFW
	r2TQ7WnapJogMTjU6X5GuepQ8k4iZOtlvatyyYL+yWDgb8JJZNM+IjlukjL83BHTF2A/Vy08LkM
	9lKVy8bK+C2OOavXJ7qWa3HpJU8R85cAnegQHt3zp/NvbfZkZQRRyaXY7YHlUvES6hKCY9up9Kn
	IaeKLwE6wuPxB4hJ5USVgHxIdcn1HhfudtR2inFiH8+3EL5VOeQDpjWQP2MA==
X-Received: by 2002:a17:902:fb10:b0:2ae:575b:2345 with SMTP id d9443c01a7336-2b077f15bd2mr285995ad.9.1773859923960;
        Wed, 18 Mar 2026 11:52:03 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbabc03ecsm1760144a91.2.2026.03.18.11.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 11:52:03 -0700 (PDT)
Date: Wed, 18 Mar 2026 18:51:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <abr0SoSoy1tSQqcR@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <abNH7LAj9thuGOoG@google.com>
 <abROLLfSUK8pXM5J@google.com>
 <abm09vCaAMtiQPVs@google.com>
 <abm1esL1dzN7NTC7@google.com>
 <abm4ShqPTxIujDlt@google.com>
 <20260317210209.GC2582517.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317210209.GC2582517.vipinsh@google.com>

On Tue, Mar 17, 2026 at 02:03:16PM -0700, Vipin Sharma wrote:
> On Tue, Mar 17, 2026 at 08:23:38PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Mar 17, 2026 at 08:13:47PM +0000, Samiullah Khawaja wrote:
> > > On Tue, Mar 17, 2026 at 08:09:26PM +0000, Pranjal Shrivastava wrote:
> > > > On Fri, Mar 13, 2026 at 06:42:05PM +0000, Samiullah Khawaja wrote:
> > > > > On Thu, Mar 12, 2026 at 11:10:36PM +0000, Pranjal Shrivastava wrote:
> > > > > > On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
> > > > > > > +EXPORT_SYMBOL(iommu_get_preserved_data);
> > > > > > > +
> > > > 
> > > > Also, I don't see these helpers being used anywhere in this series yet?
> > > > Should we add them with the phase-2 series? When we actually "Restore"
> > > > the domain?
> > > 
> > > Phase 1 does restore the iommu and domains during boot. But the
> > > iommufd/hwpt state is not restored or re-associated with the restored
> > > domains.
> > > 
> > > These helpers are used to fetch the preserved state during boot.
> > > 
> > > Thanks,
> > > Sami
> > 
> > I see these are used in PATCH 8, should we introduce these helpers in
> > PATCH 8 where we actually use them? As we introduce iommu_restore_domain
> > in PATCH 8?
> > 
> > Thanks,
> > Praan
> > 
> 
> Please trim your responses.

Ack, sorry for missing that in this thread.

Thanks,
Praan
