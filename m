Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647538AC97
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341376; cv=pass; b=qhz3I6taGADPb1dkSO+TyUWNlk/IqXmZ9WQSV1Xp9sS4gK0IoQ+kTVUSxQfLWe4BKZCDxfj3K4bMQXTbk0uB2iUfhzZTreiHLeBA9b6s2JNQALBELO9ysnmDBapEIHVkoTzwiwIN1baT6H9jBi6IJnDg5V0inL+RmH1UtVisTYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341376; c=relaxed/simple;
	bh=uim9oxsNtx9iKvXL6JzquG4OsjGFEgYmoxSJFNCT2Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OarUX81nQcVieBUhBXhFO52O8kmR5xE3powV5IvhLgrLGHPDCy0bZGX8LoXjILN14aIMvH1v9W2kwZM/Fil0a9/nall6sFQE9Kvw1XlM1B233XOPSncxalEGNA70QP1D+xvGRZyiPw9NjWF4DypZ/iIVR3C9OMSG8DXpzzOqHLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=u0DU1Xbr; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="u0DU1Xbr"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f71156e1aso644575f8f.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 09:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785341368; cv=none;
        d=google.com; s=arc-20260327;
        b=GP6NQYMGEyofnpsUc+J2raudLUZY9oeG/9eNy4N98qbH68WFf4iVIKTX3snCBh+NiJ
         jzJgPTbvji1g/tGrBGrwnQZVnNKCUQnM1+Ury/2cRBrtYZN/Bl7yL9jBu33kG7k9xCz7
         63IdDouiNeswpP+D/WpzCWl0dQpVYdikU7aa8+LoVdSYux5cwBNDQPp4+yum6Mj+eNcz
         T9OqIvOFlTln7AddN6TUAlVVLAogSjTXTxvsTkbCHmOvPh0SsR9zRKXG4qJVqs5XvL68
         dQbubopLybfp0wo8CjexFTDueQq/4JShNnQe7qCEn/mh5DCxM5UtAtwLYvQ0/5hPka9d
         uxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3zuC/oQvIKv9ZO7b1iXct9muPojkdOiWtkgZr7atSyM=;
        fh=rUWHyqRcllQWs1yvMCKKMIi9FXsxo16MXsHfHJTYr+U=;
        b=EiA/owubmonBm4+1rfSq2LjA8ph3nABwfNwB2Q8/RBRTQyN19MtWf9ZYB4ijYEdpm0
         JsH16f+o9oJsicD+lWEANTPPjFdcN4+H9+35jMlDOGpeOZW7q3803/pcOOy8qumrTvLX
         +9Nx01k22uW4rM0/0Lp42cNS3rYTYWRdSUrQxc3DJmdBgc446U0KnqjA9r2i3JdSEOBD
         ra5Mztx8RbL/NbMAuodCgmIpwmfzEnQ/ZkUZBzJ0f7mm/N+vvKqVrqyzaf0uECJuR/Ra
         dYZNGIt67RXEAHJI8TEI8HYDRMioedhxeeP0zPkJs9MxO2fTQQQk6nF7rt+1IxBL+CrX
         LDzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785341368; x=1785946168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3zuC/oQvIKv9ZO7b1iXct9muPojkdOiWtkgZr7atSyM=;
        b=u0DU1XbrBwPrfrIeNRhk26qKuJBEj6Q9Vloi41PCpa3jdJlorP0bOKoiDm/A0G+gAB
         VkbbkPLJwuANKXbBDFUOn5CzZ0WIX6bG/n4bzZp+nZnDR2s3MjsD88v7B6esw4F+7lFc
         s4yX5GmpzgtGkxoU/NjgIaucN4VPVz2LTZ2/IR9PwRijQvOS3NDCSuBJyz7XqakIeWZ/
         Q3JQWKw2RvUkfsPh1KyXOPEK9+895obo6yIThCPJqsQEaaz8T1VhVvekQWP1NzweD5jP
         uLLkfxUC1jxFqki9fYtLeqHqmFlPfvmT0EoRqs+rswbZHZ20skjK/N47fp0rVyQQP8cW
         z//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341368; x=1785946168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zuC/oQvIKv9ZO7b1iXct9muPojkdOiWtkgZr7atSyM=;
        b=HDhtAJFeE6PoJ9f56IoTrF87SKvftOjcNbGDszc5XfcPOE2jkWNzd3J/d3VzIpL6Dy
         PdVEvdoBz12t8cmUJwq2Yju5PO3xWpMF5mnfHKI9V/kLiJuZDgQj5zAW6YY2aAM80z/3
         gnTyRPcT83epAAgCx31kKkHNbla3CGYYYOKlaplFmH7DejuddK6bPEKdDxA6RYS1t6ok
         plL9E+I+3soN6FgoG4KMpwgYb6Eihjs8Xar7INrADmtyJZPwA6cM5bKk6I48DJ3l161M
         E5v7E9rWY2dyqIra96xfBMNRuRGeaME2t+vlKJqK4hOhLNV7yqdhibkBWTMiEzK0p0om
         pHNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5eIYtoby1Liw+Gi9PzldF2KLHbh4y0BKNn6WtuT6VTp7RdkCECka9i2AOprfSXRlcVHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Vi86mwYSGTx6nwHmG7I7gMNYCXrtPKwOqt+QvESKatU/I6JN
	U+qmlt2Cugz9j2U2bFn3mZ9rzh1LeFovFz587QPQjYLqxdmf6dv/pp1tWWKitRwa/e5fPKjenrA
	3ADO5qlKejLkk5FMOVw9UdetPVLWN6Chqd32CuMfaAA==
