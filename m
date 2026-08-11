Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0335721CC71
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461880; cv=none; b=t7Mi0w7A+GzrLQMvrT2QmQoK09sCHk6sYH0fnPOcX49HVj/50YBaB6M+U3+YmAYmoaRtaWbjKMHz5UR+VrKVsx/KjwDL1HiKkA9CNOAvYP+x6PCTtYT2SKt2xGFcCh0kYiPSvKV2h84xIxKtawQQ8hnpkgpr4JeXO0Jgs0F6Nk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461880; c=relaxed/simple;
	bh=UlhJrx4cD0iyVN15M9xGt+ngtuV5yPj/OQO+zrMn8bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9g+A4YlsMP4L7FjsLzpqq5UVksg7z1hjn0/LcUHj8jmslib0OijJQec/0BBXp7jhJXy+++2KgkGbDfVeCOE19qdTdquj5mTLOmhkdR1AtLnO8A0vKmkRIDOg0FECIHg6C645B88P5jrP5wbGKmrmIgIxzz090q8fEedSQa97P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oZDgJ02r; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oZDgJ02r"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9349ad9c857so5090185a.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786461878; x=1787066678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GJpznJoS0l7uzYWTFF1MoJR9UykE3LUYDEr5DpChX2M=;
        b=oZDgJ02rM9PMe9yWrEcGQOxGZCOoAkL0AZza0UjpTSUIJhslwZh5j96tq0wJIH73je
         sbQFWOzrQn5+m52b8mYtNWuvsFhthip6ZqHwvWRCQKRr4WNjbJNGdkaswQvmhTfBQdJ+
         9ajORS9BbnLCYOJlmx1IJEPH7UxVNTD2Lxedj9JNNLcGs0KJUw64MzO0Q8DfYo41b7u9
         DPuhGQ6blutenuWqroAAsm5XJaR36stVkyijtYG8m4kiTVi64XAcrBe9DT6dsx8O+Oux
         2Qr9hXw3IjGg0/6uwgh91FGeqyiXiXnqsuSLtNSsL/0q7kS0I6kwlGykEp/IA21WV96e
         Z7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461878; x=1787066678;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJpznJoS0l7uzYWTFF1MoJR9UykE3LUYDEr5DpChX2M=;
        b=Ix1l5igAAkRUkVWbZMnLJNzqCetKh3bz5bqI+9pS/y+9CNRp8N4RTuv5/RQ3cOXrl7
         R1oi6w4maPXhDXTqlIBaOMLeEU4+MF3mJMyn4LupFSiNOD8bX4SaVZvsDIDBn67XHx7r
         PMGNg053w4sjW2D3uxSZ+NH4/FrC30z2wXca7aIwggujgKVr1qEYVs+k5q9YLHmpjbZR
         Z5EwVz3TB8xe012bQEC7F01lMek+wE2QfYETTIvfIsDEWdgpu4fpKw5J9UoKRkWkyBSz
         nTgK68vaQastiPrHdDH8swy2LdwbqbuF14JshH7+G9TJ3xhIQwW34dU4XtIyuqzAvnrZ
         oRAg==
X-Forwarded-Encrypted: i=1; AHgh+RqDx3W0QqUFawMOEouq5TOSIeTc8iRMezD5bxVGzsvbUg0XX2UsSvXL39b7Yw5rH89gl6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYYho2AtUfQTK3nkCqtauhWyxdXrUd95vxZyI8cjA/0Lzjxcy0
	dOapf4lukcOjMNuRmEA7J79QrMEJDEmSC8e3jB150/kvGrZkTm0hSyADLJKhABIfeXAzCOSH9ZA
	cNmQr
X-Gm-Gg: AR+sD13MK6Fd2dDxA8hACVoovwOAX3PQ3MDoM8xcVNX2ajiCWj/daJ8vOpo71F7Kbdw
	6mgwOLRGNm6gpNDV+ao5HDy7nNldmvSFwJL4z2WzL0rv1tFlV7iq9VWrLhXZ7EIO6NSpQdRNrGi
	3Cwg1MR9lITEQ1nB8ZVyOgn1C1OPnhXT/lvruq1eDdvSRwrsiGCxYg9ibUTjf3qb3FMVnq9Yae+
	3R7lPLgoK/KdL+NeL+q4P20lTsjmhSG5rqrIlhRr4Au5C7zp3XO1phiWhD3hybR65fsDPUMU1Xz
	MNfxUABUIIsN0m0+bQC1ExtfsiI1in9SxdQMa0nk4X4y27rL3De1gMYmCH5a7zV0A/RW0uWDFqZ
	/Ow16GOzaFQeTJax8LQ0SpfJC926++dA4cSTwnEKofljGTMXJhvR2dhWGyOcNb/9tN7sfIwDzBX
	AMxhhBafZo8ruQI9VeMY2H/Dvmbb1KU20EafhDZw==
X-Received: by 2002:a05:620a:c50:b0:936:48f2:b04f with SMTP id af79cd13be357-936a8e5f5ecmr330842085a.6.1786461877528;
        Tue, 11 Aug 2026 08:24:37 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936a8472ed4sm132935485a.9.2026.08.11.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:24:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtoLD-00000002WyE-1V0l;
	Tue, 11 Aug 2026 12:24:35 -0300
Date: Tue, 11 Aug 2026 12:24:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260811152435.GH544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <15a7bd252a9aaeefe393f5609ec383ce2c61694a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a7bd252a9aaeefe393f5609ec383ce2c61694a.camel@infradead.org>

On Tue, Aug 11, 2026 at 04:15:36PM +0100, David Woodhouse wrote:
> On Tue, 2026-08-11 at 11:27 -0300, Jason Gunthorpe wrote:
> > 
> > The unstated secondary purprose of the atomic context is to force the
> > driver implementors to make sane choices that don't degrade the MM
> > spectacularly.
> 
> You realise it only does this is in the OOM handler context when the
> normal death of the process takes too long, and I literally had to hack
> the kernel to even get the splat to trigger in the first place, right?
> 
> I don't think it's keeping your driver authors honest... :)

It is documented to be like this, even if it is hard to test..

Even for normal blocking notifiers you should not be using
synchronize_rcu().

Jason
