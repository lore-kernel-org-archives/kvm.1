Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BB35E1CE
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206658; cv=none; b=YM1lre5DzJvtWhAH/igBNf1v+gvCwfwM/nWovL4/foSy4y16+eSG998dSYjsD0PZlSQC+4+kg/0ZajlD/riZwuFVzndxMTsVz8qmGIR8Ruq3uI5TJANpjCxNB6Wk/2KL1i2PyFv6cn5CptoxSBMRC/3CG4Dn/33tK5bouO9yOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206658; c=relaxed/simple;
	bh=G/sS+eV/En7VfNNCxb94MAg33YSpnby1kQ+wnVsYp2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kHYNiW+FrCwNtq/C4B9al0KvhDePG0z+H+rCGpjA3zPzZnfPDUtzHjeE4Db/it9CtYuNuCC6Zee6IyOsh0qzjEy4XShg188vCi2UYiSg2guMH6rmwozCVUsAdMFjYe6/Ufac38QyBSZdAAuEqD4cq7PCNRPO+/54kEI/zew88N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7ysAWyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7ysAWyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5964D1F000E9;
	Tue, 23 Jun 2026 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206657;
	bh=uu1gE+w0IIygPtSqc3DOpPTSEN1y4A9sZQObYVtvI0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J7ysAWydymKcjf6Skd5/xkKIIEQ2M3RHxmxoHqRs9fWuNZ4aAwMHr8/KwMWbaXILz
	 zF4Ff25gsnknGSgGzJ0TOjd3NC6HE2T8JaDEj7R1v/C22/w/F8XuLU5x5oM0DPhBBP
	 o9Dw6086kKLzF6qAkeFM9JKAgyhgklxd1SLOvcpjiNH5MXP4J3vcCh/5uzUkGt71dk
	 ZGQzF8XVvcBhuSSGIGpDfa21nqqp6z22a2Wql70GAVbk79ycZYYeM+5JGRtiXyZo75
	 IuRDWM4NqS7F/1P/enlXu4fiOxAqb9sRMSLJcpq6gdvI0l/IYowlDbxX5WPG9kxSuR
	 Il/xlrThQvPhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] kvm: sev: Unmap pages in correct order in
 sev_gmem_post_populate()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260623091556.1500930-3-joro@8bytes.org>
References: <20260623091556.1500930-1-joro@8bytes.org>
 <20260623091556.1500930-3-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:24:16 +0000
Message-Id: <20260623092417.5964D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch corrects the `kunmap_local()` LIFO unmapping order in th=
e initial setup path but leaves an identical unmapping violation in the CPU=
ID firmware error-handling path of `sev_gmem_post_populate()`.
--

commit 6fe2af9a226230e3ae153d850afdecbdb7d9f3cc
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: sev: Unmap pages in correct order in sev_gmem_post_populate()

This commit corrects the unmapping order of kmap_local() pages in the
initial setup path of sev_gmem_post_populate(), ensuring strict LIFO
ordering.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 41dcba5180cad..f09d15f68964b 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2360,8 +2360,8 @@ static int sev_gmem_post_populate(struct kvm *kvm, =
gfn_t gfn, kvm_pfn_t pfn,
> =20
>  		memcpy(dst_vaddr, src_vaddr, PAGE_SIZE);
> =20
> -		kunmap_local(src_vaddr);
>  		kunmap_local(dst_vaddr);
> +		kunmap_local(src_vaddr);
>  	}
> =20
>  	ret =3D rmp_make_private(pfn, gfn << PAGE_SHIFT, PG_LEVEL_4K,

[Severity: High]
This is a pre-existing issue, but while this hunk fixes the unmapping order
in the initial setup path, does the identical LIFO unmapping violation still
exist further down in the CPUID firmware error-handling path of
sev_gmem_post_populate()?

If an untrusted userspace process supplies invalid CPUID data during
KVM_SEV_SNP_LAUNCH_UPDATE, the firmware returns SEV_RET_INVALID_PARAM.

This directly reaches the error path where src_vaddr and dst_vaddr are
mapped, but unmapped out of order:

arch/x86/kvm/svm/sev.c:sev_gmem_post_populate() {
    ...
	if (ret && !snp_page_reclaim(kvm, pfn) &&
	    sev_populate_args->type =3D=3D KVM_SEV_SNP_PAGE_TYPE_CPUID &&
	    sev_populate_args->fw_error =3D=3D SEV_RET_INVALID_PARAM) {
		void *src_vaddr =3D kmap_local_page(src_page);
		void *dst_vaddr =3D kmap_local_pfn(pfn);

		memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);

		kunmap_local(src_vaddr);
		kunmap_local(dst_vaddr);
	}
    ...
}

Should this second instance be updated to reverse the unmap order as well to
prevent kmap stack corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623091556.1500=
930-1-joro@8bytes.org?part=3D2
