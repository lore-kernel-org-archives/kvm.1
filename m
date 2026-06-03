Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1103421A15
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474738; cv=pass; b=CCVIFiVwdXZhdEVNTO4x9UfhEddCX952KsjOpbQj1TqX7zfrXnnfcyB3UtwmCVgRuOSXoGZCzXQHe2jtcBKKVPZfBuATORMfVfm5z+bJiE18YtaazESRyVBuxpeg8YRaPxHNiLuKIPiaRLXQ7WXR2XNJeXfjN4m8lX+ejSciMsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474738; c=relaxed/simple;
	bh=BxOKRvh36q4H5tlZ5r66oJwHpH4szsKxsvymTey7/TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wg8eKd8aH9kk2N9Y7muLSnjkMOTNzAZI/K5rhnzs6qsjeOCx2sL7n7MmkuU4UehXiGBC7Xq35kaBrHz/tyG1+eGqaN8C+UkeSR/lyw0UW/p8fJVPTJqDdztukvwkVIdWFl47Sz8bX7KUUpTwoit99pRC/71YHxJkbs2I7sE+6bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=rmZ6sAbH; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="rmZ6sAbH"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69e50fe0919so67415eaf.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 01:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780474736; cv=none;
        d=google.com; s=arc-20240605;
        b=iAm/4a+TmROupSwatytMHRzYqu691pWZMH0FOLhXz+21qeD8GXN3A1K+uqX2TKTNVI
         eaGCP0LdvdaCaxcLGRlJXc5+rniBu1De3xGv2TMFduOHLrWqaBM7F55TiLcjF93mpwv9
         dQbicoz8wmbNDYqbaRu74oAaD1MDP7mlkE/DyhRnirrkHMDSm4uJqTUz1thLXBBxg9Io
         oi2hpNQJFzVnfXcdKqKXXpqRhT7Kdzmn0lfeI73pWzDrumKEW0ryrDIG5rAAVkqRzZ1R
         IAYatQ+mTn7QRPA8hDV05vpifbrYAidbOjmKT6rAaeWuGhnXD4jQHhjIq/CfYNCDoKpJ
         DTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7YXXRHTsYqYQHd5MbLWphJfk7peWK7x0kQufaDYO3B0=;
        fh=g+beMBz/85qaDxvzoc2KF8xzIgIYuAeNCJfU4sCXlWo=;
        b=V2nhQU6eYrYGypfa10tKKl0zYiJDRDx3cnFE8hyCJACZG9TXKtSsifqBfLnVkgEf1q
         88P2l+S4X2P9MKN8TX018lip55lVsnZgV+xkcU3VclUAoHzta2gzscLFmIt2xbuK1IxU
         vJlG2dgK7kjVagaoFlJ8vguMvvvoRtEdVHqwHsNhsLCTX2S7m3NoGGygHsE6r4LqHn9+
         oJRnTends2plr70z8EJekZj0P4Uw7X67pGH4fcvgnFI/lJs+6WTh1BmLV2zSBKjOgrug
         gmGkq8jy0q2eVCWUO4p4UCGO/K5QTZ6SuHopkxC+rCtZp84aEizKIpsrR8t6tc2queys
         HZTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780474736; x=1781079536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YXXRHTsYqYQHd5MbLWphJfk7peWK7x0kQufaDYO3B0=;
        b=rmZ6sAbH88vKt2s5vlkFxjv7cQ+857XyxySYNW+fD/1Hwxa1S/Vl8j5X1d7ThRmrA5
         eXaCInJEiZULHOaqHcZtRtoEdG95DoMKILwO51TtOyqq4OgulCAkgT7IPHZN3TwjoopM
         Gn8y88xviOoN75yKwG5uNzb/Y9XMwSwaqVAgwexXdV5ZMeAncQb8SO56kZzDzdyX9E7w
         XJY+gQcG6CKo76WSTjlzVN0ATPjclDP/SDAuqolSWm6vbrfdbAdqP3fhF80gFBt49rdi
         8wbK44AgJdsPQwKk2/4UVd/4asweveueWg+is4S3woKxZ8eh9tEDXkzvXZ9Kwp1DPUrL
         Wg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780474736; x=1781079536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YXXRHTsYqYQHd5MbLWphJfk7peWK7x0kQufaDYO3B0=;
        b=mmeZEIslAguLtmbcqEgQ+EBIkwmqQLkK2hD7ne+m0FW6FHNrhZw3oxNC9kPiT7jKd9
         pM++Eks/MJ4deHq9OUoRJGyyW8RcVRTLFiPVLEhRZipRwAkpN9DmvPwbTF5INyrg94V3
         leUEYSmeKRfdACnq+NdHTCIuYsFOtXmzoJiMsOyx7wh7ocePdlVppPwM2tN8Ss4k+mPx
         BU3IozlXOYuZKHN3Uke+oCyk+XI8tubdCxt1xl/pNUqe4pXC7LoRTggOQzs7CIXn5sT5
         8cIpKZDEqi+aZEvkHs1TTMq8DieuNZzr4ddcEpBZcyhIfGJLHUaNmvM2f3LOgiKIlOMx
         ch1A==
