Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC2376A0F
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087469; cv=none; b=Nc/yGQzq1wwodrNuUSCbcBwKQVI0gaQMwBGhdRsa2vSM6OtolM7t8jrNWyD+9jHQg3/LytKOaK+2amE/k3IOSdXs0tz+ArQjc9R7yZ5u2T9TbNYyHVPgCaS2e7mp0PJcfQEU/e5nbpFpy4Or9xBDqKaK291WbWrwRhcJ9Kc1DqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087469; c=relaxed/simple;
	bh=X7ToM56irJtg2Jolki+zcIFTD4EePOgDnNseuPDjuBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=taRGpDvEnaqyt+/u5tDsSPWD0vAQGxnjITYnUnlypIxqdekebaOni2eDx/5Si4SDBD0Nw3jRNvwkx0NOG21KRQixvZHxAml9Gxz8534UJzyM7L11YqQFghtIQBa4y0aHIY/fnBFz5/uACi8DP5Zbb2qJhMi4T75xDtkZRlAYdD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCKzjw9x; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCKzjw9x"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2baf7378ad0so155667715ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 13:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780087468; x=1780692268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQS7YMdO6nDpRo3dtOS7KCTUy9/WLmbNeezECkxyxIU=;
        b=XCKzjw9xRrX9s06Z74IsAEK9zt+rIsa7v12sj3vpnelS4Rzm2GWfBdkeRs4dBQmv/6
         la8oCX2mVqZp9JYYRLx3WVu31jRgcvBflikXxHKxoXum+2UompyyC24IUox1PF3Ho1Wb
         ChEN0N6SEVZ0dQW63lufOkujOzEBuiytapuBzo5a79cn0qdZH3B7jh376xwv0beOzo9u
         nQIhKzYNYlEPnmJVwORiGIoT2psNcYJyMb9UpOMjtOingzIcY8FVhjy/PeDQCKBpTpaK
         fHvBlAPbmaMY/H+WMTZl3GUGEw99BQB6JIU+LGoNA5nP2cwpLHYfGuWNDA6m9ndseMBU
         M7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087468; x=1780692268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQS7YMdO6nDpRo3dtOS7KCTUy9/WLmbNeezECkxyxIU=;
        b=USSqGRwtkZnnBX+rMYG4QVYYxKmgKRWtargH6OZZVTgLuy/kV2aPr+HrXZRUTHzxup
         /0NuRazMKT464o/WgjvusTyWQih8a/c7GgDNILuifqmWlOk/0jtbYhNx02CsaL2nHU0J
         NKz2gVKC7QhHhah3EG3hpzOKdesfe+BDNR2+SP5ygItYdrB4D4cWkiXIhYmljFxKpo6h
         1HUOwbM8W61i2z9AAgufOwLxDWHFlxxa46goec2tcfRag6FxL0MhonQw4YN6aP+QKnMI
         wy2iqqoFpuz7BPVwmJ4R20Kd6kSvz0G7HPePeJ92+lP/oVvmncZVjYOxaqrRptsVsm+P
         mTEg==
X-Forwarded-Encrypted: i=1; AFNElJ/7qZMBSCSwbUni8/0+PoC3DWcGYWl/gZiqHKr+CVoENyaXdrID7xeovHCWiUqsKL5nua8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ziwZ1kOZ5vwpZLvmau5jKZYkja4CdlN9eeeiDMh17Wbc3zUO
	TzTjC4CYhgpPHU1192yXWU6VeTWZ2LHu6qSaFVsBuyXLiDL4JZolFOeDG9D8i1WtO139mKUPakw
	DLx/icA==
