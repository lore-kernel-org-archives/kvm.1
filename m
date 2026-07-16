Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF02F3C3E
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227201; cv=none; b=Q8eL+UPYiU/1Y8/006131DvGoyC6XIoasabO4nB7wqI2+JsYDhMZuXUNZmFL6mPZ4ZaAT4/sKyWqJbQ9uUCNOjjUootQihJXuU8+3/+bEYsBL9wJKEcalVQmAryESWtnJ3wzldr+DpqDfOtU3RX+KAq0vpo57X+otWrCq956zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227201; c=relaxed/simple;
	bh=gtntDMvbJJ40vGpNo+oxYTALGel+rOJJxeyKLpQR5PM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sdurRO8aVOZ1afhtfYMhfIW3PvtqJnv588mEYUbdgBlYc3YK1rAevQ+9GJqbu640qFL3X6oS+Ne+ASGdl4aPsTU4gfiAU/D3VmkUhP9ydc+5IoP66g2CDQokHVeCB4Fa22RIZJIYhW9xGxnfNq5T3rQbQGElucc4qKSI0DubVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGJmmJ68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGJmmJ68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DC61F000E9;
	Thu, 16 Jul 2026 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227199;
	bh=ImMH9pqOBc1WoJVt8oTxmWDxWL1RkLNhuo4YZ+cxbsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lGJmmJ68Xin3WYmVWsWd1BwhHByxLWlhermYiq+q764VkWaCInbYxbtE9VZWWkNnW
	 RaUL8XwgbyuRaiaWpedhLDUXyQDfM/6+pdKqYWHM42HpRGVHlGc77vYMDIjCiZMMbx
	 HfSnd2kikCnWGE+gEotF0KCADwgfy/zujkm0fWOTLa8bPs626MPyE1O9Kz/wmRBXC3
	 sbssfUYaodqplrvMSu8IJ6pTI6wRRmcrn2kuSPQXjuHqdoum+F+di3tyRqXmbd2uUF
	 WYcwMe3/twH8kiARvAJchj6sDd2cbsSiI9vREa3yAee0d1l5mIk3X5Aroudx3M7kxh
	 PhCjjTQakBVZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/24] KVM: x86/mmu: Extend map_writable to a full ACC_*
 mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-6-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:39:58 +0000
Message-Id: <20260716183959.65DC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Generic bitwise masking of `pte_access` with `host_access` fails=
 to clear the user-mode execution bit on EPT, allowing the guest user-mode =
to execute host-restricted non-executable mappings.
--

--- Patch [5]: [PATCH 05/24] KVM: x86/mmu: Extend map_writable to a full AC=
C_* mask ---
commit fbce49ecd47269b3bd1cd08c8c69aaddfb1e0d62
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: Extend map_writable to a full ACC_* mask

This commit updates KVM page fault structures to use a full ACC_* mask
instead of a boolean map_writable field. This prepares the MMU to support
non-executable mappings from memory protection attributes, simplifying
make_spte() by directly passing the host_access mask.

> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c

[ ... ]

> @@ -206,6 +206,11 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu=
_page *sp,
>  	if (!prefetch || synchronizing)
>  		spte |=3D shadow_accessed_mask;
> =20
> +	if (host_access & ACC_WRITE_MASK)
> +		spte |=3D shadow_host_writable_mask;
> +
> +	pte_access &=3D host_access;
> +

[Severity: Medium]
Will this bitwise AND logic inadvertently allow guest user-mode execution of
non-executable mappings on EPT?

Because ACC_USER_EXEC_MASK aliases ACC_USER_MASK in KVM, a host_access mask
that clears ACC_EXEC_MASK but retains ACC_USER_MASK (to permit guest
user-mode data accesses) will fail to clear ACC_USER_EXEC_MASK here.

When execution reaches the non-executable handling later in make_spte():

    } else {
        if (pte_access & ACC_EXEC_MASK)
            spte |=3D shadow_xs_mask;
        if (pte_access & ACC_USER_EXEC_MASK)
            spte |=3D shadow_xu_mask;
    }

Could this result in shadow_xu_mask being set, inadvertently granting guest
user-mode execution despite the host_access restriction when Mode-Based
Execute Control (MBEC) is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D5
