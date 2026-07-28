Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFD33DED9
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261354; cv=none; b=OqtlDs4Wp7CT/sv2tmJx4DAuF61RkGnYTfgMcg1EfLcjCZ8mPDOoxXmZBP4NnI1L4eKSSDvzJmCCPGG+HsrSVB+5V6YICdoPSmpTFcERnX3HFsBCidDohoiiladtoaXh7HWE9G21l+hXS3RE/V56eRJka/nlaMAJ5G9zrHClzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261354; c=relaxed/simple;
	bh=LF7noLiNdzawX4c+ZLUh8jqYRExDy55AyB7cIWZMYhg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OaUvLJhCwDVBtH1Hk4zJme+iuvFya2wiL7fcHGOU19HjQTahMiNdK+g2g1TvlSs/Jy2Ku9NQaBvuqPBJ5Qr5T0UuO2OR+QsDclnvtS8xXdrnxJlU8yz41Vauj5Km2yrVuRkOaZYs1FKy6/P+PKsJiJxLCmyUN0NuxCWydbT5ZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2uEiAHR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2uEiAHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991521F00A3A;
	Tue, 28 Jul 2026 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785261353;
	bh=pTrw9js+9R8UgFOIY3KI/OI6vwD/VqvBoG6W7NKNwoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E2uEiAHRghc1C4uARzHi+/U/ogslxSbbuiiypbJrNfDGRXxo2A6if1Pd34Gs/Okp4
	 QY4AZiyDgpMqTmieLKnJKYf6M/E98niHqX3H+MC7tuV3GeUXOG5zUCLYFd9w8VFI3k
	 Wzskt2OgWPevFWT81vbzLSEhbn9W2sHJglw85ObF4LMgEVQM0CUembp3vgpuC9qXja
	 RBDfkJZ4t1sImoquMuW31ebxXQ5f1iHtvr7CHWbKqJ7BXBJVXAlX1aF5UQ/TINv4iv
	 Smnt5tmIZUyhz+R+bTS3Jk6nuGdYXGMOZBttkoL//I6PwCFIXRfqsn3YbBpJ5LklKo
	 ICpVKq+JOgH9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/13] KVM: selftests: Drop
 HORRIFIC_L2_UCALL_CLOBBER_HACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728174232.2423257-7-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
 <20260728174232.2423257-7-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:55:53 +0000
Message-Id: <20260728175553.991521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Data race causing register corruption in multi-vCPU nested tests=
 due to globally shared guest_regs structure.
--

--- Patch [6]: [PATCH v5 06/13] KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOB=
BER_HACK ---
commit 9a9a1bcc6fc0c85786cd983d4fae11f1dfafdf51
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK

This commit drops the hack in ucall_arch_do_ucall(), as the nVMX test
code now preserves GPRs across nested VM-Exits.

> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/=
selftests/kvm/lib/x86/ucall.c
> index e7dd5791959ba..38050c60a0670 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> @@ -10,36 +10,8 @@
> =20
>  void ucall_arch_do_ucall(gva_t uc)
>  {
[ ... ]
> -		     "pop %%r15\n\t"
> -		     "pop %%rbp\n\t"
> -		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory",
> -		     HORRIFIC_L2_UCALL_CLOBBER_HACK);
> +	asm volatile("in %[port], %%al"
> +		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory");
>  }

[Severity: Medium]
Does dropping this hack introduce a regression for multi-vCPU nested tests
where L2 registers could get clobbered?

The nVMX code that now preserves GPRs appears to use a globally shared
structure:

tools/testing/selftests/kvm/lib/x86/processor.c:
struct guest_regs guest_regs;

The VMX_SWITCH_GPRS_ASM macro uses this struct during nested VM entry and
exit:

tools/testing/selftests/kvm/include/x86/vmx.h:
#define VMX_SWITCH_GPRS_ASM \
	GUEST_SWITCH_GPR_ASM(rax) \
	GUEST_SWITCH_GPR_ASM(rbx) \
...

Because guest_regs is not thread-local, wouldn't concurrent vCPU threads
running vmlaunch or vmresume clobber each other's register state when
accessing this shared struct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728174232.2423=
257-1-yosry@kernel.org?part=3D6
