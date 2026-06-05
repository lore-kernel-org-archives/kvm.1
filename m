Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF70382296
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642158; cv=pass; b=P4DTpdILOBgMjcYlrf071YVDmCz+O2c9BH8Sd2+Yq222tPSWfzHAxBrntzdyPlSzVR99zMTVO+B527ANUSGGgrHEVkYL6C5YV17qV3QH6VPltLX1pvs7p97MDIja10h62nYa3CHrZHAjNI24VdCPuTDVE7k6sOPTLMzxppca8lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642158; c=relaxed/simple;
	bh=snaCOCDAK97fyO9F4+M2h4JAVuixBPBOsKp1/H9MEb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMrt9JrlaZFzzvbgksWeYx/aD4L2rag3k+syvJOl8dJflGv6frTHSCMImTYYdgIh45uxXlJWmFIXblwxtZE+wgIVCLUrWILF/BYdZsa6AbpGdf0KCeEWoUO12NgY2zKDR5c+3LLx4BKms07036TsMnW9ibtKlMhr46LG78TCfww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=KY1njjIn; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="KY1njjIn"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e690c213e3so1266888a34.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 23:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780642154; cv=none;
        d=google.com; s=arc-20240605;
        b=K4niFoEs8S1V4U7pKQgOrANOPmN4oVPb7qftjcQof2dmI9Hp4LGLya7O4k/cTxxD22
         83C4O3H9zc63rKst3ruhVY3Bse8h460yTMUzK3bHyUL8XZWcgzsH0K7/G0LpkiG11XvO
         ghtYK4VKhdaoeLSAhsbB1ibhBYWVcAjFmqMrzVEbOU7AWIDL6uJ2JvDPGyk/70vjbS77
         x2sGL2DZr0tG/+maszsl6v2pkqxlOMOUGeexP9Nnz62Hzzi5RzVd2MVaxTQlKkHp17ct
         3e1laMiF7ug3wt7gbG7xgZxrM3smKYVkmbVJ9NZMNtr/C+GMdaqbJRFlBgP8BXouQxnJ
         l49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6XDq1xh1XzOsuKw97N0TVXndgcJC/tzYgMFv9LJzmno=;
        fh=PldLLLclEviMRF5a5D3tzYPAu2j632iMSg6Rcr54xZ8=;
        b=BumorfBbzPHTUqKn6TNzr0rdjJrA6Bg3Lfavpqum6/zZDFXejl9MKte7tMsl32cFjK
         6tC5r03XU9+fxLLZnDNQGTP8vf9qIJdg8bfeeVrZ/TkeWenvbe7mQshNtitMbgvls/xV
         VKKhEOyaFNr1PHs8Zmjr12NEVjeqsr5QFWvaM5VNiPuXgoqpa43H/Z8LfULFCNodPUNs
         5TGMKp3ZILXUspGem9sGV8eiWJ9X3iimE2C5TSBQBZ9LSjFg6hkDCa2qVT6quxS3bi+c
         UT7ljvYuMGIej2hdFI9SLJFnPxIEcJBZLD4+k1J3/WvQpYdjL8lr5XNOQziKxQkvYX/I
         9XIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780642154; x=1781246954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XDq1xh1XzOsuKw97N0TVXndgcJC/tzYgMFv9LJzmno=;
        b=KY1njjInEpZePjR/6JkT+SiaLThx6o8H9pQCD3WXijC2R2xhYoT7ydVyEpH6R48aXw
         K6xVKvX/F+hMIoi3B8YwaNdKi2Du0iB1SflkPhoKjqHfJMq7BpPu7oK51LY3Pl3tCVKx
         quUEeWrNZ3a2dvcqkxiW3qbAIgmedHg4JqZWAmNC9lPe8RcN/h1lTvJNrOOTP7xIno52
         V3gjMkWH48tyb8tcKtB8me4Aqfo/4X1jv68+spjHN/nHppVFQs/NBvS4ekQ0HQjtelEv
         KUMWhdyNKdrUOnx7GmTOXZ6qLMiFko3UaUgl0yEMzyxgMVmuTRPe9O+ERpME2VbWQbMu
         qGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780642154; x=1781246954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XDq1xh1XzOsuKw97N0TVXndgcJC/tzYgMFv9LJzmno=;
        b=R729OkjyxjocjVBpz6JoGG1wJ3+bvkhivDV6/H1d3RdXoMZ+2BXZFJk9sgXhBeamEh
         acpZrPebz3awp6fuvCLl1aP5Bw45orkBjheDVBK02vzRokxdvTyvYokWWEzXjiFLQOhC
         vPpNgqP0jPIMAyN1g5clJ+hDIORbP0FgB8bskP02KYgWiIQxadaDAffUTbuESjn6U46P
         UzMMOidjOWqgNJgKy+GHTD3igS1bm61IKGBz2rbu8ClrGH579wKswdiFx2zRQub+Zlpj
         QANMvOsyXoZ6xLrDGBO2NZaQVVmru8I1MnVlgin1UWaymeRm7pV+P+txhEGOcBIBWy5T
         PqUw==
