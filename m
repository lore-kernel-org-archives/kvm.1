Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE6371045
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857078; cv=pass; b=GyiEt7iuWl7FTBCoBYJaiLTbubxb4wqD5T/0fYARN2W8MDWPunYsNkYYtSHVV4Z3HDB22asBk676rwbQ2Dr6RcU6c4a1Y7AZ5eFTxZwgmWASLpezM1Git2mTnmMWhTWFKWAX+hYN5Q50PuCOrkTd56sYmsMBCco16++afDJj3EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857078; c=relaxed/simple;
	bh=CioAAeK7MHrR4h/jM5ruIAqfFXcmnCKmwTPVrhBIKsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZpGHPaTNLqPai3HNZhK3xzvm1abvpuYdKfYgdojyUjeKJuewA3rsM3Vpn9eqUxXNt7o/Y20R040e1AAFREq8QHdiIQbHk4a0KyTHbvkpDDBiILK+mJ/bbujNR8LXiTLZ9/3JbVEskvtH3UkH17g4jP6M57VKoPbLamwLWNI8pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=hjL9XSVz; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="hjL9XSVz"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7de4e6c5a30so10467068a34.0
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 07:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778857073; cv=none;
        d=google.com; s=arc-20240605;
        b=fdz9xnmIFp0ZNUkvhLHkf+pVd9Mk1OPGqWVF5A/8HBdjT5kuT9RKJmI+kklSc+k83q
         npMR8NxElh8XA/YQjtz5+mTBkQJA+zXW4ALybsKtj7kkXHcqieyIE4COChP+xrin2YQ+
         3iA6x0+FTHwevk3kvsPzoqUpcZ89u0Rx0S9k1BB4wqUeMhmhPb7YxvHktFqIN23rQDq5
         a12ik0KCV+Abenmkq+QjTSbqq9uIrOjE+6SeHTTBW7kaHGuNAM5D/cgbvNRLknpip9EP
         Xf089Hvg2G15L1Y47va4mO7QEKSXkoCKrUUI1fCQSTv3Sfzl3Ag081LX7SZsO+wODDLP
         avkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3t1pOxjg20Z3wcl0vvYq5Ty0ZflWEwctqSCHyvpXyd4=;
        fh=4p9kAtBNT35pab3vHPSvur6CneN2ROlzKT4P+nDOLLM=;
        b=K5smzu61ARtSCkHI0Nbg7Jyee/TtPQUieN+biKSimo+Lqvp7Af7b0VaPg9RaJaYRfc
         01l3WglaTJdBo9r/oiVBYBiVYq7z9s/i6JBed4pEiVlrxfWelHjAauJWdPxGjrYerjVF
         L71HEw7Zv/pMQlDiYxOcRGx2gz9fO+PAbNw26aRLWgCamG2HN8z0eZyhgjHvwxoFGdFV
         Alfvqx8lSeL/+94RefQSYYD7gydao0pK+X45JpiXxeL/WFTWQX6eD/Z9wOhh42IaCdsI
         8xSytcphRrKdGVXs8/5dM3EpRTOF0F5OD5Eq+28GecGHTNr7aCyZWmXuJLot55qErZO8
         z2oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1778857073; x=1779461873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t1pOxjg20Z3wcl0vvYq5Ty0ZflWEwctqSCHyvpXyd4=;
        b=hjL9XSVz+M9eV9Yua3qhRA8EZeRColV3UXvvWjlbRK1MBI3HxYtf6y1VLzk3IRFtrK
         Z5IKod1jheLCMDQh/7eCFgzpHx2WDLfV/i8z/JZhBeKxLWKQEvhAR6h0pWcEO+nnwJTs
         ULt1xs/XNdz3ax7GJuOEwGscQkpWUpmxo9vQWzHaNOakEjmCpC0wfg3Py0t5NWnqec8R
         7Eu0cQ/LF+Laubl8jJxcDL1blFWFkc+BxpAZAN/od/O094HLidYZN3VA3dw/5JlggvVD
         X7lJLHl/moCNBXJ5BYxeCAUQPjE5ISqo+CsY2l1FpHLsGF2vqWacFU2QV7BiH8Xyi3+v
         619w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778857073; x=1779461873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3t1pOxjg20Z3wcl0vvYq5Ty0ZflWEwctqSCHyvpXyd4=;
        b=CIHNpborOXHB0f7iFngUpekX1ekBgjBbpxle5WCLhr0xQhqgdSKbHauj4EOJvIMIPV
         XGDE0uZjZ27chxrWI5Qy6T9Btx+g05XfLeEWjxG5WsfZb/nOzEpAid6TiPj1T+0DLWpc
         zdls+LOavh8vL68fPL8cGj8AWEjZu0PYy8yyuWvwwkNKs7yEYCT9B9K/+X+y0HlfYv3d
         NAVCcw/QBhy3WfHZXtQuY9FZEowrOB/v9G3XTphnEUSCMyMzkzG3dEbxA/sMQME9NzRb
         iinqr6k/TbCgXmo1XJndS80S1jbzsK9LX7cjjp2KpfyVVz+XRsQUSVOuYbqYIMDhbFwO
         75HA==
