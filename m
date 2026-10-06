Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB328E0F
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306230; cv=none; b=MZ50annCXvDm8F/nGERbXBoBT8YRRUoD7DyABt/FSTMirgVXsLsM2nSb6rEI4ZJd+Ln9NQ32kivHR2XbO85h3ZYToas5Lr4tR8OeuJ6a9EJj1KMn1JpsufQuSBWdODBbcBq9C5fE/yRrF1dutg4SFIEUJo33d4fIZuPjc0NKc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306230; c=relaxed/simple;
	bh=Hf4SOHeSyUmkZKQQFNvdLWnzAtMRCXhgk2+51asn2RY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sLAjcnSb4Bjg5FLxCHHFHEk7xUjVKzl5JmhHF2LAs4EQ4M+ls9pF2c8Wg/ufWCf8RwQiP+SRSR1gxZMHGZsvyzPqPOq5TK5CVwH4RyvfnPEyvbl2fL5v/OjlniHS2A+uPAlV18eJ0oFlCpAfDRCMD4m1hDWW0aM1GRmIbmmhMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+qXcKY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+qXcKY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56531F0089B;
	Tue,  6 Oct 2026 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791306228;
	bh=FBrugKIkDZwi9oTlFMf+W5eUHt0gVZslS1vBm5SFwr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P+qXcKY7HTGxL+yw6bDBdQuFtZeTwhgwex7JikRMqcGL66JhAeE5mmA3j2Fc4DaO/
	 j/4blKKA3ajniR5HiDFCmo3+A9/wCQvy+dMEZ8YgIpC7xJchkVbTU+Scxp/fMcGh3c
	 Iv5oAees2nZ3EMrudaEfqZL93INC9PKVkqwq5wt6zlKFXfhxhHfy65lLX/cytOnb/f
	 MKAfEe3MjJnI/PdhL9AwSQrE1hS17a6TNw9vGpac6TmOr9zT38UyQ21TaVMP/9O+0n
	 s/HZjLvcifTz1yMAA1UM3b8lx7gvpSeJc/3fS9q1gOU4M64bIrObWjAdd+0Go3JJUo
	 yjyDWcBBsDgYQ==
Message-ID: <sashiko-outbox-162292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 3/4] x86/sev: Add guest support for Enhanced SMT
 Protection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <92a1de684bfb5d8633c2de0ed8511f33282a0d70.1791302373.git.prsampat@amd.com>
References: <cover.1791302373.git.prsampat@amd.com>
 <92a1de684bfb5d8633c2de0ed8511f33282a0d70.1791302373.git.prsampat@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 17:03:48 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] x86/sev: tools/arch/x86/include/asm/msr-index.h out of sync
--

commit 52d51b6c190bcd07e516526d1a62088b4f2a3da6
Author: Pratik R. Sampat <prsampat@amd.com>

x86/sev: Add guest support for Enhanced SMT Protection

This commit adds guest support for Enhanced SMT Protection (ESMTP). It
populates the VMSA with the vCPU's identity and sets the SMT sibling
mask before the page is turned into a VMSA so that threads of the same
guest trust each other.

[ ... ]

> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index ee9fb820a1cd7..638867e7b4ec2 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -745,7 +745,9 @@
>  #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
>  #define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
>  #define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
> -#define MSR_AMD64_SNP_RESERVED_BITS19_22 GENMASK_ULL(22, 19)
> +#define MSR_AMD64_SNP_ESMT_PROT_BIT	19
> +#define MSR_AMD64_SNP_ESMT_PROT	BIT_ULL(MSR_AMD64_SNP_ESMT_PROT_BIT)
> +#define MSR_AMD64_SNP_RESERVED_BITS20_22 GENMASK_ULL(22, 20)

[Severity: Low]
Does tools/arch/x86/include/asm/msr-index.h also need to be updated to
stay in sync with this change?

This out-of-sync tools header will cause build warnings indicating that
the kernel ABI header differs from the latest version, because it lacks
the new ESMT_PROT and RESERVED_BITS20_22 macros.

>  #define MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT	23
>  #define MSR_AMD64_SNP_IBPB_ON_ENTRY	BIT_ULL(MSR_AMD64_SNP_IBPB_ON_ENTRY_=
BIT)
>  #define MSR_AMD64_SNP_RESV_BIT		24

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791302373.gi=
t.prsampat@amd.com?part=3D3
