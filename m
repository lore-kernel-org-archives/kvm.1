Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E8407CDA
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814030; cv=none; b=pEJ5cBOyJcLYi2Lk4mGOjBUfZx12JYvMTkfG21WwtBnHuoQ++e9aouUCL4p0wAPYWYWzsp2ec0DNSnjogv5jUyIpZNG225YkJnGBZyC62lAIjXsqzwA19OwirBxpIjnxBta1/aqPnpb/XBU26OsfWMgLaOZ1TtYMuXV/5P5wgLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814030; c=relaxed/simple;
	bh=HGgVKFUyZeW/doyt/1y5AWLdMAlMEEHs85xRlHMS8CI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bl1bBh/a3wh8mZA+Y0pWVPOLoUNflldhGjGSYq5vXlF7UBkLtv4mfN4sO9/0I4+awkqdpfaA0uBBaTz2hhs/dbCbciI4KcRimOt0cEnBD64wyRf8Efd+d8OGNyQDV1rgBqGD7Q0bU2+ruEbT2Jk1SaKwUAjdDcDAl0OKXRhGriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wh4Za8Nu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wh4Za8Nu"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc977e6aedso114954155ad.2
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779814028; x=1780418828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5hEkpl5l62+cN1SxJ1PimRF17M7yN52dY6rYG/782eM=;
        b=Wh4Za8NuZ8/zE0fpWJxGwHWazvdnRq9LzY2lf46Iwo+zeFh2cFfdBsLVDtnItgwIsd
         qR1xhOIDOlUfaVp3j8ZfmVZVsH+R/SnGi4Hso+JgGkhEvaYIVaRV0EIcGOB1HUQicQRh
         E1FOX3Gdg7KXuQnBWzFiAJwNh/n4cF0c0eytjEYHK89uu2iT8I4AwXWk8OPUd8Iyh76w
         pZIF/+6KP2lw+fuUanBUpv71xhwoMl84qHPawJ3jmr8FpZuaOKMyNp2p8Uy1ycDpvKI9
         rmTFo9yzydNBttx0JZXP4fcF8g8FFmgxo+cu4iM9NNfz++lmudjSZo7Vxy3j17BTs7kx
         WRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814028; x=1780418828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hEkpl5l62+cN1SxJ1PimRF17M7yN52dY6rYG/782eM=;
        b=gW68pGn82ClK97EQ+0+wKcNyEjqmf2THOvWruzairrxng0bBncT8ilxS0Qo0UoPF0q
         SEwOFCO5MdPshCE3JFanp+2k3B8WsSzXldWb4PO1UQc3Tiqid1HELwqqqwL6chC6Pr8/
         bWk3xxt/Fi0m/5eG54m5+ge2Qmwy7Zb+53bny1jcO7imecsIgOKX1H8T4eMsFgb3xhmT
         mOuSJ+NpQsoYxhaNQdJQQH2SwF2VE/mdwWAFZvrSMF72Hv9GbYbY1/02Kkp5Wyw7XVJa
         iw07w+5qnSmuyWH/SW2otxuiQuSDmaYVbteEsHAG/L9ANFm1czR6c6bdOEcpgE7cgLs/
         Spog==
X-Forwarded-Encrypted: i=1; AFNElJ99PjhKyzXCg9mllZX36G0PxlA9mDDvEXg5dgsozwrsLVZpKRUCvgH2CDakjoXJkWnZLHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7sBcyEGWm8gVZlXvLSkbCVGN44oXc++w7z8KUYgfu0UPvGM6q
	7PxZv2lbNhTpUW4XbN9Bws+9LVrnipfomuqQxsO2Tg34lFmNsCT3VC/MOOQOxotM2TkmXZK9Pnx
	2YJzDdQ==
X-Received: from pgbbj8.prod.google.com ([2002:a05:6a02:188:b0:c73:8741:7555])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a03:b0:3a1:90ef:7e46
 with SMTP id adf61e73a8af0-3b328ed621bmr19755806637.33.1779814027730; Tue, 26
 May 2026 09:47:07 -0700 (PDT)
Date: Tue, 26 May 2026 09:47:07 -0700
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v2-5-3f196bfad5a1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com> <20260522-fix-sev-gmem-post-populate-v2-5-3f196bfad5a1@google.com>
Message-ID: <ahXOiy0dBSBOQli2@google.com>
Subject: Re: [PATCH v2 5/5] KVM: SNP: Mark source page dirty in sev_gmem_post_populate
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 22, 2026, Ackerley Tng wrote:
> Mark the folio as dirty after copying data into the source page in
> sev_gmem_post_populate. After the memcpy, failing to mark the page dirty
> can lead to the memory management subsystem discarding the changes if the
> page is reclaimed or otherwise processed by the swap subsystem.
> 
> Fixes: 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating guest memory")
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  arch/x86/kvm/svm/sev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index dbf75326a40f4..1a361f08c7a3d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2395,6 +2395,7 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  		void *dst_vaddr = kmap_local_pfn(pfn);
>  
>  		memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);
> +		folio_mark_dirty(page_folio(src_page));

I'd rather use set_page_dirty().  I'll fixup when applying, unless someon objects.

>  		kunmap_local(dst_vaddr);
>  		kunmap_local(src_vaddr);
> 
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 
