Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309DC431491
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440200; cv=none; b=rKmJILz1MTr9wyKN3xcKHiPv3gRtNeCcgnFG63qlrCSbK/RIqEHCRMqnPSt1/OPtVRYlB/92yOhubEhAkH1Po24bP429FXT9AFDWHwu5k+/KpySXT3HMq478K1thb2Hox6rqhC6+Rc8BHGzShz1TST9gLY38v8hHmPP6YojdrVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440200; c=relaxed/simple;
	bh=MRwZ9no6SnLvgcrAWxdx1p+YVT0L0Ns9i5czUpMcAKY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bW91RcNK7Pj5LrTKTfFEJi+KSEK8DeedNHuQWsPCf2OjI+b8lvYOPCIn87J/w+iiCEvgoQjzcJQhHjCWXGz0C7tIp/nSC4kPEjYU1uKh7CNKOjfxmGizzlm7L1AIv86fFImSCus/b3JZ0ExFBohDsu+JjAmuUFTj0kdew3uDXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kjJz5qeB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kjJz5qeB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c8018f11fbso57737755ad.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783440198; x=1784044998; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pL69ZVdKR5D25APZYCYruCm0FglFMWTjtZf4734SenU=;
        b=kjJz5qeBFzhVypLWYl3tnwlA8ZRUAnoBrH8/Qz/yJm1rS5x4TgymOGS7iFp2LZyKpI
         SuVAOxNvDmK6QB96oGhxiJITPCmUuOikQbO42lbJ8dCCXu5lkylJYEGiJn3s33qVu2T4
         hFFi+CptnnnTjjlYM+0AQOQSu30yhvJdlR0JiyVE7rvl0JGU4d3WxjuoPB/ruzSAcdHp
         aoYpiMEega8p60fq4dFQH1IXhC4j7XbzZgfc8jHceYUdpZp05JnW+o6ZJnZVivZFA62v
         SgCPYQOSUKF0e36cuYi3hnIyDdQym9lLXD3SpAfvVfr/FM0eQO9tAzdbep0klslbYwqD
         J5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783440198; x=1784044998;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pL69ZVdKR5D25APZYCYruCm0FglFMWTjtZf4734SenU=;
        b=NmQy43fOJE8oDKl7wnMrn3sXcgFHwPt3GOKtRnuRB6w/+ejaWdRN6HLKVBsKQq7SRh
         eYt4N4Vef0GrS3vRsWnzd7VN/470w9q8COeFgsjaJrjxPVbmdsH56jKz3g95KNyj9sKp
         Q7Fh5HTvAjcR/giUhQg5utY08VvG6/U9y4qqmDkezQ3paccAr5gAiYO9AJXpPOlA+SnF
         x0GusbjpZoxc5hR8BbRG+UR4nUs/BTWS1TZEdsKtdHg8IijwtJj5VIpXD23QyZyLq003
         DABdPiU6pvs/tIB/TBqKFqEBzKoGAtvT3hfh9f2Z7BjPz5txD4T47NTgTebZKRwOOt63
         wqyg==
X-Gm-Message-State: AOJu0YzSzfwgQqesNt66KlnvHxrKIJqAjwgxgMCdNvM3OZlKnj0qkfXo
	K2EayV1qIfzdd8kcsKuG2CNZEexUiIbvHhX9h584dJNy1MrkGVgpJwCkzeo+HIqIlOViurj9WMB
	NkEzQeA==
X-Received: from plpk2.prod.google.com ([2002:a17:903:3da2:b0:2ca:c401:c941])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0f:b0:2c9:b48c:fdde
 with SMTP id d9443c01a7336-2ccbf057775mr60146615ad.26.1783440198329; Tue, 07
 Jul 2026 09:03:18 -0700 (PDT)
Date: Tue, 7 Jul 2026 09:03:17 -0700
In-Reply-To: <20260707152105.8FE671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707150706.1198541-1-seanjc@google.com> <20260707150706.1198541-2-seanjc@google.com>
 <20260707152105.8FE671F000E9@smtp.kernel.org>
Message-ID: <ak0jRanrFxDC8F0P@google.com>
Subject: Re: [PATCH v2 1/2] KVM: selftests: Drop superfluous use of pthread_attr_setaffinity_np()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 07, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> > index 76fcdd1fd3cb4..a244bf9f701f7 100644
> > --- a/tools/testing/selftests/kvm/steal_time.c
> > +++ b/tools/testing/selftests/kvm/steal_time.c
> 
> [ ... ]
> 
> > @@ -558,7 +555,11 @@ int main(int ac, char **av)
> >  
> >  		/* Steal time from the VCPU. The steal time thread has the same CPU affinity as the VCPUs. */
> >  		run_delay = get_run_delay();
> > -		pthread_create(&thread, &attr, do_steal_time, NULL);
> > +		pthread_create(&thread, NULL, do_steal_time, NULL);
> > +		pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);
> 
> [Severity: Medium]
> Can this assertion spuriously pass if pthread_getaffinity_np() fails?

Yes, but that "flaw" is "fixed" in the next patch.  All in quotes because IMO
neither scenario is truly problematic.

> Because cpuset is not cleared before calling pthread_getaffinity_np() in
> main(), and the return value isn't checked, cpuset will retain its previous
> value if the call fails. This could happen if the child thread completes
> its execution before pthread_getaffinity_np() is called.

No, because the underlying kernel task is alive until pthread_join().

> Since cpuset was already populated with CPU 0 earlier in main(), the
> TEST_ASSERT would read the stale data and pass even if the thread did not
> inherit the affinity.
