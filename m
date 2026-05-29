Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D7352C3C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082973; cv=none; b=PbtsYQ+W6D9nDnyERyvKX6L71ass5Diz/E7HGCXr77D9GWGxqW4Gwn+0Q70RfXv64EpDBAEwM7jFWREFAYF2E9eKTVaR4CpMcygWCUcXufB4M7fSZ4+liu3cysbqpa0ImTr+Lj5KnYgxDmOv6cpy03Lz5ft+7Y4Y3XdrKyIc0Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082973; c=relaxed/simple;
	bh=k4EzTeX2HTrMQTCk/QD5CcNTQlguLVNPByqYh/oFNS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JJqpU3HLk57KzoGkIr7YEMMUkWQ7cKxTXNpns5pQFlXkQ3I+ZP1j1Raju7LSloRODbpWOtbbW7R0QSHBZ3PzCan7AS5yrSI1K5UScsK8g40bOu1MAz86FGm2H1HCS5+EWBVbDL7XdwuSJ0/P0XlamSPadi0YM89aNBxdeC1PK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h25QKQRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h25QKQRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301811F00893;
	Fri, 29 May 2026 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780082972;
	bh=5NXNSy4UEgrSFhqO1zADE54xjkOz8ZbdGiRXvcXer+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h25QKQRwckGnf5OAap6jA4x4I1DPmL1Ctagsn/rtge4wAE5mkEiiMXTfNtiiI08FO
	 il44dHqCTXI13q8oTYJfjWZe5hsi9XowNX+2Y5tFjZUa6j6ky4b4bY18smss3MifYq
	 jcR8TyVrJhPBGc/csMryJfDste+qO+sFhYydrV0gCoWz7zjjnUqIRioN2pc0tlAxfS
	 KXQhSf8wSOo6mJ+K7iitnUwJS0Bqr3d2xotyKjOfOI0b0hUPI524FSHQSoQ3z0A7oV
	 oUrxtx1xdJjNh2xYSfklq8osTCT4QHdeFovXfVQMOD3uvAf9zkpkYnfFyeCpSB3zHT
	 Mx1fTEoHxLUUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/24] KVM: SEV: Ignore MMIO requests of length '0'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-3-pbonzini@redhat.com>
References: <20260529183549.1104619-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 19:29:31 +0000
Message-Id: <20260529192932.301811F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious SEV-ES guest can flood the host kernel log and cause a=
 Denial of Service by repeatedly triggering un-ratelimited `pr_err()` print=
s via invalid GHCB scratch configurations.
--

commit 294af95cb303ec47ddd0734af250cb6201c6779d
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Ignore MMIO requests of length '0'

This commit explicitly ignores MMIO requests of length 0. This prevents
underflowing the length when setting up the software scratch area and
allows for special casing 0 in the future.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 23170b64f4a33..fb2174b6d1ba4 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4497,13 +4497,17 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  	case SVM_VMGEXIT_MMIO_READ:
>  	case SVM_VMGEXIT_MMIO_WRITE: {
>  		bool is_write =3D control->exit_code =3D=3D SVM_VMGEXIT_MMIO_WRITE;
> +		u64 len =3D control->exit_info_2;
> =20
> -		ret =3D setup_vmgexit_scratch(svm, !is_write, control->exit_info_2);
> +		if (!len)
> +			return 1;
> +
> +		ret =3D setup_vmgexit_scratch(svm, !is_write, len);

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a host
denial of service through printk flooding?

Looking at setup_vmgexit_scratch() in arch/x86/kvm/svm/sev.c, there are
several validation checks on guest-controlled values that use pr_err()
without ratelimiting:

arch/x86/kvm/svm/sev.c:setup_vmgexit_scratch() {
    ...
	scratch_gpa_beg =3D svm->sev_es.sw_scratch;
	if (!scratch_gpa_beg) {
		pr_err("vmgexit: scratch gpa not provided\n");
		goto e_scratch;
	}

	scratch_gpa_end =3D scratch_gpa_beg + len;
	if (scratch_gpa_end < scratch_gpa_beg) {
		pr_err("vmgexit: scratch length (%#llx) not valid for scratch address (%#=
llx)\n",
		       len, scratch_gpa_beg);
		goto e_scratch;
	}
    ...
}

Since these failure paths gracefully return to the guest with an error code
rather than terminating the VM, an unprivileged guest can trigger these
paths in a tight loop.

For instance, by repeatedly setting sw_scratch to 0 and issuing an MMIO
write request, the guest can flood the host kernel log.

Should these messages be converted to pr_err_ratelimited() or removed
entirely to prevent guest-triggered spam?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D2
