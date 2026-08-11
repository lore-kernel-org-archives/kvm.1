Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216B40F740;
	Tue, 11 Aug 2026 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459347; cv=none; b=hySElm7L21+OnHr7tmKTdxw+2H+taDS02XVAyZf4/+uUBbqujzA9LmI6iBeWq8qNvPqoit7cg1Dcv4wA9jxFblvtzQ5uWyhvS4h8F+HVem3iK9o4GYgYz2fqQPdK2qkn8Zw1yvVfRHgVytMGD1OZI/SWJt8lrutATAuaYWkibcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459347; c=relaxed/simple;
	bh=x8JM/8uKzUCIYdjLzqYgrf/L/uVF3VjP5scTvdfVuog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFR9xJWhV7U6G1sVVRnbTGfmwVFBs92f/ONLtYdyWmKaU1S8B0repKxIN3Nkropvs2umZrWrJStqdxJfWFbhXrRwAIEgqCKzs3oPl5jvzFQTenEBP3RL2Z7Fk66uYBte6GQq1P1qFpUsH5qXHqf94bzapnaqcyWY9psqGsVC4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 80210A04AB;
	Tue, 11 Aug 2026 14:42:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 1BDE720010;
	Tue, 11 Aug 2026 14:42:18 +0000 (UTC)
Date: Tue, 11 Aug 2026 10:42:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand	 <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett"	 <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport	 <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko	 <mhocko@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Simona Vetter	 <simona.vetter@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWU=?= Glisse  <jglisse@redhat.com>, Christian
 =?UTF-8?B?S8O2bmln?=	 <christian.koenig@amd.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, kvm@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260811104229.72fdd928@gandalf.local.home>
In-Reply-To: <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
	<20260811135537.GC544626@ziepe.ca>
	<1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
	<20260811142730.GG544626@ziepe.ca>
	<a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1BDE720010
X-Stat-Signature: oxypg9f677wxwcpnaarkrfp38fcwugwo
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19dAleZhUOu5jMhgkH99lyj0Dn95BWTID4=
X-HE-Tag: 1786459338-307469
X-HE-Meta: U2FsdGVkX1979J+Q3OdtvU+zN/hhYl9JQhI0wFYQuN1ZrCOyLwM835zzoagX5l163DZzohmxYfjMQMg9LMvXrD6bg3AeHd1TrLiR6S1r8L72HAN+v3XhoxZRX8xO+2I0Jc1dgxN+O60SUmzois9+y6MU9QJdwUAoXwKZYXZvgflOY5MkQGkqp/ZeTZ3GzgxqRZ0WF8S3WS8LB8o7TyvqBGXiA98/d9imuVuTVh0RKt7dphRhabMtXLx1CHkUp+8F6TrPt7w6fDOjixFfwzPAI0/VQK18sVl3nuIRCZ+fXGfIeFWakblsUYrcuLOfrE2v16Fx2y20k2tKyfUJUKu/Aa1kEnu9UsWEY7fVgeGUG4kiRo2q1nZuksArsq2JybJg

On Tue, 11 Aug 2026 15:33:18 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> > If might_sleep doesn't work sanely at all in preempt_rt then just
> > globally turn it off?  
> 
> Turn might_sleep off? Or PREEMPT_RT? :)
> 
> The RT maintainers are on this thread if you want to pick either of
> those fights... that was not the course of action I chose to take.

I guess the question is, what exactly is the reason for sleeping to be
prohibited? In RT, sleeping is allowed in most context because most context
are threads (like interrupt handlers and such). Now, you still can't sleep
in NMIs and hard interrupt handlers that were not converted to threads, but
I'm not sure that's the case here anyway.

If the non_block_start() is just a big hammer to make sure things are fine
in non-RT, it will likely still be fine in RT even though it may block and
sleep. But what it blocks on are sleeping spin locks that likely would not
cause an issue here if they didn't cause an issue in non-RT.

Thus, perhaps something like this:

 		if (ops->invalidate_range_start) {
 			int _ret;
 
			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !mmu_notifier_range_blockable(range))
				non_block_start();
 			_ret = ops->invalidate_range_start(subscription, range);
			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !mmu_notifier_range_blockable(range))
				non_block_end();

?
