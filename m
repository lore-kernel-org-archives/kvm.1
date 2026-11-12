Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442673;
	b=h1xDvzvE/TdVgdfpCHA43v8R2cEoVxt6/FNiZJvYHkBIzw3M0hBYsMGvImQE1hWcWdRX
	 aK2ohlHC4d01RibolciLPkmHhDH3YXqaWM7q9lku+C7GH8z2WaFhxssQNck+vN/xtZjpY
	 9Zg8QwHJP/o/JJFI00ap/Dgn/KkHKrSb04ha/hh5SganRk/IZE5qD0JEV9a+5BYnSly7N
	 hXiAIofW7d+jqloRbk48pahSzq0fupBWF7hhFbDeWPKq9L52036+TYyDWQT1fwrQDA7Yk
	 s+MuLEj87qxokxCYHSLkwIuRAQ7SRT8m+abGDeZyqqeXhcSOkz3njiltlwy7M0bSZzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442673;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZzsPa81dpyn+F/Esmqz9jQgZ2Ln/oH57eZktwIJQp6Y=;
	b=sAewG/ikbW13SJxptBrx9SzDOwD5b8PJF9ZWFMa1hmRWkTQoqH6DqawCeQXMIGAYNGW7
	 ou9v9kixCjPCtYWYoweKzOJPsQMMlveprATX4Snkttu0b1mYlvXQQhngG6dzxPhdJ+VoT
	 URxsU6SLOIbvVp4Iv9tf7rRmwspPxDquqS1/Ouk1OEJ1rTvGpn3okH+kuESHmJ5EJtZuS
	 5ymNziiVmoz3ls/EDSz63gHvhA3elYQAkwZTo4W8hBirqDM//iG5Bv/kDY4AQIvDtZuuy
	 jQZmZ78MVSQOdQg0MgfUcAoVh06waqOtu8Zjr8vxKqnvAouXiSRTTpIx84L8mvUjj4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEsGkfZy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA785606A31C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEsGkfZy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BE51F00A09
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 00:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442673;
	bh=ZzsPa81dpyn+F/Esmqz9jQgZ2Ln/oH57eZktwIJQp6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZEsGkfZydFig5ZVck3lA/C5493vPLZ2sGi5g8mDO/n4GIR6AE6m9rh0/YufhB/wNp
	 6ZOQIj9NzuSMBwYJ+Qf/JlRZbU94/OmPloQs2zcg1TG7+H4UAXDzKPzgHd3W9Fyfds
	 eggGoZ71ipTiclI22QNuAGp+kGgeR+7qTjmSqEfqK4YRFmSLg4wha6JT7EcRyiRsml
	 Ert/ZpEE9f/RCGAtMBIheT25jCdbNtLkbFwWS0z6SEJ5AE5sSNrjuH9eF18Bgb/ZAV
	 qmfEtE76nCXu+2n3UO3mTHJ/m/xDhGpo7K2HNCiq020CutKBBDzhOZwMhGCPUdeYk/
	 lYHYGFSYDIWuA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso545864266b.2
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:17:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFfgxxh/e4S1jA2/o0pgTX34UUKP32i06ZYrb+KWPmDesaztkx3PUWZPKLwW02Rmrql2Q4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/suMOO5TRSTExalLjoZ5O2aAxKH2igTGYnWMEWqGqDdjFAfyb
	zOutGeuFHzFBty+aioSvWeuuitu0sUthBaG+ANAKEUIVw7JkQOQ58SrtyqpPIzsA3KMgMhAzkFr
	t6qovdstcxq7+kLf06dM5xj19h8VlU70=
X-Received: by 2002:a17:907:980b:b0:c26:2a2:b91d with SMTP id
 a640c23a62f3a-c506694f0b9mr345372866b.6.1794442672547; Wed, 11 Nov 2026
 16:17:52 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112000200.3005587-1-jmattson@google.com>
In-Reply-To: <20261112000200.3005587-1-jmattson@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 11 Nov 2026 16:17:40 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMD5E4LxsQsV2P5_wy2yKdqE6TSNAp6y+3SpzcMDTSUkg@mail.gmail.com>
X-Gm-Features: AclHuK85o75-ht54CUq8k-6jkx4zbqrwa2R0Tq72RmOqP8KdGNg2NVlFa4nMQzc
Message-ID: <CAO9r8zMD5E4LxsQsV2P5_wy2yKdqE6TSNAp6y+3SpzcMDTSUkg@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Mark VMCB_CET dirty on active VMCB in svm_set_msr()
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 4:02=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> In svm_set_msr(), writes to MSR_IA32_S_CET, MSR_IA32_INT_SSP_TAB, and
> MSR_KVM_INTERNAL_GUEST_SSP update svm->vmcb->save.{s_cet,isst_addr,ssp}
> (which resolves to vmcb02->save when in guest mode), but mark VMCB_CET
> dirty on svm->vmcb01.ptr instead of svm->vmcb.
>
> A stale VMCB_CET clean bit may result in the loss of those MSR updates.
>
> Mark VMCB_CET dirty on svm->vmcb instead of svm->vmcb01.ptr.
>
> Fixes: 48b2ec0d540c ("KVM: SVM: Emulate reads and writes to shadow stack =
MSRs")
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

> ---
>  arch/x86/kvm/svm/svm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 136069dfcd44..eab11fe50312 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3181,15 +3181,15 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, str=
uct msr_data *msr)
>                 break;
>         case MSR_IA32_S_CET:
>                 svm->vmcb->save.s_cet =3D data;
> -               vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_CET);
> +               vmcb_mark_dirty(svm->vmcb, VMCB_CET);
>                 break;
>         case MSR_IA32_INT_SSP_TAB:
>                 svm->vmcb->save.isst_addr =3D data;
> -               vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_CET);
> +               vmcb_mark_dirty(svm->vmcb, VMCB_CET);
>                 break;
>         case MSR_KVM_INTERNAL_GUEST_SSP:
>                 svm->vmcb->save.ssp =3D data;
> -               vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_CET);
> +               vmcb_mark_dirty(svm->vmcb, VMCB_CET);
>                 break;
>         case MSR_TSC_AUX:
>                 /*
> --
> 2.56.0.567.gdb80ae8cd5-goog
>