X-Forwarded-Encrypted: i=1; AFNElJ9fS8opTeGhMbsgfACR4MS9+zvlT1y1+DCwn9EGoaCn2B2ZqBb2vrMpKFpoDJZgUf1b3Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRId6ChmRTSMjzwklLJGIzEUV6QuaaaenAUUb2/snxWnZueHN
	OUQfYZYClQ1NkTg8G5OGJXeiwBqt12/l5hY9+pM0sTXj95fiFjHElhvLasGCLmq2uK/289M3O+W
	qwOfe2GXsiUVjLEw1tk9hil/MJEakQnjlqtZ+4ZaikQ==
X-Gm-Gg: Acq92OFtSs3VluVEpfcuFhGuDfFGY7sQq1f1EeZYoiUG1VS+658tkS5LZ4ycs68cXkT
	RKd7T1q1MUjoxLo2gWVG666vl5LHoSgMdh5/i3M1dCAqpdKMREjQ/jlwzfW299kCReyIHm7X0yA
	XmL195sRsBjValxukii0c2r2SRxq4QZg7faavPWVdAO6AaWZxtecZmhLJvJYexMIlxDsqq1E0GY
	x6C2/2RmBEM3rl96dZEOM98+pjh3UGOSv36RqXT7ZbObTtEu4HP/U5s5hmca6o1KT7I66Dn80Ho
	tQNCrct0K+j/1vC7OxvoyVGr8kO04W16IQyTebXMElf75BKvDrGXjIU1n79AkUYjlfMzSV4HmN7
	3bAx9lmLqmZ1HuM9uZ1qfhYOlQX35qeXlZrKceCYL8S8Q4O8Y
X-Received: by 2002:a05:6820:4c89:b0:696:6e28:8c19 with SMTP id
 006d021491bc7-69e48c8b9ebmr865206eaf.20.1780474735890; Wed, 03 Jun 2026
 01:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn> <20260513154251861FBOlxl8ySih_oqyoJL1iA@zte.com.cn>
In-Reply-To: <20260513154251861FBOlxl8ySih_oqyoJL1iA@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Jun 2026 13:48:44 +0530
X-Gm-Features: AVHnY4KAwfGnPP2mIswxICBynzTnVouAFw9Yon74XWLX5xuvqnAhH_lb6zEINMc
Message-ID: <CAAhSdy3vB+jes4WxQh4jN2GSmLYU6i_tySfKd3Y2xcZJQ6K0Yw@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG
To: wang.yechao255@zte.com.cn
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 1:13=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> Split huge pages on the range specified using KVM_CLEAR_DIRTY_LOG.
> And do not split when enabling dirty logging if
> KVM_DIRTY_LOG_INITIALLY_SET is set.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup


> ---
>  arch/riscv/kvm/mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 14c558ee5f15..2cdea3e3ed4b 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -147,6 +147,9 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct k=
vm *kvm,
>         kvm_riscv_gstage_init(&gstage, kvm);
>
>         kvm_riscv_gstage_wp_range(&gstage, start, end);
> +
> +       if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> +               kvm_riscv_split_huge_pages(&gstage, start, end, true);
>  }
>
>  void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *me=
mslot)
> --
> 2.27.0
