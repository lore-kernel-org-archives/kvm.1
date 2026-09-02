Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E18320CD1
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392414; cv=none; b=BO1NnGGTRLl5M7SrjjxA0dqylX/Yt1eknYQKoTN4KM+9+QYHYi2cBhO/F4kRa2X4NdZVd30oVDIqD5hTV+o3aizJvcSsulD73CarX449OktVSxtJgI3CBTHITgNqkSmfksFSm3BgOk9oBXedAD1j7YgiQPiCxCW+32uUT3hzTfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392414; c=relaxed/simple;
	bh=mBr1GlFUl6unCGe0+SCW0XGBdhz1aE4PpVCpGIk5I3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P3idWD30Bjmzd2nOR6qk5KImkH3yOj0lQI4DuGIgouYripYe6E29mndiRi/ZT2cgSYBKqECJ4qrIsAUknw+k40DjUrWfaZyuo8pwhbfq59gmVFmVc1urDfViSDAvuDmZyEeQRp6AgZIVDHFf33SgidhcHBajMeDlibZJP9tkkzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5wO41Mh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5wO41Mh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A561F000E9;
	Wed,  2 Sep 2026 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788392403;
	bh=A/gzwfmMhdcHxXQiUk0l/zjDTZcow6DLKYK47zKm29g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5wO41MhDd1z1l2vxNDR6Rrh8nx2brNPuw8DqlA/SaVmLyQqN2M8N0+FJJ5Db++Ta
	 jtqGzHXGfICU95x3LoH6+uUMZApgiKLIcl5epaKYDp1Uh1F9htgusuUeOwdhXvvJ8b
	 Fod7nym4u8y/JJ+TLxaK5+3JSRNafb0NFkEULCcgZfJLixLBotCf1N8tZ4jMZt7mGw
	 1W7Xhplsr/aWrRbOkQbFNe2S9QJ/q9qX+PBnLEdS/drmhJ6+pIxKH/K8l0iJq20938
	 IJAoKowUHwXabrJt3oPYu1CU6aNNXV1bQmowtyecFgFvkYPOETTQ2cI6ISHea/iZrq
	 khQKg4cD17BIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when
 preparing L2 state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902232028.2767071-3-seanjc@google.com>
References: <20260902232028.2767071-1-seanjc@google.com>
 <20260902232028.2767071-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 23:40:03 +0000
Message-Id: <20260902234003.B3A561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch incompletely mimics VMRUN hardware behavior for EFER.LMA=
, allowing a malicious guest to desynchronize KVM's MMU state from the phys=
ical CPU. While the patch forces EFER.LMA=3D0 when EFER.LME=3D0, it fails t=
o set EFER.LMA=3D1 when EFER.LME=3D1 and CR0.PG=3D1.
--

commit 0061c7315461e9b92e5efb9b382e2eecda3b30bb
Author: Sean Christopherson <seanjc@google.com>

KVM: nSVM: Ignore EFER.LMA if EFER.LME=3D0 when preparing L2 state

This commit forces EFER.LMA=3D0 if EFER.LME=3D0 when preparing L2 state for
VMRUN, mimicking hardware behavior. It addresses issues in MMU code that
key off EFER.LMA when determining whether to emulate 4/5-level paging
versus PAE paging.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 49fb10ad1f9f6..23d29597d6bf2 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -789,6 +789,10 @@ static void nested_vmcb02_prepare_save(struct vcpu_s=
vm *svm)
> =20
>  	kvm_set_rflags(vcpu, save->rflags | X86_EFLAGS_FIXED);
> =20
> +	/* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing VMRUN). */
> +	if (!(svm->nested.save.efer & EFER_LME))
> +		svm->nested.save.efer &=3D ~EFER_LMA;
> +
>  	svm_set_efer(vcpu, svm->nested.save.efer);
> =20
>  	svm_set_cr0(vcpu, svm->nested.save.cr0);

[Severity: High]
This is a pre-existing issue, but does this logic only implement half of the
hardware VMRUN rule?=20

While this correctly fixes the invariant for EFER.LME=3D0, could a malicious
guest desynchronize KVM's MMU state from the physical CPU when EFER.LME=3D1?

If an L1 guest creates a VMCB12 with EFER.LME=3D1, CR0.PG=3D1, but EFER.LMA=
=3D0,
and executes VMRUN, nested_vmcb02_prepare_save() skips the LMA update
because LME=3D1, passing LMA=3D0 to svm_set_efer().

Then, when we reach svm_set_cr0(), it fails to correct EFER.LMA because it
expects an edge transition (!is_paging(vcpu)), which is always false since
L1 must already be paging to execute VMRUN:

arch/x86/kvm/svm/svm.c:svm_set_cr0() {
    ...
    if (vcpu->arch.efer & EFER_LME) {
        if (!is_paging(vcpu) && (cr0 & X86_CR0_PG)) {
            vcpu->arch.efer |=3D EFER_LMA;
    ...
}

Would this allow the guest to trick KVM's instruction emulator into fetching
arbitrary instructions from a different physical page than what the guest
actually executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902232028.2767=
071-1-seanjc@google.com?part=3D2
