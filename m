Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359225771
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419596; cv=none; b=Am732+e/Yepqhj18zjjHt8pYY8ZeiSxYDtWQWx3CjHrwD8IRtOkR7O9vKdBPJZ48+G1xn5i4fDxgQeAK0t3UO2FFwI2HzmGv01VofhYDYug3uwdcEyBGWTLQHc3EHABOeLaU9Y5CZIoyimPiIysxc2qzAnlxHm0zZnf2HyRIenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419596; c=relaxed/simple;
	bh=qCMzvUGg5F5V3yCKYr5h+K/I5z2Y+WxlEnDISScs65o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IeGOP6Z/wvLXp/p2fXUZgtyiTDMMQjk2TymDCyBUdHZ+1nt+Wscy4OOGMu5yVEY69DqrsZSkBF2C87CFOGxcdn1Tl5VFF8CLRVTtURIEQ8hNdqLoPT3rHMJT4pAKFhQS8Da1dEHKHyUUiFO00+oSCNGsd2VOavw0xjD9q65durA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPQEMNJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPQEMNJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE8A1F000FF;
	Thu,  8 Oct 2026 00:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791419594;
	bh=f9XMQj9oGCFB+If613ksSy7aZj338SryGIt+h1q+RRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LPQEMNJVCAaVweXqYgpS+9U7MfVwFRd1TRuFI0fqUddm++bDFp27a+I6gW1OQf5df
	 37OU2OAjEbw3zbWt73iRV+PUTkGSIdfsgt8PoCR1/VjELG5/BgofnpzZuOdzJ3Gjbp
	 T3jb3giRqikHPd3azCZQ5df4yVM9LtbTGtNt09qat60PStV87L3i18k44HACmxln1f
	 IlKmtClmRb5AMXRCk8iWbRe4T0QU3HFhRAAHjUhfgwYj8UbobTrrZA0CccgDdemrES
	 JJPYy9zk2voymKXEgjeYjXPv7X7PdSNGTJYGssFb1eWOVa7SDGQ89HA5zmbcCcB7kf
	 U+dCa677b/KVQ==
Message-ID: <sashiko-outbox-163474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/29] KVM: SVM: Only flush the fallback ASID when
 used by a different vCPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261008001425.2458927-12-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-12-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 00:33:14 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: data race on sd->fallback_asid_vcpu between pre_svm_run and sv=
m_vcpu_free
--

commit aa8eca89b8d60f642d17b3f8439f52f2e1ae951d
Author: Yosry Ahmed <yosry@kernel.org>

KVM: SVM: Only flush the fallback ASID when used by a different vCPU

This commit optimizes the fallback ASID flushing logic by only flushing
when the last vCPU that used the fallback ASID on the pCPU changes. It
adds a per-CPU tracker fallback_asid_vcpu to determine when this occurs.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 8f27722bc4faf..0dbb1962d32b6 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c

[ ... ]

> @@ -1422,6 +1424,11 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
>  	svm_vcpu_free_msrpm(svm->msrpm);
> =20
>  	free_asid(svm->asid);
> +
> +	for_each_possible_cpu(cpu) {
> +		sd =3D per_cpu_ptr(&svm_data, cpu);
> +		cmpxchg(&sd->fallback_asid_vcpu, vcpu, NULL);
> +	}
>  }

[ ... ]

> @@ -3884,8 +3892,11 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
>  	if (is_sev_guest(vcpu))
>  		return pre_sev_run(svm, vcpu->cpu);
> =20
> -	if (unlikely(svm->vmcb->control.asid =3D=3D fallback_asid))
> +	if (unlikely(svm->vmcb->control.asid =3D=3D fallback_asid &&
> +		     sd->fallback_asid_vcpu !=3D vcpu)) {
>  		vmcb_set_flush_asid(svm->vmcb);
> +		sd->fallback_asid_vcpu =3D vcpu;

[Severity: Low]
Will this concurrent access to sd->fallback_asid_vcpu trigger a KCSAN data
race splat?

In svm_vcpu_free(), when a vCPU is being destroyed, it iterates over all
physical CPUs and modifies sd->fallback_asid_vcpu via cmpxchg() across CPUs.

Concurrently, another vCPU running on one of those CPUs will execute
pre_svm_run() and perform plain reads and writes of its local
sd->fallback_asid_vcpu.

Per the LKMM (C11 memory model), if an atomic RMW is used on one side
of a concurrent access, at least one side must use READ_ONCE() or
WRITE_ONCE() to prevent the compiler from fusing loads or reordering
plain stores.

Should the reads and writes in pre_svm_run() use READ_ONCE() and
WRITE_ONCE() to avoid this race?

> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008001425.2458=
927-1-yosry@kernel.org?part=3D11
