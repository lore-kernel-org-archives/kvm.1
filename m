Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA93242AB
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458456; cv=none; b=Vwu8AkrnOtJdnV5Awd40fVy4OA1JzTugjLFmeCAJAt1qiyLpNfzcPhfOTXtNynY/ylwrVeEC8EO7ElXcu0Ff1gdpp4e7va0XX5rVhS/gt8pDAf3stsQEVUq22ZMVQs680q8AoqNwxSfIN7cKawQg+Sp6wpQ5koQUbxxwd7WYL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458456; c=relaxed/simple;
	bh=S1MnOpajZIuRKJeZjsd/WdRxI/oF2ocNH/aJeyBhuMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhPJwriWGRZX4EkhUZgnSPLfbia5RBbEKUJphmeWkNt6UCwEkycUx/uK2l8IfUQhT4UnCfxwK5Af+yuiyffD71nNpQ6Z23ArBVMfkZTa5Devi9QjHl0APAI4k0fj1j0Ji/ksdbAwTYK8uXb6pE3MeDe1F+Pn90rli+EpDjiqtNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dbB7+sak; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dbB7+sak"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92f0b5ed131so233989485a.3
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786458454; x=1787063254; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yGh0jdU9hH3pMDac+rBHolUofOnAZc4NvBka4kqdBBE=;
        b=dbB7+sak40pPnRMPCKfyGL9fk2C4XP85WbbO0XvS7oiplIMQzZ9ZMVREd8gxsmiJDl
         CGPDOVFKQTqSbqWd/la0FNTF67FkUqJUNp2hzlh483mpKDJnGp5NeJ+3H7Kw29iuZ4ye
         6W4I3giodel+k42aIDd+NcA7SHqrzSoT10isnVs0k6HCLZZBsOf9/AfsmoFCDj6cp6mS
         R1lkEpTJ1+OTl1FnkWwfgVnwq7jFsRslT3VFKuB6Q3pfpS3NB69g1enhQh8pl1zRSCSv
         MO0+lPHNFiQ3ImmafIWOoyIW6QSRn2HxQ74T+kkDvFB4CDoHAJqapHktVpbiUclOKHBd
         NHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458454; x=1787063254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yGh0jdU9hH3pMDac+rBHolUofOnAZc4NvBka4kqdBBE=;
        b=enxjkq46cblo9h/4TfT2j3U1sWzZO1ohCIBBv54AQZpEBNBvN9V2dEIJ6+KIAnJ9Wc
         6F4FlLS8CMYJW+aTvtpIKCJz9+UJOY4iUlGcGgBu8RAwZg8kRwh6+OKeVdg06fmoA2Sf
         cpdqGvfVTojoIWic87PNGhIXh4BwF8hOnHQXXnHhWDclRyivEivFJkfW8BvlvDD6tffr
         xX16Trnu/rdRduEyGJ90r8cYxcvZjkTeVO2H7z+hgKezlbHPaDjZsA4Mg2tSSWVcYEuf
         gZe05Q2tnIoXMN9hYhkYvSV5tdadKSAywdo7o7eI6sczL3Oi21cfkRH1zz/c6e6s2ePg
         ISKg==
X-Forwarded-Encrypted: i=1; AHgh+RqqmS78ZEFJDvdjHztgbe2WcxNarb3BW0Bh7nYPPDsXM6ix7mHmJzgg1cCPNrnDuLg0JOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD2O+hKguCqh7reqUd15CvXAypQhFiA8CJyw8gMKNv27R5BpIO
	Pan3GOLUVC2gwNvPMkFoyO+6JslTCSVhe/jWMigMdB4L+Jik+jG9xqjBOKsZ6GSzEwI=
