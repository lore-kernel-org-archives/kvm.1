Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D42EBB8C
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007946; cv=none; b=Mz0cRatcZOaXI8pjru4d57liVVUAwzTOAztP+7TjY2qCdoB0scqww/ORnq3zHTZNF2QxjC9zmouMmvUBQZR3/EFVHZ2nniGP+g36GIZxw+N6MBkXhzgVeuGVHBv6aVS7OsB/gLOcRwxkwIVrB90/0MKGSJjlX81ujUTVFfGfNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007946; c=relaxed/simple;
	bh=P8AzmCQz1lFLbTL/eZh4BbLBTanu3rBDDv3noIdJamA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fAx18M4uvUezd/YgPkFalFz9xQDlKdjakqy6cWwMcCP2x8/H6+oLpADWfC4DnvShxjU7sNdIt2N7fAAOXdfJV8+Ajzy4p3czDY+rj4aZqwpx+DB3/g8QRhBcv7hrdG+f5wqRUCEmrtu/AZyDbl5UsgUdtXyJw05jX6yCc8euWK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agv1xqOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agv1xqOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3641F000E9;
	Tue, 14 Jul 2026 05:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784007945;
	bh=bA3drNZIfqUWSi2Djbux1pKjCCs10ELyfne3wbJ80ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Agv1xqOWHHge6pqc3o16mCHZuVMshC3ngcc022infp8tRM2nifps+INAATrjXii5p
	 cOWyJOZt9kPgbThkqTVIc+3DjBm7Jtt5F7c2Pc76gyxMB2m996NmNgmrmKtM+IQU/A
	 w8501ISLqYWEc+XCLw5jzuEnWLHo3EHxZVpJRYqBLfRS/UvLBwCBJOg/YEChqu/Kkl
	 5UkZiO6vBdR3wPnug8eIEM7VBNev3t0pDpBcN9APA3fmP21Rz91qGafvzxt3GCOm3s
	 eQnXu1Y3nQQdJO3t21aJt/KFsBMmvSI5RYcTEjSgILOgePuMy5v+5xqajFMrTooyYe
	 U8IzRzZw0ROwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] KVM: nSVM: Fetch missing DecodeAssist bytes for
 synthesized #NPF/#PF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <341a0d64b31f03bf580beab32a36bf58042ccf2a.1783999988.git.zhang_wei@open-hieco.net>
References: <cover.1783999988.git.zhang_wei@open-hieco.net>
 <341a0d64b31f03bf580beab32a36bf58042ccf2a.1783999988.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 05:45:44 +0000
Message-Id: <20260714054545.2E3641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing 32-bit linear address truncation when computing `rip + c=
ount` for instruction fetch.
--

--- Patch [6]: [PATCH v2 6/8] KVM: nSVM: Fetch missing DecodeAssist bytes f=
or synthesized #NPF/#PF ---
commit 92b0b1d782b47781c3462fcdfb9a37ae5af201c8
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF

This commit updates nested SVM to fetch missing DecodeAssist instruction
bytes directly from the L2 guest page tables when the emulator fetch cache
is incomplete. It honors CS limits and handles page faults, but skips tail
reads for SEV guests.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -75,6 +75,54 @@ static void nested_svm_clear_synthesized_insn_bytes(st=
ruct vcpu_svm *svm)

[ ... ]

> +static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *bytes,
> +				      u8 count, u8 max_bytes)
> +{
> +	struct kvm_mmu *mmu =3D vcpu->arch.walk_mmu;
> +	u64 access =3D PFERR_FETCH_MASK;
> +	gva_t rip =3D kvm_get_linear_rip(vcpu);
> +	struct x86_exception e;
> +
> +	if (to_svm(vcpu)->vmcb->save.cpl =3D=3D 3)
> +		access |=3D PFERR_USER_MASK;
> +
> +	/*
> +	 * Hardware truncates the fetch at the CS limit.  CS.base and CS.limit
> +	 * checks do not apply in 64-bit mode.
> +	 */
> +	if (!is_64_bit_mode(vcpu)) {
> +		u32 eip =3D kvm_rip_read(vcpu);
> +		u32 limit =3D to_svm(vcpu)->vmcb->save.cs.limit;
> +
> +		if (eip > limit)
> +			return 0;
> +		max_bytes =3D min_t(u64, max_bytes, (u64)limit - eip + 1);
> +	}
> +
> +	count =3D min(count, max_bytes);
> +
> +	while (count < max_bytes) {
> +		unsigned int chunk =3D min_t(unsigned int, max_bytes - count,
> +				PAGE_SIZE - offset_in_page(rip + count));
> +		gpa_t gpa =3D mmu->gva_to_gpa(vcpu, mmu, rip + count, access, &e);

[Severity: Medium]
Does this properly handle linear address wrap-around for 32-bit guests?

For a 32-bit L2 guest, if CS.base + EIP is close to 0xffffffff, adding
count to rip can cause rip + count to exceed 4GB. Because rip is a
64-bit gva_t, the addition won't automatically truncate to 32 bits,
meaning the address will evaluate as greater than 4GB rather than wrapping
to 0.

Could this cause KVM to fetch instruction bytes from the wrong guest
physical address when the instruction fetch wraps around the 4GB boundary?

> +
> +		if (gpa =3D=3D INVALID_GPA ||
> +		    kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(gpa),
> +					     bytes + count,
> +					     offset_in_page(gpa), chunk))
> +			break;
> +
> +		count +=3D chunk;
> +	}
> +
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783999988.gi=
t.zhang_wei@open-hieco.net?part=3D6
