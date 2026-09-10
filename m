Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBBD33986F
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051654; cv=pass; b=aZjPgzxXjNgvsuVogjE+jE3a8XnygKQ77dLgEeZRlhHQP4DxNWlkdQ9OCnwH5frqxe+LKBTZFBKXUBvqqTtnqKHqmPzS+tCXR2Zjk6pu0dc7BYURjav7cdwJHtPiZHJK0GQSpEQSIdNT91g7En92MjfNLjE1WFKb4PWfCgNNL+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051654; c=relaxed/simple;
	bh=Okm/jzRAvTBw58BaCq0sxyEyxRDfCrz26IinG233cnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsS0lPSFJW0vDenCP06xlFQ0X2zBIOU73KBcdyFefQTddKlY1eiSzKPBlB/un38TCluZdmAOaclg+KC++yffB+8AutVCiiQDPCE4DKLKKEGgkbKbagz64aIJSrZy/wAqEnTjFZ6a1IEMmMUUXe5499tkSK+NTwGo61uYh3ETt4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=u+Vz9SeE; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="u+Vz9SeE"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48434392b02so1261687f8f.3
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 07:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789051651; cv=none;
        d=google.com; s=arc-20260327;
        b=OYQiHbKiJhj4OxTCu8qzJjbww70+QDXahCFdPqblW7QuZqZGGgCQgsjoUnved2vllz
         rtnY1ugtrjYs9OJKfWWFSwttu5f+ehvc8clnWri1iK2JQ4K+cQNChiq523wJrrZU5D9o
         UJXL7OZC0z8xq1dCPN6GLAyBETdGSxl+pt9rmprS3n6FsmoOljSyzNXWYn+MMvzqqX0A
         kZQ3xmodmefMBDpkVbZ0jEOs9Lp8To1yA0yLZ1Fk+sqwoj7CDTVeuHGoTJeYCRoZj7jk
         kzGEbqh0/nwPsyq7tcJy3D02kyey3aGYvFLm4HdzCOT5h0mmhHDNevKKCFSGe3+yVOYT
         a8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Fj+UUPwjPg1SwSshTqSVQg8NUJ6uD77121d863dA0c=;
        fh=gU9t3ECVDiZ4dNQPI2s1191erq49+BcGzO3vE8uhcdE=;
        b=c1M7wBtH4Eq1iVOyRtFX6Mg0lGRy/+eBe0T4POrh/lEl41TbaPuL649+vfB6ujW+1U
         zj5gzwAVvmJMhPXObdeAsL1rzkLfsPDrU4ckZEXKnrWGYXDvevFTI0p7G4a2DQ0b1XyU
         O2D8uADWdVBOrSEdTFdQmrwOUhgYn20KiC+c1DlREVr1TwTMjVYOnE3ZXy6JcKeK1Y0H
         LqICoN7kYtHNYp8BZ0WYxvpG2JRSvNl1c6CGSyy3IcMimk63pZzYxRMOq+CHqPyEMm0f
         ee1mpgtR+ikgTW/KqrkJcKPNhQ3wsEa0Uhlj7U57zIlSUfR7IIdct4dYz353GcQpBcU5
         bU6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789051651; x=1789656451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Fj+UUPwjPg1SwSshTqSVQg8NUJ6uD77121d863dA0c=;
        b=u+Vz9SeEUFgLgqvkphmPxt2MBqMzqo2OxbN7B8UqfxONUYOQJVwXeVIKa9IK4JcOzk
         MTb6s46WtcMwqEH1r9xVKf+NL/Wy+ZYsHO5Hq4zKo2zX6mZ64vN7m3OTv4UgNJf0pwsi
         8KnOFF4ujhBHIaHVOH+UeGooqTgFWB6Vw+FzHX+MTClIAfp/rpzhD+lO16m7jRQkzfAK
         VJg+npsIOwqMNuvHNtKrVNdHTibNcVYECxP5VhMrXQ54WQ3TSdvauiHYb6clYzBcZSAw
         wg2WRlFlw/Yi1vXq/f4rEDaIknr9jT4lQtSgqUtTxTkTyq1SurOkFKm//0VnAUm6S8BM
         q3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051651; x=1789656451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Fj+UUPwjPg1SwSshTqSVQg8NUJ6uD77121d863dA0c=;
        b=ZMX85llV37sfUTyhnhu3AZnHjF+toun3A2equaGTJDzp+ZxRFyCON/tQCPlh85Wmmu
         lnnYcci8zd95ihDD+zCdGe6J1dmjW/yTsGuca1j0D/1kOqT3AhMZhxeOVEEhb8cPXZX2
         O7WNa4+9vw/UfylYZi/3+T7gH9Y3IBISAoPkgYh/MlFUO91bQrkNw0CvuNQftZKKzcHc
         f2ncoTPaaiYxP05HH4rdjbrljzrrEC5C05t0JjwNf2+1vWFtpqG2xrjfir1eIVuQYxn2
         g3TtygweZLs32QIzyLbBU8hS+l20rjpzx+y6YGgkLp/78n9P8/YLWkID3THRLZGnZqUX
         X34Q==
