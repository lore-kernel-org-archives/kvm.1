Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F97C21CC51
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843863; cv=none; b=l18nbj8ZYYN66WjpvqBgbjTAdjkF+s0GMStN9Lrm3k5sGf0sEBqMDbMVlYZjJjbN6+ugOp7YKvUuonE24yMf7JpFhWNPsVTythpEG9LbxnTwWSGdDFB/BTDBcgX1MhMDcLJTfCn1zHNnoIFtfTaiepu7lSILVB0qMjvStw6ZzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843863; c=relaxed/simple;
	bh=rwSkP9rbQ/TQlaXhO1PQYJjbnE3GluHKotPqi8gHDlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A6eToNqnL3e/B83hMS9910tlVR0ZlXwmQ6hoNVwWo8t/oK4aoNldWSMnbc88UttaR4wrrd40M/ACH8N/PcHCEY2ImigINh4BIHc5++j66XEcaTIZKBiM6qiXBHmBoy23mAyCrqIiosIbRRsXWhErkctfTI/C8KJ13dn6XvbENQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUTU7uTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUTU7uTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1481F000E9;
	Tue, 30 Jun 2026 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782843861;
	bh=ta3jjtqPr3fgVUFb8MVBP88BXhss9R7RPlZ/TVD2mow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUTU7uTgISejJf+r+0NGyNfbzXs0WOcKtz3bKno1w0rKb8TpVQecQgZkHFXDyALTv
	 o77ZKVhiLmVunJBpyNyys9zyECcmmLHx/zSvJ1X84Gx1s1UulMvXr+X9Kz5O69zjUO
	 j/hT3r/YW4zIhb6UnfKq48j+drGoP/a1EdyHI4B9eNvJowsrl+P7Bz5lQkeH7Q5kK5
	 MevH1RAvr6J8NDwba3ktUr3pYIl67ulx9CCgBVbi2dgdlOx+jOrvW8wDAlgSR6bji/
	 K8+iROMqJhdsEa99x6VB7r0OAVY9erUI6d2VtbO/QTfMovsRaCJtFi0wkFLQbHhSUk
	 xdP0YhTwk193Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/6] KVM: SEV: Perform RMP optimizations on SNP
 guest shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <3a5df8dec32da5c31998bcfa775ca92c80cbc1eb.1782841284.git.ashish.kalra@amd.com>
References: <cover.1782841284.git.ashish.kalra@amd.com>
 <3a5df8dec32da5c31998bcfa775ca92c80cbc1eb.1782841284.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 18:24:19 +0000
Message-Id: <20260630182421.8C1481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Indefinite deferral of RMP optimizations via mod_delayed_work time=
r reset.
--

commit 5a78324bed688cb2c4b58d363233a323513bd9b4
Author: Ashish Kalra <ashish.kalra@amd.com>

KVM: SEV: Perform RMP optimizations on SNP guest shutdown

This commit performs RMP optimizations on memory freed by terminating SNP
guests. The scan is deferred so that a single optimization pass can batch
memory from multiple guests terminating in a short period of time.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 4272293478766..c574849b15878 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -2992,6 +2992,16 @@ void sev_vm_destroy(struct kvm *kvm)
>  		 */
>  		if (snp_decommission_context(kvm))
>  			return;
> +
> +		/*
> +		 * Perform RMP optimizations on memory freed by terminating
> +		 * guests.  The scan is deferred, so it normally runs after
> +		 * sev_gmem_invalidate() has converted this guest's pages back to
> +		 * shared, and picks them up then.  A very large guest whose
> +		 * conversion has not finished by then is picked up by a later
> +		 * teardown's scan.
> +		 */
> +		snp_rmpopt_all_physmem();

[Severity: High]
Can an unprivileged user indefinitely defer the RMP optimizations by
repeatedly creating and destroying minimal SNP VMs?

Looking at snp_rmpopt_all_physmem(), it uses mod_delayed_work(), which
cancels any pending timer and pushes the execution timeout back on every
call.

If VMs are destroyed at a frequency higher than the timeout,
the background optimization task might be starved and never execute,
leading to degraded memory access performance.

Would using queue_delayed_work() instead prevent this starvation by
ensuring the timer is not pushed back if the work is already queued?

>  	} else {
>  		sev_unbind_asid(kvm, sev->handle);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782841284.gi=
t.ashish.kalra@amd.com?part=3D6
