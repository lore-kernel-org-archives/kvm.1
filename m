Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96D21018A
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764574; cv=pass; b=GIam4p9rgeDJkqatF/DrJAljBixDniCOdelPG1lRfCG3HRW3THwFSNvjvA4M+9Yp4zDMTL3enGpoodFzUk9aj/uAi8KreKRtGLoAGIkGNfV5aHfbwSdyAWoHcTFQZpM2EGeeExBjI5zu4ys+FSrhwFyGWb/Jlfa0xQhAbv1m0Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764574; c=relaxed/simple;
	bh=DwLJG7mqdmml+mZ7S7nowmXhI93LCzcqjMV9ypSd5wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ea5TULY0qiRaylQfyHSpjvK0u5j0h6lH0KwY78P0A8n/2s2dhc1sbGa9sEY+/lxiVBelaENVgcoLX5qNfR5NeycJusVrWFosXA/q6RJd0pxFkTNmcjtVbBmm6V2LhR/iwoz0cRKnEvsLkFbmuaR3jwpj20h8zRqEk/2YEeqAd/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=kAn+Ms0q; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="kAn+Ms0q"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d55b97f358so5461303a34.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 06:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778764571; cv=none;
        d=google.com; s=arc-20240605;
        b=g0C2RKwnq3G1q7J8f+H5tiMcKFLfpd3d2U53Feveb19T1EHQh9AApC8FOGDgTzH836
         ADJjKpsDK6S/ek6/TY4xYAGmiIzlqKoty5oxfSGWca8mVx4qm9N+vbACuFw7JN2qVBcb
         FEoBQd7fNTgUM0/Pf/U8fW5444pPncy1eMhPyDwdf5RmwTqHtCh2G0xbEFJjNd3FEHgZ
         nfEbSe8tMnmrojEUKtjw6IFDBO2/o18kFtq7+EMKf/8nBFe7TJXXYPp3ThcM3bW7eqWj
         oM9xqgBwwCECjmd0i64e0epGyF6U6gKPMlP26Am/l2lIGNXiLiuK6+elfIrDacb/CETq
         KMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2L0wvqc81PCyDXrG7skbGOKy477Mis33owEkB25SlXA=;
        fh=IHkDubCyYxs3jEBLSI1mB0z6JFp91WA7AU978ps4Q7U=;
        b=ljWFPdrOYV3NoBMJpxq5V0FUC3rBXydvymIo37Y3Ztafm05VbWeEQbiouck5Xf8tMP
         CP476IWjQn107OH0pdoiGurbTcR8nftGSS+wfXl3mW52OjJlRXeCs2nnET7twcaoNlm1
         +I0SsJ7EDVPVx4iSVNomzwsfEqTcra1LEmslJUNIE0Ah9EdLYkM/QjssKLOwurYspL5u
         MhK/sa33SjiBq42BU4vxdZniB4iBLSxjXafry0PQ9hQaL/OhQr68LSZGAyq1v/bUzvLu
         tAUVyqzbPWTbqkMQ23SmdhGVzruYIgmj7mCHxUgvLkgEXNf1g6FTQEAAuIV5BkIpbBqz
         BfJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1778764571; x=1779369371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L0wvqc81PCyDXrG7skbGOKy477Mis33owEkB25SlXA=;
        b=kAn+Ms0qF18Bgfh6ypJOb87ZfdGvbyCYNo8nze90N9U/x6mMV9nXzb51AramRwGLRa
         5o0m+mXS3h7A8o0WypSpd6X/sp82QS9dCtlWsSl1L9uCqPFNJXCBXMXknAUCI38ldGS+
         0IcjpFTwUht7i8RPgdbXCNcrXI2sdFOXPlut5fnSLPdZTJwbjxLqL/a9kQJI8kin6U/e
         LT/X3eFgSu4NB5YoZuVC8RHUrltwZRrvqfyY5bJGjClf9msnUjLGamlY9OjRQJ7d1BIU
         0zOnMmEbzhrzmimm4D9W4EJ7BlRqUAk7kjtWQCaA1214ScdZuQVdZqnok4S3uP/Hp1qs
         BHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778764571; x=1779369371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2L0wvqc81PCyDXrG7skbGOKy477Mis33owEkB25SlXA=;
        b=CwZOf3r1dZ3GO2CQsLehbnqnZTs7dUJxK7qPKKtke4IDan9kqVkqLIUgEkldc5hLhC
         KZhtjPdy6va6B+L3zX9dJhcMxnvIEmvBzkCBjq+uredFZ2VHl9rYFHbbovFXQfdJn2IC
         MLtkLu/uSDcC7sLmq1TRhwePFw+5Q94/8DMWz/lqE23xhJU3Oc0lNtp2Ngq177OmHmOB
         xyQQws01WAIw90Ah8QKOvcQ2dAqqOJc0nwtEmttTnQeGVYN3YNVmadGkM6lbgzXA/g1/
         GIPOyAlJUByVA6fNmgDtmtuSfxQC9MwC9cPKuXfo3aztD3wokiAa30vAQFeMyqUDAAnd
         u7Mw==
