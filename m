Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED663B0AE7
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961510; cv=none; b=ucDZW+OR9VlKhnnefBsKVKmFoNy9gV90MikQ4XDc1VnzeNK3ohwPaPkkoGUHSfxX77ur0p+lzXqa5PjpAcmxnGxBuZY1eUJlIGf2/xKcjeI/IYVEd0NNcMPjNS7vPa+dzDOgTRKl+NasSFEwhneCO5/EXeYiL3W9s5YrQ1zfPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961510; c=relaxed/simple;
	bh=qQ34hoxTfiDHz0fVKBjA80a667A+Td+I2M6HuwvaCmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tcGvcLf3Rhuu2d5v55E6aw2HZtcqswD9fWqSUk7ozFcptQsALonmRLnarQ6utdLrjCyGgfPzTEpEqUUpax3ADlRROMvJvjB+uhVnxUY4MDFqN6w1iQr+pX8bTW9f1ZEWGK3kFF9FZhR/JKveNCnpvB1YVd1PAX3jsR5QWjWq5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWhkHX9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWhkHX9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF631F000E9;
	Thu, 28 May 2026 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779961509;
	bh=+EWWTzcINrQvnUfYjA7PSfmmNlg1QQRGo/pHmu3Um7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CWhkHX9ENHV4plo+3t7OkYOShw3I3zmZbYG4P/jqBJJOUGTAbe4HD4/29QteuqzYK
	 Rvu129XJ73NqW0BOlBYGdt+pUWfhEgNCogQ+qYf6ouNBLO5veD4n5PvTHiOeX7m8ei
	 IUqlCcBy+G0a2WTFNrLcup2097HPmCrzMma5lpWn3WUfYmoDcmaDGft/+eSTnVJisn
	 N2c7LDpNL0NB64SCvpIvZwBk/dv3UMejbJbkIkP43yE3lmiODjMIe/SOY72seU3TJP
	 rtf4ZgBQWEvMxo0aFXP4WfmkXiHT7YLT+yMnURFmvhZPC+e0JYS9z5EXQC1NG2bu0b
	 GFT/mlKNdND3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/15] KVM: TDX: Move KVM_BUG_ON()s in
 __tdp_mmu_set_spte_atomic() to TDX code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yan Zhao" <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528081139.10284-1-yan.y.zhao@intel.com>
References: <20260528081139.10284-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 09:45:08 +0000
Message-Id: <20260528094509.3EF631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Returning a deterministic error (-EIO or -EBUSY) from mirror SPTE =
modification paths causes an unkillable in-kernel infinite loop in TDP MMU =
iterators, converting a VM-scoped bug into a host kernel hang.
--

commit e15424312043140d3e6eda83d94e044749575d32
Author: Rick Edgecombe <rick.p.edgecombe@intel.com>

KVM: TDX: Move KVM_BUG_ON()s in __tdp_mmu_set_spte_atomic() to TDX code

Drop some KVM_BUG_ON()s that are guarding against TDP MMU attempting to
propagate unsupported changes to the external page table through
__tdp_mmu_set_spte_atomic(). Have TDX code trigger them instead.

[ ... ]

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 6a48bbab5f141..8e97af221b40e 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1717,6 +1717,9 @@ static int tdx_sept_set_private_spte(struct kvm *kv=
m, gfn_t gfn, u64 old_spte,
>  				     u64 new_spte, enum pg_level level)
>  {
> +	if (KVM_BUG_ON(is_shadow_present_pte(old_spte), kvm))
> +		return -EIO;
> +

[Severity: High]
This is a pre-existing issue, but does returning a deterministic error
(-EIO) here cause an unkillable in-kernel infinite loop in the TDP MMU
iterators?

Looking at the TDP MMU iterators, they evaluate the return value of
tdp_mmu_set_spte_atomic() and execute goto retry on any non-zero value,
assuming a transient cmpxchg race.

If tdx_sept_set_private_spte() returns -EIO, this propagates back to
__tdp_mmu_set_spte_atomic(), which restores the unmodified iter->old_spte
and returns the error:

arch/x86/kvm/mmu/tdp_mmu.c:__tdp_mmu_set_spte_atomic() {
    ...
		ret =3D kvm_x86_call(set_external_spte)(kvm, iter->gfn, iter->old_spte,
						      new_spte, iter->level);

		if (ret)
			__kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte);
    ...
		return ret;
}

Because the memory is restored and try_cmpxchg64() isn't used to update
iter->old_spte on this failure path, the local iterator state remains
unchanged. The loop retries, evaluates the exact same conditions, hits
the KVM_BUG_ON() again, and fails endlessly.

Since tdp_mmu_iter_cond_resched() refuses to yield without forward progress,
can this tight loop hold the RCU read lock and burn 100% CPU, leading to an
RCU stall or soft lockup?

Prior to this patch, the same livelock occurred when
__tdp_mmu_set_spte_atomic() returned -EBUSY directly, or when
set_external_spte() returned -EIO due to hardware rejection.

>  	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
>  		return -EIO;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528080856.1014=
1-1-yan.y.zhao@intel.com?part=3D5
