Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23D3890F3
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419657; cv=pass; b=BndynqzEOQO5jLlA/Z9dRrvwNUjTBHCOPtJ0eYkeSdsbTn5WwbU4vGTQiIr0t2NIoQiS7abGIL0yKg4DwWXoxFeOuh0NsoxgM7izFLo5k2ac4monaf0YBpICpKE6eIWGPZdwIJH9dUBxLHaYrBu/iw+JBoEuu7KdLzcDgpTrMoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419657; c=relaxed/simple;
	bh=U3ahQduobNenu2MyiCXv14Q8IImIIVCNH9OIRKPH1FY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHu7ovBS1KGljBosbVyvlZO7HB2rF59+G/attXI0xWrLyVgINJPT/SsZGjAD3MmdzVQen5OB1t3NKg+1smxzpdY9PW9s3RctVYRcjJdez+afCecIisz6i0PjdhJIFSryxBgsW+ncC4oRwERmG6FdbIvTmQxOP1++5iqrMs9cEK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hsmFq7DF; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsmFq7DF"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-60fce51aa55so3722803137.3
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 16:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777419655; cv=none;
        d=google.com; s=arc-20240605;
        b=SJkKi2w2sfldDyLlYOa+pm+MWErJ6sHnKwLSUywxFCMyvAXIfKDlpzKTzeJ7vpf00F
         VjB+mp8psqOSA+YJrrYIbDtt1tpzckVZ656AuR88yrqCWD8u5qGXNlZ2peas2/qFSLfv
         hSAiYyvhIwL2UrWkUreGF2Vs65L7RiVtnFUp9hJ2AGTJ1aBZpTTfAsOlryfT31VdyO+u
         klKwY75eQut/R23hxf3naZK2RCA2HXZcc1GbWUBDT7BuhOQQ7MxodD1L1qhREFqOp74T
         hLD0cPiJLQHGV8iDTKanZyPW7pYBnm5hDJJsde0zheNOt/fV25sAb1yZldYXge5DcfWW
         I/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fSQsiZsSkLpyfyftl7NX7sITr7YX8npk81aNrWQuVW0=;
        fh=ZUjjivijM4EXTWIrdbeccSFAatGL0e9frBVNOyo56eo=;
        b=h5F2PzPwh1cPb6hSd4ZCPKPOb8kgjXETu0iYS7hjrq/FMJivzfDGt7/FX8vyd3t/Cm
         +Hv/xHq+LxtNAFkEUmLhTqTNPS6Zc/lNjqN8OoOxfoQGF93tVzHnKBcUeThD4uQjfmQc
         NI8e+671NvnVRATH0jiHeX3BFncLjFbODbo1EmvtNguFS16wD0htCOFLi3f+h9et8Qc9
         Q2tFebjVcbGTXi8+FZyPwAPH+BEZsFqFdd/gdr/5tRZ1nAYeUCdN0ESAF9R53wIXdehL
         6a+BtJedGR0I1sp4e729oQ/7nO2fnKkxq/j5OTgTeMjCSLqvQlz33+OegENDIVBzMmYK
         +Mww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777419655; x=1778024455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSQsiZsSkLpyfyftl7NX7sITr7YX8npk81aNrWQuVW0=;
        b=hsmFq7DFMBfAwtb1IZ6VAuUFHbYwGJe7T0YGoC2CKhGIdjx03B6Mtva/uC62TfY3WS
         MmLL3e6YwiFrJZCe2ef7t+xrcR2XxghUK1J9+MA+2/7GY0Kv6SiMlyXY3elQUFAQeYwh
         +TT3HVmfTWZ8OgqvASfAFZ5JbpMU+zuyrahpa3beA3dcT/5NtNlmlhNTUvuQRi2tPGGt
         m0X9RTmx7ze8yVGzOECOZQOaP+HaBZpOrTA9MBKHH7H7dIwkWZ9xYfeHKrj2OLaQm6sH
         177ukz6mlxPHpdy9ilHl6aV/WYum4uGcKUbdHIrqTCVwaxU0rQX9FIolN1xsa3CdA7+E
         PeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419655; x=1778024455;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSQsiZsSkLpyfyftl7NX7sITr7YX8npk81aNrWQuVW0=;
        b=c6ZkjXg/6sqbMIrcTddmsSM14xQnEM74ql4wzT+XZcLnH+kSTuZk13xEiTslrTVzD0
         GcmSscQWyaiOe0D1eq5xrCcJ9P2omKCRswl3u4en9xl6W7KlZqCsXo1+FBNOCU4681vJ
         idRPOW6qR3rqGjbLqrLlH+a8hksuAhyBheb7mL8KGv7FdYDcCYqgZ1Qh4QYalx4//XON
         3AB22GIgPBRJlil11YW3gdiqv8NXFBkPXee1qq7FRBSNaoq0hc3c429jU7Y59biwuYVl
         YOjOqfhxE8EyIpBUOQLx6fTFe34yrJ7FOjXHwD3mBmm25/ZbemImS7S7X4iHfAHs2SZw
         xVTg==
