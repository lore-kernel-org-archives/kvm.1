Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A912772D
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849677; cv=none; b=cPpsvYkLbaPBCWkQyTlMlGR5ZS9andPUYsnb3tvrMnEvjQ8vbnxZYmepFu3eZB05K0vJTihP3ZWPWFEbosgfvVyXpBqg1odONs485vk7Z8Pw5VnXkj7WY2/Q7auKdaIxsLkTV0Fy32P3z+2H/Myj1vpa4NugqhYw7xsVNE9i6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849677; c=relaxed/simple;
	bh=8CeBLbekq6ByoEeHRZlZxgD3roLojJfVsHvXvzXSS8s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pvwELt9i1lIjFZft7ExXFZYWehtqX6Oo2R2WCPKmVazQvn18/5v3C/kVNbv0oYrDLuEneDFl/aqKzqUAEeDjPBE5skZU0KeHi2uBPG69QWj3eL6d6uOBL+xTEdqFjm0fiUe6YiMJDx3necUbP0a0SoEz2jM3zUo7dAyqVGhyFLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8mPEqH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8mPEqH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63BD1F0089B;
	Tue, 13 Oct 2026 00:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849676;
	bh=2Xl+F+H00ZzbyeNOGQrIiU3zcK6Df4su2LhjV5NKvnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e8mPEqH1QlbBDDGMLXy4vVFKn+s9ST6idy8BuL/u5c/jcS41IQiraWm03V24QTblB
	 8JHKP8A7loo73TtrUaD2uWoJkCggy7VLkoK93f3HFKcUj+pspTH7jmEnq+jepoBojj
	 L6q272qXlflQnD+81I9FcsQXNDNs1qnI2zK4S7nCzEMB1ZORC9b7Us/L1D54LuaZCw
	 FnxoiIIkTS4JWh+tiZ6NqxMbBrjkEBuAFJF2PAskOmwZchrm+JdGE+oISwrSbXwwT6
	 /joSfF19e3DzxqwqW1LZDepxljl9KihuMzBGB4wKX3ghSGo/YCBQPZEDKh7djl3pxk
	 9q5yrKy0RYsFQ==
Message-ID: <sashiko-outbox-168763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/27] KVM: nSVM: Add a placeholder ASID for L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261012233638.2546339-14-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
 <20261012233638.2546339-14-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:01:15 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: nSVM: missing vmcb_mark_dirty() when updating L2 ASID in SEV =
migration
--

commit c8f241845a6790f522df58195167e95ce8fea046
Author: Yosry Ahmed <yosry@kernel.org>

KVM: nSVM: Add a placeholder ASID for L2

This commit adds a placeholder ASID for L2 to prepare for future changes
where L1 and L2 will use different ASIDs. It also updates the SEV migration
path to copy the new ASID into asid02 and vmcb02 if nested is already
initialized on the destination vCPU.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 99577859e1aab..b2e6acfbb081f 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -2041,6 +2041,15 @@ static void sev_vcpu_migrate_asid(struct vcpu_svm =
*dst_svm,
>  	 */
>  	free_asid(dst_svm->asid);
>  	dst_svm->asid =3D asid;
> +
> +	/*
> +	 * If nested is already initialized on the destination vCPU, also update
> +	 * the nested ASID to match the new SEV ASID.
> +	 */
> +	if (dst_svm->nested.vmcb02.ptr) {
> +		dst_svm->nested.asid02 =3D asid;
> +		dst_svm->nested.vmcb02.ptr->control.asid =3D asid;

[Severity: High]
Does this code need a call to vmcb_mark_dirty(dst_svm->nested.vmcb02.ptr, V=
MCB_ASID)?

If userspace creates a non-SEV VM, runs it in nested SVM (allocating vmcb02
and caching it on a physical CPU), and then uses it as the destination for
an intra-host migration, the migration path updates the ASID here.

If the vCPU is scheduled back onto the same physical CPU, pre_svm_run() ski=
ps
vmcb_mark_all_dirty(). Since the VMCB_ASID clean bit might still be set from
the last exit from L2, could the CPU ignore the new ASID in memory and
incorrectly reuse the old non-SEV ASID from its internal VMCB cache?

> +	}
>  }
> =20
>  static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012233638.2546=
339-1-yosry@kernel.org?part=3D13
