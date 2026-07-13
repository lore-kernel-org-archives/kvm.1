Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576D3537CD
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783968178; cv=none; b=XVO8bfW1yG50sYlOajuXO32FlHfg17HVVJxgv8bi8sKTUWarbTTihC+IuMgvmFIreIqxT8INmt+rovunyndmcb53cFCcOh6uRHemb74P6NwLJLPlkYP4hfzkgJ2a/ihMO9brFaUeyCxcBqM52r9ctwmPxagKeuf/pDnXvDo7AT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783968178; c=relaxed/simple;
	bh=1o+Lx13qvdu2g3ZhpBDT9AwSItQSkIyfuW5E7oUOwQ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d5UWkBzI7zaUNvppBUBx9jtVW6ZRgRhazCazp0X4J9Aozhi/JJXEd0RIwRpqJuz31Apt/TF5EYtS97qRe/Sja9x6w/9MG8LTfqd+QOnFyJ5Djq9kA1RCo6ouEQ8Sc0xU/RBXCsF7yLJZMXTBd8Tjz3gwXO/a8/AJI1O0nTy3NSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzg2momK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzg2momK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C181F000E9;
	Mon, 13 Jul 2026 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783968176;
	bh=xIv95M3RGFz5UHiP0o2vgKRHIo1JLRjQJ/vYJRpPHu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gzg2momKpQXPiW657Licw5N4/7OmkCSqw84IyZfhD6skYz8HqohxHh4pJNGzr+lQE
	 BgR4Dy0FGsWcgFjnrdKTeQPea6cT1sjvgOgnGdcmpsPtF6tqT/spT+PAai4ccEn74t
	 psNRyBbLtP8JLSRfDXETEmPBNa1Fd9Est3IjGUFmZUXSJSEIsBZHhvlH4ctEdXwfhW
	 hdIrsRlGk1P9e96augT6rEDcZPkwm8pjTAuF0zQjDDwJvEPEiXvCMvDVg1BVMUgqtV
	 hINJad0kDYyHBH4GLSlhZf/fU3qjWhhAEJvz7AQlv+YK/nu3e3w3wXIQFHn2BDsy9I
	 v72FwTileQdPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] KVM: x86: Disallow EFER.LME and EFER.LMA if long
 mode is not supported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713181020.2735367-3-yosry@kernel.org>
References: <20260713181020.2735367-1-yosry@kernel.org>
 <20260713181020.2735367-3-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 18:42:56 +0000
Message-Id: <20260713184256.82C181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM_SET_SREGS bypasses EFER validation, permitting userspace to se=
t unsupported EFER bits and potentially triggering a host kernel BUG_ON.
--

--- Patch [2]: [PATCH v3 2/5] KVM: x86: Disallow EFER.LME and EFER.LMA if l=
ong mode is not supported ---
commit 804513f9cd9e8710ae3f651192ce52e48ee9e59a
Author: Yosry Ahmed <yosry@kernel.org>

KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported

Remove EFER.LME and EFER.LMA from EFER reserved bits only if long mode
is actually supported.

> KVM does check long-mode support before allowing
> the bits for guest writes and userspace writes through KVM_SET_SREGS*
> (in __kvm_valid_efer()), but userspace writes through KVM_SET_MSRS only
> check reserved bits.

[Severity: High]
This isn't a bug introduced by this patch, but is the claim about
KVM_SET_SREGS* checking __kvm_valid_efer() accurate?

It looks like KVM_SET_SREGS can actually bypass __kvm_valid_efer(). If
userspace invokes the KVM_SET_SREGS ioctl with a crafted sregs structure
where EFER_LME=3D1, EFER_LMA=3D1, CR0.PG=3D1, and CR4.PAE=3D1, this state a=
ppears
to bypass the consistency checks in kvm_is_valid_sregs().

Then, __set_sregs_common() applies the EFER bits directly via the
architecture-specific callback:

arch/x86/kvm/regs.c:__set_sregs_common() {
    ...
    kvm_x86_call(set_efer)(vcpu, sregs->efer);
    ...
}

On a 32-bit KVM host (!CONFIG_X86_64), this call reaches vmx_set_efer(),
which unconditionally triggers a KVM_BUG_ON since long mode is not
supported:

arch/x86/kvm/vmx/vmx.c:vmx_set_efer() {
    ...
    if (KVM_BUG_ON(efer & EFER_LMA, vcpu->kvm))
        return 1;
    ...
}

Additionally, on SVM, bypassing __kvm_valid_efer() allows userspace to set
EFER_SVME and force nested state allocation even when the guest lacks the
X86_FEATURE_SVM capability.

Could this allow a malicious unprivileged userspace process to trigger a
host kernel panic (if panic_on_warn=3D1) by forcing this KVM_BUG_ON?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713181020.2735=
367-1-yosry@kernel.org?part=3D2
