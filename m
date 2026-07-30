Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F641A542
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414697; cv=none; b=GgUEHkA9VjYXnqFM5hhU4cge5Qy73oO5eyZSe0h3Wad+z/0twK5YXl4un5c7J4Z03MeWEea32Q4qk7yubrgEEwSO1U3KPehJ8XmfWHBcbJr5XNj/fAPzKeMTFZ9kPDuAiJPC35AMgIL2pofsjSsCOMhRbgAdXyOesR8TU5yO4IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414697; c=relaxed/simple;
	bh=NMgMGAW3q1Zd4AF8yl/vsFGFzJyJgQORBe7azYcIFTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tCT9QBaR5KU9t0vcrocARSYDOBlN2LL7qKaLXkZxp+yRYq/PBUh5rq15hzgdsD1jTxtkjXp7Mk3sijtOPB90JjKatLdJvNFlDOrRx/dHsQnn1FhzfCCIhhsbwosxhf2DIB1TDdvdXz1iFB5Iz732GgAJfLxYAKqGx5QY9xhQxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR8/fofb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR8/fofb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FB21F000E9;
	Thu, 30 Jul 2026 12:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414695;
	bh=2KplCie7SYhUKlw9ByNuQW0oTuOVFz2SOKR7p+wSbkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fR8/fofbKMI/a3dygwXjgtC+egpHre/1BZ2VGCGvLnVqWQqkT/wo99rhPtoi3V7Ej
	 BrXwPgj8KbW6wKvEcIiDoTLjb/0Mr3J1KY5jGnG4TJVTyhi5imlmbnBh//sh1JCreG
	 xc1fbzBRaJ6kJ/Set7ANyFtzDBZeFQjbdZTKLSeO4EWu7yFopnjBiM0e/2kOzVBN5c
	 hjkCWf2jROBzqDWHFxoRO4XCs7AKu33lPUyILn83d1/w89MLBW7GoabQVQItMJTH0J
	 yO5qEIYSVepR9rNZCoOMFiEXiGBL8L/EBXH1du284c4dxBOvjstQ6np0GqBquBEwro
	 yj1DFTqah2zxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] KVM: nSVM: Fetch missing DecodeAssist bytes for
 synthesized #NPF/#PF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <9dae4bd5ad241b72193b38cfe8857c968c47a4b7.1785411877.git.zhang_wei@open-hieco.net>
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <9dae4bd5ad241b72193b38cfe8857c968c47a4b7.1785411877.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:31:35 +0000
Message-Id: <20260730123135.B3FB21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Already-prepared instruction bytes are discarded if the instruct=
ion pointer exceeds the CS limit (or due to residual upper bits in 16-bit m=
ode).
--

--- Patch [7]: [PATCH v3 7/9] KVM: nSVM: Fetch missing DecodeAssist bytes f=
or synthesized #NPF/#PF ---
commit 96d13188ab4298d9414e0345853cc8950d39abb9
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF

This commit limits the preparation of synthesized state to matching the
emulator fetch cache and fetches any missing tail bytes through L2 guest
page tables. If the emulator cache is empty, it attempts to fetch the full
window from the L2 RIP, avoiding fetches for SEV guests.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index cfb686c29bb47..cf2b6bb8126ff 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c

[ ... ]

> +static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *bytes,
> +				      u8 count, u8 max_bytes)
> +{
> +	struct kvm_pagewalk *gva_walk =3D &vcpu->arch.gva_walk;
> +	u64 access =3D PFERR_FETCH_MASK;
> +	gva_t rip =3D kvm_get_linear_rip(vcpu);
> +	struct x86_exception e;
> +
> +	if (kvm_x86_call(get_cpl)(vcpu) =3D=3D 3)
> +		access |=3D PFERR_USER_MASK;
> +
> +	if (!is_64_bit_mode(vcpu)) {
> +		u32 eip =3D kvm_rip_read(vcpu);
> +		u32 limit =3D to_svm(vcpu)->vmcb->save.cs.limit;
> +
> +		if (eip > limit)
> +			return 0;

[Severity: Medium]
Should this return count instead of 0?

If an L2 guest in 16-bit or 32-bit mode causes a nested page fault where
eip > limit evaluates to true (for example, in 16-bit mode if kvm_rip_read()
retains residual upper 16-bits), returning 0 here causes the caller to
overwrite vmcb12->control.insn_len with 0.=20

This would inadvertently discard any already-prepared valid instruction byt=
es
that were passed in via the count parameter, forcing the L1 hypervisor to
manually read the instruction from L2 memory and defeating the DecodeAssist
optimization.

> +		max_bytes =3D min_t(u64, max_bytes, (u64)limit - eip + 1);
> +	}
> +
> +	count =3D min(count, max_bytes);
> +
> +	while (count < max_bytes) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785411877.gi=
t.zhang_wei@open-hieco.net?part=3D7
