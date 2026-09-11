Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DB43E08F
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111485; cv=pass; b=MeOm/sHDQRLEThIyPm+hWPjgyJuxCAXgcklQaon78vIm4+cs5Cqy6apYL6x7LIeZ6zqcbWaQq1JtMgl0c8Gc8n4l9oWCBDjSM/JJ7f7ZzSu4Rk43v4bDLAyOFq12FG19yQ15HkvWVfI8VgisKl6WIBjLGwiVBNHlfikALYsRajw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111485; c=relaxed/simple;
	bh=+8tTBn8vkpHIXmkwGk2okXiTKep6AzUHo71M/p9GXbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nlb/aCdJjLAw/Fb5BtOGL0kn8lY2epUCb3AF68sPPwUf7MG+KOQqXJRLCsAwsUt93oiM/05IVayodOVfl3owZLI5Rck/XZGaDIJqfLrrDe0LX1nbmc3uzEQdtwuE0TzlWwwN1OYlJXZxNTsZLEoJ6Z2uIbWE7K3KOrsXE7ElxFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=CGTri4GC; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="CGTri4GC"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so359862f8f.1
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 00:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789111478; cv=none;
        d=google.com; s=arc-20260327;
        b=HMlDq2ijzvvreJXC1Nmq3eWZY4iKIUldqWK8xN/z5yFYuuw8zXEsTAVM2H8p1lYTum
         l1jtNJf19jLSU2M3R+zVgVqenrmYOoWneLmNF8kxsrdGWommy3F3XEjERTgUTx6f+rpu
         8P9wdT3f6hp9d+rEcmIviz9rKGKWK70odBNH71mkgIKoa3Zj2DOEkFYSztPnWMLvDF7L
         HQP4fKbLWYAhfZOZroqRBY/py96IxcGPXEjZyJVmIfZotc7hq8Iu4buOUm9j9Eato0sp
         2U8hRXYUw9dJ9o3IT6IQows3Cr1R08fOqm7+iguDz+grgjjDaKCal+jAGV3BDqBsQ9cu
         lQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ZBw3ZTwOIgY959yo8ebXtIDcCXQztOd/7/v3zr0SCc=;
        fh=x7EX4qLXLpYnIHMqk70eeICNmzojWWjOhyfnaQAOObg=;
        b=iJp4EkRv2zkV+V0grskT5D7LwB8TIRstrWvH6F1swWyeGQwKtb/ED2n+2ZiFDKbOP5
         D00gNIb5gzDVk2+48kx0dtb/69eGrdrwJ9CHQKOtm7l8LhORZ1ayxQJQwqTw1YPuv9vm
         H0SKDpHa3Y1uhLJFS5Xge4VnGP84LU/peD4kufQ50plGwVBOWcHFXeYhjRSKk9ZLiEoo
         vivczhhBnYlLSmuB+G6iAkwbOgklw4jKo9fweXUZ12ZWIKyAXS+HltSUxN92EJCkCwFz
         wcu+A3hXUpmB7ViY8hqsqEDb2RjsLtkTGFxG9TO1QkQRNpe7yO3Unq8Wk/eHl98S719s
         KMRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789111478; x=1789716278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7ZBw3ZTwOIgY959yo8ebXtIDcCXQztOd/7/v3zr0SCc=;
        b=CGTri4GCS+YdFymUSllkltgWEgqm9YkGQKXeum7qZPkalrilIYeskMf3Ict6CDbhI5
         Yp8hAIbSawRnSlWzBxIoUqLPPiVQOG1pYv6+6eBZxA0xyZ9T9UKbGQMipzF+lm5SsDN8
         rjZdCMimOTBMWvzftIfS9DSm3YErHoGeftVdaLUcBIxLG2eAfwGhCcvE1CWrDVi3l//m
         MIARRwlLNz9SnCnNhHe6IvRKxqdbDYH1iYrSpCQSeATvkMiuFqILlI33uNQwav8SbtM2
         8jNaQhvMcewvjCFC3+DuB3bhMTY4iy3dq/XC0e4DpZKQGTF9zon9kWJiGgNefN0CSCjX
         C7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789111478; x=1789716278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ZBw3ZTwOIgY959yo8ebXtIDcCXQztOd/7/v3zr0SCc=;
        b=C1y7aIBmwM2/QYmeYudFrvLTnkpQXvfi8kYgE3qhZTwa7vVaB0T6KSpjgUW/6R+wie
         Xmb53X9Vk9I0ARQICi/4qd5ubte8FtHTpynQzchr1abBSAOS5vz0fZb51jTynLheNheq
         CJxh8ZApL8ILHCG9gWY3zBB+rtTSpfZsFBlcafWqZ7S71RIqZoQpMrQe99V+NAI37cjb
         KeM/q4oO2YQtv9NY2tKjtYSV2YX5q3XvldVLWgQwBPNwaJJ3haLe44OwHDtDc3J+cCP7
         JFePsVy1+xVZGug6c1Ps5MNxQ08gnJZ8uL74ldEuAen4sewJqI8QIUEgYB2vrytYRj4x
         eVhQ==
