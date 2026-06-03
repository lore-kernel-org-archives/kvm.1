Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3B3AA4F7
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501050; cv=pass; b=aLCUjwe42y+6OuDgCdTpE8qdVTjfVF6sRHmtzvcJkIKPBJ+rHwXHl5jpjrJgayp/Mye+A7XSCFArag1Vrf+h632qiIZTapwQCSVj/0omjsoAh1iT19jt/cwDOBlvuKOCsT+GGuoQt9cR836bcEtNkxsBQ7ZdeCUoWOxF64DLGMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501050; c=relaxed/simple;
	bh=iT16nj4vmbKjWbssqY5Onbed0A197duChiGcNAFwX1I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+Zu9xQLmduCyu0i7GMKhYJdY0BZkA9iRTjh+x1617r5ihiM7dooJw01sBhhj6+ZdZBb4iPFrYbD1keEnNMurlu6vg0TwRH1ocyPV5Ksw7ru1KwTddsnXv1ZO5dOeujqF0UTki79HlRVZlNTGwuCBP6fSIwzC5Bhuxo1BfNZfco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSiv1S8y; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSiv1S8y"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1370417c01cso12970230c88.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 08:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780501048; cv=none;
        d=google.com; s=arc-20240605;
        b=NASLzMKvNH/USycW7KVeaLCAiRB4u+PCX5KX4QpcU6uDk8HMYgJsvJt5AUu2lFyJzF
         BlFT+aK2ldCSojsIQ79WLLe2/ONBmiIr/6mJG/OgpmAI2vL0lGXH1rOzmeeP8Wr2dfXw
         Q9GTGyvR/7+ol33zvtxKqu9djA29ikY4DJW7TT+wvPeiBphxp20P/GeEaj8KrHrXA4U+
         QOcjowAktamfmLK2KrCq8GxcHKceyw1pDJ89c1HwPhz8pnXz0alYp/stpUhSIrLftZfo
         xNLq1YfIasDCvoPvo7hoG/nI+4PIsno+ssTsBljjnZCiTcC8jJcvjTSCJEoxv34Eq861
         qvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=zMzkr1hPlH6CXA1xWWogThW63vdd09MXrFoJqAto+7s=;
        fh=UW/Ms6Aw5ZIkS7OjL7znSAT6kovNPJcp+nToPmNiwJc=;
        b=OVj3Dqiq1ntiPNsEn81liyMMbe7njQkCyyTAIVDY542adTV1Y17iwbT6uGSgiBmbSn
         UbTWWsn/h4e0pYk1quwwpPX0ano7Gyyf+OgD8aX+BwE4B3J/ItGXtP6T/e5NZSugzJGU
         6Usdwr7RdYHpBw9l8F7ekpLI4aNiOYvG3MIZZSMhB9QyU/VRsgFDTT0vTJJyiYJxsQT5
         39tl5kqidQHxjxJcUXLHCzVJexy6my7zQHuKARmq0amYWvrdkgGGhbfKqQzQAPfSiMmo
         mwlEtLu+14hP28Z9ISWPqWZ67oI25Wg+4NFxnC960Kn3Beyf3eNE1D3H5YSu3BJbOQm/
         +ljQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780501048; x=1781105848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMzkr1hPlH6CXA1xWWogThW63vdd09MXrFoJqAto+7s=;
        b=lSiv1S8yAjJoJzYAWkSSd7bslsSBHcCz0yT/G04kFurojLFEIu1WCIM8HMGHF0/Zr1
         tzb9WPHK3HVKibCk4cehyrsE7m6DTGt4GLEmuBM07utB8cPvj8Ax/gMvDe3kgnJGW/pF
         blMVhffw8Do3vOE6lxtk/aYz/GCC264POw0Vpi2TjuUhSc1BSoIXUgFm1/jcmm6kh6Nl
         LF+AMc/BYLa1f/Ux0vXmY73IbX2IzEm4dny9KU7XThKdQK4d/0WOyMXevKvmQGIr43tZ
         Uo7xeg3BW33vWnRbK1CcAnCzA/D8uI1IcuvAVSsDKqznw/3QzNaAnvQ7dIffD4RPo9XU
         Kzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501048; x=1781105848;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMzkr1hPlH6CXA1xWWogThW63vdd09MXrFoJqAto+7s=;
        b=KRKVf7STh5QG051yWoeR3IpZSWsZo0Ei0lXNeguz4sKAB1X9Lz4HpXGtfnsN9cXDqn
         JsD9aPNMqKmi/hU9OvrBbIfcMNggWwadBGAWxgAjK7y4GEgUERSMhNs6GfZ+vfEXsztk
         UFvTC0tEENFolAK04Na2qRf8a9ysZMGumi447RasXy9/049O5WZ3K5bsFQsEZBp+/+nn
         NDstejH0olT++e2XFt0yTo7Ypd3+rZnQbsXM64A9FJ14IH/GCuFJhvnSml2Y4ciIehqc
         GiBBPHo4bGwnSVTMlx10C9t6Djea8i32zkU6yUH/WjqjJyqPGFWBUh3V375Senv+/rsN
         SJaA==
