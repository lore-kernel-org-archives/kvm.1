Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BEB3A874B
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953734; cv=none; b=pPG9kEy61moPblkfpXQVKkOnxbCIEG4WD4SwUrvpne1WTahuE1GW4s+NTNqNrlx3sXIKbVrAasnCDm1lRuRKTmEIaHriXFEPR0/wTws/okeqHs6CfHcNnYIZKvzWYqZJNXVUaIIe068w6CbLyyS/vE/qjVwOEZKvjlXUffAi5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953734; c=relaxed/simple;
	bh=2gnO9UqHbMdRcgpnGslxvRrPyZLdTD+CuYj3dUNjvuI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eNjYZ4PUrVQws1fvkFLASSceaGRF5R8KhTWSv+eAHsFwQSMVGlORoXQuxfuBZCfp5e0aix0o7ha/3bjuOSUxP8QMbznIO47Lr0AM/khFYAhGFnNi8VUPsUy/ZOVDf2nB84q/OPLcqqQiub9O18KSvjWlXgd/Kgs9+Yy1CgkbVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORXXESX5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORXXESX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4724C1F00893;
	Mon,  8 Jun 2026 21:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780953733;
	bh=Sqf/iaRoCrRZyPnAs7dkJ7Ec1IL1boOWa5UFMxb8u9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORXXESX5K2ucyo+MuPQ0B8gAi3+kBG7VOgBeIZiVz4z5hHKmrst1bv38zaktMCmFT
	 VLGkUO3PvsFkTqoqCSvL0huZEc+OgCTbKfLQBCZqtqU6qUafjpCqD+qyvaTLha70wO
	 bry33uX68e1uOk4/S3fgjgCqVK/iMWjtM4+77zusWwp5NqPRJm8iyUcZ6vzLXNM5Le
	 CuCSznGBWTlwm3eR2PybOfnV3Ae+foTQZ5LI+ffUHbusz0t6GodmL0i+uj/336Q3/f
	 PXloyzd0YJAPo9Nse+Id4bIE6Zasoel3J5dRLGEMF9QSZS4pWNDu+IpDrN2vZTbimj
	 0r2BcbGRBp74w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 48/60] kvm: x86: Make event injection VCPU requests
 per-plane
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-49-joro@8bytes.org>
References: <20260608144252.351443-49-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 21:22:12 +0000
Message-Id: <20260608212213.4724C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The macro `KVM_ARCH_PLANE_REQ` is used but never defined, resulting=
 in a build failure.
--

commit 3e3f06e3097218de739505c72c2090c73bad04da
Author: Joerg Roedel <joerg.roedel@amd.com>
Subject: KVM: x86: Handle events on the plane-vcpu

This commit modifies the KVM x86 vcpu request macros to handle certain
events on the plane-vcpu. It changes several request definitions to use a
new macro.

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -85,20 +85,20 @@
>  						 KVM_X86_NOTIFY_VMEXIT_USER)
> =20
>  /* x86-specific vcpu->requests bit members */
> -#define KVM_REQ_MIGRATE_TIMER		KVM_ARCH_REQ(0)
> +#define KVM_REQ_MIGRATE_TIMER		KVM_ARCH_PLANE_REQ(0)

[Severity: Low]
Is KVM_ARCH_PLANE_REQ missing its definition? It appears this macro is not
defined in this patch or the baseline codebase, which results in a build=20
failure when these requests are evaluated.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D48
