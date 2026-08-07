Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F84756C4
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120841; cv=pass; b=MoNSPRf5hGCb6fme73N4yycZt0IUpIpa0ExM4QrrpCjPBos1at/QImlhZJay22YWbzjo5OS4zadxpL2kYbCWqn7IXFeNkl8t8SvojgRl5IS2eIIrIUDejGsvci3O5ZiEQ8V3L68xftS7sLoegWdo6O9HFRmHH+CHxTYNZo1c6Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120841; c=relaxed/simple;
	bh=ZcC9zQ8CA1OOO7vdGCOU8ByGt7F7GkjE8325WF9eOvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSyQ0zAk7kJPOYEfIQgnIphTyTe8R7GRkDujRhMunm04Q3W1Pn/fmjDN03r2w/HSEipQumPDZyNA0eNyQYrb/U+kcxB5U3bfpM/HsxFhGcZYKtP6t5ZNdzl8xc0hLFAMjkDkoRsr5UQJHfLDyi31O7//TIRkVwfP/+PjYenQUUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=h2vS5C69; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="h2vS5C69"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f904e80eeso2996968f8f.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 09:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786120834; cv=none;
        d=google.com; s=arc-20260327;
        b=YsKL8YNPpI71m6aPRuW4FhsVqVPQUOEl+0u5k1nNGuAtS8zlzPJeSg4MTFxzRd9O27
         3F3uDmkCj8YtdgBzLMFqV8dNmIhmmRTtTkHatPa1KmmQegCJEv7AUVCPTfIRHm+b0Mrh
         +F7m6UwkMUTTwYHqViqHLE/r44NBpIx19xFabyDjVgeEP2Y1WTRZlo5gWd6iuM4hNKUj
         BBPi5vINUhgmWYFf7m8PN5iT25kQWqgrBti7UZ7WZEwuJzmgbWYD6/1Yp9LCHQl5Z4o9
         n2iT8m09DX+ly1r+PQWa8OIU9QP+I8YRuwLk2FEJFGZ4p7uexiUNZbg7Bssmq/1BQZUP
         z9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ivwd8b6C0kvbJOzxDYFzgKuMZMZM9eaqiKpZX0jjZbI=;
        fh=sPToMzKiRLn2xQwR7dUz1xwfTMq4uSStCcjVLIgUuZo=;
        b=XeuTFO1y3PRI5YplTwtEAr3cPvl3JdXQOAnU61wh5r6oPzJevYZaVumy2qyKNXLi0w
         gq6qDBbk+vrRvu5/Rmn3PHiYm0g6U7RsI/EjJW6GhtL3tgnPuA4/5d9/3zBw25L34BM0
         vECf1ZpSZF8PumUwyVpwDLVQr5a4i45PQVDHU69PAjQ+kIcY2H6f9EyBT7h7y077uKsr
         iEJdwEs9w+/JM3LSpB7F4EUkm7rzYzZ2SV2EDgMVSE7f8IIH/WPN67v/b6R8H74vEn+6
         m91ys07GUtyDjGl9KIH05Wcp32MBjidnIzcUNQNYBIsg+krj2T4/4xrSknBHob6r6Kr9
         rCzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786120834; x=1786725634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ivwd8b6C0kvbJOzxDYFzgKuMZMZM9eaqiKpZX0jjZbI=;
        b=h2vS5C69IOb5KJQd/sizIz5oE2Z3JS3GLQ1jhGlsBpZLZx+8X+08Cra0yZBzbkWqB2
         L+k0BV9hZuvsf+gUJo/t4FucHaEA1flVY3kpNrqCs4GHiYSNe9Aunii/8PjWWq2eWgFq
         l5F3j40znhl0YQNMylxj8xKoa100FFgWi/zcE9mBjAa5x7sNj17RK/C61GGwdnJiQVXE
         h8kI8PV8RW+FlFbxj7J9FiFRvp4aLckfZVnpkGx2fDY/pDYGRBChfnhJdIAzl4pg7JPa
         r1ZETHHigvV7io+miLhJESW/HlAeJ/g2VscpKse2FjbFZBILDIdGZz5OoOMa4CGwWWP1
         hUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786120834; x=1786725634;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivwd8b6C0kvbJOzxDYFzgKuMZMZM9eaqiKpZX0jjZbI=;
        b=AaCzMU0PbCe1wq4vAbRnirZsQ8gLMkInzcqNN14rhm+gzO7Oa4agh24Ebb3aCTsNHd
         fRNHsgD3pm323h95YhP8oqCKH99dFjtwUtDD/5cSwbhCAVuYj3EiUDBCNZynH/duVNd3
         PumbqWK58UZJJzt2/RM8mGCrmJtwfn4Rfpw7IeNuwn9MjeV56jCsDWVCAhBS4DMYrlyy
         fTOII9/jJ30ujgvNDDkkC6WyshIdFWDfMWlwZCel4Lhu+ouq/WecyKcCuXa/JgFhEozx
         SdpPrYKqDNolHMdJ3IZSxZqpjyXEanZzOkJ84BVhpE1mc3tLUNpcyjjt0OyCQnDWN4Fv
         4xYQ==
