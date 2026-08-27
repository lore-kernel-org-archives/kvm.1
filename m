Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C33C3C07;
	Thu, 27 Aug 2026 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818830; cv=none; b=VkFGZP/HBNq46m6WB5q/JOJyejSRYJftbI7D7/CMer1MaA+AMYQEghfxUUeInBFciuj3mJ/2e7Vlvv4App4JK8/gk11W5TqXA3CypMpQ4qkvmCFSnNzYPrUGgf/zpVYX8mAvcDK7lOkYhqSXS74Fbb7v2xVh9ZS/EIZzpwHUf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818830; c=relaxed/simple;
	bh=SV/m4iYNW87OXTbwLv7lP42wYFhTHG6yO/9HHGcZArI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqs+W73VRk3X5h/26MPYbUFnDmfOrFtDLleOFG9cHhUkDE0wzKYDz19QJdDpYeVHWrMqsGDVf64gZsl4cAcMHV8Y5RRXX4PfEoQkGKXeQ1m0CBOQnXepCuj5jrRBx2s8wQad6mfRXx27xNGZkPyl6sPBaKkJgnCvhocdoDsuqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xEMckJcc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/xHz2Dwu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xEMckJcc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/xHz2Dwu"
Date: Thu, 27 Aug 2026 10:20:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787818821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dHKgEcpAnFM7pEhWpO1E8wnd+7B5JBIywxZU+obwOD0=;
	b=xEMckJcctN+XyCF3tP1A7kB3Z9NMqkOr1WP3u9eNx0R1d6VPmDAbkfzv6Dz5L6rc4iPDAL
	DeTMebaCG9CYd60ZBy6/6oyFrOocGDegnbcEVpSCtOOxRTmp89Tc7fP2j9Jfwx1X3iSEr3
	vfg3fbcnrSr6VMLGvtRDr7LRYO7vMlHebLP9UMnFoEz3x5z3PqRFdQA/dGiGAceQ7kGREX
	B3FthaoTCt/827MpvioWnToPzvvNkcrRmQeEzocpdKAI+bB3Zz4jCENu/fNmn4DSRgK5+s
	gQKshKN67amzT1FdkuYnlf17RNxG4BlGjMnJafxaU6KZGBY2ee5SSXKE7rYqRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787818821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dHKgEcpAnFM7pEhWpO1E8wnd+7B5JBIywxZU+obwOD0=;
	b=/xHz2DwueZDiGs6En/mm1IcQyzO3s2+iRZ1dFAnSt6ypCR7hibiWxWPyikRCsxBcAbJWib
	mLu+1zK/ObCQ8jDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Jerome Glisse <jglisse@redhat.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260827082019.xrNuIfE2@linutronix.de>
References: <ao3z7Rtw2FROkVpy@google.com>
 <d4f8ff92-08ac-4253-b647-f9e95c66698d@paulmck-laptop>
 <20260826073233.T-KtFXmj@linutronix.de>
 <da5ee56b7d082abfbb20f71be99a6885247e9811.camel@infradead.org>
 <dbbd6634-4da9-4ecc-9fb2-d7430e2743ca@paulmck-laptop>
 <98e123c9-3dc4-45fb-815b-881b3346741c@paulmck-laptop>
 <ACC45EB6-F881-4EE9-A9F8-D53A2B921FEE@infradead.org>
 <e62a7362-7dd0-4615-8877-6ab675971ab2@paulmck-laptop>
 <06F9A0F0-2177-4173-A201-56325A73F89B@infradead.org>
 <4415dbf2-10b0-4cb1-b045-13dbcd69c5d5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4415dbf2-10b0-4cb1-b045-13dbcd69c5d5@paulmck-laptop>

On 2026-08-26 14:04:32 [-0700], Paul E. McKenney wrote:
> > >Anyway, easy enough:
> > >
> > >#ifdef CONFIG_PREEMPT_RT
> > >DEFINE_SRCU(whatever);
> > >#define my_srcu_read_lock() srcu_read_lock(&whatever);
> > >#define my_srcu_read_unlock(idx) srcu_read_unlock(&whatever, (idx));
> > >#define my_synchronize_srcu() synchronize_srcu(&whatever);
> > >#else
> > >DEFINE_SRCU_ATOMIC(whatever);
> > >#define my_srcu_read_lock() srcu_read_lock_atomic(&whatever);
> > >#define my_srcu_read_unlock(idx) srcu_read_unlock_atomic(&whatever, (idx));
> > >#define my_synchronize_srcu() synchronize_srcu_atomic(&whatever);
> > >#endif
> > 
> > We could do that for the KVM GPC locking, but more consistent would be to change *all* users of the 'atomic' lock under PREEMPT_RT to silently get the sleeping version instead, like PREEMPT_RT does with spinlocks and rwlocks.
> > 
> > So it's srcu_read_lock_atomic() itself (et al) which would get that if/else treatment.
> 
> OK, the traditional approach is that raw_synchronize_srcu_atomic() and
> friends with the raw_ prefix are always atomic, and without the raw_
> prefix it is atomic for !PREEMPT_RT and non-atomic otherwise.  You would
> use the non-_raw primitives.
> 
> Easy enough to do.  But does it do the job, both from a PREEMPT_RT
> perspective and a notifier perspective?

It does not lead to any lock violations so that is a plus.

> And notifiers (though a different type of them) were the first use case
> for SRCU.  ;-)
> 
> 							Thanx, Paul

Sebastian
