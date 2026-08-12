Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F345DF6E
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542578; cv=none; b=JJpvSd7t3rtNYEogTaL1USAtZVRIQa9tIKZ98158FUtLmqcdYwllehl2EMtSHawbIG16VB8w+O+WqTRrVTP2duHESkPlTfokNNokMJnI0KPI4k7wANC+QVvpP+hsv1aFoJUFerLvM/S6w3RH2Dud5o5SPTU+87R3HY1ILQvg3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542578; c=relaxed/simple;
	bh=LvwifihpyQl04XWVsmiC/g59oClWiM8qKJQT0nS9CgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncRMesJkwAhrlapfywG5l+h2Qm1H4BqRlvKwdyAP01JO8+RcOyfS3yyDh4rZPOhTBKas9jm4Vl6HPyuD1ZVGac+fRYL3Nf1LSq/9a4yOo+lLbheTiAYUkqzvEC84qmqUVIfsQM3udor7ox0IBW5bf2UKAZQtKgbIVDvctLwv7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HoEfNc5l; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HoEfNc5l"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-527e352a167so4624651cf.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786542576; x=1787147376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kc4Afb6aXWQXjmXmnDB66MIWvaDryZWAnPWngJIIDAE=;
        b=HoEfNc5lyU/Ll7hN0GPE+9hljvoua4Qpye46SRrlgLYSsFB08P74Cw+HiY95R/9SKR
         KrjVHI6m6PmEeRl/FWnaPIF2smRTxGXu9Jt7rKg3FIx+sOfPF2ij88BPp9JzB73C1g82
         fI452m4cyK7obORK07nYNN8pedDlhZa7vvaEXF+bY+pvg0vyK/qR/6PlTH8ikXeK2XRR
         XJRCIiMVfeY48NSOJlzxjHvMxFmUJLZsnksLcS7Se52daZBJ2VCfSyLNS5Dj7GMXfp6e
         +mAuhqq0FTddib/3Wb6/F7Jdql6e7XWizRh+RzqIOsPRK9aCmpYPbQCTXJ9BLnoLI7xI
         rlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542576; x=1787147376;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kc4Afb6aXWQXjmXmnDB66MIWvaDryZWAnPWngJIIDAE=;
        b=kmyrPXuUOjDk7fv1WquHPkRCcxCgkVfbAlivBa1UCKA67Ib75l933aOIv1hJ6OZoRw
         F2Puh4s8STx/k7QEfvUPWFzhwlL23uSf/OYKnR/VtWnfL33rli6GREZIoPBRk8iVvBJS
         UdP/oROauCMF8qPBZcgGoJsOFh54yXvkaq8gfrXBAUH0pwbUZxpdDEsO8J4Bcd6tgDoj
         TN1eW1Vqe2G/GC0i1pupd3LAEcamJVi+d+eWS2oQFBVXqlH9foNfV3dKkahVOyyIext6
         +n36P/Dx8O3J6P7r1HzUrU+cz/phAllXs43uD210DXJdQsbuVm28HpZh/Q21FtMqJLra
         12Qg==
X-Forwarded-Encrypted: i=1; AHgh+Rpfm/3sKcHY9tqr8a0Y6pphJcS6WBt7ze2dH/ydAITOFH9eS5XovZWkZKXP+xm3OzItIBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXtF4w1usBZacu8tC24tu+BV7+dzvGl6MNRdy5hwn79wjIy2OS
	Z3qun3tafzbc30AzjoDQ/nCyiMKH58nuuxRKax+rxsFXduSN0hhtNzs5iJ5Xs7B3awA=
X-Gm-Gg: AR+sD12qiA5fU34asv1iutkqUxkLVbvvAwevenONtFyymWxDFjyJtfRbON2xN7JSH8n
	qRM/cLuUZDK/9uBgS50prmyfzL1Cv8al+NbaLNw91R5eiQUYWPXeEsRKxh9q5WbaC8Nu8gFS0sA
	Mb1vNNyXDs8Um/c+fMWeT6GCr6OfY3hFTi95IYPPaGdqh/Xh4RQZcNe5yWod7sC7fFgfvkCqTiQ
	AUH9HFIvx3DR+nMfUZQyHYLofgDuZLG/jfipIel3V7ywGMN9QSWkd0azqWfPt/JekwCpoP9Dksi
	MPxKyedh+YnN8Ugibj5Do8wV3BmeeVd1GXIl7HmaZncakr0mw1ehWmtVLxImFLoO7CG0dgMuekd
	pJ8ADt5Q1bDIrG0TYzgKEOcvjJ5bqPi0vhFSkA0tpc89P5Vj0MJLQL0cX93Uc4NzNXo//64x/B0
	XmW0JZUoQMD9sM3gQ7QxnlxfQUagQGr2ZBS6MJuQ==
X-Received: by 2002:ac8:7f47:0:b0:516:dbf6:f8e7 with SMTP id d75a77b69052e-52d646fa46bmr42007131cf.17.1786542575667;
        Wed, 12 Aug 2026 06:49:35 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61c0821esm18333021cf.4.2026.08.12.06.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:49:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wu9Ko-000000033xl-0724;
	Wed, 12 Aug 2026 10:49:34 -0300
Date: Wed, 12 Aug 2026 10:49:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
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
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260812134934.GC662699@ziepe.ca>
References: <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
 <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka>
 <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca>
 <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>

On Wed, Aug 12, 2026 at 02:46:08PM +0100, David Woodhouse wrote:
> I hear you. I'm less sceptical, given the use case, but I'll certainly
> concede that the universe is known for inventing better idiots.
> 
> I'm certainly not averse to having a wrapper so that the read sections
> don't just srcu_read_lock() directly, but also get a sanity check
> (non_block_start? local_irq_save? what would it actually be? does it
> have to be different for the hardirq vs. process-context invocations?)
> for free.
> 
> Or instead of a GPC-specific wrapper, do we make it a first-class SRCU
> citizen, SRCU_READ_FLAVOR_ATOMIC? If it disables preemption, we'd know
> that lock+unlock must happen on the *same* CPU, which could potentially
> simplify my new try_synchronize_srcu() and/or allow for a *spinning*
> grace period if we really do want that (although I'm unconvinced; it's
> *latency* we care about here, and punting to the WQ when we *already*
> have to wait is fair enough).

These all seem like good ideas, then you don't need to touch the
notifiers..

Jason
