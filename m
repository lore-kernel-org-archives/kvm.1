Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204783914F8
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051206; cv=none; b=e2rSY7CmBvWfE7iFssQK8Y6gwsSJKbak/NF/ZHTB9z9RQEz5e6OTkWJj093HDz8hi7NrPvaNZZnAGeuVIlVEyn2/SR5KcK0PuVyL5I8+N8XDwAy/dyAhz5fRabYmM0J7K8AADsetdSLs+moj0fFQU3Td6izkFsmXMKcinihBsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051206; c=relaxed/simple;
	bh=rn3kkX0+FwUtuifs7gbsi+TSNbEY7/3xxhxV7wcRpt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MFO43Trz5Xm4XRp36+Jv++49ngwr/4THulpGQPI6vCqSnMGP5EwNa68v08zA27sGwlMSNHhl5Rj70KKDMFDr0DrM5aC5O5I88KvvStL4qvNZayEDlLNQWrHXwYol9B/qhZSQHwvGlfJJA+PNj7AjE/9cPYs3lDX4jeINMD/3hP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjMdtp7s; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjMdtp7s"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc489e7a701so5467492a12.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789051204; x=1789656004; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIBgJBhKU50pwCazOvi6fosiWFgkNV9R+TQpZ3/OTOk=;
        b=PjMdtp7s1LeHtLSNr6xtHYoIALOTsg3lTHB4jv8PXUBHoTILQKuk5/pEvLat000Rdt
         r+uAQKeHyADUtHmj+gRUu6J07CEgsnmjKFYLardOE7kQPTJLpwpp2GMR9BxZ/GxCrLq3
         76094sosjdle+xhFoUgLk5wiK2Kq6SqBDELl3yqVSq9x/IxvOAvxKTZC7laCR726W/Uw
         TOYwqMhqAlWFHKaLaBtp9TC4bk1Oj23aefjZN4tTpq30In7cOprbUj3zKzBQmrhGqK13
         ehR2hR9vJM8+/GsN63X6QHyW248BO1DCjMkjn0ezXQ2dB+eaGCNuj0DmbbU3xywyHdO6
         AQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051204; x=1789656004;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qIBgJBhKU50pwCazOvi6fosiWFgkNV9R+TQpZ3/OTOk=;
        b=obb4bZbjo8lH3dGgZBUvlKf4x0ANIGP4LB5c77KjfajyBL9MW8/n2oLCxjEF5Vg/UU
         GI3EtCyRiUa7lECIJaYx2494MTi7U7aRCNmj+s7Lm0b6uy+Ag0YAA5VRcwsMmfOpWhNX
         WYF57xuTrPB2FE79zjPOtfTYSwPpbyhuJijWY7d0sCx8jBwiBd17RypBgEntm9wqfCkt
         sQQdqTjqjAfkKvyL3g3q1sKDY2ALf4uNW8MoKF8gfIXcn0ZDIQp8nz7PtK1r0Sik4Qsd
         G9k9T75LmWXIV8S6Jp5QUrP4JkHS6jqB++kifaDHIkJQG8qadn9HA46p2Ff0d2KOVyRV
         NFWg==
X-Forwarded-Encrypted: i=1; AKwUvBz4eKMILKdanKuRI2Sip/QCRXborU96bQ/GkrL9GfIFK6gi0iL/vyezciYc40LhcbDgscU=@vger.kernel.org
X-Gm-Message-State: AFuF++ly2FV7Lf3FwOJyzEGZWRe6FkqTHM29mOF+Xx9W0IIn764en8D+
	WCCey3jcLo7BfpJd0Pv8d2YO0wuuqH2ABS6PsePkvU+O7VJgdPjt2POQ06B7KVFfgi+Hh+M0/Uh
	kILnkjQ==
