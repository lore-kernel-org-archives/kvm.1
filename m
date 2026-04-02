Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE81624C0
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172211; cv=pass; b=DlXYw/HYI362XyAI/iuOKkDPO/i6X5cp+/KSyKqwJzymXIe663OYnPHTifLgA0E5NxFvhnwoEz11rmpWdC1MLkUIMEyV1kwz1Tw9I9NdT5IKFquXCnWiusGTYea1m3q6FECdNSB3heMXqpXoFMMVUmeK4lNwkKvxqkuKSm1z2lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172211; c=relaxed/simple;
	bh=2WAgR3x9pcbMMZEljcq4po1AfFNPTeTXEWuQrsK7vdM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcZd968aHQE6dET/W4NMHrY068v78ShwT7qKp05q0g4idphW+liBwJmMAZKI9RNfiHOojDi1oVvkxcZRQlCErt2veqkUERY62oPKO0BEzdlz7h8uRbWvuuUZGsi/wiQWwvNb+ykAnlIeC91dtal9r1YNkraigZ/WYrVRBadx/jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hgMJCw0d; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hgMJCw0d"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6055a0414d7so471457137.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 16:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775172209; cv=none;
        d=google.com; s=arc-20240605;
        b=YfUzyBNFSun2PE00hZVII2oMQ0yGyVuFqxtALb7Bey+DIQdATJMJftwOYxRUXg8aON
         ytxlShFhxmdIYN6sV+b2Yy+Jzwb2HFGc/pe/oCgT1wzBP6/FPxnO9IVbHsyjs1Mf7sya
         rgpvSgky74tFFkg2PNWVUuYkeL/ehZCF6owJXeOBl1MNh1qTdAV9qwtoQjd9bJafqttB
         UnZSDQcP0c7dhlHhhS9YUbDX2wCEdGiraBDe5tTEmNxJtaIApD2LctZjvGAryAwk97BC
         5AK8VggNopQcMIFwqFEZQrum8r/OkIqDpwcF6DpTjUwXlI7QqpW2xL9xSRGyU2Kyl+b/
         GLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gjOPgwHvpL8SXcAqUI6l7te3rZPTzhYxLIlKMmHX23s=;
        fh=iKNg84BEyZ976U723tfSm3t1Bf8W/HgfQSRQ9eCW1Pc=;
        b=XXn4Nq1bLvfjzAj+XVv8bf/bprbWr+rNZshz/ixLbFt7YNz89aLuqD0eML8bF/vXjl
         4x2DD55PRH9tBIxSBqqzeT09rdfP5sJsQva99RXE7Yc9AcQbt91IoFTeWBn0CeB60JT1
         YvLbAbRs/aO7XxQM/a+L1QuSRaJJ1EPacllTDdKCdk8qx+x643pURC1DBGAOm3ytcOdQ
         Wwzdy8RzD0BpBlMug5/IvMZzefMcdpNNITTPfbVEu7HN0b4xw0UHHNYaf+MQAkAt1iwC
         rwsEQOvolL2Hk9Ax9zLMHMgBJLUIOEiQW8OkpdJ52R3AJLHKXj8qxZ7ZmZUx8NWD/nGp
         SGBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775172209; x=1775777009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjOPgwHvpL8SXcAqUI6l7te3rZPTzhYxLIlKMmHX23s=;
        b=hgMJCw0dcnHo4fyIvrToaTOmwNc7K5lDjkPce3jBlzx4+jUkVSHYGFoZ97rc4je6jK
         UwuI9aiocpsKEetBQ8zM0aCqOpUtzUNWVwsywTGjKdCG6Twc9F2lrhg4IOpMruJtOrWH
         YTFLSpBwG4DMtXWeV0EmAyxCJUfyNEj85AyK/2AE8IUorAIOqAYGYmsXweXaP5HoDmaS
         Z9wVwa/QfF5fB+K83ekIo6qLV/uWRafEm7vFikJZb3SAaus2qGJn8C/H28SZFKNf7WJ/
         RjX64XR4SvTo4J2jOiZKl4YOdyDYktJc+Gq7VXnyC7ajCQPMXSNooRzTQ4aPMx8Dp2FL
         WVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775172209; x=1775777009;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjOPgwHvpL8SXcAqUI6l7te3rZPTzhYxLIlKMmHX23s=;
        b=UrGBBTU0NxuYrnztLF5WvlM4DhBguIc3xEtVb6++LifaIA1jtispGGjmTYBJXBBum5
         GafMFihGeZUQodpE8W2RgVsVrACn8VdsvToiOYURdS0VICn/xRRJ4jbwDG/wnXIgojt1
         11u6oJhGkGHz7t0WrluZlSN/evm0/WufwvqpQ+WXiev2NhC+RZi8ou7bpXiD9aOmaibu
         tVBA8HpFS1/XZ2ZwoXuwaqaod92As7A7Oir8Mjt4PA4Gv+ZimpSNO8t1VEWaKeaZWtve
         RT1Lj8rLyiPEcgsGXTXiyQJnyKXZRSc6m3sK9yfTX4QKRvZrXJpkmpmYSxMJm7U1K+DU
         1tVw==
