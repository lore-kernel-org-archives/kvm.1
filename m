Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164B379EE0
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522394; cv=none; b=bCLczmHs0ldYh6nuvYFjxp7RjOxOCmxeffr2AkDDlyUl0yzB3IjtUi5p13MJ6q2hijxx8FWX0yxnNyDrrrGzRrZHg5qlqI7a+lhrJTmmyPlKjtd2uGSG24fVymsrS6tOv7wNgVtmoiB8RQczpUXxaaJDCfOROQCkdRZ6LLeDpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522394; c=relaxed/simple;
	bh=LZfvAz1OdH+4vvnegdGNwqfqI7AlK1EZetVAI3vqD3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC8FuUt+P1sK0/EB10KiZ55F/hbVVwZNsRIf8iyWQAgXNpK9vn+G49Uvtnq4Js9LG2JjViVNnZyWWc2vcpP0uaQSWNV25YSP90IFsuuT/gdx1H4TbKPiA+ZaIsZ5wKjigTv/8jJvFiXIlqr33pohyJeEsoLgjl5sBZh9hqlez5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aOTUngGv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aOTUngGv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4997581cdc1so5350435e9.3
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786522391; x=1787127191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ul3j3WGcIwdB94lLOJYR7d/dt/sRRRqyC+QOYhiAFkk=;
        b=aOTUngGv+Wh+SXlRAqgcU7heS9OD7v2M7lnPaQ81bTTCy0U06tcqB5PT6vID9BqaX7
         eGTxgoAfRxWhowfegqVgcl6pR45Gmt/I/IoETOxLZHlFGiApkI36n6sUCn3d3VWPqlaP
         kAJcu+KLgmMHwpBXNJmtBUecQHwyAX6BQ+EE8ijkPcL/5qM182lYveSt2LDBPpdxiyo2
         CPXuDGHg2jHtCLRIci0GQYKOeTyZgRbm/juRPslLnx6Hl2W94GUFau1GZa6oW+pY07/x
         cJSkdk4aGBrlDI38CgTMlSHw71LFi02BEoK5RStLq4ExaYzkwZT89ZPQC5dvoXnQEcgh
         6KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522391; x=1787127191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ul3j3WGcIwdB94lLOJYR7d/dt/sRRRqyC+QOYhiAFkk=;
        b=kBcHcBql4GetMpnU2ByjvIiwtpqHRwON0vVCzcb1b4L8FBDPuajr8Jnawmgx92phCR
         EaC757jAiqTLsj3LGP131hlkbId99Nd6vVTfafHGpF4FaDSXVVO2qJNOo3Z3BlosYpF5
         Gtlvy1xeljAgesIl5cUYXDeDW7GRKuIAWGAmohHPQq0Ik/ufq9szXUeQa54pdqnmvVLp
         Es39P7Bc3+f1iNYYL/jgkklweySHlEHdADLyIRKI/psKuQAjWgdqnqnArgpBLnIVinma
         mIz0KkyogEFWCjBZios/BTjSasNFVuSm3X2LLAlJJfs/3DkvzBftYYEn1MSCEdzILjDI
         Wp4A==
X-Forwarded-Encrypted: i=1; AHgh+Rq2oQUN7qMh5aa9gCmmrMdW26XXybhacOPe7oJkxndPqJOS8wPAVclidMk3HU+VAluLVu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3hSD//s740LZwyfPnTYX+4jbqewkTSBsROdJtSuAdKdjVGjl
	uxQCgEq6drnhkA8CuNUTJQcpB0uflDgcT1v2MtVmaUD3OcgfUflKw4+KxScebI1ljps=
X-Gm-Gg: AR+sD10OU4PE+Rxlo0/AND8mEuDexAH9WU7avFc/4hvj27/K+1GcAK65222f3Lma5xj
	1UyM84M2zfrbs4aCznXO/ndUCHb/d8LueeK2qswPKrNar6L77qwfO7V3nDNCddQwxQb9U2NTW0n
	c1jLOuyfxPA1EVapjRVkqoetF3Cu2MPhr4i0f6wkIzKafVA4kTMq7PZ8haDvB+HT3gprn2I4rCa
	kOppMfj8U23xGZZHJYjQydwxG/xj73aqL/0c7r3xSbXRM2jGL/nvKbjvLeFYnZrpeu3eQziOEJM
	P5Bdq3hF+0/Imoblswr54fyK/MKzikqfTaJRiX/w8P2DzDUntTnKoKPCWcQUGTP6Gaje0SnCPes
	lehAiO+ZPXrSvyd8egVcThG3A9Z9ZaeDBA0eaGuHPdZ1eup8PpqPGr9da1Tbs/Z8eMUGKS8PFwT
	qfdMmH42eaEMmBhFBJKF2qmS9Ayvnn05DaVNwovlhPKLeKoHSEIch+a2lF2iy6bPjF0fgHUF4=
X-Received: by 2002:a05:600c:524c:b0:499:7410:545 with SMTP id 5b1f17b1804b1-4997c145066mr36029645e9.12.1786522390781;
        Wed, 12 Aug 2026 01:13:10 -0700 (PDT)
Received: from localhost (109-81-23-83.rct.o2.cz. [109.81.23.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b237ab6sm26020375e9.0.2026.08.12.01.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:13:10 -0700 (PDT)
Date: Wed, 12 Aug 2026 10:13:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <anwrFZEKcW8bPJTY@tiehlicka>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811104229.72fdd928@gandalf.local.home>

On Tue 11-08-26 10:42:29, Steven Rostedt wrote:
> On Tue, 11 Aug 2026 15:33:18 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > > If might_sleep doesn't work sanely at all in preempt_rt then just
> > > globally turn it off?  
> > 
> > Turn might_sleep off? Or PREEMPT_RT? :)
> > 
> > The RT maintainers are on this thread if you want to pick either of
> > those fights... that was not the course of action I chose to take.
> 
> I guess the question is, what exactly is the reason for sleeping to be
> prohibited? In RT, sleeping is allowed in most context because most context
> are threads (like interrupt handlers and such). Now, you still can't sleep
> in NMIs and hard interrupt handlers that were not converted to threads, but
> I'm not sure that's the case here anyway.
> 
> If the non_block_start() is just a big hammer to make sure things are fine
> in non-RT, it will likely still be fine in RT even though it may block and
> sleep. But what it blocks on are sleeping spin locks that likely would not
> cause an issue here if they didn't cause an issue in non-RT.

Yes, this makes a lot of sense to me. While it is not really great that
the oom_repaer gets blocked by a RT sleeping lock because it delays the
whole operation this shouldn't break the "do not make any direct or
indirect dependency to MM" assumption as those locks are normally
spinlocks so there is no way to depend on blockable allocations.

So the warning is mostly a false positive on RT configs and what you
propose below makes sense.

> 
> Thus, perhaps something like this:
> 
>  		if (ops->invalidate_range_start) {
>  			int _ret;
>  
> 			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !mmu_notifier_range_blockable(range))
> 				non_block_start();
>  			_ret = ops->invalidate_range_start(subscription, range);
> 			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !mmu_notifier_range_blockable(range))
> 				non_block_end();
> 
> ?

-- 
Michal Hocko
SUSE Labs
