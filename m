Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25B480DE0
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632044; cv=none; b=lteog+1zo1Xdy9CBlyhY+ple1jUIT3tm6SKg4YnhqtQBFHEJUCvLYcnlef4QQfQup0ZSIJ0ugd1jX/PsFRU5zw5A4Fp4Hj/iDgqeYe4VQOmWK4dKsUTCqFXm1g79unWMymS9HNLjTv68cKsSGKWJAaPydJ3IZOfVPhehrXSa8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632044; c=relaxed/simple;
	bh=Fn7/Kun1Xj3zANVPU/qpma4EzgtzFyOKv79nRQkl1r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9IAqhhq9M3cWrdEyYUd2WiTrBe58IWYaZVrRspwIZTfofEIRkNNFjhm4j1tK4pm4W6o03uxaz+o3v0dkPnoCKFiAcejGtOWBQ2tapjpHRB5FRnwV8vphbDEuhcE47nh6VwlXbdui73pccu3NJdh1gteLG8W2Q8B/CyobJGD8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EUWElDDd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EUWElDDd"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c2a818fc4so5427191cf.2
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786632042; x=1787236842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BsutUma4J7k9K1EQrc1L+Fl5PhES1nmDAUI72Bdk2Yg=;
        b=EUWElDDdwSH+FXakMZvZr8rw3pV6Wo5e/XbPyv3TtWhHFLmdO+HYs0benH7AsirNWk
         rNZ7H9SzFGU472kbpI66kX/fFeX4kjxmbUnE/rU+olCLI7flRMJcczxrO4xZ41SuDhdQ
         oDy7HZgIWvZu18g8XEkvehJcts1kQ8XCH4pZ1MwahgE+JhnZcBC2FROeSKt8kbRh+oeh
         +qMpbf6yxAqrPmTs1EwCwBrL8Jy8JwzvqLHB21rh6tyyFO9Ona8Ihk84YXiAXVRPMQom
         tQQqMRKWCFx+nHkRT4LCOpiylFpATwkFQ8QCtXsdpqJ14W0muF1JNq3y3mqDUNXA+ZGI
         pG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632042; x=1787236842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BsutUma4J7k9K1EQrc1L+Fl5PhES1nmDAUI72Bdk2Yg=;
        b=iepx5ci3e0zCxLKu4kTNVaI3/VwY5wp+ldizsRqNuoUfA3/D5nx+UYeR4sJCqcaz0+
         3FeCPL//cuZp5sBrVQiyTC/OnJu7/zbelYOi1S1b3axr9aRPv4YYojPIcNc+IdbF3pzy
         9r4oQT1ffhvm5Lb+aM+PM/0xcqTF6mGWjOJOsQhDGAZQARw0EKGWQx7TdBA0uDhpt+r4
         /dxcjboRkoxyLXGCdiCn09fsoqpPtEC6i86WbavULoeQg/upn1Y3AtEZwpAjT+mUqeVx
         nanq7O7ZfQlZMotFtuhqYfMnp/whE1PNwIHm8oW2otxZ6Iu4f8UNNFESYd56dTDhYxdX
         3MMw==
X-Forwarded-Encrypted: i=1; AHgh+Rrmo5Ey7YeJqnHAXVZYysprJh4o7eSpM9Dg1sv286OCh/Vx8UYBA2gBFjqP215zQBNEsGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtyzl/v7qd2YIxYCpyD+FSY3qI9YClV1WTtzXTFsYiBg//siSz
	BFqp0tIQ7BcCwbSLr3CYvjQTZPPa4Bc5AAM6YxFPXlY9kq5dnb7V9fIxt4WnV7DgSO4=
X-Gm-Gg: AR+sD12NjeqIQqq1bgVsPQ94Ih4ttdXWbXKgkCq0EEm5V0PSd7k/ar/Hua0xoFUm+q5
	9Wsm8YoE8pmoxF8DYAgH8cJb/Ymm9wRD7LMEebCCwY8Yxc8XzuoSIyEQjAiwNcO4WygdmndQDRj
	3sgnsPsWtQRyTYxnxYphSnwMERLMLLiBKkrQOAMLrXcclDfp2qiVbto1CEZX2vTS69LXa08PJHV
	Eqy08jx9Qr2flTXuTnxcX5BPJz1aXrxgYEBpum3eeMfqja9yyorEwD/BFBanVdW/0fwTz745qYg
	uM9kAahlYoiesyp4ZtupCX/51Q/EW9PmV5s0ZtcZ1Hrx6+8bOyFwVkOpOOReC4HajSNQKHVxlEK
	W5vNz7ARffWvrjtBjxGiBPgUwivWXcj63LG+85rdpRu+++KrJhbalQCU4Zn1YqZcYt3b8TeeGXt
	4+adVjm3uP6cpOSYYEmwzyJ7zUZFQ2wafARBIYUKQHgDffSKLtw/aOhVwXnZzR
X-Received: by 2002:a05:622a:2299:b0:51c:857f:9c12 with SMTP id d75a77b69052e-52d73c272demr67730661cf.4.1786632041981;
        Thu, 13 Aug 2026 07:40:41 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d74005849sm18256301cf.30.2026.08.13.07.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:40:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuWbn-00000003oi2-45RH;
	Thu, 13 Aug 2026 11:40:39 -0300
Date: Thu, 13 Aug 2026 11:40:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sean Christopherson <seanjc@google.com>
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
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260813144039.GA905583@ziepe.ca>
References: <anwraNIKJV8zwrNT@tiehlicka>
 <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca>
 <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca>
 <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <20260812142659.GD662699@ziepe.ca>
 <9e65be44430e7d013fedf9a1626caba020ad6d94.camel@infradead.org>
 <8ba4860fec45afeaa305bcb011d732ef0da302d6.camel@infradead.org>
 <an3NyIYrdN3li0ag@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an3NyIYrdN3li0ag@google.com>

On Thu, Aug 13, 2026 at 06:59:36AM -0700, Sean Christopherson wrote:

> > On the other hand, they are basically *all* false positives from the
> > point of view of what the check was actually trying to do. And in KVM.
> 
> FWIW, all of the KVM false positives are due to PREEMPT_RT turning mmu_lock into
> a sleepable lock on x86.  So killing off the restriction for PREEMPT_RT would
> "fix" the KVM issues.

Yes..

Still, if you want to get rid of the non-blocking feature then it
should be replaced with something else that still achieves the same
end of preventing recursion into the OOM flow. Maybe some smart
lockdep scheme or something.

The non-blocking thing is pretty nasty, and it would be nice to
upgrade the drivers using sleeping locks without MM entanglements to
be able to work with the OOM killer, but I don't think anyone should
attempt that without some robust scheme to detect the invalid cases.

Jason
