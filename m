Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C051F09AD;
	Fri, 24 Jul 2026 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784852118; cv=none; b=SE334VeqIE9BTmMFx/3ja0qxksWK+YjiHTu7K/nppmiHz76f1JSL9thSq/K5MWdcv8CtcMqoUR9Cxb23T1TP+uwomAMmMSunxBWxAWIrInGwbSEmf9jvl4sXJY+xcy1gnJnJxjUNs9XOfENuBr8CsqGlrSVspy2YV/Y69cpaYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784852118; c=relaxed/simple;
	bh=1g06K9gyGtl1lv/yuZaA3HQ3R/lwVsoKMcItrriBILg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kxsiU95AWK9WgbinBDF+Zv1b0ZbZ9BUKyPoyiQHCbFYEgaMne2/CD7OcZIQiTZCStN3zTb860ClSriU4suigDixh6tEhQlvQAXmeD9NCARx6QNnsQ1Fzwaz8o3xHCNwtlchXXUdaR53uQDnb0GyA202+pFlllgwn/xa5pMetCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QZDSnRYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QZDSnRYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9171F000E9;
	Fri, 24 Jul 2026 00:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784852117;
	bh=Y5aYK3g7NYOnUMQLXgxW5eDWWXLVLMQ0qcKu8Hb6xp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QZDSnRYopXKAJMRYUmq5QTkslx6Kh9jmh3HWibjIAp+ME/RfgEQBlX9t25t75zs0k
	 0F2rSaC1mFzk4YlMjOSHAJ6mC1v/YxZ6J6YUTP/SNlMo7E9J/gWzbDhDwoeoSzEkn8
	 xwxRkzO1dZQfsB92x8fYnXHh6cOrQ8glU21g9Z+4=
Date: Thu, 23 Jul 2026 17:15:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sean Christopherson <seanjc@google.com>, Yan Zhao
 <yan.y.zhao@intel.com>, pbonzini@redhat.com, David Hildenbrand
 <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
 <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Neha Gholkar <nehagholkar@gmail.com>,
 kvm@vger.kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
Message-Id: <20260723171515.b5ddbc59c5c36ad01ef8f7fb@linux-foundation.org>
In-Reply-To: <amIrDncrL4K-JRBO@cmpxchg.org>
References: <20260629163337.1264881-1-hannes@cmpxchg.org>
	<amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
	<amIcXrS7nGX-adpG@google.com>
	<amIrDncrL4K-JRBO@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 10:54:06 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> > But in this case, IIUC, this change will "silently" enable NUMA balancing for
> > shmem-based KVM setups where it was previously disabled (albeit unintentionally).
> > 
> > I'm not fundamentally opposed to the change, but I do worry that downstream KVM
> > users could be in for a nasty surprise.

It is a bit concerning.

> This should be very visible in early kernel validation after an
> upgrade. VM hosts tend to not do much else, with VM memory dominating
> the host. You'd expect a significant uptick in numa_pte_updates,
> numa_hint_faults, and a change in per-node nr_shmem stats. And the
> patch subject makes it trivial to find in a commit delta scan.

Is there anything we can do to make this process less painful? 
Documentation of course, but what about detecting the situation and
emitting a once-off warning?
