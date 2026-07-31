Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E030D418
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 05:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476776; cv=pass; b=THLFvViFSaTrLpVi3dN2306cCs9OiheLTPtE8iQNPQerD1mEJ0Q9jF+dWtw8Fkxu7hnQq3pAj0iVfi2QVfWUnb/2UO6fKorsqE5dHBnUaLhZCg3qdsq+4x7GtUBYBpcZJvtan5NNmxZylkRtgtGK1rNC5CfVwLrR8CJPtDna4XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476776; c=relaxed/simple;
	bh=dOX2oJiDvFctrTMaZgDSRBdjWS60VPlFbcph9MdYbxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiPGpikeKG/U6auLhhN19n4aRkqNfBjVKInVJikVXHW4IMDb1CU+wzF95G9Ui3AQzfGIcTqFDGMvf8tPnuM8BZhBvKxaoVwyiWWuqlvDIy66/76VaWrVyb1jbsESAgayc3fkTw2k5zhpZ9zN0+XlohxdBvismekpWfmmQOkFlmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=EB2NkgeJ; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="EB2NkgeJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-476a130c138so629184f8f.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785476773; cv=none;
        d=google.com; s=arc-20260327;
        b=oXLSj6LItia2rWxUxroYvdbtziM1q4TxW4awnXKG3+tOJyFvZYAyLwZ8o+/tiMUv2k
         bDtmj8sJWoLarLQaAb4ZX5I802R8+h4eNm2OUw8nfPfrzYWOPxYCu1WOAHf8jwX1y13F
         vQ06YkfQvFIRXvEaRNEzqqKnWRFSwaQ++qRKasRKAHcF2nQzLqC/Tmvrx1haUUX83eKe
         ETULzlsY5PbWjDQ1wa0aU1z33tFWzvzZpVN0wfys9OaMp3WRt8JXgNH1h1EH8BdEbQF4
         5zHC45wy+mGagm8P1iAatoJaymMz5oRvpvxHwly8KZUJrljVmXhNzwrSvHdiT8pC+VUV
         x1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Lf8luiLEN3RbexnbiyQwUf8ICLEKYk0IAFsMs36M5k=;
        fh=IkY6lyUlAlDLmzktLxe1Yta25U3sS0zM+U+4F8plImE=;
        b=DMoCX9in7x95dGmk6jAOBXXHzARxGIXpGyG5tZV3ryTwP3vLl3rZ9pkbLqBWz9uaFW
         GPRdr/6sfaJQVVZODWYh7bQLEupSsfRUEjKuUM+q1bllEBulinBQenCc0lLRx+hHSH06
         Bb75CCK3Hr92hV5o4n1xzXl20o1V917XqssiIJBkoLk0J8cPj3IU/Pex9vvLyBx2ilL/
         kxdXw148n61dJ1iMNebDoMcUGiJe8gCP2gyrZCyKe1SB8l3nF1qV3IEj67lpyRE+jtBW
         1ddSM4Ykpq/9l7iSAiPDBZTlG+wFSHQ9hdEEODXeH3nZwy1hYr2fRoiA7N2xFR1+JFpA
         KHCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785476773; x=1786081573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Lf8luiLEN3RbexnbiyQwUf8ICLEKYk0IAFsMs36M5k=;
        b=EB2NkgeJFTwfP0dgHnURv47JTvMdR73rqc7wuoVlfHyeCgZ/jjqmPruaAT79+jaaRJ
         Q9NE0rnDLt7fZvNCN+u6kXcqtAJtuv+oBfU4PClYyXjJjm1gykfQrcAH0SVV22EXjOvG
         eEVE9WXuatJ8PPAwgpD2BTh1mVSZSgDd9yGwTZRqYu5pXkz3Hw7n39XenVpwQzwpkORW
         1eebvE93Ie0u9y9bT5jpkbOtRuV5OPEKTk2plAsKXNeFv3wSVskLWdGW1NugSkMgIYFn
         A+i+r4mT2oj8+nbPxQh9sfIzLfMgS0IUiW5wy76VsP4g+iYCWsETYpiAGItlaOYzNmC9
         Wugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476773; x=1786081573;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Lf8luiLEN3RbexnbiyQwUf8ICLEKYk0IAFsMs36M5k=;
        b=rAO/mOwUtjTGCAhQMducWmMJkrrvHn575Q81gxz7fl3ncUimzjf9fLdnMzZi3c2Dj4
         C09WkZ8eBjFrPC2w/XvDqLZeSdQ3hYP+8ck/TiuheCpRxjW/ghHkb58A5urw53Z5bn8S
         nEyj7mW0+A7gPFvRu5MfR/4ebkgd62rTqZ1INks2qRjWoSjhL5i6/kGxY0HM4hK7C2K3
         d9KzOR0VHDrZZHtIA1SUO5ajfovfaXrt0j6wcIS3HpO4hYF3Y8qHGCXOI3GkOc8V1SgJ
         obI9BLw1JJ4Ol2U1R7dRN5ivccj97ihXmuXCIdQ57nyLRyfu8SXMxCQ40VvG9MVrB5O8
         fsSw==
