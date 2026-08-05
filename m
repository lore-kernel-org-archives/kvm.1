Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDA3DD537
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957247; cv=none; b=scaxCKab0gGk4qSb+sZheEMzNMekGba/A1fqlcCZ3DtUTIVGEbKU6A0R7mPpS6m2c0stEdTPkeDwanxz+1KZDI3yrXQ13fBSF9RR78qVaKYHOFhxFxn5z6/S8aFGMmA19k0i5XmQZBwAi7YnpLbHFVnPJdXg4h26KVGdjCifa+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957247; c=relaxed/simple;
	bh=2S6GP0bBdb1VzSR/nhiXfZceYSzLO1zycm5l8hXXlDI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OVq1n3uPp6cgxgaf95wn5vYGcOkEjnQ0dzpjBi2F400zYE1qg+r1sZOEnys7/uHkTJFBoUGyOPyVbZA9MhdNaUllhGgiNUQVChEFArz5DxY4ds79P05iYmYEB7rmuGxLdJYCGynPHUiwZCiT67Q+rd4Ic/6gWqFiIA1xHb1Cez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqSWOU9i; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqSWOU9i"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cccfa32670so18580925ad.2
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785957246; x=1786562046; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p4UHFDLmQWuRE5PrI1VsBpiXB9qx3KKZYbuNff/89QI=;
        b=JqSWOU9inYyyKfGk6g8YO4EjJUTo2SmIdnnKiZOW/fEywaNKGLMrv+dCjhMH/vKukU
         DtGDeWHhzJpZqKQD86Mw759rUisGt8GhG60fphYMVabqptXkJ0iyqrN9Xd5gzX6pQPAh
         eDeIUCIUZVDhJeInjE3CPYc9yo1lmX99Nsu5AHAXs6n+ysn7NcxaVwWuHYdkmlSEYNpy
         md3E55+OpSiQ0dZkAy+Ebgj8UDhRxV41j9PZj6mwyLghvTFR2goaEa6TKbX4NKh3TdrK
         NNR3rpyU7gV7Swo4mZF63a3lMgeduDHe+G85UUPn3GDqWCQgFZbIlXif+E6Et25HTPuU
         5Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957246; x=1786562046;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p4UHFDLmQWuRE5PrI1VsBpiXB9qx3KKZYbuNff/89QI=;
        b=LG+wPPTsGvmz1PBYyZX+s0PFCyPCw0wdBY23kVSI/9GSowxkySZad577LCSPreiXVV
         1Crd/rn6OTiFj3EWEHWeCBtjBQX8LXXiQBW6479CRsYrcqSrhznJq75KBPYFu2sAP1Om
         DVutAU6OhNAymiU48LI7UVr1o64VOIP0Zvdre41mA/hEBnVtWYasJbSip13TC0ldtE++
         e2p/ZMyTT4Q86GUmgzSuL0AGeQPZTZIQJyniHxiHLlq6Y0mn4ED4GcyT2kNHtwo5dTMo
         CJwrAeyfHyO6CMbWvrV9VC1q64H5PSEaDQtadw18Mw6AnI/e7WLiEHGPxWIVl4xgHT/V
         i/iA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2REpCEVQ6L6x0G91WozllrqVK1Da3UFpxlIX8DdNxT6sJPfoturZ8N0gCyusBoXFgHTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNi/5/n78GuiOmOAAYxX89JsN4FiPYiWL63zZxPWVHPgoTKzVs
	XJ2A63nDaRKn8bpcAhainyr6cZjFPxRLoKvFnUR36LM7y2v79scghbcp+cG21D/hEpaTm9btron
	82Po+ig==
X-Received: from plje15.prod.google.com ([2002:a17:902:ed8f:b0:2c9:a5a0:a677])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2447:b0:2c9:d539:61e7
 with SMTP id d9443c01a7336-2d0ca962f17mr94331945ad.19.1785957245262; Wed, 05
 Aug 2026 12:14:05 -0700 (PDT)
Date: Wed, 5 Aug 2026 12:14:04 -0700
In-Reply-To: <CAH+3ta4uD-QYju=6YRqHvd4Vwa-WAa9T9a65soCzdu49wNxV8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804105755.276646-1-kimjw04271234@gmail.com>
 <anHk2wTLHYxdB0jD@google.com> <CAH+3ta4uD-QYju=6YRqHvd4Vwa-WAa9T9a65soCzdu49wNxV8g@mail.gmail.com>
Message-ID: <anOLfLhAGbOXT30p@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Write-protect tracked GFNs in all
 address spaces
