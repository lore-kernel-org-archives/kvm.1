Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7DD23E320
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917892; cv=none; b=PVcEAgN2aeLT0BZFsuVJoJPF06xf65Yzelz9Z7wy3m/rhn4f/gVSezdkJG7qdA0N6ssIC6If8wNWWn8L9fRj4UbKERXt9SaiDC6E7lh10jq37vmmkk6XrPXH5Ae4TSI1mTnIa1QYET7P45tqSnOBXdTZMwfrUb0eYfd9Mkb/MEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917892; c=relaxed/simple;
	bh=87clDt5ueg9mS5UsH7R1D3qbN7LiTNe3lt+HlxSdZxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mGshPUVymkt4EHX6opaMCzOfmcG9DAA4cl/iXdzMF5K4Npoj25LdTSD1kBpZt/TpbgE+gMCjfQyCz8kfHhx3MFVDepz8Km2ZLRCcYOzHIuEGFa3OAstFmIULu4kmmObLCEubpHfHZBxdmXlK5Z8ZiBjSHdpTLNc6z19YdNhFqs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3IIf7qa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3IIf7qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C02E1F000E9;
	Wed,  1 Jul 2026 14:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917891;
	bh=K+B6G8nJk75N/dUoOnZ64yE6jGlgOBg/r4JM91HVfk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3IIf7qasxb/xYhjszSRw84l9VtKRyP/VRr4elNcULjaZV3fAkXuMQuNURfTwaKUq
	 I7e+x98TY4xRy0F814xasSKc2Y5rEfO02Xmibu/lvZO6k3rIWb4CHyIB2kwzAJuqX8
	 hipr9VWxGFvt7uGPpFagBrlXdOKB3VbftMhQP1UwLmZuJLxjOayMfdTRviBc8GjT4y
	 d5QcCT6QTCYIdFpxZDoZPX8Njb5YeH2vc0fnTFcW47MnJnK+q0he8b5FgFYYF16og8
	 Hk/EWeIPRRniFA8b41OJsDTNRg1hAh06Tyf0IQUNgsHC3BXWgCwNjJS6TtPMFDkmxQ
	 +gOcAzT3X0nIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pankaj Gupta" <pankaj.gupta@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701144543.39582-1-pankaj.gupta@amd.com>
References: <20260701144543.39582-1-pankaj.gupta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:58:09 +0000
Message-Id: <20260701145810.9C02E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping FOLL_LONGTERM creates a silent long-term pin, bypassing G=
UP safety checks for file-backed mappings and breaking CMA isolation for an=
onymous RAM.

Pre-existing issues:
- [Critical] Data race and unprotected state modification on `mirror->enc_c=
ontext_owner` during SEV VM migration leads to list corruption and Use-Afte=
r-Free.
--

commit a611d4c7ad0ddfba6a16536a997563da04d1672f
Author: Pankaj Gupta <pankaj.gupta@amd.com>

KVM: SEV: drop FOLL_LONGTERM for encrypted region registration

This commit removes the FOLL_LONGTERM flag from sev_pin_memory() when
registering encrypted memory regions. This aims to restore virtio-pmem
compatibility by allowing GUP to succeed on file-backed host mappings.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 74fb15551e83f..053b59068b580 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -2751,7 +2751,7 @@ int sev_mem_enc_register_region(struct kvm *kvm,
>  		return -ENOMEM;
> =20
>  	region->pages =3D sev_pin_memory(kvm, range->addr, range->size, &region=
->npages,
> -				       FOLL_WRITE | FOLL_LONGTERM);
> +				       FOLL_WRITE);

[Severity: High]
Does removing FOLL_LONGTERM here create a silent long-term pin?

By dropping FOLL_LONGTERM, it appears we bypass GUP safety checks for
file-backed mappings and break CMA isolation for anonymous RAM. This could
allow guest VMs to permanently pin movable pages, leading to CMA allocation
failures and breaking memory hot-unplug.

For file-backed mappings, could this cause filesystem operations like
truncate() to loop indefinitely waiting for page refcounts to drop?


[Severity: Critical]
This is a pre-existing issue, but is there a data race on
mirror->enc_context_owner during SEV VM migration?

Looking at sev_migrate_from(), it updates mirror->enc_context_owner without
synchronization with concurrent readers. If a mirror VM is destroyed via
sev_vm_destroy() concurrently with its owner being migrated, it can read
the old owner_kvm pointer locklessly:

arch/x86/kvm/svm/sev.c:sev_vm_destroy() {
...
		struct kvm *owner_kvm =3D sev->enc_context_owner;

		mutex_lock(&owner_kvm->lock);
		list_del(&sev->mirror_entry);
		mutex_unlock(&owner_kvm->lock);
		kvm_put_kvm(owner_kvm);
...
}

Could this block on the old source KVM lock while the migration thread moves
the mirror to the new destination KVM list?

When the migration thread releases the lock, sev_vm_destroy() would wake up,
attempt to delete the mirror from the list (corrupting the destination KVM
list), and incorrectly drop a second reference to the source KVM, causing a
use-after-free regression.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701144543.3958=
2-1-pankaj.gupta@amd.com?part=3D1
