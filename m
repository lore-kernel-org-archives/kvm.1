Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C9B37F00D
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426304; cv=none; b=c5QIVTeNDbFByHVsp/658f0qc9wAkP4p5mSX45Mf4bAOR/++NecpPMHvleU092oskseUNki9uNtfVVnFETVb8sGCau7LZr+lh0EFbdd/VfJWp8vwrjPj0fZ9iT2ijKtTFfwcTssuRk1RBM+7FXjB6Mk2tU+Z2K31mUVC1ec0Tzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426304; c=relaxed/simple;
	bh=EkAMPfgN9lrnfmC3aVH0UKMXqzPv+zvsOK5fBgXiSh4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tejg2ZPNV4DVM1YGnXClkbQqGksORnUfhuLt8FKkJJumqv1PbTJ43VnT2LagMXVDG6TMpZRTGW8gHK7MSo/EpTIYwrNp/k3ReJGyqSQqvk9c916psWO1z8ig0D8Gzq5hloFF694lSVv2MVSrtdFzMVWWGeEJ8/kmBrXTpOEiVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmE6laUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmE6laUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB891F000E9;
	Thu, 25 Jun 2026 22:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782426303;
	bh=uN7r3mbdLK2r5vrilBz4dU/BORL9waMKxKCpk81OB1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AmE6laUv3TQtCP6sTK04tI21fmtzdzqSKBOJA7uTW8lT4QlMRIbIqlNuceIF7rtMh
	 v0791jTPVLHp0Ek5XP1owadsaA4tk4G/gFEPOUpRK4gu5ov/x3boQcT+ebcRuY+ZQe
	 W6dtT5N0IaupqRAURT/ZF5u32ku2wXKJhLfQCNfIwmRgOvMg2RLtif1QbjYJudqf65
	 0Wa0pEHSUz0BCEB7NHR6f2QrWTJ9ErU7KkyPAja2nQJv3ot2z3mPdsVr4KeSIXP7oG
	 YhbJxMGy0qU/esIJNEcRJxh6sDCUFP17aE4go6EMq+QiCGVDjDeCe2iD3PWsEYUmyo
	 bNc+zx/STQxhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: SVM: Drop unnecessary avic_vm_destroy() call
 on init failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625220933.3357733-3-seanjc@google.com>
References: <20260625220933.3357733-1-seanjc@google.com>
 <20260625220933.3357733-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:25:02 +0000
Message-Id: <20260625222503.6BB891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free (UAF) due to missing `hash_del` in `kvm_create_=
vm` error path.
--

commit e695b91eb85c201025f5666d103667275ead16a1
Author: Sean Christopherson <seanjc@google.com>

KVM: SVM: Drop unnecessary avic_vm_destroy() call on init failure

This commit removes the avic_vm_destroy() call from the error path of
avic_vm_init(), since the physical ID table is now allocated on demand
during vCPU creation.

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
[ ... ]
> @@ -367,10 +366,6 @@ int avic_vm_init(struct kvm *kvm)
>  	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
> =20
>  	return 0;

[Severity: Critical]
This is a pre-existing issue, but could the error path in kvm_create_vm()
leave a freed kvm_svm node in the svm_vm_data_hash?

If kvm_create_vm() fails after calling kvm_arch_init_vm() (for example,
during kvm_create_vm_debugfs()), it handles the error by jumping to
the cleanup path and calling kvm_arch_destroy_vm().

However, this error path seems to bypass kvm_arch_pre_destroy_vm(), which
is where the hash node is normally removed:

avic_vm_pre_destroy() {
    ...
    hash_del(&to_kvm_svm(kvm)->hnode);
}

Since kvm_arch_free_vm() will then free the kvm structure, does this
leave a dangling pointer in the global hash table that could trigger a
use-after-free during subsequent VM creations or traversals?

> -
> -free_avic:
> -	avic_vm_destroy(kvm);
> -	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625220933.3357=
733-1-seanjc@google.com?part=3D2
