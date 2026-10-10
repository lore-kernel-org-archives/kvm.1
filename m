Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C2B2701B8
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791618126; cv=pass; b=DrNhZmf++tOkMYUURIRVwItjzzj2pSZ0T7zcX3bXKbLXr12ruheE/Y/mfSHJDI3PlLbu6FQXVi6tQSgVsym/AXU2QVecOoIABqHTIIHAcuhL0fhKJKKJ9UJXv1SuaJmacxCX19sh6ibOrVLpe/hRl/WRFFpHnWXeS7Ykt2Fd5us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791618126; c=relaxed/simple;
	bh=MTojMnNoOc2FrRH9VCOe6h2M6mtftCTUaADeBwnOD9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5gkPm0yMRFbDlxaGCDVedVVQW7Qm5//HXqfLKgsNxCIALkPNWDFPawjpn8eY8Ai7y/GGTcgAy+pdnSKmb2SvaNYq203IvZBjPQEUnOIEJETnlpKrk6Vm9/VIoE1oY1/bSpFvpw96LPCBSI323UzFH3e5igE/o4aLLlY1+uhVMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=YzTDW2LL; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="YzTDW2LL"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4649b3aaso230845f8f.2
        for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 00:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791618123; cv=none;
        d=google.com; s=arc-20260327;
        b=QcQs2K/njkZjOZDXLfbnVy5NVut8iXvkFTMo/ls9kxiLqHJw6McszTcdfJIhxYXA7u
         nisreu7WeThH+4JhTDeXuoewRlP/o23WA8bfePcNBGPyh0Fa9xSOmj8CDwsISYfc41Rc
         7eOZsM4yJZV5psc/iYm/w3mFoLNabDrhXBdjVZ1HRMejgE6/lASd4zLNFl4dBiQcgWtQ
         QgbthP36Ocas3DeFEO5jbeWruf3hs5JxlmaaZhP/6YdBrAyKrScDuvAgr5vV3z23A3MN
         D+50rJn9jsOiL++WBA0ChhtsKJhszkzYozX4Rdm5qT4FNK0OootfCGdNaV7pxTXirKOS
         1y3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XCywv9S23B5H539wqDzYaEMewRr3bUq+EMOyebbIFcQ=;
        fh=GJTrZC0sm8u5OKWFuWNrEwZ/qaOoeNOWPzrUjZ9I0DM=;
        b=aqIBJf9OoEEvHlPkzvkD39gShukUkx1TGlAwNqUPRY0k5/cflwBII84dAcmq/enuLN
         2+ShG2iRgUvwpWc9bjeScPhotG8OKzVvzqQ1IqztgzZZGyaKg7/0PPPhnvtkZExFQOZ5
         dg4j0qJIB9X1ChycgXnbhbeFn5pnOpBTjRT1jXvI2Qsa4hrXwsXJiKjPAZoXobvkHS1n
         jysRDJcfBt/vSS+EydLNUNbWgMBRTzjWX1OJTIRNmbYrvU4cLb3fURUlCjRsBY1jmPpa
         Z0jZiazL09XVVWYuASapoKwsECtyaI3e+vLU/H6Luy91iNeI5MboFYo0HilOKxcom7ar
         ckdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791618123; x=1792222923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XCywv9S23B5H539wqDzYaEMewRr3bUq+EMOyebbIFcQ=;
        b=YzTDW2LLuSZW0t3ISarmAy04d1+HX78Mci7xmHmLrIamdlWEkib3oFBE/1FxdfnKqm
         drUdy97EANjPWz0U8uhRLBgRJrVJETAiwotjJvJxAamEO1jfwGlkFSo5pV4JbzsYJHTA
         ktmFpXQUba8llqggZNFrEjafbRIykxWnpxpD7y9UsUKHQ/1ONPneaH45FggmiHuLRgKR
         /0nrcp1IpYR44Efj7gDdvwAXWwaioj1isjhsOmSSgKAG9Y+UPrKXIlA+ER3516oKQUAG
         ckZAScuoALseJSAOh2LksUkf1D2unzdXqKfGeXXvUsJklHzds02zvadx7sNHjyDSbd7f
         AktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791618123; x=1792222923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCywv9S23B5H539wqDzYaEMewRr3bUq+EMOyebbIFcQ=;
        b=hxoX30B3PwQSX0VLmuKJEQW5YJDI4J+OAKwu8P3R/VkqH8cFAcBekFltc94SK7laUi
         D6tq5s38NzlWhfF7zvaSNvPJJC1mszb4msu3KkAssN8JI0oHSlMDgqM1RtFZqkrZi4vY
         7xE+iyNVmMnQfv8iX9oj+l3mQyUlYKFXOpomz8rcSFR58l1Xd8MM3nlmpDu6OtIy6938
         4z4/dSlu+0ErxQh5/erkvmgy0zwv1vWo439wzgXVAW0wNZpsKY3G/X8CTspymbMRqO3+
         HqautwTRZj3qyhOxhNcrJvhQHkumjIBj1ywVKk1wbTFyw0u7ibnZsKgMC5r8aiT/3maG
         rq3A==
