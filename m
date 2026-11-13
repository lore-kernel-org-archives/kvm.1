Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794548222;
	b=JKnRBBHlggZU6uXvvGkxQtm5M9MJ4axy3ZIWyXKRAMBwAEnSEojYcsK2b5FvWpYFIk/5
	 zXJ0pueGPE2TgNgE6VdhGWhGTHPtyttIGf3ebhZDnZFF7e7b4q2CoQqsfU+f/qTAt/fKE
	 D6ni0yb69bd2FelXDnee5RKjJmu6PO8mvrXlisJlk8gqOOXW+lp8idJ5sXj4HPWt63aGb
	 qs53ROa3grYXLLttro+l6Lv+Fn3geG+eS4eOP3tcxrfuO486ssZekuRQ+Z8DJG/lKZgPn
	 1ko/ezn7gMs00M9SE0O6nRl/k1sOVXYYvvXXvFEoXMZWzrOHf5avIHnwzBM6GV5mzAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QarEwHVG8bVm7bZjBedKgl5vOWWE7Gicj7qr674GGcM=;
	b=zIqvWvlr8W97HQM0LsiWaC/eJDsnNx7AfvGJyPHTBWRGrvcqBRikqCvd+qaWCN5PpdVe
	 mr/I3+nX61yKXMYY7w1cIPL9Ywkt8zlroMTjA5VQnr7huSLVEBRxCTvpp2cRUBDJSW5Ep
	 U949FbhKBttx+uVirD0PwCZXlL8Nscq3ODaucP+3XFS0FV7fBBpRHq4ewp5hYWSb3D7l/
	 LtQ5GIk9o8KVVlLTFOK/EuEyatic/KGAYZG+C1If8uWMwhFkfkijLP8uOaaDaw8aSgZEp
	 2cIx5jTQcIStd4EOBiDV0fIRZZQZRWeZsJkh3dhKHWI+vJnOx0qj3ba9LiHYymb7A/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=LrF+y+kL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01943606CBEF
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01943606CBEF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=LrF+y+kL
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso664895f8f.2
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 21:37:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794548220; cv=none;
        d=google.com; s=arc-20260327;
        b=J00w+ygxt/wbIofU8i9SVg+37rhz5xiU37ugz836Vqzt1GHhEGoUKh7wLdmhmVoLPU
         GFs+MJc8B4OT/cHg8TswyH0gM44ASX/+TU8CANl1YUkWKgs/OH+Hyiu3lWbwlciXrg1A
         68phikmXMcJm9txweICO5+ye3JV9L8lX15P9xB6ey3oyWkxc5lj6qBJJm5yMq06LPDdy
         g1AxbLMaxj8y8ZCLTTo/o1pfi9Re3BHJwqVTlh0lUukiV6H63XUb9G847l7cYqoLBCMY
         TdsOp28vofQv/xGhPczKLpiDDXndvSkodgu8tGr4+LEFmZ6QnzefqXhdAJqhN9WAWjL/
         bgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QarEwHVG8bVm7bZjBedKgl5vOWWE7Gicj7qr674GGcM=;
        fh=k8L5xHGXpJIQ1y3HTw8jFmomQQccfj14AnRfqCZUCjU=;
        b=RTQCjUQSfxMZrtQODgMPcmzvMeKzM7naiq88eMlmAWQtWpf3nYegApHpWN7+TVNL+p
         iMrQanBS1RHg10DMayCjA4q/ae7fn6gUdW6uqujM4hrJL+50h+cbtz7tG30Di1DSt/9d
         6eAjFN3K3cnPu0DCz+H91rWsVW3E8RA2FTfDhD03i76e4/Qzjp8i/C0B5bnspcJueQW8
         HOXD1D0brRgaldKXUVKWb/BW1720a1kh5tB0b6NN/FYa/FIeBFQ57MZqlJJ5Qr9Lm8P1
         V1lHtVE2SYP2QEoWpNfIiQT+dQPiy3/VDSoU53BEDxd42LsPMFRkq2u9bzBySx7UHs42
         TyWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794548220; x=1795153020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QarEwHVG8bVm7bZjBedKgl5vOWWE7Gicj7qr674GGcM=;
        b=LrF+y+kLolu7fexQ3wcMkemKa/uN4SPoyXEfx19KAyO7Dt5yXQRSLANwIHzxw5Qf4P
         DbVqU8iv69aj6S0/5tlv3pIwe5kF/L6zQik9+FA8HtdvuC2sgDiu4wOU9Um+CWERg95W
         45prDOrxAD5jpkux4cA/6j8DUHkVWDWMdFN+rpQwjAbbhnmojf2TRrVG6uvS0PGzFO3D
         WnHjUN54edRVfrmT3MKR00Ee7VpBwGm2zpa7TncTpCtl90FwooreD2RpThd62Im2pk0U
         IY32h1rkJtUm6rvXMI9cNvl8TlqHwfZnr8bVOnAQFtdF9cRzUsYooMNulHIn794trRFN
         AQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548220; x=1795153020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QarEwHVG8bVm7bZjBedKgl5vOWWE7Gicj7qr674GGcM=;
        b=uy0texjlsK5pZGf9dz98qeubbth7xKEv87580doqK0Rmx2gxwIBUyFQpO4qfnbEndj
         yKzoTKK+Diwbhg9LS6k5NSgheC8Qgt6tChMHpSdZ9nTOBf8vKcQHF/ioscHhA0eb4y7I
         5Kmnfa4ZiVODPkIhcplfvsnYvZF12JcoZCyW1IKsXLj9vuonKaeZN7dlS8V6YXP4Uh4f
         NJOJ2UtAX7ed/KkbXth9oD/4qPml1E3edf25tcVPWWDsb6+Qtm7VC13dzZLfmf6NBipm
         I6h/HNCbGafUutKU/GSofyCsAAOnEeQLlvF0SAhXmXYgBBGkzL+fn3oBofYcXMqbxMQ4
         fD/g==
