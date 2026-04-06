Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A53349AF9
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775449574; cv=pass; b=b5Z4WPUAuHgkdaqkYwCnHsBCmOHAFTl7Z/YYkocqVC3aUAnIDZIvQbvTi9MH0y+4uTQRdgg0Yt8zqwzzE11KIz692W3VYun53XTX8vEEv7L/IlyByZiCk3Xr6gRZvCtvwrlZJH+jhr3FqKUvDxr7CENTbpBTxNcGvDaEdCkSJDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775449574; c=relaxed/simple;
	bh=UqdeIjdUn5YvYpvhmjrudTNBqmucMxgenBUhQip1r9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LT3mI1MB92QzeP4xzmWy9NLEWZzUk3gLBvsejdd+/TDO8FU+eal9QI56YjeTYG83sRzttJ3a1+8senDslbJteyAM3QVNo7EvATIf2aoG1WIR5+l5qRJ7eArxfRWTAdKnhuOe9avJaz18YCkyj47kX2n5Zvr9EqdbRRFV11aKYH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=tZVfww0K; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="tZVfww0K"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-66ee7b9af94so1185791eaf.0
        for <kvm@vger.kernel.org>; Sun, 05 Apr 2026 21:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775449570; cv=none;
        d=google.com; s=arc-20240605;
        b=APMgZcGZ4Me8mMcfYLsOgQS2gBYEZmuAl84RqL76FCO/CleWPa5/XPTC/r2ism+5YC
         1B604y+yKs8oFwD5QhmuApedAXreABNaAUTHe57DF8xQ2TYC1EhfhGWbWGUmic9meEME
         NTKmhGQiMTq9PlCJ3EPyzEWkHkm2BJqEFEoBYZtR8VjP3v75Kd0XYAcgHhT89A7ee/yu
         HunH/rsplqgSSCWOlBIsyrsHKuDDZ0zb31P6FJ+tT4Pz3aHc1HPNsenAte25FXEPns+U
         AK9gG26K4HIEzqy7WHh2PrC0Yvpwd59iUZFyk/WduAVBX6I0Hs1nB6Pv/u77vexfcNJ8
         MZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d2Eqcpz26fbgpoHxUOQO5t6bHgkVihQ+ivm0vWcl2To=;
        fh=PygykwduqkonOy6K4bxmsX/asuFtDHbfowmNXw0g6Ks=;
        b=GE6/GiO4Yf2xWfokNubTTKWh+9o9uvr1jfBzMp0qVI1q7cavqNigpKQ9ql+Jk3nkrn
         0d/aS7Arfxxhvy+l3zLsuW//Q+fB0N/Elsgs1wJv+dS502AE9Yv60IZ0Bn3bN+eTOy+x
         dsY1dxX5YYBtdAwPCGm9ObC02e+j3QTzTV08v+R3Q87AFFlBdRt/8ZjbokSgYM4V8b5g
         lDK73XilMVyhpAs1tE8t6eVfFJtWZX4j7Stuh5kwG9U2IZ9+IS5SicLT0bIWtNYToFzL
         nSEM3hwyi0n6a2ooVv1aGRpXEPCQmO/VdYW2x1qDekBFBndfDqueFvNwKnvp05KoZXSh
         RqDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775449570; x=1776054370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2Eqcpz26fbgpoHxUOQO5t6bHgkVihQ+ivm0vWcl2To=;
        b=tZVfww0Kj7pmpn+ep9BdiCWc38M5FV6oChsriWNX+MZPWFMk3VSzYHjfHPPdkd/5ZD
         aY+RWtYOO27qNH5xJjB3w/qrhBqqY1wdONlGvGHXWyfGHVe8psX16J19G71Dp+gjZYxS
         z8hqOxWBH04BGOm7qHufbzVMl5hwyq14hdCa7NTtSaseMOgGdMhaquXZLdW1jK8wgnuT
         n5z9cTt2HHE2XVIbaGHpPzmbbGsEUsLpagTp4EBaHUaB2hQ5RAl0ETeGTnqmcVN0OCdD
         oMtX8044PA7zAgQXWACFruxocs/119Ro/W8jpaAMZcFizFe8AjC/wvOntQCBVdfMXAT3
         JU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775449570; x=1776054370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2Eqcpz26fbgpoHxUOQO5t6bHgkVihQ+ivm0vWcl2To=;
        b=f7P9FUPOJyXQsp2UFAIBOaBVfYaFG3NEasGTSlnpaNTlleU08x4uK9LLpFFumzQSdD
         OXldjvbvAZY9kY4Sf+pC+QBbkrpCQL2JzzcWBVrihh50h2v5DIa1hM1zp8JrlKJAWglR
         YBZ4A2EBoBaVV1Y9Jc7xlJTjwhCPOFiY5sNi4uOggX+lpVy9kaUGBUJvj0vDYt4wDd8v
         3OKSE/2OxcRqlB7DlYHmTqNtx2sTR0qJfsYB80J+GBfBfIBbRQOqi/r9rN13Y7wdjTw+
         N33ZywbfPuYa90q7O/rfB1QYPaJL+wXKcZMEdxR78dNBT/lhrq20s7+GWDEOjD/0+CKV
         jBcw==
