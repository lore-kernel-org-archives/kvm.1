Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F837F725
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522477; cv=none; b=fqabESuZKZo4Dcoq1Hmd2sSkjk/z8YdjUYMc+faXvnFSqGxy8F0Ltr6FoAOyeIWgZsZJamRsiXYUk/9Kx7COR3cp/Cp8Odp5L+V5fAfGvgSL3/1w7z/HnubBUQemlGji4Xu7MuszrELg43TGWREVqRqUTFGUTgWzCEueaIyLTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522477; c=relaxed/simple;
	bh=h3hwx/tgdyFk6zQbEwHiApdsA3w21aWE9i24GWMIjNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHdb9KoAxFnT0B80jKiFcp8asecDDpqQE5fmoRicVmrW2hyhB2pab5obaCrgagmLs3gRS4wqQ5Se3SIdKY6RWVmkuNF34ZyUiJsiYeFUqwNYatQ1Fi4D2Z/YjwP1BZS8Aw4y4iiGbPjj98hhegXyswoK+6V2z79Sd/5gbNCw+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Htf3C3yu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Htf3C3yu"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-471eeac43bfso487655f8f.3
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786522474; x=1787127274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cm73Go05IhY67+bcf6pjgSkL6qSZACbfB1rQ4knSZqE=;
        b=Htf3C3yuIJAI+kEI0duopZThe9ZfoUwp31t7J0UaRxn8IQM0ZXA3Mo7DKtDxZ6aSbg
         5mn3kmejEKCuuVTOphpBWodq/7Sj8I+DW241vieLnA56lm0J/GLWjA/Oq39QVWddbI4i
         Zeb521cbyvLx9MGx8pHmP8bsBK7knM0Q+7QVTyCvXzD2m9e0tGYuw/laAqR7yf3WBDRl
         iLgibfAxQ2gOYuLS/83pFll59CIsvW3Z4i3iQuPLs9im3N9vYBQB1XCGfVwivP5Kvbgc
         7Ogt9Ef99wJ61EHd2nwC42gyWKFAxBwnEcIPzfF/6ye0NIkbBLj0jlEm+AiU3txUTVPU
         F2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522474; x=1787127274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cm73Go05IhY67+bcf6pjgSkL6qSZACbfB1rQ4knSZqE=;
        b=npYwT43rICtNJtTLxTRK9exEd+j8TknWGDTNiAKokD0o16WLodWZkqjCubX+3QOnwb
         g0btjMOVmIdDt4/YyFkxVrZTiPSqXY1qab/Jt+/0P4IJK6EZYY1jX58BT0Iw1iAFiaFc
         iIUDM42amWeE0nbAFC7ZHi4vHGZoLvJ+W7W9CcghJkoAUwMW/98tUCq9nTWG3jvXLLUH
         LygTYYlHW7OHpIkELMGtELCFrtXRM1Z8DlKiijuNRoSo1ZYt5xSKGTeraQJHejIeME+L
         lwERyw42mjQHVb2UUW56AUstkdJyVP380r6yGI3VuoIAVZWyO7YR63Wr7R6GHjD+xQMI
         NqvQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWx3i/dqfOWkRWytLkbSWgB5I8hwEKbnelInWFnmpbhaS8bxVHrTjYKegmDhKlSF/zZbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLPi5XNgfUtOcqd3hRwK2/R7rSeYXiKTILRkoBSFhj4LL3pKX
	k91GnqDmBvvPvAXQ3j47yw/w0msZQb5QlHB3Qw/+6lyjHbcmlZ1WjoX02VqsLaNXI4o=
X-Gm-Gg: AR+sD120lxO5QBNuiYImvtmis++J541N9qa1ZQPA4B3uniBG29Ek5v8HCTS/jNuJJU4
	3St8AujBWbmFtUgMQH1+Hyw0PL8Gw7o21trye6VLFeuuS074vbWtxIz0/HyhN/N26p6hUDCV00k
	ywazxbsRxI2EvtboxjFg0Ka+h3wuOzGz+hK8DXZhbfVfCLwApuokIFh8HFZoqKodOMJCVxTjSiR
	Y2c/eg2FuZNbUIjVo29QAfOY26hu6p4UptXJ8UpGtEBG8Te99BglvN+3C2qhepEaXn2CSgK3ZQR
	LkBDH9ysBDUSMJGz3FmorGezUtpSaEow8+4NMnAYAKuTbU9OhSEfcZ4pDS5pEpKjSwiUYFFJKIZ
	4U9062C5osBTgZs9/6N6D/6ernz6lZ1nL5D60iy91939pozpE+vWfshWUNLFyolJJJlBVC8ugcI
	hiHko57tXdCOT7G5MMrBPNplDYvXJ49jhB5E9IPDO+p1FyW3Tc0mzYgNiVUJMzpeu1673QHog=
X-Received: by 2002:a05:6000:4607:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-48152775015mr4164525f8f.0.1786522474169;
        Wed, 12 Aug 2026 01:14:34 -0700 (PDT)
Received: from localhost (109-81-23-83.rct.o2.cz. [109.81.23.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150bf5f0esm4963432f8f.4.2026.08.12.01.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:14:33 -0700 (PDT)
Date: Wed, 12 Aug 2026 10:14:32 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <anwraNIKJV8zwrNT@tiehlicka>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
 <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>

On Tue 11-08-26 16:24:48, David Woodhouse wrote:
[...]
> I had a second reason for disabling the overzealous check too: to allow
> SRCU grace periods within the notifier callbacks.

Is there a way that srcu barrier could cause an indirect dependency on
memory allocation? In other words what might block the scru to complete?

-- 
Michal Hocko
SUSE Labs
