Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922163E4C8A
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766200; cv=pass; b=aEG8ChklG6TmFnlZZCcO76O34U0duKY1+8wA0ZgBBgmAJh4nGgBRqFQCb8g8rfznpWeThx9e2JyIR2w5k9edTAOAZAE5TENugCNXfT6/4c5Lj89+fSPcw/LUt/RpDGwX1kK5fZ17dA3Tc4VR9JhVltPWid2RuK9J+97DPK7evxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766200; c=relaxed/simple;
	bh=RH6MmBu4AiFDfv1jMBzWT0xrc/OrwfjUvCkcyDpIxtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipIp5AAWKjAPCgQMuMchQMcENe3Er3BpKlSw/7TmynAV5j/y/Paf8aB4EgeI3rE1GkApwG7gY9NiiGheLVLhwLO6SomoMtj0ZWYNMJu8Tn5Ad1JShK4dXI1ejdIS0y0e4UmkKrDShCvwLw8jjuupk13uII8SCtdeeZyHbuVq+YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=LpPbCTHl; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="LpPbCTHl"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6948e6bc30cso2437161eaf.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 06:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778766196; cv=none;
        d=google.com; s=arc-20240605;
        b=I++PuFblrwISdZr4WbnHizDyMrpt6xKM58q7IMR8g2v1TAoncubw2RZHc9Bn9Cavxl
         ywZCf6RcdTEu7DNxSuLHccdHkjV7FluyDsbyltVpHOk46ROJUN94L1lL4HEjKp1Vv4f2
         0ejWCAZhwhNQObM4rK8l6YNXd+n8/kVnGy/+dlUENplHKvcm4q9NAqOJL1spn6BBzyyz
         6e2ENUfWYp3yfzoYyKI0WuL6RaTnIxz7NL19oMhaP1036bjuBoGBkfl1cOtACsfE/Yn/
         SVtDNRJBhfaHWk2Qp9KoBCGcPbkUhoR7VJlrBXKlRlVtp+ETvGyMsIIwRmG0G4nyvi1N
         icTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h6d8VthjlyqVFZ52dWXLfCKwuTt5I0MIUqg/9Vw2be8=;
        fh=N0IgYcaM+hOTtz77s++//NI/xOJHxkXUElDp3LwUSIs=;
        b=Y7x5BNUzIWSKisYYifecr7ecUTzWwwVo6O1pqTxURx3bEnlwzhZdtq3OFHMIat45vx
         87rAkUEhkOXK3LyZMlcCuM7LSkMIp/IR7fKGjinF7Gf35WV+glRaCXnFB4CGrzNfxENZ
         6cLgg0I8XtHgqpm9Mfo7LHGT8SuQ7xYxPx5SW+9gtyMuEB784R7Zn+SVFMw79O233fS6
         xF2njv+boa15u8YzCth6FXc4u+/bfjkAuE6fsl1wjZGAYQEPIjARyh8nTJ+On9o8V7I8
         1ZwKmKRYO7HRnGuIYrAH0jrVfh3v6G3va0E4VxjkfEgeIxWM5PPsA5iV0ci7wCjmDbxf
         IviQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1778766196; x=1779370996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6d8VthjlyqVFZ52dWXLfCKwuTt5I0MIUqg/9Vw2be8=;
        b=LpPbCTHlJhgnJ008k2Y+qalg7IrbZ4gl0JLy7BEGsDvm7sB3Q71mYz0FAKeBJxGrsR
         tQjfXqirKMSWwusEJJ/ZnaS3m4CjKibiERH8bEv7out9AJRlLjM5QBL0/kA8tQbd4fWL
         1X2xXLSuEgMJCLCJzTpTFJvOhefRa+qH3rFr2HT+HGB3hkeu9wfKRauu26E4gKRzKGEz
         oFuddwMeES8plJTH7CaCZUbpL8E2m7d357w82GmIDTSA9L4n/iakhEn79FVAk3a17Crz
         aqv8SH1a70tMDtupdDcy+VnJDH/EekdafIQNPWyXk+4nhcUXnDYWMeBlRB4/xUSGzB72
         ikqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766196; x=1779370996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6d8VthjlyqVFZ52dWXLfCKwuTt5I0MIUqg/9Vw2be8=;
        b=IkjvtifGpCUkkid9hEUUIFxWLYGosYltW1r472ystVeYX0Qn6/fCePP+85gDI2Hm8Q
         hZbB6z2uVhsz6mvNSW8rN7/g3a7DF/ENtEC4kXD/2xHhynjARDcBbBTO1/4JN36wRsZ2
         +Rx/ZUd0ZbICv8ycFwt1bBRm+SNVe09NMVQsXOFatabKxoU0EFnlUHWqKXlA85dZ2Fz/
         g3to2bgqq2J4b0paomCwzekLClytTAJh2XvbtxTGLOsnNukcf5vfVHcYY6dkAxB05ybY
         S+fBGI01fjvwpTCFJpQm46x++lr9rKV1lhHSI2aN+CIOlcBecSrzbOVjccqnPmAroseX
         5Rtw==
