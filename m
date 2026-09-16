Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA03ACA46
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586184; cv=none; b=VRwAhyIxQVY4cJNqoqsC75bu61WUZojVG9p1lDvUYzEwDyNReI5P4yL/Faj9ZKri4PooWQzsCs9UuScX7kcjvOaNVMAFCgKYKHdBcVDnUDFX1FL3LQwgFi4ulJA/5eQ4RhWJMK12SiJCe2vsq/yEzWJ6iGrgPYJTamA2YdWd09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586184; c=relaxed/simple;
	bh=ZVg1o3nL+kUsP4fRtTCfZ4Q+0z35B+P8XWcdWGaEJHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ka2zkkgzvp3vHyyC/ValOabzw2/unZjqZ+KShHsIHTl+Xikh3fmTQZWTAIFqBLd7XK9LYsww/NDZYl5MxhPklpsZNN7tplJC8XWpmtjd1fnbDlgoPr1XJUwwYyOpy7wqJH8Qr1n7VUsA/7WRFEnxZcOUVaAM6opxoIdv3kCtL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxN8+59T; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxN8+59T"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so101163a91.0
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789586167; x=1790190967; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9tyk2gRNqh2OygqV8s9h46Wy6WNa/6bUmL2Zc6mv7w=;
        b=QxN8+59T1vWKRY5SRVsWTG/ZNR7IDNUiAyFm9wkMEm9sE0udXdtl+gFlpgskOJjv9A
         O7BPH2uMpWhuNXuROmLSB6IFjT90g0GDL/l9XBtxwFee/5UTIG/HCaMeFxotRZa4AFvV
         kiNuQVTNudR3moS/2iBuxlp2b7+ujRirHnLWL/63G+4AITR1d7123otVjTCmqCPzWfM4
         otvWlVRqfI06Tmq529tTLjcs4gCFulSMpmLyfgSBnid2s++e5zcw1zqlmzvwbOGanHey
         YoDB1JV49Vx6UlUL/Z99JbookuthneHAFSXAH643ZHwz385r/Tz5MfPZ6IjxgE1mx9jM
         5ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586167; x=1790190967;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9tyk2gRNqh2OygqV8s9h46Wy6WNa/6bUmL2Zc6mv7w=;
        b=t4UR8lKm1B7o41NmMDQRyoGrCCJTd2mMg0UXODJeJBUewAsnJcfvUtGDD4g6vSIZrP
         lGfNo14Yx+W2vEqtFtW0i6+3eQ9Pz/5M5buxbnwtUq3hn/gPoGuQPptgasHZhhPaEiml
         YjjmqdI9Ax+e0jFfOsnkMMMieGCdgtwE8fKhl/WnpgqH2nPSSio5o0cykJvnOrLvsTOJ
         353dIo+ShwVsckwiCGivroJwN6XUXlB8ISP8Ilu3ONhIIaurUN4VBV3G+BqleU/OBBMm
         lWj8oJkRc/7RAhxC0AHgxIMSF2ji5H1CvXVVT6L8JWN6mJlxYSyY90kjXfaHxvCYVBl4
         ASzg==
X-Gm-Message-State: AFuF++k6TtUJX2qXqSFlBlLZ2+br9I73FC/DVNWhD7aULDLXX/jF9mWP
	n3/W60Di4A3R1/dXFfI+9JoPsrB8TPC4yzNGQvgAGkPn2FH3VvhOqco53NabSZs24rILqEawLsP
	po/pm1g==
X-Received: from pjbka21.prod.google.com ([2002:a17:90b:4755:b0:39b:7c6b:bc3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8f:b0:399:ecd:d68d
 with SMTP id 98e67ed59e1d1-39e1e514ec5mr9424444a91.22.1789586167144; Wed, 16
 Sep 2026 12:16:07 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:16:06 -0700
In-Reply-To: <20260915222625.99965-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915222625.99965-1-kylebot@openai.com>
Message-ID: <aqrq9kE0HnDXQKad@google.com>
Subject: Re: [PATCH v3] KVM: x86: Restrict saved GPA writes to hardware write faults
From: Sean Christopherson <seanjc@google.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Oleg Boiko <oboiko@openai.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 15, 2026, Kyle Zeng wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 064ecc33b926..95b9eac9962a 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6632,6 +6632,9 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
>  		return r;
>  
>  emulate:
> +	if (direct && (error_code & PFERR_WRITE_MASK))
> +		emulation_type |= EMULTYPE_PF_WRITE;

This shouldn't be conditioned on "direct".  Yes, EMULTYPE_PF_WRITE is *currently*
only used for direct MMUs, but it's a generic flag and so should be accurate at
all times.
