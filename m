Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582F2E1EE0
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124095; cv=none; b=KPsb6V/9ZbLVuSyl/ZEbTWW1HisRx8/0renDgVIN/8FmlK4RuUuW67I6HMeUrKXfc9TW9cc+pP6ZvhMh4W2zjE+pPTfr4sfxDqRctkRJhoS/kNK79Z1EeH9G1dAjBGwSdQFXntzrP1KQxHMwpiOsUtKtDDfjLky7KUC2yRuJlLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124095; c=relaxed/simple;
	bh=YUNlULqGxpfkajn3VKPdSRsIF4kh5mp6SjJILiQI10Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ucHmLfBV7+qb/JH6NLffeoCCrpxMv3abEdhvfnCjLXc6SEnfVv9sSjgBuln3vZyVzHFkYBfVlDqTF9RPP/ITn6ZB4saCmBRYrHB+IvASTtNod0otq7Yyn7sVHDCHTCHXycqvGEC6hvd4n8kzrncPoiBFSrZTWmRWw0HkJ/3hCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6W/3kD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6W/3kD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540441F000E9;
	Fri,  7 Aug 2026 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786124093;
	bh=Ptr+++5EKa2ZHapwy7s355fyFnv9/rgRCdH2uTfYVDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6W/3kD2nr8o8MHFH2fc0Kc7swTtjwwR7IlL783dBCBTlUaGU/o7DZkxL5EokkMX+
	 NmOYzHyFqSHf9RIqdSqvKp4f5hqbl/5UQ5R6IGhsZ7qXcTGE7fLi+2+untilddX2nq
	 ZmD766lS0GgZVa/9k0nxraQy2N5k5aTjCYxHlet1+rJqDQhWjkFjVDl0cucKOwGUsM
	 IHuzFHYj7ilbcSVGoHOjwv9CJyP61Vyf5rBnlYPmrJu9uyMX1zSRXyuSGAW3xzOHhD
	 uhqPGNdEla9Fq7BJoFV33rDtbhLptbg5P4qmjAzNrl8m+V5DBt7r/UKxTlRZ1rmwPh
	 wrL9VJWLgmY8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807172433.82045-2-amachhiw@linux.ibm.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com>
 <20260807172433.82045-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 17:34:52 +0000
Message-Id: <20260807173453.540441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM_CAP_PPC_COMPAT_CAPS is advertised as supported on pSeries HV K=
VM, but the KVM_PPC_GET_COMPAT_CAPS ioctl backend implementation is missing=
, leading to unconditional -ENOTTY failure.
--

--- Patch [1]: [PATCH v8 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS a=
nd wire up ioctl ---
commit 3fd26ec35303a5e885f7551c23267fe626ae5e16
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl

This commit introduces the KVM_CAP_PPC_COMPAT_CAPS capability and the
KVM_PPC_GET_COMPAT_CAPS ioctl to expose CPU compatibility modes. It routes
the ioctl to a backend-specific get_compat_caps implementation.

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37b..2fe4ea0ca4ff1 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -697,6 +697,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lo=
ng ext)
[ ... ]
> +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> +	case KVM_CAP_PPC_COMPAT_CAPS:
> +		r =3D 0;
> +		if (hv_enabled && kvmhv_on_pseries())
> +			r =3D 1;
> +		break;
> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */

[Severity: High]
Since kvm_vm_ioctl_check_extension() advertises this capability as supported
solely based on platform checks, will userspace expect the ioctl to work?

Looking at the ioctl implementation below, it seems to fail if the backend
is missing. Should this capability check also verify that
kvm->arch.kvm_ops->get_compat_caps is implemented so that it doesn't
advertise a capability the kernel cannot fulfill?

[ ... ]
> @@ -2463,6 +2470,77 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned =
int ioctl, unsigned long arg)
[ ... ]
> +		/* Reserved fields must be zero */
> +		r =3D -EINVAL;
> +		if (host_caps.flags)
> +			goto out;
> +
> +		r =3D -ENOTTY;
> +		if (!kvm->arch.kvm_ops->get_compat_caps)
> +			goto out;
> +
> +		r =3D kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> +		if (r)
> +			goto out;

[Severity: High]
Does this ioctl currently return -ENOTTY on all platforms?

I don't see any backend implementing get_compat_caps in this patch. If
userspace probes KVM_CAP_PPC_COMPAT_CAPS and gets a positive result, won't
it be unexpectedly broken by receiving -ENOTTY when attempting to use the
ioctl?

Would it be safer to introduce the capability advertisement in the same
patch that wires up the actual backend implementation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807172433.8204=
5-1-amachhiw@linux.ibm.com?part=3D1
