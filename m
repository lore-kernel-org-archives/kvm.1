Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFEF214812
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369160; cv=none; b=DepJ/TtBNYdtZu3nEFrI28+CWIGWCGsfZ6e3Q0Zc1nlG3uVCA5w8cWygrShCqkzFxbCsbCk03mDthPRiqjT4yBQu1O2n61r+bpgQYEDiutcfg3fxeX/jZfu+lYfqdDsZWm+ZJzDDwtkc0ZXW8PqfvVzDokie1bwC6TyFpUjfPwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369160; c=relaxed/simple;
	bh=nyV6z64g+Qk7jB/rlBoXcX4ah3nX0B7i/JsL66CIfNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c1jDIoleYaGamZRW7voUbHOQd4Hr4lej0BvvjijQVuPPB8xEdDpRMxHKJQr9Y2eOFR7HJUbdvsZCiN4lP5yEGVZtPJgzI1LGH2858RrfMlp/Bu1E1PCZswdIFmSd2437ZySWaHO0Stq7N0FXabRZ8y0+JIsZVtbFkGEB0yMZWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws0qJinH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws0qJinH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6576A1F000E9;
	Wed, 29 Jul 2026 23:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369158;
	bh=o2QpDtuGyeKtQzGOp6SGNT3Jr1lpzcQZSRkuorpIIGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ws0qJinHBBEY0zoY8/DLhww6mN+LPKS8MvbUtzxBUrNSClsXXreqfF/pd6LdQnkB5
	 +J6vDfm4uMnJ/VD9fkd6ZywiFUy/4udJkdWnOxo6ewgjcopekXNjKLWTLH884W8Kwo
	 rScmhfUJBpLhhhkv3raaoGztyJFl9pUyYZ7iNITaQEAu9c7kr+j+9olIkD/rWueJv+
	 Zuax/toRBNKxwkytCFhzX8bgnHd25nq+d4XQv/Scr64GjTt8PVSwVBfofmZbawOqg9
	 QFrKd6Cm6AUly1lIfJ+Uir8jxx9KAk1SgiKWnW3c/COzK9eut1iy0l/IeT9XI3d60s
	 IeA1eb8Ed/geQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] RISC-V: KVM: Add SBI FWFT validation support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729232527.139183-3-inochiama@gmail.com>
References: <20260729232527.139183-1-inochiama@gmail.com>
 <20260729232527.139183-3-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 23:52:37 +0000
Message-Id: <20260729235238.6576A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The FWFT SBI extension defaults to enabled, breaking live migratio=
n and violating KVM ABI guidelines.
--

--- Patch [2]: [PATCH v3 2/4] RISC-V: KVM: Add SBI FWFT validation support =
---
commit 9a4432f98b4fe06897baf4b85a503109a0f2b7f8
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Add SBI FWFT validation support

This commit implements extension parameters validation support for the KVM
SBI FWFT extension.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 1342adb3180c6..2794e9e5b495e 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c

[ ... ]

> @@ -574,6 +598,7 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft=
 =3D {
>  	.init =3D kvm_sbi_ext_fwft_init,
>  	.deinit =3D kvm_sbi_ext_fwft_deinit,
>  	.reset =3D kvm_sbi_ext_fwft_reset,
> +	.validate =3D kvm_sbi_ext_fwft_validate,
[Severity: High]
This isn't a bug introduced by this patch, but does this extension default
to enabled because it lacks the .default_disabled =3D true flag in this
struct?

If an older userspace creates a VM on a new kernel with the FWFT extension,
the kernel silently exposes this capability to the guest. If the guest uses
this feature and is subsequently live-migrated to an older kernel that
lacks FWFT support, will the migration silently fail when the extension
unexpectedly disappears?

Could we add .default_disabled =3D true to vcpu_sbi_ext_fwft to ensure prop=
er
capability negotiation?

>  	.state_reg_subtype =3D KVM_REG_RISCV_SBI_FWFT,
>  	.get_state_reg_count =3D kvm_sbi_ext_fwft_get_reg_count,
>  	.get_state_reg_id =3D kvm_sbi_ext_fwft_get_reg_id,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729232527.1391=
83-1-inochiama@gmail.com?part=3D2
