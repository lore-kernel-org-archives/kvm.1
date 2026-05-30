Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B33033C6
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780152028; cv=pass; b=L0Acmo63K1FGzbAuBUatgsUz8Dk5EhZE88hvi6U+hsPQUo2MQMeue2mLgU3wQhGNVAtP4pjstnhpOrU6D5fk/CfDHjh8SFZpLVTbFEMErZzWF5DFXcL7mhCZ75WtkpT70E3taC3EvyNFE7X+LnGD08UBURFrCgAxFJW2cfokZ2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780152028; c=relaxed/simple;
	bh=KUvooNNdIkd+FKzYuRy/5PyjM1kK3R4YfLffFWnxvH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igKqPVhk5eoWkGLtXemBt5hltDcUTNwFOyMx6tn+eDnFaaExFilgbOHhgj5iEPa0eVB8//n7TtfuMTZDVfVHqEoyUj0qXoutShGTfEhdNL76KXb3Rkq1kU94uiBcSEiD+D1EPkWduDcLajn6UHZ0DU7IwqCoJZw3dSsGn67VIDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xafl62hI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFT6ipN+; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xafl62hI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFT6ipN+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780152026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbX9ETGeHL4O/J6AyhXPVHFQk4gtMWuNw5BL3nh2ccc=;
	b=Xafl62hIIdsjCpLLaq2/A1DNiPGXINP8CHPB5FpC7reGD/eEBfvzAJyE7Pg1d0fta9anUy
	jo+c3NAG+/k5efBubo1D+GTYK4s5+vPGMtmmtU45G4KRwacQ8r41TbIfs4BsjG+Po1uSii
	4oQf/bdtv2V51hv8BaiOuRGofbVitvM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-A4vOKHmmPzyCfi-bQomkDQ-1; Sat, 30 May 2026 10:40:24 -0400
X-MC-Unique: A4vOKHmmPzyCfi-bQomkDQ-1
X-Mimecast-MFC-AGG-ID: A4vOKHmmPzyCfi-bQomkDQ_1780152023
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef9437b7aso322743f8f.0
        for <kvm@vger.kernel.org>; Sat, 30 May 2026 07:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780152023; cv=none;
        d=google.com; s=arc-20240605;
        b=XAYnc6BUxod9a1m+hdc4ERz5LqO3ouh0MrGvHNmL3edrpOznebm/ADhRVV2/M6ahH1
         M5u6tqcnS3p3UBsd8ERVj4q3Tj6nMGcrI+slHQ3z9wESwDpVyp0Oaqd5riDgglVJtEG/
         O+At68VQf6hn+K9NRJk/STTfeiU0cICV4Lhf3zhQ29XZ7Q4PTnzSKyoFA88LdjT9lUPv
         xJk8aV/CUT513IdrZ9gvpBjdfIPg3MkonEaU/GL0DA3AHXqNv4HlAKMkakzj1Z5rw7ZL
         D2ohbp3qg//JPM4SQGaGgHGczAklgt2ei46fr5zMc/FMcnn+cKqEPip9kb9zp9RjwtgS
         MAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SbX9ETGeHL4O/J6AyhXPVHFQk4gtMWuNw5BL3nh2ccc=;
        fh=vZPV0hLRQQbp/oFUiGnKmlrN3UWLF79BbfyhLsG+Qe8=;
        b=d1GjMhv2eJ5rbNayZgHaeeybMF1GJb07auCgFkGKI6ZDJnwuvg6c8WjvdR1oTYhbXP
         szzg14SF4JS0kFX8SAW+5ZwZSbqaae7mdf9c3z+2DQmeJmLyCigQXsxaszQvU2m8h1Hz
         VLMtdmqQXcRgaSjdPIo5MrskXuR5fVjhB9TdRrk765x1muSIlxZkrm2Ge+Vy5b8G01v3
         4hLFUcokZlKZWQsDJLD0tCrzwVxKJ5/4bT2ur5VaJHXFdfE8jIeflyv09rqJwOkibJim
         RedjPg3bpceVOn1g4wNj0pVVwkfITYXl5c/N+lzkwpv9EfTZT1GtP3ZTl5bJZ7UZMZEF
         tqeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780152023; x=1780756823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbX9ETGeHL4O/J6AyhXPVHFQk4gtMWuNw5BL3nh2ccc=;
        b=GFT6ipN+zGDxLXDuzEhrJlpy0bOHdcuGleVGGl70/GGxDSsX9P0X/T9Gu2G4tSB180
         RLziyMEbfiZEp+QYkKuuUzsTr8fp9JLWNKXwygbB+WIqTWZ0pbHpeJpciMGCB/T2mJ2c
         zWQArcJvQyOOzLCr9UzOzgC3ISBL7KWktjC+Ldk/9+9IR/EkZ9NguflZlY4lH9f/hJa5
         sY4V2Fk38hlWT2VawnionsNFlLGwCRTtVkVseuoz8w6TFU098s/WblicUbS9hiMqjzEQ
         NHp9RPW68AGxm6ZuR0APdlbRjgbyAzViZ1/fTkIvRU4IuqgoBYSsuUMe1SXdoeqomg96
         bifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780152023; x=1780756823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbX9ETGeHL4O/J6AyhXPVHFQk4gtMWuNw5BL3nh2ccc=;
        b=WF219egrtdNOXF+fhZdH3n0j2E3sqqeK3z9yJCulfNS7FeOqKKy2qveepYm1x7EQfC
         RwPcqoUm37YZo9MZOYikmYTywsKzOIKYHQq87pT0lOKWJQvNcN0Ikh5tTN8oOHaplEwu
         5rWsFIbA5+RP+Vjc2L5Rli0mwS2FOl0q0AzbW+vuw27cPsf7aDLBVBNRrfei4QI8SLIg
         oMNhHhpZ1jl9X4d9v+Fu+SxTljPnGk/2iLaI2l1bZXxtMVWtcQPgscs4BndwGDYopK2N
         OYw7gto0dsdZzvK5IoBA3o/dJ9sUdBgdTn4muMEdxv18iT7E3bMsh0QazVTa1x0c235X
         iPoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dsLwod1mfHZ2XpihdOXUZqKKXFrRJU4NYjGwabvNgysZo0hKxoIV11HphNA5Up2uX0Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVXrSbUtaRyJTgFgCewLQzLTp5ajnw3V6QIUYAKb41V7jsju18
	Vav2vNBFgboS2GXEZlskGLlWncB5fm8wVLk/FkuxatfJDV2RYW+NTxuUUXiqyfo9P49qrgJLbBd
	4XNk7/Neqw2ENcmURu/luobz5/FJ/ET041k671A5HIFyGctCVkFvT+gjPlolXTF+dNJRMuelaXT
	FBY6pXkt1gBUbeF6G+L7dVbQvkJs2q
