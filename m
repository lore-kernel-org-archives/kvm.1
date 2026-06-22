Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCE347BD9
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157063; cv=none; b=JogXwvIQF64Tl3k61K12wf93TT1OMhKw4GAUYL+Lvt1trUBIBSJuSVbEuuSL1WuSOAw+5fdQKgoBzhCVLmGVw0BupcnP8zeABwoN4bjPb0BgRNZC9FqmULM/XAf+FacRHGgINKzYIXFy5uKX1440lgUaDmCyBf0VvXN9kHYoOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157063; c=relaxed/simple;
	bh=ipiu40ohpbWubc0ToG9lzVol/xR4NZqTHGAHqzsth/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwncyJU9ks5kq3/eRgP137RJOsIWkL/mhj4ITGWrErR9/ZJJO7p7tESSv7bC6/gUZ8qqnITMqKRtgQgjjTh/HrXoikLJiYSrATgO8F55ZRMVmhzpN3nKO8Ix7AdDSh9Xy8YLr6I/IjDIDMhsFSS9AZBI9Z1juiqGkXHlldiDNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aemcix+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aemcix+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5105C1F000E9
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782157062;
	bh=SBXDGLy7VvtxOcX6pab+23ecSintJ/2ebyGVRfBLReU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aemcix+pSVH/DhjCaDUHGsH1+hxi244zx0zbsGSDuCXEQXfx21GGBh3flyyv6aZOC
	 FC3YFTRx3nytXln4VOwjq06wp9MB6GM9rpiLBTV7U/OrIrAAvrnTvJrVXCpmSB40WB
	 x7b9qKsiruScoLL3A76s8lW2PPLywN239w+YN/Fa+Tp9b/a+qUIcPZ7CT8kfey7GZY
	 CMttxeirPiAqJrVchs1rg9jG8yj1WNcpidZMHpnWPFPXnIeEZ8HYY3u7qkB47Ix87f
	 8wJoWeSp/2bzCPtVYUPFj722/xgnTV6JrQ/S5IJf2hwhDjK53PphniOh8tj8l23l6D
	 gsc2iARc8NnwA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697764213d6so4596098a12.1
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 12:37:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YyDey/OgJ3Y+b2ZyKFV9rPI6kzCksoSps9LVjvg/eqqIhOd/GbX
	uxoRN36dngfmRl3wMp8iMsls8Kr6c5Y0iugE7ZQ1Q9JmTkxzuCaIBQeCrOyJbjWt9OT21lM4AEF
	MJ9HoMIi5iSSFNyk+DNTtbLNI58YcCwU=
X-Received: by 2002:a17:907:d0d:b0:bee:bcf6:6a22 with SMTP id
 a640c23a62f3a-c097cfb4d64mr1033662866b.44.1782157061312; Mon, 22 Jun 2026
 12:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622112725.40348-1-pbonzini@redhat.com>
In-Reply-To: <20260622112725.40348-1-pbonzini@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 22 Jun 2026 12:37:28 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOgBY5pb_QcTmYEm1OozjWuxW_0dZNCv09eWJtn9EDuMg@mail.gmail.com>
X-Gm-Features: AVVi8CeoW3Qk4Z9lj8elMxzf_CInqtJ29hepWmWs-tm6OExMeoesffN9aEtABLg
Message-ID: <CAO9r8zOgBY5pb_QcTmYEm1OozjWuxW_0dZNCv09eWJtn9EDuMg@mail.gmail.com>
Subject: Re: [PATCH kvm-unit-tests] svm_tests: replace rdpru with byte encoding
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 4:27=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  x86/svm_tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/x86/svm_tests.c b/x86/svm_tests.c
> index 06eba51b..ccbab1d0 100644
> --- a/x86/svm_tests.c
> +++ b/x86/svm_tests.c
> @@ -3652,7 +3652,7 @@ asm(
>         "insn_rdtscp: rdtscp;ret\n\t"
>         "insn_skinit: skinit;ret\n\t"
>         "insn_xsetbv: xor %eax, %eax; xor %edx, %edx; xor %ecx, %ecx; xse=
tbv;ret\n\t"
> -       "insn_rdpru: xor %ecx, %ecx; rdpru;ret\n\t"
> +       "insn_rdpru: xor %ecx, %ecx; .byte 0x0f,0x01,0xfd;ret\n\t"

I am curious why this is needed (and the changelog is a bit light :P).

>         "insn_invpcid: xor %eax, %eax; invpcid desc, %rax;ret\n\t"
>  );
>
> --
> 2.52.0
>
>
