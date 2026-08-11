Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E2430CE2
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469192; cv=none; b=CxpG5lXR68OQhiXZuddy9u1511/JRkSulPvSPH8oBN5kC3zalnvFDzCUMlIF684nWY2/3sV7LE+i88+4QCqe6xVaQWLXY4aKvSRktJ8weSZs8IwmDDvP+8X4BE9VDy01POQTQjpuab5dfaNa6GJyheJid3Qtpac6b+Z0pWxi/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469192; c=relaxed/simple;
	bh=PGN/23AcG1BdZ95Dbjp/XFqXT+g7ycHtDWwLc+SPRNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6RP5Apz2GtAr0ryffxDufZTqym6X0Ar2nUusIzH0CTKlGmXzq71sYtLkelwMeiO+gJJMdyN+2oHgY1pkq0gXAvTRxiU7I6J/QrGFzIny1+sMUiBUDssYNKBNGMoJx2py+I2hjE/Kmj8VVW4I0pBYegUi1DH8Il82Nya4OHx2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lvTpFi0B; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lvTpFi0B"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f186025973so799636d6.0
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786469189; x=1787073989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T9Qh79QFCvjYnoGtVduyp1NZZfqwn8kEM0DsabkDFtg=;
        b=lvTpFi0BIT3IWa9d4EgB0llYeP0dh1ppGbPdy6hHbOh2C5aoyTsrWlL1Yp3RGjxYm2
         U6Ek/dJoBIUXUSjuOai7EZb/ptiUeyDI19iw2RsGY5VNOUy+olhtSmngUVkIFUH8aCAB
         sAT3EP+bAV0ORZr3NUyDMAiKstnNK3yvpQMue0As7Y08uHUcAREwTJFMzJ9dXDAfU/q5
         9ciDraZa8yyRamNZE3qj/QeuR/8rZ0sRbWOio7cQSFuatTvvVOB2VmntYD25yVX1wgcC
         GKadvOXfyE8Y4z3wxKBHPI4MjzbXHTcNol7ejKbqHRhBlGKj/kqVwyz9pnXsTzpC24T9
         qgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469189; x=1787073989;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T9Qh79QFCvjYnoGtVduyp1NZZfqwn8kEM0DsabkDFtg=;
        b=KqJdbsLd44dmkjqPZfc/xwG2VELaC1+7MZ2MHzM314YTobcnUTcN5osiWRdDRWxWPz
         DOzyWqYHNZE9hX8fLN+lES2S0ECfH3HBT0uFYH5jWC/p2Ptnr886voRW91xLKAYvAoJl
         /bik+v8YVIdkqc3uSqwRekZ2oplkOIE6M7BU5eD9SBflZCQYGKF3d1S0691s8zKflpij
         B8wDtHmSYF0J5JxbnwuihNA4sOT814W12vC+ftDrJdQ5CICF7fq+VjuLVrmY3RAkUoKS
         QEHXNF8HHz6taoNYUTsEKELf57/qrqKXleYnYXD+gU20PRxhiExUAkxgF2FlaWKYxxKb
         gH5w==
X-Forwarded-Encrypted: i=1; AHgh+Rqju1h3uixsoH/0FCXjE5Cc5UjIFf0DzAGu69CpXpLKqw5qYHpZRw5cptQsWL1ToNp3O5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpv0l7ptBzAhYKnOCGwCslJjCBC+SBSoETvYS7zEqs+imgy8Sn
	ZHK7DjKcUE6t8ulZpIMb1xZsbZjpHfySYVNu3ApQtv/b31u2bq2dGQJgtBBGS1k9I6g=
X-Gm-Gg: AR+sD11dkYeUEzzNtSHET/ITj/7RoLaT7NWyXchiB/8ncuAde4kEegEXSFJZ/2sKUex
	qixzGXl5mnZd7Sole6MYN1BUJmpG4Gh5iaKcoOGFIsYBNlEYJtIkR87Q4dMkh+yW6IVkFqDUXeT
	rQEZfVkrHGz86ro6qSAswxqIbU7vr00GgXgGQvawFiXK98mTMij8ug917hvRHrOp7W+kAlXcBOF
	B+Gb7ulBwCuGfwmfVb2XFUf2vdwABbCRJflI+O9aFicG22vlgaj3z1sNMqf109boRfzZOc0RxZX
	O1cgxUOVAZ25dWXM++FB2wwvquOTbmhafBR/NL8eCaOf6PBltOfL5jGryx6wOTHajUPRR3D5up0
	uQpjZ0svj3ZJFXxAZyvxmBNr2ShZ0ReFQfmul7Eqmt0nSDaNU7ogO/vS8MZy0hPmRyKjSKrp4M2
	bUDPPBy4SEXCVWdzMTH58V+tMPFzIr6nY1bDtveA==
X-Received: by 2002:ad4:576a:0:b0:907:d9bd:2f8f with SMTP id 6a1803df08f44-90a6694b0d3mr50111416d6.6.1786469189079;
        Tue, 11 Aug 2026 10:26:29 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3c8af4sm3611196d6.39.2026.08.11.10.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:26:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtqF9-00000002gAk-2Giq;
	Tue, 11 Aug 2026 14:26:27 -0300
Date: Tue, 11 Aug 2026 14:26:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: akpm@linux-foundation.org, david@kernel.org, mhocko@suse.com,
	rostedt@goodmis.org, bigeasy@linutronix.de, simona.vetter@ffwll.ch,
	jglisse@redhat.com, christian.koenig@amd.com, paulmck@kernel.org,
	seanjc@google.com, pbonzini@redhat.com, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260811172627.GN544626@ziepe.ca>
References: <20260811162423.GL544626@ziepe.ca>
 <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>

On Tue, Aug 11, 2026 at 06:22:12PM +0100, David Woodhouse wrote:
> On Tue, 2026-08-11 at 13:24 -0300, Jason Gunthorpe wrote:
> > To be clear you should not be using any synchronize_[s]rcu() primitive
> > inside the invalidation callbacks. These are well known to have
> > multi-second delays on loaded systems which are a completely
> > inappropriate performance characteristic for these mm callbacks.
> > 
> > This statement has nothing to do with deadlock.
> > 
> > RCU is always a trade off, you can make the read side run really fast
> > and the write side is ghastly slow. If you can't handle the slow write
> > you shouldn't use RCU techniques.
> 
> The multi-second horror stories are about the *global* RCU/SRCU
> domains, where the grace period has to wait out arbitrary readers all
> over the kernel.
> 
> This is not that. It is a dedicated srcu_struct, private to one VM,
> and its entire reader population is a handful of KVM fast paths that
> until now were under irqsave rwlocks.

Are you sure? I've never heard that srcu has those kinds of properties.

If its so fast you should just propose a non-sleeping version and
leave the notifiers out of it

Jason
