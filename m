Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853271A9F96
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782347110; cv=none; b=ap2Eya6i627T5WSQv3DSiSsEoKcomrQOjETeTVsmir0uvlrcxwr3aYmAsPp2GpVaEkWLpUtze6HMedcw/of23k1sywVhUA2HAMMaRvjtygRLbndDJohZh6AW7IRqQ101GBZeuKNRsvn0tCes3LUq+dXGu5t0kgnLyklcEJqoPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782347110; c=relaxed/simple;
	bh=kQQ41EWrLcGkWqhJUIvXbTO9tnD1FkBA7CokSzX+hNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dIXx2sZ+5MvXMvZnffgnuWXPwSxhgO0+47MchFRBnJPZ+YaphkjYRyk9zEqC7gkaV5G4EudUtch9Da4Prw+9sSccNROh1Xyrd+CwCGaIom2XQDB6HANmgMVYyG+gd1QV8Gd520lq6HA+Hj4vy2GwKfpKWEhvi3mOVvOh3GEANy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTcrJdsC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTcrJdsC"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37df0ae3ca8so410202a91.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 17:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782347109; x=1782951909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XWGM/P1xdNUmP/2r/ojPGVaA8AsMQHAHTqUpXvu/HM=;
        b=sTcrJdsCK4NDOenf6k6wQiV/OGGO+nFgugMbFK0lbQv1m+dvzYk/S35H7KXHxntAdS
         idBkJc9eW9km68ejZPx0WRf1dll1aLtUymKsyMZAxxvUFVl82IPQxlRN798bwtDgEoZ/
         hLvUL9ijN1sZi61DMG7yzd/pZH2QbIPn/e3VLLEutrlJ/MISA324queZa1jWZLyziJPx
         DhV7NU+b2s7RDd8wq+9DHL0D5BLu2OoE51VygoK89cvIUrhp+HgSBO6+u1XiB7oWveTL
         qyf/J2WR8Xt6A5dOj9+D+u7t3H8hyAvDggRP95eovkkqXGFG8C9LFQNSybuimq7Po3jt
         YaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782347109; x=1782951909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XWGM/P1xdNUmP/2r/ojPGVaA8AsMQHAHTqUpXvu/HM=;
        b=YZYO7GQxZrEOm87WOA1DAUR3Q0pYnY4E/sqlUgMLsSARal5ugJYQWOVmcKUFUroOyC
         rDwFEv9Z73tfzuevSWXMl51Zr8qVFnW7kAiWeYqnjJoc+6Z3pMDS2GtJb5i4Q1p1fCIa
         rKitvuzZKj8gNtK3laXugnS22K5b3UxgcwvZMjSzDtDCTlxwtNuZwjZsGIS4QAdNE963
         UfUm4PwztXPd4MpuaLAzNXekK6ZP0BD3I+Z6OOoeapQHqpy6FC5aSi7r3POUqupbqDe7
         9rjRZla4kXmjNm6H0N+b0rpHAvLteKYvmlztek2c0RNMcFQnMPGMSdI6aWOm0Qt0tgRo
         KxWg==
X-Forwarded-Encrypted: i=1; AHgh+RooV2ylfORtFCEWZXukrxB8Bf1/lBeXbmJv8Auk4WALgk/autwTZZgVJRF3zgPw17fHuWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4Vlw8BXA9NXcb0gRfki/0+Pu2tB/85jq/5zm+VIxrQBmfvMa
	PbQhmudfdpbkDXGHwRWwHlYD5gfEIXlTofpksjAwhbIjMu18kriB8SyULgQ/uJejRWJbUpWTUfp
	3smemgg==
