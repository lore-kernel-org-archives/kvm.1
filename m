Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFACA3BCD15
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465467; cv=none; b=JwfT9cUaHlggkdze9+UKDsNl4ZxyecYb6RgQikMEgIFmfY33Y1AxgOKp03m7se/JL635068tMZQj9QWZBEVFzjSarjUkC1ZsR654zrgn3+WLGewZXWQ8gX+d6Olvuo08ZSEWNe8JWwh1dnpuf3zYQI24iu/r3V09L7R62DBq9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465467; c=relaxed/simple;
	bh=HwC3T/puzehhf8bSut7phAm1yYtmjq0Oh6XDbBl2A68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlpBf2Xsx8Qi62dyuhpTc8zK6eE6gSr41TsrCPxJsPE8yuxBxArWlgO50Nbs6XDSTnW+z23IKpwRHUZEMsEcGFS/t/Y/m/b8gkCZX0SsJT5b/zE+OKY1wMi9c8xZM8WMx9+ZMOUWiB0RCP9aOhiB4ebpI4K7P1xMKVpxol66uKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XMRiV+3z; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XMRiV+3z"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9063b380982so180206d6.0
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786465465; x=1787070265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ge2DKXL/0cigzsh3KdWGGLhQNvufZEJOXUsvNTDWwxU=;
        b=XMRiV+3zHn7csMteo7qplcPoE0IJjjaZOqOxsoSP1uyWa1jOVvdePlhXC+eOKo4bw/
         1Ktyf+6oXen/UGN9QtwETFY08PBvRM3mVKYLLySMOIC8viSgDh7qLvmaBvi9aTdNw2d1
         bP42Kc/LXzQ9PboxRgm0rsUT0kasw85YTZ6/Yub2Ues3dzsPL+kKi/bVbdI55T+I2dM2
         c4ghxew3iGVPvg9JBKpBUMVrHLIAu1h4lTg8FDeMvrdudUTm2geMLFkhi4KttJ1AC2Tt
         aPO7z6KCEhJxSoJqLyqKqeKfi/nLJIoJBgiBQ/jMSGN09lhDW03WNm5hv8ijAZV5YAtD
         BUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465465; x=1787070265;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ge2DKXL/0cigzsh3KdWGGLhQNvufZEJOXUsvNTDWwxU=;
        b=XgELWJU5/nd753A7CdZ1uzbQMqAWMkpMXuSg6ILp+M6vte5XDLfYmcqXNNgdVYAjTF
         ig36bqFy7pj/6GxRugjq0OKOcF9V4+JPq+yZj+Ge1AQkvbVQeLFP35gWTAhexEl16ofw
         wggewVXfQkm8xeHLBrrOvrx7yM6Wg9z0YIy/AiWRkXwU8kvmUlPnGnMH9KjXGnLLliE3
         l7gG4rfH9zE0Re6+XPbjoY/o82xxNhCe57Q9ftddep5APok56wnCMbLSMpkaQOKyoYq7
         znQIV59IIJRYohUKl6eFc9uhoQRkz+OJBJMQoKhTYTiS1Sg/D8azWHRV7WFRPvJTA7vc
         JHMA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3ls+4B7de3qXWxeUNXb8+cfFFeOdFBUNaWGEDZg2Lo8k0KY8ucbPbEF1fYq2/T59nzb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0pEzED6O7/t4eO5Zc92GOI/+Wd0ZsgNjSRI+nNcVbI9S6kRZG
	793xifL6j4EI3fiJsGaqUKce5OujiUAOl7MvSywmOiTb2oVoEt2/M4YHHCJ4xzB+BuA=
X-Gm-Gg: AR+sD13UGaw5gUzpFEcRTw5IXCgvdHuRb6SYsQwiBzD+tBt9+IFKP0kkl04bZrcP+XH
	wDvr9Opvebc45Nn2zsoH3v9jRmIzJF12kn8ObL8hSx7RceLne4mZIljH8rlog3j/25DBo2Ls9Cm
	8rJvlrKW5uS/KDs2znIvIrQj9T6Yd8CrcP02tvT+ci4h4hHwo2hL8FPCQoSJWyUAmwcTsHt1Lcm
	j1EPMu8huG2H4iTtjrg7AiTsYjA+Z2DqvlfVrU8ro8eGkTN8WlpnCTHBq6414NqjNaM1akne29m
	rJsz/l2gW6i24e4gvisUt6m82ryQH4LKfUL147md9l2hyDL29PvgQJ0B8EQoHmlx3qzaMDaUs45
	g/X2UOFjeQ0SbOJJZE6Ma1ebKIpfjAM0Lew++Now+REQzfuEl76ZZto2G+fqe2KsfDoqd55JDgg
	tiLwVR7K7337O1O9jpCbMX9lwOPnMlsJFS/o/Oo8a7iTeQp4oP
X-Received: by 2002:a05:6214:5d81:b0:8ef:ea2a:2728 with SMTP id 6a1803df08f44-90a66df2c02mr43379816d6.19.1786465464725;
        Tue, 11 Aug 2026 09:24:24 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3c38c4sm2442696d6.36.2026.08.11.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:24:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtpH5-00000002YAS-0rLs;
	Tue, 11 Aug 2026 13:24:23 -0300
Date: Tue, 11 Aug 2026 13:24:23 -0300
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
Message-ID: <20260811162423.GL544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <15a7bd252a9aaeefe393f5609ec383ce2c61694a.camel@infradead.org>
 <20260811152435.GH544626@ziepe.ca>
 <eac6f58590798a0bd96573d0ab15e0700937ec1d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eac6f58590798a0bd96573d0ab15e0700937ec1d.camel@infradead.org>

On Tue, Aug 11, 2026 at 04:29:55PM +0100, David Woodhouse wrote:
> On Tue, 2026-08-11 at 12:24 -0300, Jason Gunthorpe wrote:
> > It is documented to be like this, even if it is hard to test..
> 
> So don't change your documentation :)
> 
> > Even for normal blocking notifiers you should not be using
> > synchronize_rcu().
> 
> This is SRCU not RCU, and the read-side sections are converted from
> rwlocks and never had any allocations inside them anyway.

To be clear you should not be using any synchronize_[s]rcu() primitive
inside the invalidation callbacks. These are well known to have
multi-second delays on loaded systems which are a completely
inappropriate performance characteristic for these mm callbacks.

This statement has nothing to do with deadlock.

RCU is always a trade off, you can make the read side run really fast
and the write side is ghastly slow. If you can't handle the slow write
you shouldn't use RCU techniques.

Jason
