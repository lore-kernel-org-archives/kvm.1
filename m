Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD83148AE;
	Sat, 25 Apr 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777075209; cv=none; b=B6iv/AqiD8efJbknC2kJhsiSqg3B3jTcQSYD3OfxZwF9Iswvm2cthdOITrFgvzjYBFCF97m984EJF3I9fUMdzXFbXXDJw8++GXFuqq4hxuwLv675QDphh2GetxR36sfw2IJGBRqlYsPpqA521enoWg+VANYBw+/30EGXTUe+A90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777075209; c=relaxed/simple;
	bh=C8r7huZNyRElYBe+dzNVCmXSopmsS7PatU3slqIvHiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYK47PmD9Qg5KpBjWwDvziFCrTUFtB/ExcEaQM8Z9L4sfqSWGT88xTBjwsgRJ1vwyhYuDyfc1tq8lXiBLLIzu/spfzHr8DWjGEMkx5yZtscaMQ8I6HERNX27ly/m1uxDtHyJXHcrkbyTgeGIBUC6pOTjWrOqs1shCjU25UG2Yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsP6Nh8W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsP6Nh8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F5DC19425;
	Sat, 25 Apr 2026 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777075208;
	bh=C8r7huZNyRElYBe+dzNVCmXSopmsS7PatU3slqIvHiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IsP6Nh8WvKEeCyPJ56ahQHwF2bxzxblJotd1wZXbilPyV3ve/Uv8Fv6kAOoOzg680
	 JLRwJXvtvWV8b+bWgo10MkWEQwvxbFRoRRApx99J14hHn8fRbsy2knuRrjitI/Yqwd
	 5TDlZhBpyC/o7ItjCRUbfLopFA09l+QpXJe3pklvOuKrdKP7MrYWCUQGYquGkA6Ylc
	 z+mx7p/i4O4Y3yD3JVGMuSPP2XfiojskNYGLRFLNAXsvYcNyZ6ucZXPH7nVSKGrAy9
	 qs9kjsYLBG6KTgXZQrtiCzdp1e7jFlwQE8kqWEmr7uXOjnB2b3S5Jk68JSgotIDUQR
	 qvV2VssP7PYQA==
From: SeongJae Park <sj@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM guest memory
Date: Fri, 24 Apr 2026 16:59:59 -0700
Message-ID: <20260425000000.84178-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aetaH3W47iR56nQ5@x1.local>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Apr 2026 07:55:11 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Thu, Apr 23, 2026 at 05:26:24PM -0700, SeongJae Park wrote:
> > On Thu, 23 Apr 2026 14:57:34 -0400 Peter Xu <peterx@redhat.com> wrote:
> > 
> > > On Thu, Apr 23, 2026 at 07:08:00PM +0100, Kiryl Shutsemau wrote:
> > > > On Thu, Apr 23, 2026 at 10:50:06AM -0400, Peter Xu wrote:
> > [...] 
> > > > > - Whether we have explored other approaches on page hotness tracking
> > [...]
> > > > DAMON is built around sampling. It is good for working set estimation,
> > > > but I don't think it is directly useful for eviction decision. It can
> > > > miss hot pages. LRU rotation will also loose info.
> > > 
> > > Exactly.  If we need to collect ACCESS bit (or anything similar) for
> > > eviction accuracy pusrpose, IIUC we need per-page info, we can't estimate
> > > by sampling.
> > 
> > That's a fair argument.
> > 
> > Nonetheless, there are some companies who use DAMON [1] for a similar eviction
> > purpose on their products.
> > 
> > Also, page level accuracy issue was indeed concerns from many people.  DAMON
> > therefore provides page level DAMOS filter [2].  The idea is finding a large
> > region of cold pages in low overhead first, then do page level access recheck
> > on page of the region using the filter, just before doing the eviction.
> > 
> > DAMON-based memory tiering also uses it [3], to avoid wrongly
> > promoting/demoting cold/hot pages in DAMON-claimed hot/cold regions.  The
> > evaluation result was not very bad, and a few more users reported positive test
> > results.
> > 
> > Also, DAMON can be used for page level monitoring [5] and open to changes for
> > users.  Actually a work [6] for making DAMON-based page level monitoring more
> > lightweight is ongoing.
> 
> Good to know that, thanks for the info, SJ.  I'll add a note and try to
> explore all these at some point.
> 
> I recall I read a paper describing damon tracking overheads when
> granularity is small and when the memory scope is large (in VM's case, it
> can be e.g. 1TB or more).  Would there be quick answer on whether this one
> still suffers (or maybe it was never a problem)?

I think that should still be same.  In case of fixed granularity monitoring,
the overhead is inherently proportional to the memory size.  And we didn't make
many effort on making the overhead lower.  We have two ongoing works [1,2] for
that, though.

Nonetheless, whether the overhead is too high or not would depend on the use
case, I'd say.  That is, if the system has hundreds of CPUs, letting DAMON
occupying one CPU might be no real problem.  Rather, there were users who
willing to give more than one CPUs to DAMON if DAMON can provide more accurate
monitoring results or work faster.  That kind of scaling is possible, by using
multiple kdamonds that monitors different partitions of the address ranges.

> 
> > 
> > I understand no one fits all and the decision is up to each user :)
> > Nevertheless, I will be happy to help if you have any question or request for
> > DAMON.
> 
> I'll definitely ask after digging more into that, thanks for the offer!

The pleasure is mine! :)

> 
> > 
> > [1] https://cdn.amazon.science/ee/a4/41ff11374f2f865e5e24de11bd17/resource-management-in-aurora-serverless.pdf
> > [2] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#filters
> > [3] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh#L40
> > [4] https://www.phoronix.com/news/DAMON-Self-Tuned-Memory-Tiering
> > [5] https://origin.kernel.org/doc/html/latest/mm/damon/faq.html#can-i-simply-monitor-page-granularity
> > [6] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.com

[1] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.com
[2] https://lore.kernel.org/20260423122340.138880-1-jiayuan.chen@linux.dev


Thanks,
SJ

[...]
