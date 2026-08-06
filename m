Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91AB423E9B
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053254; cv=none; b=CNocm9XYmL9KpusnRzgZeP0hpCg6cT8NUWxaeJI2QKGW6T8usqs2MOkCKPbfxMZ0XPUfSH9+iKkX6rogTRL2oAa7ndZPE+VIbuAorIt7mpWdPP+4AHe3JrD3iycw3Ur9PR+HNU9fQuHz5RGA11l/f/eWLw4KJad563VlvlKUKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053254; c=relaxed/simple;
	bh=5ZPrV1g6KbPo59whUdxRwjI/Z4cxaNbLApuZK0NsPjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R0qzv74bUAOb1vabzxz1gFx4wJLP1TZ4Tq6YWF74KGZoAhLQOWEoax5w1URKzI60Vn0uUuQ/I/s6HpZfgqyUVoYq9Dy7FALGmn0+eT1NWjU4DpI35sGNXm/P22XxyzoaWdgr0pht9HZlNoZjqSDuj9UC3qOiYC0lLNmyKyebD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyw2YaFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyw2YaFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537841F000E9;
	Thu,  6 Aug 2026 21:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786053253;
	bh=cWpz8zH9M8mRk1C+RqXlg4uEFcvFuFTtN3U1HOC19j8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyw2YaFmjmv2GWUt5dQKOLH+T8er0jnzrAdXqo6kOTnlApwJqJCx4Tc45qD+PThvH
	 elIQt7wUmpm3KH/iKeESfEYg7KuWYfy4bwUq29lzubhY6qBqNEQZOx7PRT/frMu3GA
	 YCNo3sG9D+E/ZTkWFJ7sqQk+xJrkC910LZNwDR5GWHtuWQ9ZEeeapJay0P6bN2mGpG
	 nOQdgKLSjvzJJz0kCDpXy6XH2ct3WibKkz5I27OkcWBnegcg/yrQeKP3ui7YOX7QS2
	 uPgcYPZZOVXKZ6ihhuNRHPirCAUJDaH1RZLlHrZUQiZOCYwvHuk80gW1HfIfyrP3e+
	 dz4zITIsDUe1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] KVM: x86/mmu: Add sanity check to detect stale page
 faults in "map private PFN"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806214050.78058-5-seanjc@google.com>
References: <20260806214050.78058-1-seanjc@google.com>
 <20260806214050.78058-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 21:54:12 +0000
Message-Id: <20260806215413.537841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `continue` statement executed on a stale page fault inadverten=
tly terminates the retry loop, causing a fatal `-EIO` failure instead of re=
trying.
- [High] The KVM MMU invalidation retry protocol order is violated by captu=
ring the sequence after acquiring `mmu_lock` and after the PFN is resolved.
--

--- Patch [4]: [PATCH 4/4] KVM: x86/mmu: Add sanity check to detect stale p=
age faults in "map private PFN" ---
commit 8ecbe739b111e2504c32794278902d5137202a16
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Add sanity check to detect stale page faults in "map private =
PFN"
   =20
This commit hardens the "map private PFN" flow against stale page faults pr=
ior
to mapping the PFN into the guest. It adds a sanity check using a sequence
counter snapshot taken under the mmu_lock.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 379f570ef04f8..76e3cd717324b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5210,6 +5210,16 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *v=
cpu, gfn_t gfn, kvm_pfn_t pfn)
>  		 */
>  		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> =20
> +		/*
> +		 * Snapshot the invalidation sequence counter after acquiring
> +		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> +		 * i.e. any concurrent invalidations are guaranteed to be
> +		 * irrelevant.
> +		 */
> +		fault.mmu_seq =3D vcpu->kvm->mmu_invalidate_seq;

[Severity: High]
Does capturing the invalidation sequence after acquiring mmu_lock violate
the KVM MMU invalidation retry protocol order?

The sequence is explicitly captured inside the mmu_lock critical section
after the PFN has already been resolved by the caller. This bypasses the
mandatory generation safety sequence (capture sequence, resolve PFN, acquire
lock).

Additionally, could this still cause false positives since
mmu_invalidate_retry_gfn() checks mmu_invalidate_in_progress?

> +		if (is_page_fault_stale(vcpu, &fault))
> +			continue;

[Severity: High]
Does this continue statement inadvertently exit the loop without retrying?

In C, a continue statement within a do-while loop jumps to the while
condition evaluation, not the beginning of the loop block. If r is not
RET_PF_RETRY when this continue is hit, the condition r =3D=3D RET_PF_RETRY
will evaluate to false.

Will this cause the function to exit the loop prematurely and return -EIO?

>  		r =3D kvm_tdp_mmu_map(vcpu, &fault);
>  	} while (r =3D=3D RET_PF_RETRY);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806214050.7805=
8-1-seanjc@google.com?part=3D4
