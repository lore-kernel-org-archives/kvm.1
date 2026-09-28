Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ABC4E66DA
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614335; cv=none; b=YnDCGxwACjRCpIW1m8KQS+m6lgT1WsMtvMzCMfguBlVPlXbiqgd8EQKYprtg2yrhZEMzFwqT1aWnUtDPbJDIOVonmAGegRGc44rddAPim23UDeosiuc/Eo/q8qTmZ/x4QF8ILgl/Ss/PODTjEY5CaGu8pZ4yAH2SeNqFBvjpF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614335; c=relaxed/simple;
	bh=p3n4Lkzrfyrz2xO6Xaw86FmCkOlUcXrVRaEq/yWAE14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tt79brP787QecKphTXjognEG4gHKU5+jqf8T7FXZ/tW8XPt4npxtJdOaC4g1hyCgF2cHk7uM9zfrzdHcx3qZxEirA7WwBDp6aEFDtuuJjRJW4kyMy4A6aKGRn9QI0BdIr+lKkoZmIFowtWhbcAlMMU6HPD1wLLHUVAkU7CGKGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK3w42ek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK3w42ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054851F000FF;
	Mon, 28 Sep 2026 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614333;
	bh=JnZEvJA5lnhZ9k59kw2JmVQdDyUlfRF3AVOXYz9fvL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kK3w42ekrrO2VLyQ+SUOAMbOYm6zZmHoH7TUU+sTIduKHz+jBtZg4XegoL2P/ylLk
	 JBkC5Hmmx318KLtr1RRn6hWsvSYGb7oQuOkgXMUudQ7dENfjFy8aCrfjEW/LIDQoBn
	 ai2QxoGP9Tk/oW3lmHumz4jdV9/q07T6W13+no09jaHr5S+Y7eCI07jfoy4QDJ7pNw
	 YdVjsLUaS9wRsJqByEwbUc3FZwwCgu3HWSuALg39DqnJt6FGdQ63ACrA3AJ0dg2e2i
	 RapRodYJskXkXL+NcjqJa3KltOhYnFkrcZy7N4PaKVB5oy2hTiKZiaK12Kwiyj7oaU
	 wq7YmkXBKHfHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y v4 03/11] KVM: MMU: update comment on the number
 of page role combinations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kenta Akagi" <k@mgml.me>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260928164427.4699-4-k@mgml.me>
References: <20260928164427.4699-1-k@mgml.me>
 <20260928164427.4699-4-k@mgml.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:52:12 +0000
Message-Id: <20260928165213.054851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: mmu: incorrect comment on page role bit count
--

commit e43e6a4b81c3f6c9da7c094b704c3a172f16148a
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: MMU: update comment on the number of page role combinations

This commit updates the comment explaining the kvm_mmu_page_role bitmask
to clarify why certain bit combinations are redundant.

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 710c9c87cdf2e..2c378064a1db9 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -292,19 +292,25 @@ struct kvm_kernel_irq_routing_entry;
>   * the number of unique SPs that can theoretically be created is 2^n, wh=
ere n
>   * is the number of bits that are used to compute the role.
>   *
> - * But, even though there are 18 bits in the mask below, not all combina=
tions
> - * of modes and flags are possible.  The maximum number of possible uppe=
r-level
> - * shadow pages for a single gfn is in the neighborhood of 2^13.
> + * But, even though there are 19 bits in the mask below, not all combina=
tions
> + * of modes and flags are possible:
>   *
> - *   - invalid shadow pages are not accounted.
> - *   - level is effectively limited to four combinations, not 16 as the =
number
> - *     bits would imply, as 4k SPs are not tracked (allowed to go unsync=
).
> - *   - level is effectively unused for non-PAE paging because there is e=
xactly
> - *     one upper level (see 4k SP exception above).
> - *   - quadrant is used only for non-PAE paging and is exclusive with
> - *     gpte_is_8_bytes.
> - *   - execonly and ad_disabled are used only for nested EPT, which make=
s it
> - *     exclusive with quadrant.
> + *   - invalid shadow pages are not accounted, so the bits are effective=
ly 18
> + *
> + *   - quadrant will only be used if gpte_is_8_bytes=3D0 (non-PAE paging=
);
> + *     execonly and ad_disabled are only used for nested EPT which has
> + *     gpte_is_8_bytes=3D1.  Therefore, 2 bits are always unused.

[Severity: Low]
Is this updated comment accurate for the current struct definition? The text
claims there are 19 bits in the mask and references an execonly bit.

However, looking at the union kvm_mmu_page_role definition immediately
following this comment:

union kvm_mmu_page_role {
	u32 word;
	struct {
		unsigned level:4;
		unsigned gpte_is_8_bytes:1;
		unsigned quadrant:2;
		unsigned direct:1;
		unsigned access:3;
		unsigned invalid:1;
		unsigned efer_nx:1;
		unsigned cr0_wp:1;
		unsigned smep_andnot_wp:1;
		unsigned smap_andnot_wp:1;
		unsigned ad_disabled:1;
		unsigned guest_mode:1;
        ...

Summing these bitfields yields exactly 18 bits, and the execonly bit appears
to be missing, having been moved to kvm_mmu_extended_role.

Could the mathematical breakdown in the comment be adjusted to reflect the
actual 18 bits present in the structure?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928164427.4699=
-1-k@mgml.me?part=3D3
