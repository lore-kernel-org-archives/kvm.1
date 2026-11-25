Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619208;
	b=eMgkJ3eBB46Xzyi/Bkd9+Z8KPOvbUZeCMPJJHMbkKH+5cQ+C0ZYIuJscATjZXYlFUCRF
	 +OwX1LXLgQ7Qy6vUebhE1a8qHHxR6QNXsuk4jJEVz+BkGBhhbk21OwHY1AZt+eD4PydsZ
	 1g/37q5gRilxBSeOGcviistDBGNobMlWV3cu5XIulD02MbC0ErorBrNAf0ERm6+0pKnVn
	 14ZHZNTFtt/U28FoNF9e7g9ijNCR8XRlYoKafx3TkxtgU6Dginda85lnkQl3PCj8kC4w+
	 MPpPeGAVhL+UFt/xbZ00wHa6CyweKPbJhOcQR02qeWnBtuXMw1e/hRx17KAudLmfxgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=wQhYGWbmYRpOsQh048VImHZFZtKvuW+wybi1/wHnwY8=;
	b=GbZs0Rzjm08HxyNrizPL/lkjoxR/rc4CZ+IO0bmIhKJ5a/5Z2BfTnZUjtkG6fXWknP5F
	 5sikGyfeuCqYsyA3TuLuoDWpDX6u8ZkxIpUje79ROIrWaR0GW8X0oy8NtfMSPtUeEb0aN
	 AVHYx6Kx2a+1WlIber5M37IsJDzuVNiUxDRegJ5AtvDurgJpq9O6+cFXCuHRCmyZ9RPIQ
	 9A/QO6hEelY25/NUx/GxGfUzfUyAnEXxOtJmR11xcsVOVqyqOgSiAn2YYVyVCSngwI7qP
	 WFfHEigqGbyf35qommQ8TxFi25rdMTZRLq2FsBviDZmaKAKFBWeX6FluO4gQJDUoJaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=pemRuMXy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCB606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCFCB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=pemRuMXy
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b467581b98so57614235e9.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 07:06:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619206; cv=none;
        d=google.com; s=arc-20260327;
        b=pSZx6ioPzNsrrvdExjmeCx38l5NrWNjMLoQpweGL3scowlAHHH109V/kWhbhxvHU4m
         BarYZpMEghlfDZ5r8hR7u+G2slNd7f7dQMjTPcALMx8D0TA07iEIIFc7wWF4dOItfF1J
         tY0AejP4NcXt7JJntnjOEeYQKXkFwX8Iospz4XCW5iPDzwEsw456UsFHVzSTpl8TCXtl
         4hyFuf+uPUGmn71P4s9NspdivHzaXsDwDUbzNHa6g9TWPZ4JCE8aSLlZKUjbnPIu4Roq
         U/YKY/jqwam2WGgdIweiyy411RxdEOQIyqpKfDkZpNcpmzHqu6ZY9iR2o0l87nV8HXaF
         HKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wQhYGWbmYRpOsQh048VImHZFZtKvuW+wybi1/wHnwY8=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=bxeKZdVrPEGH+WehVrboQYBXwtRVS67lYcEUbxwi9uUevTiXlatiyLMGudcbfgORWh
         OJaGhvUmThAMBFoj5HREhOCWY05mR479tCZBNkUisxjAKogBlCbBxKejZC0m2EBSk+AR
         ad7t6otEtKsSnwfhIt7528jq/YjR77NIPei9o8SaUM6fblKpga6/qCDEnwgCzf2zErZm
         WYkccqNhzSnRXWJrHxljje1zrzREBJdIRQQMAQvcH+Das26ZPTZwC6EGH+MvA9uI/g0k
         HP0TYFhIi0jO63FwtFU26ps6fxK7ikTZa3LIAppnRjN9VYgr6MjjB+1Cx5aHyM7Det7J
         RXtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795619206; x=1796224006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wQhYGWbmYRpOsQh048VImHZFZtKvuW+wybi1/wHnwY8=;
        b=pemRuMXyr4I+c1uAftwjHSHymoYH7Onl2IbwGetE3XAtmQX8HIt3kHduM3rqqvWGiD
         Yjl8YW0mB+xKtyLsZKIY7eOvw7Yl3jukaCT8DQGlnCi9GLJTA3QQJDxinJjDAjZP4Moc
         UZ1YaNLJ7/cuVMJbNeHhLmmdME4JYLSWFxZ/IpUKSqna2UDG//Vh4PgosVBNdOELJIPO
         rPsmtKcRuGP8+z1MGP7eQp7LBCL7EWumiDgyz8ssXhTj2sA9U+1doNI+08N+6qnz6jxG
         P86ATgyMpc20XFtOnmiOQVQaBQoqeaVY0j0erX/fJAT8YsM1FWNTT1nrorwU+gghnTfJ
         jzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619206; x=1796224006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQhYGWbmYRpOsQh048VImHZFZtKvuW+wybi1/wHnwY8=;
        b=CO4O9WRBNsEGRBOU0QBUBcUf0UJyUTZTAdVqC655uKHHczUAjp/OWCtwc5vXWSSa4h
         nwahc4je8vBZzvnNXIxN06t9lV6VO98LAa0hcHyr/CMAPUz4+8ERVAwuZ+Cqjx5CFVXV
         98ayVvHKMV5UDftyF5yLsiJNTuoUQJyWLRepa5SrH5s4NCsYuLDGCg7hA0IrWktiSOUR
         wr9+pjF6EvSTN8AIJUS13SKILumFHZVejmynwYBblYzB0vgRpMQ1zInxIgtKUdg7NYRK
         6ok/crIliCHx6//ro6aVL8D+CzFp6PcwMwTqZlHXgOOVJ9HY2cZlD1TstApC/bnZonww
         /Ddw==