X-Forwarded-Encrypted: i=1; AL+hErEXs8uwlT7o8nkMxTjfKvORFbu5g489ncZaqVVNz5U9EkH5d5OaCHouVd054+/LTp9hw0U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+T/flOeXyYMECk7bHcL6HSzYg9XF5jvhDufHbTln84htbhyWWn
	KlgM0G3EpdxgVBjGqHXgduv+Fx9/g7Hf87RHJ4YaywPcH7qKOvl7q5/nWaCx0mIY0Pr99+PN8BO
	y5JlkXdyNEhTKQcMBDcVHaq8vGoCZ4Z8eLrw7/xQNZw==
X-Gm-Gg: AYBFou0DVweaGqzXN5VRf+HyyFvCayJnOuQkScJOkYngNeRImPeNEuF+5oRuoX2bpuE
	/2kl+XYG0pqf8fEFxRk0SvbayIIWmy30XAgBe1y/XkPbsmVijUDTfl7BzLH+y19EscWc/tZBBtF
	ulaTT0mB7T87X4gCYbPVY6QdH1BCUCnPhv5pXNlzv5tHUfkYtUiyU3Fm/eWkMppqY+PR8J5JjHs
	C/t9yPhlXf9FCVIiZ0XE24RYKpEl1uGRuX8FveOTdu81MHadd4sP2I4cQgy26eAcLzHUPdcNNhq
	KPnH+3r5jIA4JUtBvYOwnEFYikSodiDkJ74OJbKAho7wN4OkcgZ2EXivqyCoXRLb0DgRzUR5B2B
	fdoemmi6/XUJbvFjR3wR7TSxKJ48LCuYn+AJW3ZA2v/i+Plt0m7qtav1Ywrc3dJxMwIp7CQH/9c
	ZgPj0KQvhhE7wtg6sz1pbfiMaVPNHK3GiZIWgDhXgeSLfETnVMe6mPuRZkSmS7L7/zQvFpMRNEU
	dv1rA==
X-Received: by 2002:a05:6000:4707:b0:48e:e98:8b6a with SMTP id
 ffacd0b85a97d-49c6d453ed9mr3163083f8f.4.1794548220458; Thu, 12 Nov 2026
 21:37:00 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1789872556.git.hppiscas@163.com> <fbe7337f6989994ad4dbc4dc03a67e8ebfa61f8d.1789872556.git.hppiscas@163.com>
In-Reply-To: <fbe7337f6989994ad4dbc4dc03a67e8ebfa61f8d.1789872556.git.hppiscas@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 11:06:48 +0530
X-Gm-Features: AclHuK88LJjsYi40jv-VHQ1EhoNonVCEpnzC8CHgPBMpwYuzpNXU9bTUnQfxb6Y
Message-ID: <CAAhSdy2KAtv=4RAo8aaOjeHWga-JJsLympDWAeg6MjkfAxstoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RISC-V: KVM: Disallow GPA-width changes after AIA init
To: Pengpeng Hou <hppiscas@163.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@linux.dev>, 
	Fangyu Yu <fangyu.yu@linux.alibaba.com>, Guo Ren <guoren@kernel.org>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Nutty Liu <nutty.liu@hotmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 6:40=E2=80=AFPM Pengpeng Hou <hppiscas@163.com> wro=
te:
>
> KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) allows userspace to reduce the
> stage-2 GPA width while a VM has no vCPUs or memory slots.
>
> AIA initialization can complete with an APLIC and no vCPUs or memory
> slots. The APLIC MMIO device has then been registered, but the existing
> checks still allow userspace to shrink the GPA width below its address.
>
> Reject GPA-width changes after AIA initialization. Both paths hold
> kvm->lock, serializing the width change with AIA initialization.
>
> The issue was found by our static-analysis tool.
>
> Fixes: 7263b4fdb0b2 ("RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HG=
ATP.MODE")
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Assisted-by: gpt 5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

Queued this patch as a fix for Linux-7.4-rcX

Thanks,
Anup


> ---
> Changes since v1: https://lore.kernel.org/r/4852f3b8985c353811fa065e4701d=
76dc9a7f086.1786512671.git.pengpeng@iscas.ac.cn/
> - No change to the code; retain Anup's Reviewed-by.
> - Rebase and clarify the locking description.
>
>  arch/riscv/kvm/vm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index a9f083f..66edfaa 100644
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
>
