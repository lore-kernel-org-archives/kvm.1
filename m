Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46AE2D2394
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456541; cv=none; b=LD5cSJoceX3SyRxDNa8LMRqmvHhbxIU0FwlBjiD3/3nXUsHlyX2imKdsV3Qmn2gedncdNMz+NcCXkiy0iGq5AG0ZHnAQgsKLWbfMgnFbKRQHqpYloXdtTN9fTAbwE8zsCn+H9TJehAN5FzvwWeyc2w38FzU/L6VWtP9uLyG/pHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456541; c=relaxed/simple;
	bh=2eYYxqEe+PVheZ31u+T+PddfjluSsh9ADg0MARNd0Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ8fsnMCuOaQ+1qgcz1EBznYcyZklEK5vZnlHv+aK4smDXMRdegyVUc10JougaXScA66PQ+E4vcEQwKheIkUc8zOquvy4p4PlN+q6ER/NgeWd5v47K2C0AKOUOM0fTG0O/AO5v/0btBwIqn6gvYZV9K6dE4iQ+EVSV6PErMX4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NlbdNuAM; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NlbdNuAM"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfe810293so13661031cf.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786456539; x=1787061339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xauE7W5wOY3LNWuplU4mgV1n8xBkZN1XfpHr0f+D+b0=;
        b=NlbdNuAMSsubVfNUyu06VwtNJjCl2mAUricHs+nwFICdOUvmjk/qwsFypDTvzopcU/
         kQTvdbXB34Gkw6rJ6AWLRloqMNeBk8orQVkoQmtDyZvCVgWp7Cut56YBbQWuOK6ZhSex
         koEn++ebpuDuhcjqlLeE0r45xmxTqoEmY6EasJtg5/9kb6lJ+ebTtZsndfhs/AhYCchw
         jGgVZgiuUO9y2ZDzWDAV8cn3xgoBHQt5MI/pVftqnwqSyHalSV4IQMmC8qZ7l5JPnR1x
         P3RVGSC3YiDSduHspr7XLVwUirAt4RoeZ5/r7kuG0eXssVH3m/5ggbgJ3VMogOtMeNxB
         E81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456539; x=1787061339;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xauE7W5wOY3LNWuplU4mgV1n8xBkZN1XfpHr0f+D+b0=;
        b=aK5U1doC9Ey44l3O2RgDFZKKMCiTXCuR4QXdp+LMa9rO2Tep3qhDi/MWGV1MEpb9vn
         o1YYCuhmi+hkdO0vXkrMLLSLISjazF1P7wvBeh1/+iM/0Sk5NptSDrpx7mCf/og0bEbB
         3Sy56dp1n8RrvuO+vm7hUkP3UW6vxSpk1l2uwQ2ry/E2RORWJaYozLg0Qk9/i/p5+uWu
         zbROk+76EZvTbO4qMVFdx8KoOInGQbX9VnJhsC8kZyD6XxPP/f0UbvvirM5zDD9e1X/5
         iRavWzCAnQ7S8sF6azPmFqVy419Fg13JYfZrwZhjaFMOQF8LA2TQobTaheiV5ptRCcT2
         reiw==
X-Forwarded-Encrypted: i=1; AHgh+RpPdhOplKbVp45my5MQqUGsw8+Ogv+OE2NtVJ7PYM4jTHQx7k6cadCeWuSa23fMauCiIh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUJuQO9ZMZoV3DOsYEzGIVvrWLa3QxEWzC6vVBm8YBCjOF+6O
	v91reIAYX4//aQRwiNMP9mgm8e647uebXzkhBJ3NZPvwR4WnNk2TyKUzFGT7vJEGIA48kfOXXoy
	OWeqv
X-Gm-Gg: AR+sD11mFABG9vMGCEekNcEc8w415hporg3A+90PJ65vqVbMqVroLgiyaI1EqwPV+YY
	5+H4GOcBMa+FVRx01FWk4yeGZ2nzG9pc/tmKdddpsqx12Tw8PCRUcWlq+1NGvvUTZ4ARQbvcXOf
	+3o6YOK+4ai6/E5DaiJyOVw6gfRI2BhUNYS9B26s7L2OfpiEpAljhclqOeTnIFWfQjVJ1bwrQ7Y
	x8oEeSo6OdY2WR60P8KM/5eWmvrFZUUD+di9+jPO6snC1mnuCpr6OflSkXxE9LdEe3AgG4OMuG2
	B2DkFXhFcrxLmndoLG1zacSLYDNr1Q5JgSNWz5Ol3ikiU6mKZxvN6Cosxz3hBz8pNxlim3/Vr/I
	4XByF8Khsud0Vyot4kBrPC26ChxK5d3Rfusd85nhutCnnqta9VW3aOAK6mbNgIxeoJt/LqPXU1G
	+ctrWWH95Oy8lYVNEfubScLJAEdicNEuTDiuBeBg==
X-Received: by 2002:ac8:5cc5:0:b0:51c:963:cafc with SMTP id d75a77b69052e-52d5867f904mr29812841cf.41.1786456538732;
        Tue, 11 Aug 2026 06:55:38 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d57c749aesm11606881cf.31.2026.08.11.06.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:55:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtmx7-00000002UhD-1Ab6;
	Tue, 11 Aug 2026 10:55:37 -0300
Date: Tue, 11 Aug 2026 10:55:37 -0300
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
Message-ID: <20260811135537.GC544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>

On Tue, Aug 11, 2026 at 09:58:44AM +0100, David Woodhouse wrote:
> As Michal Hocko put it when the
> annotation was first proposed (quoted in commit 312364f3534c
> ("kernel.h: Add non_block_start/end()")), the OOM reaper "shouldn't
> depend on any locks or sleepable conditionals" and checking for
> sleepable context was "the best thing we could come up with that would
> describe these demands at least partially". 

Sure, but we translated this into the notifier must run in an atomic
context and everyone has been happy with this.

> That distinction now matters in both directions:
> 
>  - On PREEMPT_RT, spinning locks become sleeping locks, and perfectly
>    legitimate spinlock/rwlock usage in notifier implementations (e.g.
>    KVM's mn_invalidate_lock and gfn_to_pfn_cache locks) triggers the
>    splat despite having no allocator dependency whatsoever. This is
>    reproducible today on a PREEMPT_RT kernel: KVM takes
>    kvm->mn_invalidate_lock in kvm_mmu_notifier_invalidate_range_start(),
>    and if the OOM reaper reaps a KVM process the result is a "BUG:
>    sleeping function called from invalid context" from
>    rt_spin_lock().

I don't know anything about PREEEMPT_RT, but this seems like an issue
with RT if a traditionally atomic safe functions are now triggering
might sleep failures?

>  - A notifier implementation may legitimately need to wait for an RCU
>    grace period before allowing the caller to proceed with unmapping

That's not allowed. We really want to forbid that, it is not an
acceptable way to implement a driver using these APIs due to
performance.

Maybe change this to #ifdef it around PREEMPT_RT.

Jason
