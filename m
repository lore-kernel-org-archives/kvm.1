Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A3367F36
	for <kvm@vger.kernel.org>; Sat, 12 Sep 2026 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789197593; cv=pass; b=jOAQ87QG/tt2u0rcl7EbaFjfCcPjLNle+xYcY7bTSo4ybw9InSm9Noq5uabBZipdcprp4GMxBvhHU8+teXk6hxP15XQYP3N69B2rJUgEAQ9BezqEj1Vz+I+UNeG9u2y3HinrdnlgSqeBikYVIqd9PdxSj06XRGxpaN0R0z98kOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789197593; c=relaxed/simple;
	bh=pGpH0+ouhnwwNkJU6TGm2wYa4a8DQmd3BmREAcSC/hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIB/H7E28A7PD/25KhoISkWSQ5vIxyHuZCMzE7LRz7DJgq2Eiu7TrjQGeUFT64xTMJcHqKBt7SQyzRlwBwlghlpm8fHc3Qa3+RFbe22LvZutPySDhEjoO/TVmS0aU9kjHyl6gzFwSjG8Q4/qa/QUNmgh7Y9Rs9ZGoH3lLuz5O0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=ZsRwpwIa; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="ZsRwpwIa"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so125652f8f.3
        for <kvm@vger.kernel.org>; Sat, 12 Sep 2026 00:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789197590; cv=none;
        d=google.com; s=arc-20260327;
        b=Rf61PNHIFaUxh61HSnW9AvMQpnos9Rn2p2NNUte3hmZvZl2eNHKaaA9XxnsjIQ+3jN
         xl+lwE9O9kq2aJWn6kqZIsWPzeaOdgJG5ftYPrrKAwA5vgGMUURwJqXg8vW71wbwBz2u
         8BKpF7rxyWyboH2wxr/eY/Lul84gEE4ar3nTQvWVEjcMMOxg5+2RNSBCqxk0Mc7RbwVU
         q7XjGmWTNGjohXC3gMfeS4s6vPkefsqWnmDciBlhhtccH6fFo7wzHhb1rQYNkoze3Ssq
         SRm3fQ06a1i6wtd0f4qJKiWP7cFDCYdUVKBVe8R42BtVcXTmZ2qgMBKrrPC7q+ypXGEb
         EmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9RWV49ckuigD55nYwZZoBmV/ryAALoCGfcRf1WteUKA=;
        fh=uuf3L40LSQ6dj3BRXuSQeb/Pk89c6tSWxBHLRsMT/1g=;
        b=n2qzDN3lb3dXdTg//Fqy0fGTTcSmRZ+jd+m+xArv1ZeaGeXSioabtX34KwEVuWfWG/
         rzKEyTTf1iV1JCLAcude+5JlnY2txAtuWkiyFaLQbw4MF6MslSRXh7zrUY3C8TsVp8jS
         UdS0wPmMGl2k8cQ/T9q6MUJQuuFfaF1B8KdRMWeArVt7d7pmTvBRpMYdayXCkw8Lhx+d
         LOsnEHuBQKf5sEk+TUoe6Cpib6MAihjt2JKbPunHbkdLw2AbhVwthpsdX9PDQb4R3bhd
         yidh2LsjRDp63cc0t2GxWjg4znjHvHlphwbjTENF3L0JUhOJlaqeHTKe9S1Fi7H8ekIb
         fESA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789197590; x=1789802390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9RWV49ckuigD55nYwZZoBmV/ryAALoCGfcRf1WteUKA=;
        b=ZsRwpwIa85u1zXhnKFyhmzRZJ32K7oQ82tXuZRnTAuOJFpF3e2vAs0Wsq9D4/7Bunh
         dul2WJQOWT1kDjXgbdxK9VdoErOhu9mS0b//FHbmCk3VnG3bJn10dKkc8yNHtkAX1RZR
         yFIUGW43t/1e+pKSWCR2wM0aDjIVI03mtIOc9B9fbw0b7oLZJwUYuDgoIuPShlV6S3TB
         8vYO/wfDkUoCWc45Io7S9EiPSWM4QCOmoQV7a3HHiWKB1Ns77iyclvjMcUyqzQmHYVcD
         XKaknhxaBZnBW9ocUQPJD+qJDUPMD+tcc/tBuCIXU6t5dOJJ64qdsFyZS6ttaWQmYLBf
         Y4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789197590; x=1789802390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9RWV49ckuigD55nYwZZoBmV/ryAALoCGfcRf1WteUKA=;
        b=MLAjQX168vRKeMqhPHhsJrVJ8GU9qOdZhd+FLuTG8nmqOulWhqGXlXqugPzfw8TEOr
         8kMjJgWZoiXZ9HUxybwCuLmNQeMYVmZA15Sm3nIEeUt7c95QHfmscj8iYiEd7WyMAQa5
         MQk/q7N21BrCGF9Iwca1MuZtrjpCWgXHjaBkVolJZR2rhVjljNILJUJLG8BvyKkN+P7f
         5Pko1ZIAX/kYT9RSlLL9l1xQLMLYPUcw5eNMwlfuMcJa8DXLwGxy/vrfBPfvrHj3LuvA
         T/JIMRUzf9Hq2gcuj4/tsGkUyjkm7nFVzdVVhZrPvYPRjTKbMKeTPO6ffoy9wOjrDCBz
         qshA==
