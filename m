Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFA34388E
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939769; cv=none; b=JmluYCAL6kCa7mWyVotiKIPOCwqqqi9CCLJsNL0Vb8MbQYWxXBBd8Jf0hTsqkC4iUcgnan1obSZw+TRhTiFR1XMg3zA/I0oqMrI3jdJGBM57Txx5HQYkXTlU0VgxLSiPPGpaj628W5NtlJ8YRq+Fo5E/thW0f1lhcmsthcSJsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939769; c=relaxed/simple;
	bh=iNvMXVOJH4QcaFNuoag/4Mqlpc0Em31Um3kU3a4m390=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXJbZ+IQ2yBkDxfCunZSgBdUdpWN4alsxZfk5gMXgSmhZAfENBAauD1/Lm/0kRPXSv+5ymOy549N0uztfCQMsZpzu0GjWgNr4CQsX5iby98mlEkMvmx6wnqyw0u8V3w0NYDHciDKWgrcbOxXn1P5vpf5d+OPcrzt20cEwBzE+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TShfYxzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TShfYxzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E049C1F00898;
	Mon,  8 Jun 2026 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780939768;
	bh=mAS2/w7YDYh+leycq8z66RofrtfstWiSjaPrJ2E9XoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TShfYxzRyaNVW7VlHPsMIPmmtSOTjHyiQ8KgYYNkdao7b9yXbx4CkbX5day+hpZN1
	 2VL1/VWiUpIArb7NwgS5dBw+iJSdZa1ZaHC2drACRlCJp1RMaS+ftBMvhJmCQLk5xE
	 oe/MbATojOMflqDoq1u1CG0ZjVcQx4x0dpamTfQ1LlXqdB553K9seO79Fd7WQ5QC9l
	 jWjdn8ACmlxjJD+PLgnTAR9aImUu+YjFCgROyfrz9+o/fE3okt0QwqcQrY9i1ZTUzK
	 RZkBex+vhl6tG2uAjyAdV6SGINmNITxVUgXYSaKUt1a2YcYzDczAnrVdtCy97E0Ykz
	 opGTrwgBL15Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/60] kvm: Implement KVM_CAP_PLANES
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-29-joro@8bytes.org>
References: <20260608144252.351443-29-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:29:27 +0000
Message-Id: <20260608172927.E049C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch references an undeclared capability macro `KVM_CAP_PLANES=
`, which will cause a compilation error.
--

commit d670294e30cc501dff928c57d37434874d9140c2
Author: Paolo Bonzini <pbonzini@redhat.com>

Introduce an architecture call-back to request the VM-specific maximum plan=
es

This introduces a new architecture call-back to request the VM-specific
maximum number of supported planes. It then uses this call-back to implement
the KVM_CAP_PLANES capability check.

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 7a0b632e3ac0..5a0277e2ac7c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5079,6 +5079,10 @@ static int kvm_vm_ioctl_check_extension_generic(st=
ruct kvm *kvm, long arg)
>  	case KVM_CAP_GUEST_MEMFD_FLAGS:
>  		return kvm_gmem_get_supported_flags(kvm);
>  #endif
> +	case KVM_CAP_PLANES:

[Severity: Low]
Is KVM_CAP_PLANES defined in the UAPI headers?=20

I don't see it added to include/uapi/linux/kvm.h in this patch. Will this
cause a build failure due to an undeclared identifier?

> +		if (kvm)
> +			return kvm_arch_max_planes(kvm);
> +		return 1;
>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D28
