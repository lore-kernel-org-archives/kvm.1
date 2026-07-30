Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63201E515
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393302; cv=pass; b=Gjoy1KwnPkTs66yq04iI0usDqy933csYo8NtaYWCMs3nWBNPo0G19MNQiNXx09EoTwacF1x/LT4TDTVLyY6LkIW/C/5snKzdSjwt9Pw9bXbGvDhU5DzkaBX2rMKkXTHyYG6a+iQiyDvqyhKjzIMAAEwl9tbIT+qWjGuWIIeEBZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393302; c=relaxed/simple;
	bh=tTg5/NN2pPyKuL5//LHE2B1PVusmtNWst3Jnj+QtL2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws4Ry9gE1r/AgUjU1tCtUctQQCVoHPmHYAOaW/hqL32g6qM7Q5lXQoj2WQDpXSDbr5HqjnqHjzAqMSt6AwJdUmfIVbPQOM9SnVRMrr63Q9+3+7egCtYPiYio/s8Ck7mXJEfhR7yjm9iY34GsqxUZud70jCYDc0bgPYy9zcP0JF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=nnw8tNRA; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="nnw8tNRA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1458363f8f.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785393299; cv=none;
        d=google.com; s=arc-20260327;
        b=cm1fbDzqD/ZgS1myMBYgjsU3xtOWMI9rOlcnhKmia5Pd2gZdoGPcduU/zI4UGbrlvx
         EBVJCIYSJ1dU8Jz+CDUNEt1W/Gv3F3/QdiBTQYY2nDvb8u/mAWJ/c8fvcd9H4q5Tu2Ky
         d2FRv3eMKEe/a00ygeMj1hArPyUvrz/TWieIfw8lHICiALWQKAYUJ7y+4xNliQPmYLiy
         ax1Vch+ZkVkSjvW1mYzEsRO/vJF0Usrbhr75X33LZKTejFv9y5jF2P28mzhdsXmEFxQ1
         TMD/1P1MgNP/ZTyPFGACHRmrfPNrCkcTonVMdyYxAYlU/bPBo8aZty6LpjMGEQ6p7gdn
         mJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IbxqtpZnShFKaHKefEe4sTCSmkBdNGqkiQHmyC+L+Hs=;
        fh=aVlO1ihXaWzTodxsd5UwgqYdpEme+BRFSbOd1fLu6bI=;
        b=ax0QiLO31EqbIF5ayw8e4VfYe2bU4SZoPirPlNGwynNlLHsluZ/zCdqIYdtESMKSaZ
         YEXCyoi+WeEZBD8Jc6gxwZIj/dP3cjxW7cDXoD5GbKPaz97atWpc2XZ8X6YJAj/Xiwxl
         fMfRG4Ocehe/73di0M88IPvFXngXxypj07E9Rji/i4LVLconnMSg18yBQEe1YZ5XIN83
         x0L0LeGTF/Ieu/WZwF3h/V06/Maiifnaki34P+ZD0KMBN/O3bYdFehAGtS680tFQVbbC
         /gUx6yg22GackT8mhWJjNLqDBSe0jafid5ElwzSVQWp9qac1Nll9N0KKCalFbULmr1wS
         xP7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785393299; x=1785998099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IbxqtpZnShFKaHKefEe4sTCSmkBdNGqkiQHmyC+L+Hs=;
        b=nnw8tNRAOTVHJLIgTFeFNUgDtuYDOvqrmG9C1kVcwCSRyCHWo0edLt1uUY4wTZj87s
         5eQKXlfJbdkI2p8XJe9XlqntBlGIuBuU4bfrDLo+EX5wfSUVqd4IL4eK7SSX40UUa/TB
         xqVswMj91DsFpSpXo7PYv8gHsvz/dTb11sYO/l1dy1mPl0OMRs1hxwdg4WvsRhOUm04F
         b+WzLy4FvjqgL/zrQhNx+GLY6gfQEVgfivmM/O0731YGxnaxCGVspmLbW27UI1itn8rQ
         xMJ/u/b73BBIVfrhncFpOnnqOkICk4/z5KjfLFnmMNiXk/DkgdY4+ZAPngOpur7sybrF
         NOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393299; x=1785998099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IbxqtpZnShFKaHKefEe4sTCSmkBdNGqkiQHmyC+L+Hs=;
        b=buvZTs+I2uv6AVk16MqqsNwOCYejP1H/6fOoowuG/seHJTAVVe/BaX7nwUS3Ul3DuI
         VlmLd/tZLY5Y264BPOSyQYTnyZCHO9jbTPOpY5i1LIUzxpO4EUrS4uQVKbzxCckbOMHg
         9AvIthMKFBfwPP9zkYVMSlV1gNk4fU8cKyKUTMPxcoZgcvZWdYrbYx3edZmOLp8XuifC
         1TNEMf/Jy70VI+D6uRi2MJcpDqRu/a1PxepgqT83xtsdWteXArNWdgLu8aqkmV6nrv+m
         OFu47kUOh4ZL4p9bIilKYYPVN5Q/3QFYPg0YYzu4qKjqRKORDeOUYUQ4+1WMeI/g0aOz
         gKAg==
