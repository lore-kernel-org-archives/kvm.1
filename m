Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7280531A807
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674556; cv=pass; b=tcxLs9ctP0H9G8tmT1t9lnvQvnwqi3uFU00INLrCZes716/DNizrR5b71zlC9gPm06kQcEEXz/YzkALm0RqdDbmxMW2uPZ04830hPPZA3jJxRoUReWwGVkbKcFxfUHsgiykYwIuLWyDeT4s3l3aNfcpJaXF1AVFPpE4c+B/3cHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674556; c=relaxed/simple;
	bh=OBnmjwFTw76SUK1D+KXgI7Q8sf+FZbI4wRJvGKqBkFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RN4ELK0Qi7v3gpNj6T+kcj7dwFOlaYeXY64YdtwrQKufY/74TqPLlT6rWUcU9fXqQ2egiDVmAmv8VImfjhR9gPp42wCB3r0FtoztWbDhoauAMnFNJzwlDWJXO4Qg08Fj1SVCAFZcLZlt1qNcVOm932ErQtoWprRtHTNTFw3ZvYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz5OSt/1; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz5OSt/1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8d7f22d405so598377866b.0
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 08:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674554; cv=none;
        d=google.com; s=arc-20240605;
        b=QA31ECYUZUeNM9oWaGMb3LGmCUJ9tC3DeBK52ZbD4hUxMgP6m7Quh+UZ5djbCZ0RKD
         9s9METvazQHs8ia4wqA5ZHII/g5FzfYABW/fz7vWeyZ6NwFmlxHUHEnqwjvxlPxVm6AR
         pbMaUTF2spWe3Ug3FFOSPTzIOiHeWANNFGeGwZ5pyPw5ytz5h+gDESuHmACtdrYtwCw5
         JXNnaSya6ydhKITm7ESHF8FABwz8BFvFS8NDx+Usep1qNxWaMe6VMpqBeAGYMVMUAMDJ
         4It8rd/yNE7SmCkWF29eIBGjmySvqFQUVNJFRPgoCd3bM5h9Qh6i7o1ZAon1brZSjTR6
         z0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aela138P2UA6HOSTxLhqrmtMIrzMEnb2IdbvAjDcPFg=;
        fh=FUPwdN8ScS19+fj4IuE14IBARuapDnFPQOWYyi/CAzs=;
        b=ZJ/fLHJorbbhQsEzA1FlArW4MaqDve1nziRPeKE9xaYDw7dBoFREAjP/fv2p5teg6J
         Xo2oQnf8cukb7bfhaKsW5GMjyv838NpLNO8FtJSgj9oCXktxmTJcAztNoLIN5VHyVDmC
         vb5vD5z58/p6lKW2ewLLwgz8HIY/uHp6hQ2l/vwcbF5TIcq9CEPF9n7ze1Kz96Yv/T5f
         oGf15Fgz6LAPlGwo4UOO6xHt2JEFRIJopfu+RDwLGC8w5oq+2V4aBgfzYoo19HJXviXt
         xn/Z1RtwBJsmVN5J/YQJvgc9q9PIIvIbGNBvWTfdoqWi7wXywwNNyiqwY3TvJEXRXrml
         ZdsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674554; x=1774279354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aela138P2UA6HOSTxLhqrmtMIrzMEnb2IdbvAjDcPFg=;
        b=Yz5OSt/1nv4X6Rsusw0R9fyGiYTq39uQ2j4X8MZLlLPg3IZmM30NvodV7IwL4HwdJF
         GW9OjFKRwXOzYson7VkRUacEzfgh3SnbKYjpz5qgcCnaZ3yBieCoMw/4nhN52FReqBFn
         oAThtXB5tPf+P589BxQgEhp4iAK4Cr+9z8A8Y2MVBDcP7yaqztsl5RhxOTe5EAtltTw4
         BWdzop7sQTAlPMgaDSg2oFfh8ofMd3LZ4cRNHzHty5vbYPOtc6boRgxfCot+eRhMaPJz
         7/BQr/M0r3/ugOOXGr22808wJdiPKDFZ4cfUvLYG1I8NYfkmtXqtJG3sfsAbgi5IoRQS
         cKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674554; x=1774279354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aela138P2UA6HOSTxLhqrmtMIrzMEnb2IdbvAjDcPFg=;
        b=O7vznZEwrL3z1wB+C8df+fB+vxMfWumf4uoJnHQTNNI+OSrH3B8xrWrjG06tdL8UT/
         89L/fd3i9J+T5HPlCNsmlmJYBm0maCHFFaHFpS6Efq4MaSj/Kv9lXTCa0gYnx9KdRWx1
         xTjfr/h/fU7NCQZ2fXi18G7P6jzBXtJRzfOAddutheNXesi4Vi6iia7byUQqzAI47IOI
         KwnCQde4gDAudhms0nZnO7VmA48B9v/7A3EE6KNpFyR13BMe57W7UPMdmuD4W3XnA1NT
         o4NYlvTBuFiaRMLZMx662J982psALcRnFtdeSxjpQvC0Uu+h3dAa1zg8jkTNGwtMFEtQ
         xcBw==
