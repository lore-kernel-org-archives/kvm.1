Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5DE442B2F
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332029; cv=none; b=Ddn/UlzPmTijsikRt1W7DHEpghgtiJUC4rnGP118qeUkuC1G9t0nsu8x00QeWCcFwMkx3Sa6AFrW43u7pP1DX/D4VhUCX9phwLlrW9nib30uX76QoEsjZWDOgerQgZvR8o101elPxLsgDByJs1NsHgJuIzrpa1n9DBxXI40oKoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332029; c=relaxed/simple;
	bh=K0ygnMAFELlBdyDd/KT2teaL2TrzoS7MwyViwa4IIDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hy5/EYHyntpmgHO6IoCbOfF1gw2WkMO3B14zdZX4WCCNnnAiGVB1pqqshZD5rQ8WE0CHWvN2p4W5rI4Pscb62cL/8tnd7rkWOqMFCRR4sz/0vtHektD7iB5OqD9645KJXyqd0U3H5JpsEK3bqPWDKNojMqBQ1xsupsn6ruyUzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RUlC4an0; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RUlC4an0"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a67b16217so1687343b3a.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785332025; x=1785936825; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8cpEO4JktV/Wn0qoLGpZpmCga6uZX3snEVQEMhCVZKg=;
        b=RUlC4an0NK+KSk0bldd6JbuSoYyJT3L4jbBdTVeTbLujCnky/7nDw8boOCzRsgNpLe
         zzZTL6FUfh0zq0OlOLFwB4dQVtvslnuD9yzgzbma/RZks7Hsu3y3sAEokOmvKtGS6bYs
         uOYTy3bwDw/RWYSY/KtHWjw/WYDuGx1VyUsK+52N3MtzSrBw8v1+k1k1grhF9w2dPXNM
         vjt+w+150K5aPz/P4H8nzvzOC66+PzMrqS+bRURSmvyvKekRxv059uTODmWiKFvAV5GU
         7u/iIxmtt2PuokxK8fVhUpJSE5pr95kmxvofy87t9wNLPpxAtXhDb7PQL6lLWRl2F3P7
         NXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332025; x=1785936825;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8cpEO4JktV/Wn0qoLGpZpmCga6uZX3snEVQEMhCVZKg=;
        b=V1nYgaGdFla30rCoVeGtl/amew4+WaVtkKpVxsaglZKb9534uaft8dIIgypOIFcZoQ
         8Y1aKwiBJfNgCpRXfqvaQ5XkbQgqJo0k9yI0hww4gAXqNcmV0aDyXkE4yqkIcFN/PtrA
         7H9Qskmoai930wuXVExTXl8ONDTKxioLsTDtIxXbc3krwyquciwh4uXKyHEH8lFQybXR
         tpoXQmY4TvDBCOVNAF/nPAt7Qq7+8VCNvKxykHlGy8D/HcubJnJI5g8vo2R0O+XzQsvG
         dARJv2ug1tpSjxuvODJYbsHk6IPSS3fRunqNb2PmcDah5m8MqjEkMMg7J5sCdwalEuQC
         4kxg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/LywWsA8gsW4WfXyWiio694jTWxZddw9YpAq4aRgY3CqoJmcr40jrECCABp3nbdKM2pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQGVckENo+qeNRuSq4xFi4f1pjM6VMtBK76i9ISxwf25hrPdO
	0+kfDRTC5r+uYornQ4GOxaE3kgErRj3uHyFX2L3lSt7BPos2QmEbe80kA8F6Zi8VgEvGGf5URai
	sO3evZg==
X-Received: from pfbjc34.prod.google.com ([2002:a05:6a00:6ca2:b0:848:4690:d658])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc7:b0:842:5da3:9b89
 with SMTP id d2e1a72fcca58-84e932ee1f3mr7600555b3a.38.1785332024476; Wed, 29
 Jul 2026 06:33:44 -0700 (PDT)
Date: Wed, 29 Jul 2026 06:33:43 -0700
In-Reply-To: <99aef43760db560d32e12e99df6bf209c67260e8.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728002236.869865-1-seanjc@google.com> <99aef43760db560d32e12e99df6bf209c67260e8.camel@intel.com>
Message-ID: <amoBN62nWqEgh0RE@google.com>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: Use LOCK CMPXCHG to clear Accessed bits
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"jthoughton@google.com" <jthoughton@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 29, 2026, Kai Huang wrote:
> On Mon, 2026-07-27 at 17:22 -0700, Sean Christopherson wrote:
> > I initially was planning on tweaking the FROZEN_SPTE value to make it ok to
> > use LOCK AND on Accessed bits, but AFAICT there's no meaningful downside to
> > using CMPXCHG.
> 
> Maybe do both, e.g., still remove the A-bit from FROZEN_SPTE?  AFAICT there's no
> good reason to keep the A-bit in FROZEN_SPTE.

Hmm, I'm leaning "no".

Once aging uses CMPXCHG, the A-bit isn't any more or less likely to be corrupted
than any other bits.  And arguably, using the A-bit is "safer", because (a) it's
got the same bit position on EPT and everything else, and (b) spuriously setting
or clearing the bit is more likely to be benign.
