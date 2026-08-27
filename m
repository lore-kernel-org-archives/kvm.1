Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B63033EB
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809960; cv=none; b=qHjmN57AcZzbPT7ToV81OgSWE+icwTV8gW/WA6RyMy1Nl7DQGfe0KhBQBHpRF/rGAJVy6iFDY3f+RYKMuInhKEkq07zqJ4oq8r/bp7EKzwzz7Wuq7O3+pY34cNKYxbLcQfJGBr8ZF0s2gmh3rRXu8EK9XV74wxJTsUnLvWWQg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809960; c=relaxed/simple;
	bh=U8dFj21gmo1wRRnMpmIZTXNP7xQxshNIRI95NyePvgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nhpFNCEKiTrYL517JNrL/d0luVcRztT3G2px3zGqOrJ28JuYw2CbrPtZbB1WYgOXhsIQg2Es+w8Xv2PM0bs7ciPeKmfKWiRNXTJn7/XtUlsfAoCi10SKe4hNpfer7yMObEybbdCth6m7EUQ/TqQUBMPUDWj13HSu75Ptx2WIyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJnuvuP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJnuvuP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6C31F000E9;
	Thu, 27 Aug 2026 05:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787809959;
	bh=SRiyOMXH3HhcU4oGn0FPIUry2GWlGd/vS7RZRcJs7gI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LJnuvuP657v60PgHpPnH5kdpzIXyNQYWNJ5xSWLibIM24m5nWJ4/gCII+FMw58+a1
	 jAP33AToi5iBUw8hkHQXQ7yA25WES/x6R+cpgw8OaSvaComC7Ctjuu0fTumMJMQtTu
	 fd70Ohr5i2NlSXZDo8OxIV1Ta5rxnUhR6grj6mF+vwCHS1r4uCwV/I9QsKaODw7PAw
	 ES4EESFlsIY8MtxVhYf0B3Dkebv6LdbkqzUh/AjO5vS+liXsCFJijEJQvF0BPvDnOI
	 G7v8p5BYsWAMsZmEJKJEQXTXVmAyrud6TXOwtp4kXZSBdEraP7K0QFAL3QzP4tB7fY
	 dxygDyRwmV6+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: nSVM: Restore L1's debug registers on nested
 VM-Exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Zhang" <hao_zhang_kdev@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <ao_Ms5alWwKa30U8@192.168.1.215>
References: <ao_Ms5alWwKa30U8@192.168.1.215>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 05:52:38 +0000
Message-Id: <20260827055239.5A6C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Restoring L1's architectural DR6 and DR7 from the hardware `vmcb01=
->save` state on nested VM-Exit corrupts L1's debug state and leaks host de=
bugging information.
--

commit cba4fc9e5c8bde0943c94c7835fb0e3712e3df8e
Author: Hao Zhang <zhanghao1@kylinos.cn>

KVM: nSVM: Restore L1's debug registers on nested VM-Exit

This commit restores L1's DR6 and DR7 when emulating a nested VM-Exit from =
L2
to L1. It copies the debug states from vmcb01 to prevent L1 from observing
stale L2 state or losing its DR7 state.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 73f37b050d0a0..e7975ac7bfca2 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1427,7 +1427,8 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
>  	kvm_rsp_write(vcpu, vmcb01->save.rsp);
>  	kvm_rip_write(vcpu, vmcb01->save.rip);
> =20
> -	svm->vcpu.arch.dr7 =3D DR7_FIXED_1;
> +	svm->vcpu.arch.dr6 =3D vmcb01->save.dr6;
> +	svm->vcpu.arch.dr7 =3D vmcb01->save.dr7;

[Severity: High]
Does copying the hardware state from vmcb01->save back into the software
structures here in nested_svm_vmexit() corrupt L1's architectural debug sta=
te?

If KVM intercepts debug registers (which is the default) or if the host is
actively debugging the guest, vmcb01->save contains host-controlled values
like DR6_ACTIVE_LOW or vcpu->arch.guest_debug_dr7.

Overwriting L1's software-tracked DR6 destroys pending L1 debug exceptions,
while pulling the host-polluted DR7 permanently leaks host-level breakpoints
to the unprivileged L1 guest.

>  	kvm_update_dr7(&svm->vcpu);
> =20
>  	nested_svm_transition_tlb_flush(vcpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ao_Ms5alWwKa30U8@19=
2.168.1.215?part=3D1
