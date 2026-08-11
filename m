Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63933A59A8
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462238; cv=none; b=p9TUDEBMNYQLWlEBPF0lFnjafgAY//WOBZDyYW01oX613tl351nI9sWHT8tcn3aHfju1OKK5xpcKYpHEn2CyjfH4LCBgTe/tM06A0Vwg91PVElbfiztTenCp9eiKBZZdBA/HHFfRei8GL7U8BPQcnYy0n/QUSwTGPIVFtRoUU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462238; c=relaxed/simple;
	bh=ajdewnx/cyhu5yu7KfoSulJ0n0owi6YVHKYNKTf+Sz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fynbma6dhCjjgw3t3egw+9Rx0hY196SnJ085uQdeFvg2OPjE8RYrSPVp3gQr0mljEQwzB08jIjrWCTuF9NvfQ17Xne83v2PfEb3swufVg60ldEP8cGROTcy5EEqVeMT/tCHyineVHs5PVd+ZtTXSD/t7uY49PyVyVkq9QCg4LrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Hjou1TsJ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Hjou1TsJ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso19553996d6.3
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786462236; x=1787067036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZ5oPQk870n4i5Wo5FTt731WhaBz04ce9fYdf/2ufqM=;
        b=Hjou1TsJyTnGuA1qoYGF8lLhwmatjb9R4AgI15R13FcdxZDthCNl5Bt6CpxsBbMgtb
         dznEn+j09Fw8/OkoGuO7q8cTB5TF469a9/JLRlvpwds7R+aqT/wuBoyXsbKUilTER5gN
         x/TaqH1rkAv1Lt0RmSMrYv8q2cCatsVPqzO5iCVvQ1PT6ffsyew9PtHx7yELGkNs++vn
         3onjoxZNq5MFxmHQRF/tcFYcai6wsnGuXtLOKD63DF43UVJmvu7a9uLjyjNrXMhLz1KU
         J0M8HIA1PDZ3BKaJAy+zIy8dSb2OynaBhhE98xIqEN5K0v5cYKxr2hUzUnqh/akKN1Ez
         SR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462236; x=1787067036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HZ5oPQk870n4i5Wo5FTt731WhaBz04ce9fYdf/2ufqM=;
        b=aAL3Pt6svr/nkWDcWKFrKS8nN08OHBWg5lJ9LNdgMGtp2byFHHwZPdGMyIP2dI8LFB
         CSxeoiYL9KsKwIzc9sMtv6KeGN+OPihTVNE9lskLZheysjCCRX6iLQvMLJkMOT0pKtbS
         ln9Hccj0sbnO86A83x3gdMweL7G91boi6R3lhIAuBK7jHpt2NudqaNJ+zKbuSzHWxdI+
         npNxFuoAg/mqsCB2SN6TzhRx7iRC9IH5qSb8qnRnPksn6VkuaCoudZ13lnTWKIYhaIdE
         A1JQKy+2WRjHtZnxJGy2Zv7uWEM9eIgyyqHz3yzhz5iHQ8C8K7dqBuEO2VAMZRlGWMj0
         WXUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpP9lbwUVqkCEleSb9lcAXB2p3jTH1FEs65ms5kw9hLjiAQNhP0Lp57qvqVQZhOAkgsG0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YylPczpyFGx6JPsSOnFNL7ffTQWBZYq4yJyY3dwB0RZro2EEdWJ
	OKB0h13kyzAG3bnCKvP34IjJNWaAPCter13WF7xbj2jw2LMudqq+7QDcxmOxNWXh1NI=
X-Gm-Gg: AR+sD12K/+ZHBYXVZw7xJ49e0vZp2HBojmtOVMztFLloa+BdmYAILP6bXWFKl8J4hTi
	J7RjQ7Hl8RkF8Usa1rAdnUKBLNcbCnCIjd/app4l0J6ytNz/NJ4TyMYy2UrAo8cPm6LnqjWrG/+
	QyMhdfhHNPbC7D4leIPHnkIVi0mYHtohtqid9qPck+r00EBY8PfmiXukLh1Bxd7nc3kNpES2GVp
	vdpxPjIBJ6uyYRZnw5eTgDcraP15DKztn99Q0OgazyfmCAls/V5VGugPAfT8ZfhazuGCOhar9xe
	boTfgcmL5F/r8nGBHNaztkGX9vjmVsyzxAQVXbVwNNKL7nVNpxhg95JcBQDkvzbvDwdJZ/30O54
	kjSoNAIlvxqtzyY7zHijVsenKS9fEVNpCSUDBbWZGpn9ksZwNhF16dNBL7yT+BZX3THhdOFxy0c
	pJkfpT9JciZmMZEAlGk70R+JdWgBStYoBiJymDkQ==
X-Received: by 2002:a05:6214:2aa3:b0:8f0:c170:4591 with SMTP id 6a1803df08f44-90a667e886cmr37546616d6.4.1786462235465;
        Tue, 11 Aug 2026 08:30:35 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c2a05f3sm1600106d6.18.2026.08.11.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:30:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtoQy-00000002X83-0m35;
	Tue, 11 Aug 2026 12:30:32 -0300
Date: Tue, 11 Aug 2026 12:30:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260811153032.GJ544626@ziepe.ca>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>

On Tue, Aug 11, 2026 at 04:24:48PM +0100, David Woodhouse wrote:

> I had a second reason for disabling the overzealous check too: to allow
> SRCU grace periods within the notifier callbacks.

Don't agree with allowing this at all.
 
> > Thus, perhaps something like this:
> > 
> >  		if (ops->invalidate_range_start) {
> >  			int _ret;
> >  
> > 			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !mmu_notifier_range_blockable(range))
> > 				non_block_start();
> >  			_ret = ops->invalidate_range_start(subscription, range);
> > 			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !mmu_notifier_range_blockable(range))
> > 				non_block_end();
> > 
> > ?

This seems fine to me

> Or put it in a per-mmu-notifier-ops flag (a bit like the one in commit
> 5ff7091f5a2c, but with almost opposite semantics), and let the drivers
> Jason cares about still keep the guard, while KVM doesn't need to. With
> or without the RT part...

Nope, common API semantics please.

Jason
