Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970E328610
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782516576; cv=none; b=EnjhE48bFlFeEAIc3thN6UFIa3Xggn6DILei0LFoqTwxDXEbxOcH3LTnwaSMRX6MOabA2qHGmwkumOVz4As1HrYQd4eE2HRuSSwasKGOdsqGFjbOuscmOA7P1nbN/MEiXkO87X1hAk/h7rXUZDfxeOgjo/FMtjM7o6lwQXPiPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782516576; c=relaxed/simple;
	bh=wXY5j2xpJIzbHymWJSI3QRQOhXO/xF0oKMZKAXWvHu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0HkRd7z41YJkxg9+viDViXgc7m7dgatFlm8iPJ6qnZHYlVpksg1hdwweFaj+Z+EJmAZPfuNjbV+8Ir+cGj6az7u0NDhWu36SuNS3Or4J30P8R2BIBIKoF4EKwDqeFzoYsbZE/SzqyylZpcPdUIyxaXPK+txQmER+u3CrsxqVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBmabsJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBmabsJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99A11F000E9;
	Fri, 26 Jun 2026 23:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782516575;
	bh=SkQlDtNQOtI4xf4TqPW3RQTP3kR9MPkiwV9/tjE82TM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBmabsJP/FeGkzOhArhrT/k8wTFwVoSLp7nQ7OH6FrAawJUhWbc7kLixr3jgzJvnB
	 wx6CXuIHrK2llRJhq50FOmXfQlQnu/HhsPedMBE42lsuBZRdloLKBnDsl3DLf/US0I
	 5ev8agqephjp7sOgIdkAonN5b3lamqVaaCxAnqT37w10ox1jSL9oJXnwIgr1xtItJb
	 bbt0Qx3ZRfY6wHi9iircgdiI0URKczKwbaKJRDRgsmatmJ0ljjkjIryAbdMYFtaUbz
	 ClPSTYN5wFRo0uH3Nurpzfm7vverMR4rcFjGTJS48mIVBCahokH6d+1DXBE/VXKjAq
	 zjEIFif0Lx/Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into
 "front" and "back" halves
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626231416.3943216-7-seanjc@google.com>
References: <20260626231416.3943216-1-seanjc@google.com>
 <20260626231416.3943216-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 23:29:34 +0000
Message-Id: <20260626232934.D99A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Evaluating `kvm_memslot_flush_zap_all(kvm)` twice in `kvm_arch=
_flush_shadow_memslot()` creates a TOCTOU race window that allows concurren=
t quirk modification to skip the back-half zap, leading to a Use-After-Free=
 of host memory.
--

commit daadba9269f9868eb59f2fe4d2fd49715b55bc67
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves

This commit splits kvm_mmu_zap_all_fast() into a front half (running with
mmu_lock held for write) and a back half (running outside of mmu_lock).
This allows sharing the mmu_lock critical section when zapping in response
to a memslot being deleted or moved.

Cc: stable@vger.kernel.org # 6.12.x

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 223d80b12b9b6..5925db37543f3 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c

[ ... ]

> @@ -7578,14 +7591,19 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kv=
m,
>  	};
>  	bool flush;
> =20
> +	write_lock(&kvm->mmu_lock);
> +
>  	if (kvm_memslot_flush_zap_all(kvm)) {
> -		kvm_mmu_zap_all_fast(kvm);
> +		__kvm_mmu_zap_all_fast_front_half(kvm);
>  	} else {
> -		write_lock(&kvm->mmu_lock);
>  		flush =3D kvm_unmap_gfn_range(kvm, &range);
>  		kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
> -		write_unlock(&kvm->mmu_lock);
>  	}
> +
> +	write_unlock(&kvm->mmu_lock);
> +
> +	if (kvm_memslot_flush_zap_all(kvm))
> +		__kvm_mmu_zap_all_fast_back_half(kvm);
>  }

[Severity: Critical]
Can kvm_memslot_flush_zap_all() evaluate differently on the second check in
kvm_arch_flush_shadow_memslot()?

Since kvm_memslot_flush_zap_all() dynamically checks disabled_quirks, if a
concurrent thread disables KVM_X86_QUIRK_SLOT_ZAP_ALL after the front half
executes but before the back half check:

Thread 1 in kvm_arch_flush_shadow_memslot():
    if (kvm_memslot_flush_zap_all(kvm))
        __kvm_mmu_zap_all_fast_front_half(kvm);
       =20
Thread 2:
    KVM_ENABLE_CAP with KVM_CAP_DISABLE_QUIRKS
    (disables KVM_X86_QUIRK_SLOT_ZAP_ALL)
   =20
Thread 1 resumes:
    if (kvm_memslot_flush_zap_all(kvm))
        // Evaluates to false, skips back half
        __kvm_mmu_zap_all_fast_back_half(kvm);
       =20
Could this skip the back half zap and leave invalidated TDP MMU roots
unzapped? If so, this could lead to a use-after-free because KVM's MMU
notifiers will not find the mapping to zap it when the host frees the memor=
y.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626231416.3943=
216-1-seanjc@google.com?part=3D6
