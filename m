Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEDE2F1FD7
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138364; cv=none; b=aUehuckchWzaxoptyXy2VJDzHe122Blgam+bBw2Hkzm2kK8MrrkMMZCt4GXIvRPS2XUaJJt5qNDPBfM07qik2giB+PqkmU2/BP4KhG/s4ft6Moj5xDpcJaqhOwqYyK5fb312vmyg3xLn7OP3MFRQPZNtVax534Zj53Auc9keOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138364; c=relaxed/simple;
	bh=Hej3Zj3NStqh71MiKbxQ1k9DcefmUG0XAKssGqWi9QU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V6//vobbmC7jIWYdRQKe6Ym27hzjNiChMTT+AXX5mPXBiB78I4IAbDr2dKM8QjePh+BXBZg0R0+On4h4EC2ti8Fdg0l8mctohQhGKd5fWO/5QMTS7CHLdxbrvU1no/Mpb8QpR7AeB6YgfnXX805VtlBnV2t45JJ2ARJc++hkZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuA4OzCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuA4OzCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F9E1F000E9;
	Mon, 27 Jul 2026 07:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785138363;
	bh=CLCar9gSehw8qqLYfQSFeHMorOWEW01YJl0C4DTLnqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fuA4OzCEB6jH0Kbvh3sBO+MrLEU6EevjNnMpStb7V3JXqjDwSq75ZuONadTSVSkq4
	 YxzY4JqwTTzN1LRHZOxYdPHQc8r26PQhntKmuaff/vDc9A3QcLOHDX0LHcI8Mx/Cdq
	 kRC5tGZxeliYkuU1Fz1ySRCuzBf1M1CmhMInBs6UpaBCLaROkc4g4zn7iM8PyEUHME
	 BonoAIooGBrDAt+HFCrQUcUsGBBSdt5aI0jTRmTA8MP5M+kL0HljLZTdmCCVJ90roY
	 WchkjIegW3jvw7DwyHC1RenEpKKiardZo8QHN5g/UeFZ+CBeZ960gNBTQI0w5PQ5GT
	 Ygto9WF+6x+zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] LoongArch: KVM: Add remote tlb flushing support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727072109.2151675-6-maobibo@loongson.cn>
References: <20260727072109.2151675-1-maobibo@loongson.cn>
 <20260727072109.2151675-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 07:46:02 +0000
Message-Id: <20260727074602.C9F9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Local TLB flush requests via KVM_REQ_TLB_FLUSH are silently ignore=
d when cpu_has_guestid is true.
--

--- Patch [5]: [PATCH 5/6] LoongArch: KVM: Add remote tlb flushing support =
---
commit 8224c08441c8eee94923d3771b8015f38a7278ab
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Add remote tlb flushing support

This commit introduces remote TLB flushing support by queueing a TLB
invalidation for each CPU to perform on the next vCPU load. It adds a
tlb_flush_pending cpumask and updates the vmid index when scheduled on
a physical CPU, while keeping the vpid index unchanged.

[ ... ]

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31a..19c81ae8941a9 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -210,7 +210,12 @@ static int kvm_check_requests(struct kvm_vcpu *vcpu)
>  		return RESUME_GUEST;
> =20
>  	if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
> -		vcpu->arch.vpid =3D 0;  /* Drop vpid for this vCPU */
> +		/*
> +		 * vpid need the same with vmid if vpid is not separated
> +		 * with vmid
> +		 */
> +		if (!cpu_has_guestid)
> +			vcpu->arch.vpid =3D 0;  /* Drop vpid for this vCPU */

[Severity: High]
Does this silently ignore local TLB flush requests when cpu_has_guestid is
true?

If a local KVM_REQ_TLB_FLUSH is made, for example by kvm_map_page() in
arch/loongarch/kvm/mmu.c when upgrading to a huge page, kvm_check_request()
will clear the request bit here.

However, if cpu_has_guestid is true, the VPID is not dropped. Because this
is a local flush, the tlb_flush_pending cpumask is not set globally, meaning
kvm_check_vmid() will not drop the VMID either.

Will this cause the local TLB flush to be completely lost, potentially
leading to an infinite page fault loop if the guest hits a stale invalid
TLB entry on hardware with a page table walker?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727072109.2151=
675-1-maobibo@loongson.cn?part=3D5
