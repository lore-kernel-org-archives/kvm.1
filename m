Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BB377AB9
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923701; cv=none; b=O64cI2DFUShNr6UhhIIS4jEj0rIU6Gh0wFB/u2rd7s5qFMcmX5RStjFvhhvrBnnPBw4fW9Ip/uT4+Bl52hjoYOUhPbDHbZo/ldhyeHaqwzHqTvQ9nfqvsfYq6bR5SpQY5Egmk10v0nZjSh2OqVH6wGPzsKnoigKhGcKH9iI57ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923701; c=relaxed/simple;
	bh=e5CsOBQhSnoc7zIYj7nrwtUYVVOm9skjoXq/LcPeHU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TxODu1n0tW1MT9/7OiuErAUk6xwPDbM3WBoZmeAl74VfHLieRQZDY0xuz7ctSzgJArH5c9OtBQJ4zgQ0sXTjjwUrWUfoFUlc2odwk146FDxfgT6MDJo7Rnp4V9Jmgum7h6aCSMYfwvVPmnQp2OwnLvJqzVWpNtIzOa9iFjPOrFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mef2tsDo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mef2tsDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D22F1F000E9;
	Fri, 24 Jul 2026 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784923699;
	bh=0ZHnhgTzKNaL5WwFxvl2SiC2vPFpHBtPFBaPmjIVoEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mef2tsDomtff9pc24bEl372sMvGxcevvBJEFyT4CPa5M6WrSQWf+D/ukaJn4cMXlq
	 bu4VEiyITn4JQeqXwxQu+9rZVpiB266MLpQNlBPNg5/PLs4/2e9GxHWMQZLF/qTqgB
	 Gv1sFqX83p7Fs/1E+vWG+POwyc4ViTejXjPz7aPPGala8JcdfPM5T5I+z3/MFkQHBT
	 O4w8ANR7Cb7SUMinKEUDrE7dSk7Pzt/hrSuKlDVST4v27nvqMlTYqUFsMgfIHqyAai
	 QKltBQw7vzwWK1zeBsM/7z6FAsqmak08txG11z/Gpm4CKKBTWnRvF6bCxRVEf4hOfe
	 kwOerP38A6Kcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] KVM: SVM: Add VMCB fields for LBR v2 virtualization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260724195040.630468-2-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
 <20260724195040.630468-2-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 20:08:19 +0000
Message-Id: <20260724200819.9D22F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `svm_get_nested_state` function writes out-of-bounds to usersp=
ace memory if `user_data_size` is exactly `sizeof(struct kvm_nested_state)`.
--

--- Patch [1]: [PATCH 1/7] KVM: SVM: Add VMCB fields for LBR v2 virtualizat=
ion ---
commit 91df21ca3dd4f3f8277b9ddd8eb84059e0bca6d1
Author: Sandipan Das <sandipan.das@amd.com>

KVM: SVM: Add VMCB fields for LBR v2 virtualization

Define the new VMCB fields that will be used to save and restore the
state of the Last Branch Record Extension Version 2 (LbrExtV2) related
MSRs.

> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index aa63431ba92c3..fbcf6c4dbb92a 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -552,7 +559,7 @@ struct vmcb {
>  	};
>  } __packed;
> =20
> -#define EXPECTED_VMCB_SAVE_AREA_SIZE		744
> +#define EXPECTED_VMCB_SAVE_AREA_SIZE		1912
>  #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
>  #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648

[ ... ]

[Severity: High]
This is a pre-existing issue, but can svm_get_nested_state() write
out-of-bounds to userspace memory if user_data_size is exactly
sizeof(struct kvm_nested_state)?

When user_data_size =3D=3D kvm_state.size, this initial check evaluates to =
false:

arch/x86/kvm/svm/nested.c:svm_get_nested_state() {
    ...
	if (user_data_size < kvm_state.size)
		goto out;
    ...
}

The function then proceeds, expanding kvm_state.size, but never re-checks if
the user-provided buffer is large enough before clearing the memory:

arch/x86/kvm/svm/nested.c:svm_get_nested_state() {
    ...
	if (clear_user(user_vmcb, KVM_STATE_NESTED_SVM_VMCB_SIZE))
		return -EFAULT;
    ...
}

Can this corrupt the VMM's memory by writing 4096 bytes past the end of the
user's 120-byte allocation if a VMM dynamically probes the required size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724195040.6304=
68-1-shivansh.dhiman@amd.com?part=3D1