X-Gm-Message-State: AOJu0Yy+yWl2qj5W5F7yUJMqR5XmeA1xlgatGjxqhWcf7wU1RYWRo5za
	He/61PmCAa1esjqf2JB0DTtafipvwONeh89ztV3Fs47A9tES6e35eTBFcbVFVoVizRn+qzWFKsF
	25pHE1wuNYJ7lA01uHgevRYkdnWwdUumC4QldH6KfCg==
X-Gm-Gg: AR+sD10PvGXPuGRbYjbyMrBGEfbOa6Xqk/qAbEILeO5zUMu95i92ZC5WfZNUjPp2qaV
	HMwjIzEInajnjd0TItSB57b7GWgY+AizCQ9KOfVwpbwG3B2Ffc5WpMf3RZ6XVNKOyl++Is4TuM/
	jy6pOp4jUHOI7WKq/FI8UTJ+J1KCPFIPaK2RBjAlTgO01H0KEj5cVjBaJgijR4zz0vo4jPCEuWt
	2gq6iHEhjAt67h3id+M0Bc1HNDfdExbL9frlMrJ8XZu9N1veb8zd4SHCebEGsQGRTXShnuNJ9y+
	70tayjcL/kNa/nqurqdxgelm6Jerf/gtTDf50i6YI6rvyzHDiqQM4mq1Xq7/Jh9tsvXGuTMW8Id
	rZtrcnz7v2ZFjWw+h5C8rJJT2Xkj/7y+AORv2Mzne52hnBIJ/ZCaaeSvVW+1bcrA=
X-Received: by 2002:a05:6000:230c:b0:47f:673c:42cc with SMTP id
 ffacd0b85a97d-47fd2addda8mr1644637f8f.27.1785476773316; Thu, 30 Jul 2026
 22:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701120954.129873-1-wang.yechao255@zte.com.cn> <20260701120954.129873-6-wang.yechao255@zte.com.cn>
In-Reply-To: <20260701120954.129873-6-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 31 Jul 2026 11:16:01 +0530
X-Gm-Features: AUfX_mzN4xvGB1FC37c2_ByG_NIy5dlvHsx9qUPd9Sl6iIb9ehxwGJKWVKuQSis
Message-ID: <CAAhSdy0Juk1xdKo88U_gNMMJxT6niRHCFVfdznqWHcvpRZDaUA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] RISC-V: KVM: Add the eager_page_split module parameter
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-doc <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 5:41=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com.=
cn> wrote:
>
> Add an eager_page_split module parameter for RISC-V KVM, following
> the same approach as on x86. This parameter controls whether eager
> page splitting is enabled. The default value is on.
>
> When eager page splitting is enabled, KVM proactively splits large
> pages (huge pages) into smaller pages when needed for dirty logging
> or other operations. Disabling it can be beneficial for VM workloads
> that rarely perform writes, or that only write to a small region of
> memory, as it allows huge pages to remain intact for read accesses.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 +++++--
>  arch/riscv/kvm/mmu.c                            | 13 ++++++++++---
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index a68003c3599cc..b4c68a896fa79 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3047,7 +3047,7 @@ Kernel parameters
>                         Default is 0 (don't ignore, but inject #GP)
>
>         kvm.eager_page_split=3D
> -                       [KVM,X86] Controls whether or not KVM will try to
> +                       [KVM,X86,RISCV] Controls whether or not KVM will =
try to
>                         proactively split all huge pages during dirty log=
ging.
>                         Eager page splitting reduces interruptions to vCP=
U
>                         execution by eliminating the write-protection fau=
lts
> @@ -3067,7 +3067,10 @@ Kernel parameters
>                         the KVM_CLEAR_DIRTY ioctl, and only for the pages=
 being
>                         cleared.
>
> -                       Eager page splitting is only supported when kvm.t=
dp_mmu=3DY.
> +                       On x86, eager page splitting is only supported wh=
en
> +                       kvm.tdp_mmu=3DY.
> +
> +                       On RISCV, eager page splitting is supported by de=
fault.
>
>                         Default is Y (on).
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 29a7ac023d4db..a534f596c8ca0 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -16,6 +16,9 @@
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_nacl.h>
>
> +static bool __read_mostly eager_page_split =3D true;
> +module_param(eager_page_split, bool, 0644);
> +
>  static void mmu_wp_memory_region(struct kvm *kvm, int slot)
>  {
>         struct kvm_memslots *slots =3D kvm_memslots(kvm);
> @@ -167,8 +170,10 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct =
kvm *kvm,
>
>         kvm_riscv_gstage_wp_range(&gstage, start, end);
>
> -       if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> -               mmu_split_huge_pages(&gstage, start, end);
> +       if (kvm_dirty_log_manual_protect_and_init_set(kvm)) {
> +               if (READ_ONCE(eager_page_split))
> +                       mmu_split_huge_pages(&gstage, start, end);
> +       }
>  }
>
>  void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *me=
mslot)
> @@ -238,7 +243,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
>                         return;
>                 mmu_wp_memory_region(kvm, new->id);
> -               mmu_split_memory_region(kvm, new->id);
> +
> +               if (READ_ONCE(eager_page_split))
> +                       mmu_split_memory_region(kvm, new->id);
>         }
>  }
>
> --
> 2.43.5
>
