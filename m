Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6A3932EA
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785679840; cv=none; b=Bh1k4uOZDD8h5hzortTG+owr5ai6qogWvUCnUoDxvprF7wc0wTzZqU85lGSza+dVhU1Fj15xtAxo/IEy2fJqVEcexpypE7/QM8J6E/30pP2DqS6cJq+shunYl4gLljWGbCi7gg/SG2WERwVyLO40Jvw1uvtsq7Yot/IznYhdPmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785679840; c=relaxed/simple;
	bh=lRO8VDcoa3TIBO/CPMJ0s3De3InVTqKIhmYtGLt8Y20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARSbwehGKB5vIAf0HeCt5WaEC1wf6e86dxOmQYkpCJJprtswmVzN0ual8mLUD87WoT/lurwfbrYsiQ2QFMp5OUF+iQ4Fn7bJxz3PKnzhkecj9ZizN3QokwTTgjD32chC5SWcthRIWjXPLlHTg2lbRvqMbywFSluNcnRkRGLrosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G82nP5D0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G82nP5D0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ABD1F00A3F
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785679839;
	bh=DQjOuBhLjuT6mtQbbyh60bt901EFtaE/jLkYdyn1c4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G82nP5D0tsGLzX1I/FFM3k8eEygPSUOoUPchd3r2nRl/KND3ClcDu73CaZcUSrVtj
	 8QFvHcdMt7M6zZqjYwzu9dTuNVWJolVQCyzedHHm5Xby8xDUCB22JdX6Hh3RJY28sR
	 IR1hQMHiUfSvEOwBAHn2pGmIYwsuOTNhs5gXoTlr6nhHKPm8l3tO5jSUv+bYd/vTQ6
	 ELgvBG0r45f38Ub8jChpSHdvWWxcrtvQtnRfs4YkckhcbteEPwFK7fOBYSfHnBJUiI
	 3wHkam8pXKVDRPslClRdsjB7uHAY8pRtVjKrYpm6Y6y/4Ji3BOxLh/hQG42LvycaIx
	 fyQWWG7ULRE7w==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fec980a30so3087320a12.3
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 07:10:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwBLPQgsccbJKK2sbE7x4UznSU0qz89ww+1SAsuNFOMP4+m8rgQ
	xWdsd7VLuQ+XnKhzfDMFKbUPee/errIXGilhcLckipeXQNl4X145ka9qeKBF6TZn9lRlrCF3O0y
	qCqp6JLYD6Gl60pEXtgSFXqUPbZ7CeRE=
X-Received: by 2002:a05:6402:5055:b0:6a0:926e:f8fa with SMTP id
 4fb4d7f45d1cf-6a0a7c60456mr4742944a12.2.1785679837852; Sun, 02 Aug 2026
 07:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616022615.2141072-1-maobibo@loongson.cn>
In-Reply-To: <20260616022615.2141072-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 2 Aug 2026 22:10:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Zy4c=pQyGFpp7BaEr6XMg1sO5=8mEEKd-UN1K0eUzdQ@mail.gmail.com>
X-Gm-Features: AUfX_mxH34VOw-RYvT74o-50Pv__NPojjRwRUzsuTf4wTRGTeKstN_GkN6ajPjs
Message-ID: <CAAhV-H7Zy4c=pQyGFpp7BaEr6XMg1sO5=8mEEKd-UN1K0eUzdQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] KVM: LoongArch: selftests: Add FPU test case
To: Bibo Mao <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Series applied, thanks.


Huacai

On Tue, Jun 16, 2026 at 10:26=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Here add FPU test case and verify FPU register get and set APIs, the
> FPU width supports 64/128/256 bits. It is important for VM migration.
> ---
> v2 ... v3:
>   1. Remove __vm_has_feature() and use __kvm_has_device_attr() directly
>      when checking LSX/LASX feature in patch 2.
>
> v1 ... v2:
>   1. Replace hardcode value with CSR_EUEN_XXX when enable FPU access.
>   2. Add attribute __aligned(64) with kvm_fpureg variable with better FPU
>      save and restore.
>   3. Add clobber $f0 register with inline assemble language with
>      fld.d/vld/xvld instruction.
>   4. Add fallthrough between UCALL_DONE and UCALL_SYNC switch case
>      sentences.
>   5. Remove sync_global_from_guest() between vcpu_fpu_get() ioctl test
>      case, since the buffer is not modified with such instructions
>      fld.d/vld/xvld.
>   6. Modify FPU register with random value rather than plus 0x10, and
>      random() is replaced with value 0x10.
> ---
> Bibo Mao (2):
>   KVM: LoongArch: selftests: Enable LASX feature by auto detect method
>   KVM: LoongArch: selftests: Add FPU test case
>
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../kvm/include/loongarch/processor.h         |  18 +++
>  .../selftests/kvm/lib/loongarch/processor.c   |  12 +-
>  .../selftests/kvm/loongarch/fpu_test.c        | 138 ++++++++++++++++++
>  4 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/loongarch/fpu_test.c
>
>
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> --
> 2.39.3
>
