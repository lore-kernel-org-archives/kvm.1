Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B148B389
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990178; cv=pass; b=h5LrvdABLvSiutXxt31h3anxmWRMZHPEr/UmeGXVeH7IRoAsHfNi2sIoKz/LT2sUPet7SLWmcT7FHD3Qxn61Dj2HcY9avfkr6dymq5WDPC9o2DcBu28WaPEmuqL8BUPRH7FyaPR13PoHxPBylIW1ogrUOCU/mS+eAlohGSQqbAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990178; c=relaxed/simple;
	bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELUCDiqBIWgYf3K5ALRx9loAoWlvTCycBNxPpnZJMlG7LHjFfvwGKxDC8JaZKJNry44Q3BKNx1G3GRFGGRw84ChltZxnJRhN50ISFYLBuveWNorGLD/KCO8XE460AN0pAcygh44ZzdRtoEb6RdMM+popaoU7ucWo0EnSidOnE4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6ageLli; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFjosavz; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6ageLli";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFjosavz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789990175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
	b=O6ageLlihfDB6076/yHJyZKSoLL3nKRi/zQLTHfzt81mczUIQ9IS0tgvRJ1NlCjqBb4DoF
	GZrYoV3RbM1da3b462HvAx/mn3gZn/RrTsYJoZiIFO2UQUxFL/1TZPIy0U7ZqqGb/oJSYY
	phAiGePIBp/H+zTMNVR59vJJTguhh7A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-R5PeqNMHO8S0IHXcUwlpQA-1; Mon, 21 Sep 2026 07:29:34 -0400
X-MC-Unique: R5PeqNMHO8S0IHXcUwlpQA-1
X-Mimecast-MFC-AGG-ID: R5PeqNMHO8S0IHXcUwlpQA_1789990173
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4870142fd5cso1489333f8f.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 04:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789990173; cv=none;
        d=google.com; s=arc-20260327;
        b=sz+afrs8a+1Ny1a7BbaU9lJx3lRCmFBwvQhYsCh5XEQXvkmNHlG6bTPJEV71Bk4Glz
         3xXdRMmoxAhveK9yG6KHlzLYsX+XLmfbnQGH0QhpVa8PQGflVaGFc9VkTYcH4fnwz/OO
         kSA8/em+I6bMXkJvqvpJ3A0S1vlvdbEwbGSXxEVAgjSXoLjAUcepKZZVIibb3JlCsyTe
         ifBEffpTL2AqFTtLP/7PUgg/+1Z+z7Dt0IHgvpOvzcE4uvdM8hxEFMdM/+c6MiJFYQXR
         znpbkET0g+ZasDhm1PLPUiPXIvHTlJ1H8dMx2TsD3IAU4l1b83foHOgyArAQWe5GaL2r
         8qPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
        fh=n2jsaGO3VHSXTCarIqS+1/hasZqOG9b0u8jclMOt94w=;
        b=EirLdcJiPOfu+mmYigkSIAleFRi5BhUXaZ4Io5/yDZgifzMqtWzCVJPd2jp52MO5Gg
         ALavlfgy9wgIyc3lfu/zyJOOcaQLSLznUri/AAL+7tyKFaGdGXM1ncdvkVNG9McoAVKY
         ytEB9PoVLQ7vVqrJwbXToR7+nav/nTi/Q4zT70EhwDKonaTnVt/lYnuxrzwpa/Jjxudh
         ZWghvvDHF6EIJIbOq7bD5RsUX4ZukLaQ/Hs0KjvhUEr9bycoYTgogRsS3JtyZB6pZ57Q
         +DXI9XnCnVmJ7q6ZmFdskjoAenFjKjNptG7xKLAFyEKvO8ssVk63CPAfF2PWKIP3nSXR
         QOeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789990173; x=1790594973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
        b=hFjosavzTEBg7sS+/amQKm0DVwQIeND1Et6uVLHGgp9oztjbPFCj1GSVjXpTtW1o4K
         Bc/WtO6t3w0BAV929yBDSAi710gt9i8vIG6G4IyZ6GylRBVB41jc975KGZ4C1vu8jtTJ
         x7xcrV9Z/Uk9xBkxBfaUqamjFEOwqtWIVJnzLrJGEKAvBb06h8yPiHXwvPyE6czoy7I2
         +8i/fivrjJ4mfrJsjj/GSjzW25mhmbFvGSLW+leI/NDqeBUQcrHQxaHhM2koGsHWO/cA
         SqniDp40toI3F8H6TS7Y1ucl7zgJL2l4gWnJOBTOA0JIIEQ+e05bwbUp/oqKz+wPpNep
         JPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990173; x=1790594973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
        b=vJnz8ZXR9S0ZqL5VHBrZW0QY0TSmtoBYHVhND3ggZpeoZjiBqIdM0QSkCxC0pzztxY
         yWzAGCUmGFgLYKa40CMQbfAhGvuoi+cx/G+XQW6ULhFfa6Lb9QmkZG9pLxg6pz0UuHwY
         YQKsHdptGpUOVIRlv3mV6HKtkqzJYG76niMItcP5OUAs1H1pNXiD3pB6xPAuhx3BxoRn
         VOHLVdLX8iIbviQ0z/xWReZvzX/gXHnI4Hl3q4IBR8bviYhnVIRrSQOVI7JHHwXqyatY
         QUIYM+zrFm2QZYZ8q2dMmSEYq3ZWOgbwA8OIkB6pKzCWSJJge7V7F6zAIo9obbjtJ2Pf
         hYDA==
