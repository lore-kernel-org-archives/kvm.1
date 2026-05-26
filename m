Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142B38D3F9
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810951; cv=none; b=FHhOgHTVlU/lQHs2l5z2TAuKePDYRqqko2TzwD491BJ8p3isegm2FTGdTMZR5sRT1pMPCL+c/s7q9DLTvnot+CLDubIANxpl5wP/PC2pB4c+/+fLqAR/oRnWOEX4qkfmWfgkVVcQWcfBqbqiWy5McPomPaIwIrJofPI7WYKNvsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810951; c=relaxed/simple;
	bh=vlcIXZfpF5z544D6f/NmQwNsL7FDGdksfw3NZhpVsGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eWohOE6d54AtN6LP1t9y9q4F58WDoVLuInk6IKhHP2EbGqyYH89J3fxJcxCjlIgPVTW/fipTXWLQWy8DHzhKA9JLs6wBOSgTyGEL0QGYclc8ByH/xCVX9eT4KeUzse6rynO55Z26AHjkUZMbK7sL1RVRx47T+oX2mVB/AdezRI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9dxbh9M; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9dxbh9M"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b99eb06178so4484995ad.2
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779810950; x=1780415750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hySHD8b2TDWrlaxMGeF1pIvJSXR1GuivjeYjS/HSokw=;
        b=P9dxbh9Mg692UtWCQG9yCIJdYQSuRl0v+MPZxIR6WJGDDiqZp/lV6jUGQ75x6ZtGc/
         JD+Wx29ydma3NSkWU+ZnC1qmGaX8whalhiEV3G+L5xhPql+mJSFME5zFdABDvt5e3LzD
         aYrXrtnBxamCqd7X3WPBoLMjTQcICdN6F4Vq+z2aRzQwGcTPmYUhd8B7ZgHMfm/lWOM7
         PWn5cWnEKk7O9NFQ1HPeMj2wSg+DmL87XSEhjDzVxmjdtST5bI7Ec2fGoaebBnjyZjqK
         SCpPu3FjiumLb20CSggzFqVl04H24HPyFp/9K7V3rVMo3pJ+FkKM21N2jThHUb2BwXz+
         IWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779810950; x=1780415750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hySHD8b2TDWrlaxMGeF1pIvJSXR1GuivjeYjS/HSokw=;
        b=BKDibZqwFvFmTltWGnYHlMOK7yPi72NW1d5NvZ3ig2Eye3NI6DvcJYBOGKQysG1+f0
         UJTUyllgdJiYHQES/OT15Qw7wbeIZtDQpUYcTL4gzbiSpLKCB1yN97DYM938wzgi3A+/
         COO4dIQTx6n9VJ4rzR1E12q/hOadIlmvL4oKMHjLaVnW+Hnalfh/s4fDVoyDRwmlekeI
         V6RBmMWCyIfSwkBKyAYcoS1Vqvep+gCGc/qNnD+ENFpPCP/q3YGHYniU+E6vWcBMg/+R
         Yp7X814LhD+TBafWJOukeuYMcJSZZ2i+bf0HD7pQ1RKRO6dtQGoc8+/syeemX1g2+8bN
         e7Vg==
X-Forwarded-Encrypted: i=1; AFNElJ9rMWzb7+BRcVnz1WWwS/S3LPkkd48YBcUGBzZntD170zEEA//53YIndCk7NqjoR9paw4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOhuVWBfDnnu0pApcQtEhoRKEL4AxZQdOIGs6KPfLiB07me4y
	i8YLeWLyVmaQGdA5I4Wy5UK/i/FNzK95x8TbEAQX+xoAdJmCVSUPg8Zmxana0Ayy0NMyZbHcPIK
	GXRBOkw==
X-Received: from plnz8.prod.google.com ([2002:a17:902:8348:b0:2bd:7eaa:5d77])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b87:b0:2ba:3e2f:6883
 with SMTP id d9443c01a7336-2beb05d9f8cmr216024545ad.19.1779810949754; Tue, 26
 May 2026 08:55:49 -0700 (PDT)
Date: Tue, 26 May 2026 08:55:49 -0700
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v2-4-3f196bfad5a1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com> <20260522-fix-sev-gmem-post-populate-v2-4-3f196bfad5a1@google.com>
Message-ID: <ahXChYgryPiOck1L@google.com>
Subject: Re: [PATCH v2 4/5] KVM: SNP: Fix kunmap_local() unmapping order
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

Similar comment on the shortlog as patch two.  "Fix the order" tells the reader
nothing useful, other than the author of the patch thought there was a bug.

  KVM: SEV: Unmap local kmaps in LIFO order, per highmem requirements

No need for a new version, I'll massage when applying.

On Fri, May 22, 2026, Ackerley Tng wrote:
> Mappings created with kmap_local_page() or kmap_local_pfn() must be
> unmapped in the reverse order they were acquired, following a LIFO
> (last-in, first-out) stack-based approach.
> 
> In sev_gmem_post_populate(), src_vaddr is mapped first and dst_vaddr is
> mapped second. The current code incorrectly calls kunmap_local() for
> src_vaddr before dst_vaddr.
> 
> Swap the kunmap_local() calls to ensure the mappings are released in the
> correct order.

It's worth calling out that this is completely benign since SNP is 64-bit only.
