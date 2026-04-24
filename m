Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92996221DB6;
	Fri, 24 Apr 2026 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776990394; cv=none; b=lF1fNDKDtSvWrGN0n2p5656X23HUU9f+IuqCbZ6G4RCbGoc4DG5aCuuoF7zNVgUItuiUa+oQ3yJ34C3iZVMX1Wy78PgV71+IYTsoGdWcuc7LVfVqSSejPOGy40EFwxYSCAwbE/uldk4zOHIWCKVtwUfVbthaBIKNxOANo8+lpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776990394; c=relaxed/simple;
	bh=Wj7MBRLrssfpOdJSw3iPqXTN5nRgvGJm3FItsgv+Vek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1yxQvD55LWvImukYQPV2/bMS3oDHgn0WtZ/TDr5qjWe3SWPwHJ5gQ7y+C+fcFONkGs8XeWtiOJYmJVtbfd9j7t/8r6bTCDO1QrgCV20sSEpPANafEcO+M6VSwiuZfxaMZDNIl3KkigsWnzVataKPo4o1QyukWcYd0iemmzkxn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYLMGkPr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYLMGkPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E894C2BCAF;
	Fri, 24 Apr 2026 00:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776990394;
	bh=Wj7MBRLrssfpOdJSw3iPqXTN5nRgvGJm3FItsgv+Vek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYLMGkPr0oW877jQr7py4WfT5WNcb+zqX5VW9F0jPSCMZMSt0lCf5ALSrINIqmnVV
	 QHzk88X1JWZxm+UGrHtWamlGKFJkroxYKtbF/b4Sm9x4qdo1w0N7VcJ0mjzj5jojhe
	 U8HfOu9LA/tNbClE2Zn7i7SJ2Hy/R7Pz0fIFl8+8Us+yiNYUC19q1lhFxBZ7bUg/Os
	 RzyLOX9meKjztf+SxOH/spUDLPvmlptEc6ZiyERnVJgRu0RtuABlov0LF1IkeGu/0C
	 TPyYkmHDEnNcADg/RgN8rhUAU4Z26WaG9QN3I5b975Eg4YL+Pn3OP07NTQFp3huU/1
	 72uQgg7v+ZBlw==
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
Date: Thu, 23 Apr 2026 17:26:24 -0700
Message-ID: <20260424002625.89857-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aeprnnccJeyHB2rt@x1.local>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 23 Apr 2026 14:57:34 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Thu, Apr 23, 2026 at 07:08:00PM +0100, Kiryl Shutsemau wrote:
> > On Thu, Apr 23, 2026 at 10:50:06AM -0400, Peter Xu wrote:
[...] 
> > > - Whether we have explored other approaches on page hotness tracking
[...]
> > DAMON is built around sampling. It is good for working set estimation,
> > but I don't think it is directly useful for eviction decision. It can
> > miss hot pages. LRU rotation will also loose info.
> 
> Exactly.  If we need to collect ACCESS bit (or anything similar) for
> eviction accuracy pusrpose, IIUC we need per-page info, we can't estimate
> by sampling.

That's a fair argument.

Nonetheless, there are some companies who use DAMON [1] for a similar eviction
purpose on their products.

Also, page level accuracy issue was indeed concerns from many people.  DAMON
therefore provides page level DAMOS filter [2].  The idea is finding a large
region of cold pages in low overhead first, then do page level access recheck
on page of the region using the filter, just before doing the eviction.

DAMON-based memory tiering also uses it [3], to avoid wrongly
promoting/demoting cold/hot pages in DAMON-claimed hot/cold regions.  The
evaluation result was not very bad, and a few more users reported positive test
results.

Also, DAMON can be used for page level monitoring [5] and open to changes for
users.  Actually a work [6] for making DAMON-based page level monitoring more
lightweight is ongoing.

I understand no one fits all and the decision is up to each user :)
Nevertheless, I will be happy to help if you have any question or request for
DAMON.

[1] https://cdn.amazon.science/ee/a4/41ff11374f2f865e5e24de11bd17/resource-management-in-aurora-serverless.pdf
[2] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#filters
[3] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh#L40
[4] https://www.phoronix.com/news/DAMON-Self-Tuned-Memory-Tiering
[5] https://origin.kernel.org/doc/html/latest/mm/damon/faq.html#can-i-simply-monitor-page-granularity
[6] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.com


Thanks,
SJ

[...]
