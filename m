Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222938AC94
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151925; cv=none; b=SkvpXw92Jso1EJya9CliezwgrfmGHBxdS6CUtUGlgc9eqvSjSIPlSyn0aVbvTN4bFiiBdeGL7NSr9x0l1kND51P/ldJbDsDxurt1XzJFtpPP4hRVftxitV2pJGvyYAbHk9w7OfKdeHOq+PFUHVrRW2IHtlALbTqrNl1+nfCp0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151925; c=relaxed/simple;
	bh=+TcL+IUx6zJmNcAGvV4DgqcF31CbjxR50XVoyThwmtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bCgTOwl7uLcBtYfOAM3GEAGVKE9qN9hG003Amem9wpd9OlWCI5Ku6AHrOlplxt/KBcjqGWGawhOzlC/VvbItoUhUbO7a/C191Bana38b0MXEWwTrT333ULvEMSbwddWAgC75IcczzMwjhyIQXEfZ2NCMYzL09V+++/2kzRRLMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNlgJ4zd; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNlgJ4zd"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8298150caddso4288512b3a.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773151924; x=1773756724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4S848XCbrnwNHShj4M1DfLZem9m3I2fkthB5jWjWU0s=;
        b=kNlgJ4zdsVd3qBHAum9nGNmghoaPQJ377cqW0FhYwSQfu8Y3Di9c4AcY6IQ2DzKuRJ
         oVi736ic09nXzUOlRsixjGdXO5fdx0elouVfO8l0ZsJiHNT83rHWTG/LltWBWz0WDHhy
         x6fy3Zn1cGT265aKkmNNpOCvjEevsJ9faDOBO4arLfguU1f/HYVcHO9R+9BK99ypPVN6
         3kcfBAXeslABcergSuuCXkOVJkN6FGvj4QDFl5FDZGAt84pHBOIxpRgr1AsOzShYGpsX
         zLaiV2m3wHEbOIYXSSlHFjQZQcAeucS46eYbGPFtgBNEqm/nciqeSXecqHqpLY4rMADC
         M6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151924; x=1773756724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4S848XCbrnwNHShj4M1DfLZem9m3I2fkthB5jWjWU0s=;
        b=ghQzsVQnYkxEilpEiNhLZfB6AWKsJmWT5HEPnHwO4CBFdCeG5OcA+EtF79AjcsKTcy
         EU3yYstdO3Co7mOq5AIQL+8auy/e6TrOtNT2q5zXfdhy+zgVnMzk7+YtcifI+W1E1lvs
         tuYh0Ct7VtdZfVrky5BdUz9T+uwyA6jcuFovjDEQxeDzJjSnM+DPcXCoreW7BvAK2DlP
         bv7MnK6Ium2tx8+PPZnc+6rhAJf3hf7aZPzbEgS9dYRSKM/ieLCi+HvCM+pcE6sKnN3y
         l52YJAm06qB4mFXgtFWLMtxtgtR3r9xgEdOCFW/K+6/ivDguG689u1mQJzl02oyy3x1M
         IZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWRZGCqu22FywCdKvG9vANxdhkjia7g2dAIRLxs0a5W2vyAkUxvgWuuLnhkb4APYnxy/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ya9l7SMahFSv6qAnUt9uH+FPSz+bD26xFxeBhPIJqQuOYOAS
	IKMkTByMVkmhaBoHWuRkq9UPWJX/upQypoz6ulc978NinoG5jkjL0cl/t4jeFqreV2DBuTWpume
	vMGfKhQ==
X-Received: from pfbei4.prod.google.com ([2002:a05:6a00:80c4:b0:7b9:1e6:e516])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3021:b0:824:ab8d:6f9e
 with SMTP id d2e1a72fcca58-829a2e13ba0mr13263019b3a.29.1773151923806; Tue, 10
 Mar 2026 07:12:03 -0700 (PDT)
Date: Tue, 10 Mar 2026 07:12:02 -0700
In-Reply-To: <b9a1319e93b6445f87ae87a6c419a07f@baidu.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309092132.2484-1-lirongqing@baidu.com> <aa7o-4eHAfTikGec@google.com>
 <b9a1319e93b6445f87ae87a6c419a07f@baidu.com>
Message-ID: <abAmsiyA4y83ZkXy@google.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbPz8/P10gUmU6IFtQ?= =?utf-8?Q?ATCH=5D_KVM=3A_eventfd=3A_Remov?=
 =?utf-8?Q?e?= redundant synchronize_srcu_expedited from irqfd assignment
From: Sean Christopherson <seanjc@google.com>
To: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Li,Rongqing(ACG CCN) wrote:
> > > Removing this call reduces latency during resampling irqfd setup.
> > 
> > May I ask why you're micro-optimizing VMst with an in-kernel I/O APIC?
> 
> Few devices use it anymore; I just think the kernel ABI shouldn't require
> synchronize_srcu_expedited.

That's a *very* broad stance to take.  For all intents and purposes, eliminating
SRCU synchronization in KVM means eliminating SRCU usage entirely.  That's not
completely infeasible, but I don't see it happening anytime soon given how much
KVM relies on the properties of SRCU to avoid unnecessary serialization.
