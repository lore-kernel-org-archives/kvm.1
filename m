Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873368;
	b=GiPU/+Ufe1lVWsj9/RZV008I4AVaSmPqHy5AFgHSoFo2X6SsNAU6hX63XqZ1GDXQam3t
	 XPdikDKF7N3tw6aU0ExQ3J3aq9ubtP0CuI9FZ9GkHqjkU9lWIM4KC0cq/OUWB1yLbgDfY
	 8Qetb4twmteNmhQI5UBiptv0LAiOMi8RjX+CjXJlRHIUFY5jJz+YG138aI0PITv2p9Ndv
	 PKl+9mfs4zee5FavtYYHEFErbePTYPCmcEQFZCWhP1glwMUGY7ItJice5uSPJC8e1wm7/
	 jWiWffR9dTv58hApzmefM0SVV3QzzYKiR4ZTnelkycaJlEHGLAunpkSuIhFKtB8j0dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fM8BvtLW9s06KtNJra4C3dkWSMEENlr39TjRJ7lsWKM=;
	b=3kjSEsGP6QcM4Qvrrm7LqDmitr0ZhgYbFYRODzzs3MrpOokEX/WXwmVXuvdhk14U5dZh
	 mUwu1cU6Z5J7CXror1KW5K0b+hOh2WXACNMm9TaSIPGfNMdD4xeGl3hRbJ+1nMTO0/d0v
	 O5gGCtrum/lg3hEB7UcJY/x3rWbULpHPx0mv6AagNyIpmNzawT3Z5dv8zjILb/8sUu1fV
	 dTzO2mt7xdvH3pzP/tnJ559sYJhR18jKAzbTzAkuyVAYoxmGYBUGa1m+47Lc1Ez03M1lN
	 WgKJrDQ8iK0t3U2tkKbIj3xa8h/16hprK+rrLKAJ4YXrdCd0RB13KyIJ37IlBUAgZww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PAcK3R4K;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C50606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 23:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76C50606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PAcK3R4K
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed276af91dso61921855ad.3
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 15:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794873368; x=1795478168; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fM8BvtLW9s06KtNJra4C3dkWSMEENlr39TjRJ7lsWKM=;
        b=PAcK3R4KP5NzTzBgDklbrxNpr+mWw0evOjbMm/NEKaUP4f5jIahkQcSRmn/LQCg1KW
         Dy25LFzQy+eWhV9aohUKn1qFF48t3hUt6aWxEjm3bnKgHv9Sii55U6DnUDl83qbyf8MC
         prgPkGaKEte3R77mx+Mzmf5LhtCJoGHlHXgCYYJC+rZIiQ0J07/mxx5D0lGvdlDq0Wz8
         TrJ6YaZ3QpFGEZuCtC9B3lBXR4zXqR7KC/15SITkrPyTIm622sLgqKASOgrkhDhx23gS
         6LNg0bwLtBcvRzScdyd0BK82vEu4O14hTLHFZ7sbguThPCHYzVgZwyN6ctZwsYzhosDk
         2QmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794873368; x=1795478168;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fM8BvtLW9s06KtNJra4C3dkWSMEENlr39TjRJ7lsWKM=;
        b=ZBaB5kyTj2099cZhs24wTEY6B32CjrOCSiNtTX3IPHLhBkkeADtTtxv4d6+RoCnKTV
         wS/ejQtVntVnWgDZ73bAYgMouAmGcEBPoZRiGjffc8B0nGOoK2C6e+YJqU5/MkTl9JGO
         s12gRBFQlle9JCnXTYZz7NW0U1RccJ6eit5FWJ/V+tD4sOMvsfa4kSjKCAxB+mTAtTiv
         E24j4rxxxFuQHHvG52wluu34wg7ykVO6jDmb8jnvpfkFSqpVz+LKPoM9G8uSgrvoPxP1
         hMSwnkQ6qwd4Di+3/douruP4KnixiCVYSY9CK/CjuK+uDNs45ilouriIhEFSKkiqjAQc
         PDUg==
X-Forwarded-Encrypted: i=1; AL+hErHLO2wSGrKaCX2vWrPrLhsLTZEehphnI/vlsUnYjmE62JAsm5OKIKd9xa7bXjqDUBbmAOc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JIZdyLucN+2f58v4eU9k35NzM1X9itbw9FQez9FcDPJW/sMyb
	uTN/YuI/GHfZwE+idntqTTV2GL7gon6giWqcgkzV1QJRfKfVTegUs8jAnv+2qApdIIReVxQ2sEz
	+3KQ+kQ==
X-Received: from plbl21.prod.google.com ([2002:a17:902:eb15:b0:2e8:8642:f035])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228f:b0:2ed:697:8855
 with SMTP id d9443c01a7336-2ee0dcd30a3mr128254295ad.58.1794873367529; Mon, 16
 Nov 2026 15:56:07 -0800 (PST)
Date: Mon, 16 Nov 2026 15:56:06 -0800
In-Reply-To: <aviC2OUjvNz_ubZr@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164000.467175-1-seanjc@google.com> <avdAIMDfgL_wy1rx@gremlin>
 <aviC2OUjvNz_ubZr@google.com>
Message-ID: <avuYFqt_DAnCiM9U@seanjc-mac.roam.internal>
Subject: Re: [PATCH v3] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Nov 14, 2026, Sean Christopherson wrote:
> On Fri, Nov 13, 2026, Lorenzo Stoakes (ARM) wrote:
> > On Fri, Nov 13, 2026 at 08:40:00AM -0800, Sean Christopherson wrote:
> > And a VMM that's doing something broken (i.e. trying to take advantage of this
> > as a vulnerability), could then intentionally set up a gmem-only slot to point
> > at ordinary anon memory, munmap(), and have a UAF on the underlying folio due to
> > no MMU notifier invalidation.
> 
> Ya, Sashiko flagged this as well.  I was initially planning on adding the check
> in kvm_mmu_prefetch_sptes(), but adding the check in kvm_prefetch_pages() is
> better since the work-in-progress prefetching for x86's TDP MMU will share some
> of the prefetching checks, but will go through the normal fault-in path instead
> of using kvm_prefetch_pages().  The return should be -EINVAL or so though.
> 
> I'll send a patch on Monday. 

Slight addendum: I'm going to a v4 of this "series".  I original thought the bug
was already reachable, but I was conflating this issue with something else.