X-Received: from pgbm25-n1.prod.google.com ([2002:a05:6a02:6199:10b0:c9a:ffcc:19c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2d09:b0:3c3:791e:5e18
 with SMTP id adf61e73a8af0-3dacbdb526bmr12238309637.7.1789051204137; Thu, 10
 Sep 2026 07:40:04 -0700 (PDT)
Date: Thu, 10 Sep 2026 07:40:03 -0700
In-Reply-To: <20260910112027.34581-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910112027.34581-1-flyingpeng@tencent.com>
Message-ID: <aqLBQ8AXe189POtS@google.com>
Subject: Re: [PATCH] KVM: Simplify backwards dirty ring batch check
From: Sean Christopherson <seanjc@google.com>
To: Peng Hao <flyingpenghao@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Peng Hao wrote:
> The backwards coalescing path shifts mask left and back right to check
> whether moving the batch base would discard set bits.  The shift fits if
> the distance is no greater than the number of leading zeroes in mask.
> 
> Use that directly.  Convert delta to u64 before negating it so that a
> positive delta, including one that wrapped to S64_MIN, is rejected by the
> unsigned comparison without invoking signed overflow.  Use __builtin_clzl()
> to match the unsigned long type of mask on both 32-bit and 64-bit builds.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

LOL, Paolo definitely has a different sense of "simple" when it comes to bitwise
math.

> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  virt/kvm/dirty_ring.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index 572b854edf74..8f39047ae7ab 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -170,9 +170,8 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring,
>  					continue;
>  				}
>  
> -				/* Backwards visit, careful about overflows! */
> -				if (delta > -BITS_PER_LONG && delta < 0 &&
> -				(mask << -delta >> -delta) == mask) {
> +				/* Backwards visit, but do not discard set bits. */

IMO, this really needs a more verbose comment.  

> +				if (-(u64)delta <= __builtin_clzl(mask)) {

Rather than the s64 => u64 => negated logic, which just makes my head hurt even
with the verbose changelog, what if we gate the entire outer if-statement on the
absolute delta, i.e. the shift, being within range?

And probably in a separate patch, but I think we should also replace BITS_PER_LONG
with BITS_PER_TYPE(mask) to communicate that the logic is all about not overflowing
"mask".  

>  					cur_offset = next_offset;
>  					mask = (mask << -delta) | 1;

Maybe also opportunistically use BIT_ULL() instead of open coding the bit shifts?
The literal '1' is especially annoying, as it unnecessarily obfuscates that the
code is setting bit 0, i.e. that '1' isn't some magic number.

Untested, but I think this would work?

			s64 delta = next_offset - cur_offset;

			/*
			 * While the size of each ring is fixed, it's possible
			 * for the ring to be constantly re-dirtied/harvested
			 * while the reset is in-progress (the hard limit exists
			 * only to guard against the count becoming negative).
			 */
			cond_resched();

			/*
			 * Try to coalesce the reset operations when the guest
			 * is scanning pages in the same slot.
			 */
			if (next_slot == cur_slot &&
			    abs(delta) < BITS_PER_TYPE(mask)) {
				if (delta >= 0) {
					mask |= BIT_ULL(delta);
					continue;
				}

				/*
				 * The next offset is backwards relative to the
				 * current base of the mask of bits.  Shift the
				 * mask "backwards" as well so that the next
				 * offset becomes bit 0, unless doing so would
				 * drop bits from the mask.  If the number of
				 * leading zeros is greater than or equal to
				 * the shift, then no set bits will be dropped.
				 */
				if (-delta <= __builtin_clzl(mask)) {
					cur_offset = next_offset;
					mask = (mask << -delta) | BIT_ULL(0);
					continue;
				}
			}

			/*
			 * Reset the slot for all the harvested entries that
			 * have been gathered, but not yet fully processed.
			 */
			kvm_reset_dirty_gfn(kvm, cur_slot, cur_offset, mask);

Or maybe capture the shift as a u64 early on?

			s64 delta = next_offset - cur_offset;
			u64 shift = abs(delta);

			/*
			 * While the size of each ring is fixed, it's possible
			 * for the ring to be constantly re-dirtied/harvested
			 * while the reset is in-progress (the hard limit exists
			 * only to guard against the count becoming negative).
			 */
			cond_resched();

			/*
			 * Try to coalesce the reset operations when the guest
			 * is scanning pages in the same slot.
			 */
			if (next_slot == cur_slot && shift < BITS_PER_TYPE(mask)) {
				if (delta >= 0) {
					mask |= BIT_ULL(shift);
					continue;
				}

				/*
				 * The next offset is backwards relative to the
				 * current base of the mask of bits.  Shift the
				 * mask "backwards" as well so that the next
				 * offset becomes bit 0, unless doing so would
				 * drop bits from the mask.  If the number of
				 * leading zeros is greater than or equal to
				 * the shift, then no set bits will be dropped.
				 */
				if (shift <= __builtin_clzl(mask)) {
					cur_offset = next_offset;
					mask = (mask << shift) | BIT_ULL(0);
					continue;
				}
			}

			/*
			 * Reset the slot for all the harvested entries that
			 * have been gathered, but not yet fully processed.
			 */
			kvm_reset_dirty_gfn(kvm, cur_slot, cur_offset, mask);

Actually, I think I like option 3 the most: capture only the unsigned shift, and
then explicitly check "next_offset >= cur_offset" instead of checking the delta?

			u64 shift = abs(next_offset - cur_offset);

			/*
			 * While the size of each ring is fixed, it's possible
			 * for the ring to be constantly re-dirtied/harvested
			 * while the reset is in-progress (the hard limit exists
			 * only to guard against the count becoming negative).
			 */
			cond_resched();

			/*
			 * Try to coalesce the reset operations when the guest
			 * is scanning pages in the same slot.
			 */
			if (next_slot == cur_slot && shift < BITS_PER_TYPE(mask)) {
				if (next_offset >= cur_offset) {
					mask |= BIT_ULL(shift);
					continue;
				}

				/*
				 * The next offset is backwards relative to the
				 * current base of the mask of bits.  Shift the
				 * mask "backwards" as well so that the next
				 * offset becomes bit 0, unless doing so would
				 * drop bits from the mask.  If the number of
				 * leading zeros is greater than or equal to
				 * the shift, then no set bits will be dropped.
				 */
				if (shift <= __builtin_clzl(mask)) {
					cur_offset = next_offset;
					mask = (mask << shift) | BIT_ULL(0);
					continue;
				}
			}

			/*
			 * Reset the slot for all the harvested entries that
			 * have been gathered, but not yet fully processed.
			 */
			kvm_reset_dirty_gfn(kvm, cur_slot, cur_offset, mask);

>  					continue;
> -- 
> 2.43.7
> 