X-Forwarded-Encrypted: i=1; AFNElJ8EMednm7MMNj3LXlbVlVAe63nW0FGdoftMwCTspN98bDNDvp/BdRE0GanLK/Ln9EHS4Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDT1y/z2gfTi7FkBNE85JgA4zoXipqBYGAY+/Bua7cbT0NRwfJ
	sFB/lh71O6Jv+yOp2Wh5YU+vQQKDcUfXmfQE5o+wG0E3teUkIuKm7aQApdtn3NdpW8LhZWnNvIj
	xG9M18r27vAkMLZQjRyNNertp+Ra2MBCZY4IO9Nuysg==
X-Gm-Gg: Acq92OGRxXnB3p7PeEIMI7d2p8GRmSvtlq9GeP9BbL4U+gGjCEkAslzCgW6G9EZlYmS
	KC8QVDfopST5pTdXZeVcS8Efi+qfhNlm/rDy7xZDlIO446Z4igOnPI2Wg5sX64Pdzb5JfdBGQoi
	RLqaVxtP+GTidHb5aAexEIFea3V0Q7UyWKXe0i6FjqRibUCj6G46hJQyVlRNOXpXcCO6McxdJkP
	YinRV5v8AtUjYcp/SJiWP57Iq9fMRKc+VdZisS5nWnaZC9OMHNzkR38MKg5obUHxgtqd3bZgeoZ
	Vcp/+8WBuT02xxlGrVj5Cl1mfdJLM7QaIcFtGjoupnfs0HnZArYqElYooq5tnIqrjfrCCqDXi4Q
	l8rGk8VdsgQO4BGSISrA6SeoK0gw=
X-Received: by 2002:a05:6820:1525:b0:696:17a7:498c with SMTP id
 006d021491bc7-69b78dd26b8mr4064734eaf.30.1778766196074; Thu, 14 May 2026
 06:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415220930.287592-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260415220930.287592-1-osama.abdelkader@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 14 May 2026 19:13:04 +0530
X-Gm-Features: AVHnY4IYOTnFk_hk2daMk_NQTXJRetF68AXlyGAJYT-GkJrVasSFzbM3upXos9s
Message-ID: <CAAhSdy3LpnWtc9iTnND2ez4WK8WJUF_edYaDfD9Nd8_F3dPJFg@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: kvm: return SBI_ERR_FAILURE for PMU shmem OOM
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 3:40=E2=80=AFAM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> kvm_riscv_vcpu_pmu_snapshot_set_shmem() and kvm_riscv_vcpu_pmu_event_info=
()
> returned -ENOMEM from the SBI extension handler, which caused
> kvm_riscv_vcpu_sbi_ecall() to abort KVM_RUN and surface the error to
> userspace instead of completing the ECALL with a negative SBI error in a0=
.
> Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
> handlers and kvm_sbi_ext_pmu_handler comment.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Split this into two patches where:

1) One patch fixing kvm_riscv_vcpu_pmu_snapshot_set_shmem()
2) Second patch fixing kvm_riscv_vcpu_pmu_event_info()

Make sure to add Fixes tag in both patches.

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_pmu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e873430e596b..f36b099f447c 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -435,8 +435,10 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm=
_vcpu *vcpu, unsigned long s
>         }
>
>         kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC);
> -       if (!kvpmu->sdata)
> -               return -ENOMEM;
> +       if (!kvpmu->sdata) {
> +               sbiret =3D SBI_ERR_FAILURE;
> +               goto out;
> +       }
>
>         /* No need to check writable slot explicitly as kvm_vcpu_write_gu=
est does it internally */
>         if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area=
_size)) {
> @@ -480,8 +482,10 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *v=
cpu, unsigned long saddr_low
>         }
>
>         einfo =3D kzalloc(shmem_size, GFP_KERNEL);
> -       if (!einfo)
> -               return -ENOMEM;
> +       if (!einfo) {
> +               ret =3D SBI_ERR_FAILURE;
> +               goto out;
> +       }
>
>         ret =3D kvm_vcpu_read_guest(vcpu, shmem, einfo, shmem_size);
>         if (ret) {
> --
> 2.43.0
>