X-Forwarded-Encrypted: i=1; AKwUvBx6owOauEOnL+vLSUqJ+k9+rsQMiTfhfyXyfJZOeDSQhtQtbHw/hNZAFLwjaej8mFxtqaY=@vger.kernel.org
X-Gm-Message-State: AFuF++k2///8/FcVhXFwt5LCjG4v20LwvTTaAHB290FB2jDfM6+GOacr
	7+GFIBk8S9d0Ha5soOHjTrE60aTNoyEIn4AYZp0qFonBhaP95B8JPhD8f4DHn88sZh+xeEMAowG
	PupZQmrkTjKYyOKlYtMKunaicE5emTdJxt07pvNaI5TNE+APhLQGex+w=
X-Gm-Gg: AYBFou0A6YLYpYeoItWHYcKB1osl1nZ0IePjLIzSQHc4zdcl33UDiKKYMUBsvAgIh4b
	ABdrfu+A2Lxdtw9eVBYKhL9rnMIfwSGh3VWFcNZD4ydE2+lKpSmRqNMxSY/iXWk4rt6RvU5UgQ2
	Y76/EWmp24L9Zy0yT9b3WXyCobvTC3lA0mohOVAOJXTFWV3nN3bK1fnYr5i4ckIYbZPlP7/XZ7U
	gMUfUtLfo5nAvz90aXoC/I2fJQuZsvXP+p1buDR05DNPNebIN5thK2ywYwYLE4AX8rnaSSNywTs
	LVOdfhn9lE6U5HKyGeBvrwHiOsayYlE8kti5I/K5rqBcmrGIcGnmQ6dNi8ss5zMDn475SGGUu1o
	lIqWn0R4xj9Pf541oaHIJq7MqJw/E8qPEi0iQ7b/L+B3Db6GNPzdwPZ2K7aVKOiNHUtzzfbGqWq
	g=
X-Received: by 2002:a05:6000:702:b0:486:f600:8e6b with SMTP id
 ffacd0b85a97d-486f6be9493mr1750445f8f.14.1789197589863; Sat, 12 Sep 2026
 00:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826064117.58029-1-min_halo@163.com>
In-Reply-To: <20260826064117.58029-1-min_halo@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 12 Sep 2026 12:49:37 +0530
X-Gm-Features: AcwNN1WADS_UyMRbl-o6HEs2JIz2PBNtpUz7lA9SsGRbmoy5E-S50JL4uCJxHNQ
Message-ID: <CAAhSdy1AugX4AiU6xj1R3SQ9bRsRFBNu6=_aYM=G9SMkXN8Ghg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix sdata leak and stale snapshot_addr in snapshot_set_shmem
To: Zongmin Zhou <min_halo@163.com>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Zongmin Zhou <zhouzongmin@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 12:11=E2=80=AFPM Zongmin Zhou <min_halo@163.com> wr=
ote:
>
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> A guest may call SBI_PMU_SNAPSHOT_SET_SHMEM repeatedly. Each call
> overwrites kvpmu->sdata without freeing the old buffer (memory leak),
> and if a later kvm_vcpu_write_guest() fails, the error path frees
> sdata but leaves snapshot_addr stale. A subsequent
> SBI_PMU_COUNTER_START then passes the INVALID_GPA check and crashes
> the host with a NULL buffer in kvm_vcpu_read_guest().
>
> Fix this by clearing the previously installed snapshot area before
> installing a new one, which keeps sdata and snapshot_addr consistent.
> The SBI spec suggests a single invocation but defines no error code
> for repeated calls, so KVM must tolerate them.
>
> Fixes: c2f41ddbcdd756 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as fix for Linux-7.3-rcX

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_pmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 752f1014d633e7d67f69c27b72088ed560c187ac..14f73490f12cbc5a8547859f0=
d1bb1170d89403b 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -454,6 +454,14 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm=
_vcpu *vcpu, unsigned long s
>                 }
>         }
>
> +       /*
> +        * Clear any previously installed snapshot area to avoid leaking
> +        * the old sdata and to keep sdata/snapshot_addr consistent if
> +        * the re-install fails below.
> +        */
> +       if (kvpmu->snapshot_addr !=3D INVALID_GPA)
> +               kvm_pmu_clear_snapshot_area(vcpu);
> +
>         kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC | __GFP_A=
CCOUNT);
>         if (!kvpmu->sdata) {
>                 sbiret =3D SBI_ERR_FAILURE;
> --
> 2.34.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