X-Forwarded-Encrypted: i=1; AHgh+RobqDIfTR3Lnp8fEQasrM/LGOaTTnZDON2PLnZHsRdwfk4VeVfilXfxruZlGnN8TP31oJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyORmKPyQNWG4yGqxveYzZdKtgjZB4dDCW7bT5TBV++OK5OpkVn
	KedLz3CkND74dQL2DLCRc10O94cqU4YXKlI4q+oC/BmCuQ/h+Yz/jdZzHdB7XdYgQb5vLZlREGg
	srfxVkmB2+2WIX1ijF+wau4nRJuP+wEkx28UxON2M5A==
X-Gm-Gg: AR+sD1244SB8Gi1SI6rw48NvEb8gPyjgImAsg6tWkUkIxjZk+2GFzwPQ6te/dh4MLwJ
	pRtqd1ju3GCcvj0QgtRm19X67r6d6Lj0HPKvZYMCAueFlHlDDwgFQSedBOrYnUkykTlhHHSoJ9K
	9XmHlTgh/7Vqot+bCMuXCH/UosE+4DiBb5iB1DzCQ4XK1YhrKki6sTJ+2d5EG941yu9T6ieliYK
	welZ+V/H9G7Ds2NqDSlHsuVXN/bKgvKZDyqgQo3x5wWplzPAK+ldqySJcaW1XHqKxAIjnNidilU
	7j7odgdumVDerixvjk/2SVeYrjvCKvZlouuuoPhfUZjtEq8ypKrKdfg6f4/NcqgkPkc47IRO81d
	0hGzt9QXfZGxzauq4osPLo49hYR3WdyDaUSDYKuGLn2Vy+0Hzd4ELClwmJUvsfoMR
X-Received: by 2002:a05:6000:491e:b0:47d:ee9d:90c8 with SMTP id
 ffacd0b85a97d-47fec4e2910mr44316338f8f.3.1786120834611; Fri, 07 Aug 2026
 09:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718040000.005.6ede2881-caplitmus-rv@iscas.ac.cn>
In-Reply-To: <20260718040000.005.6ede2881-caplitmus-rv@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 7 Aug 2026 22:10:23 +0530
X-Gm-Features: AUfX_mwYx18eRgllpSc1cuoaEbtIanIWNOsGbSu5y1XnuqpHv0835ozA8nP-WMI
Message-ID: <CAAhSdy2j+0sV0_XD=ieDgSDPTK8eAxJBy6EFjR+yFxT0XH-5cQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Reject overlapping AIA IMSIC address fields
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 10:05=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn=
> wrote:
>
> KVM lets userspace configure the IMSIC guest, HART, group-width, and
> group-shift fields independently. The individual bounds allow a layout
> such as guest_bits=3D7, hart_bits=3D6, group_bits=3D1, and group_shift=3D=
24.
>
> That layout places the group index bit at bit 24 while the lower
> guest+HART field also extends through bit 24. The IMSIC address helpers
> later consume these values as one address layout: aia_imsic_ppn() masks
> the lower guest+HART field and the group field, while
> aia_imsic_hart_index() combines the group and HART index. Allowing an
> overlapping configuration therefore gives one address bit two different
> meanings.
>
> Reject group-index layouts that start before the end of the guest+HART
> field before initializing the in-kernel irqchip.
>
> Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irq=
chip")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup


> ---
>  arch/riscv/kvm/aia_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index be83c2d5fc308..0793d4d4cf5e3 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -248,6 +248,12 @@ static int aia_init(struct kvm *kvm)
>         if (aia->nr_sources && aia->aplic_addr =3D=3D KVM_RISCV_AIA_UNDEF=
_ADDR)
>                 return -EINVAL;
>
> +       /* Group index bits must not overlap guest and HART index bits. *=
/
> +       if (aia->nr_group_bits &&
> +           aia->nr_group_shift < IMSIC_MMIO_PAGE_SHIFT +
> +                                         aia->nr_guest_bits + aia->nr_ha=
rt_bits)
> +               return -EINVAL;
> +
>         /* Initialize APLIC */
>         ret =3D kvm_riscv_aia_aplic_init(kvm);
>         if (ret)
> --
> 2.43.0
>
