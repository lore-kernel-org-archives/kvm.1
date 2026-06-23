Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40F22E3E9
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219421; cv=none; b=UexpO886V2g8Os7tWe5Anvx+gESni6zSCxf/CVKCCjoarn/K7OohHb4/ShmmrtDCtsP4eaXS1cF6xzC3j8zfPQV+r0PjPyDA+mM6Kd+o9V7ZTbEDjHtRRCqrzC3UYWgBL34ESeah7pjQaISFvdG/pirr2Zy2vqg4SVDj3D37sB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219421; c=relaxed/simple;
	bh=cYciK/K71PU3bqDNjuY+Q8z2fxXYxDMG0vk5d6ZKjW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V0o4eVhc3p66aoXXaVFIiu9DBaVD7cVTJCeFO+ZGsQ/gtzjr+IOktSFYCf1fTVrIPGjep2SDq6xrLIPAfFPdqZebOU9CQB5zlhM6IHF1UKDUuq59hcrPLxxO3saityLb/gNQkY104EikXME2abSvZQpsxkXSt/emTQZJsEQlwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ut1NTRXy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ut1NTRXy"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845438fbd9cso4292637b3a.2
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782219420; x=1782824220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYciK/K71PU3bqDNjuY+Q8z2fxXYxDMG0vk5d6ZKjW0=;
        b=ut1NTRXyoE8yRLB+r7JIrJv30u7SlR8w6tZ/i8p0voyyj7DVW6/i0i8hmuQXJw9lIz
         jLYsnhwuIpkaV77Gmw8JhtHtGJj9Z0gvBpeJ8QlwNUcOTSFCwjw7behfycz1T65BZ6c8
         8vxQFJ+BNDIBb5p5ItYL870hpplLvsPb1xHCMdBvpCbo86M0Ge10M8HGX49LGkx6tCOm
         qxnncidFZ64g6MMEYyIXMYUj31Gm7PTngUtLRFPzSEThYD8JDrVopHYWqxC5hzMt+m/W
         77a7WuONrOTdCZque/2SWcKM6Vive84rodBHoogNU/LhV5CZ83355M1EN2XYcd4AMcWv
         s18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782219420; x=1782824220;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cYciK/K71PU3bqDNjuY+Q8z2fxXYxDMG0vk5d6ZKjW0=;
        b=L+F+Qh/Sjx7ilBUKhu2YZU05gzFicwA+NJbVJKSEtXkdAyoyvVXgWi8dWK4h9X8984
         kBwgZZ/IOPsxDdX1ah8yL4oAJrh3fvRb9f+eiBh0wHooTM8PnR43O/0YXdUN4keWLB5l
         mSY4GvJhHfuoRBrsrRWe49PfTi/juY23fhFbYUie53McZQ91tpctzsDh4/UOIMR4P425
         iBGU8OHAi022RijNeZfNn7B3VXbnpIyW5kirJO7dCOwpJLOHogi5497cnB6ZEOo70Rx5
         AQ7TED5QMi6d58cuvTooGRjqAGTDKTcBakHMT37/SUWyb6dj1b2pP6op152r7EeIYl/b
         rb/g==
X-Forwarded-Encrypted: i=1; AHgh+Rr9QuDdZ5tP3ixWBjbQwYeSthqomo2BrANkkxfuj0iJZfFr8GjhXKeIh7ijK4tpTylegTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHUDPlSI1XTUQFvkouwoevkFkYTY9ewfYKdkV50F7zLkg1uEY
	fxXQI0mleU1QmsFh8SbNq3HRAcYL3pwvkVtXGRMxU6CcLNZLzHhfIr4a7q6q0BW6i5Drg0Jk5yv
	15ncoTA==
X-Received: from pfez11.prod.google.com ([2002:aa7:888b:0:b0:844:e56c:ba8c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f08:b0:845:43d6:14d7
 with SMTP id d2e1a72fcca58-845507e017amr20047637b3a.16.1782219419781; Tue, 23
 Jun 2026 05:56:59 -0700 (PDT)
Date: Tue, 23 Jun 2026 05:56:53 -0700
In-Reply-To: <ajpSF6HyhgBA3uV3@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623091556.1500930-1-joro@8bytes.org> <20260623091556.1500930-3-joro@8bytes.org>
 <20260623092417.5964D1F000E9@smtp.kernel.org> <ajpSF6HyhgBA3uV3@8bytes.org>
Message-ID: <ajqClZ3kHfDcCxUe@google.com>
Subject: Re: [PATCH 2/4] kvm: sev: Unmap pages in correct order in sev_gmem_post_populate()
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026, J=C3=B6rg R=C3=B6del wrote:
> On Tue, Jun 23, 2026 at 09:24:16AM +0000, sashiko-bot@kernel.org wrote:
> > Should this second instance be updated to reverse the unmap order as we=
ll to
> > prevent kmap stack corruption?
>=20
> Yes, it should. Updated for v2.

Already fixed, commit 138f5f9cbe37 ("KVM: SEV: Unmap local kmaps in LIFO or=
der,
per highmem requirements").