X-Received: from plbmv7.prod.google.com ([2002:a17:903:b87:b0:2be:f9c0:8cd4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:986:b0:2b0:608d:d8a8
 with SMTP id d9443c01a7336-2bf36795211mr16688475ad.1.1780087467675; Fri, 29
 May 2026 13:44:27 -0700 (PDT)
Date: Fri, 29 May 2026 13:44:27 -0700
In-Reply-To: <CAEvNRgH21BoKT1mOQzgmKHKpDi4xbwtbMuenGv5U1ZUSENrJmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-gmem-inplace-conversion-v7-16-2f0fae496530@google.com>
 <20260523010607.CCABC1F000E9@smtp.kernel.org> <CAEvNRgH21BoKT1mOQzgmKHKpDi4xbwtbMuenGv5U1ZUSENrJmg@mail.gmail.com>
Message-ID: <ahn6qysOGfa74A2E@google.com>
Subject: Re: [PATCH v7 16/42] KVM: guest_memfd: Determine invalidation filter
 from memory attributes
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Ackerley Tng wrote:
> > In __kvm_gmem_invalidate_begin(), the code iterates over f->bindings using
> > xa_for_each_range(). The retrieved slot pointers are protected by the kvm
> > srcu, but the read lock doesn't appear to be held during the iteration:
> >
> > static void __kvm_gmem_invalidate_begin(...)
> > {
> > 	...
> > 	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
> > 		pgoff_t pgoff = slot->gmem.pgoff;
> > 	...
> >
> > When a memory slot is deleted, the code calls kvm_gmem_unbind() and
> > kfree(slot) after synchronize_srcu(&kvm->srcu). If the read lock isn't held,
> > could a concurrent memslot deletion free the slot while it is still being
> > accessed in this loop?
> >
> 
> The issue here is between __kvm_gmem_unbind() and
> __kvm_gmem_invalidate_begin(). Since f->bindings is protected by
> filemap_invalidate_lock(), I'm dividing the analysis into two cases
> where accessing slot through f->bindings with and without holding
> filemap_invalidate_lock().
> 
> ## Holding filemap_invalidate_lock()
> 
> If unbind happens before invalidate, we have
> 
>     filemap_invalidate_lock()
>     __kvm_gmem_unbind(), would have removed slot from f->bindings.
>     filemap_invalidate_unlock()
> 
>     After this, slot can be freed.
> 
>     filemap_invalidate_lock()
>     __kvm_gmem_invalidate_begin(), which iterates f->bindings and doesn't
>        see bound slot.
>     filemap_invalidate_unlock()
> 
> ## Not holding filemap_invalidate_lock()
> 
> In kvm_gmem_unbind(), __kvm_gmem_unbind() can be called without taking
> the filemap_invalidate_lock() if !file. The only places where NULL is
> written to slot->gmem.file is kvm_gmem_release() and __kvm_gmem_unbind()
> itself.
> 
> kvm_gmem_release() is prevented from racing with kvm_gmem_unbind() since
> kvm_gmem_release() holds slots_lock, so since kvm_gmem_unbind() is
> called while holding slots_lock, it should either see a guest_memfd
> memslot with a file or no slot at all? Perhaps I'm missing something
> about get_file_active().

The comments in the code pretty much say it all:

kvm_gmem_release():

	/*
	 * Prevent concurrent attempts to *unbind* a memslot.  This is the last
	 * reference to the file and thus no new bindings can be created, but
	 * dereferencing the slot for existing bindings needs to be protected
	 * against memslot updates, specifically so that unbind doesn't race
	 * and free the memslot (kvm_gmem_get_file() will return NULL).
	 *
	 * Since .release is called only when the reference count is zero,
	 * after which file_ref_get() and get_file_active() fail,
	 * kvm_gmem_get_pfn() cannot be using the file concurrently.
	 * file_ref_put() provides a full barrier, and get_file_active() the
	 * matching acquire barrier.
	 */

kvm_gmem_unbind():

	/*
	 * However, if the file is _being_ closed, then the bindings need to be
	 * removed as kvm_gmem_release() might not run until after the memslot
	 * is freed.  Note, modifying the bindings is safe even though the file
	 * is dying as kvm_gmem_release() nullifies slot->gmem.file under
	 * slots_lock, and only puts its reference to KVM after destroying all
	 * bindings.  I.e. reaching this point means kvm_gmem_release() hasn't
	 * yet destroyed the bindings or freed the gmem_file, and can't do so
	 * until the caller drops slots_lock.
	 */

On a related topic, I posted a patch a while back to clarify exactly why the
release() code is safe.  I need to get back to that, but in the meantime, more
eyeballs would be appreciated.

https://lore.kernel.org/all/20251113232229.1698886-1-seanjc@google.com

> Would like Sean to check my understanding.

You're not missing anything, Sashiko struggles with scenarios where thing X
makes thing Y impossible.