X-Gm-Gg: AR+sD121zP0T9wGQSmy7xazKXI1OTSFam7WAR/gQ71/Zm8b38mREfFR43GPQMMaYyFv
	/EWKu9uJYnTXVw3Jk/tAKJ+fdI8+SAte1GzhzRqRWaMG67eT0KtUXIpCGx8JZXP3KgX/w/L97Q7
	gVlZjIdK08hbST6dgGo6sSEqQHkVHXgyNY868INGIyFj/rL5VphE1YI97RnILKiZrYuueJxZBBd
	Y6MbL5c1GwYDgI1BEI3YKitlVLb5Q8zDXfLOt43kDjarWl6tu9UgrEUdR1anf3fERS4wy0J8f5n
	4UvyAzHVul1T1NB3qhJ2dZgZR7Erm56qjZ9Q9VjO37MdbucT7SOOnOnS64Ih9PVq7MHrqpTtvQr
	USkc4onu4Kkib+DcCaSDFqO0qu2eOcw4Bf4XybbWFKVrlBSU7J/wxidU+JL8xlT08
X-Received: by 2002:a05:6000:230c:b0:475:f100:3607 with SMTP id
 ffacd0b85a97d-47fb1ee72ccmr9567614f8f.54.1785341367986; Wed, 29 Jul 2026
 09:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729075230.743030-1-shanbeeyoo@gmail.com> <20260729120733.829457-1-shanbeeyoo@gmail.com>
 <20260729120733.829457-3-shanbeeyoo@gmail.com>
In-Reply-To: <20260729120733.829457-3-shanbeeyoo@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 21:39:16 +0530
X-Gm-Features: AUfX_my5C6bC1gg8YQo_QEqDM5Cr5_eRkLpJTSlYIaDahaeJGjleoyTTh0Bt330
Message-ID: <CAAhSdy0Bn3N+weuszLa3VX6rJHRoXRSwqEf3MZEoSJXy6=cwxw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] RISC-V: KVM: Use unsigned int for vma_pageshift
To: "Bingyu.Xian" <shanbeeyoo@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quan Zhou <zhouquan@iscas.ac.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:37=E2=80=AFPM Bingyu.Xian <shanbeeyoo@gmail.com> =
wrote:
>
> vma_pageshift in kvm_riscv_mmu_map() was declared short.  Use unsigned
> int, the conventional kernel type for bit widths and shift counts, in
> preparation for sharing a common struct kvm_page_fault across
> architectures.  No functional change.
>
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup

> ---
>  arch/riscv/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 943d8dc72105..d2a06a54be17 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -541,7 +541,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         kvm_pfn_t hfn;
>         bool is_hugetlb;
>         bool writable;
> -       short vma_pageshift;
> +       unsigned int vma_pageshift;
>         gfn_t gfn =3D gpa >> PAGE_SHIFT;
>         struct vm_area_struct *vma;
>         struct kvm *kvm =3D vcpu->kvm;
> --
> 2.54.0
>