X-Forwarded-Encrypted: i=1; AFNElJ8m7SZlbGp/iWzGZU2yuTW59+du4SbuXl9IK6cPY7C0FWfxTa3LDPzTQBlcbXbz5gl2YFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXmgpSmK2etdCCRXqovSMoR58zw78NT1RZP5ZU5sECwYWXGvf
	qyadi9AGJ/M6lY51Twk5Luos4wE2Pife7maXAvQ6vaMdYYoCJvTeCoJZp6OlwYnzifyqT7ev5Ls
	sfm9RjoFnO+MdvG2c70+6WWWRZB1paLRa1DEpFUa6mw==
X-Gm-Gg: Acq92OEdVODv0qleXiWyMhJ6nPdtNpLX9Ao+wuUg3K1e1RurDew5Ohg75+J0KSNizPW
	fUynS4nH012c5kzr+A1AdOmEAt3E3MwqApYS3S3aeCh4+Vf5SBRW5L5vl2+enNYGjCMt3IrWc/g
	SW6dR96ZEca8KwpkpLX3aaarqJxxZz8bJ0G6Xfg7RjiLAa2/3t05LLv4ZPZ7mNcWFuYOsoHROnH
	H/+ZmFvUozeuOKedynbgnNGG6rORQ6uMU5gD74vIY1R1VR+eaNNR+IijPkTx+L9HkDnwGsgtI89
	BFVL8d1MSsiFsSAXiTjuGTe/LpMDJ9W7/DGh6UWzlwRRD6iovK7bSI79E6I4pXB1sskkebDX1PC
	dJsNR+EdbE3afzyEfK4lGNILmlyQNF3miWbSo
X-Received: by 2002:a05:6820:561c:b0:69b:6d47:8180 with SMTP id
 006d021491bc7-69e68c23141mr771817eaf.39.1780642154512; Thu, 04 Jun 2026
 23:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528113840.2629186-1-inochiama@gmail.com>
In-Reply-To: <20260528113840.2629186-1-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 5 Jun 2026 12:19:03 +0530
X-Gm-Features: AVVi8CeHnuM2CioMa5An9kIeCY2Cck7qIHe-9yB0iUqpIPQzrG2HNoEWHmj4vmY
Message-ID: <CAAhSdy096z4SdwQKBxM0ZtE5=i3UZrhMD-BcES9UdP5OgajqEA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Enhance the logging check for mmu mapping
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 5:08=E2=80=AFPM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> When enabling dirty ring, the dirty bitmap is disable, and the logging
> check is always false as the RISC-V architecture does not select
> "NEED_KVM_DIRTY_RING_WITH_BITMAP". Although the dirty log is recorded
> since the write path already trying to add the dirty log, the logic for
> logging check is broken and some side effect will occurs.
>
> Enhance the logging check for mmu mapping so it can check both the dirty
> ring and the dirty bitmap.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  arch/riscv/kvm/mmu.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024270..b5873bca9dce 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -142,9 +142,8 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>                                 enum kvm_mr_change change)
>  {
>         /*
> -        * At this point memslot has been committed and there is an
> -        * allocated dirty_bitmap[], dirty pages will be tracked while
> -        * the memory slot is write protected.
> +        * At this point memslot has been committed and dirty pages will =
be
> +        * tracked while the memory slot is write protected.
>          */
>         if (change !=3D KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_P=
AGES) {
>                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> @@ -433,8 +432,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         struct vm_area_struct *vma;
>         struct kvm *kvm =3D vcpu->kvm;
>         struct kvm_mmu_memory_cache *pcache =3D &vcpu->arch.mmu_page_cach=
e;
> -       bool logging =3D (memslot->dirty_bitmap &&
> -                       !(memslot->flags & KVM_MEM_READONLY)) ? true : fa=
lse;

Why is this not correct approach to determine whether logging is enabled ?

KVM ARM64 does a very similar thing (Refer, memslot_is_logging() in
arch/arm64/kvm/mmu.c).

> +       bool logging =3D kvm_slot_dirty_track_enabled(memslot) &&
> +                      !(memslot->flags & KVM_MEM_READONLY);
>         unsigned long vma_pagesize, mmu_seq;
>         struct kvm_gstage gstage;
>         struct page *page;
> --
> 2.54.0
>

Regards,
Anup
