Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C254763
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965457; cv=none; b=eCamiQg/85PzA2hMfEkJHDKOwYlAwHatLZEJAe3MMKJf1epQe+Gxrwa6Vrwn/tP3LgMbNNqKhGzsQTUFtMnqg/sMlRJciS522pi072uRhDNp8wSmOn86uVdzOStptV5MDpBvd38mY89OLR98kH122kMUhjQD65xEZtElq1WHpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965457; c=relaxed/simple;
	bh=+/KdcunXWfo/Wy4O9+aKPDeYpWcdOsrtIlThfGl/EX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QlWbb0+CxT5iOw1ttrASJk+ForMYFAk1NZ/P4rZVk8LI/UEQovs1DM6MGZJxIIh8RvKADr5RvlGDAOegnsRDybzBXZDVWlVZ0dLyu6MdMTqOvmesb5IGUrbYn4r8l4jpTdwokr/qiIW8MU/vkjTrBcSzVM6P0S2EC8USfWYlT5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx0JXNNV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx0JXNNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F6A1F00893;
	Tue,  9 Jun 2026 00:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965455;
	bh=UPH6cVKRrZqJD/psYiVWCpAcaCJ9eHx15Y+2YnZnlTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mx0JXNNVWHlFbJNUo+YR5NpZc9+gdDbimRHMy53hwhbBz/xxA0MmGZpsnhLRvhGGW
	 pI74RlAnXJxQVLNd53Q378UWMEOF0B4KTNxjpVKouY01rcVZn3fOgEG9br/l7V6I4i
	 Js182dmfISzZ1HaEdO19Ob/uRStalFCD+eaQgZVFXTHO7msl6ILMuJPyoTzwvnAcy4
	 Hrj8JGnLC+93Y00eOWpIFowis6x/SFuRABrRjbUpDz+jca5kySAQuOUBC+a4tqYX9O
	 znlXJNxEP6pZqpGxNaj5wXRpAqyDipcd27QrK5uBmZxa8H5Mt8LfVNL919h7q30pCn
	 30WkelKR6Fm3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 29/34] KVM: x86: Re-synchronize TSC after
 KVM_SET_TSC_KHZ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-30-dwmw2@infradead.org>
References: <20260608145455.89187-30-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 00:37:35 +0000
Message-Id: <20260609003735.82F6A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `kvm_read_l1_tsc` after `set_tsc_khz` calculates the curre=
nt TSC using the newly set scaling ratio but the old offset, causing a mass=
ive discontinuity in the guest's observed TSC instead of preserving continu=
ity.
--

commit c224c306d9d055ced6e04bed3638e47c8d31fb69
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM_SET_TSC_KHZ changes the vCPU's TSC scaling ratio but does not update

This commit fixes an issue where get_kvmclock() uses a stale (1:1) ratio
when computing the KVM clock. It calls kvm_synchronize_tsc() after
changing the TSC frequency to ensure cur_tsc_scaling_ratio is updated
and the TSC value remains continuous across the frequency change.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 54d4b1b3cfe4..96250264d403 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -2611,7 +2612,20 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, =
u32 user_tsc_khz)
>  			 user_tsc_khz, thresh_lo, thresh_hi);
>  		use_scaling =3D 1;
>  	}
> -	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
> +	if (set_tsc_khz(vcpu, user_tsc_khz, use_scaling))
> +		return -1;
> +
> +	/*
> +	 * Re-synchronize the TSC after changing frequency. This ensures
> +	 * cur_tsc_scaling_ratio is updated (used by get_kvmclock) and
> +	 * the TSC value is continuous across the frequency change.
> +	 */
> +	{
> +		u64 tsc =3D kvm_read_l1_tsc(vcpu, rdtsc());
> +
> +		kvm_synchronize_tsc(vcpu, &tsc);

[Severity: High]
Will this cause a discontinuity in the guest's observed TSC instead of
preserving continuity?

If kvm_read_l1_tsc() is called after set_tsc_khz() has already updated the
scaling ratio, the current guest TSC is calculated using the newly set
scaling ratio combined with the old offset:

tsc =3D old_offset + rdtsc() * new_ratio

When kvm_synchronize_tsc() is then called to compute the new offset:

new_offset =3D tsc - rdtsc() * new_ratio

This algebraically simplifies back to the old offset. Because the offset
remains essentially unchanged while the scaling ratio has changed, the
guest's observed TSC would immediately jump by the difference between the
old and new ratios multiplied by rdtsc().

Since rdtsc() represents the host's uptime in cycles, could this cause a
massive time jump that breaks guest timekeeping or leads to lockups?

Would it be safer to evaluate kvm_read_l1_tsc(vcpu, rdtsc()) before
calling set_tsc_khz(), so the old scaling ratio is used to establish the
baseline for continuity?

> +	}
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D29
