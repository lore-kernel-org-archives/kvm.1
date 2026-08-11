Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42137F314
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472359; cv=none; b=MKIQ7tUi1PbaIw3qIpROOfMbbpWnzOS6JF2flRhN+K+8XDOuSZq1iHLa5zCE6KNq3sPmQLe9Bq/8zGF+zMKqAiYeTaBTSTeDpGHrNXobe0lp9rNLBQXzNmCU3QVEkK79iKo2LG+gGgtOX/EimAK/V9mBqpro6jmFJ1U/1C5ASBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472359; c=relaxed/simple;
	bh=q9Epwa7qAc+1FtYECVkBZAqgd+xV7L2totBuG3xJDSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhUJX7fbBeweefyKhJXDcrKJvIG8PqXH5gkfUfYE+tswiyxzRljZQ3hX1sysbuj+ZDhB2UyLW77JlIVXxMQoZo1ciOjvYqRS2980FRWMY7uaATaDN1nAP4vU+EtzF7NOMKAGpB151OZM7jA/Q3u6iKsZnoOh/QvOPcUcPefLpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SHUDkncm; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SHUDkncm"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so1066096d6.3
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786472357; x=1787077157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Juoz6itPiwLzS63SjvZr3Uz5ivFoN4JzwWEODeoXz4=;
        b=SHUDkncmRYwSME9h1t0VuFEiEipfntXNn4D0TN0ftZbmnaXpeRo8LcqXGLFOICBNXO
         hgTtRljmnJ++QIGm1jb2AK6/r/c1wl0KU55DlX9JUf+XdrkXqUfzTF9J4RiIp/48s8PU
         rlO45ME6YpOcmXC7E/yRPH/3JmDHkWY7CfAlxOqXSLKEYe69SEjKu/11fiIOJxL81LW2
         XhJTiBWCVGIU7AsE7sobm+MYmwaIi4sKR1Y0YMKaVbnTzKT5VwfjfIH1/Li6PCxaEJt8
         o5dPV5ZPXpvOX+KGdb2Q/P29B1Bh72EinZEkZS9STbvCCltTWjLzpGSlIrV0cJ7DNO8i
         iPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786472357; x=1787077157;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Juoz6itPiwLzS63SjvZr3Uz5ivFoN4JzwWEODeoXz4=;
        b=Y6BjUy6n4JWOLWa1UHrmXeSmDvskfjUMm3mrw92MiFXAP5NIrI/Efw9G6n0sSySKRO
         XdOeU0ALP+xIJkA8FESbwwJh7DIFmyGeQ1xlpslUzNfk0oo1mT29JWjuWxG87H52XSEk
         c0kWY8ToSuuruw9HlvrwuFaOoN/s5BEziWiV8NldFwjhV1p/zcE30QyXGyXBl28OJO4N
         2EC122UChWOY2cyNDBC3Xz9XnIDp2wbJgy0EGw73kVGdATauuNrZAIDt2L1SAdEWa1nQ
         PsVDAzN19QdxgcrtMRNmiD5oHLpx+EUg0EXMPZae4V6h5pvAkwh5PXkqXHBfe7HsCuOQ
         55uA==
X-Forwarded-Encrypted: i=1; AHgh+RoAtB1pMuF/E4FlA3VCSK+IW+IF3OB2+Hf8fmqz6w6+q2tQGILgbPUkxMQ9rpOqZZzLAm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzREh9MmEl2/iKrmtRGIm8KbrfHpz85Ohk0BixCiBFmtU/hJcEN
	uEgedTNkR04gi3Cucl3IE/vJ+3aMFb7ulEOnnZFNtbkOpmZFtoCNkaO7KrWZgeYrsvg=
