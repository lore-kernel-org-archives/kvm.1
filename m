Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636820DD51
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204940; cv=none; b=ieMyLmT926LZ019nlzIWsM2H0IgcvwuYVbPjhZDimO8P8LYfo8+xojMFhXV5BQogvDPmjtyE4vMr56herkybF4FtQp4T6H2msD7WwwxmKl/Vrzq8xQMdYDPDrKq0nfIdLSqvBz2IS8ULPke1EhyxmQWaX/eEfMx0YIi6aVfU1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204940; c=relaxed/simple;
	bh=fhPyyRBuJXO+c1O4aIoSvv3vaX+DNXmCRBVMOMQ54mg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y6MmWbq/H1IcFZFTICdyRrhj62V7228puVNjkHHaIoKxxNBpR9iHfgcNHWG5UwGhR3KgvgX9rdYpnlF/vszRFONOhWZIVc4N9Dy1AtjhbQx9wCFrLVyiq87vvLPsZRQk/Cf0P9jVNt8mcsPBxXjVmgVHfqpaGRdI7JZ3sgyCqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMt6S3b5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMt6S3b5"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so2884195ad.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781204939; x=1781809739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cgKILDAticaRzulsJIYH9W464IRS0YMv9PGXESfrWA=;
        b=uMt6S3b5UF2DW577U9JOSbzITD5oZLystXr/OY6EnBZy0j2ue6SFedG+CEdmDXi9pz
         QKxBT4sPDCr2bcqIY5p4LnShVnNvNUNW+BGAvoMMmEdqYWfsaRsuNXd5MbFAIhqJ4vOn
         3XfZtpeNkojurtsQYEKo9X/08HZ/iO34udBx7uTr711L28cTvGN4HBz3kH5muoKzkhwe
         bCXxnvRd36iiplr7Xl8N40JBtMm6/x8zJgKW6/a09dnLh45HU0807KqbRcxTWU5u+6pn
         bMVSPBm6vbX0rX4mANkRdinzH3OO1ChHBbOg2a047GPTlKCHBNg70S3oR8t6Swt0DE+C
         zHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781204939; x=1781809739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cgKILDAticaRzulsJIYH9W464IRS0YMv9PGXESfrWA=;
        b=ITPAbvZYBgMMkZjZ5LNrHVcmF8GyYr4bHaRw7uBnV2RRdH4O5cvY4tVPJ+xiedsgYv
         lVWZ92SkSetIG2/rQLQbEy7HIM9R6kS07Mfgf92qxxinAG2CUPeT9KZq/9qaS1FSZmv6
         IeJaxb/MbvKDaoO5tkDLDe+Q3dJufDvBq/xoh1wxbktASGQZ/ypymt7XrRsqlGTHltZm
         yi1EVp7GZszd6LpNHD+KYStsQ8X5utUKskEm3mgQdCenXgD0rWYD38ii/FHk0ZL12v16
         ePMuAFeb0QxyU7g83hq22L1oDyUTBJr7eXif6oht3nMFcsdceS4Tn+sPoVPkz6+BMcaC
         oYJg==
X-Forwarded-Encrypted: i=1; AFNElJ9A7AoP43jFmlV6Qy+ZgFF0uOq3tGjoqWGTy/7NPdOvP6ejDYhVe9HLORQ+SqAVhQxAl1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmvOBE5g7tMWcMAR6i5VrUq3Jnm07M62uIq+h1IySVDLXxVRSq
	984MML534W/fqK2kMmbmW6bZGennd4Hlqa7l83QGqZdlWC0yDYq4KTbq7h0exY1KW2XEdmuEmIY
	Uwu0YIA==
X-Received: from plkn7.prod.google.com ([2002:a17:902:6a87:b0:2bf:10b7:41d7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccd:b0:2c0:c262:b917
 with SMTP id d9443c01a7336-2c2f0059f43mr46929825ad.5.1781204938424; Thu, 11
 Jun 2026 12:08:58 -0700 (PDT)
Date: Thu, 11 Jun 2026 12:08:57 -0700
In-Reply-To: <CAEvNRgGrPKBXh=VA3QBLJOczKRpMOB4nDmZL0XRwV6B3PT_7+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com> <20260331194202.1722082-2-vipinsh@google.com>
 <CAEvNRgGrPKBXh=VA3QBLJOczKRpMOB4nDmZL0XRwV6B3PT_7+Q@mail.gmail.com>
Message-ID: <aisHySKe0PwM5DSg@google.com>
Subject: Re: [PATCH v4 1/9] KVM: selftest: Create KVM selftest runner
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ackerley Tng wrote:
> Vipin Sharma <vipinsh@google.com> writes:
> My (future) use case is that with hugepages, I want to run something
> like
> 
>   ./guest_memfd_test --order=0
>   ./guest_memfd_test --order=9
>   ./guest_memfd_test --order=18
> 
> And 0, 9 and 18 are the supported HugeTLB orders on the machine being
> tested. I'd like to iterate over supported HugeTLB orders at runner
> runtime instead of at build time.

No.  The right way to handle this is to define testcases for the "interesting"
sizes, and then rely on the test itself to SKIP if the size is unsupported.  This
is no different than a test that requires EPT, or nested VMX, or nested SVM, etc.
