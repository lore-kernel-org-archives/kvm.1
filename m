Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAA2EA754
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774851966; cv=pass; b=tTmH7g6ljE0ahNoBWQ2ERPKA+7uWADYC42dRoaUWWqtO+glj2s4B0N8Kr9rySMN5+GSEVmA+A9vNITV0IAohQKHTNlS2ZLkQ0k1qFGdvCqW1wjnjLq3bTtkj9LnVb8ncqADIcU1WN3LRLZFBPNAYNCXwMRfGsOzYBaBiL/UVDs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774851966; c=relaxed/simple;
	bh=7/2jt3MiR29tu71W2kAToigR83F/W34kwzsrw6lCAac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeVIrwl29VbhbOtgFzMSZ9bgIBGP4AjQUkajIrEFa/o5P7dysSxhrj8lT7nMNj+iKbFwzrpCcipoJ37uBwCwV4StTO9cGQdWy68ig7Qtgz330/jN2juql4umv/9h8vHoSqeegFRstOAIOOT+xyDh6OqEJM6B4T+5NK9sKqFUVGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=sCFV6hwg; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="sCFV6hwg"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67c250805ccso1528794eaf.1
        for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 23:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774851964; cv=none;
        d=google.com; s=arc-20240605;
        b=edCaxn47ZLdhkGzlWhttg12b3cNdNnq5Ty4inlv1i2gIRpMZwzNWMwe3oh5dD8hdjJ
         4dYYh6tUZy9tTk8vfQ7fhtYNnmXv1TiUQynWCtbPd076LMFyJ7TvEBqPtw3i8Kq8s97i
         kLHjxrD7gHrYHWL9I/XTO5kGIbHuAbLR26kVZfSns01iCoRZ0DbfGozJ/b2eh1xSka1e
         LtzunAaeReITq9gbb85svtLYgPoF/vNCYaNozS09dsb+xPuzOWfwNTLoX6YmkfhsLXB+
         V/3tbY0MQUln39gBMfwpZZduxN8r4+Mf64fzeyxRvf3ZqOzyd0mT1smVnEVQvulHdHn1
         nE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BJL4Mjb1KkwQXihagjZYCJrbQf8hr8cjcUo/ljk+BF0=;
        fh=Tje/I1vJrcbuuiJoOWtO3LJgSGNdwcrBa4GsP6Ntrfc=;
        b=iVCm3UKcHwtsGkwFzoIvO+SDZDWSLjkKYuLRZ9MLnXAj57rx06S71J85KkC9WAhVj1
         /U66YBQ+hxTm64LkS/zZ3g9PSkfkbN60KrAkb7rL72fctv02aC/daSMwzEo/pE4JMBf9
         wXY9SxfVoL7hTILI0w8zN2VGBJpQKi8J9HwBDSZiR82I2LMkWpsIE7/tjNfQUDVgw4Cs
         35vTtt3qSb3lKTJmy/g0HbtFjzpE0TYcMNL7ggFujv3Ny0Cl7AP5RkARYAQPWtboD9MO
         /sxv8sUTDA1ssfEFS/2JTbI9e3XhrATi0436diaoGmdKNUScIb7z+jyNMfIO1TrcU0cq
         V5yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774851964; x=1775456764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJL4Mjb1KkwQXihagjZYCJrbQf8hr8cjcUo/ljk+BF0=;
        b=sCFV6hwg5bi1IhX41qbVoqrD/9ie+TAOXsMVpOLRpPBcgJJ/x6I73YygvsblrGHjGx
         Zs8eLT3ycWZ40bc/MXP3o/P4SLJ3jHQ9aey6xaoU2nyzWKC1HPs9gvRjIbhvS2ekBrtn
         fkl7rPsjk6NSziU6Qc9GONdmkPC7AP5NQcwMtYlzJ1Dfprz7IGosBB5yK/T17AweTfH+
         x3SwvkM8PxKmSo0Ycq96zq76rnXmv8zMRnaGiBxZDvqTdK2st9ead/O2U5p3vGsdI+cv
         1WNKW8slxQ7AW9E0636eV59iTWOSnn7bq/BwyxCUdc21j18oDVj0UxFiKruui+KiSWaj
         D8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774851964; x=1775456764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJL4Mjb1KkwQXihagjZYCJrbQf8hr8cjcUo/ljk+BF0=;
        b=cH2wDidnF+LnT08sUi5eA5LixZkOm5DO6Qyg2c/Ogx/Rw5FOYBXVkdEthigmId/yGz
         rtHLtKAdmMAEsIlE9XAR+b24lHHUu5M5oHBymmwFgmv6QkRmf4wxAQq9bY0VSRRsnThR
         xXm9GzO2ZZqmI0VcybE6C64q8CqeQGpQG9EWvz5nedKIbf9UUfXx7I5NcdLo8oE+noBE
         /81QBBPDM86P0rYpZ2oP78FGT8TuCEKlfF7vowg/idur3NALDUGNwKc8o6YrTdta+oMV
         Z0x8IO2mfdIsYbFzjMpw6W3Z+t0ksISW9Qx3G4g92K5FAJHVNNBz5MGsTueKZq04T+wL
         hjgg==
