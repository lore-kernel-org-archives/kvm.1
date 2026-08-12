Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1172F7EE8
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550875; cv=none; b=f1WPg33D1x+dWr2vf7px6RckEMRMYlt54gXHRiCk1CSksL+TNTky/cthxGnenfbhItljAB25NfHLX4ty3+Y1RI9p6r6nXY5qqjDqtO17IqB8AxT2ERLULTwGgDz71YY/RWYNqfLehzJJphUfJ43ZkzQDR6lQK6fUml+7p9frdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550875; c=relaxed/simple;
	bh=8VjxuQ7/EdjLJ1RtGzwNw8ajISCRdqqnx1HQ2IWy030=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAkGCS8PYFex8T5mRIQhVo3ALPBwybmE5BDXknkcV7ZlWTd2KsXnVN/brZUMyCM0bkgVtDv/FMOazK3e7FnnhD9GqMCAEiBf9Mu70o44JRoYmW2NkEu/czoUkFgWeMJaqisYKbBviHtSmgfq2AsYzXc58C5tQSKXwF62JH36Bm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SUqXOSAs; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SUqXOSAs"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f256eaedf8so11043666d6.2
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786550873; x=1787155673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5LjMnXy9HZacJlswsSe7CtbuBRK5QuLVRHumX2nxtuE=;
        b=SUqXOSAsMLaYf9U8RlqvDZqnl1f1Dv1MHQDhr15ZO+mb89LxaByLvPIuJhPprByuq6
         Lp5xUc88v/KjCirWbPCGCDLwlenbkUZdkzUslIn7rM8MmxRc+dxsearHwP1QS5+qjhKe
         MP6I6y01zA0cyeU0aXQ/uNSvz4ujaE3/gUMbbbN2bzIdAUbOG75h7FcfBgbWWZCt9GGf
         kF/QWzY3l9SkeGEN+A/ZtZSlaGV4KW3dly3+HK+/IoQgKOLqcg8B5nT32MURPjWmkF9k
         GO7XcWnyWAs4920NN8eWUx535Pl9uZM1akov2hm70kdJM+XeaRWWsF5IMRNCPdWPVBCc
         8l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550873; x=1787155673;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5LjMnXy9HZacJlswsSe7CtbuBRK5QuLVRHumX2nxtuE=;
        b=ld79/uoXL4Oj/conulN5473hoLwailT0nNvnHfQyeau/cfWEROhGskQjoH8WejbxqJ
         /94jTrDjhsUaZfjEX1JuehNkhj22JH4vQaMW2340RNBVpOJd1iETVsEWBkG+0RUySkdE
         a+gGEzOaUIS+/tPkhPmprMTLmJqdWIiS277fl/CRYTrcEooT6qIzG1ga2YVVLOsQAjO3
         2KsxU4jjZsi1hsf0+N38ZJzdMiqPIQ68gY7Y1n+adA1sDDjms58S1hTkOw2S0Sv8zQw2
         P6jlCrrDzlQ0lr379VOw/i/cqbe9hQdO+3EUGgs8MQ/tcmFIDlGRUuAZDpNjwaBaWYoj
         lJrw==
X-Forwarded-Encrypted: i=1; AHgh+RrvNUX1b+h3cltBOZl3yMVsjfvi68XT9+yoxHFQsREVHhgfvRid8XQ1DP+L+AoRRhZO5aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXb6bMBNUyEXicQh9EcId+jswehlKO+uU+F5sDou9Y0EEEaFQR
	fhPCydqIhuUCWwuBCA5atiNyP/Xa/blLFgqsFwk7kUFIFQpeBIoVk63rNpdgbACytqs=
X-Gm-Gg: AR+sD13SZf4djoXzfWxFKUf291ykSyjrFyCJnLDEzCVwxwDU/kgVvHjNgOhHVuIi6C/
	a8n+lD1u3kn9Ic5dkBlf36Y6wDmQIlKbueOAkdGIvRP1B/JLDGR4yUZ/9KmEXbUSBxsnOg8F2DK
	dCtLmSDUkxTEyykq8oTJe3iSC/v8tfjV1MccnDJ9XFnX9126qssXOzVaKAx0NMRnHnXxYIt5xxz
	UTjcubc6OL/7/nBt/h5BFeruGIEtfCVHNdr7ExTSVIqqNaaert4CDBfCGwHGpmXKicrnROwEP4/
	pLKaiql15n3QScU2KCqmpiNv3MPnBjYBFB9NQH5h06XFzU6FxNMOs1kF1QYRdKl9f4dQkEhA/8Z
	iaKI+thkrz4SjSwbKPxPLPi0szerH9Zs3XLlVsfAesmtTERFzLIFIILDhf18se2bwuIg7wQLBJr
	MDQPWcrw496rxuvtzKGf+MivgcS/4GVxArwvxT8Q==
X-Received: by 2002:a05:6214:f07:b0:908:23fd:8147 with SMTP id 6a1803df08f44-90a7001868fmr51143086d6.23.1786550872775;
        Wed, 12 Aug 2026 09:07:52 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3ee3a7sm24135746d6.44.2026.08.12.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:07:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuBUd-00000003DHb-0qab;
	Wed, 12 Aug 2026 13:07:51 -0300
Date: Wed, 12 Aug 2026 13:07:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Michal Hocko <mhocko@suse.com>,
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
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260812160751.GE662699@ziepe.ca>
References: <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka>
 <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca>
 <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca>
 <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <fb87f673bf290cad133d113dbb0750a7752b9d30.camel@infradead.org>
 <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org>
 <CABgObfYjdQ13Gd9AH-kck85ZWch7j_E00rajawFuRdt5D=m3Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYjdQ13Gd9AH-kck85ZWch7j_E00rajawFuRdt5D=m3Sg@mail.gmail.com>

On Wed, Aug 12, 2026 at 06:04:47PM +0200, Paolo Bonzini wrote:
> > + * Atomic-flavor readers run with preemption disabled, so every
> > + * read-side critical section is bounded and running (not blocked) on
> > + * some CPU, which is what makes spinning here sane: the wait is
> > + * bounded by the longest such section. No index flip and no
> > + * grace-period sequence update occur, so concurrent call_srcu(),
> > + * synchronize_srcu() and srcu_barrier() are entirely unaffected.
> 
> Making synchronize_srcu_atomic() spin in CONFIG_PREEMPT_RT is a
> slightly tall request - it's basically putting it on the same level as
> raw_spinlock. But if the MMU notifier guys really want to make OOM
> notifiers atomic, this would be basically the only way to do so.

IMHO it is fine if PREEMPT_RT does something else, just that the
normal cases should follow the current arrangment where it is atomic

> If instead it's okay to remove nonblock_start/end under
> CONFIG_PREEMPT_RT, for RT kernels I'd rather avoid

This seems well agreed at least

Jason
