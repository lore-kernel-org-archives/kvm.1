Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20CD2C187
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615055; cv=none; b=JBNt18V4h2T6HE3TJjZERhmUh0Aac6FdcKIdMJMMPURD/B+yVXRJwWVWyYVSVn4fQKzLnKe24sKkWFWqD4HdkbWNtidq+Dc+w8UaAtPoGCgbCuInKYNOrepjmchO0clJR9VCoj4rGB92QduVQ6tRMD8K6jZ3I1XFkVwBesQ1Z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615055; c=relaxed/simple;
	bh=h5HZwXfdM1n1zaFuwds3o5gxLDXfbGzfqRYvPorn+jE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J3YEWrwbvqL1anOAlJuRaTStn3hjuQSL1z5tfPlOKdu3A/gDZ6p858HsCu/uyZ/4ygZzTqV05Hrs0yAchLcnvAPd5/GpTtmtnO9HjS6Hukp9yIPB5gPE0Qz0DAHyiOGMK6M8Cc2kx4et/20CgMc00K5MCSaPzfZB+N6Rb3RuY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqYhngwI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqYhngwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0F61F00893;
	Thu,  4 Jun 2026 23:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780615054;
	bh=EO24sUx6N07N6hXorRwTHLOY4CCAj937CSTmg0lu3GA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqYhngwIYKE5ytfsEVtUO44HXu+d4QGLNdDB0DD+JCXZt8KYcP6EHmngXy+wHMhca
	 7GPAD4mNMHyFGmcgUOV8iYvkA7VGncEkBcGUSkx2kQawPBQHWeJniDyzYC+ot+PKYT
	 UcDS9d/8tGb0W64k2mVbWPqFhnzcnAdFkBvQPtXZ8HdRyPvg+7rZHVnz12c97efoWx
	 hapsa07WVZPtPWpbS+3f9nW+2sys7ov0GOl02F5CNK8iS6/KPks3N84fYcmekQF7dq
	 C7V+EfsD+dczlRCqQP0KTog83nntMoVE8dfnc2ZfyLX57xwlFzn41flZNyWCuVzGpu
	 W51C1aW5gSTxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] RISC-V: KVM: Fix skip of valid pages in
 kvm_riscv_gstage_wp_range
Reply-To: sashiko-reviews@lists.linux.dev
To: atwufei@163.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604230317.30501-2-atwufei@163.com>
References: <20260604230317.30501-2-atwufei@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 23:17:33 +0000
Message-Id: <20260604231734.5D0F61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unmapped huge pages left stale in guest page tables, leading t=
o Critical Use-After-Free / VM Escape, and unaligned address advancement sk=
ipping subsequent huge pages.
--

commit c66a8f8b8062b26c9c1ff1c7378d57e05da217e0
Author: Wu Fei <wu.fei9@sanechips.com.cn>

RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_wp_range

The current gstage range walker unconditionally advances by 'page_size'
when a leaf PTE is not found, e.g. when the range to wp is
[0xfffff01fc000, 0xfffff023c000) and page_size is 2MB, if found_leaf of
0xfffff01fc000 returns false, it skip the whole range, but it's possible
to have valid entries in [0xfffff0200000, 0xfffff023c000).

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index d9fe8be2a1516..2b141a78ecac7 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -429,14 +429,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *g=
stage, gpa_t start, gpa_t end
>  		if (ret)
>  			break;
> =20
> -		if (!found_leaf)
> -			goto next;
> -
> -		addr =3D ALIGN_DOWN(addr, page_size);
> -		kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> -					ptep_level, GSTAGE_OP_WP);
> -next:
> -		addr +=3D page_size;
> +		if (!found_leaf) {
> +			addr =3D ALIGN(addr + 1, page_size);
> +		} else {
> +			addr =3D ALIGN_DOWN(addr, page_size);
> +			kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> +						ptep_level, GSTAGE_OP_WP);
> +			addr +=3D page_size;
> +		}
>  	}
>  }

[Severity: Critical]
This is a pre-existing issue, but I see a similar pattern in
kvm_riscv_gstage_unmap_range() that leads to a Use-After-Free / VM escape.

In kvm_riscv_gstage_unmap_range(), if the walker encounters a huge page leaf
but the requested unmap range is unaligned or smaller than the huge page si=
ze
(e.g., when the host MMU notifier unmaps a 4K sub-page of a THP), it skips
clearing the PTE.

Checking the final state of the series reveals that the subsequent patch
"RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_unmap_range"
fixes the !found_leaf case but only adds a WARN_ONCE to the found_leaf
branch:

		} else {
			if (!(addr & (page_size - 1)) && ((end - addr) >=3D page_size))
				kvm_riscv_gstage_op_pte(gstage, addr, ptep,
							ptep_level, GSTAGE_OP_CLEAR);
			else {
				WARN_ONCE(1, "Skip unmap range addr: %#llx, end: %#llx, page_size: %#lx=
\n",
						addr, end, page_size);
			}

			addr +=3D page_size;
		}

Does skipping the unmap here leave a stale, guest-accessible huge page
mapping to physical memory that the host has reclaimed and potentially
reallocated?

Also, because addr was unaligned and is not aligned down to the huge page
boundary, doesn't addr +=3D page_size preserve the unaligned offset? Would
this misalign addr for all subsequent iterations, causing the walker to
skip unmapping every subsequent huge page in the requested range?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604230317.3050=
1-1-atwufei@163.com?part=3D1
