Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776231;
	b=21zxgk5cJfVhrTPitN7OU+x1EFObiK//ppxH6RY9vrl2Poc97uEmMx3cw18GzEZHRcKq
	 dLrLK6nfgHwhiV7S5cSF9AMsL0GfTe/Djqq5Wnzr1nk7aTBQjyZoVE5f0GGjOWDHvbjrP
	 BdknSkMjtHfyA6WOpCubFdAJmI2sTy0oLY99jBkT+I0M98qtjkEDFpE0wYeGhX0R3AR/T
	 FvCkNP6uXbVJWL5TxHK4E+QfoAKkESog8Ei7Og9n5bwlZN3JrgLyFpMvQzhRtl+5FW4Rh
	 GradzRYF9zWftjXIcca72eKp0Ty9/YqQ29mYoP7NZ37Lr7jEpteZMNEq2lA06VzCNxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b9U8BJjnSyQLu8vlmMN8CV+h3S1yPSnSBNwOLGcNxzs=;
	b=jDVeJvTLNXWgePRVMPitV3WcGz0KN1/MDDn3Wwsd8AlXerMcKq5KL/H0kVUbjtOAYX5r
	 DMx4gOnXkK3H4BldF+v+pKOgQPN6vDJMlffDnQZ4Zv90qkYsdY3Okchkx/dtrDAGVbbhW
	 43ekSyFo8/DOgUEFBi6FBoWUQyJQRwIErF7BcAsbgcSTG0/nsiDhWjpl+OWQlSfREfJtL
	 o4XGPorBYZAA1YqKHiJ8VvnefJB9U233z8d8tOAMIQofw0qbB9lHLNUa2rymhEkmpCS5I
	 OTba6LbDx3r6FKEt1gVWX237R+yU8gtdVji0YSQfNoHCMTXSrxvxW3i8S32+mBwfcMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="m/lj/Off";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72E606A320
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 17:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F72E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m/lj/Off
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so8907965e9.1
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792776230; x=1793381030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9U8BJjnSyQLu8vlmMN8CV+h3S1yPSnSBNwOLGcNxzs=;
        b=m/lj/OffyrqASJ7/+k2ndy3ARnMmZ4ngzDDHOfoxfIyRpwQk+KAsWUQg3rrdg+qaNN
         3TFoyZ+aewF8WQz7pGfyEVXk5pHwaqut5XJ5xuFHCeBh7vAoOzdEgwybgifqnIAZykIF
         avAi8vIkMrmNGJPtKRcrpQfo9ODQv0n4tbspV4EXY1DvEzOb+OeH8TwDdedQ8F/jexXy
         rs4p9x1faefX53U5CkJj3x29eWfVs5Ga8NTm2vD010Jv9UP2rh6zuzJFkWQHRz18S/te
         y0hZ3bPqJeoOiYzcQCyxNZqytGu/jC/a9iGP3pmR3VmnMEoNj2iCNmhJDNd8HzM1Ilsh
         GG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792776230; x=1793381030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b9U8BJjnSyQLu8vlmMN8CV+h3S1yPSnSBNwOLGcNxzs=;
        b=EbII8b7W83vESTAz9eaBbI5f0cF/hzMakKUluJBxHbOu8fVUQAxBqzUAtA4pxEvj+5
         /FPnKHV7qW79GWtO+xWvA65rhg+HJd2qSUqnmZ6cxKHglBAC6qlB6eJKSYVXbOHJ6Hrq
         T+e9lFxE+JdHlWrrdcWIs2mE2RHz4y0m25Ck4EIQaeUXM6J7iyRxNLDeBZRaGoavrUgY
         dDi8f9IH/UJdbti5f8JkbQVkrc+ItaEoiXcdmpO/EnwlVTWR5qn0TENx5FOaXmkC4rhN
         s6lz6JtIxNCzbSVpo1K5FIO6Cf+7e1DbaU83AKY8TLjoW4jLlIVoWTEQMRI/W9GkQnCS
         lqTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCvmb5/M+orV3I9IoEdiCvCEJTlo5v14yUQeIHykmswfjbaIkPH7oS6NIlMB7B9HlDGbM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDGE0B0cR5X2scU3s95xtGZUgVytQCmzg/kOTVQwMXnc1RCVsK
	ZP/RDIEMVW0NRpcyZY+C1RWQiLbFneRkC/8VZ7AA1K9FMaGIUIlXSgp1
X-Gm-Gg: AYBFou1XRdd0oWe1IUxfq62pINvjX580mwoCfmF4vIjsyWgjIJzZDk28X+MgKqX3zWG
	42CS7xFcG8idLPNQyWr0FLgN/gJn7ZHYwmFwZoC/Da9I6b/fz65C5bdIyOjLnr4RK59rQ84lWqe
	8py803mbHzAOSzoO2qdWNSxrxIPa9GIeMLccjwJGoh3FOjUBXrXJGUmvzL1ZxwaZfAPGZvDfgSB
	TaJLWFdz+3YScgrqZ4vd/Rw6201HRwhk+Q29mCb35jk62pdeHEo/rnMic80CZSwuHJbRKI97iRN
	mvG4WMeWLaeJYDgHogkNckAVrwK9KiCFf+0Hz89XcW96Fe2bC33WiZ2GP0IG7sG194ufV/y7x7f
	Sf1nIpqMsOY4kDdaYqnVHx9S0f+TgF0Kc5JAx5oscE+z1Z6pOXM4qvaVpHV1i9RvnfjjcqX4N7X
	rf55x8/w9pwKsstwBkUeMdAdjQCJSYAaizcPjLoEPU9I9KCUQHo+C3BZ9z/c2uJBK7gZYLL0dY3
	PzzYI3l26oHMMI5SEt6RRtcUMNAYV1mZC19mjiIKIW2yWyGEegka2WIB1Tol98omFbC82+mw+pE
	hqwBTxrYFAhI7txaQuY9mPXSatldEN/J62NDj6XUYp+J561OdZtCW2o/aD0DPJa0NnGp16Mcqxt
	ARTJVJHq+ZxlfGX32
X-Received: by 2002:a05:600c:354c:b0:4a2:1197:1de0 with SMTP id 5b1f17b1804b1-4a211cb23f3mr50233895e9.19.1792776229374;
        Fri, 23 Oct 2026 10:23:49 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a30764e9e7sm17932475e9.2.2026.10.23.10.23.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2026 10:23:48 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH RFC v2 31/50] KVM: guest_memfd: Support getting PFNs for stage 2 from providers
Date: Fri, 23 Oct 2026 17:23:47 +0000
Message-ID: <20261023172347.88443-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022-gmem-alternative-providers-v2-31-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com> <20261022-gmem-alternative-providers-v2-31-5dd1dc6c660a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> +	int (*get_pfn)(void *provider, pgoff_t index, unsigned long *pfn,
> +		       int *max_order);

Should get_pfn() also return attributes of the frame? Only the provider
knows them, and every mapping of the frame has to follow them. Two
examples:

- Read only. A provider may lend a page that the guest can read but not
  write. I know you dropped this from the sample to keep things simple,
  but without it guest_memfd maps every frame writable, and there is no
  other way to make a guest_memfd page read only.

- Aliased. The frame is also reachable somewhere else, e.g. a ring
  shared with a device. Such a frame must not become private; see my
  reply to 34/50.

A u32 of flags, with 0 for today's behaviour, would cover both and
leave room for more later.

Fred
