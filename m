Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61525B085
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471801; cv=none; b=TE0gKWj8iojm2Km32KGXfedcmk/Sf9E9CvGdXaxcBNkpZaTxhpSBDNnzkusl56CXtTbKzdXoF7+nxA/gMYB4I+4SE0FTbyOIslXGtYEY2erHBSb0G0ImaZQA1MdgMh5S7Gpc2kRmV0M5TxYRrTTOd4BGcJquhj5UVKk1V5ku1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471801; c=relaxed/simple;
	bh=Ekfj/I7mK5/NOrsL9YM5YnBlh5U1clx21tuHJ9aVlB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avEC6qdMAW1nQIBRyg7T2fBk7G+37dgF2T7vJLSewXPbz3Qx5wvbjKA44gxvp1WnAtIh1sRIa3bFspSEm7ZiBIfauzcJ5bn0C2aNKEb/RoCyLZcxoaIeo8pmBLDWdXL4whGrEw4D+4q5FbxY6jz/KyYItveh+7KoFODhOZkPy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+t2S9L6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+t2S9L6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738271F00ADE
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779471799;
	bh=pTOtHctpsu0Uxn/mt7EMLg+LFXWIDLG4I8nnouzg4d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E+t2S9L6XBriHAdZNF/SxsPye8XVOZEtgDyQxdCdROLcxjR4aAvZu4LV+3pVTtKCH
	 PzNfkW62iF8Ne3SgUN7rdh2Td85nJVc6MyYlSwp2YRKP6SDhvCsYj87cjZvb+xas/a
	 vl5Q7n38d+ide/JN2XNob4w5YI9yenNBr9BJ0fyDKpToAqRTcpXWmb5Ll6313Va1WW
	 5zI8hmIxz73nnDZw/+Xji0/2DIqWr7oYtPvNZdBW6FAuXhFSXJiGlbUG/iubYDOWRi
	 6vJBlIQ4TvabQAkPs7XGNrYHsJw76htUmze1gRVkJOX4zxZDUQTnnksPjW8VNyfMjG
	 AW/F3spfel0VQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd8f6ef4ba6so1115504566b.3
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:43:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ90e0OtVtCoR5O85ld9iiUIYMjE2Pk9MHNvYPe06Z3m+w90K9Mbq1s3mdRsR0ChvBTlIEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+P9jYLTVA3TliecMw0In3Oa2N/SMlQd/JyHrQDUalgBtTB/OA
	nfJv5pZYA1riis/IT5fpf3VT7itm7uZ/DhDYECOjTe+u2TO3CxersY7+9XoqcLEOUwxFJYZ0vno
	pDrrlN8KYpzbJzjaxjtoRrgzU8vK57qI=
X-Received: by 2002:a17:907:b14:b0:bd8:1c88:cfef with SMTP id
 a640c23a62f3a-bdd2293182amr233353666b.5.1779471798445; Fri, 22 May 2026
 10:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com> <20260521-tdx-selftests-v13-v13-7-6983ae4c3a4d@google.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-7-6983ae4c3a4d@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 22 May 2026 10:43:06 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMY6i+TWoZPWzj8zB+Xw3rONbK-Nee1kSFwDkT3hy66zg@mail.gmail.com>
X-Gm-Features: AVHnY4L9cSm1fyf3xq_QQ4cDC4QbA1ftaP-_x-d2Zge-0JYdQxdSD2nW52x38bk
Message-ID: <CAO9r8zMY6i+TWoZPWzj8zB+Xw3rONbK-Nee1kSFwDkT3hy66zg@mail.gmail.com>
Subject: Re: [PATCH v13 07/22] KVM: selftests: Introduce structures for TDX
 guest boot parameters
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

> +static void __attribute__((used)) common(void)
> +{
> +       OFFSET(TD_BOOT_PARAMETERS_CR0, td_boot_parameters, cr0);
> +       OFFSET(TD_BOOT_PARAMETERS_CR3, td_boot_parameters, cr3);
> +       OFFSET(TD_BOOT_PARAMETERS_CR4, td_boot_parameters, cr4);
> +       OFFSET(TD_BOOT_PARAMETERS_GDT, td_boot_parameters, gdtr);
> +       OFFSET(TD_BOOT_PARAMETERS_IDT, td_boot_parameters, idtr);
> +       OFFSET(TD_BOOT_PARAMETERS_PER_VCPU, td_boot_parameters, per_vcpu);
> +       OFFSET(TD_PER_VCPU_PARAMETERS_ESP_GVA, td_per_vcpu_parameters, esp_gva);
> +       OFFSET(TD_PER_VCPU_PARAMETERS_GUEST_CODE, td_per_vcpu_parameters,
> +              guest_code);
> +       DEFINE(SIZEOF_TD_PER_VCPU_PARAMETERS,
> +              sizeof(struct td_per_vcpu_parameters));
> +}

This is neat.

Sean, is this the preferred way to expose offsets to asm files (or asm
code blocks) -- as opposed to say using .equ [*]?

If yes, I can rework my nVMX GPR fixes to use the same approach for
register offsets. I wonder if the non-TDX part of this patch (i.e.
Makefile stuff) can be split, then patch 6 and the Makefile stuff can
land independently and allow development on top.

I can also split them out and include them in the next version of my
series, then whichever series lands first will land the offsets
support.

WDYT?

[*]https://lore.kernel.org/kvm/20260518202514.2037078-2-yosry@kernel.org/