X-Forwarded-Encrypted: i=1; AKwUvBweVJ/qL9ljkI7Ma9JQQCnVf0+L0mA3OwmMR27nhKMTLh8k+Gd1QLN1FUpXAqcrSIDN8nI=@vger.kernel.org
X-Gm-Message-State: AFuF++ms4awhuRVk7ZyPLm8oVTK9WQzl6sBL9vsGGf8byxPvg/ceN5jo
	BLciAcaI7hQLS4NkGAB2GM5/sGlkxsOMpkInCA7jki7xBOG3IX7qWIcZXflrLRlGY8yRC8ta13N
	t8Bdbxw07OUpVvKmvAOcPDAEGba4kneE0TyMq5C7ScA==
X-Gm-Gg: AYBFou2YGd4NzF0hYi0MU7nQBDWGyBPDMwTVD9y1crmoYw3OfJpV+pwB4GC5MOYA3e+
	DIZiiXtZ66B2Q5bCxGlCv6XoPDkR0pLf2M3pYyt4vmn26yXywTXpoYVdtkUv73zu2HWNVdrVJjb
	OjRN5VCUHBZ6XQTuSxF6jJCssLhUymyQGFRlydZ0Y7JeVKA8GYJm/yQhXCgsLvDtHPTBQ7AXiit
	ZAJ7QHXYeNCGEo9LyW4SbpCmInFkW9QeC9LGYBtiM+BSaEbsuppNUzmUE8RJnAaZD5Fnr45Qkok
	w0sHvsxXWw8suw3+WE5ZwEBs/PzzVRAr4UERob6hUIsAVrB4u8vqUpxNHSA2rG208dN+zS35TnT
	U778UUCAfsd7Pqm/IR2VH3l7e907spPHdgaRGY2z/QR4YKOVTPaGhvBZjnYN58ovkKoj6XQJ8UA
	==
X-Received: by 2002:a05:6000:2005:b0:485:9233:a5ae with SMTP id
 ffacd0b85a97d-486eafd5eb0mr3126572f8f.3.1789111478364; Fri, 11 Sep 2026
 00:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786512671.git.pengpeng@iscas.ac.cn> <4852f3b8985c353811fa065e4701d76dc9a7f086.1786512671.git.pengpeng@iscas.ac.cn>
In-Reply-To: <4852f3b8985c353811fa065e4701d76dc9a7f086.1786512671.git.pengpeng@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 11 Sep 2026 12:54:26 +0530
X-Gm-Features: AcwNN1UilFvQBMBFE1D37iU-TcFZA6Ymj5ixovFg4tSLMmtpRh77_3nZieaFccc
Message-ID: <CAAhSdy2gxgY6yjQRVhgwV2kLB8ZGwsuseOVPWF6KJsjPOLeP_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: KVM: Disallow GPA-width changes after AIA init
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Fangyu Yu <fangyu.yu@linux.alibaba.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Guo Ren <guoren@kernel.org>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:09=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn=
> wrote:
>
> KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) allows userspace to reduce the
> stage-2 GPA width while a VM has no vCPUs or memory slots.
>
> AIA initialization can still complete with an APLIC and no vCPUs or
> memory slots.  In that state, the APLIC MMIO device has already been
> registered, but the existing checks allow userspace to shrink the GPA
> width below its address.
>
> Reject GPA-width changes after AIA initialization.  Both paths hold
> kvm->lock, so the check also closes the race between final AIA address
> validation and publication.
>
> Fixes: 7263b4fdb0b2 ("RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HG=
ATP.MODE")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup


> ---
>  arch/riscv/kvm/vm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index a9f083feeb76..66edfaa86243 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -250,7 +250,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct k=
vm_enable_cap *cap)
>                 mutex_lock(&kvm->lock);
>                 mutex_lock(&kvm->slots_lock);
>
> -               if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm=
))
> +               if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm=
) ||
> +                   kvm_riscv_aia_initialized(kvm))
>                         r =3D -EBUSY;
>                 else
>                         kvm->arch.pgd_levels =3D new_levels;
> --
> 2.50.1 (Apple Git-155)
>
