Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194797;
	b=M1iGgtHGiBEi/ZErIjo9ewUejlmiC95gMRBD6NMwi3jDzgr2DGQcD8GDdNrE1EH3BZI3
	 pD+9o5SZqctBjf0WdyDCeQvIn5mndkFgnovXlcA0ZXAT0j9jCqE9YJU4Jnca+6SlLGaao
	 5HtdCMvV6YkSPipR/MZLadwoEBzZ+RLdAmX/P+TzDFYx1IfLx/jXNjkm2n3NHYUEv0MJ0
	 FUOrfsBwtZ8RxUGQPKrQkZV7Yv8gFohFt3MCP1w65HqIJt2ajQbdghkG8LCNVowKVyxQ7
	 XdZQrTGMnqgFggW2DQ6A6xUtpLYpi+EJwuCUDGf1mWsk6lKK6QfavkbUs1Cca0dT/rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xZLmLgFNAyARHxSBRStR7OWRqN4IR/DocC51szk/rqU=;
	b=ZuYiuVaqLtB+gx4OuxXXfcZ2YfGyOJn3PQyRPL00c+LVmNdDFpK4Xd4N4C32/Nbu2u1g
	 +SAh1IUSaQGOZXBRwHG3kSUclZYml6RJ/wddAAEpsgsMiG+8Tw+ExXsuxN22YhT6MnYFr
	 4r0xJqtHGDvw01dZncr/DKiaTmTJtM3yWqrxoG4wG0dFHiKYj0M83ciKWGnx5B/svEhbW
	 8kcd8PVf494SkC6n5IhaL5Y06P+xAfnI4WTs04vke1LlNWG7lxGHelAaLpjuKN7P7LbaO
	 6Odm37IVk0dN8vyo7KLdTo1kh/f4mWQ1r3F60RE2wR3a4Y/9WqcjgrodlMT7QGoH87w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LESjSuOq;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0E606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AD0E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LESjSuOq
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89e05d31e54so820117b3a.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793194797; x=1793799597; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZLmLgFNAyARHxSBRStR7OWRqN4IR/DocC51szk/rqU=;
        b=LESjSuOqN3OggtzntL0MzqzWELNEjFn9nkiqWH4PX3wHLkJJqeFEE9kmk81CDLlTyt
         Tf2EHOG6UWOyZB6dEXBOUfsAbpPwlhBdYtRgVpnN3+CI42GQmkz4OCsKsHAKy3hZE1Gx
         83px2HXR8hjMZsKqnQRzztL50uRZbM3MDFmyDuFAb4MzqWW0saqAlKEWrbpDyVDsPtSe
         rVBlvp/mxjqHfxlM0BdasHLfYWJ5+eZMGjqHvqjQT5ZEcG2nSpd4mPLsnRT9EfPYPxwm
         IMvEGcffyNcx4EJLNX+OteMXRzsMDnOVf1MN2fMdPgQt/fOq0mbwGccQQ97JalPJA7OX
         8fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194797; x=1793799597;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZLmLgFNAyARHxSBRStR7OWRqN4IR/DocC51szk/rqU=;
        b=rOeueP11yWqoKs74MSOBs1xYwT68zpAVZ8YHd/7iClBC9dNZkr2jqs7myREdks8Y1j
         GCFRBjAyylkHC6I6pjblFflmGqRHi04SNYyVUVT3EmXA2x8YQ6jvYz+J3wpTcKrVjrBw
         QjAgiQPItHcg4higwjUpGBfVVU8By+F/JS29Wn5RaaMj87kN9Vli+Qx4XSneAaoDRDEa
         lif2v/81lQgyx3Su+E9y8h5ewPc7IO2+jy+mGpnJdsKcrOzfp5pe0J248W3RHnnfrWC+
         kOEMTfJHHtTKc96zKBF5wATk5K9LBXA1QEeJ8372JbKiz5ecjw8V3SvMOgM2CrVYUaex
         SOEw==
X-Gm-Message-State: AFq9FYLYkkFEsBAKRlrU/Czvi0JV7qRyWjapHpYV1wUCydAOCXA4RJ0H
	jLQpJ/QPuYJhSt5CZJQ03Oc6nQYchik/bel6dDOplQ6bHH7Dzhw/3d3U8CN44D7rUo75MpHliAp
	pnQswNQ==
X-Received: from pfaa28.prod.google.com ([2002:a05:6a00:a61c:b0:89f:30c1:9a96])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fd4:b0:878:6ee:672b
 with SMTP id d2e1a72fcca58-8a6e6ff34e6mr1964985b3a.35.1793194796562; Wed, 28
 Oct 2026 06:39:56 -0700 (PDT)
Date: Wed, 28 Oct 2026 06:39:55 -0700
In-Reply-To: <sashiko-outbox-187201@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027224914.1574319-1-seanjc@google.com> <20261027224914.1574319-5-seanjc@google.com>
 <sashiko-outbox-187201@kernel.org>
Message-ID: <auH7K0Sq0KcApJGq@google.com>
Subject: Re: [PATCH v2 4/6] KVM: x86: Recompute EFER.LMA instead of inheriting
 the current value on EFER writes
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 27, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] kvm: x86: guest- and userspace-reachable WARN_ON_ONCE() in set_efer()
> - [High] KVM: nSVM: guest-reachable WARN_ON_ONCE in set_efer() due to stale EFER.LMA

As explained in v1, I don't think any of these are actually reachable, and if they
are, they are pre-existing bugs that need to be fixed.


> - [High] kvm: x86: missing MMU context reset in set_efer() when EFER_LMA changes
> --

This is a legit flaw though, though also pre-existing.  I'll tack on yet another
patch in v3.
