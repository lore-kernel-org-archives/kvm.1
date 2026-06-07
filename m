Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061D28727D
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780813245; cv=pass; b=nNZRPMg/TXmdHGbKKaZlQ9oy46CMxFHM7TpKX3lDj6mCB9qUk1V0l/0gat0xkmbs9n09JKefS/9HnuaLkMEwf4zSgbpY+bmZT/r8+l6aSlStWMZ8+05UOX5uUhE2mW/eSom6VJ22dwU+AQALjNg1IHUTux1rmaj6+C8a1oBIzz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780813245; c=relaxed/simple;
	bh=RBEbW9acGR3F74aAC6RZJJlZMlviGhnDYXuEhGu0fxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9F/D2ymPgJ0pdhM1GfiS8k2fJodaVt/9B0piBolvAaw1fTiQrnFiKh0hBbL3zkutNY7f/4SxovqQ/PINOCfM2+hI4ajoQ7NVovXTGjH2HpgCRN6kexXA4lLVcUSJb0sh8e3r04sSaHo0JDT88EADZ/sQMRlRfBxgPXuNs5j0j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=hjrmLGNb; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="hjrmLGNb"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43d16405b54so1430754fac.3
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 23:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780813242; cv=none;
        d=google.com; s=arc-20240605;
        b=M+yyRrXiF2zO7J20LWE5SC+bycjchck3ubtgo//drJkguKyHSfG2VXChK2CGJtKZKo
         9E9IVJNVVUkKahh/bxDMVA6TQaCjTheEK0qDIphCJ2qgNJ1bgQl1taSW7oLZzrjy2ev9
         Mh0+DxHbIvkwNgHdG1rx+ddNzy8inlvDjsdk23OQklPxYqOComW46b2+NhexIitV8dtD
         0opMWJ/fDiBVVqY4br7nBrAY3DowmnDtvdWowFfeORfMMEKRv0CpW1+Y/morvYXHzj4R
         3hTUYTeYyEl/ROznKmtMaXPs9KGvM0Jd+hSosMO237wCDyncKrCjVMjuza0QAVbPyGmy
         /Tww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vhujZ4A3wvVpGOkzPEzqlti0wTqzoqDWtQRHQ5CXPug=;
        fh=W7iAAKsKS0745pYLiXOAPw/o9CoUjEd3rftaZ7XLa4U=;
        b=ImTb6cFQPPouGMXCKVDixCJp4hWzhsYzWm57nYiMYFDxu0mb+bKS4TAYmhpXiXjoe3
         0b4esxYjTW22uEKmu0q/LbBhvpAo1yyHrf4W4wWfCG9LOUSwecRF7xD1DBrY/BUnHm0i
         2YIX6U/rUjUTXMx4Q54w43WuV/6o4j8yhnstKqLThM1UiNq5aPth1nPcIjbAQ6bj42MR
         Yp0I8RCxQZs2KDJgko/5U5Yfjy8YuHmxeZlCedT19y0V8S89HchJZjga46rICyKKaodA
         TTd/GwD7bxAXpXDLhKwDvXseWMnKGtHO6iUrrfftD2pJVhEACRyaojptn6TylELot49g
         p99g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780813242; x=1781418042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhujZ4A3wvVpGOkzPEzqlti0wTqzoqDWtQRHQ5CXPug=;
        b=hjrmLGNbT/OpmtY3XhcbSmGk4P6vFNq/Df7LtI3kV7bDD3EBaW2F4LI5XLk4vMduEv
         4Xd2wJZMVKsEbGXUzV769+qowTKwI6Ppi+PHEiz0c92C7jlSBGObHT4cjYnXFNmcbYmm
         PfUlk9wliGWPcNm1s2obTtmj+TwWcku8Xin4h+erFGfDiOysvYlPqtzW74MdMo3H94nG
         55ka1CfDwHpPRCNlCfZzW9ctXEyDNhNSqa+ecglksWZ13FD4TGMVu9hOPPqw43xFGBhY
         +xhHBjazVbRC1B/C3nrFikSVEHsUZenbreg9kdhX4HgB6C4k1B4F4ciE55vUXeQZK6Kn
         zbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780813242; x=1781418042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vhujZ4A3wvVpGOkzPEzqlti0wTqzoqDWtQRHQ5CXPug=;
        b=dbmkkRdCPuhln0SIj9zBkvSH+WJQiyflQO7xLK/mL4u13tHEYxyncgyaoGSSyYfFI1
         mmdq/DRZTXyVpXe1dbIjk2DeiUsQ13yO2Gny/vMSlFKd8fVUTmDIzQLiIZjt3RDvS5hP
         E81PZ2crpucac+rzM+lVxM9Q7Du2QVaYPJAFa+iT+YxzTVN/Ff6rYX4hkPu2lOkJXWrS
         bHuCRhZoLRxOofZm4bFJJ7Dm3AUjXLPPOkKqVWL4FINuI87+La3UWuiA5365pH8aGLGz
         uL1N0emmv9D8Eds+kqXjBxUX5eBM97duHV7ry0+qgW5aI+VVmfyegUKRjrIyg1bA9LRA
         cceA==