X-Gm-Message-State: AOJu0YzOqNolFy6q3QB3Dkul9ld5BFfXzw3PpgQjAbOugU9Jml/mdQa0
	LLfn2dui9s5u1jBhwnGAhImVndZVffCC4S23iahcd6zoDs4fYU7zjNgU/2onnOG1+sijDXeuK1o
	O8GC2lafJ6ik41bCcu1fn/+HlwLcDviasCULs9MWG
X-Gm-Gg: Acq92OFIjHu7G6nKB4Y6iGyLtfI2uPFgja0cUdyW42M04fQL83paiUA8az2jPdUNAw4
	5/HyOLB03G1z3yXLp9Qtq1exvfaotLn0iciHJ2+K2iNdi/9Epd3EmMEb/6LGHt0ejGhaJVI0He+
	pU9OM/vT2cs+Upp7qytLzw1M2T0pTqfwP/oJMj1ZZehVm9/I7saEdINZ8+7AiImBQHlY8x3VFnE
	HjEdWyuHrRp8HR7mbfcXLN9AWtp38xStbxXvVOq6Bvar4hrCkAsghNxome7PsFs86m2E2r9jRvw
	h9oYiVvIfHZh4Xj4CZoRnCN42+xHA2Au/pj87y5dsgimEYGiVOw0FJ7tZeb2
X-Received: by 2002:a05:7022:3d84:b0:137:fad9:3a30 with SMTP id
 a92af1059eb24-137fad93edemr810541c88.19.1780501047722; Wed, 03 Jun 2026
 08:37:27 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 08:37:26 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 08:37:26 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20251113232229.1698886-1-seanjc@google.com>
References: <20251113232229.1698886-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 08:37:26 -0700
X-Gm-Features: AVHnY4IMoCzdaYGxJ5Y5Fzuky2JYxRLjpc6pBCchbg4z9Vy3Ki1usEJzDDM2fMk
Message-ID: <CAEvNRgGmyd1yqQXsnz5hWRZpBZUs=piEWbEaqP9+cz9ZqEMQ6g@mail.gmail.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Add more context and information to the comment in kvm_gmem_release() that
> explains why there's no synchronization on RCU _or_ kvm->srcu.  Point (b)
> from commit 67b43038ce14 ("KVM: guest_memfd: Remove RCU-protected attribute
> from slot->gmem.file")
>
>       b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
>          occur after the memslot is no longer visible to kvm_gmem_get_pfn().
>
> is especially difficult to fully grok, particularly in light of commit
> ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when
> gmem is dying"), which addressed a race between unbind() and release().
>
> No functional change intended.
>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/guest_memfd.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index fdaea3422c30..2e09d7ec0cfc 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -338,17 +338,25 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  	 * dereferencing the slot for existing bindings needs to be protected
>  	 * against memslot updates, specifically so that unbind doesn't race
>  	 * and free the memslot (kvm_gmem_get_file() will return NULL).
> -	 *
> -	 * Since .release is called only when the reference count is zero,
> -	 * after which file_ref_get() and get_file_active() fail,
> -	 * kvm_gmem_get_pfn() cannot be using the file concurrently.
> -	 * file_ref_put() provides a full barrier, and get_file_active() the
> -	 * matching acquire barrier.
>  	 */
>  	mutex_lock(&kvm->slots_lock);
>
>  	filemap_invalidate_lock(inode->i_mapping);
>
> +	/*
> +	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
> +	 * bindings as slot->gmem.file cannot be set back to a non-null value
> +	 * without the memslot first being deleted.  I.e. this relies on the
> +	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() to ensure

Is this kvm_swap_active_memslots() referring not to swapping out of the
deleted memslot, but swapping in of a new memslot?

> +	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
> +	 * grab a reference to slot->gmem.file even if the struct file object
> +	 * is reallocated.
> +	 *

I think the part that's missing for me is: why is synchronize_srcu()
required after NULLifying memslot bindings? Normally, synchronize_srcu()
will be needed after memslot updates to make sure the next user of
kvm->srcu gets the new state of the memslots?

The "new state" here could be

1. slot->gmem.file == NULL
2. slot->gmem.file == some new file, set after the old memslot was
   replaced

> +	 * file_ref_put() provides a full barrier, and __get_file_rcu() the
> +	 * matching acquire barrier, to ensure that kvm_gmem_get_file() (via
> +	 * __get_file_rcu()) sees refcount==0 or fails the "file reloaded"
> +	 * check (file != NULL due to nullifying the file pointer here).

In this case, kvm_gmem_get_pfn() uses kvm_gmem_get_file(), and because
of the above, kvm_gmem_get_pfn() will not try to get a folio from a NULL
file (new state 1).

To handle new state 2, kvm_swap_active_memslots() to swap in a new
memslot must have called synchronize_srcu(), so synchronize_srcu() can
be skipped here.

> +	 */
>  	xa_for_each(&f->bindings, index, slot)
>  		WRITE_ONCE(slot->gmem.file, NULL);
>
>
> base-commit: 16ec4fb4ac95d878b879192d280db2baeec43272
> --
> 2.52.0.rc1.455.g30608eb744-goog