X-Forwarded-Encrypted: i=1; AJvYcCUWe62gPL7D4qQkzDnQKPA04KOV2DscfrT6X2aDrMKGFucFV3y7urFpd6Y0JgNGrqdr2SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyppmF3JFNlMnqdJWJGxuKVwqxhwCBStdFXSz1EXS6V9+W24/sH
	ChQIiVq87lEpHnLWs4EIpWMl3jSBJglATAc9/969dlAl4zau0K68fCcGUb3IfEfs/HW6O+kQzp2
	9ufYk/qyV8jUS1zokXEIgxw9ZpYaP89k6fuPgVC/x
X-Gm-Gg: AeBDieuwFMQjOlwC8b/Hn/XyoD9K5V5qV4Oyx2IEkiQFqWw5vjd040IhpIxBVVmCLJS
	4EgfkRXbT2WL79vzyYkkeoUg9oIsyQGY1J/PmeqUHeiuh59+IaZJZCbHei1M2EmHDPtl46zM8AI
	DQjEB6OS+g7ZtwyAimqLP+ZuKQPWKshW1zYDYP8JmqTz4MMPgVYNNOHq5g3q0jixpK7yx9Y/mQG
	0A2NJv7klP8toLGQbQu3wNZdclntTdP425IJ+xglY0uJjTPhvD+cA79ckwoqIVE/b2ZC3PbL6oK
	Y/ZWmFbMLwaSkrOXXGNCIN+ASCoushUyVU+aAkhOHGvbZyH3KAKI53nOick53E3de2rxvA==
X-Received: by 2002:a05:6102:c47:b0:5ff:da11:fbb4 with SMTP id
 ada2fe7eead31-605a4cd8d9amr397405137.1.1775172209191; Thu, 02 Apr 2026
 16:23:29 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Apr 2026 16:23:28 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Apr 2026 16:23:28 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260319005703.8983-1-yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com> <20260319005703.8983-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 Apr 2026 16:23:28 -0700
X-Gm-Features: AQROBzBntx9xdv1WNhuZ4VA9cGFnH-Mo9Y24zQ9Jpt4-WeTGuacelxcK9gYE_Jc
Message-ID: <CAEvNRgGknoP=QscA-efLB0LSS03XttsdN3v0KBVROAXTknAakw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
To: Yan Zhao <yan.y.zhao@intel.com>, seanjc@google.com, pbonzini@redhat.com, 
	dave.hansen@linux.intel.com
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com, 
	yilun.xu@linux.intel.com, vannapurve@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

>
> [...snip...]
>
> -u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2)
> +u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *source,
> +		     u64 *ext_err1, u64 *ext_err2)
>  {
>  	struct tdx_module_args args = {
>  		.rcx = gpa,
>  		.rdx = tdx_tdr_pa(td),
> -		.r8 = page_to_phys(page),
> +		.r8 = PFN_PHYS(pfn),
>  		.r9 = page_to_phys(source),

Perhaps in some future patch, are we considering also passing pfn
instead of struct page for source? Would we also update
kvm_tdx->page_add_src to be a kvm_pfn_t?

>  	};
>  	u64 ret;
>
> -	tdx_clflush_page(page);
> +	tdx_clflush_pfn(pfn);
>  	ret = seamcall_ret(TDH_MEM_PAGE_ADD, &args);
>
>  	*ext_err1 = args.rcx;
>
> [...snip...]
>
