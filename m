Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFB331EC7
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276494; cv=none; b=rqmxkB/mWpampKcmFvI86Th/3D2Nmf7Sx+MFZIfPzo99xhGFT3Xe8LFJOy8DMYXe/h0t26cXnE74zUlUClyHvlSbrs8KDRPlnHwcP9HxQMcVbr+pqC4A89OV1urlj34K8Md/qQ3YlBKG3HPVVgTm4gOq7hnQuO9uVQ0uu7o5Lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276494; c=relaxed/simple;
	bh=K0xINq0v582qiuK+DVFKdvsAHhBz7kVbWYB9kvfCf4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DYQD5eidptj51r7jwgoLGWTX6nZ4AfsfApgpU61e5yEIRUjORB9zgEuK/DlRwxqbLjotN8DKd3fonJC2o0fzwcZUbhY7ej9RS1i1AShDiSEwwX62aLYctj6Kdl0U1+waqI6lnaL5URtPDRXQLM4n61triHE5KpjF7HSkcNopApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1TKjolX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1TKjolX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150891F000E9;
	Fri, 17 Jul 2026 08:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784276492;
	bh=SgqyM6UbuVjJRDqZePKqAfVSQKsEIUKeMu+zpSsvAjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W1TKjolXM4dz3n/sk4Hn47W3+moOa5lUWLKwTwUfHQcpDInEpH2pfymXCJ/Du+CeJ
	 dUTC2BaDEcGLcdKTaftXbrSe62GKTG5NPKnvWuYYpApWwZa1kDnFwJ3dPyFTU5x5oM
	 S8Ff5VDgwvMK3ujO2N5A8qy3XErP8XbuSMG1MI2U3ILbR+tihi403rQnHSYtcDmDNZ
	 WWwsZhrDNF5U+VzdkEv6ceAy/TwTjbidbmMPTJvgbvVr+QKqm0NN2TLFJrh9pxjEdd
	 ey702HDGgZ55LYbiVoPgt6jP3swmq+kQP7dGuVjV5gH1/e9wRKyyQua97ovksidUjN
	 NSunnojvkvWcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Improve dirty log clearing by skipping
 zero bits in mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260717080654.877151-1-wang.yechao255@zte.com.cn>
References: <20260717080654.877151-1-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 08:21:31 +0000
Message-Id: <20260717082132.150891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the non-atom=
ic read-modify-write in `kvm_riscv_gstage_op_pte()` for `GSTAGE_OP_WP` over=
writes and loses concurrent hardware A/D (Accessed/Dirty) bit updates. When=
 write-protecting a page, it reads the PTE, clears `_PAGE_WRITE`, and write=
s it back using `set_pte()`. If the hardware page-table walker concurrently=
 sets the Dirty or Accessed bit during this window, the update is lost. Ato=
mic single-instruction operations (e.g., atomic AND or `cmpxchg`) must be u=
sed for updating hardware-shared PTEs.
--

--- Patch [1]: [PATCH] RISC-V: KVM: Improve dirty log clearing by skipping =
zero bits in mask ---
commit 69dff78a641691bca22a783a5f60188157d6a975
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Improve dirty log clearing by skipping zero bits in mask

This commit optimizes the KVM dirty log clearing process on RISC-V by
iterating only over the set bits in the dirty mask instead of scanning
the entire range. It uses a new function to process leaf PTEs and entire
huge pages, reducing unnecessary page table walks for sparse masks.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index c4c3b79567f10..9af86b1c5e3c3 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c

[ ... ]

> @@ -472,6 +472,65 @@ bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gs=
tage, gpa_t start, gpa_t end

[ ... ]

> +bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t base=
_gfn,
> +				   unsigned long mask)
> +{

[ ... ]

> +		if (found_leaf) {
> +			if (ptep_level) {
> +				addr =3D ALIGN_DOWN(addr, page_size);
> +				clear_huge_mask(&mask, page_size, base_gfn, addr);
> +			}
> +
> +			flush |=3D kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> +							 ptep_level, GSTAGE_OP_WP);

[Severity: Critical]
This is a pre-existing issue, but does the invocation of
kvm_riscv_gstage_op_pte() with GSTAGE_OP_WP race with hardware A/D bit
updates?

Looking at kvm_riscv_gstage_op_pte():

	else if (op =3D=3D GSTAGE_OP_WP)
		set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_PAGE_WRITE));

This performs a non-atomic read-modify-write on the PTE. If the hardware
page-table walker concurrently sets the Dirty or Accessed bit during this
window, would the update be overwritten and lost?

When write-protecting a page for dirty log clearing, losing the
hardware-updated dirty bit could cause KVM to believe a dirtied page is
clean. During VM live migration, could this lead to the page not being
re-transferred, resulting in data corruption in the migrated VM?

Should hardware-shared SPTE updates use atomic single-instruction
operations (like atomic AND or cmpxchg) instead to preserve concurrent
hardware writes?

> +
> +			if (ptep_level)
> +				continue;
> +		}
> +
> +		/* clear the first set bit*/
> +		mask &=3D mask - 1;
> +	}
> +
> +	return flush;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717080654.8771=
51-1-wang.yechao255@zte.com.cn?part=3D1