X-Forwarded-Encrypted: i=1; AHgh+RoIcdnSPRqNZ/OuSc3sjYgPwyrSlZ54soYWvzGmotEZ3kb5qgI2bHxWdXSmMv08gNW8IY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRMK6UdKLaiPHWfrRsQDgGd5pDCOKyJA0loNS0UU67FVdb9xZ
	+7TEd+R0yWeupEoW3nCOohdR8yrAw+UUAVOhAxH9FQktbAvUPjasFo2ANKyAB0SQykKIXXo/nrU
	sQHL2O/8Xlbi/JoeN0po0F4ESc79PgZ4GyDAz6s/8Lg==
X-Gm-Gg: AR+sD12EYwIPJxJqA1c6ZkWZQoxfLUke322VjZ1ZCLHy1LnZ+AfdUq77i/DcBX2APCG
	su5zjhPMx/uQdYErMdk7pgdzXapEJZ16clnwhwmoh8mGWzoDhBZihMS5zpiVxaJL/c4Sf3gdI6X
	6MScTwjZm9bP75iJCYET6JDYaC1Fw37ntLJ9//C/sp07Wu2usSHCHq+Cj8mcEh9p9phzPR1Hxuc
	SMtn1YGLQ6/wKQ5h6sePfk2AATuO/919ksmmJO6bueMaDviMzGZe9RBt8IQttDbHe/Fh0Nj+c/z
	Fj/b/DCfQY4rI7I3ybQh6sq+NNyXT1RYLIZL8tn2Vd1yxf/xaYjFznxmQLwv8BvYd1A9JPFMnJk
	p7HbKFob+ydMS+YTM3nnPgprYTsWqF2ymxtkY+FXw/gvw0meHWLlzSDxEK6vPm1Mkuxqf5JBBwg
	==
X-Received: by 2002:a05:6000:2010:b0:47f:4fa9:ae42 with SMTP id
 ffacd0b85a97d-47fc80c2fcbmr1669738f8f.11.1785393298545; Wed, 29 Jul 2026
 23:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729232527.139183-1-inochiama@gmail.com> <20260729232527.139183-4-inochiama@gmail.com>
In-Reply-To: <20260729232527.139183-4-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 30 Jul 2026 12:04:45 +0530
X-Gm-Features: AUfX_mwiU5ddNzdK7WpCSdf3HhHn67Wv5Yj3GZUH0R97aWLgDl1m06xy4O4sbCY
Message-ID: <CAAhSdy2dMcuYv=vvVDabxv92OwM6HMU5LuH84Qqu86YZfEDV5Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] RISC-V: KVM: Reset the SBI extension when disable it
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:55=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> The SBI extension validation callback can only fix the parameter if
> the extension is enabled. However, if the extension is disabled after
> modifty some parameters, the state of the extension is still broken.
>
> Reset the extension when the extension is disabled so it can have
> a clear context.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index b737e9a7a12a..1c4f874368fb 100644
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
> @@ -229,6 +230,12 @@ static int riscv_vcpu_set_sbi_ext_single(struct kvm_=
vcpu *vcpu,
>         if (!sext || scontext->ext_status[sext->ext_idx] =3D=3D KVM_RISCV=
_SBI_EXT_STATUS_UNAVAILABLE)
>                 return -ENOENT;
>
> +       ext =3D sext->ext_ptr;
> +
> +       if (!reg_val && scontext->ext_status[sext->ext_idx] =3D=3D KVM_RI=
SCV_SBI_EXT_STATUS_ENABLED &&
> +           ext->reset)
> +               ext->reset(vcpu);
> +
>         scontext->ext_status[sext->ext_idx] =3D (reg_val) ?
>                         KVM_RISCV_SBI_EXT_STATUS_ENABLED :
>                         KVM_RISCV_SBI_EXT_STATUS_DISABLED;
> --
> 2.55.0
>