X-Forwarded-Encrypted: i=1; AKwUvBxvD7hTW+2G22FbFLBXxIWvECLD9lM0655F/BWxM/qVw1DBAdBIf2Pjg/V/2MSLUwyoYaE=@vger.kernel.org
X-Gm-Message-State: AFuF++lHRCqWo7/EwpWlXqZTNIoRqj2/fL6SdMD6TbCV5fTa9cWc63Dq
	aLSPTJNWExZR0UGIRh1NQW5gabbzC9ielqoKJeQxHKNATvyhhh6mDuT3qBKD1fr4/yRi11zrlze
	JCqUwOVHHWMSSLhCizl2yqQNXrU7X/y/3+OntNZKAqA==
X-Gm-Gg: AYBFou2LLsZqDxahOPIK50a7MpU5Gps4UwtjWg/GL7PMwRWegbjiMG0E+S+OJac/5fK
	JsoPZpVo6Adz/TKRkRBg73OcChKSrptUp6KQuHZQ/D2PLGmAkCNhdId3b6vGyZHjc9+0p+yMamy
	u3TAGjNzIBVYy7dfXPdwAsUZ0r7ybL7AQvwcH6dIszAFlgVEpSHSzDoEXAeMGX6kdVlRcsWnq2G
	qZV3fJzHjNbNmnLptbf95bg+tP3akLFcw+KatGcMrNnq7uR40xnko75RUCRYn4YgiNeOeP6ekhB
	R9zVgzA/UZ+jRd8qvJJ5AZbroyaAVNDHJqDAXwk6zGZa7IQnZxspblWtJhRsOKBP9E9GDrTULqo
	rxjiKt5du/5fDKproUFEAYQZ7AxYLDNl1PWSVihTOyq35goCL0QMYPCIuv2RpXsohgH/pk6l21m
	E=
X-Received: by 2002:a05:6000:4801:b0:482:f61c:7cdd with SMTP id
 ffacd0b85a97d-485ba5ac39bmr18503655f8f.4.1789051650755; Thu, 10 Sep 2026
 07:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826075009.68952-1-min_halo@163.com>
In-Reply-To: <20260826075009.68952-1-min_halo@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 10 Sep 2026 20:17:18 +0530
X-Gm-Features: AcwNN1XuamBEFO0Lo4789f27od5JxTL3ZDB6v9YGVoHyrw05uNbK6gYYJBs_SaA
Message-ID: <CAAhSdy3dymMWApBRrSw4YveTC8we8d2QaQ_3MHM0rp=BeP+AZg@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Fix NACL hfence entry update order
To: Zongmin Zhou <min_halo@163.com>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Zongmin Zhou <zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:20=E2=80=AFPM Zongmin Zhou <min_halo@163.com> wro=
te:
>
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> The SBI v3.0 specification (section 15.1.2) requires a nested HFENCE
> entry to be populated as follows:
> 1) find an unused entry with Config.Pending =3D=3D 0
> 2) update the Page_Number and Page_Count words
> 3) update the Config word with Config.Pending set
>
> __kvm_riscv_nacl_hfence() writes the Config word first, so the SBI
> implementation (or NACL hardware) can observe a pending entry with
> pnum/pcount values left over from the previous use of that entry,
> resulting in incorrect TLB flush ranges.
>
> Write pnum and pcount first and the Config word last. Since the
> consumer is an external agent on coherent shared memory, use
> WRITE_ONCE() to stop the compiler from reordering the stores and
> smp_wmb() to make the parameter words globally visible before the
> Pending bit is set.
>
> Fixes: d466c19cead5 ("RISC-V: KVM: Add common nested acceleration support=
")
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as fix for Linux-7.3-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/nacl.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
> index 9aff03c4f667..a5cda9a65156 100644
> --- a/arch/riscv/kvm/nacl.c
> +++ b/arch/riscv/kvm/nacl.c
> @@ -42,12 +42,24 @@ void __kvm_riscv_nacl_hfence(void *shmem,
>                 }
>         }
>
> -       entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
> -       *entp =3D cpu_to_lelong(control);
> +       /*
> +        * Per SBI v3.0 section 15.1.2, the Page_Number and Page_Count
> +        * words must be updated before the Config word with its Pending
> +        * bit set. WRITE_ONCE() stops the compiler from reordering the
> +        * stores and smp_wmb() makes the parameter words globally
> +        * visible to the SBI implementation (or NACL hardware) before
> +        * the Pending bit is set.
> +        */
>         entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(i);
> -       *entp =3D cpu_to_lelong(page_num);
> +       WRITE_ONCE(*entp, cpu_to_lelong(page_num));
>         entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(i);
> -       *entp =3D cpu_to_lelong(page_count);
> +       WRITE_ONCE(*entp, cpu_to_lelong(page_count));
> +
> +       /* Ensure the parameter words are visible before the Pending bit =
*/
> +       smp_wmb();
> +
> +       entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
> +       WRITE_ONCE(*entp, cpu_to_lelong(control));
>  }
>
>  int kvm_riscv_nacl_enable(void)
> --
> 2.34.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