X-Forwarded-Encrypted: i=1; AFNElJ/QHazXcDbnauY0CdYUZArLZOX/SuJDHNPqtzG0GNCkweogiESHVdwQ3UxLtUhTAdD+1EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPi37SRR4a57m7kj79IfnWCIPVwA546Z15xs6ULuDADJPN6MRd
	YCN0KC13mKCDSE/w3tZAy8t8jX7gd4PyJHm+bagOivKiNHTSP6nemXlYCaQScB8J4pEmePjzX/h
	hqloqVW5M92y1NjPY8FHKXsMXQR10WeutLN0pyf6+PA==
X-Gm-Gg: Acq92OH81icdHcIIbDlHHbjSAI0p4OIUaYAIOcKOo5myiIheF+Sz/2Q3vcgt+4+357H
	WYess5Gz5p9rL/Cafs4BODmVrhzw1/Do1WvjjK8y/UYUGph/JsQprDC9EKknQjO/6kMisX/u9VQ
	8/hRGudnlKpNHPatHDWpCevPrqGsi5AbSLiT2OixhRae7b/AV4CJ7mF6u31Xz8aOHD7pFcAkHpk
	IkOUuQ1ZSyLf+B+XxQtLcPiOEcwwrqPsa7lU+svs8Fgi2FVmch73x1qcOPnx3DAqVLrRxFkeeLa
	lITg5ANghUwZXWPOmTV8NZiBuCbU3DPZCZO9+6btDdDxIv+VJSx4wMXXino4ihoGEnqWTi43Q3j
	JwrSgO8UtcnZINN2cLRryHjBMolA=
X-Received: by 2002:a05:6830:6209:b0:7e1:e832:c8a2 with SMTP id
 46e09a7af769-7e3dc905429mr4793888a34.19.1778764571356; Thu, 14 May 2026
 06:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415075216.2757427-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260415075216.2757427-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 14 May 2026 18:45:58 +0530
X-Gm-Features: AVHnY4JeoNYVJt-e7SmR0Mdkf1NGWqjoq_KVrwu0L02Ywar886al5DcZ-0R7w5o
Message-ID: <CAAhSdy0CSbsmdjCu36F-8-CD4A2Sfz4Q4OYa3i=9o1MJeVT8=w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix invalid HVA warning in steal-time recording
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 1:22=E2=80=AFPM Jiakai Xu <xujiakai2025@iscas.ac.cn=
> wrote:
>
> kvm_riscv_vcpu_record_steal_time() assumes that the steal-time shared
> memory GPA (vcpu->arch.sta.shmem) is always backed by a valid guest
> memory slot. However, this assumption is not guaranteed by the KVM
> userspace ABI.
>
> A malicious or buggy userspace can set the STA shared memory GPA via
> KVM_SET_ONE_REG without establishing a corresponding memory region via
> KVM_SET_USER_MEMORY_REGION. In such cases, the GPA cannot be translated
> to a valid HVA and kvm_vcpu_gfn_to_hva() returns an error address.
>
> The current implementation incorrectly treats this as a kernel warning
> using WARN_ON(), which may escalate to a kernel panic when panic_on_warn
> is enabled.
>
> This is not a kernel bug condition but a normal invalid configuration
> from userspace, and should be handled gracefully.
>
> Fix it by removing WARN_ON() and treating invalid HVA as a normal
> failure case, resetting the STA shared memory state.
>
> Fixes: e9f12b5fff8ad0 ("RISC-V: KVM: Implement SBI STA extension")
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Assisted-by: OpenClaw:DeepSeek-V3.2

Queued this as fix for Linux-7.1-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_sta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.=
c
> index 3b834709b429f..60e50296a0085 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -46,7 +46,7 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *=
vcpu)
>         gfn =3D shmem >> PAGE_SHIFT;
>         hva =3D kvm_vcpu_gfn_to_hva(vcpu, gfn);
>
> -       if (WARN_ON(kvm_is_error_hva(hva))) {
> +       if (kvm_is_error_hva(hva)) {
>                 vcpu->arch.sta.shmem =3D INVALID_GPA;
>                 return;
>         }
> --
> 2.34.1
>
