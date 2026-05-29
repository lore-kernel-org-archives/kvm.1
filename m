Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5F3AFB13
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093703; cv=none; b=jINR5gToqTUuI5TTuvldD1XP5PTiZH1vI9F53mdhqssXDR71S9LPOo13JHH2u7vsOV0r+CMgWU4jQIoOfJnAeeuZQuH26jCdJ+jyuvUP7CHWDd7iu2w1J8PJHRGKq4wy0KThO6M+257mwZ2g9KAnaX5m3SX1/Oa3MPq68ZxRNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093703; c=relaxed/simple;
	bh=nqcdS+sXtnc/gz7uqezCzT0YUAluusHFQVx7txiLCQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A6vTXDyu/QAx9G67HFL93kr2aw1VQFvw5U7zdlmZrGDbszN0kKyuCGgPIJL2tkduc5hy7YZCteqB6S1GLTr0fIomEpAaWRGV/93PBOMxadUEMEZKm2HHFoVP5SBdXfZItdP46g5wQwf/WCN8s7q3tFBQYr1MW+AJ3hI3jV63Dpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E89rYp5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E89rYp5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8D71F00893;
	Fri, 29 May 2026 22:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780093702;
	bh=Z/EawK8MbqDv7GZqPjJmMR8TwPyQKDW8O5bg2XADX1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E89rYp5La3kpPcFJtclIuLald43nmZJXy7r67QKh4EJOSSAmkfAAIAQFO5+zzRg2h
	 aCqNW5qqMbQgSKZaNE7x8ihqHMOuCHFQ1WVxojJbyE4o0k0jktr0KlgRKOm5+pmcrV
	 ugW++0ak4p8tpX8bbJWhFtUL+hbGu/K+JOU1SMUCJaxoJ2cZnGIUno+S0fCYRV71e7
	 E82SPTye81PeyrFddtmQYuMi9U7MfE1G09rdqXa7C7g4WGXzNXckxmFSYs53nxB3Li
	 BctG5fzNuQ2l/i8r83wtk4TmWpC3zHgEppdlPsT/jIWamQyd5Q0ZcX3CqshzlOc4xh
	 0XcOAOjQ+3W1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/24] KVM: SEV: Use READ_ONCE() when reading
 entries/indices from PSC buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-11-pbonzini@redhat.com>
References: <20260529183549.1104619-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 22:28:21 +0000
Message-Id: <20260529222822.5D8D71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM passes KVM_MAP_GPA_RANGE_PAGE_SZ_2M to userspace for partially=
 completed 2M pages that are being forced to 4K handling.
--

commit d195b85e8b040d5bc29811a11645551c672d8a47
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Use READ_ONCE() when reading entries/indices from PSC buffer

This patch uses READ_ONCE() when accessing guest-accessible Page State Chan=
ge
buffer entries to protect against TOCTOU vulnerabilities. It skips these
macros for code paths where KVM exclusively writes without consuming the
results.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -3948,7 +3948,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
> =20
>  	/* Find the start of the next range which needs processing. */
>  	for (idx =3D idx_start; idx <=3D idx_end; idx++, hdr->cur_entry++) {
> -		entry_start =3D entries[idx];
> +		entry_start =3D READ_ONCE(entries[idx]);
> =20
>  		gfn =3D entry_start.gfn;
>  		huge =3D entry_start.pagesize;
>  		npages =3D huge ? 512 : 1;
> =20
>  		if (entry_start.cur_page > npages || !IS_ALIGNED(gfn, npages)) {
>  			snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_ENTRY);
>  			return 1;
>  		}
> =20
>  		if (entry_start.cur_page) {
>  			/*
>  			 * If this is a partially-completed 2M range, force 4K handling
>  			 * for the remaining pages since they're effectively split at
>  			 * this point. Subsequent code should ensure this doesn't get
>  			 * combined with adjacent PSC entries where 2M handling is still
>  			 * possible.
>  			 */
>  			npages -=3D entry_start.cur_page;
>  			gfn +=3D entry_start.cur_page;
>  			huge =3D false;
>  		}

[Severity: High]
This is a pre-existing issue, but does this code violate the hypercall ABI =
by
using the original entry_start.pagesize when populating the hypercall
arguments later in the function?

When a 2M Page State Change request is partially completed, the code above
correctly forces it to be handled as 4K pages by setting huge =3D false and
adjusting npages and gfn.

However, further down in snp_begin_psc(), the hypercall arguments are
populated using the unmodified entry_start.pagesize:

arch/x86/kvm/svm/sev.c:snp_begin_psc() {
    ...
    vcpu->run->hypercall.args[2] |=3D entry_start.pagesize
                                    ? KVM_MAP_GPA_RANGE_PAGE_SZ_2M
                                    : KVM_MAP_GPA_RANGE_PAGE_SZ_4K;
    ...
}

Will this cause KVM to pass KVM_MAP_GPA_RANGE_PAGE_SZ_2M to userspace for a
range that is no longer 2M-aligned and whose size is no longer a multiple of
512 pages?

Can a guest exploit this by passing a partially-completed 2M page request
to force userspace into an error state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D10
