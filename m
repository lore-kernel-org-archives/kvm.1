Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793958605;
	b=1OVXTQSgZnGMqsLwUGfyUK2UuN5BXbBWoKzNlmpRienPCk9H9OOJde/KOtzAJ7Aqa4uV
	 ujC2qwPdhW5oV+n5mMFlxDaAfU6bLlKGZe6v5PLlVuOMYCg+bcSIk+ReXtvTqC/rXdsUv
	 Av4GckJRT8cobMgX0mXsfb9+vDnnwTk4vdt7IJeKYu++UcGTss8OrthJERuIQWZ+lVHRh
	 gKb0K0hLMhnSJfBEHjBH7h/AKEQ78e33MCQj369fE5Lo1LJ2CEucuzBtsnIi40iy9d21E
	 hWWlfe4OL6NOZ08om4jwonjFpjSM6fYH49+SbANJPRw85O7GUwfjvaz1yEMgA0iluZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i0RXhXRHqPQplgUbaoUrvnlIZ5UbVQs/4MlB5+exT+o=;
	b=Pioy9C+tWB5dQUTVWeOjWa9RRvgXK/PVbto9OQLgDwh059FXBIPm5y7eu8twyW7Ht6aX
	 SzrOH4M8nfNX6dF7UjeNledt76FokjJOlflqoYnSfObpmXuXmQ4UuPqAZ9b7VmieNCSNM
	 Cse1aZ/rB3NmR1Tf5BfVnxDHvKyAaKxZ+HALue/YhxcyuVyrrnpORjzysHbJXAMu8J6+K
	 VMztD9FkDASZrKXKAVDefD6W10l4nvWHn5d35l7jSiCmk+1gqW/ZrrblPe6jNEB6ui7nd
	 OEe+3JhC3e3ZhPT7fE5MBsjrbIQ51yvmOVEYh45QtfNfWezt1stkOlvgN7vf0ljTLWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rzqR38H4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90474606A328
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 09:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90474606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rzqR38H4
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4c78e8caso361218e87.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 01:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793958603; cv=none;
        d=google.com; s=arc-20260327;
        b=ZsCvVP/cFzd3+NsMStLxnrAfq34/X2SPPreveumGWvYrzF8RBRjj4+SW/MfNFHpFjJ
         iP9bYblzBHk9HHF//3QM++bL9vcj5DD1CG9jsHKeeLY6UdIWn5kmoPVmvJ/rytFbEzah
         bzCtTFvKPlIJNnosw6y2qp7avylBntGkZBsOe+GBqyCO9b0BOIdJBbYcwPrxdntGtskF
         bqOB/B8LizSYaF2oJ/uooFTrLm0oge7wCLg9tPqqy+JMBVJ6bztuNRMtaiEsbiAfhhBf
         N73/6GvE21xinPwWSjqxeMZDgjnOx+g+4rB+4aL6REpKCfXmKNEVCPwLQ9AFZyJ1eYn1
         Tt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i0RXhXRHqPQplgUbaoUrvnlIZ5UbVQs/4MlB5+exT+o=;
        fh=/K9HN8O53Lzop3XtEFhuOUCVG2hu0wPSWjneb9TafQc=;
        b=Ibh/TDcO9cR5GF3Za3IO9ax5FaKQk+UDs6zVZv3et58fCuvmgTBsyxYWqQLJMJsehl
         fUWo+Yxyq7UWWo5/1yElqguB0AAM/XKRjRurFevWkUQb7LyAYBsfmF2Vf3T/7DQ1yojk
         0HV6f4qENoHb7MhfIfuxKteWwW+KY0gDkVBHVJ7DCFHq8tTI6SGKVGH7XFzHcZ4lKvMo
         BxRU487/4GcReR49FeoKuVCYcKdu/5Gi3qPIydJYKqGJ3fXxeY5grY0wX4+TIUljI3zB
         Swg4X4uzIMFhf3fNcH0AX3qRsxuqxHXzUGGVjQ610cR3QE97isWdMEl/w8k+8QkeQGNZ
         CVIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958603; x=1794563403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i0RXhXRHqPQplgUbaoUrvnlIZ5UbVQs/4MlB5+exT+o=;
        b=rzqR38H4iEVTKI+W8IRWYFkzq+tJB5Y7OYE9A4p0tEOBaQNsBTdTA7sSi1pfsAY1gG
         7QzqTwgXkb2GChWskkYKohzYaCfimpwZohcZRYXI5LPZIdrMA6g7TisHn8U7fkyUXuc5
         U/YenI1adZs2ilmqX4Pgvr7Bs7vHRHF7PiYReq1EXz8HxxEqDio8FhdexnCgFeiO/w1f
         +H6PTu+wk31z+u3rJvDtXUeF9MmDkKwKJ6ZJI2154C/4yzyF+U2IHBRZUqC1zOB1LJmZ
         /fFUHYTr0qn1emJpZ+d/AlxRHbtK7oDQUTIL8ATlZnPPGHw5I8zXcqoTmn9j5pcnh6in
         fpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958603; x=1794563403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0RXhXRHqPQplgUbaoUrvnlIZ5UbVQs/4MlB5+exT+o=;
        b=zsEWoM2pDQoscPw9+SK8NsT/fC8WTsxhMhqQaCDAqkdqjmW94YoI1J8kmjJySt1yuR
         pdX1yFoc7jJRolJpVvXjhgGddYZEekeZ7DhMd6pgxScWDiOXuefDsEX3FUeG0KCT/jGa
         BP+/ebqRZJ2dqggMPj6tALr/p7md6AgDiie727hjntpxbteaFc4f07N5aJTdJxRaG+in
         mVepD9lsRIMkekWgYejx0EtLpjEMteZSCpLegHgbxQ+i+iX8o+6CjmzWqq8MVf+D4n4U
         6O7nnNCiExJlLt4ll9D02uCT8NCj07c4IQopMlfjFqFsYRlB9jjgRNOhdERR9erSjRMk
         ZHqA==