X-Received: from pgdr9.prod.google.com ([2002:a63:9b09:0:b0:c86:1628:53b3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5630:b0:37c:8628:f79e
 with SMTP id 98e67ed59e1d1-37dfa251589mr108649a91.16.1782347108547; Wed, 24
 Jun 2026 17:25:08 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:25:07 -0700
In-Reply-To: <45ixyum4upln4b2yvasovm2bmsfxyfezsi23vsr75r4fklelef@utxv4mymvfcd>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com> <20260501203537.2120074-3-seanjc@google.com>
 <ajNQ_Ix5e0p6FuFT@google.com> <tx3hcnrhfbcz2p7e7umc5o2zrw74pluzuzgtlqt4dz5cc5nhxx@6tzzorc25nqw>
 <s7jfbw3tnfgmp6blfqlfoi7yhq6f5n6xl62zzty5up45cqtsty@ljpjlvqw2gyy>
 <ajrkryMxHZtsMvga@google.com> <6xyh7xa53k2s7bytlkcys4pyq4756rwoly5q7swrifv3td6dey@3h5e2e67lkvj>
 <ajsjQtpZb-h2BdPh@google.com> <ajxLCMgLQe-JiRfq@google.com> <45ixyum4upln4b2yvasovm2bmsfxyfezsi23vsr75r4fklelef@utxv4mymvfcd>
Message-ID: <ajx1Y93iX2oV-DLa@google.com>
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV
 {en,de}crypt debug ioctls
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, Michael Roth wrote:
> On Wed, Jun 24, 2026 at 02:24:24PM -0700, Sean Christopherson wrote:
> > On Tue, Jun 23, 2026, Sean Christopherson wrote:
> > > On Tue, Jun 23, 2026, Michael Roth wrote:
> > > > On Tue, Jun 23, 2026 at 07:55:27PM +0000, Sean Christopherson wrote:
> > > > since your proposed fix seems nicer and more complete anyway.
> > > 
> > > It's missing a case though :-(
> > 
> > Ah, but so is the revert, and it's not a coincidence that the old code didn't
> > bounce buffer the destination for KVM_SEV_DBG_ENCRYPT.
> 
> Yah I was realizing this too :( Though I'm not sure why we set
> 'guest_owned' for DBG_DECRYPT... I'm not even sure it makes sense to
> write decrypted data into guest memory since it would only be usable
> if the range was decrypted to begin with... in most cases this likely
> wouldn't be guest memory.
> 
> So maybe the bounce buffer approach would work for DBG_DECRYPT at
> least,

Yeah, DECRYPT worked fine, it's all the others that break.

> > pread() doesn't work, because the source or destination needs to be a userspace
> > address, and so any RMP #PFs will get eaten.  But copy_file_range() makes the
> > world go kablooie.
> 
> I was hoping we could at least rely on kernel accesses going through GUP
> and maybe doing something like unmapping and freezing folio refcount
> to block concurrent access to the page, or read-only protections that
> would force the GUP to fail and just fail the concurrent userspace-requested
> operation...
> 
> copy_file_range() bypasses the GUP, but freezing the refcount or locking
> the folio would cause it to spin until the folio was released. So maybe
> that's an option?
> 
> This is similar to what's been proposed for gmem hugetlb support when
> splitting/rebuilding hugepages as part of the conversion path, where
> we need to guard against concurrent access by both kernel/userspace, so
> maybe it's not too hacky?

The big difference is that guest_memfd owns the folio.  For SEV/SEV-ES, KVM has
no clue what sits behind the destination of the ENCRYPT operation (or the other
guest_owned commands).  KVM knows it's a refcounted struct page due to pinning
the memory, but that's about it.  We'd basically have to audit every filesystem
to see if a "fix" would actually work.

And the risk isn't limited to copy_file_range(), that just happens to be the first
syscall I found that did what I want.  E.g. any memory that is kernel allocated
and mapped into userspace would be problematic, because that memory could be fed
back into KVM.  Ha!  Now that I think about it, I bet the pages mapped via
kvm_vcpu_fault() are problematic, because KVM owns the pages and will access them
at will.

So I don't think we can fix this by playing games in KVM.  Which is pretty much
why we ended up with guest_memfd: the only way to lock down memory to the point
where we're 100% certain it's safe to "poison" the pages is if KVM sequesters
them away in a dedicated file system.

> > I don't see a way to salvage SEV/SEV-ES on SNP systems, short of requiring
> > CAP_SYS_BOOT or some other elevated permission to do *anything*.  Or redo SEV/SEV-ES
> > support to require guest_memfd for operations that require putting pages into
> > Firmware state.
> 
> Yah, short of maybe the above approach, I don't see any way around it atm :(
> If you think it's worth pursuing though I can give that a shot on my
> end.

I say we wait for Paolo to get back from holiday (in a few weeks) before doing
anything drastic.  I'll send a patch to fix the existing selftest though, no
reason to leave that hole open.