X-Forwarded-Encrypted: i=1; AKwUvBzdfCD3RzJ1XDpnK9v5jCr+Eeyv3y14BUeDbH3WTKpzYe31NRpnZx5R2zeBVxlBekt5CrI=@vger.kernel.org
X-Gm-Message-State: AFuF++lVly36Dnr0qYs+k5xjt1//m/MzWMzB0BXrD87Em+QXiVXS9atq
	vEQg7oE7+TKm7jKn7f6Xg+ur1Q2jWntuhNpvEm50I3+A8e2KO8QUvbVOWamxrM94Bfh+jxhC9b6
	q7ClpbgQCohN2HZFc+wtqGIURzcJGp8vU33DhQbeM0UfLnOZvziHFamZI7emj6hrnS3z4yJrFCv
	M5mOkQ38h7MDwwD7W9arockZkrGmIo
X-Gm-Gg: AYBFou1t9e1RdbAaMNRLDA9Cy8XfpQPsoWU9bfmpZnAwuk+t5Uty/PMYhm0evOisqTn
	ekzJaTwYKe7Sab/i4d672Urr9bVUrf/AqjFlmNYHZKp7hOiIELhRwIJBf+Jkbd1+iC7jxqJcOlx
	w/sVTZKvdgFjT7vvUoqV4y8l28/wfXTSxUrKUGGmgv8NJwHxHqxvu+cqW7OKm1IfbsMrYtaFZic
	BXiXm3l+vNjF9ZLAzzmzyg90smcl0eY3Ab7gmdQS6Ut9PfNUsfONsBSOQzuDA==
X-Received: by 2002:a05:6000:491e:b0:487:84:96d7 with SMTP id ffacd0b85a97d-4871e373189mr14673926f8f.53.1789990172840;
        Mon, 21 Sep 2026 04:29:32 -0700 (PDT)
X-Received: by 2002:a05:6000:491e:b0:487:84:96d7 with SMTP id
 ffacd0b85a97d-4871e373189mr14673903f8f.53.1789990172510; Mon, 21 Sep 2026
 04:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <272c0fdf9e5eb9a1caf6a5c0bf674e3c006ac2ea.camel@infradead.org> <20260921112131.274-1-hdanton@sina.com>
In-Reply-To: <20260921112131.274-1-hdanton@sina.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Sep 2026 13:29:21 +0200
X-Gm-Features: AcwNN1Xi_H7uo3XvFAj5sLWKjk7Urm5G8ShkD2xSWIid9H62cmytfHb-xU95uPA
Message-ID: <CABgObfYZKfSV=Ykmjkey+t1pA4rEEk8=a-VMho4=A0=xNLmKcA@mail.gmail.com>
Subject: Re: [PATCH 01/17] KVM: pfncache: Use atomic SRCU for readers instead
 of a rwlock
To: Hillf Danton <hdanton@sina.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 1:21=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 21 Sep 2026 11:54:36 +0200 David Woodhouse wrote:
> > On Mon, 2026-09-21 at 09:42 +0800, Hillf Danton wrote:
> > > On Sun, 20 Sep 2026 21:49:29 +0100 David Woodhouse wrote:
> > > >
> > > > Replace the per-cache rwlock with a dedicated per-VM atomic SRCU
> > > > domain (kvm->gpc_srcu) for the read side. Readers now run under
> > > > srcu_read_lock_atomic() alone =E2=80=94 preemption disabled and non=
-blocking
> > > > enforced, which every GPC read-side section already satisfied as a
> > > > former rwlock critical section. It works in any context
> > > > (including hardirq and sched-out paths) and never fails or spins,
> > > > eliminating the
> > > > read_trylock() contortions in the atomic paths, the double-lock dan=
ce
> > > > with the lockdep subclass hack in the runstate update, and the
> > > > PREEMPT_RT problems inherent to taking an rwlock in those contexts.
> > > > In particular, kvm_xen_set_evtchn_fast() is called from hardirq
> > > > context (timer callback, kvm_arch_set_irq_inatomic()), where taking
> > > > gpc->lock is a sleeping-lock-in-atomic-context bug on PREEMPT_RT.
> > >
> > > Given the preempt_disable() in srcu_read_lock_atomic(), as PREEMPT_RT
> > > has no way of handling preempt_disable(), you need to add another
> > > version of srcu_read_lock_atomic() with preempt_disable() replaced wi=
th
> > > something like rcu_read_lock().
> >
> > Hm? What's wrong with preempt_disable()? It works OK, but is generally
>
> How is preempt_disable() handled by RT?

It disables preemption. :)

The difference is that *spinlocks* (by virtue of becoming sleeping
locks) do not disable it, but the low-level primitives preempt_disable
and get_cpu do not change their behavior.

Older PREEMPT_RT patches had get_cpu_light() which did
migrate_disable() instead of preempt_disable(), but then
migrate_disable() was deprecated.

Paolo