X-Forwarded-Encrypted: i=1; AJvYcCUZPc1f38pq/bDNh6Nl1g9L8x5fS1D1K69/dGc9hqTt+3nOMk+KWGJv090hGRmPd7jXCqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11VvpSrvVMqn0IWjeqwjrrqel2u/aG/OWQy2qBdkvLXmqU7y7
	3yDjLQHFCLUP2Vll+/TRRlioRdgr1Lne2XFSx0Nbtn7scaJ/W6y19q5NvrAQ2idzHvAjMl5fIZG
	xM4QoVp7HgeQ7mGBQb8oqxKk9jCkR4IqkPuhB3X1bgA==
X-Gm-Gg: AeBDievuzz+fG+165n8ZhNpm2CuloJeXqYs23gW7yx84HDEFpht1EdDiHBkM5+JI7Dp
	NRAwfsdrhh3P/UMmbnG2nB9iv1vAZlz3A2MFuPLIBL2i5xfXTTYR5UpwjA566J7WFLlIJ6nAe5y
	AM+B3mfmdqW4T2oSy0B8kr/dHuBlANRJShO3N4O4SBW9r+n1cFbYizJZpxYcHrZywxndTmGA4Kw
	4ynSyGx/LO/MoLixU2Wfzua/I02KseXw1rv422Z62x6Y4aZ60yqjjXpZsIq0vivpLRLWCCGCqAE
	U6Lz+EYI4Dfn38DT3v/JenRuUZL4XYME9sCUx6Iy0WGEEDje9pP5h9qEYYqwihIdN/hKMNZwIMe
	kE6unTXwM4qsAVyDBzTzP55+75w==
X-Received: by 2002:a05:6820:169f:b0:67e:1063:37ff with SMTP id
 006d021491bc7-68220b4a1e7mr5624387eaf.36.1775449570255; Sun, 05 Apr 2026
 21:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403232011.2394966-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260403232011.2394966-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 6 Apr 2026 09:55:59 +0530
X-Gm-Features: AQROBzDGT78x3zHvCoTNFnS1VnkRVlKe4WFUmhyAI0q8NrLRsHtw1tX_S_VT1YI
Message-ID: <CAAhSdy353CV6FYe7BzVFvvo6drhY5hHGcv4HnJDYo+3bfB4n5Q@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Fix shift-out-of-bounds in make_xfence_request()
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 4:50=E2=80=AFAM Jiakai Xu <xujiakai2025@iscas.ac.cn>=
 wrote:
>
> The make_xfence_request() function uses a shift operation to check if a
> vCPU is in the hart mask:
>
>   if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
>
> However, when the difference between vcpu_id and hbase
> is >=3D BITS_PER_LONG, the shift operation causes undefined behavior.
>
> This was detected by UBSAN:
>   UBSAN: shift-out-of-bounds in arch/riscv/kvm/tlb.c:343:23
>   shift exponent 256 is too large for 64-bit type 'long unsigned int'
>
> Fix this by adding a bounds check before the shift operation.
>
> This bug was found by fuzzing the KVM RISC-V interface.
>
> Fixes: 13acfec2dbcc ("RISC-V: KVM: Add remote HFENCE functions based on V=
CPU requests")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>

Queued this patch for Linux-7.1

Thanks,
Anup

> ---
> V1 -> V2:
> - Dropped 'idx' variable and compared vcpu_id against hbase directly,
>   as suggested by Andrew Jones.
> ---
>  arch/riscv/kvm/tlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index ff1aeac4eb8eb..439c20c2775ab 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -338,7 +338,8 @@ static void make_xfence_request(struct kvm *kvm,
>         bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
>         kvm_for_each_vcpu(i, vcpu, kvm) {
>                 if (hbase !=3D -1UL) {
> -                       if (vcpu->vcpu_id < hbase)
> +                       if (vcpu->vcpu_id < hbase ||
> +                               vcpu->vcpu_id >=3D hbase + BITS_PER_LONG)
>                                 continue;
>                         if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
>                                 continue;
> --
> 2.34.1
>
