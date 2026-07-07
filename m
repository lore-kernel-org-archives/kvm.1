Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339C3F9A1C
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424712; cv=none; b=OYPJmk+dXdZ2Ak9FzniIsboOIg3zuC8iFcEhYnbHpr5TbKmqxUj+Byp8hOQMXRNtTTx0vIAtXcz8fPgS2lfMBW1LOa23VGJM1Dm0Mw9bboTLMdKtDkNsRaVJr6bgIZkFVLYmmy1ldhLZ48vRPLNVUWvRdYKusos00Zv/B2v/3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424712; c=relaxed/simple;
	bh=QHqWcNMuvzYA8fXLinvk1vQGPcfHWv5AL9HVV6AyN44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=btxZOhXAOLxsCBRajvtaw8w9hhQRofvhn3t0NmEdvB/L0JzHs6PHg/jDEvuBzRyAOV+jxACVmmPcRwv0XJAZ5Qa1FBGi/VJ53NkH47aFsYwfpafm5jg/6DX1da8/FJhVdtZO2MiBymgqmvArBGCZJGeUzB4AbKniFLJo+LoNALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noYyVZPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noYyVZPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707C71F000E9;
	Tue,  7 Jul 2026 11:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783424710;
	bh=i93Gz2qGBKvooAicVngxj6J0meIETh/gkEaS2jSoCq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=noYyVZPkbMKos2ri+w+Va/IlcdNxzO7NCvgQRXHiCgwnfw0CXyYqnJs+BZCp01V4F
	 cYyhMAjXWvkUq5npijahNZwuindJ+LVwNjRHPDgdpDpvlJq71/ndtSHAMspMcQd0x9
	 OV73yWRM4lH2iyJqiJjwVT7Q7QB3rlv0cz6ksiYjACFFt6SAC7BJ0Z5+vzTbllvXkH
	 6CMjlCTA6PeXnqQ9gG+E5+zqk/ev1jGomjnIPvKizxYStm7P63dj69ByhZpyL44YYM
	 PZpnEe/xvKXMo/vAuxk63e0xiYvN0qpqsZxOY8JFJUmLXdD/x2Qj8GkOOqZDnLtq7p
	 KVJpLgnBoSS/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] RISC-V: KVM: Move hfence type check out of loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707113715.413265-2-wang.yechao255@zte.com.cn>
References: <20260707113715.413265-1-wang.yechao255@zte.com.cn>
 <20260707113715.413265-2-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 11:45:10 +0000
Message-Id: <20260707114510.707C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch completely breaks KVM_REQ_FENCE_I requests by unconditio=
nally returning early from `make_xfence_request` when `data` is NULL, silen=
tly dropping guest instruction cache invalidations.
--

--- Patch [1]: [PATCH 1/2] RISC-V: KVM: Move hfence type check out of loop =
---
commit 7dbdb7321dcb98c78f1282572934fc7ae89bab7e
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Move hfence type check out of loop

This commit moves the validation of data and data->type outside the
VCPU iteration loop in make_xfence_request() to reduce overhead. It
adds an early return if the hfence data or its type is invalid.

> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 993b25ea94d67..a67b44a4d1d7a 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -335,6 +335,9 @@ static void make_xfence_request(struct kvm *kvm,
>  	unsigned int actual_req =3D req;
>  	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
> =20
> +	if (!data || !data->type)
> +		return;
> +

[Severity: High]
Does this early return break callers that intentionally pass NULL for data?

For example, kvm_riscv_fence_i() calls make_xfence_request() with data=3DNU=
LL
to broadcast a KVM_REQ_FENCE_I request:

arch/riscv/kvm/tlb.c:kvm_riscv_fence_i() {
    ...
    make_xfence_request(kvm, hbase, hmask, KVM_REQ_FENCE_I,
                        KVM_REQ_FENCE_I, NULL);
    ...
}

In the old code, passing NULL skipped enqueueing to the hfence queue but st=
ill
allowed the loop to populate vcpu_mask, so the request was properly broadca=
st.

With this change, the function returns immediately, dropping guest instruct=
ion
cache invalidations. Could this lead to guests executing stale instructions?

>  	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		if (hbase !=3D -1UL) {

[ ... ]

> @@ -347,9 +350,6 @@ static void make_xfence_request(struct kvm *kvm,
> =20
>  		bitmap_set(vcpu_mask, i, 1);
> =20
> -		if (!data || !data->type)
> -			continue;
> -
>  		/*
>  		 * Enqueue hfence data to VCPU hfence queue. If we don't
>  		 * have space in the VCPU hfence queue then fallback to

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707113715.4132=
65-1-wang.yechao255@zte.com.cn?part=3D1
