Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A32BE057
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768019; cv=none; b=f1rZ8/kcxfWarLh5LnFa0h6TK2QBFj+kGPxbdg8NDNYIUwKq1bEdMcwdURAB5EpitvLGDDFpB2W4aJfbPNZvS8Ykuhov6EZhHl04b0ByXf2pcPEl3/tLeNEhwbl/nM0nYpr8c5EUfFwCRFNHiFtC3pLwEe4sxMNYWOk6eAkuFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768019; c=relaxed/simple;
	bh=hyKzx4AGogcof4/JFNIAxKuBec+6MTNmSCBpThiVlEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N6Izk4ghHHsXclaAeE+aXzkZlYrtc7VtaECoA1hyWiB6tUIeQWGaqugkSATNgEYwLEwdMcvzeQ2l/XTArFm3CH4xIkRgmnDlomndxA7BVHKm9LsaxrYz2zh/lejdpBzxMGLbKSujbyEMttjR6tDz3624RmQmhzWPASRM4nXD5OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHvMRLy6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHvMRLy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D726E1F000E9;
	Tue, 26 May 2026 04:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779768016;
	bh=Bw7CghG1+Wpw1tg+WYa/mNk3xLB61poNXfrOl26qYlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHvMRLy6EAChBHPNVlT0/F7/Q98iZZxL7YUNbVrSnZp10jX4omF8TCWpjqxDFtcOU
	 /5SwB9AghB4QThJkzJIIKmuyLksuH7HDeZkDSaySS0wJ4DknNm9LBZAfp1m5vExjDr
	 NXfpV4xi65TwSW6XquYD0REx8+jnBri75WrfvwQKY3VT20ro+vg5QHMze8rEz4OK04
	 XBBRjQQRh7+2LP8JPTGK16Ky5UtO6Jpy/6a+RoWCmrbdemcgak9p+rxTIM1vwJmce8
	 6sCiz8oyuqND1hZiZQQBBHjK4rhQfv1jDvwNRthQxuca7kFejTFyNMt11m3txsQFkO
	 UJbwurmvZQV2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
Reply-To: sashiko-reviews@lists.linux.dev
To: "Douglas Freimuth" <freimuth@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526015323.207343-4-freimuth@linux.ibm.com>
References: <20260526015323.207343-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 04:00:15 +0000
Message-Id: <20260526040015.D726E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Allocation in atomic context drops memcg accounting and potentia=
lly triggers kswapd lock recursion.
--

commit 0463a419ba36eefec4ffef625bfb65cfcb7dbbd7
Author: Douglas Freimuth <freimuth@linux.ibm.com>

KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

This commit introduces a fast path for IRQ injection in s390 KVM via
kvm_arch_set_irq_inatomic. It transitions shared resources to spinlocks and
changes allocations to atomic to prevent blocking, as the path runs with
interrupts disabled.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 23f578e7b9dce..1aedeeeedf9e8 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
[ ... ]
> @@ -3632,3 +3700,85 @@ int __init kvm_s390_gib_init(u8 nisc)
> +/*
> + * kvm_arch_set_irq_inatomic: fast-path for irqfd injection
> + */
> +int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
> +			      struct kvm *kvm, int irq_source_id, int level,
> +			      bool line_status)
> +{
[ ... ]
> +	if (!ret || adapter->masked) {
> +		kvm->stat.io_390_inatomic_adapter_masked_or_coalesced++;
> +		return 0;
> +	}
> +
> +	inti =3D kzalloc_obj(*inti, GFP_ATOMIC);

[Severity: Medium]
Does this allocation drop the memcg accounting that is present on the slow
path (GFP_KERNEL_ACCOUNT)? This might allow unprivileged guests to allocate
kernel memory without being charged, bypassing resource limits.

Also, since this fast path runs with interrupts disabled, could the use of
GFP_ATOMIC cause lock recursion? GFP_ATOMIC includes __GFP_KSWAPD_RECLAIM,
which triggers wakeup_kswapd() and can acquire scheduler-internal or waitqu=
eue
locks. Would it be safer to use
(GFP_ATOMIC | __GFP_ACCOUNT) & ~__GFP_KSWAPD_RECLAIM here?

> +	if (!inti) {
> +		setbit =3D 0;
> +		adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
> +		return -EWOULDBLOCK;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526015323.2073=
43-1-freimuth@linux.ibm.com?part=3D3
