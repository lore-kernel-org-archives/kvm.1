Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E130AD10
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094901; cv=none; b=hkO0na6ny5923KDEqbzf6WEK/Cf6+JTGA2neQUC1q96Pwn3x/XCtx8/M3EpILHfTN62pdFgJorARlRhQrj+ZatVApmdrsr/wkVw/9SpuLpw5y1D4r4JBnKr8lweC0MgIDpyD5Z3jwrgELopmqzAQmtYa6JvY1jo3xbVbNO+gxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094901; c=relaxed/simple;
	bh=2LDxysWe3RkYg1uQpR87v1OgCFW+XgvoavVCWHHeIAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HZ94PJPUaPX4L81tjR0wjUF31lEB60O8yGKZkWBFY0OOxxJM/CgbkuozybKq3ovRPb5x1sNWI/Q6zO9Sr9uZgmejsdCEx5ZX91wjVj8zPTdzka6hFjSZFt4pa0GNUXPI+acHdnW4vFZ/Shy/n+lZSuPDckfuKITKv8U4+8W9Wos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4pOsX9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4pOsX9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6765F1F00893;
	Fri, 29 May 2026 22:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780094900;
	bh=OhI6vW4zsIKCgJqnqeUAru4QUK/w7akGbyIL5OAtvoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l4pOsX9cHN/fBxikNd4HAVgTK/j09BZSYnJPCutkBdoC95GSovtMTwzhjfP+8DmJc
	 2STu/ltLpne563toiNWOCqMOl8fmVtvTtrZrpwrlOFQR3oX6Up3emRLFRkQC1N83xq
	 XXDgYHOCsba2esOC2rj6u7OmqoxJ9l8pYx0tUw6VnRWE+ss8ujYiaJyWFO8leck3+J
	 vhpnU46fcierAtI2Yj4JLVmayeju5EfigI0nEBzvAj/wvvYGxYLh3RGtzPnGETl469
	 AGgeBei5rLnDSfs8uwviFfWbrzOSv3BdxUIeKkGvXibQ53BrAdnJoZyYjWLG0crpPr
	 n32STvKcqzKpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/40] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529222223.870923-5-seanjc@google.com>
References: <20260529222223.870923-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 22:48:19 +0000
Message-Id: <20260529224820.6765F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect 32-bit mode segment check emulation in `sgx_get_encls_gv=
a` violates architectural bounds, alignment, and type rules.
- [High] KVM fails to enforce the architectural requirement that 64-bit poi=
nter fields in memory-based ENCLS structures must have their upper 32 bits =
set to zero when executing in 32-bit mode.
--

commit ca9673f76fcf276ab1d3acd4cb535b328a49e842
Author: Sean Christopherson <seanjc@google.com>

KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of 64-bit m=
ode

When getting register values for ENCLS emulation, use kvm_register_read()
instead of kvm_<reg>_read() so that bits 63:32 of the register are dropped
if the guest is in 32-bit mode.

> diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
> index df1d0cf769475..4c61fc33f7648 100644
> --- a/arch/x86/kvm/vmx/sgx.c
> +++ b/arch/x86/kvm/vmx/sgx.c
> @@ -225,8 +225,8 @@ static int handle_encls_ecreate(struct kvm_vcpu *vcpu)
>  	struct x86_exception ex;
>  	int r;
> =20
> -	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 32, 32, &pageinfo_gva) =
||
> -	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva))
> +	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 32,=
 32, &pageinfo_gva) ||
> +	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 409=
6, 4096, &secs_gva))
>  		return 1;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the 32-bit m=
ode
fixes for ENCLS, does the existing 32-bit segment check emulation in
sgx_get_encls_gva() violate architectural bounds, alignment, and type rules?

In sgx_get_encls_gva():

	} else {
		*gva &=3D 0xffffffff;
		fault =3D (s.unusable) ||
			(s.type !=3D 2 && s.type !=3D 3) ||
			(*gva > s.limit) ||
			((s.base !=3D 0 || s.limit !=3D 0xffffffff) &&
			(((u64)*gva + size - 1) > s.limit + 1));
	}

Is it correct that this calculates the linear address (*gva =3D offset + s.=
base)
and then evaluates the segment limit against it (*gva > s.limit), rather th=
an
checking against the effective address? A non-zero s.base could cause limits
to be evaluated incorrectly.

Also, does the check (((u64)*gva + size - 1) > s.limit + 1) allow an access
to exceed the inclusive segment limit by 1 byte without faulting?

Finally, by requiring s.type =3D=3D 2 || s.type =3D=3D 3 (Read/Write data s=
egments),
does this reject valid Read-Only data segments (types 0, 1), even though
ENCLS structures being read (like PAGEINFO) only require read access?

[Severity: High]
This is a pre-existing issue, but does KVM fail to enforce the architectural
requirement that 64-bit pointer fields in memory-based ENCLS structures must
have their upper 32 bits set to zero when executing in 32-bit mode?

According to the Intel SDM for ENCLS, "Any 64-bit pointer field within the
data structures must have its upper 32 bits zero in 32-bit mode, or else
#GP(0) is generated."

Looking at handle_encls_ecreate(), KVM extracts 64-bit pointers from the
guest PAGEINFO structure:

	if (sgx_get_encls_gva(vcpu, pageinfo.metadata, 64, 64, &metadata_gva) ||
	    sgx_get_encls_gva(vcpu, pageinfo.contents, 4096, 4096,
			      &contents_gva))

And passes them to sgx_get_encls_gva(). However, in 32-bit mode,
sgx_get_encls_gva() just silently masks the upper 32 bits:

	} else {
		*gva &=3D 0xffffffff;

Should this instead validate that the upper 32 bits are zero and inject a
#GP(0) to prevent invalid guest structures from being successfully processe=
d?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529222223.8709=
23-1-seanjc@google.com?part=3D4
