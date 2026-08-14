Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA53BE14D
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725098; cv=none; b=jle9KlOdTQ+qdU2u0GkFBr35xleH3qTSdqx8v04YCYNSf0K6RnYHSiA2lee/GKsijBFyIu7s4vBeD10tViXcUUj2kSGF2vKwx8yu6wRYAH/Dij3HYSrzfhF1coV2Lh0HbgIdQZtdT++nePBCX38aVHP6Cl2TiHBmpode5HVv3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725098; c=relaxed/simple;
	bh=S69k8pl1ST2lh5w/IuLOehF18eMZumLZ1HDIeplovlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e6OXDSWUOvj7b9ObHrc/CQWxHkKg4ll92zxrr+Gf+63mUHNgWMu/QnXt2Oppb2Gjw2SspHEeAuteEbpxtsathPTbEx8KkHNtD6rEt6h0MQXWbdyrBcAbYeu8Tp07f/hRwdUlLgSj3k2HkmDExnhv7kStsRh2BWHnxYlv/xrTGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgVodll9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgVodll9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297DE1F000E9;
	Fri, 14 Aug 2026 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725097;
	bh=FM+wn7iu01veenV76jcuRAcGyQOz5ObzXFVXCLSCxHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XgVodll9Dcq2HDKdmpTqx6cCbTEdn2vmUi+LWpDQTFCgmxHGh5+zvC6QGx2CwN8O3
	 ZHMhrti8LfrJIKR5V9d0QLMr03soKi6DiAU5i0AVbTAy3yJKEPNAFGrkTQhnciG5ee
	 f2/qmf50jRhuy3YxMdTyJxYofv4DlOeYrJnNMsQsewPxRIHedu26gBpn50GsHyiffW
	 nBB6uNrSo1kVhX2QMPCxZbzK8XWn4a2Ik7/uhoANjAdiSnw4MB7hHwq/2QNFchXL2w
	 hZNW5s6CRXCdgqprFchpS8eKNFgPi1tNLi1cLEeTpqMwlSEcopD3Fmn+0ITRQ4EML6
	 5nh8sE6KHEn5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vitaly Kuznetsov" <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814162221.2144473-2-vkuznets@redhat.com>
References: <20260814162221.2144473-1-vkuznets@redhat.com>
 <20260814162221.2144473-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:31:36 +0000
Message-Id: <20260814163137.297DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes an infinite VM-exit loop in `handle_vmptrld` by in=
jecting a `#UD` exception when eVMCS is active, but misses the identical pr=
e-existing bug in its sibling function `handle_vmptrst`. This problem wasn'=
t introduced by this patch, but represents an incomplete fix for the class =
of bugs described in the commit message.
--

--- Patch [1]: [PATCH 1/4] KVM: nVMX: Make VMPTRLD result in #UD when eVMCS=
 is used ---
commit 34f5c31113003a4163d028b0ce4bfea669ca97f5
Author: Vitaly Kuznetsov <vkuznets@redhat.com>

KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
   =20
This commit updates the VMPTRLD emulation to inject a #UD exception when
eVMCS is active, rather than returning 1 without skipping the instruction.
This resolves an issue where returning 1 without advancing the instruction
pointer would cause the L1 guest to get stuck in an infinite VM-exit loop.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221841

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 6957bb6f5cf7e..c78c67525ac9b 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5883,6 +5883,12 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>  	if (!nested_vmx_check_permission(vcpu))
>  		return 1;
> =20
> +	/* Forbid normal VMPTRLD if Enlightened version was used */
> +	if (nested_vmx_is_evmptr12_valid(vmx)) {
> +		kvm_queue_exception(vcpu, UD_VECTOR);
> +		return 1;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch, but does handle_vmptrst() need t=
he
same fix?

Looking at handle_vmptrst() further down in arch/x86/kvm/vmx/nested.c, it
appears to have the identical pattern that this patch fixes for VMPTRLD:

    if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu))))
        return 1;

Could this unhandled return cause the same infinite VM-exit loop if a guest
executes VMPTRST while eVMCS is active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814162221.2144=
473-1-vkuznets@redhat.com?part=3D1