X-Forwarded-Encrypted: i=1; AFNElJ8eNxWiw4dY2q5NAMXjy6CdrNfGymCqPWQWcMJAi50AUF8SUfhAHccRuhHzkdUqpPYjVLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4YFKRndnw8QrjcklLP1cPFb5TbIkpJYU8+hASDQcu7EL+EjR6
	b0N+M9F3d0j4mnbFCHlfp+hy199qDvV2RPPP3CtvytwfqmMHMr1k5CvuSYNnlAfy3A2Tb1QKQEc
	PDaKdLZj8+xjwBVn3N5AdGYrLzH69zYzlX50CRA63bg==
X-Gm-Gg: Acq92OFNl+y1tibBUU+VLMeBqVzQs1qq7noOGLDWO8HU/BOYk/4+yfMBi2T1ylbfHcr
	AkdSJ3+kGw+/6wYys4sR/L/Hs6VDtEiHGTdYOPDHNVbxvXzh7uAoborbGBOs9RkvqccoJN+yfYH
	f923UilYbRKDQJW7PyYnhzrL2qCFIeceOJ/2D+X8pGThC6kcpjX1BZ0eMC3zN/2M4ndeTZiX8En
	DEOTQju9oxJRRsy41SHVzZHO8W+pJIyrr+toYv53Gs+OEJtdBu3LKHvbtqtGrsifle8ARp4zToa
	Ldx+hIUNlMcsnoT4ZXZRRN1nSIiqZ79Aowm1ZYwz4fOIRcblN/tXlCv0ufMk2oOH1G/9QD13dba
	DqoWw82In0jIx3av53DHhmnqR+rQ=
X-Received: by 2002:a05:6820:c81:b0:67e:3ae6:9031 with SMTP id
 006d021491bc7-69c9bfc803fmr2593844eaf.59.1778857072918; Fri, 15 May 2026
 07:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513092650.2386205-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260513092650.2386205-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 May 2026 20:27:40 +0530
X-Gm-Features: AVHnY4IC21LFp6nss1DoEsQGb_rfcL825pTbxqa9a4YrYi4kf6osVuSSox6fKAY
Message-ID: <CAAhSdy08enoCH83begksrSA4strPG5n5Wd4i+ext0Z+Wmz_OAA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix NULL pointer dereference in SBI v0.1
 SEND_IPI handler
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 2:57=E2=80=AFPM Jiakai Xu <xujiakai2025@iscas.ac.cn=
> wrote:
>
> The SBI v0.1 SEND_IPI handler iterates over the hart mask and calls
> kvm_get_vcpu_by_id() to find the target vcpu for each set bit. When a
> guest provides a hart mask containing bits for non-existent vcpu_ids,
> kvm_get_vcpu_by_id() returns NULL, which is then unconditionally
> dereferenced by kvm_riscv_vcpu_set_interrupt(), causing a kernel crash.
>
> Fix this by adding a NULL check before dereferencing the return value.
> If the target vcpu is not found, skip it and break out of the loop.
>
> Fixes: a046c2d8578c ("RISC-V: KVM: Reorganize SBI code by moving SBI v0.1=
 to its own file")
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Assisted-by: OpenClaw:DeepSeek-V3.2
> ---
>  arch/riscv/kvm/vcpu_sbi_v01.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.=
c
> index 188d5ea5b3b85..98ecfcb2469e6 100644
> --- a/arch/riscv/kvm/vcpu_sbi_v01.c
> +++ b/arch/riscv/kvm/vcpu_sbi_v01.c
> @@ -55,6 +55,8 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcp=
u, struct kvm_run *run,
>
>                 for_each_set_bit(i, &hmask, BITS_PER_LONG) {
>                         rvcpu =3D kvm_get_vcpu_by_id(vcpu->kvm, i);
> +                       if (!rvcpu)
> +                               break;

Instead of break it is better to continue here so that non-existent
VCPUs are ignored.

Regards,
Anup
