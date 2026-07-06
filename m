Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D193242AB
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374366; cv=none; b=mOclxJJ5WdDGrKzUeouWr3O37HAk2+A6QU0iTKQGqrzdTXr7XFLCMpVBibm8Dp3y+KL5Z1okRGXLuOzJ8uXqk0FDM939+4SRJj012K6+m1bPRZt3TiMDnST6XKNZyTqmNen/1y10HrOElgkj52q4YmR/0qGOMFtjIRLERY4IbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374366; c=relaxed/simple;
	bh=3N4ytG+E4H/OljtRigUhcR8G4j5CEvRKQ9nzA6+RjxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hjZpkDPgJGxxXPi76TiQoW+Id9dOV3hZu6AVuP4CgzjgEVZB1cUuvB8GQs1fjk+gf1npVBWuhIwTOrLE0NbXBDh/KXk/6+ZoHWcKwOCNc8TggwhElgDxU65YpR7YunYwFxcI8j6hD4O/Urv5An43O3PXobSjeBbMm6NRsZ/W7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nk4BW51F; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nk4BW51F"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so2115126a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783374365; x=1783979165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1AXWpDbuwot7e/IsmprnSM8i9vxDyXshC7OCwJGDTM=;
        b=nk4BW51FxeEHz5RIRAsMxqp/7tSJtzJ0tATqo3noLyLGDnDWjVPPxhqpRsJp8qCj5c
         kJP+Z4xbIpZuNgRknqdLwh877uANUFMCVzhsSC6TKQVRYc7XAX31zF+PNmNj7P+KTgUz
         mxKCraPdSQEUMmL3xdjdR0IPm+IrEecUdoBhrdkriLr4x7MHsii1FNTrDv9QEDcgwsFK
         +Ji7xb5zgEhT6RBbsAz4JvQsRcc614Nj4UDj6dfFV0YS1e650WiuVBc+DzvsItjm0LY6
         WbntuXD7BnpM1EFLAnKx4Zwc3L/n1bGIDalre/oqd3aRbDrE9VAFcVuhM7sIiSIKSCTV
         ejnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374365; x=1783979165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1AXWpDbuwot7e/IsmprnSM8i9vxDyXshC7OCwJGDTM=;
        b=Pntp1Oxwb0XFM6nCgoDbi0a2lkRIpmEwqY8SNMjr90b31/XK0CCt9cUn8grltVqEtZ
         +4HXD1BIqISsGzE6ShRyzVN3rmb7y0TFFhxaWVYujvr54JzRPI419fCSG+n8zAtquqGc
         OIWIMQB6pYzwAHyVOqYWQDWFXBVHlmF1Gxlh11okH/xfLJr2svRwsT2oe2bTuJZtKDF5
         EaAT7MsjpmvTfe31PaaqqVUeUHxPxWwEM0ht6zrAGs3FBHAIXZcW9zqdBCQq4DR98WqX
         wbIEtqD0+nb0K1zn1d3Y3fpgtRqPfLMUKpWvG4vDEqkm45XaYqKc91mRPOfZTk+RfayX
         pg0g==
X-Forwarded-Encrypted: i=1; AHgh+RoVnonuSMi51mNIZYY0G0HbOAa9pJbG56AR7sy5OhBYF14LmyOF0n0yOkiyQVuCsXJy9lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxutyMgXGtvsWGeAawN5qhCsQq7eVx8uaq1IxrfDXBUKmVFoK5L
	j9NYFI2NJhqzBGTob+lfy65MCBYnxUwaTe5NkKUef8uLRT5XnvQKFRCRdwlGH7ha+wmA6BR9833
	BEkQ9sg==
X-Received: from pgbeu10.prod.google.com ([2002:a05:6a02:478a:b0:c85:a528:228f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:220c:b0:3b7:9c18:c681
 with SMTP id adf61e73a8af0-3c08ec8da6fmr2781635637.9.1783374364514; Mon, 06
 Jul 2026 14:46:04 -0700 (PDT)
Date: Mon, 6 Jul 2026 14:46:03 -0700
In-Reply-To: <akuxjY-VRrmcybjZ@raptor>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702142912.6395-1-alexandru.elisei@arm.com>
 <20260702142912.6395-2-alexandru.elisei@arm.com> <8a24f016-6f0f-4322-b646-d843f6fa481e@arm.com>
 <akuxjY-VRrmcybjZ@raptor>
Message-ID: <akwiG_tDu5Eyyc0-@google.com>
Subject: Re: [RFC PATCH 1/3] KVM: guest_memfd: Use memslot id to keep track of
 associated memslots
From: Sean Christopherson <seanjc@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: David Hildenbrand <david.hildenbrand@arm.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, seiden@linux.ibm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	fuad.tabba@linux.dev, mark.rutland@arm.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 06, 2026, Alexandru Elisei wrote:
> On Mon, Jul 06, 2026 at 09:14:59AM +0200, David Hildenbrand wrote:
> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > index db57c5766ab6..43ef8e908aaf 100644
> > > --- a/virt/kvm/guest_memfd.c
> > > +++ b/virt/kvm/guest_memfd.c
> > > @@ -25,6 +25,7 @@ struct gmem_file {
> > >  	struct kvm *kvm;
> > >  	struct xarray bindings;
> > >  	struct list_head entry;
> > > +	bool found_memslot;	/* Used for balancing invalidations when punching a hole */
> > 
> > Probabably best to document what it means, not only what it is used for (and
> > maybe document above the member if you end up with more text).
> 
> Sure, this is how I changed it:
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 210bdd76f0aa..3cee64047bce 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -25,7 +25,13 @@ struct gmem_file {
>         struct kvm *kvm;
>         struct xarray bindings;
>         struct list_head entry;
> -       bool found_memslot;     /* Used for balancing invalidations when punching a hole */
> +       /*
> +        * Keeps track of whether memory has been unmapped during secondary MMU
> +        * invalidation, to keep the invalidate start and end calls balanced.
> +        *
> +        * Accessed while holding the inode->i_mapping lock in exclusive mode.
> +        */
> +       bool memslot_invalidated;
>  };
> 
> Hopefully the new name is better.

Why add a boolean?  It's not _needed_ to balance updates, or rather it shouldn't
be needed.  filemap_invalidate_lock() prevents modifying bindings while an
invalidation is in-progress.  It might be a performation optimization, but if so,
it's a premature one and belongs in a separate patch.