X-Gm-Message-State: AOJu0YwuPyceueeGjSsI+6T2UewkpiKoF0B5PXl5NRd3fcAow9r5msy/
	hDoC6q0L5rlqXdMU63W0H00U/Opeuu3X9GKL7GBuC7It1HMpwz0B2l0gTkIYaiyqq0FT1917ifg
	UMNP5aDhyHay9Z0jkA/8XnXsCFEr6yQN7zvv5A1g8
X-Gm-Gg: AeBDiet408xPb5u8CAynujFGhK2y+P9x7pagB1kwidyQ9I+E6WNtg5EOWceIkgwtW+s
	ueftaVRyAzVHZ0XIitdkjWAw1iKraf5tIZwBk8GGcTxvedLIIVDJ/0mrvIEqgYtKoEOTIBlmpOs
	ftoFHNuMOC3RT7Mue2p/ddZpS3C2MZiC1dLJp01m5cZYAFl2Rn4gA59Im6Z3AA6w0msKnmeibD6
	0/QKoJowIuXpl0eg8eVeFNwcGQBXQkk7TOEyBkMFjwnOl7oB9vPtSLuPARwcXUhDwftXO9GUm1R
	n076SuxDgoiLa4sPAy/LraE2wsMH31xb9NEw+O53YB1eVHGWb6ft7U+AeAE6Y5M5VcVUEyYKSA4
	5+LPW8zmq72gMhFI=
X-Received: by 2002:a05:6102:809e:b0:606:49d:183f with SMTP id
 ada2fe7eead31-6280b1df187mr2828068137.26.1777419655062; Tue, 28 Apr 2026
 16:40:55 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 16:40:53 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 16:40:53 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260428-gmem-inplace-conversion-v5-24-d8608ccfca22@google.com>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com> <20260428-gmem-inplace-conversion-v5-24-d8608ccfca22@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Apr 2026 16:40:53 -0700
X-Gm-Features: AVHnY4K8zc89tOubY_FIZvJs5RqMpzsyiDSJNy3Ts6m6f6GRhz2hBKqCaZ_7fHQ
Message-ID: <CAEvNRgGv3RZipinpQLCGUfBCAfS0PRc1mCx2yc3JgjfEu=QhdQ@mail.gmail.com>
Subject: Re: [PATCH RFC v5 24/53] KVM: SEV: Make 'uaddr' parameter optional
 for KVM_SEV_SNP_LAUNCH_UPDATE
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

> From: Michael Roth <michael.roth@amd.com>
>

Thanks Michael!

>
> [...snip...]
>
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c2126b3c30724..bf10d24907a00 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2343,7 +2343,15 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  	int level;
>  	int ret;
>
> -	if (WARN_ON_ONCE(sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO && !src_page))
> +	/*
> +	 * For vm_memory_attributes=1, in-place conversion/population is not
> +	 * supported, so the initial contents necessarily need to come from a
> +	 * separate src address. For vm_memory_attributes=0, this isn't
> +	 * necessarily the case, since the pages may have been populated
> +	 * directly from userspace before calling KVM_SEV_SNP_LAUNCH_UPDATE.
> +	 */

I dropped the #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES from [1] since
vm_memory_attributes is #define-d as false when if
CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not defined.

> +	if (vm_memory_attributes &&
> +	    sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO && !src_page)
>  		return -EINVAL;
>
>  	ret = snp_lookup_rmpentry((u64)pfn, &assigned, &level);

[1] https://github.com/AMDESE/linux/commit/7e7c29afdf3763822ced0b7007fc0f93b8fb993d

>
> [...snip...]
>
