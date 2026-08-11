Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE03AC0EB
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462158; cv=none; b=MbtcYmK/HFSRRcFUGzZzQVEfO6fnAO6Ua5MXglhxHYPKBTephklO9hm148cyjfqSBUncFXMGJlwsFquFHsP5z5p9qsFKmhq4vvjYiI6uKhg6ZjJEax9MaJBlEZ6Nq22B2wxvzijZ7ObdCri1hNQ5G0VTyyAPLlOJMTrCB/1Ape8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462158; c=relaxed/simple;
	bh=UHHefDh2EvrnsEzLDkapnlP+pXYEV924LvKFh48lZrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du0EkPlJ0bkJbxhlHj08+p6/Z9CoWYQbsQSeEN2XFhtyqJjEl+rnhljdx7TKQXvrNrZrmaNuE+I8W+zGdTM5vBeukZ8evVPbEgN06Or+/RQB7WlH4QlDy+yTToTTVjO5BEYaT41/gskhN42V4kv60OUEfdqvC5G6owgQ9+tO6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K4yR/huY; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K4yR/huY"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f23e851626so6470426d6.3
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786462156; x=1787066956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PH0RdPEa3oSLEapGNLL6x5bM2qkhDfi4j65pHbraVdA=;
        b=K4yR/huYx5piiUWPAxoQ71jBPkQM9HMLizBEWmmc/jF9TOGsJD7yazTY4saTVlvF+R
         KW3UTB3166z5Z8+Rjo3IpFyr7RgzFjdlUVl19ux6SR4zmgBb/utZ301U8F4NN6M/1vDe
         xIlXslUEcTunLLdIeTIBDZRk00dkyAPKn8soCgw2WG/ZpUgI4pCtFpvrJySXRUVQq69P
         nKqyF2Rr2wx/Yk2Nli8vFCVdEqlUyqYAYMmZeEaYngyZu+mEkC53RMx/ZTFOdU88h8MB
         OqFoJiovga7u7obX3U9vePGpsYOXdWq2DLDGEnWbYD8NM3ojQJdchKNR81aOgJr8JsOO
         ko/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462156; x=1787066956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PH0RdPEa3oSLEapGNLL6x5bM2qkhDfi4j65pHbraVdA=;
        b=UCUlM2SF/j/hPGkY9444YV2VQCdIiTKL6OjL4I4Hgi0oxJu+Y6aKr9jG3pcSHUyWi7
         fYp2xHe50cuZStx1d1LIAujuEtLj6gEC4JJdfreOcR/w4WOXatMH/2F24KXnFHAAC89j
         vxU5XoKYLGYJE/xROQSLuL6nMEbYeXsnPzmYmfDRTTD2RqrVx41bO1Ptg2ZQikVYQSXB
         y3h1YLzDOWHhG3fg7nSlikHGqn7GqVP8trqPfmBOrF7v/Qw/ST2cpq8rqqG5jFD9C+cq
         +mxCv4+pVtmj1filxdf00XaZsMhi+xuZ2OTIFBpnmorIiQnoQAeffE3BF+ypzQTeAqu1
         +B4Q==
X-Forwarded-Encrypted: i=1; AHgh+RqRyxutAM3l2XdmOc0ul/tByx9Dj8SWc+MJ345UxJfilB2lckDc3Ab3z4iFSChvXw1v57E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSydSKYCGxpLvHRx9onicmJrVp1ENdFkQrdKtlhUjccHhrleDF
	K+YyiL0UB/AICwgNxSuunRmj0rRTZWkrhNmmFpFTE46QtP7pfSv+7XKSnI7TCUuh3rg=
X-Gm-Gg: AR+sD12yeteztfX6Cgb1nBjM37AhWmI56KpsgE9AJIgJTMbmp6rsgmeFzYZ5fSpoT7Z
	ERm2yWjEASdgdTCypkVcDDQynyMz+HDVt0kVylw5yOBEty5tl6K3Zf+NKq+5wTdzUaBKCIdsKPD
	dfVhAnTiTk+mA0ErDNI12B/uRFdRrvc52XkZCydhyh3Lwm7kpmhUVrRA+/mAcJ0TasaP2Qz2aIg
	M6i+3qQFWBB8LViC319QyxU4y3PIjlIncw/gt/MDPWBS38DgYT+GHJSLRBTX1sS2bQCBgu0RLll
	hgBgfbJzTKZl0yNewAaHigifJTTqDkqcXvQzGYFB2TcqFqZyAUfAakPklFdEDJ0QZ0QZzcclcsU
	0PrqwPgcoUmoo8DnVaSXbWSTEZ1jzPiQ6VJ4QU4jmV4klnhw6XKlPWQ92PdhyLAYwpHNOm3I47T
	Cv7XLMQ28SyIOP2qwe/C2HM4D3GXWTLL1x9Y1HHA==
X-Received: by 2002:ad4:5ca5:0:b0:90a:6016:deab with SMTP id 6a1803df08f44-90a6c0dc16fmr9015366d6.8.1786462155946;
        Tue, 11 Aug 2026 08:29:15 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3c1d73sm1372206d6.34.2026.08.11.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:29:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtoPi-00000002X6a-0ioj;
	Tue, 11 Aug 2026 12:29:14 -0300
Date: Tue, 11 Aug 2026 12:29:14 -0300
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
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260811152914.GI544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>

On Tue, Aug 11, 2026 at 03:33:18PM +0100, David Woodhouse wrote:
> > At the cost of completely destroying the mm shootdown performance with
> > 1s RCU grace period waits every mm operation. No thanks.
> 
> I feel like we're not talking about the same things here.
> 
> The KVM patch which this enables does *not* behave as you have
> described. Have you looked at it?

It does, it calls synchronize_rcu() from
kvm_mmu_notifier_invalidate_range_start() - don't do that...

> Nobody's suggesting that we force any *other* MMU notifiers to do
> anything that they don't do today.

Sure, but nobody should implement their own notifiers with such a
heavy locking primitive.

Jason
