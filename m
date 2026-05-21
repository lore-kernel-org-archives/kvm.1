Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BC360EC6
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381848; cv=none; b=Q82wIluVdrYsT3SnwDF6lBmxWRGBXCZoCHnDxFVxfOTaxzAQqOckrnyQSXKhkVg6KHsYYWmJjwmB6G498Y4GsTMggx70VBHFEXwJathRRLiv5rxZuaBhMNH3DwunGrS4Tp5HKUNeMMBu8d6IfVIUmrL7FsHcoe1lKwTklCD0jfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381848; c=relaxed/simple;
	bh=FS4LVD5EG7d26mDJvJxoozXIjKLTP3j8hcba8AGNdCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTCFR+ex6a+wSvp9KUiMHEogP94E7/w+NdEXxC+dgJLjn43rkfUY7Zu44E2ZrF0HPcDrlpkwlwJTOuN12HkStqpXvQ3/wlrX8i0sgzurJ+u+C5S4n2j7rm6p4mptQlShY60++NtNEzrfPiPkDpfG+FXl0p0mwVQQ/G4xvbGfgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0uYBMnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0uYBMnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229791F000E9
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779381847;
	bh=TUaFRHfYFNLpPrHEzw0wLhd0/Sd2iteGtCi5IHBNDAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=F0uYBMnWYcZbd69tEmLylDWUEHrBPFGZ2Ea+4IE1UjVcPOtXSj5KSeGPV0bPqjAjs
	 o4B8Br9b24e0HlZgh7tz6rQq+1UUEle/3x4PD0P5ncZaW/DlN94rVcAO8lI6IwnlTj
	 1Pd2q6UBYYDJuOd7CxdZUo0BV3gO74qGczOsrxdZHgc7/fKWYK2PtEcumZJrFM6Wet
	 1rnm4bXg6mJXCu6Nmis3LvaWG29PtRhTnJYKtT8EmBvMMQRsXFNgkSfRLzfgrlmvXU
	 m+FmvyGvtiU/6L7o0p6t+83bTJnsBTqyOPVt+sLqTkapeSaXzMJhhfs8UADsQBRHwo
	 0rKLRnK1AaDcQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67f94c078e8so10396420a12.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 09:44:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YzFSYHRfSg91TCAfmXnpsI32wMhz/DdPu0/Gk/nwRvJzGmGpEZh
	Rhsii0eTGSINUmI5s9ZypXkm/lHEmgplRcUN0MxhX7eHc9vnLinYaMeUx56yCxHZGW63lyetArP
	Jm0oSm+Y6Y38IbQ/oeIdMixjzFBI6mhc=
X-Received: by 2002:a17:907:7f91:b0:bdb:6077:a168 with SMTP id
 a640c23a62f3a-bdd2580cdafmr6764566b.26.1779381846103; Thu, 21 May 2026
 09:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521092311.86030-1-pbonzini@redhat.com>
In-Reply-To: <20260521092311.86030-1-pbonzini@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 21 May 2026 09:43:54 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNwaMuXNNqLTtj3fv-PVk_6r15UC5X42FYm7T-x9so1Ng@mail.gmail.com>
X-Gm-Features: AVHnY4Ifq5z3TzTFPAo4JQC6nrDYcowpoktsh_ymkQYZ8QUEho8A3xxTC6ijdiE
Message-ID: <CAO9r8zNwaMuXNNqLTtj3fv-PVk_6r15UC5X42FYm7T-x9so1Ng@mail.gmail.com>
Subject: Re: [PATCH kvm-unit-tests] svm: fix rflags and rax offsets
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, minipli@grsecurity.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 2:23=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> They need to include the offset from the VMCB base to the VMSA, which
> is 0x400.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  x86/svm.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/x86/svm.h b/x86/svm.h
> index 7603ea0f..f926cbd6 100644
> --- a/x86/svm.h
> +++ b/x86/svm.h
> @@ -437,16 +437,16 @@ static inline void clgi(void)
>
>  #define ASM_PRE_VMRUN_CMD                       \
>                  "mov " GUEST_REG(rflags) ", %%r15\n\t" \
> -                "mov %%r15, 0x170(%%rax)\n\t"   \
> +                "mov %%r15, 0x570(%%rax)\n\t"   \
>                  "mov " GUEST_REG(rax) ", %%r15\n\t" \
> -                "mov %%r15, 0x1f8(%%rax)\n\t"   \
> +                "mov %%r15, 0x5f8(%%rax)\n\t"   \

The selftests have the same problem. Sashiko pointed it out while
reviewing one of my patches touching the same area (fixing other
register offsets):
https://sashiko.dev/#/patchset/20260518202514.2037078-1-yosry%40kernel.org?=
part=3D1.

>                  __SWAP_GPRS                     \
>
>  #define ASM_POST_VMRUN_CMD                      \
>                  __SWAP_GPRS                     \
> -                "mov 0x170(%%rax), %%r15\n\t"   \
> +                "mov 0x570(%%rax), %%r15\n\t"   \
>                  "mov %%r15, " GUEST_REG(rflags) "\n\t" \
> -                "mov 0x1f8(%%rax), %%r15\n\t"   \
> +                "mov 0x5f8(%%rax), %%r15\n\t"   \
>                  "mov %%r15, " GUEST_REG(rax)"\n\t" \
>
>  #define SVM_BARE_VMRUN \
> --
> 2.54.0
>
>
