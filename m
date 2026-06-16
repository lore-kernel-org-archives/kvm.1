Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FD1FC7FB
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577296; cv=none; b=j4Ogx+DYYFCMVjNa2NL5uMSUGnfMsGzTMi5dlJQgmSuvGk0lMlgr6xAH6WAV/YbBeHnfK5iw1dYxZDZzfPPBaxu6emfydcVa0Zo1hsCkqiJ4UOZgonw+iOqq5OCH587DitK203IDARSxU+AGK9nQZNgdSz4GyQE1pDJ/sSCftPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577296; c=relaxed/simple;
	bh=J0F29HKmEJmn1uKOYpKDuzJlCgShKvnCPkwc1kLHgLc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ao0PX3T+VfEDHNpDdSpo6Ee7DqGarM+LmozEjH7KGEMCYarqT1jKWEgI3RVJmEB5D9jyiuaPNwGBz2rBuCDcWUCxAGrb0VdBw9iAp1CnCDpL0ml7ptm0olATlspD3RJslREohFVQJgb7F2mCjr3JhyRub63v2kRrbUge8lSYnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUwEmn1T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUwEmn1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EA61F000E9;
	Tue, 16 Jun 2026 02:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781577295;
	bh=Bcvtk2vMH7CUuUYnKghdPUyZygVwhOSimVBy52oAPQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hUwEmn1TG6SOv/OWISvU/2Z5i26ko6vDjxn4N2RYJfwZQ6VxBlfqKDxAjMt2mfxJP
	 nK4WM666UuQgDUKtqKWrjL9OWeHdhU+hx5hGS/5U7p3MWFioam0PvRFrJGNJS0Tbbd
	 wenHnbzQo5ertC3TKzbwB2+Da589ug1Ctj0kCUuT/x8ouYpQgvNU7w7DWtJjwpeGO+
	 ZBlGhXbhOCjf8Ulf5DwwITy/C5HokFOtRsnm71Hu85izgWdCKOpUbOxGwVyTRHYI1i
	 E4uCitlNBhobNQSz4qCSfrsjUEWwUudOFrnEpl0vWIyIocx2rxmHNe23cOs/L4ofaw
	 Jyc4GUwDC9P2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] KVM: LoongArch: selftests: Add FPU test case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616022615.2141072-3-maobibo@loongson.cn>
References: <20260616022615.2141072-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:34:55 +0000
Message-Id: <20260616023455.67EA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] FPU selftest fails to verify that `vcpu_fpu_set` actually modifi=
es the vCPU FPU state.
--

commit 2bf4caa3158a9fa987285bf7aea2092fe7c8a3f7
Author: Bibo Mao <maobibo@loongson.cn>

KVM: LoongArch: selftests: Add FPU test case

This commit adds an FPU test case to verify FPU register get and set APIs
for LoongArch. It supports testing 64, 128, and 256-bit FPU widths.

> diff --git a/tools/testing/selftests/kvm/loongarch/fpu_test.c b/tools/tes=
ting/selftests/kvm/loongarch/fpu_test.c
> new file mode 100644
> index 0000000000000..fe58ed4f93c0b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/loongarch/fpu_test.c

[ ... ]

> +int main(void)
> +{

[ ... ]

> +	fpu.fpr[0].val64[0] +=3D random();
> +	vcpu_fpu_set(vcpu, &fpu);
> +	run_vcpu(vcpu);
> +	vcpu_fpu_get(vcpu, &fpu);
> +	sync_global_from_guest(vm, *fp);
> +	TEST_ASSERT(!memcmp(fpu.fpr, fp, 8), "Wanted 0x%llx from f0, got 0x%llx=
",
> +			fp->val64[0], fpu.fpr[0].val64[0]);

[Severity: Medium]
Does this sequence actually verify the set operation?=20

The test adds random() to the fpu structure and calls vcpu_fpu_set(). Howev=
er,
it then updates both the fpu structure via vcpu_fpu_get() and the fp struct=
ure
via sync_global_from_guest() before comparing them against each other.

If vcpu_fpu_set() silently fails or does nothing, won't both structures just
read back the previous, unmodified state and cause the memcmp() to pass any=
way?
It looks like this pattern repeats for the 128-bit and 256-bit checks below=
 as
well.

> +
> +	fpu.fpr[0].val64[0] +=3D random();
> +	fpu.fpr[0].val64[1] +=3D random();
> +	vcpu_fpu_set(vcpu, &fpu);
> +	run_vcpu(vcpu);
> +	vcpu_fpu_get(vcpu, &fpu);
> +	sync_global_from_guest(vm, *fp);
> +	TEST_ASSERT(!memcmp(fpu.fpr, fp, 16), "Wanted 0x%llx %llx from vr0, got=
 0x%llx %llx",
> +			fp->val64[0], fp->val64[1],
> +			fpu.fpr[0].val64[0], fpu.fpr[0].val64[1]);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616022615.2141=
072-1-maobibo@loongson.cn?part=3D2
