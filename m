Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FF43B4BC
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312178; cv=pass; b=cAQXTmYaAJdypdTwpX95EVuT+3yYnKXNgTSGv5X/tvAIeHxUxCqvkchz6kdjz90/pba/zdwzYSHA2R97nJqXg/F5FG/mhTMtERyRxu4wEjmZ9mQdhqNvLrN9GxDAZjiFxsXxR7ajd6m3qeM39IjmtWW5qNst2piibIgqIcm9Ly0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312178; c=relaxed/simple;
	bh=pbcZzsH1yly7yzM8EG5vApUsgdoSwx5zDpdWlF0TDl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLbwiMR3va8FdH6UYaGddmW0DyWyEdBnnWWZEaoi6cVeWCNKndXv+I/DSGu5k7Xy3dNr5j1A1VykG2je61gr26S1JaTvoS67kHbDrYBX7IO2ZSe5HCjhZnRrrDV32WEPonZO3X6etR9vAwaT5Y7r3sP/pTgKPIkoB/fXCDRCmBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=fudfgFMU; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="fudfgFMU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so4156225e9.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 01:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785312171; cv=none;
        d=google.com; s=arc-20260327;
        b=AFntwL4lPHhfH5HziCOVe5ICB0g1S0uKwizl3f5SmevrhRf5MkSaLXWpWv88jWIEwh
         WwAp3JXe5hJezXwsGNcPP/z16qnh5Yo5D8K8iQcSeWtsUxwU1VipC6q4AOysnUkTxuzr
         cTLIQ47Vuby08IC+TtNiE2j4vsjSKAW1f6YOmSR1kCVImmcJoCn7pC70zWsziJeIWeQM
         WRgFrN5y6W9xps9BaP2S15JB6Omn0pITHyTMS4cOBU8OnPV4/HfycIRxAiQx4/y7H5wC
         ZTlpOKXSXDo6AtsAZKE1ukmaD7VLVCgGUd4fzAML3gZz2oI2f4vNjDK6T02diIGkLpLt
         ladA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KUGHARkb/NyRoNdj9PaR5oVTMK44ZfhRPJfOUUN230Q=;
        fh=Dvsuszvu8rv6GcuHXBnV3GXji4KUFoOxP4jAyI9BPf0=;
        b=c3+wBZSJnRhqb69lEbll9Ute8kX2xjU17l/pk7mEyP5o0fBhYizfymr31TuVdCVvxe
         HRmekngwBoPY/6CKa2Sgo8BjlDgi1/Q5E4EjhdfrmiWM6GcM567HkCQuFEdv4f181++1
         fQK8CDKEp4+1Scc77GpNnqVZhxGWrrQf7RQ9Yq3Qn9SsMed6xFpM1515om7hdmNBsTYD
         fqFu6p++HXLBo8nA9YDu0mO52CmdMfTxBeDx8IIOO5NAbrAnqRLqmvWjoI5Te6Pu7I8V
         F4BCUdHsBKCUYzSltulRfci1KQwM5D3KoAfvwoCsQkU9whuJkD5tDCVAyT2S2JNGvsbn
         gmVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785312171; x=1785916971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KUGHARkb/NyRoNdj9PaR5oVTMK44ZfhRPJfOUUN230Q=;
        b=fudfgFMUSqgZV/EXxji7XJttxWri8L2LT3hR/b38d3hBjpETgDAPfkUB0nXKyORYYy
         0jUG1OvFf+ogQPrYPsco+Ie3HQJLXOtF9Lp1kw1+fz+ibu+sqN4mym6dqj3qXp7eSiI/
         lndIgfMKsgZ3vzEQUWj+C7v9b0r04m3QmRUZruOqhfYYy+FynSp9jIGYydI/aIuQW4SI
         1t149ksUvbq4vYnV0e0y6rG7st5TiU/Ojh0TTHmqgs9KFTgGX3Uq2DQi6i8DJFmsVGOj
         TbMPqtsCwE9G7pM0gpxi5G1QiwW1v1kyNDd6CzkWJsl9bRIK58J11kdtEhN3YQ0udmJf
         COjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785312171; x=1785916971;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUGHARkb/NyRoNdj9PaR5oVTMK44ZfhRPJfOUUN230Q=;
        b=j8w+POaohTy665f7TTk2KnZftMBCS7RKRi7wfwtvWilFdJIyWohuIQg1j8mFhRh0LQ
         R3wwV11feIVaEZ7Ox4aXMODrDXiGtooONDyfaFxU7WWA6ZOmqfFCi34O0sJ42HHprgau
         OtCvB3sRVTKxQeyKpuddJETC89/CK36FQmpUW0PyjrAoBccq0OSFwd8c9+w5EH/rdcGW
         vF/H5dv+foIuKnthE5JlOZdR9f5MRt3x2DEnBbQRezKjql2x0TGpks9tUy0HGRRlz/0h
         RZdWWwfCKy+2BtZq7lJgccO3r6oAWGTDCw/zgpcuofChEuuDm2443jXt5GvdGi5TtXK3
         neCg==
