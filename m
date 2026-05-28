Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED82F5468
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985199; cv=none; b=pEy7CKj5fDalXx0J4/RYU7Q5sU7vVHD4U8dCiJO6VobIjfLVQfiuu0OKZh4pVVK9y2HRvekeBrD/yID7+nQJc3WtoNrtj+qZ+whxXM7CwKmwX17nLgWf2UQUP6LBv9VPMgUlFRCmHY1Om5N7pMtT0jhr8x+L2fkJTyv/E/wiJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985199; c=relaxed/simple;
	bh=maT/bYPvH9gHKLCXpbtiqal+R2D4WfgQQsYjuVFGdVY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KSIbugQWH1/nd/cZjmXsuWmDKYb++qtlbqvKtCeCJzhde5gdkEMejKLNKBAmvEgmiealWr90HR6lNjcbkPNgunY07Kzg5u72lR4mZ1WPRv3XGXrK1WDZdi4GU6Bl+5LdWGZYkW33i4Z2DKzfxTPRgPRDA4I1gNj+7gNdPxTsuaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0ZcQrx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0ZcQrx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295FA1F000E9;
	Thu, 28 May 2026 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779985198;
	bh=fCeKi28WsHpaSohtK+d697LhmVSGSKW9cZE3DmE8sP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k0ZcQrx6FDhz11/iwFh2+vKL0W+UOLMjw7NiXHHaG6xKEjgLjIlJiBqsJ4ya3QfE2
	 s8UetEU6XWEOR4VEbKvAsrrVVgtoU9quQvvsj2jGlU+o7vFFuTrM+oy5didqeUUvG9
	 jq5UIPfikMLG911HGrUPv/DWnREQD0OTyOgth0hFJGXzYGgn06rKT5zUOwPS+vYano
	 7Eanvcn71t17ZJa6zBkxW9d4FObn7+Mfh904QuNrwxEAs9escDmN3YACH5//chdTNW
	 WzwXdNBfaM6DynPf/A9m8VVN8rwuDHpWrQG055eHTQf8dxNHv2IJQuNL80q/Q5bfNG
	 M/9UX4QhkvHHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] KVM/x86: Return -errno instead of "1" for common
 MSR emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528113605.267111-7-jgross@suse.com>
References: <20260528113605.267111-7-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 16:19:57 +0000
Message-Id: <20260528161958.295FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing the return value 1 with -EINVAL (and other negative errn=
os) in MSR emulation functions breaks KVM's #GP injection semantics, causin=
g the VM to exit to userspace and crash on invalid MSR accesses.
--

commit 7cd01aeef050808bb174c0f9c10b5858a36dd08a
Author: Juergen Gross <jgross@suse.com>

KVM/x86: Return -errno instead of "1" for common MSR emulation
   =20
Instead of a literal "1" for signalling an error, use a negative errno
value in the common emulation code of MSR registers.

> diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
> --- a/arch/x86/kvm/mtrr.c
> +++ b/arch/x86/kvm/mtrr.c
> @@ -99,10 +99,10 @@ int kvm_mtrr_set_msr(struct kvm_vcpu *vcpu, u32 msr, =
u64 data)
> =20
>  	mtrr =3D find_mtrr(vcpu, msr);
>  	if (!mtrr)
> -		return 1;
> +		return -EINVAL;

[Severity: High]
Does returning a negative errno instead of 1 break KVM's guest fault inject=
ion
semantics?

In KVM's x86 MSR emulation framework, such as __kvm_emulate_wrmsr() and
__kvm_emulate_rdmsr(), the return value 1 is used to signal that a guest
level fault (#GP) should be injected via kvm_complete_insn_gp().

Negative return codes like -EINVAL bypass this fault injection. The code in
__kvm_emulate_wrmsr() propagates negative values up the call stack to
kvm_arch_vcpu_ioctl_run(). This causes the KVM_RUN ioctl to return -EINVAL =
to
userspace, which typically responds by fatally aborting the VM.

Similarly, the instruction emulator translates negative returns into
X86EMUL_UNHANDLEABLE, leading to handle_emulation_failure() which also forc=
es
a userspace exit instead of propagating a graceful guest fault.

Can this allow a guest OS to trivially crash its VM by reading or writing an
unsupported or reserved MSR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528113605.2671=
11-1-jgross@suse.com?part=3D6
