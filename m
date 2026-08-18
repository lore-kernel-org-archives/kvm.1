Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0435B5AB;
	Tue, 18 Aug 2026 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077114; cv=none; b=RjaI32BAGxueO/gWTYv4C9ZToOihnjh6RmUGeTlihplbihdkFWqD7zhi+vviOSS030WDIPW4JmjwMsjdZsvKsdIlbNbmCYRLhAGx5Zg1bV6utOMGlyCfvHoDrde4kBOClliO0g2cedPQQM4Hp044pHK+iPCIZEHpKe20gyKpPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077114; c=relaxed/simple;
	bh=gcGMQeye1GvDwotHSocWmsR6JGTyv2SiaDfnsW4qsZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GndS/6TV7dyndJ/ouwkBvj/x+rVakdfgRSMJ2J/orF0UoalEyEysV28Ax+XNRcwaHUFv2OlP9PKFbnQuL6fTV6bL3Mw8UUzTDcD9xL0eMMOj+nkm6cnc9DiMdyU0kTOVcCX1smXWMuqOxe10zeomu6ypjHbKI7ZvJdJJCeED/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp8x8hOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp8x8hOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EC41F00A3A;
	Tue, 18 Aug 2026 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787077112;
	bh=lHkgO62VARB1BZerT3cLWYX4fEgJZv19mZbLBDUYoks=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=cp8x8hOSSpz/sJye8Q4MMvhA8ZK7QujQ0rrdjr0GbGqZP9y2r+o8cf/WZN6UI7FwI
	 LnDTGaD0a0TK2lPowDdVJbV4CkSUAEY3Wwrmc9Ok4YvbGbEeypjgWAze154w3sXcY6
	 lIauGUEX+Qx3BLhY7FBah0nSL1A1t6H+pQgFdf3NmOJ/sNuhAKq5feEH9+4l/KyfVR
	 z9N31fia2WakSzVInaiahdWihqYxi4ot6SDiryHzxLLliZ4OsEY9J4zHIGwcX4AES3
	 ml7ldAgZmb8HtZhHkgei9GL4dyogvh/VfeLfJjNcF/p/+PrrObVXvKSrkLK0V32yV0
	 WOgzv1ynTcyGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2AD17CE1A23; Tue, 18 Aug 2026 11:18:32 -0700 (PDT)
Date: Tue, 18 Aug 2026 11:18:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <49df45c6-4d0e-483a-8acc-0ace7f9a6484@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca>
 <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <fb87f673bf290cad133d113dbb0750a7752b9d30.camel@infradead.org>
 <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org>
 <d0692500893f303906fba1d7d596eb59a07a806a.camel@infradead.org>
 <anydY25Cl78l1HfU@google.com>
 <932DB129-1794-4855-A61E-F4C2B54B1EE6@infradead.org>
 <b736237c-64ee-4eb2-8201-5685a3853844@paulmck-laptop>
 <5f6a0669f319951462c2aae3a50d595983a42e4c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f6a0669f319951462c2aae3a50d595983a42e4c.camel@infradead.org>

On Thu, Aug 13, 2026 at 08:54:44AM +0100, David Woodhouse wrote:
> On Wed, 2026-08-12 at 14:38 -0700, Paul E. McKenney wrote:
> > If not, please let me know, and I will put together that does the
> > job.
> 
> If you're working on that, I assume it'd need the readers to be known-
> atomic. So if any of the read-side SRCU_READ_FLAVOR_ATOMIC thing I
> already threw together is useful, you can find it in my tree at
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/srcu-atomic

Thank you, happy to steal pieces of that with attribution.  ;-)

My current plan says that if you have an atomic SRCU on which you
use srcu_read_lock_atomic() and srcu_read_unlock_atomic(), you only
ever get to use synchronize_srcu_atomic(), never synchronize_srcu(),
synchronize_srcu_expedited(), or call_srcu().  Does that work for you?

> Slightly orthogonally, what do you think of making
> synchronize_srcu{_expedited,}() attempt try_synchronize_srcu() first
> for an early return?

No objections, but one thing at a time.

							Thanx, Paul