From: Sean Christopherson <seanjc@google.com>
To: Jinu Kim <kimjw04271234@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 05, 2026, Jinu Kim wrote:
> Thanks. After considering your comments, I think v2 is trying to solve a
> broader problem than the one reported, and that the resulting complexity
> is difficult to justify.
> 
> One thing I do not understand is the proposed revert of 0f38453cdb2e.
> The original pte_list_remove() panic was reproduced on then-current
> mainline with 0cb2af2ea66a, 81ccda30b4e8, and aad885e774966 already
> present.  The panic remained reachable there, and 0f38453cdb2e stopped
> it.  How would those three commits prevent the original upper-level
> shadow page from becoming unsync?

That's why I prefaced that with "Assuming the true badness referenced by commits";
it wasn't clear to me how marking an upper-level SP as unsync leads to a corrupted
rmap, and I hadn't thought too hard about it.

I assume it gets triggered by way of FNAME(sync_spte)() calling drop_spte(),
either directly or via FNAME(prefetch_invalid_gpte)().  Though it's somewhat of
a moot point because marking an upper-level SP unsync triggers a pile of WARNs
in so many other places.

Hmm, but *if* we decide to officially say cross-address-space gPTE writes are
unsupported, then I think I'd vote to revert (to make it abundantly clear that
the behavior is unsupported), and then suppress the issue by skipping like so:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c519e8e8d646..34d3949b6362 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2997,6 +2997,12 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
                if (prefetch)
                        return -EEXIST;
 
+               /* Comment here about abusing SMM. */
+               if (sp->role.level != PG_LEVEL_4K) {
+                       WARN_ON_ONCE(!!sp->role.smm == !!slot->as_id);
+                       continue;
+               }
+
                /*
                 * TDP MMU page faults require an additional spinlock as they
                 * run with mmu_lock held for read, not write, and the unsync
@@ -3020,7 +3026,6 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
                                continue;
                }
 
-               WARN_ON_ONCE(sp->role.level != PG_LEVEL_4K);
                kvm_unsync_page(kvm, sp);
        }
        if (locked)

Actually, irrespective of what we do with SMM, we should harden KVM to skip
marking upper-level SPs as unsync, because while corrupting guest memory is bad,
corrupting guest memory *and* crashing/compromising the host is worse.

So as an immediate defense-in-depth, I think this? (BUG the VM to reduce the
probability of the guest consuming corrupted data).

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c519e8e8d646..8d53d37750c5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2997,6 +2997,9 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
                if (prefetch)
                        return -EEXIST;
 
+               if (KVM_BUG_ON(sp->role.level != PG_LEVEL_4K, kvm))
+                       continue;
+
                /*
                 * TDP MMU page faults require an additional spinlock as they
                 * run with mmu_lock held for read, not write, and the unsync
@@ -3020,7 +3023,6 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
                                continue;
                }
 
-               WARN_ON_ONCE(sp->role.level != PG_LEVEL_4K);
                kvm_unsync_page(kvm, sp);
        }
        if (locked)


> Your comments also made me separate the general limitations of write
> tracking from a narrower issue in this case.  I understand that KVM
> cannot guarantee write tracking for every way guest page-table memory can
> be modified, and I have not established a current-mainline host-security
> consequence for the remaining cross-address-space revocation issue.
> 
> In that narrower framing, there may still be something worth fixing.  In
> the reported SMM configuration, KVM creates CPU SPTEs in both address
> spaces for the same GFN and backing page, accounts that GFN as backing an
> indirect shadow page, but can leave the peer SPTE MMU-writable.  KVM's
> shadow-page accounting state and the permissions installed by KVM are
> therefore inconsistent with each other.

I agree it's a bug, I just don't want to fix it. :-)

> Fixing that local mismatch would not imply support for DMA, host writes,
> arbitrary aliases, or a general guarantee that KVM observes all writes to
> guest page-table memory.  Those cases can remain unsupported and be
> documented as such.
> 
> If this narrower boundary makes sense to you, I will rework the patch
> around the existing shadow-page accounting and synchronization
> transitions.  A replacement would keep the normal mapping and memslot
> lifecycle paths unchanged and avoid introducing persistent
> cross-address-space state.

Honestly, I'd wrather support host userspace writes than cross-address-space
writes.  At least those could have a somewhat plausible use case, e.g. if userspace
were to implement its own emulator.

But I am also very biased against KVM's SMM emulation, which is why I want Paolo's
input.
