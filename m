Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB53E2765
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943945; cv=none; b=OrsJpbeb5JoZGRGnu5eouxi83GvJAsPClXQfiFi9PVIrhd5cf+zph0rvD3WlOcdgMm2zNBeP8oXOfUXDIidBuaNiHnXYD9sHnqc2bn4n5yGTbueP5YXxhrgk/ZUmtaDDW0vcQr0dSY4Z9IbFNI04UnBQqwazORqI3wQYgYqJahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943945; c=relaxed/simple;
	bh=JJh0TJtq0YDqsJdMJr7YXQ0RyL7C9skegRJtbzu6mS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eqNHPwtS9BubgMnnNZjqB08b5ps0TfD+fUQqXWYWer9HQj309KO4sG9Bm/77C7LovDVPwd5UlrwwLyYIf6RjVFQMUNIScDN/D54UEnn256isISGrYCI58VGwceh4vVvUFhbD46b/nPdCczUobepSLvKnjM9zTFQfyv23nxEeofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYSiUe8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYSiUe8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A481F00893;
	Mon,  8 Jun 2026 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780943944;
	bh=11CODMk7VNf2GuxQOc0dJEP/qKKO/Klre0eX1vIt4/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XYSiUe8Ly/QSNaniqZf0MzelTPHnPA92Zb1Hkj8pxwR3ih9x7OuwncY03A/iH5IXV
	 69pa173w1+5t5mJQWQGVsQdnp7g1Fa5U8NLSiarhmWZDFgsiD8TbnLyQk/I7MI0flN
	 Lh1S5lMfYhFebTzBea7qWXICb+HuYqAHdx4RuK1KJ4Gp6WCMhBhIRJz3Z5tNlNrPX7
	 XJZyuBZMPqYdf2xEDqIzGlqL4X9lDwU2ra2d2YpgBivIVZqxdMu0aZEpxBGSq5xZ30
	 pZiA9Ue/RANxSvlgYSDPX8afzD+5sX1u++7+hxZKLeLW9WtZu8EGGWtDK/J1elZK3M
	 7p8/5cgUJjy+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/34] KVM: x86: Improve synchronization in
 kvm_synchronize_tsc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-19-dwmw2@infradead.org>
References: <20260608145455.89187-19-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:39:03 +0000
Message-Id: <20260608183904.09A481F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch breaks the 1-second TSC matching interval extension, cau=
sing severe TSC synchronization failures when restoring large VMs.
--

commit 36ab17132ec1bae1eb23cb9d908fb9bf60b2d36f
Author: David Woodhouse <dwmw@amazon.co.uk>

x86/kvm: Fix misrecorded TSC synchronization values

This commit modifies kvm_synchronize_tsc() to reset the written data and
timestamp to previous values when a synchronization match is detected. It
also unifies the TSC reads used for calculating the current time.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index bce4c7a6a6fe..c8c0633263fb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -2904,12 +2916,25 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *=
vcpu, u64 *user_value)
>           */
>  	if (synchronizing &&
>  	    vcpu->arch.virtual_tsc_khz =3D=3D kvm->arch.last_tsc_khz) {
> +		/*
> +		 * If synchronizing, the "last written" TSC value/time
> +		 * recorded by __kvm_synchronize_tsc() should not change
> +		 * (i.e. should be precisely the same as the existing
> +		 * generation).
> +		 */
> +		data =3D kvm->arch.last_tsc_write;
> +
>  		if (!kvm_check_tsc_unstable()) {
>  			offset =3D kvm->arch.cur_tsc_offset;
> +			ns =3D kvm->arch.cur_tsc_nsec;

[Severity: High]
Does forcing ns and data back to the start of the generation break the
1-second TSC matching interval extension for large VMs?

During VM restore, userspace sequentially writes the exact same saved TSC
value to all vCPUs. KVM's legacy behavior updated the tracking anchor to the
time and value of each matched write, creating a sliding window that allowed
the restoration process to exceed 1 second in total, as long as each
individual vCPU was restored within 1 second of the previous one.

By freezing the anchor to the start of the generation (T0) here, this slidi=
ng
window appears to be lost. If a large VM takes more than 1 second to restor=
e,
a vCPU restored at T_N (where T_N - T0 > 1s) will compute an elapsed time
greater than 1s.

Since userspace writes the same static saved TSC value, the expected TSC
will be more than 1s ahead of the written value. Would this cause the
synchronization check to fail, creating a new TSC generation with a
misaligned offset compared to the rest of the guest?

>  		} else {
> +			/*
> +			 * ...unless the TSC is unstable and has to be
> +			 * synthesised from the host clock in nanoseconds.
> +			 */
>  			u64 delta =3D nsec_to_cycles(vcpu, elapsed);
>  			data +=3D delta;
> -			offset =3D kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
> +			offset =3D kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
>  		}
>  		matched =3D true;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D18
