Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830DC345EDE
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785566392; cv=none; b=pTceLBJDpQotGN1qvzVlsuOaw0D11jBPemkaZrTc3DmvgHs+LeTjEm9ZPs6dgNQftUMSrbO3drCLlxradD0vhhnhqCCLLQMbFF522yJD2LcrBoYGQG6wMrE6JGjWvhS58LEEHG3f3gg5u3nH9EDgVH2jz5a2ePbcgEP2mgwY51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785566392; c=relaxed/simple;
	bh=uAOY0v8MGPRICgJuqnvlepM0TbMC80f/rF9Mk0Y/e+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWTl2ZTRm4ficYBJoYGFNXT4hPPIFdc4aJMuOSncxpI6ke9s3B4j3MfqJPT6d7aYH044hzLCk9Zoc5eosAt4o3vDaK6mmsh/PfIf0NK0roN9okGIUP9SNo6zl/fp4LUAaGwk4560Rdo5XetWSMq7b3YyS7zjkwiRBamRwEgbrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDJR2yfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDJR2yfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE1C1F00AC4
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785566391;
	bh=NmiU3YsrkD3uH4fhnFIWr9ahSVPy+Fq0AHJaw4B7LzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZDJR2yfOtEIzRwtbCUBTEktbabtLEpgIPuRGon5cby4ufiT6rGvo351knf19CTnQT
	 IBKQHwz3jLcm1cLruXz32Iqc2mQG9I80yQLQICsM5dgGKKHqUmw8k5TPTTYuOswNsB
	 LtOcn5e0Eqv1XPM0LYlFyIsllWSnA3+8iI9zV3jgcq8bP6E7L3FJAelEMMO67P/Hq4
	 zXvDfwUHr3cPijo7ULSfzs47qsaXZBobKJFFKlj3xAXNa1HZ92p5jHbKNlVp4wVa7O
	 EcfhYIqMTFQ0lf85PHkL+w3ylX3wqYG0sja3GGp1oUCkDg3PnQjN39cPV+hnakIucy
	 VgPs/unBBxZQA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c160420289bso261363066b.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:39:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoK1HADHaDj12U2lufbs3wopgtuTnmOBVAIsgrxqEJgBdR2xJLE/qnzfVsmy2IUC2mSSzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UR6L6tVvnCTT5GAxE9sLn2tclzBoDe+FOF95gDici+zE6OEI
	BWaRkaYJGe4PDc4wWZNaudkUpq8sWuKhU0OLaa7ZSut11veYIXlcGfDG/qGMZwx+/xe2uR+XzaJ
	nKlcphVOc3Yo4/AhXghgMU0ksjlNySP0=
X-Received: by 2002:a17:906:22d2:b0:c16:29eb:e834 with SMTP id
 a640c23a62f3a-c1fe7f45d1emr105397566b.21.1785566390095; Fri, 31 Jul 2026
 23:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <CAO9r8zOVyea=7yRD25JcRmar4-0JtTpuoDpK__J431o9MJYj2Q@mail.gmail.com>
 <amgDgTpPGsE451QP@google.com>
In-Reply-To: <amgDgTpPGsE451QP@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 31 Jul 2026 23:39:37 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNK-q0kzPEzxnGCJss4QCxHVAU+AKL2qx+hvJ-EnF3WEg@mail.gmail.com>
X-Gm-Features: AUfX_mwkWzKbzZRfqvyBzLRHv7rV50h_rlF0lVYzGh3Ll5blEGlCwmA-OOrOF9c
Message-ID: <CAO9r8zNK-q0kzPEzxnGCJss4QCxHVAU+AKL2qx+hvJ-EnF3WEg@mail.gmail.com>
Subject: Re: [PATCH v1 00/28] KVM: nSVM: Optimize nSVM TLB flushes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"

> This is probably my fault?  I force-pushed to kvm-x86/next this morning to fix a
> stupid goof I made, maybe Sashiko was confused by the exact objects not being in
> in linux-next?  I would say do nothing for now, we can always do a resend if us
> humans don't find anything in this version to necessitate a v2.

I ran an internal version of Sashiko on the series and replied to
individual patches with the non-bogus findings.

TL;DR mostly problems with SEV. Unfortunately, some of them are due to
the first half of the series (static ASID per vCPU), not just nested
support.
