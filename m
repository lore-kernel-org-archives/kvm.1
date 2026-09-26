Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51D331EBA
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790401366; cv=none; b=DUs8NRHxlsiqrvbscK49GkQ7331jDOolucTeiCoc1SHZX4qQWSFJVr3M4zIvcYNBIDsfCaakx7h/pjIg7ElazLOCn90xtJ8E2wyeYacLU+/+DP07nUi3r9STviwNLUC4VlqOHh2NqnR7OpE2jy1vfEfLs+1/MYbCyLpZ/oEtdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790401366; c=relaxed/simple;
	bh=T/EDwSqyNSgs61PdX7X+nkNKsYuhX+sEv78xhdsThyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0MBJqIR/hVOkBfSrAPKpJsGpMF18Ziyz2Js4oB3WQeWOam1TIB10AiCp5vegY6vAvaLegT5mlztZ3Bww/ItmsAZw0VZOJnirLSk0YsDwUyiE+aGpQ36P5DFK7Xk9FpK2j4kQ0h3bQseAvVf/4dei3YYbUvPrxmSIWj6WIL/Q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpjZMwv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpjZMwv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063B41F000FF;
	Sat, 26 Sep 2026 05:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790401365;
	bh=mFWv3wmThY0Bwsy8GCdj630qTfD7tfMsfDCT+F9zkC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YpjZMwv8MAcV9W5cb4pem+XgyOwzluu7h4KbnYfu/5c57i9E+Umj1p0uKiBnaZ3Wl
	 hmbUKJG3Uo9G77EokF0EOkYdvXlPqNiFDe3L/Crd7XFbSe/dM1Cr0twVAchyrnH5+u
	 e4iDY8gLed6ODjFHqHXYfcLZn+lQ7vfbd3AhikYTQ1iBL2shCkEsJtzK/qtkTWLDbr
	 +5pUDP2nMyQKe8UIfWL4VDwRbqnJ3wrQHhY/XAAI1CJGuIoWpckVn6SPJTiGF62TgN
	 PepxPAXe/8M6QpSYmfzJ1gGAtprGERTZFn/Gt1MGjTJpm6sHqB5tqmgHirMG/sVGgU
	 vZPSBXMwoSV3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] KVM: SVM: Use the active VMCB's MSR bitmap when
 checking if MSR is intercepted
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260926053253.195597-6-pbonzini@redhat.com>
References: <20260926053253.195597-1-pbonzini@redhat.com>
 <20260926053253.195597-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:42:44 +0000
Message-Id: <20260926054245.063B41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: svm: invalid pointer dereference in msr_write_intercepted=
 due to SME/SEV C-bit
--

commit 043abbaa7ab3cef236605eca71fa3da8b7711f0e
Author: Sean Christopherson <seanjc@google.com>

KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercep=
ted

This commit modifies KVM to use the MSR permission bitmap of the active VMCB
instead of maintaining separate tracking logic. It dynamically calculates t=
he
virtual address of the bitmap from the physical address stored in the VMCB
control area using __va().

Message-ID: <20260826195833.844526-1-seanjc@google.com>

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f4f488328ea42..1f279cd91ecfb 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -673,16 +673,7 @@ static void clr_dr_intercepts(struct vcpu_svm *svm)
> =20
>  static bool msr_write_intercepted(struct vcpu_svm *svm, u32 msr)
>  {
[ ... ]
> -	void *msrpm =3D is_guest_mode(&svm->vcpu) ? svm->nested.msrpm : svm->ms=
rpm;
> +	void *msrpm =3D __va(svm->vmcb->control.msrpm_base_pa);

[Severity: Critical]
Does this introduce an invalid pointer dereference when SME or SEV is activ=
e?

When Secure Memory Encryption (SME) or Secure Encrypted Virtualization (SEV)
is enabled, physical addresses programmed into hardware structures must
include the encryption bit (C-bit). KVM enforces this by setting the bit
when populating svm->vmcb->control.msrpm_base_pa.

Since __va() on x86 directly adds PAGE_OFFSET to the physical address
without masking out the encryption C-bit, passing the raw physical address
here appears to create an out-of-bounds virtual address. When
svm_test_msr_bitmap_write() immediately dereferences this address, won't
it cause a host panic via a kernel page fault (#PF or #GP)?

Because msr_write_intercepted() is called during VM execution paths, could
a local user with /dev/kvm privileges trigger this to cause a denial of
service on SME/SEV-enabled hardware?

(Note: This issue appears to remain unfixed in the final state of the patch
series at commit 497a001eb419947b).

> =20
>  	return svm_test_msr_bitmap_write(msrpm, msr);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926053253.1955=
97-1-pbonzini@redhat.com?part=3D5
