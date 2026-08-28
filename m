Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230DF39C631
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937311; cv=none; b=DeysBPKUovALb9puwGu14YQqAmoNrK/Q9dvlMis5mzfG8nWGClxTVwjyVrzW1+zzPcEWDk3GvKhsDUgGSRhK4xkK6nuvhrq/OUpZEtqBt+65f3ZgixXaa8Qd07jaN0SAmiLvGsWZk4G0Czmy1uWLHr4+bn4kMedWj48/IXgbLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937311; c=relaxed/simple;
	bh=A+XwQ7hx7c/PpoK2zYD8Ti9Cfmu9dIdyNosReE7Z13A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jn/724MczI1SpG4Heycd0hFMIKzs311nOjCzEU+4PxSV0y41gf4t54y9N4lyZpeaL3vJ7BfNKQIRjlj9LqOCjA2Bm4QFET6ZbiGALdCGObF+2xuw+AelaLdLD6UcPNPG7Vf4TlQDgzy5CyNVgliWcz0RYm8rGaTZyG7jFw/mQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HaPS5SSb; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HaPS5SSb"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a67b16217so1802899b3a.3
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787937308; x=1788542108; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oz0Aruxc0OsgSYrqyxjcA7Qxw4lkCYaQy9l/Ml6P7S0=;
        b=HaPS5SSbVhOC2R8m6r91iePwZsMR8G/zsOI1fM+tzH6dG7iEX2eHWx9yQ4dItOMa4D
         wqbEni/VlTzwG3YAomWS6L4T6lBNwP25PsUPWeQQPw7+hv79OtIgWgIEaqtghRBD+xm7
         PVSVT/viVMuJX7hKHTvbPKeHO5vfeMcL2+J07EnDLCfGlFxlc9aVyUXZb5QtYwaU26+c
         KknNfw50ckiQ27Cd9+0Kck1ygFtu7YWUYnuLUpVKCbkZ6ZoODPYyX/jFfGUJ2a14QLDK
         LzcF/ZKFR17StUQLsElE8afspPU5Ul5cgVmzLSpGtnrVYhLZYCSPK9LazEmYgX4Rp+gh
         XGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787937308; x=1788542108;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oz0Aruxc0OsgSYrqyxjcA7Qxw4lkCYaQy9l/Ml6P7S0=;
        b=K420nCAv9ezTvanWOvyRmaNNPD3P70oFVE4KqW/qlSzCN5Kbm2Bk8FZbvPNJ6duFJa
         HwQ5ays2jwUGH6zvtNmCAtzoj5e4YxwDQojZb04pDzPn4IJMRcHGvEG1nlQ8SCwGfpwG
         wRswg5cZMsO/XDvQp/85GRm0R1cjgj6tjjM/ht+xBYHyh3oDsnfP+DG7ZLYuzOcScAgJ
         ANxLbysBO2Ah8fQ+KHrnsxCdutT86n79ajdW8g6mzv+K98/7YckYKLMrL41nwK7jWS+Q
         3ECaNAbLcRmJDHl5JEhG/14byw+nIy33geFV8/Y9v0CG3iZ7sXOuxUxPtrhAsG/s0moB
         icNw==
X-Forwarded-Encrypted: i=1; AHgh+RpOwBlI/9kAmtJ6TsIKaq5cXMN48VwVLXZm4RtXG4xFBqTzxM8srEueAJZXSTg4Cut6q8o=@vger.kernel.org
X-Gm-Message-State: AFuF++mdoCSji3RNtm9lJFYGPli6dwCqoxeAuikgW8+aBZUUV1c5iY4W
	R75iT+/aqWN1udKopiWfyA4ZtLpqCXYxDrb+QyQFAs4Qsj2Qd83fs9GeJq8Tz3KolrJZFx/9ALP
	7bI6bqA==
X-Received: from pfbem11.prod.google.com ([2002:a05:6a00:374b:b0:848:4690:d658])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2991:b0:851:92fe:504b
 with SMTP id d2e1a72fcca58-856274efd7bmr20706200b3a.7.1787937307954; Fri, 28
 Aug 2026 10:15:07 -0700 (PDT)
Date: Fri, 28 Aug 2026 10:15:07 -0700
In-Reply-To: <20260828102728.1308266-1-zeng_chi911@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <apCD3F3oOyC6E5oN@google.com> <20260828102728.1308266-1-zeng_chi911@163.com>
Message-ID: <apHCG78KyLuzPrNa@google.com>
Subject: Re: [PATCH v2] KVM: Don't treat reserved xarray entries as having
 memory attributes
From: Sean Christopherson <seanjc@google.com>
To: Zeng Chi <zeng_chi911@163.com>
Cc: chao.p.peng@linux.intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, zengchi@kylinos.cn
Content-Type: text/plain; charset="us-ascii"

Please don't send a new version of a patch/series while there is active discussion
on the previous version.  As is the case here, there's often not enough context
in the new, standalone patch to carry on the discussion.  And even when there is
enough context, it's annoying to have to read one thread, and then skip over to
a different thread to respond.