X-Gm-Message-State: APuU4Z8qi48Axa5OZWzE9u+ziTozgc07DQJ6h0F51stsGjXoL65D6bNU
	etvqa7fcXif8YCaWWccmuJMSWbzYd1pbZu+TGQFi3iRVq59i1YMSfMLRB2TRdyTADR1AOYrnAWQ
	voUYFtUrGDd401a+aq5PwCMcLf8mbn/C5BiHtPN+EaA==
X-Gm-Gg: AZFdTZepD7HhGvZnOrJHtyLNG5LBtVGCsn1y5MpfKddvVm7BS6jZmlCnrPyDGyUVRmY
	hLpnQ5kG8iaP7JwBDWoO+I0bHcut0kXSLhLI6fYoq1/VrCda+2ufG3I8y7LLZC3TmtVVrgkmcdt
	+C2jBedCuqX0mfS4CDlKusm4M84H0AfNtarq3aobQDLPJP8fnHx37oCfgp+UQ4vDn75a+adW8kG
	ceaZu4C6WoRLNK40WoruSWgafOXZ8zY9y7jlvBXwfdN/HSNH/CamtE2vi00ip1SkA6kNySTzD0o
	vhgvWUZZNAdtnhqvJTNeN7iibHcAJBJtEw6vSbM+cg7F703Phwth0Q+tN4ub2dvz4ZijYNPSn7M
	c48PGBBJ+9eQfK22qJt/jMkDvCD2qiFrdVFoCTPLn2BWK2OTt0B1d3P4U4/gtqqo5F71ad8Tn6H
	xWh1wG0j4BRKMcofgjYF/s3ex3mA4Xuy585r52o/3gZFrYtIcRZ6uW
X-Received: by 2002:a05:600c:828e:b0:4a1:cd83:b23e with SMTP id
 5b1f17b1804b1-4bb88786ddemr337232595e9.0.1795619205644; Wed, 25 Nov 2026
 07:06:45 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260914055936.3672758-1-wang.yechao255@zte.com.cn> <20260914055936.3672758-2-wang.yechao255@zte.com.cn>
In-Reply-To: <20260914055936.3672758-2-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 25 Nov 2026 20:36:34 +0530
X-Gm-Features: Aa3M54rWb_qwV0lybeTg4v6ZPTlnIV7_ygoXoP0dqWuArNVCCcEttr1PQxaya24
Message-ID: <CAAhSdy2-HGNfbBCJeXPS0wyTaSt+C9rHw08K6dn5DcJCLWy+rw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] RISC-V: KVM: add tracepoint for guest page faults
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:37=E2=80=AFAM Wang Yechao <wang.yechao255@zte.co=
m.cn> wrote:
>
> Add the kvm_page_fault event tracepoint to count the number of KVM
> guest page faults.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  arch/riscv/kvm/trace.h     | 22 ++++++++++++++++++++++
>  arch/riscv/kvm/vcpu_exit.c |  2 ++
>  2 files changed, 24 insertions(+)
>
> diff --git a/arch/riscv/kvm/trace.h b/arch/riscv/kvm/trace.h
> index 23a5fd1b686e..07fcf5b6059b 100644
> --- a/arch/riscv/kvm/trace.h
> +++ b/arch/riscv/kvm/trace.h
> @@ -133,6 +133,28 @@ TRACE_EVENT(kvm_vcpu_irq,
>                   __entry->vcpu_id, __entry->irq, __entry->level)
>  );
>
> +TRACE_EVENT(kvm_page_fault,
> +       TP_PROTO(struct kvm_vcpu *vcpu, u64 fault_address, u64 error_code=
),
> +       TP_ARGS(vcpu, fault_address, error_code),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned int,   vcpu_id)
> +               __field(u64,            fault_address)
> +               __field(u64,            error_code)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->vcpu_id        =3D vcpu->vcpu_id;
> +               __entry->fault_address  =3D fault_address;
> +               __entry->error_code     =3D error_code;
> +       ),
> +
> +       TP_printk("vcpu %u address 0x%016llx error_code 0x%llx",
> +               __entry->vcpu_id,
> +               __entry->fault_address,
> +               __entry->error_code)
> +);
> +
>  #endif /* _TRACE_KVM_H */
>
>  #undef TRACE_INCLUDE_PATH
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 88e0c369b354..de0262d0fd95 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -29,6 +29,8 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, str=
uct kvm_run *run,
>         memslot =3D gfn_to_memslot(vcpu->kvm, gfn);
>         hva =3D gfn_to_hva_memslot_prot(memslot, gfn, &writable);
>
> +       trace_kvm_page_fault(vcpu, fault_addr, trap->scause);
> +

The trace_kvm_vcpu_exit() in kvm_riscv_vcpu_exit() already covers
all traps so I don't think we need separate trace point for G-stage
page faults.

Regards,
Anup