X-Forwarded-Encrypted: i=1; AFNElJ/bRj2Ka1lpttSqKgkpcsOn41DuWxJ3naGMREhSVg7gdHcnS/NNDi4CDj5lk3vXV/LmufI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJUndCTAU3EWC0D3Mox0FgsEM+/CHqKTnrZr8A2h4IckbjShY
	Tm0TeatXkoxSFRbJ5A3hYU9HB0L2IFIFY6eqbw/ujfL79RLeuvHMF23VIaIPfCGn70qUazbyg7N
	xkoU1lBXl9sDlGCKFOCDGTopXph2RgYHGzlQz8JxUXw==
X-Gm-Gg: Acq92OGDzVOcUEHDKbsKE7VuKyZD2krH+cxR0iiP3X/uyf/bKYwucwHZTXiOLrXrhWG
	d/LSLtJapQhXhuq8/dTPBO+KsGTNi3FPsjKn4G6ukthgk21Xm1h19jdJcqYPHpYtxbI+xcW2bUh
	WaERf8Xcx4fbVCan7iB4/j6ByL5MMXSog8mbuyO4fYTHfEgGsSzYC/mAz99Ts+nYcw8CH/g2DsU
	PaYKZO03qFVzWuPjY+ltlw5FHBtMTawwmzwfkoN/K2CPhmdBAzOaAsxPShH/rtbZneFtXvPKC/Z
	g4tyt9ECw4EroSdUYUldhfW0CZonnK6EO5MrM/As6ywrNC86CRUDfVwWern6Fb9xJBUFNI+HvbB
	0jNDPIxdE1fUhdRU5bLfGdROxVpBDdW+J72jjZA==
X-Received: by 2002:a4a:ec4b:0:b0:69d:e28e:2fff with SMTP id
 006d021491bc7-69e68c51309mr5003541eaf.40.1780813242384; Sat, 06 Jun 2026
 23:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604230317.30501-1-atwufei@163.com> <20260604230317.30501-2-atwufei@163.com>
In-Reply-To: <20260604230317.30501-2-atwufei@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 7 Jun 2026 11:50:31 +0530
X-Gm-Features: AVVi8CfslfRV_nfpl1lMc7NvFioZQ6rmEDmBn5uL68s_8AeUTuE046d7lHCFWAE
Message-ID: <CAAhSdy3hugWgSPKiuos38-osAFWkvQ3fHph9AMhGQZZAAf+pSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_wp_range
To: atwufei@163.com
Cc: seanjc@google.com, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Wu Fei <wu.fei9@sanechips.com.cn>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 4:33=E2=80=AFAM <atwufei@163.com> wrote:
>
> From: Wu Fei <wu.fei9@sanechips.com.cn>
>
> The current gstage range walker unconditionally advances by 'page_size'
> when a leaf PTE is not found, e.g. when the range to wp is
> [0xfffff01fc000, 0xfffff023c000) and page_size is 2MB, if found_leaf of
> 0xfffff01fc000 returns false, it skip the whole range, but it's possible
> to have valid entries in [0xfffff0200000, 0xfffff023c000).
>
> Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.2

Thanks,
Anup


> ---
>  arch/riscv/kvm/gstage.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index d9fe8be2a151..2b141a78ecac 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -429,14 +429,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *g=
stage, gpa_t start, gpa_t end
>                 if (ret)
>                         break;
>
> -               if (!found_leaf)
> -                       goto next;
> -
> -               addr =3D ALIGN_DOWN(addr, page_size);
> -               kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> -                                       ptep_level, GSTAGE_OP_WP);
> -next:
> -               addr +=3D page_size;
> +               if (!found_leaf) {
> +                       addr =3D ALIGN(addr + 1, page_size);
> +               } else {
> +                       addr =3D ALIGN_DOWN(addr, page_size);
> +                       kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> +                                               ptep_level, GSTAGE_OP_WP)=
;
> +                       addr +=3D page_size;
> +               }
>         }
>  }
>
> --
> 2.51.0
>
