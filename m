Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176F3A4F47
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357747; cv=none; b=eF7oCcCkddrtzlv1xbxjwAo+Y3xMSYMSQf7X33vJaReDkjF4jlVdO13iEHjk6y73WH7axdeknRANlIldORtZvuStKqFRye4iiIhZSS472nEeVDbLWu94TKkwhyJGW3vaFZWFJZlLTXnavAHXPQ86eCkxKIEmbVIQtwQ6Kr2+LWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357747; c=relaxed/simple;
	bh=FhCwS7E6wjWGYrbzFEVYQu8Yk7YBJ38XX3qB7E5Qlcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=moHtY1voYEHthuGBIepaZV/7H16l+NBXnjCvjAXpRfYulbGE5AiAia1g/D1chbxjuvVFZk3slk2cUitVqG7sjAojineP3GFB2DQkE8EVAqaq07UPr1eteMJ4zqPT/u7ZAGZKXt/Nm9GavlhEFJAUfBtJCd9vDCp2oNxeHxtMls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwUSzkrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwUSzkrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF001F000E9;
	Mon, 10 Aug 2026 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357746;
	bh=Ra4Vi3yKjwUZ6GJMMU1DeTMjVlGTQL0wlRNg4rkv90w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hwUSzkrkfQ1uJcGYBN1H5XqCVMMwaFAeOJ15N8kwG0XuUZQOHCnyfDDCVojOA9ieP
	 G/qoABQQfpf8qN5NXUBmqg321wuVp0MXSqNGTzgbk12K35w+xwWbwV0ddNCh/4P1RR
	 g0q5kYdIMNUze8jt5sdq4DlsQpDFR+W0pMocwble94fWlDMWeDqqDrR+tMA9nhmGjD
	 VGQhNT3RZudga68Auj0QhwDa1unuQiwsnDLZeW3ns9vBQ+c5WB77WUPgoorC2eShDK
	 rV8Z1IDN30qUyLJA2IcxVT3OEAkpiRUSD2jopsPtTeE7b1kgXs37nBvpP52scYD9zg
	 el24mJfdj5UbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] KVM: x86/pmu: Add PMU ops for vendor state sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <97458b49f1ba443345e13868db0115fd0249b5aa.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
 <97458b49f1ba443345e13868db0115fd0249b5aa.1786345201.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:29:05 +0000
Message-Id: <20260810102906.4AF001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly introduced PMU ops (get_vendor_state, set_vendor_state) a=
re never invoked by KVM nor implemented by any vendor PMU, rendering them d=
ead code.
--

--- Patch [2]: [PATCH 2/8] KVM: x86/pmu: Add PMU ops for vendor state sync =
---
commit 2b7ba0292c6d4a2eb66eaca07b256dee5f7af75a
Author: Sandipan Das <sandipan.das@amd.com>

KVM: x86/pmu: Add PMU ops for vendor state sync

This commit introduces new PMU operations get_vendor_state and set_vendor_s=
tate
to KVM's PMU architecture to allow synchronizing guest PMU state with a ven=
dor
save area. It updates the capabilities initialization to nullify these oper=
ations
if the mediated PMU is not enabled.

> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index f60856c48462b..2b1a8d6433734 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -42,6 +42,8 @@ struct kvm_pmu_ops {
>  	void (*mediated_load)(struct kvm_vcpu *vcpu);
>  	void (*mediated_put)(struct kvm_vcpu *vcpu);
>  	void (*write_global_ctrl)(u64 global_ctrl);
> +	int (*get_vendor_state)(struct kvm_vcpu *vcpu, u32 msr);
> +	int (*set_vendor_state)(struct kvm_vcpu *vcpu, u32 msr);

[Severity: Low]
Are these new PMU operations actually invoked anywhere in KVM or implemente=
d by
any vendor PMU in this patch? It appears they might be dead code, as there =
are
no callers or vendor implementations (e.g., for AMD or Intel) provided, des=
pite
the commit message mentioning opportunistically synchronizing the state.

> =20
>  	const u64 EVENTSEL_EVENT;
>  	const int MAX_NR_GP_COUNTERS;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786345201.gi=
t.sandipan.das@amd.com?part=3D2