X-Forwarded-Encrypted: i=1; AJvYcCVCkzgDLz7fgs/GCr3Kj8jrYMizNh4wygVM+pWlL1vF4Au11jQ5+7ZpFlYy2h6EmVb2HJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9+6tVuweuwYXmxzL59yUl/1VyA1z0CyJJo93G1sH3N1JZWfZ
	WqqDyKgTrzbTi66fsrBb4HImi+LibVJ4UuSYI7JojW/7irjlZo5aHzsZEJjS3R2KfCOHkNavp4B
	FgHRbtlBOnFB+boEZuVT7i51WtwxhG78=
X-Gm-Gg: ATEYQzx7F2EfEaobh+MDamwGgv02OD0h6IdGWxS/f9VLYyTXExiejwilxqbdzjkLvw+
	MWieinhBeiBCTo+tnZfMQyPqepG7uRs0J2BnplNmtPuG9n+XmOh4vG1w0K7AssUMIOx4juN1101
	fjsPai4YXCsFSbk9oCU27bLMFrYnuQ43r366NiwJHcmOC8RisPOaQt64PBRybfllykr53amrpbM
	KBDVL5sQzsY6AarCkuhe26ixDL63sX77ymGZEb1IpBGuMbiT5tky9UGDwfgJHwjR8/aNbE0lKnb
	ZbeMgzs=
X-Received: by 2002:a17:907:94d4:b0:b97:464:9553 with SMTP id
 a640c23a62f3a-b97650d8e72mr936440266b.17.1773674553492; Mon, 16 Mar 2026
 08:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316151612.13305-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260316151612.13305-1-osama.abdelkader@gmail.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Mon, 16 Mar 2026 10:22:21 -0500
X-Gm-Features: AaiRm510yNIk-2AFg7p9AlWX6hUz5FX6ePJRq44wcScAeWIThYKeskTelXRSBP4
Message-ID: <CAFTtA3MXQdQodaurFOz0PneuHEbY2j+yfQyWgqT9gWMBS1cZjQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: kvm: fix vector context allocation leak
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vincent Chen <vincent.chen@sifive.com>, 
	Greentime Hu <greentime.hu@sifive.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Osama,

Thanks for spotting this,

On Mon, Mar 16, 2026 at 10:16=E2=80=AFAM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> When the second kzalloc (host_context.vector.datap) fails in
> kvm_riscv_vcpu_alloc_vector_context, the first allocation
> (guest_context.vector.datap) is leaked. Free it before returning.
>
> Fixes: 0f4b82579716 ("riscv: KVM: Add vector lazy save/restore support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
> v2:
> - Add Fixes: tag
> - Add Cc: stable@vger.kernel.org
> ---
>  arch/riscv/kvm/vcpu_vector.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 05f3cc2d8e31..5b6ad82d47be 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -80,8 +80,11 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcp=
u *vcpu)
>                 return -ENOMEM;
>
>         vcpu->arch.host_context.vector.datap =3D kzalloc(riscv_v_vsize, G=
FP_KERNEL);
> -       if (!vcpu->arch.host_context.vector.datap)
> +       if (!vcpu->arch.host_context.vector.datap) {
> +               kfree(vcpu->arch.guest_context.vector.datap);
> +               vcpu->arch.guest_context.vector.datap =3D NULL;
>                 return -ENOMEM;
> +       }
>
>         return 0;
>  }
> --
> 2.43.0
>