X-Forwarded-Encrypted: i=1; AHgh+RqsaHWDrnm0jvTHwsvTWklXa0hv9fOzicx7aZy0B2iG6PQaY5hgcjkxSSFKFIfyrwWl6Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgkdVD6BL0LU910pm5xb5MYGMNe7Ct5Er/WRP3nCc53HJpR1Y
	2GwBqOrbziVVoOuzZon+0hgyVwZ3XZjGANrouphcTqxkYW5MlPs3VPCF+zPhPuwTB38TMltd0Ma
	zZ8HggRPCGn9iZe+sK1FnO6qABdKqKKgX04SCPG2GoA==
X-Gm-Gg: AR+sD10uqhRORRHGQSlcqx/1bvRCura9P+ekLe8VlXOrjqY96uJyVuGQYUQrCP8FEMa
	vpaobavuB0ZjgpCsWPMAZRaF8fH2AfcocgfjVU5Wz/HrEts69Lgokiby6BFbs/bh/3OV+Wo9+9l
	LlIeB2e6ZN43lGr/nyVdl6jV5ViUktOSNoHGw4LK331SG984w31D5pVmDUwQM9dlj++Yh37BBZx
	nalR/OLaJG7HHDzYPOFtu+LiizVpQHHwc17la3DxOJ2osQiaDIAF6oB7BRL4e9irqevXpkBwyYQ
	mFAb7ehJJGzBbFBxD/VzrJMTSI+B10e43JcYsjqpTGCWV5sgIX/xAOIaUMjG66YsHohHq57xyNl
	uzM7uK4mVgoE3PhvqzTshml2MvITNIbk6Csb74SS7eKCMi4wUw2DbZJFKXnAlG/4=
X-Received: by 2002:a05:600c:3146:b0:495:4cb6:71cc with SMTP id
 5b1f17b1804b1-496c6413090mr60244765e9.5.1785312171184; Wed, 29 Jul 2026
 01:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706021154.210289-1-inochiama@gmail.com> <20260706021154.210289-4-inochiama@gmail.com>
In-Reply-To: <20260706021154.210289-4-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 13:32:40 +0530
X-Gm-Features: AUfX_mwSxFjTy59usX_zUYG_2NAipnz8XUOKZh1hddj4nec-XezM7JKOT1LvP0A
Message-ID: <CAAhSdy3qnvWF1cdxJxnJxR9jf0_BUpKbauNAuJcY_AAVaJw9AQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] RISC-V: KVM: Reset the SBI extension when disable it
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 7:42=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com> =
wrote:
>
> The SBI extension validation callback can only fix the parameter if
> the extension is enabled. However, if the extension is disabled after
> modifty some parameters, the state of the extension is still broken.
>
> Reset the extension when the extenion is disabled so it can have

s/extenion/extension/

> a clear context.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  arch/riscv/kvm/vcpu_sbi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index b737e9a7a12a..3eb7b7c57059 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -221,6 +221,7 @@ static int riscv_vcpu_set_sbi_ext_single(struct kvm_v=
cpu *vcpu,
>  {
>         struct kvm_vcpu_sbi_context *scontext =3D &vcpu->arch.sbi_context=
;
>         const struct kvm_riscv_sbi_extension_entry *sext;
> +       const struct kvm_vcpu_sbi_extension *ext;
>
>         if (reg_val !=3D 1 && reg_val !=3D 0)
>                 return -EINVAL;
> @@ -229,6 +230,15 @@ static int riscv_vcpu_set_sbi_ext_single(struct kvm_=
vcpu *vcpu,
>         if (!sext || scontext->ext_status[sext->ext_idx] =3D=3D KVM_RISCV=
_SBI_EXT_STATUS_UNAVAILABLE)
>                 return -ENOENT;
>
> +       ext =3D sext->ext_ptr;
> +
> +       if (!reg_val && scontext->ext_status[sext->ext_idx] =3D=3D KVM_RI=
SCV_SBI_EXT_STATUS_ENABLED) {
> +               if (ext->reset) {
> +                       ext->reset(vcpu);
> +                       vcpu->arch.csr_dirty =3D true;

Let's not blindly set "csr_dirty" when any SBI extension is disabled,
instead we should set "csr_dirtry" in kvm_sbi_ext_fwft_reset() (just
like we do in kvm_sbi_ext_fwft_set_reg()).

> +               }
> +       }
> +
>         scontext->ext_status[sext->ext_idx] =3D (reg_val) ?
>                         KVM_RISCV_SBI_EXT_STATUS_ENABLED :
>                         KVM_RISCV_SBI_EXT_STATUS_DISABLED;
> --
> 2.55.0
>

Regards,
Anup
