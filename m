Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B61DF261
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999066; cv=none; b=DkfgHC5luXtrnkR20gJjnxsHTVjqN01AHOjelmDQIGjTUZvAnaBTX4u3LBEkGoVrgIx2izNqUMyukQv6cEBy9I9Y6nhSQfLQPbbuz5+RO85W11/yIVLEk1H+nWvNsRdizpjh08Ro45dex3K0QelXaE9jpuGfYuuwGXruTe5Qp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999066; c=relaxed/simple;
	bh=VDLmoDIcL1Xt7Kp2f3U72+7cH7yphKfih/EsGanwd7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U0CYR5yC4IEfI82YzVAuyVE1fAFSNeuR8tPEO/9O+bEyAWhW4LUG6N3fLpJH1fnkyF8TEJD5SuoNS77R0Zck3hMvpBrRAi5TkqzHIfrXXppT0elLrFVTqi5Ep5aMp86s1P2NsW31lqkAAgnPPUpuTk8LBYMj52LwkN9zIhOUzDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOfCKkki; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOfCKkki"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398fe469aa0so10673253a91.2
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 17:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788999064; x=1789603864; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1EXqKImLUULHLFVFsB/u00A+rhPp4MpgJ1nYtLoaJb0=;
        b=EOfCKkkiSqtY0lBCDf4Hooa3Dl6AYs7wpKzjclE9+jOa4R4spGqqct4yny8X84ZtsA
         bs5aGnHH2d554Jh9YfmoJb/lRCDGKCCYJsjAZzVns6JjVkvGjVoH4UzawOxZRqfcaVX9
         gYl4Ug/GA9qqy8/Oaq7VDM70H05lUu1JHiLGIh7RNwPcP3Vwn1e40QoPzPnWidG03Jaq
         bsJzyT6Zn8nSt6ZQoEd0qJOybtaahknoimSjobV0vD2w8keaMNIwpL7QmQVGeJ7fAuQj
         Q9dCm16m+b/C7jFay71W8oUKGzYUST9ieLYAbuBx0qt1gljRSaRuDhfVaFZ6DLrpGQ/4
         jqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788999064; x=1789603864;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1EXqKImLUULHLFVFsB/u00A+rhPp4MpgJ1nYtLoaJb0=;
        b=NmLLfvYhFsC70vpCAH6TTpMrCc8I7rHCoC1T2bf1vbqvIbOais2gnx394YEGJAwLYS
         r9Mrew7fa23DRxHSiPTmu/Evo/93vd41IyqcpCxwr2sbaKqY6ByqDXueD7k7V9Cw+E9N
         jzvv1RaTvLgYpuggY/eWZSd0mdLepENWUYJTftCz2EHiXG8+WVUBVHpS6/aAuY6t5xkM
         4XkqLSn3V0GSKIcvfZKTJ5TlBMwfXike1coRzauiOTTTt4rB5/hWW9fKJF0AdGrByOR/
         vKqjKM6X0P4C+csz+L5bhNfL3pFxwcSjI3UxS32KSNUSBg3g7PeT3Sde+zBMFGqkzQY+
         FvRw==
X-Forwarded-Encrypted: i=1; AKwUvBzX/bc0WNLUPwbPa/VvEijzmQjFtTrPpWhUB/DnPN/NuSnRUdoQJ1j8huYM0IF7lR44TyA=@vger.kernel.org
X-Gm-Message-State: AFuF++mpO0ARZQ+/0iUmN5ISNH58klGoQa1rSyPcjDHK2KZeegZmD1Nv
	riWDtWdDQB2Dp/NQHsdhat0u9Z+gCKTDuKeQ6U0jO3yOeDP+K0wu61o6/1Yp545FTicxpzPU12K
	x1TnXbw==
X-Received: from pjsb18.prod.google.com ([2002:a17:90a:be92:b0:39b:2614:3bfc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d403:b0:39b:61f1:8032
 with SMTP id 98e67ed59e1d1-39d70ae19f2mr6011471a91.16.1788999063274; Wed, 09
 Sep 2026 17:11:03 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:11:02 -0700
In-Reply-To: <CAEvNRgF6EsMc4iLSM_VZP-5fGGwKv1YJxf-D7Z+DVANTJhxiYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904004342.3162959-1-seanjc@google.com> <20260904004342.3162959-2-seanjc@google.com>
 <daa3875e-420d-4de5-9a1f-8c4138a1dbd8@kernel.org> <CAEvNRgF6EsMc4iLSM_VZP-5fGGwKv1YJxf-D7Z+DVANTJhxiYw@mail.gmail.com>
Message-ID: <aqH1lvIscO8ybcKR@google.com>
Subject: Re: [PATCH v3 1/4] KVM: guest_memfd: Gracefully handle xarray errors
 when binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>, 
	Dennis Tighe <dtighe@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 09, 2026, Ackerley Tng wrote:
> "David Hildenbrand (Arm)" <david@kernel.org> writes:
> 
> >
> > [...snip...]
> >
> >> -	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> >> +	xar = xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> >> +
> >> +	r = xa_is_err(xar) ? xa_err(xar) : 0;
> >
> >
> > r = xa_err(xar);
> >
> > Should be sufficient, right?
> >
> > mm/memremap.c:pagemap_range() uses that and just avoids the intermediate xar
> > value completely.
> >
> > r = xa_err(xa_store_range(...);
> >
> >> +	if (r) {
> >> +		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
> >> +		slot->gmem.file = NULL;
> >> +		slot->gmem.pgoff = 0;
> >> +		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;
> 
> Was wondering if the changelog should explain why not move
> xa_store_range() before setting up these 3 fields that need undoing.

Ya, I'll add some context.  The TL;DR is "look at patch 3".

> IIUC the reason is that other parts of gmem code expect any slots in
> bindings to have a non-NULL gmem.file?

Not just gmem code, all of KVM.  The instant the binding is created, the memslot
becomes reachable.  Because KVM manages memslots through SRCU-protected pointers,
for all intents and purposes memslots must be immutable if they are reachable,
otherwise readers could see half-baked state, e.g. a memslot with a gmem file but
the wrong pgoff.