X-Gm-Gg: AR+sD13PmHzBno3nhrp2B4ERKl9+Dd1RgOELu49iFWQVMxzroovhbSiPK5FLo2S/4f6
	YO3Lgo6gWK/KbZow/H83nMduokz3A9T9e0uxhQAfZ+TnL1hV7cn2L5Y7zNP8Ymasknev57qNnhu
	jHlUSoknrjm5ex043x16CzHLpVZRSwZQkV29P3gmKMNBnTbpXNULEslt3zkxq3c1zuBIwGMNssS
	M4qCQ1KKsZxb7BQSPraj3o+GHpP5LXAYbzTt5bqxMCswzqwpqUhMLfnU7T96nvxpmNhyDsUiBpg
	gpv02ebo9jwTxGqPAva4Ki0V5sQ6xFcFCq7jdifq61DIUcI2ad+gYQhXhaNhsIbM5X0zdtIN2Jt
	Dq+f+ysmAoKtzTNvj1Jri5YjpSufMTJs+FFVGlr495ZIxJnL4cj8b8gWbM6qQPfplTG4l9f6PFR
	vr3MPs9G3ky8PkT+DbW/FIBIfCE1bn2bM82yIqrg==
X-Received: by 2002:a05:620a:4549:b0:914:bd27:2d1 with SMTP id af79cd13be357-936a8edb650mr322022485a.11.1786458453669;
        Tue, 11 Aug 2026 07:27:33 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936a849ed87sm122584685a.15.2026.08.11.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:27:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtnRy-00000002VR0-3Mpe;
	Tue, 11 Aug 2026 11:27:30 -0300
Date: Tue, 11 Aug 2026 11:27:30 -0300
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
Message-ID: <20260811142730.GG544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>

On Tue, Aug 11, 2026 at 03:21:35PM +0100, David Woodhouse wrote:
> > >  - On PREEMPT_RT, spinning locks become sleeping locks, and perfectly
> > >    legitimate spinlock/rwlock usage in notifier implementations (e.g.
> > >    KVM's mn_invalidate_lock and gfn_to_pfn_cache locks) triggers the
> > >    splat despite having no allocator dependency whatsoever. This is
> > >    reproducible today on a PREEMPT_RT kernel: KVM takes
> > >    kvm->mn_invalidate_lock in kvm_mmu_notifier_invalidate_range_start(),
> > >    and if the OOM reaper reaps a KVM process the result is a "BUG:
> > >    sleeping function called from invalid context" from
> > >    rt_spin_lock().
> > 
> > I don't know anything about PREEEMPT_RT, but this seems like an issue
> > with RT if a traditionally atomic safe functions are now triggering
> > might sleep failures?
> 
> I can sympathise with that point of view. In fact I've spent the last
> couple of years mostly ignoring this "problem" and just blaming RT for
> doing exactly that, but I don't think we can really get away with it
> any more.
> 
> cf. https://lore.kernel.org/all/787aa26cf62dfd361eea8ed19f384fc517892501.camel@infradead.org/

If might_sleep doesn't work sanely at all in preempt_rt then just
globally turn it off?

> > >  - A notifier implementation may legitimately need to wait for an RCU
> > >    grace period before allowing the caller to proceed with unmapping
> > 
> > That's not allowed. We really want to forbid that, it is not an
> > acceptable way to implement a driver using these APIs due to
> > performance.
> 
> Speak for yourself. For the KVM gfn-to-pfn-cache the performance scales
> *much* better with RCU than with explicit locking:
> https://lore.kernel.org/all/8f41cb82b7c99d5a3d1dda016e4841326b4d8a52.camel@infradead.org/

At the cost of completely destroying the mm shootdown performance with
1s RCU grace period waits every mm operation. No thanks.

The unstated secondary purprose of the atomic context is to force the
driver implementors to make sane choices that don't degrade the MM
spectacularly.

> Perhaps we could find a way to push down an *accurate* sanity check
> into the code paths where what you say is *true*? I guess it could be
> done with a flag on each notifier? Or *into* the notifier callback
> function(s)?

I think it is right and correct the way it is.

Jason
