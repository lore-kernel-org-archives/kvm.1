Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF793932C9
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622796; cv=none; b=lCZ9Z7FyGCErtaxjAQMLFzSVQ3vN4v2fMc1ULVYRaxCdJ4g/jmemBdVjVXSdvcDfr5J5yJu3mnlgPPNP+iCCWrjsjzo9dZCSe85f286o8OKwr4MH32QkStnAh9+VMCebYQPlBBONL6xxTxUVp/oZWJ2kwqXm4Q0rttApwSIfY1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622796; c=relaxed/simple;
	bh=5f0sbgLOx99dwJMkBq5NiUwfH0lg4jMa9lQjzCvSrPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BhpwaxJpcXENQwZYWFqHt0c3OeDlQcsm34GgpgHdQfCzj4nn11+J/B42bko+QCG12LpOfkUmlsbKdIsyxhdo6XA2405dkPOX4Al0Y0WpV2MZaw2EBOITIt5ADz0oCCSwlUrWUrgs2D/P7pEk/N/cNKn5QnNKD2IBo/B7e0PaEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQuPwmon; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQuPwmon"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353b042152so6036504b3a.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 14:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778622793; x=1779227593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvVTealEAKbqzDp6SQK7MaRjPvv5/iK5fsP9B8BXPtw=;
        b=oQuPwmonHYfSklAUh6FnwZ+uQcCwWnefLhTeK4Zl3R9AoP0ezPeBctjBGaoh4uU1Jx
         2IwiMOUFs9halxXGMHtbCnnktLLphFHJQ4MtkWhyCcNBZAPMln6gATucD5e6yyxyGdkt
         5xbrDUfqKCRmnkW26AP9sigZhwgE0FdM0csp2aartlSPpdXgUsWgi9YEQCKIN7urhE78
         WQQrknEzJ0Ve7xLtp3wjor2M9YbREuvlt9B2JBF8Gn81dmawsETE0vaZdorTx+1bHQdA
         Gy78lETwh1G8BT2bmHxgUNScKnfrcuZfx26hG6rypEBz1R1YzUeZV3pMd9qMzEoMDasf
         bq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622793; x=1779227593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvVTealEAKbqzDp6SQK7MaRjPvv5/iK5fsP9B8BXPtw=;
        b=EbNIE1eVNqmWH1eWNaayFs5LtZMq0pA8LM9AkeXeSE996NEmSypzqeKfgDC17biKEc
         k8GKXlMJyxqQd3dAfrHm8im/AwOyzr+E3nKWabF2q1USvZ/c3cVIoO7uKTDySSWEoDhN
         /2+o3ftGRSk2eg3BloR050fvHQdu5LSy28pyXl4i07DUAcr1Hrx8euljbUwa8VozsqM9
         Gz2J/GjmVNm8n4H7Dak/VXQcrSsfDzHtXW0C4If8uNQQUAns18+pdTBvmvJjp8UX/QeZ
         ozNJOj65FMUhHGX9ov3m9AUTRrxLrGvk2KCl0F4NXGT5IvEjl9LHugtcXR/Xq4+z0Q9b
         s3gg==
X-Forwarded-Encrypted: i=1; AFNElJ/fkHVBnRyYS6qtsM3CffGfRBf+OV0jP9dl/+93F60DtOpqWdWeA7a6+e55dNjjIjkVXLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykylvYvVHJ+gezFk0x7+zWgHzcsLVF4mwS9L7eZd1sD9az2Uwl
	F4vd4xMm/22ryWsh4Jc9zT6zA6/PD5zKuC00Q0MiM2ZH7h8RdKMGvnsQ54tmdBH2bh51zCTBrYf
	sVg2YDA==
X-Received: from pfvo27.prod.google.com ([2002:a05:6a00:1b5b:b0:837:e90f:8cd9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a06:b0:82f:7b98:e499
 with SMTP id d2e1a72fcca58-83f058b2dc4mr95628b3a.31.1778622792910; Tue, 12
 May 2026 14:53:12 -0700 (PDT)
Date: Tue, 12 May 2026 14:53:12 -0700
In-Reply-To: <20260512205250.313933-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512173940.376401154@linuxfoundation.org> <20260512205250.313933-1-ojeda@kernel.org>
Message-ID: <agOhSMXZGSv0bPhX@google.com>
Subject: Re: [PATCH 6.18 091/270] LoongArch: KVM: Compile switch.S directly
 into the kernel
From: Sean Christopherson <seanjc@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>, 
	chenhuacai@loongson.cn, lixianglai@loongson.cn, patches@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 12, 2026, Miguel Ojeda wrote:
> On Tue, 12 May 2026 19:38:12 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > 6.18-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Xianglai Li <lixianglai@loongson.cn>
> >
> > commit 5203012fa6045aac4b69d4e7c212e16dcf38ef10 upstream.
> >
> > If we directly compile the switch.S file into the kernel, the address of
> > the kvm_exc_entry function will definitely be within the DMW memory area.
> > Therefore, we will no longer need to perform a copy relocation of the
> > kvm_exc_entry.
> >
> > So this patch compiles switch.S directly into the kernel, and then remove
> > the copy relocation execution logic for the kvm_exc_entry function.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> For loongarch64, I am seeing a bunch of errors like:
> 
>     arch/loongarch/kvm/switch.S:201:1: error: unrecognized instruction mnemonic
>     EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
>     ^
> 
> `EXPORT_SYMBOL_FOR_KVM` does not exist in 6.18. Does this need a subset
> of commit 6276c67f2bc4 ("x86: Restrict KVM-induced symbol exports to KVM
> modules where obvious/possible")?

Either that or just convert EXPORT_SYMBOL_FOR_KVM() => EXPORT_SYMBOL_GPL().  If
that's somewhat scriptable for ongoing LTS backports, that's probably the best
option.  EXPORT_SYMBOL_FOR_KVM() will only work for 6.18, and the list of backports
needed to get EXPORT_SYMBOL_FOR_MODULES() working on older LTS kernels looks to
be non-trivial

If we do end up backporting EXPORT_SYMBOL_FOR_KVM() and others, we might as well
also grab a subset of 01122b89361e ("perf: Use EXPORT_SYMBOL_FOR_KVM() for the
mediated APIs") to ensure a kvm_types.h stub is present on all archs.  That way
EXPORT_SYMBOL_FOR_KVM() usage in arch-neutral code will also work.

diff --git include/asm-generic/Kbuild include/asm-generic/Kbuild
index 295c94a3ccc1..9aff61e7b8f2 100644
--- include/asm-generic/Kbuild
+++ include/asm-generic/Kbuild
@@ -32,6 +32,7 @@ mandatory-y += irq_work.h
 mandatory-y += kdebug.h
 mandatory-y += kmap_size.h
 mandatory-y += kprobes.h
+mandatory-y += kvm_types.h
 mandatory-y += linkage.h
 mandatory-y += local.h
 mandatory-y += local64.h