X-Gm-Gg: AR+sD10QTkd0vxlJ2cI1aklaBs9ic8wN2THnnq8Trt8PqIFd/H+1Gyh/WDhLQnpy6qA
	7DerHSWu31t5bHlVFfBOyeJz3isQmCw06jp2leppiLGS74Zvk3m5imZg8w/Hb/wsVB0jpl5uJ2O
	VY2keDkTDUf759XXr/qE/9GNDDByI66pe8gRNOiOfaCsX4It5vLKB6dNgwL052m91XkXSErJmhY
	QAyBYs357MSu8rOXMShB4eLjY23jmm01Hm9xECqXBidmxxM+vRxYXRw0K0kWe0r3wUYrApKMMdp
	qbAcQASvIthdl0fKR8p/EyPQHQScorJ6bsckN2QR00pyJUc59+CbAihYoCgnyS74Khffx+Lh7P9
	W6qrZ+s9JJDjBudjxQRtC4KHwJqvFNcRg2FOF8+lRcEZ8T1dda81MLyn94cjfFpVePGsSS4ClSD
	vpJErtNEqivFSIXuzitiEXdBJAr8FSgjRIN8hh3DU3m6sWvrPb
X-Received: by 2002:a05:6214:e4a:b0:908:958f:4db with SMTP id 6a1803df08f44-90a66922571mr43184126d6.3.1786472356695;
        Tue, 11 Aug 2026 11:19:16 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c395bc2sm4671866d6.30.2026.08.11.11.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 11:19:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtr4F-00000002kR7-20cJ;
	Tue, 11 Aug 2026 15:19:15 -0300
Date: Tue, 11 Aug 2026 15:19:15 -0300
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
Message-ID: <20260811181915.GO544626@ziepe.ca>
References: <20260811162423.GL544626@ziepe.ca>
 <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>
 <20260811172627.GN544626@ziepe.ca>
 <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>

On Tue, Aug 11, 2026 at 06:59:24PM +0100, David Woodhouse wrote:
> On 11 August 2026 18:26:27 BST, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >On Tue, Aug 11, 2026 at 06:22:12PM +0100, David Woodhouse wrote:
> >> On Tue, 2026-08-11 at 13:24 -0300, Jason Gunthorpe wrote:
> >> > To be clear you should not be using any synchronize_[s]rcu() primitive
> >> > inside the invalidation callbacks. These are well known to have
> >> > multi-second delays on loaded systems which are a completely
> >> > inappropriate performance characteristic for these mm callbacks.
> >> > 
> >> > This statement has nothing to do with deadlock.
> >> > 
> >> > RCU is always a trade off, you can make the read side run really fast
> >> > and the write side is ghastly slow. If you can't handle the slow write
> >> > you shouldn't use RCU techniques.
> >> 
> >> The multi-second horror stories are about the *global* RCU/SRCU
> >> domains, where the grace period has to wait out arbitrary readers all
> >> over the kernel.
> >> 
> >> This is not that. It is a dedicated srcu_struct, private to one VM,
> >> and its entire reader population is a handful of KVM fast paths that
> >> until now were under irqsave rwlocks.
> >
> >Are you sure? I've never heard that srcu has those kinds of properties.
> >
> >If its so fast you should just propose a non-sleeping version and
> >leave the notifiers out of it
>
> I've got torture tests running for correctness on the GPC RCU
> conversion. I'll throw in some metrics on how often even in that
> pathological case we hit the wait case, and how long it actually
> takes.

Well, to hit the bad RCU cases you need to usually do some other
workload too..

I guess srcu does have some meaningful functional differences, but it
is hardly guaranteed to be fast or non-sleeping out of the box.

I guess you are making an arugment that if SRCU critical sections are
atomic themselves then the synchronize could also reasonably be
atomic. That seems plausible, and may be worth some additional API
surface on the SRCU side to expose this use model and drop the might
sleep that is causing the trouble.

Some sort of "atomic RCU" that has a slower reader but a faster atomic
writer.

I'm much happier to see a formal API under the notifiers that has
strong properties of being reasonable than KVM using SRCU in a way
that just happens to do that by accident, under the current
implementation..

Jason
