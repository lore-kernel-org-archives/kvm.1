Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B7372B2F;
	Fri, 24 Apr 2026 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026892; cv=none; b=ip7UWt/LHR1KfDoYLf3A+uOc6ZvjiUmjB5ndcJFNGqHgJshZREUhzIz51dV/1ZvYpK5w1LjD7nreyVByjEopALKttSh+MwKLKDuv25qTCnKtOyia/D4mKotdnN8GuZMycFoTbwxti5Zt0W8yyN+X5HVqGdQsymUeiDcehXAC5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026892; c=relaxed/simple;
	bh=PEyb6FtGbI/y7wrR0DER3IIKFWzjINJX60KL18Yzo7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeN4/272nY3WaizD32SVJcPzk6ooQ96SAdJ4ioKo94lT+jRtio6V0v1BCTwTNRTWzcS2/NMBBVc1vU7uhX7aGEEz0OWnJA06US11avaT2qktPHmJjS1e22BJ2YflBhn0dtfEmPxUjH3XvD8ulE1WJXBqJc1o6uQ8D3X0LMWtHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzPE19aI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzPE19aI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28940C4AF09;
	Fri, 24 Apr 2026 10:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777026891;
	bh=PEyb6FtGbI/y7wrR0DER3IIKFWzjINJX60KL18Yzo7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzPE19aIZMgleOj/9Q7vqfwN9bsj9eXevrDOI8GRSdwxw+lk6cdJetqiieBdiQveT
	 vyjhKFYAWIx0OboZGTxjR7SxzElRboGrqBA7wyqsAfh/A2rzelHLROqcleYL3Mrkt+
	 YNmCNLzcKDtYT1Rax37fg649Gx74TdctTD1h6EGbXlEuJ/Xyi9uQZXbVbA+RADYK0c
	 UwpFbbq8bpY7D21KSX5uN4EkXkTAg7SsT8YLRmg7y7HJ47lL1HYnUvyhTeU4ZWmPeG
	 /TM3uIQvoOg5FY4QfhVQdAwCo8tSgVEmXMkkgr9tOXhduJeHAT7oP4UoFJb/JzORLv
	 6y8HrPtoEzLQA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 38E5CF40068;
	Fri, 24 Apr 2026 06:34:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 24 Apr 2026 06:34:50 -0400
X-ME-Sender: <xms:Skfrac-9Tfj0ayWIBJIyngPd4UlMGsnZuiY2Oelqutif3fZ89iuzgw>
    <xme:SkfraTNg1kxr5_buB3DEXyDvBCKG4GgTfo0nWqyAN6dyJ9vDnG1M4d2_CcatbFkHf
    uC8G8SDCtNyHrsZb0n-pTk_58d3N0hdZ5Zueu8mn01R4yd_aXmCjM0>
X-ME-Received: <xmr:SkfraYMAqtZJXSqD1tnl6ecYoMkMELXZiL5l-qals8ZbGO6s1wuIwfBVKC0ypA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepiefgvddtkeevjefhhedtudeuueeikeejkedvgffgtdekgeeiveejvdegtedvhefg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopehljhhssehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhurhgvnhgssehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthho
    peiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:SkfraROW4DK729VqpkvKr_9pXjP4KoM5f2Ijx0pGvl9ajs3wr547_w>
    <xmx:SkfrafUWOGIT00cIGKIOwesTuYnJ7J989uaVVotDzWIgsw5j_hZNsw>
    <xmx:SkfraZrqDgPEAmJatscUh4DMeUJmyMI_-RQaPUOMUT-77ArD7thZGA>
    <xmx:SkfraVeHg_mWZ1zZqHIOmbwfIE1rZc8UvSJL51nsn7j2yohQ9UZJxw>
    <xmx:SkfraVC1daTB8U6MHmddnRPSUtC-87Qe-I1RWKoYXacKv5v0ffkmLpEm>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 06:34:49 -0400 (EDT)
Date: Fri, 24 Apr 2026 11:34:48 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <aes7b17nG0cXrtEd@thinkstation>
References: <4c635703-3d8d-4cfa-bb98-7f6f5fcbe547@kernel.org>
 <aeImfRrrvr3UoKtL@thinkstation>
 <aeTnlQUOOh-dHG8z@thinkstation>
 <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>
 <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
 <aeorZMvKwu8zKX5i@thinkstation>
 <aeoxnuGKO3uqS2kG@x1.local>
 <aeo5IPpQi7onyjTF@thinkstation>
 <aeprnnccJeyHB2rt@x1.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeprnnccJeyHB2rt@x1.local>

On Thu, Apr 23, 2026 at 02:57:34PM -0400, Peter Xu wrote:
> On Thu, Apr 23, 2026 at 07:08:00PM +0100, Kiryl Shutsemau wrote:
> > > - Whether read protection is required for an userspace swap system
> > >   (e.g. did you get time to have a look at umap?)
> > 
> > I looked at it briefly, so I can miss details.
> > 
> > IIUC, in absence of read tracking it doesn't collect hotness information
> > at all. The eviction is based on fault-in time: the oldest faulted-in
> 
> For example, let's imagine if we can have a per-mm idle page tracker, would
> it work for you to collect hotness info?
>
> The other idea is, no matter whether we use MGLRU or legacy LRU, if we can
> expose a better interface to share hotness info from kernel to userspace,
> would it be possible?

I don't see how either fits our problem.

Both page_idle and the LRUs (legacy or MGLRU) track accesses on physical
memory. We need visibility in the virtual address space domain.

We don't care which physical page backs a given guest address at any
moment. We want to know which piece of the user's dataset is cold, and
the answer has to be indifferent to kernel actions underneath: the
tracking must survive migration and swap-out. RWP gives us that — the
uffd-wp bit is preserved across swap PTEs and migration entries, so the
"this VA was declared cold" marker stays attached to the VA. A
physical-side tracker loses its state the moment the folio is freed or
replaced: a refaulted folio is a fresh object with no history.

Scaling goes the same way. Per-mm tracking of the form RWP does can
scale with the working set. A physical-side tracker scales with all folios
on the LRU/memcg, then needs an rmap walk per folio to map back to a
VA — which is exactly the reason page_idle doesn't scale for this use
case today.

There is also a cgroup-level confound: memcg hotness mixes guest memory
with the VMM's own (worker threads, I/O buffers, vhost-user rings).
VMA-scoped tracking is the natural unit regardless of the migration
story.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
