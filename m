Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D339FCB5
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355335; cv=none; b=WCiTTGE6euIx9Pv1wRzopRs3fl5ceIKBNqG9FeW3mvBjVQAcJr2yxSJ2MRfLbeXxS2WyAdOOgLpIttNE7X89D0LBuPj7NMFNl0Vbryg0JvUyRcbeNlT+bYpT//1oaHaHU58/s8VzhJ2P3NbYHQs77D7XPU+pscLUlk9PL02ylkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355335; c=relaxed/simple;
	bh=+91wU/xEn2F7awJ34DO8xKSBiFleu0yUZOziUp/WOU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XFbKrmABi8AqiJa4wvJwNo8A86G5Txt6NPWZRmUn2u2V8hCqjuz/E8cANiKtZ8sEzGmSac8NpfTbsF+vJBijUxSKOggr9MBPHOWK799rwXBTiNoq0VuLBCmtKnfpsxmoBeurcrjn34TajhiZd6x9StAmOxaoGGn9G8ratgdeoFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqu4b+RR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqu4b+RR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC1E1F000E9;
	Wed, 29 Jul 2026 20:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355334;
	bh=GcU4KB5gZrfozxeLT0yqTkuWiV4/olk+Cy3ACEENWy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hqu4b+RRQLrG6t/I97hCUh/Aco2hSVSRKGFO0wT6dgTnfk5kiLltWtWAjyUA7rO5M
	 NPxBvNqr7iYu84iKLES8Po/xD+fIvDf+CUlwS9xcNRJJm3RcYVGJ8JbtpmKsZqS7+z
	 nvUR0OjicqGvdgu6MhH7fnOIcUFFqNE9sGjFZohz0YpH4mJgj+3IZD0HouPNnxjK54
	 s4q1sjtloJkGWt+buYwnTMLwowBpE8SqYTxPEJ3eLe1TXsrFTkpbzlW8h0B7vS8nIW
	 nqPRcxfvku2BaYV9W4rl8EZL0FtTySw1RXMRINzZgNbyiwKrnI61lSLkEA6inc4cpK
	 PVRg/j+s/8uhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/20] KVM: VMX: Refactor VMX instruction information
 access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-5-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-5-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:02:13 +0000
Message-Id: <20260729200213.CBC1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete refactoring of VMX instruction information access lea=
ves brittle hardcoded bit shifts.
--

--- Patch [4]: [PATCH v6 04/20] KVM: VMX: Refactor VMX instruction informat=
ion access ---
commit b0d7d66df897ae19fd14659a411d846da0d89653
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: VMX: Refactor VMX instruction information access

Introduce a helper that returns the instruction information as a 64-bit
value and adjust existing sites to prepare for a wider field.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 0635e92471c89..92b530baa0ee9 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5234,7 +5234,7 @@ static void nested_vmx_triple_fault(struct kvm_vcpu=
 *vcpu)
>   * #UD, #GP, or #SS.
>   */
>  int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualif=
ication,
> -			u32 vmx_instruction_info, bool wr, int len, gva_t *ret)
> +			u64 vmx_instruction_info, bool wr, int len, gva_t *ret)
>  {

[Severity: Medium]
This is a pre-existing issue, but while we are transitioning this function
to take a u64, should we also update the memory operand extraction logic
inside it?

It currently contains open-coded bit shifts that might not handle the wider
format correctly when extended register IDs are introduced:

    int  index_reg =3D (vmx_instruction_info >> 18) & 0xf;
    bool index_is_valid =3D !(vmx_instruction_info & (1u << 22));
    int  base_reg       =3D (vmx_instruction_info >> 23) & 0xf;

[ ... ]

> @@ -6428,7 +6429,7 @@ static bool nested_vmx_exit_handled_encls(struct kv=
m_vcpu *vcpu,
>  static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
>  	struct vmcs12 *vmcs12, gpa_t bitmap)
>  {
> -	u32 vmx_instruction_info;
> +	u64 vmx_instruction_info;
>  	unsigned long field;
>  	u8 b;
> =20
> @@ -6436,7 +6437,7 @@ static bool nested_vmx_exit_handled_vmcs_access(str=
uct kvm_vcpu *vcpu,
>  		return true;
> =20
>  	/* Decode instruction info and find the field to access */
> -	vmx_instruction_info =3D vmcs_read32(VMX_INSTRUCTION_INFO);
> +	vmx_instruction_info =3D vmx_get_instr_info();
>  	field =3D kvm_register_read(vcpu, (((vmx_instruction_info) >> 28) & 0xf=
));

[Severity: Medium]
Since the goal is to prepare existing sites for a wider field, should this
open-coded bit shift be converted to use the vmx_get_instr_info_reg2() help=
er?

If the 64-bit extension changes register bit offsets in the future, this
hardcoded shift could read incorrect bits.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D4