X-Forwarded-Encrypted: i=1; AKwUvBytki+7bxtQm5sSKLk1Yzm4m2DcJi5Ojm1lsp1NsbbRX7fZIN/inu2w3B+NYa8bXIwuIks=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2Ob3CE/aZwBgKN7brq75kCsJKjWQlZZ43zKO4ln1VExr6OMum
	jNjQ+13M46rcztOgzIrGDsZNGB0A/5E0+c42kmDFNolGUW/6GqNYxHXMPkxa0UInzzQAgi8vgFe
	44qsLD8ggY0Ng5oMAD9aHbhb8J+02mU8VbeLDcEnA5qkrlTp6m6IYb1ZRNgH1
X-Gm-Gg: AYBFou1wRMjUaSgdVL14+1e+sJjjao6N4SJ0GWnD1oq4J2zCKdtBlNBPYVCp+aJjbbd
	a3hIl8ly1ywXwbFgWedIL+NR0siI1e211HC30fjr6W61Y9AIChjY05OTBJJN7IeEy7gsEg2x5dQ
	iSV0p87hGsPd9y9XHG67aP8w1AHTilxgJUjoJLLBwEJYuHXYLfZv6ERGRrr9ajOEW/OLW8w1PAD
	5obAIdCQpRvXZNrUaSQDG+vXfoDHF6b54zXsJXkFJZUn6RXGBnZuPPixUPnATLYpDzbEr/qju0P
	B7saqpX4ux4ueO4ozlaXUDR1k7NjciUtbXahjMqIWujKC0y+wpkpDYVWyhd6A2U+qEtXHB8kL8z
	Mq+mlHHVENFNq6aaOIKHH1tPzBeGAKgzrCpeH/CAo0oUbTmZOmi3O5sbQak5jvtE8xse0HH5FBa
	Vlv6dSt60v
X-Received: by 2002:a05:6000:2589:b0:487:218b:bbb0 with SMTP id
 ffacd0b85a97d-48dbace804bmr7344901f8f.42.1791618122986; Sat, 10 Oct 2026
 00:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922021823.44251-2-zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <20260922021823.44251-2-zhangzhanpeng.jasper@bytedance.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 10 Oct 2026 09:41:51 +0200
X-Gm-Features: AclHuK9QWngkeEhzbFvhRp9fejpKyh1bo8KVOKD4O89AFCZfZ54-3_jc6EqtE_s
Message-ID: <CAAhSdy1d-hW8Kj1rFEjfY_Q24j+V5N9tXciUcY36nMmkrUNKiA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix build with vector support disabled
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Atish Patra <atish.patra@linux.dev>, Andy Chiu <tchiu@tenstorrent.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 4:18=E2=80=AFAM Zhanpeng Zhang
<zhangzhanpeng.jasper@bytedance.com> wrote:
>
> The kernel-mode vector context handling added unconditional calls to
> get_cpu_vector_context(), put_cpu_vector_context() and
> __kvm_riscv_vector_restore() in vcpu.c. With CONFIG_RISCV_ISA_V=3Dn, thes=
e
> calls fail to build due to missing declarations.
>
> The get/put helpers already have no-op definitions in asm/vector.h, but
> kvm_vcpu_vector.h only includes that header when CONFIG_RISCV_ISA_V is
> enabled. Include it unconditionally and provide a no-op implementation
> of __kvm_riscv_vector_restore() for the disabled configuration, matching
> the other vector context helpers.
>
> The paths that set RISCV_V_VCPU_NEED_RESTORE are compiled out when vector
> support is disabled, so the restore stub does not discard any live
> vector state. Keep it __always_inline for its noinstr caller. The vector
> enabled implementation is unchanged.
>
> Fixes: b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context handling for k=
ernel-mode vector")
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup


> ---
>  arch/riscv/include/asm/kvm_vcpu_vector.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/includ=
e/asm/kvm_vcpu_vector.h
> index 6371d5ea5392..50d4789b9cac 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_vector.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
> @@ -11,9 +11,9 @@
>  #define __KVM_VCPU_RISCV_VECTOR_H
>
>  #include <linux/types.h>
> +#include <asm/vector.h>
>
>  #ifdef CONFIG_RISCV_ISA_V
> -#include <asm/vector.h>
>  #include <asm/kvm_host.h>
>
>  static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_conte=
xt *context)
> @@ -55,6 +55,10 @@ static inline void kvm_riscv_v_exit(void)
>
>  struct kvm_cpu_context;
>
> +static __always_inline void __kvm_riscv_vector_restore(struct kvm_cpu_co=
ntext *context)
> +{
> +}
> +
>  static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
>  {
>  }
>
> base-commit: 93f51579e7df248780214094418f205253383cc5
> --
> 2.50.1 (Apple Git-155)
>