X-Forwarded-Encrypted: i=1; AKwUvBwBa7kWq8Efxo2aHPktKqW6M3SBU6nR24DY8ajJCkBVf9a/FCE6HKpnvyU0PNfoINTz1dc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9T/LBwbtDFebNL0yiWKqCADdQTTydeg0blFtH70o3KWey8wolT
	bifQxhxJfo2FXMEtMNx67dXFYDQcdRDnApC/61x/JuldgwDMHOlwrvjcc80UqwCOxe+l1YBT7hn
	E8Gvtx+yZEzkBw7tEowqZLiwgn+5RdNE=
X-Gm-Gg: AYBFou1MeJANp7+rARbxI++BFu22wTLMZyVODgwOitjRiurSHbffytjzCycZd2OqTyI
	KL+998scNAwLpo+3lVc2DdIQ09+GHKMeO1k/2BjeGpA8pTJMM/kBA5X6SwagfZILa2s8OldsRi2
	J6YOaG9zDqQn0OIjQNA8wqv4C2wOX5WI0hIypyDt3DyYFs6m88WY8LnooHwPIlLCngnEh94QhVB
	l2wu0IC5pegFqPkOYevmkHpDIbgMqMnQBE5FENpx0FNO7Ag8KL3o34n4EL8pauELSBKZs0x6I+d
	ky9o6sd5gfLUdQonuloGglSs7OFN+Xv3yxhmjmi1p9H/qjgEFJigZjp5mLyajiYtES5K/C3v9QP
	Mm1HInGSVhXxEh2UVdVNoqfKvti/PI/EYjTD25sM6kImMcQiNSgyoEP4Wx1+C63hbZVeM
X-Received: by 2002:a05:6512:3d93:b0:5be:3d95:3c7e with SMTP id
 2adb3069b0e04-5c003c084f6mr599060e87.65.1793958602580; Fri, 06 Nov 2026
 01:50:02 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017030927.345454-1-suunj1331@gmail.com> <au01Qocxd1gsXs42@inochi.infowork>
In-Reply-To: <au01Qocxd1gsXs42@inochi.infowork>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Fri, 6 Nov 2026 18:49:51 +0900
X-Gm-Features: AclHuK_aMmYFw0Il5my2_hqoI2l0YbFq5ppI5iN9PgB32Mkgeg9mxiSxKYMIzIU
Message-ID: <CAGwK=3q7MuQQxMZSS=c=UxXX08xgwPqs7kpsPy1EiXgbZbknCQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Only fast-path dirty-log write faults on
 host-writable leaves
To: Inochi Amaoto <inochiama@gmail.com>
Cc: anup@brainfault.org, atish.patra@linux.dev, tjytimi@163.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	andrew.jones@linux.dev, pbonzini@redhat.com, seanjc@google.com, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 11:03=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
> I guess this fix miss a part:
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 53bb25a5a60b..1b35ab980a10 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -761,7 +761,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>
>  out_unlock:
>         kvm_release_faultin_page(kvm, page,
> -                                unused || (ret && ret !=3D -EEXIST), wri=
table);
> +                                unused || (ret && ret !=3D -EEXIST), hos=
t_writable);
>         write_unlock(&kvm->mmu_lock);
>         return ret;
>  }
>
> Regards,
> Inochi

Thanks for the review.

Sashiko also caught this shortly after v1 was posted. I'll include the
fix in v2 and send it shortly.

Thanks,
SeungJu
