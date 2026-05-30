Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216CE317153
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780133389; cv=none; b=m6ecW7pKOWTt/rX+s2RgJ/JMNqvOqZT5WwmW/zQigNrMzPnGaCi9Z94vb9dMSDos3IX5u92cdYXACs88ZkuvzlYnOlEOwSEQnUukxINwpzzeb+ZOi/vJmR7NLMSPcXwwkkjfhE0pVfurWRCS4GFhpTYGg2FZyXAqlgIzJ6aP7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780133389; c=relaxed/simple;
	bh=NsjuvnWhKKSr+gx6ACjnSrlRRyFBBWpjFXVqooGfyJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bk9SbkhSZV7uLGvyHtDvEkrGIbG5I1UZ5SahC4RtXfsCY7O7e4ehH66wSi0yrKM5O0x+Mm0iCmVZE8tc4loizS8dWK81pCCaceG4UnjV2qoDBHNjLhUvoq8Va2KP6gZT9zkJKz7ztN+UHTpInvSZhQUEbal3BTYGVAMyZD1dEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+lpPARz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+lpPARz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490971F00893;
	Sat, 30 May 2026 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780133387;
	bh=CGqECqkSBdLTWiYgYvDwHn0srLWhgTPf5G+v2b+CmMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+lpPARzp2LxFFJewhD7fZybecjiC/AVhV8I6VSTdiAUEm2RcrxCSpbef4OmiyANc
	 joxsgB2zf7MZipZvlIQ2BLXZLmgxFo0mvF46WrPdI+OhVipjj8dLZcxHEzn2/MYwJ9
	 tqxDguVnQ/t1h6d50fGBcvyAkCgZg3polMdL8wxpshBseJb4XmdFYYZpjydijNMRbY
	 /Tb/Ib8TYLgTmSpVipzpS9hItQL1fncPhFMd4Aml3xq8rYNAMPAtGTlwkh5qLYx4K0
	 YthfZ7Iv9aAct4Z3kJXpVSttvANjdcOgnsUInhjkCnMsPNBHk5ldgDp+qHUIVYJd1+
	 ZPjeCdFwh7/+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/24] KVM: SEV: Return INVALID_EVENT for SNP-only
 #VMGEXIT from non-SNP guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-21-pbonzini@redhat.com>
References: <20260529183549.1104619-21-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 09:29:46 +0000
Message-Id: <20260530092947.490971F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] KVM consumes the GHCB `sw_exit_code` field before verifying that th=
e guest marked it as valid.
--

commit 96be1ee0d4433ce7c711162daac605e0cd3278ae
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Return INVALID_EVENT for SNP-only #VMGEXIT from non-SNP guest

This commit updates the error signaled when a non-SNP guest attempts to
invoke an SNP-only #VMGEXIT to INVALID_EVENT instead of MISSING_INPUT.
It also moves the SNP checks out of sev_es_validate_vmgexit() to make it
solely a predicate for verifying GHCB fields.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 880a2acd77bff..b59adddfdbccb 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -4527,6 +4537,13 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  		return 1;
>  	}
> =20
> +	if (is_snp_only_vmgexit(control->exit_code) && !is_sev_snp_guest(vcpu))=
 {
> +		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is SNP-only\n",
> +			    control->exit_code);
> +		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_EVENT);
> +		return 1;
> +	}
> +
>  	ret =3D sev_es_validate_vmgexit(svm);
>  	if (ret)
>  		return ret;

[Severity: Low]
Does this consume the GHCB sw_exit_code field before verifying that the
guest actually marked it as valid?

By moving the is_snp_only_vmgexit(control->exit_code) check before the
call to sev_es_validate_vmgexit(), KVM evaluates the exit code before
kvm_ghcb_sw_exit_code_is_valid() is checked.

If a non-SNP guest provides a GHCB without setting the valid bit for the
exit code, but the uninitialized memory coincidentally matches an SNP-only
exit code, will KVM incorrectly return GHCB_ERR_INVALID_EVENT instead of
the required GHCB_ERR_MISSING_INPUT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D20
