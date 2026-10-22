Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635939;
	b=1JT/G8YT6FV9/vRXGA6AgUUgKkq0/lEvUVD2M41zhmZhJDM5l1UisvH4G9myq+kKVH3z
	 t6kvby6wAYLRR2b9PhpXKYGftnwzSO9QqgPwslhwArx+oehLhhBQFzD0NbuCc/YvkXwJn
	 uUUdrWMpZhda474/WeukRFznnJFe+zfPF5UHpupFo1Fn79YBph/aPafhqLKM3Olqim2wO
	 FJaY/gjRbnDz63x/djKcSAoed+AMv4faFOOf2LWuVqIfHQ7zDJDqhH/i9S8RmGdOCYPET
	 m/gHl2WdLu1PaT1pPP+v5jQ9//nMlFGaTg16sSg2F1C6JfuGicNn790b3pw3a7N6YmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635939;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z5J1InzuUYwnq/tnYe6cXcN5v3+mKm5UXh1EFEeq+28=;
	b=FB9YNwG0BOX76Ouasj9t81I416CjElCGngK2Qo/HGPDkf+q/TQIqpKQ5HVmFehgGLoNK
	 DvJL8vcQPayf8cMv3wG8M/hSSFMJj9JN+dEYVArN3yXNQ7a3lpDNxPKZecgITLY/Qy7Tv
	 8qdeRknAs1uxmiERcFaXDf0UDBMLjN+x/GlyhlS+7wGiP/f6QNjeuDx7BltNHTK4/7giW
	 h2NHzhTrkFiDRBOVxsCpJapQvZRbG3+7aEgbuLYyo7Qbs2v1xVirr4vNI2Qaqwop+9KUe
	 PwnNay8DWssdhZauWz2jKzVwytmnd/oz6lPRV05dr1vRqdFVXNVPj6seavIDP8GfqBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzEy5qYn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3E606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzEy5qYn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCED1F000C1;
	Thu, 22 Oct 2026 02:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635938;
	bh=z5J1InzuUYwnq/tnYe6cXcN5v3+mKm5UXh1EFEeq+28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DzEy5qYno52LlU9Uq2jZFGeSgAp5m5Ab/G7kV2UAXe2dyMAMB2YwD4h7IaeY+uqpu
	 tQ+U7wpiDmwhXjYANZm7PDlEaaaLgkZicNMIrREdpn2lml3NKkFfyy/LtaVqAMrWsK
	 /UEYdsbDVfavljesjEhLwjZTiEbrEp90YPROdzRNsZz0m9rWcVpIZVyWlWG0+jQ+v1
	 vlgtU7GQeTr04RQeVb4uiUGqynb0W0ANAwPmyKjPnjhE7pygb6LV/MtIjrowVjT/YM
	 HjmxP7Uj0STkEbJGUq3XOnGmImmZlwa+DpnhBft/VlNgvV4Z8y+WB6VfSL/D6PiR7S
	 EAT42CC0hQfgA==
Message-ID: <sashiko-outbox-180868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Add regression test for KVM writing
 but not reporting vmcs12
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261022021820.298886-3-seanjc@google.com>
References: <20261022021820.298886-1-seanjc@google.com>
 <20261022021820.298886-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:25:38 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: selftests: memset() in vcpu_save_state() overwrites state->=
nested.size
--

commit 352912c420268741f0078843ad13ef7b51d43d5c
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Add regression test for KVM writing but not reporting vmcs12

This commit adds a canary check in vcpu_save_state() to verify that saving
nested vCPU state does not write beyond the reported nested state size, and
adds a guest sync point in state_test when L1 is active with a shadow vmcs.

> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/test=
ing/selftests/kvm/lib/x86/processor.c
> index 8374afd08bafe..976d53af6de7d 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -1282,10 +1282,16 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_=
vcpu *vcpu)
>  	if (nested_size) {
>  		state->nested.size =3D sizeof(state->nested_);
> =20
> +		memset(state->nested_, 0xaa, sizeof(state->nested_));
> +
>  		vcpu_nested_state_get(vcpu, &state->nested);

[Severity: Medium]
Does this memset() overwrite state->nested.size before calling
vcpu_nested_state_get()?

In struct kvm_x86_state (tools/testing/selftests/kvm/include/x86/processor.=
h),
nested and nested_ share an anonymous union:

	union {
		struct kvm_nested_state nested;
		char nested_[16384];
	};

Calling memset(state->nested_, 0xaa, sizeof(state->nested_)) after setting
state->nested.size =3D sizeof(state->nested_) clobbers state->nested.size w=
ith
0xaaaaaaaa before vcpu_nested_state_get(vcpu, &state->nested) is called.
Should the memset() be placed before setting state->nested.size?

>  		TEST_ASSERT(state->nested.size <=3D nested_size,
>  			    "Nested state size too big, %i (KVM_CHECK_CAP gave %i)",
>  			    state->nested.size, nested_size);
> +
> +		for (i =3D state->nested.size; i < nested_size; i++)
> +			TEST_ASSERT((unsigned char)state->nested_[i] =3D=3D 0xaa,
> +				    "KVM killed the canary at offset %u", i);
>  	} else {
>  		state->nested.size =3D 0;
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022021820.2988=
86-1-seanjc@google.com?part=3D2