On Fri, Aug 28, 2026, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 
> kvm_vm_set_mem_attributes() reserves an xarray entry for every gfn in
> the range before storing the new attributes, so that the store loop
> can't fail partway through.  If one of the reservations fails, e.g. with
> -ENOMEM, the entries that were already reserved are left in the array.
> That is harmless as far as xa_reserve() is concerned, as the reserved
> entries read back as NULL via xa_load(), but it confuses the "does this
> range have no attributes at all" check:
> 
> 	if (!attrs)
> 		return !xas_find(&xas, end - 1);
> 
> A reserved entry is XA_ZERO_ENTRY, not NULL, and xas_find() returns it
> as present.  So a leftover reservation makes KVM report that a fully
> shared range has attributes even though kvm_get_memory_attributes()
> returns none for every gfn in the range.  On x86, the next time
> mixed-attribute tracking is recomputed for the range (memslot creation,
> or a later attribute change that straddles the 2MiB page),
> hugepage_has_attrs() treats a fully shared 2MiB range as mixed and
> refuses to map it with a hugepage, until userspace happens to set
> attributes on the range again.
> 
> Walk the range and ignore reserved-but-unset entries when checking for
> the absence of attributes, so a leftover reservation is treated the same
> as an empty slot.  Note, the generic loop for the attrs != 0 case
> already skips zero entries via xas_retry(), i.e. only the !attrs shortcut
> was affected.
> 
> While at it, skip the reservation loop entirely when clearing attributes,
> as storing NULL only erases the entry and never needs to allocate, so no
> reservation (and no cleanup of a failed one) is required in that case.
> 
> Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>  virt/kvm/kvm_main.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 65eb26a0520d..29534bcc7f02 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2447,8 +2447,19 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>  		return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
>  
>  	guard(rcu)();
> -	if (!attrs)
> -		return !xas_find(&xas, end - 1);
> +	if (!attrs) {
> +		/*
> +		 * Reserved but unset entries (XA_ZERO_ENTRY, e.g. left behind by
> +		 * a failed reservation in kvm_vm_set_mem_attributes()) are
> +		 * returned as present by xas_find(), but hold no attributes.
> +		 * Skip them so that the range is correctly reported as having no
> +		 * attributes.
> +		 */
> +		xas_for_each(&xas, entry, end - 1)

Curly braces needed for the outer loop.  And +1 to Sashiko's feedback, both from
a correctness perspective and from a "make boths paths look similar" perspective.

Though even better, we can use the same core logic.  Pulling in your response from
v1:

 : > I think it would be this?
 : >
 : > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
 : > index 65eb26a0520d..a01b2af1cb17 100644
 : > --- a/virt/kvm/kvm_main.c
 : > +++ b/virt/kvm/kvm_main.c
 : > @@ -2447,8 +2447,9 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 : >               return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
 : > 
 : >       guard(rcu)();
 : > -     if (!attrs)
 : > -             return !xas_find(&xas, end - 1);
 : > +
 : > +     if (!attrs && !xas_find(&xas, end - 1))
 : > +             return true;
 : > 
 : >       for (index = start; index < end; index++) {
 : >               do {
 : >
 : I tried that first, but it doesn't fix the false positive.  Falling through to
 : the generic loop for the !attrs case still returns false for a range that only
 : contains reserved (zero) entries: the loop does
 : 
 :         do {
 :                 entry = xas_next(&xas);
 :         } while (xas_retry(&xas, entry));

The other subtle wrinkle is that the xarray APIs reset the index when no entry is
found (this wasted a good 30 minutes of my time, argh).  I.e. when on entry is
found, then KVM *must not* check the index, because it is effectively invalid.
E.g. I initially wanted to check for xas.xa_index >= end, but that doesn't work.

This code also needs comments, because the xarray APIs have all kinds of sharp
edges (or maybe a better way of looking at things, xarray isn't a great fit for
what KVM is doing here).

Yeesh, speaking of which, simply using xas_next_entry(), as I want to do, would
be slightly suboptimal for non-zero attributes, because xas_next() (confusingly,
IMO) doesn't return the next non-NULL entry, it returns literally the next entry,
whereas xas_next_entry() returns the next non-NULL entry, bounded by the max. I
don't actually care about the performance impact, but I want to document the
behavior, at which point it's just as easy to use next() vs. next_entry().

So after way, waaay too much fiddling, this?  As a bonus, the changelog can call
out that xas_next_entry() is essentially an optimized version of xas_find(),
e.g. to communicate that the effective diff is actually just adding xas_retry().

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..cc94d9881582 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2447,14 +2447,39 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
 
 	guard(rcu)();
-	if (!attrs)
-		return !xas_find(&xas, end - 1);
 
+	/*
+	 * Lookup the entry for each index instead of iterating over the xarray
+	 * as KVM deletes/nullifies entries to represent "no attributes", and
+	 * the xas index is effectively invalid when no entry is found.  I.e.
+	 * matching non-zero attributes for *every* entry effectively requires
+	 * a manually lookup for each index.
+	 *
+	 * Skip pre-allocated, reserved entries, or restart the lookup if the
+	 * xarray was concurrently modified, via xas_retry() ("retry" means the
+	 * entry holds an internal xarray value, i.e. is either invalid or NULL
+	 * from the caller's perspective.
+	 *
+	 * Use xas_next() when looking for non-zero attributes to optimize for
+	 * the case where the start of the range (or the entire range) doesn't
+	 * have any attributes, as xas_next() returns literally the next entry,
+	 * whereas xas_next_entry() returns the next non-NULL entry (bounded by
+	 * a maximum index).
+	 */
 	for (index = start; index < end; index++) {
 		do {
-			entry = xas_next(&xas);
+			entry = attrs ? xas_next(&xas) :
+					xas_next_entry(&xas, end - 1);
 		} while (xas_retry(&xas, entry));
 
+		/*
+		 * Don't check the index if there's no entry; as above, the xas
+		 * index is invalid (and if no entry was found, then the entire
+		 * range has no attributes).
+		 */
+		if (!entry)
+			return !attrs;
+
 		if (xas.xa_index != index ||
 		    (xa_to_value(entry) & mask) != attrs)
 			return false;

