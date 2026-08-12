Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE1434E4F
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537684; cv=none; b=QokA8zSh8k0uRHTCQnsGi7TrMt9JU6j+oJi31q+hxKc4vNgUQB033VIyRmuVc2/pwoSO0wpufyygQh7VTsGctog/D2AjwwJLFSC6ycFCr4h/lLZWxpE2xqDcfEejHx3tHYre5KkeKtS2V2iz5LoIceCz9/G1NGUWJ4XZ/jdKjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537684; c=relaxed/simple;
	bh=OLsQWQAZ8OxYrzOAjJrunSXzJbHmrpka58K+pH4v6TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S77VrMY5hlEi6biOdvkvl6Y0Y7zcpsSfm60v6Sq5cHKY/pJ8onHtNWh2hQyD28ps3DoCD6Ipm0mQD0C1UrVhk9Jj0WsWhLbAZyEUpNoziApJfQq2EzpLG9znGqfmjbOSp5iuofxuIrZ/gD+iJv99Y4rJ/BlTUalXNfEtx0sAChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q1QXGocS; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q1QXGocS"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5218927884fso9093051cf.3
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 05:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786537681; x=1787142481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nO3QhHY842VdcusB6Ch/Vqg2F2nPYU3R/4exE5xwEVo=;
        b=Q1QXGocS/eg7eON61a3tdhQhABvMJ2bAwGHjg3lg5yeqp1aXMz5qcxVGSNaJK+uAc8
         PJqSUlRiRauhhKs/9U0qZnBG/nryXnqPYSWE9K6UuVQ7TrT22yZ67orHFysFufz+GFQe
         f0EQXxPnoyqE+lTl7eaVDbM0XpLVbMvqS5hJRZ7G5++52n1Tg88x7Xv5OljS/B+CTCX/
         3AFZ4E9UKosoZ1+AT6l7EPbIwWOFiH/tY0wQz8eRvBN1MTmcoG5yrDeOWjGI8uBPpS/F
         g/zjx50e51FGkEDMEANi15VG1hrU7aqJmJkVMqvsZvzeF+dfIso82wXq2C1jFMofajvq
         iQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537681; x=1787142481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nO3QhHY842VdcusB6Ch/Vqg2F2nPYU3R/4exE5xwEVo=;
        b=pg+R3edgC6VmV2VTt7g7oyVos1yRIeMOiDcOqYKnVJqjD6ym9c5oY3I3Jm7pZ1SLvL
         T6Wx/4cNhIT64UI+6DNawES2Vim7ywlUSdpecDIqlETbQ8R1ajNeA1K2cRVhIzMy7WTZ
         wYk3kNkIFDalm7P4nvvxyROhpJzmRE7LZSXCMo4IBro4dnmRm6/NlKpwF2TRRBAXaSY1
         owmM5uo+avNVBG9tpQjRerzZyZDwX/nFOp0266a/RT2kabH/wiMY5qxg7pvIfFxS+ZU5
         cuZ5X7NOAp+yRRZl2VNaf/gMkymaE8BxpoYkh7+Ggq1nlXNj4cS7wM0YIwQmXvZwyQ0h
         yxhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqE1h5aSJENFg8hnQt38KYErdD9M1PT2eRt7G6gNxjMqSvg9nFnaALb/78mLGr9o2Y6+4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTYMlXpRPynjbMN7oXBaz6xQKc9L9aVokg73ObUBcKq9pXl/QC
	EmPW3tzIqzUPau+bJ9ttoja2499CxIHCHfKaid4RjRhZ6J81p3QLbPt951Msg3Cad9o=
X-Gm-Gg: AR+sD12CIKO+Q7VgZdcW/XXiymKPqjG6+sDm3aNTFSRHkssCIcDjm07umV5RHAZNt3S
	ZaQbBDJZVrjzTdBUnaDFEUY8/4hubwzrGVc0flpK3hIAdVRwabyZzu8fR8ETYW608uSIpS9sf1J
	ygnlTT3W/5OTYgSJiKE+9uroq55l6DvLvMxHZJXrKOeeOMbev4DIVfTLD7zzhOMJk49j7oLPY2Z
	LJntkR7D9x34afvy64WGqYIj0YUY3tyO4iJFEe/T2K1d7ISbdxwrZNmh1X3njjHcKlWZHr6IdMx
	xTUytypUwvjFUpeo+/s563zpl3/VSDx8A2cQFBx/xNrrJh/PzPS8ijfQwkA67pOrMlyXOr7vodI
	Hc5gX9Vv9SrjYoaYY5yPDpOCMfDJsSaPnxlHnQW+jH4qKjds7jmYlwkjnXuWI/8z5jdWqsTk5JN
	qQVAR2gIkPyCXyQ6N7ZutG1WUVV31Y48f5ZIj5UZbqySJbEdfH
X-Received: by 2002:a05:622a:2596:b0:517:7188:c47a with SMTP id d75a77b69052e-52d646b8da0mr38269131cf.2.1786537681291;
        Wed, 12 Aug 2026 05:28:01 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c29e942sm20435386d6.12.2026.08.12.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:28:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wu83r-000000030Kg-2xlk;
	Wed, 12 Aug 2026 09:27:59 -0300
Date: Wed, 12 Aug 2026 09:27:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
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
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260812122759.GA662699@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
 <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka>
 <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>

On Wed, Aug 12, 2026 at 09:21:31AM +0100, David Woodhouse wrote:
> On Wed, 2026-08-12 at 10:14 +0200, Michal Hocko wrote:
> > On Tue 11-08-26 16:24:48, David Woodhouse wrote:
> > [...]
> > > I had a second reason for disabling the overzealous check too: to allow
> > > SRCU grace periods within the notifier callbacks.
> > 
> > Is there a way that srcu barrier could cause an indirect dependency on
> > memory allocation? In other words what might block the scru to complete?
> 
> Not after https://lore.kernel.org/all/6eed3fe3461e9690b486ca98fa7563f60d3940ff.camel@infradead.org/

The user of the SRCU might have a read side that wraps an allocate. In
general it is not safe.

I'm skeptical that without special API and documentation the KVM
special use of SRCU you've outlined will not remain working long term
too..

Jason
