Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413F36F91C
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312579; cv=none; b=dDXKbrcDqcRn/cSIn6wvQLvs0Kt2AnnzGysC9zIAEiFoZZ5fEIxeCen8ciDcY6ltMcbcNsQNR2ltTfT/XWyd0vbuLPyK+n6fu8FfzM3D5tPg4h2LMx1mlo7iCCDlzAf0oeg9ZOOYXiiGp1793F5FqyFNEiTE8Mw27J0SsYew8bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312579; c=relaxed/simple;
	bh=uVVMvctNoZmupUqjH/B5Q429l87c6cnAPIW0ZPhBL98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsD9IJ2PJQRSRB/5U9Zheejc+W8psSu5HpBtbnMPXPhysfyCHzjQo15/MdSnpSzxS48EHP7Ud8YTWOJ5SB1jV1Nd1XYoc0CPAMKKmY0W6R1idK73cfk+Du1ftr4IcjRmhEjeM5n+SAVHHIxLiwigv6F4XCcBrLTRu30zBQfX+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0IwpU8S; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0IwpU8S"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so1748537a91.3
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780312577; x=1780917377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0RvTxX98K/pUu8wDZcU84mvng4xT6uAwNgRwaMuMuo=;
        b=r0IwpU8SCWTKy7mr72sJB3cqRqn4L6L77hI4C8xPQ2Tmht3taf6GHjZdDg4a0dQHQT
         wQCNhcmAzupmnpCnz/gvekTYE4UtnG7FBsWVHW/YzmZiW4Tc+IXhSMSIzPoNrrYb0S+U
         yhl4zvuW46YfEPI3VEBLJvH2eKTXUTbmQQ8/SAdy0L8PyvSIgUwwCUZez4Y/ots2g2or
         DYO8zVIJOSn68PcGELDOcjyhSCptHjc7MWCEu4OUatxbT24XQotH3kAm7dx8fXO1gCQw
         o75ZbnIOOigeRuqw454EzTuvWnbNo3jaCtpsbAT32cRV36K/QnL+DfkWpaFoA6aGZpqv
         GxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312577; x=1780917377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0RvTxX98K/pUu8wDZcU84mvng4xT6uAwNgRwaMuMuo=;
        b=bmco6zEWiQz3vFt8UnEtlWBwl/UWdPdIwfJA+vakg05Jpgr+6XDzU7DvmlCjGi7RK5
         krdWKGGGVHa23JCGV1olp2YfhTFUTOMV52ULWmlEj93VZRXtiT21rtg2L+2vAB2HkaQD
         PIHG4Yt2TytTLMiyRoAnGYcgqy0vvcLX+UivKypuqVl1KPO8LJh67UrYvokw1TtTGMEc
         Voibtb0YE96HjHKkBrto7icFwb3XhaENfhgz/a9SnSY0ZdXcAAMmjvB52dB3g3Cmr1fL
         A79RZX14YESsXWseeNwj7sxaJJRkpIM6yqGIodJkEpHRWIOsGoeDnjw+NyQcrr8xcab1
         Eijg==
X-Forwarded-Encrypted: i=1; AFNElJ9zcOsHtbrJc77bfRUZHXBxfloB/Bb2F1LB+P40PLOWqUujPpu4wqXXwO533ajd5tP/tqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeW4fiehCzLvYIWAbXQYPfL9hSH/lOHsRlfwxeozMjy2PbHWs
	kDy87wqGNkdKqX4zH6O84nVB+bOAN/SYdQlXocJLfBv6CIXnE91686fi
X-Gm-Gg: Acq92OEAmBB2/VN/TwUD4LKtGOB46mwzFJdOc8U6JUTeQrfmviz88r1fYJj6Cfw69sl
	B05z9Q02xPXN0bXi4SHhmrZfMrwOlArrr2nDzophxc3tqFtswQlTDw1l+sPqPyi3+iJPs+uLIc1
	UdpyWgeBKlonYz/2DhKMQ7k1i1+PcHqby6sXknKchWN5YKjV/aHPCSn+25Qr1WzpaxABmdaV2K9
	ZhU8+sLtRtGWItzRzHuNf1yL5btjVsGKBz4YcaQUQQ6ey02w/m0jz6Tx6varVtJTcL5yE8ZyaI3
	/hwIt2RaSwTZ0hfkv3kFgR2ernzS8oQJtLgdAuQ+ScQj5+kE6scDj98nw4abW2QgBdlUeg5VzrV
	PteUcEAzRdsRru7moAoSjDTSB3Z3Utu2eTd7lLr+D+v42zrf6x9TvJn+O0Tx1uO4XyFzJ29vFT5
	i1nsko4meN1OLm6FFzYE3+Ku7Yg7V+a8av4Q==
X-Received: by 2002:a17:90a:d403:b0:36d:649a:39f7 with SMTP id 98e67ed59e1d1-36d649a3a91mr8902054a91.22.1780312576930;
        Mon, 01 Jun 2026 04:16:16 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc660da67sm10402142a91.6.2026.06.01.04.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:16:16 -0700 (PDT)
Date: Mon, 1 Jun 2026 19:16:00 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
	Thomas Huth <thuth@redhat.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sergey Matyukevich <geomatsi@gmail.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH v2 4/7] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for
 Guest/VM
Message-ID: <ah1pgb4S-UoSWhC_@inochi.infowork>
References: <20260601084336.2601675-1-inochiama@gmail.com>
 <20260601084336.2601675-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601084336.2601675-5-inochiama@gmail.com>

On Mon, Jun 01, 2026 at 04:43:32PM +0800, Inochi Amaoto wrote:
> Extend the KVM ISA extension array to allow KVM userspace to
> detect and enable Zicfiss/Zicfilp extensions for Guest/VM.
> 
> Assisted-by: YuanSheng:claude-4.7-opus
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 2 ++
>  arch/riscv/kvm/isa.c              | 2 ++
>  2 files changed, 4 insertions(+)
> 

I have forgot to add CSR_SSP to the context, will add in the next
version. But I have a small question for it: could I reuse the 
generic subtype or use a new CSR subtype?

Regards,
Inochi

> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 501e4fc60dd2..9f9c5ababd1e 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -199,6 +199,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZCLSD,
>  	KVM_RISCV_ISA_EXT_ZILSD,
>  	KVM_RISCV_ISA_EXT_ZALASR,
> +	KVM_RISCV_ISA_EXT_ZICFILP,
> +	KVM_RISCV_ISA_EXT_ZICFISS,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
> index 1132d909cc25..9852a91fdecc 100644
> --- a/arch/riscv/kvm/isa.c
> +++ b/arch/riscv/kvm/isa.c
> @@ -65,6 +65,8 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(ZICBOP),
>  	KVM_ISA_EXT_ARR(ZICBOZ),
>  	KVM_ISA_EXT_ARR(ZICCRSE),
> +	KVM_ISA_EXT_ARR(ZICFILP),
> +	KVM_ISA_EXT_ARR(ZICFISS),
>  	KVM_ISA_EXT_ARR(ZICNTR),
>  	KVM_ISA_EXT_ARR(ZICOND),
>  	KVM_ISA_EXT_ARR(ZICSR),
> -- 
> 2.54.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
