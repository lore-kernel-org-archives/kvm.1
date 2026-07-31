Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC47221FB4
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502831; cv=none; b=OjdR+5UvtZ2MYAJ2qZfP7oU3V+Q0/PlP/ctRqU3c9flkx5JwxH895NNCE3ZTSjL2ZcbtME1LqW1YDZT1UmawxrnVlp/EPUIh9Tc3YnG6qpT7WZ1LRSlZRr8rsgibCM2H6L4tPsv5AcgJeK3S1c+ysDl6+sdUDjN8tQTQmzR99PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502831; c=relaxed/simple;
	bh=gP0NW1Gj2B2BTBK8qEpzwW+mSr4iWHeoSNmWkG0WWDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NuAQrcMTkr+kCtjouKyfDSdmf4N+lm88HXC6vbXv05Pu24299G+/1HXC5U/aOBL5XOyvuQWg9f0Uk/wxwiQZFLn94Am7sQ1EWnOzIvmTIPxjsLDyd5WTEoZdC0N0ma3uF958m/7oifMTJ6jzCsM+OkuOUj7qyyR+VBHAHpAW5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GBcy1unU; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBcy1unU"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8486c3411c8so1326979b3a.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785502829; x=1786107629; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFQU8iH1zNafQF+sd3fwpkuxE9NFiGxCV4Yz8a5shVE=;
        b=GBcy1unUrChsMEdWwJ4MJFPLlt+OT2+cPo0MsWGT9pix61A3FXi2D43k7WZsFOoyRT
         4QUD1SgYSc2qmp4HGMBnbM8jMrmAwZuCRV7RJ+SO8f8xbDX8MvMUnK1NIK9BAsOzZOUu
         oevvPRSMnMZqsMD3LsWZwseuUR6A5TaV+cf9PKO2G96WpgsMhgjOXfdOa/t1attb+kSZ
         4r37ujpqOtkJsY7cJ+XEoTDpk2BH2RXCf7a1jSyUXj7R8MY7e7WFKQeM+2XE2VgpTb3v
         lIMKz74/HF5N62zUe0H1oZ1sf4GLmO3biV02NCnLpOsNMXnCadiLWgmiVUNpbyvCAdxs
         yIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785502829; x=1786107629;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XFQU8iH1zNafQF+sd3fwpkuxE9NFiGxCV4Yz8a5shVE=;
        b=lW4FvhqmzvL6ugs/2toysu8SQIjiQlnjJW4IiuS63eLhsGN8QHHqbGQXxNqCn/cAE+
         gLtYaOoTyoWnLFnjqbX1rm2SfvWCwDAfk6SekE6eaOjxM4e/vOzE1eXpOyir6vVNN4UZ
         +cYkpRX8/2K5jA1uuvuRaabPee68CNeqz6azIyRxfnf2gW/KDmAp+KszsJJpjmQKd1XL
         A9VUT2CrXbpjqeXoY980fpyAlo0noDAptTwD8cjKxGaxCcdOHprTnv7h41PXbA6L0X6+
         l4kOK2BB5TkeObnGhljhP68ojt+xO+WRc4Al9Zsv7oH1s0zOaD3HArOb4YRVtABE6DVS
         JQ1A==
X-Forwarded-Encrypted: i=1; AHgh+Rp6MlzTYb1zB2wY6G8pyTa+J7iNuaK6QpjBIZhiDhulCtFY3hQ1MC9WRpsqX6CUNs7TVEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyinP8POR/Uj2kcVFrh+FwNYWsgi9wltsDCst3zdJSvRb0ScM7m
	B1GaHe3JJtzm+y2M+4XQcAWmhyDAWzd/iGoe7goRQ4gqvQDNkk3Hz7zclx5yVjGOc20jfL/y9Cb
	78+3fSw==
X-Received: from pgbfq12.prod.google.com ([2002:a05:6a02:298c:b0:c8b:2706:11a7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:301a:b0:847:99bb:b6d8
 with SMTP id d2e1a72fcca58-84ed6ec0944mr1900997b3a.26.1785502827606; Fri, 31
 Jul 2026 06:00:27 -0700 (PDT)
Date: Fri, 31 Jul 2026 06:00:26 -0700
In-Reply-To: <20260730193035.CFEDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730191908.2084803-1-seanjc@google.com> <20260730191908.2084803-5-seanjc@google.com>
 <20260730193035.CFEDF1F000E9@smtp.kernel.org>
Message-ID: <amycahxKDq0cO0ri@google.com>
Subject: Re: [PATCH 4/9] KVM: selftests: Drop unreachable, dead code from
 hardware disable test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 30, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> > index 1bcbd13e99947..e08aef94382f3 100644
> > --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> > +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> 
> [ ... ]
> 
> > @@ -96,21 +84,19 @@ static void run_test(u32 run)
> [ ... ]
> >  	pr_debug("%s: [%d] all threads launched\n", __func__, run);
> >  	sem_post(sem);
> > -	for (i = 0; i < VCPU_NUM; ++i)
> > -		check_join(threads[i], &b);
> > -	/* Should not be reached */
> > -	TEST_ASSERT(false, "%s: [%d] child escaped the ninja", __func__, run);
> > +
> > +	/* Wait for the parent to SIGKILL this child. */
> > +	while (1);
> 
> [Severity: Medium]
> Since the child and parent share the same CPU affinity, will this busy spin
> loop cause unnecessary scheduler contention with the parent process when the
> parent's timer fires?

Doesn't seem like it?  Or rather, any contention between the parent and the
immediate child doesn't seem to matter.

> Because the processes are pinned to a single CPU core, spinning in this loop
> burns CPU cycles and forces the parent to contend with the spinning child for
> CPU time.

Yep.

> Would it be better to use a blocking wait like pause() or sleep() here to
> reduce scheduler latency and avoid 100% CPU utilization?

Yeah, it makes sense to throw pause() in here, if only to maintain equivalent
functionality.  Because that's effectively what pthread_join() will do since the
grandchildren never exit.