X-Forwarded-Encrypted: i=1; AJvYcCXSXH9qkGAKtaMMuNo4113qghOLBpyza59+TyUyTXLF8xBFlPlTaeOzzd31caWMsTFGp8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzafBAmhDIM1kH1RuzmQ6Ffo+42FNQ7V/rCrv555jdQxRkcLL/T
	fbFAMIazH0iyQDbU2VB3/AHnKxjF3k7PDfKeKAtfkUSOqUG1+iDrVpqiGMrTfpiqMr6gBNjVgOe
	PQmcsbXe7BHUXsGEeLY7IYJfRiEn8MZRN09nk0syOkA==
X-Gm-Gg: ATEYQzw38fJo+Tt2JMdjsWruMEC7raPp4XP4HQr+6wSlgwm3Ja4dDp+0ZUJZBVE1R8x
	dWU/2P6dJ9TMw8fx9d8nAIHUJyjug/6MHu7hXTBLTar0z/j4LdTp6sh2/8XJwhmbUddBGiquLc6
	UULphk7jBV2SuILPTPgPXKUYVAFRcUy9ELcRga6aPl6WyLJLcaqsbG3ax5I5+Sdvgw9CL2NArMw
	MHkuK0Pr6vkkxtgYxCCpPT9TstplTrDvUIicuT5s+1YbF08ou4fDVA4uiSb2DzGrGqgpBWdZve/
	mMxv/dHwuQFfprRhGV0t/EzyFvmzkfalpRe2ZnLeg1sujdu1KL/uH7Jibf9J/f6l5A8hMkmjxDC
	scXHLI/F7XtvzhnhZck1M7MAn4Q==
X-Received: by 2002:a05:6820:1746:b0:67e:1259:ab08 with SMTP id
 006d021491bc7-67e185f02a4mr5516515eaf.5.1774851964222; Sun, 29 Mar 2026
 23:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316141234007qSAOsesu2cSQsj-LA-qq3@zte.com.cn> <20260316141631543e3oVI3JGADhz5veSRD_eC@zte.com.cn>
In-Reply-To: <20260316141631543e3oVI3JGADhz5veSRD_eC@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 30 Mar 2026 11:55:52 +0530
X-Gm-Features: AQROBzDjrvHHyJxz8FHwAkL524ioyt0BKjQVXcYMmumnhJBSe00NB84q2suAzEk
Message-ID: <CAAhSdy0KBL1oTbsTVnqdcFmkcOBGs+kEyQWKmJ5iYj8MzJw0Jw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] RISC-V: KVM: Fix lost write protection on huge
 pages during dirty logging
To: wang.yechao255@zte.com.cn
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, nutty.liu@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 11:46=E2=80=AFAM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> When enabling dirty log in small chunks (e.g., QEMU default chunk
> size of 256K), the chunk size is always smaller than the page size
> of huge pages (1G or 2M) used in the gstage page tables. This caused
> the write protection to be incorrectly skipped for huge PTEs because
> the condition `(end - addr) >=3D page_size` was not satisfied.
>
> Remove the size check in `kvm_riscv_gstage_wp_range()` to ensure huge
> PTEs are always write-protected regardless of the chunk size. Additionall=
y,
> explicitly align the address down to the page size before invoking
> `kvm_riscv_gstage_op_pte()` to guarantee that the address passed to the
> operation function is page-aligned.
>
> This fixes the issue where dirty pages might not be tracked correctly
> when using huge pages.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


> ---
>  arch/riscv/kvm/gstage.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index b67d60d722c2..d2001d508046 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -304,10 +304,9 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gs=
tage, gpa_t start, gpa_t end
>                 if (!found_leaf)
>                         goto next;
>
> -               if (!(addr & (page_size - 1)) && ((end - addr) >=3D page_=
size))
> -                       kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> -                                               ptep_level, GSTAGE_OP_WP)=
;
> -
> +               addr =3D ALIGN_DOWN(addr, page_size);
> +               kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> +                                       ptep_level, GSTAGE_OP_WP);
>  next:
>                 addr +=3D page_size;
>         }
> --
> 2.27.0