X-Gm-Gg: Acq92OEhFFVcrXTTzV4cxgDjJC7RHUpEF5fIvgr7wkjnq3VE1jxw5VejbpxSn2JEHFt
	Hc+Ssv3+a4t0NCvhzp4GceRLQ79rJZDdrJaGCEOeIPjaeyoIaHt0WzIXnGi3z1uKIcXX6aLPp+L
	FgbfVOhAlpeCHZtYH6l9ZEp8NeZl8KmWKuk60brYGdZpYZk8P85Cj+J0Mjso42NgkT2163FNNJP
	jnTbpaQ9bk8+NWqBb8T+yenqmTLEXgsI/5fi668vU0O2k+5qkjYFf7HdoKpiVuMoOE1lhIar4iQ
	QalzuVGHtYWvaiVQ7Q==
X-Received: by 2002:a5d:4ec5:0:b0:45e:f631:2c73 with SMTP id ffacd0b85a97d-45ef6afd31bmr5190846f8f.9.1780152022889;
        Sat, 30 May 2026 07:40:22 -0700 (PDT)
X-Received: by 2002:a5d:4ec5:0:b0:45e:f631:2c73 with SMTP id
 ffacd0b85a97d-45ef6afd31bmr5190497f8f.9.1780152018563; Sat, 30 May 2026
 07:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com> <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com> <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com> <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
 <58d17a623c1c5c9c09bd91baa30510aaf42f899b.camel@infradead.org>
In-Reply-To: <58d17a623c1c5c9c09bd91baa30510aaf42f899b.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 May 2026 16:40:06 +0200
X-Gm-Features: AVHnY4LC9DrPydbRCcKWbqqaDhuVCInkWUdZ8RWoAc_RZ21vhkufGl1AZyy10sE
Message-ID: <CABgObfYJsacrCDHRouLDsEz_QF0EBQd8pu3g-V_gta6Eac2e+w@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in __rwbase_read_unlock()
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>, Paul Durrant <paul@xen.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:04=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Sat, 2026-05-30 at 12:26 +0200, Paolo Bonzini wrote:
> >
> > Yeah, I think so.
> >
> > The write side needs kvm->srcu so it would have to be yet another SRCU.
> > I initially thought that sucks for the code that calls kvm_gpc_check(),
> > but maybe not because it simply replaces read_lock/read_unlock.
> >
> > By using a seqcount for the data, SRCU only needs to be synchronized in
> > gpc_unmap().  So, something like this:
>
> It isn't just gpc_unmap() which does the invalidation. We also
> invalidate from the MMU notifier in gfn_to_pfn_cache_invalidate_start()
> which would also have to synchronize, wouldn't it?

You're right, the write_lock_irq() there drains the readers and that
is needed because khva is not pinned, only kmap()-ed.

That is already broken for the OOM case under PREEMPT_RT, where
rwlock_t becomes sleepable. But using SRCU would break it on
!PREEMPT_RT as well.

Paolo

