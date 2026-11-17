Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794951440;
	b=vKnw4kj0fQE4gXdVWZaBEWlPDvyMFA9cuaUf0BloPJeInLCRKAa0fzhUBKQLHP8qLeDA
	 MFbqZ1QPgktPFJ/YlIwPPWpEyrnAigazVnCSNNurQ/K91+x0LEWbGHvK5y1sIUEqcUQB0
	 W9bx4A88eWKhirBCY5ErIkoEXdZScGT+XPyt2uyRisrNqrlAyoeqXv26o/+eTRCWzGmzx
	 Mv1mD+nNuO40zy+8Hq1XLx1vW8J1nE18zk6N5DV4EtQd8XkSsOAYFsp+s2k9tB0CO7vzk
	 ZCbYcm8U+Wc5Rj65W4B+yPfsIV1qo5kr1wgJfnQIyjCirR9eGiUXzjUqWwduAb8SxHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oTX5g5bi8XpZCZIxG5tdTi5bB4zpYM7go2OdkeozX7s=;
	b=UxkTCjrfC2w1ayl795wCTqJ/j75V1+z4bAgZsKtswquysDgfyWqZ7fOmyAl2HQH1AEUc
	 oudJeGQ0HVCipkKT//BVTD+93ST7qOUIFZGu8mAzHA+cuvBM6TVN9Emi0vbaMGjDUqjFB
	 ft5e9fja92BbPiRmC64DDNlY1jmeJ39Nd1bxUepoRkSeyDJ2xjUwNLUUG2lWJvsPDLHR/
	 N69tFoMu/jDZ3X01UiwVILvJe+fULReI/ozVgf3gc9/8nIz+H6u67RzgnoDufm41mglWR
	 fktcth9yXYwGWpfWladMo3jD8Po+6xjusoQ97b58Zg00psIi7+UO+cXits8HrPJ/6Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGQTAecA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B9606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGQTAecA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087E41F000C5;
	Tue, 17 Nov 2026 21:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794951440;
	bh=oTX5g5bi8XpZCZIxG5tdTi5bB4zpYM7go2OdkeozX7s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nGQTAecAKQeMWFsmNcL+IKWFU6sQTk9zYz7eEGcghV4e7wMCQyvP0ynvMsKQ1fsu+
	 fBUwPhSKp8xGmI+5JvrHlekyaR85oQhTeK5Kd8GKqug10qRKouALMoS9v4yOAMT709
	 qtHfqqqMhhYz+WTmiqRkQ6u02Q4HPJRTXShaSUjN382ToKDhsDfEMfP+zZgVUAn6+N
	 UOistHhLmQjuLtnXTIdqPa9DJH+OWgz9m1JUfnHC73bWxFdhinrVyFChBNYO2ZWVtD
	 O7OUGL5eZdiGvsvIWvzgDWNJp0321zt3spZQaKbPlLpPn9qC1q7e+z3eULj5NxUmit
	 qZLnOpKk3Zwkw==
Message-ID: <sashiko-outbox-219706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] KVM: selftests: Verify KVM doesn't reset unused
 dirty ring entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261117212913.3634487-5-jthoughton@google.com>
References: <20261117212913.3634487-1-jthoughton@google.com>
 <20261117212913.3634487-5-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 21:37:19 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] KVM: selftests: clear RESET flags in
  dirty_ring_reset_unused_entries()
--

commit 494a32b29217257f8a046ec9364c749fef56211c
Author: James Houghton <jthoughton@google.com>

KVM: selftests: Verify KVM doesn't reset unused dirty ring entries

This commit adds a helper to dirty_log_test that marks the first two unused
dirty ring entries as harvested before running the vCPU and asserts that
KVM_RESET_DIRTY_RINGS resets zero entries.

> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing=
/selftests/kvm/dirty_log_test.c
> index 8189eaac713cd..96a40488eccb0 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -375,6 +375,21 @@ static void dirty_ring_collect_dirty_pages(struct kv=
m_vcpu *vcpu, int slot,
>  		    "with collected (%u)", cleared, count);
>  }
> =20
> +static void dirty_ring_reset_unused_entries(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_dirty_gfn *dirty_gfns =3D vcpu_map_dirty_ring(vcpu);
> +
> +	/*
> +	 * Mark unused entries as harvested, and verify KVM doesn't reset any
> +	 * entries, as KVM hasn't pushed anything to the ring. KVM will
> +	 * overwrite the flags when it pushes to the entries.
> +	 */
> +	dirty_gfn_set_collected(&dirty_gfns[0]);
> +	dirty_gfn_set_collected(&dirty_gfns[1]);
> +
> +	TEST_ASSERT_EQ(kvm_vm_reset_dirty_ring(vcpu->vm), 0);
> +}

[Severity: Low]
Should dirty_ring_reset_unused_entries() clear flags back to 0 on
dirty_gfns[0] and dirty_gfns[1] after kvm_vm_reset_dirty_ring() returns?

When kvm_dirty_ring_used(ring) is 0, kvm_dirty_ring_reset() breaks out of
its loop before calling kvm_dirty_gfn_set_invalid(entry), leaving both
entries with KVM_DIRTY_GFN_F_RESET set when vcpu_worker starts.  In
kvm_dirty_ring_push(), KVM increments ring->dirty_index before overwriting
entry->flags with KVM_DIRTY_GFN_F_DIRTY:

virt/kvm/dirty_ring.c:kvm_dirty_ring_push() {
	...
	WRITE_ONCE(ring->dirty_index, ring->dirty_index + 1);
	kvm_dirty_gfn_set_dirtied(entry);
	...
}

If the host reaping loop runs while the vCPU is pushing its first two dirty
ring entries (for example when reap_i is 0), kvm_dirty_ring_reset() can
observe the stale KVM_DIRTY_GFN_F_RESET flag together with the incremented
ring->dirty_index and reset an entry that userspace never collected:

host                                   vcpu_worker
----                                   -----------
dirty_ring_collect_dirty_pages()
  dirty_ring_collect_one()
    /* flags =3D=3D KVM_DIRTY_GFN_F_RESET,
       stops with count =3D=3D 0 */
                                       kvm_dirty_ring_push()
                                         ring->dirty_index++
  kvm_vm_reset_dirty_ring()
    kvm_dirty_ring_reset()
      kvm_dirty_gfn_harvested(entry)
      kvm_dirty_ring_used(ring) > 0
      ring->reset_index++
      cleared++
                                         kvm_dirty_gfn_set_dirtied(entry)
  TEST_ASSERT(cleared =3D=3D count)  <-- fails (1 !=3D 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117212913.3634=
487-1-jthoughton@google.com?part=3D4
