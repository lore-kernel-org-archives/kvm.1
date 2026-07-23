Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C993B5F63
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842325; cv=none; b=XECSOf0kbga5vxD/0mux+LIIAnXiBdv7bR+jLkYqLdHOBng/3FBvyzjnW7exEbS5yQrto6JGxH75G/gd+fLHv69cC6xeScGj6N7SlL2QQv45YYhkH5+RAP1aJ26aPcRlnWEur+OApEBQupmO/1SM2U8rLeE5t0f+R1M1NnB4QMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842325; c=relaxed/simple;
	bh=rofmv7cAU6+7vA/UJ9DMRHgTby/bTIfqakM6Gb4VSN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bC3EBQrQ6v8s58VV0L+sT+UlTatFU49BGN9UNK41SChKyX83xcMl/6iLQ6gmiIzXViTaNiFx6gA6Dsz40JdL7GicWjpNpKp+c6FN9bTPOgaXR2NqfmomPI8/5kbZVTciIPgdRiqBsFNMAucpttu+E6lE8/Pr/F7dIM0dNXpnFw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwd82Fdh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwd82Fdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78A21F000E9;
	Thu, 23 Jul 2026 21:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784842324;
	bh=o4J/Yhaf7/R5Xw5xIper4CyRkLZMbtund6dAekpeBiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hwd82FdhQ+wzE3KeyHVTuKA/bE+leXqYFrZrnUqpSTXUbrWd7VXuoAUU1BQPURcDR
	 5jirDBNDN7oGJjxrQnP7EeaDX69JRX0CVydH5b4SGRBaEeGplRaAY+DqbuXMPSCdeZ
	 hGV4SJXSeglDs82tWkBXJBTSK7Enuv/Fxc063qMeItpEFpcNR3MJOABFhtFGaaLpk0
	 O1zmi9++MG/hvQrf8AiCNFNIMpOHf8pKW648XoWqKZikA4IFgVM13g8BR/BwLmYHJ1
	 mZMPtePxQlnCOKkFkzn7ptl9ocs3xVdxm2EOzUHq9smoUX+IqkT8NJ6ywB6HRfgBNR
	 Kr97VPTDAe3Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops
 on SNP-enabled hosts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260723211306.75397-1-seanjc@google.com>
References: <20260723211306.75397-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 21:32:03 +0000
Message-Id: <20260723213203.C78A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The fast path in `sev_dbg_crypt` directly passes a pinned user pag=
e to the PSP firmware without a bounce buffer, allowing an unprivileged use=
rspace process to trigger a host kernel panic via an RMP #PF.
--

--- Patch [1]: [PATCH v2] KVM: SEV: Allocate full pages for {DE,EN}CRYPT op=
s on SNP-enabled hosts ---
commit b2c2b9ead19801c1266e2d6c5a4d9c103c90e11c
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on SNP-enabled hosts

This commit updates SEV debug crypt operations on SNP-enabled hosts to use
full page allocations for temporary bounce buffers. This prevents RMP #PF
host panics caused by other kernel actors sharing and accessing the same
page while firmware temporarily owns it.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 74fb15551e83f..803bd39695fdd 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1280,9 +1280,28 @@ static void *sev_dbg_crypt_slow_alloc(struct page =
*page, unsigned long __va,

[ ... ]

> +	/*
> +	 * If SNP is enabled, i.e. the RMP is active, allocate a full page to
> +	 * prevent concurrent accesses to the page.  As required by firmware,
> +	 * the PSP driver updates the RMP to temporarily transfer ownership of
> +	 * the page to Firmware while the {DE,EN}CRYPT operation is in-progress,
> +	 * and so concurrent software accesses to the page will encounter
> +	 * seemingly spurious RMP #PF violations
> +	 */
> +	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +		return (void *)__get_free_page(GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does this full-page allocation fix in the
slow path still leave the fast path vulnerable?

Looking at sev_dbg_crypt(), if the addresses and length are 16-byte aligned,
the code bypasses the bounce buffer and directly passes pinned user pages to
the firmware:

arch/x86/kvm/svm/sev.c:sev_dbg_crypt() {
    ...
		src_p =3D sev_pin_page(kvm, src & PAGE_MASK, 0);
    ...
		dst_p =3D sev_pin_page(kvm, dst & PAGE_MASK, FOLL_WRITE);
    ...
		if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16))
			ret =3D sev_issue_dbg_cmd(kvm,
						__sme_page_pa(src_p) + s_off,
						__sme_page_pa(dst_p) + d_off,
						len, cmd, &argp->error);
    ...
}

Because these are user-controlled pages, couldn't an unprivileged userspace
process issue KVM_SEV_DBG_DECRYPT on aligned addresses, and concurrently
execute a normal syscall (like read() or getxattr()) on the same user page?

Since the firmware temporarily takes ownership of the page, wouldn't the
concurrent kernel access in supervisor mode still generate an RMP #PF and
panic the host, bypassing the protection added here for the slow path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723211306.7539=
7-1-seanjc@google.com?part=3D1
