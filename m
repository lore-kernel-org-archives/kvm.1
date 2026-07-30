Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E13DA7DC
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450153; cv=pass; b=ov7ddWEIRECT7lxhEurk2oMlHf5u5XHkcvkEoMPHuy+0aJVwdVACIK0VSMP4Uvibw2Fidj+VlUCMfjznPJwb2Ib3CiSqSCJVtOWQ8QGs7WwedOixeYZxX8w0PwDOBEX+JqUriIWnODsbNPmRGwc/wShhSVvmaiK9nlduRSppCpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450153; c=relaxed/simple;
	bh=TwuTFoIIkzmwmA8oaGhsoy6UeQB2MH+oAc9PwYUacYQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVGZdx0sdfFyTZx8a1rDi6DQ07jLUlkb1K7qOesYQBw/PF3oPj35qK9DnhJg9XQzqyWXF55SU3LVPWSPN9hTFGkoJw5h1y2LrQ4Z773NJSIFNY2r9pLTIaHG2L48fkWCHKJw81EHFDc0DxatwBdL43+b+DGS8xNfQtPHO11DUrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDWBZ4VI; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDWBZ4VI"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1466961b3a.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 15:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785450151; cv=none;
        d=google.com; s=arc-20260327;
        b=CUAw9L5VcoKewhFHG9F2HuMZyuCxwvRDE4TafTSeZGhAufyeQpGuBV8HcNF7NBU32o
         7ZHDzVDXlkkJdzBsINtORllAT80+NSgi8+EOpK8ogEpEN6wTz9teX4v9KckcMPma76FT
         Rl974SWCoB+ucoe7xkxJMWEogBbHwltqlSL+Z1+CdyrryutnB1snLRq6TM7jBk/bJEY/
         90i58LKOT96lNJkvbDAeOTMcZ6rFHefyk6/n56zjaibF9yWMI4k9HMldhYegYsZKGMGg
         cflKEnKGsWZYL7FB7NajMTtXNmj4MZ+sSE2ufPHYYT12qxGCkPWQrhZ7O+0+SkINCSGa
         2wQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KKK3RxskpKfni5OmmKwhdX+l3ihKYPthumPMEB1IvdA=;
        fh=EU4AzIIRBJ2ngivreOQBh3QCxHs9TIYUX3YVcsmwOUg=;
        b=Wb/7WQdQHdI2DKTNgPy/hYrABIysAbrqO4BF3ikPbpJQBHwcxY9kKwCMAHB62AuP4K
         zBP6FJLD2mEbLLklAaOfnzPU2bmUIySEZj7eLxg61e+zNlKLIBprt1KWZqCfd5k5AUWm
         VQMbTw3Ivpm52UaWUFkDYaHG5/tZpYMVI7lmj4c33S52TQpNare5n4fcqrvb/9YMS+hB
         fBFj5w7/vLub/OohsvvCC3i9KnGjqA3FLs7tl9A0aJFxxqFQ08GNpbuk6ycXmGFE0JGO
         xtY87njyYvKAhwwlepEJq0kOPzhorUUtUZVGeEXLmb7lv+q+UHMz62pLHe7kwmYmwC7H
         13cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785450151; x=1786054951; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKK3RxskpKfni5OmmKwhdX+l3ihKYPthumPMEB1IvdA=;
        b=WDWBZ4VIMh3Ow1a+yhceUSQeY6vEwLZw5Nn3JutScqAqRVRkWEYlR5Mig1nBYs5XUe
         haQprMxiqiWLa1R7jmCp/NuQNkkFttPOiZLYHfutYjO5WtH7Vd4YCvpUBu/EhTFrGOIR
         cs/yztxzs9ycy+0j7EJQUnZvLHubkaJPy4MO3ub0tIIY8ESyV7024gxXzXwvfutuHTyJ
         L6v02gDP4SoWQ0FVLbGxKZxcR+qHOk8QXYnIa8tEgkylWDwMS6kZWho0yFJKDrWHLKvh
         maO0lL5rLij6qN76vyTFzf3CkR37gJR5/8JgKeL7opDcBpMGnfl6RheIjlvq0JJYKaEd
         IkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450151; x=1786054951;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKK3RxskpKfni5OmmKwhdX+l3ihKYPthumPMEB1IvdA=;
        b=ggIkEGzazw9eo7Klj83D/MhXa77k7/y7WSd6hKV1YoT7jVYYX7YooQXLVUDU1MDdWZ
         qdSdgRD0f7voejsRDnLwm73BLZFtIgWSMD2BXOXJwCvI+ncggHYi+PHftQq28WYWHWun
         xrs93TqC/cc6pvKnnRz1NCCNEeLuMRUqBe8Q1siHP4cH8irQkuKazcqoST0yOgYcnX6f
         Fvm1zc2ezcucfq1g2ZYZ32N3ec83XdFOgIPhHWb2bBG11C2E9KhctUGb3zWfMsIxNFUs
         BfsnU3V+eGRB7NnmGDVEFyBxfpfPouC1kVujmPRW2hTKCjRyBRjkmpLijiMWW6aA62Ns
         S28A==
X-Gm-Message-State: AOJu0YyT1SMfscsM7WqL0OGPV59p+kUkr1PHsBRwu/DEvvqb5EkyMv4J
	QtlNvHcPCUhYO6vm1e8PsEGI8IkxMnn7SU9iiC3rH9akrSJaEsAs2UZ5FBtYLjv2778JclZkLgW
	xb+sFLFCsykK008DC4bKqyHF3LaAg1SJtGXcbMwdH
X-Gm-Gg: AR+sD11o/7o9PaJnOFh0+oQ+oIPpQAJPRAVVmik1ivS3tAtFZwhP5nZtOA5lYds1Dx5
	vLmvfJlo2iwS+5afNr3CJUbhIFV5WI+fZNIZ1pya+JEi2fHI12kwrdB6R/MgUakDYq7nlOz3pg3
	Tgaq4WRfp11jQXAEz9SwLljPFbQs5NxeWJQ7WStY1kIG3Hzxv87tXe3nx7+D/uYVlleLKdPwT4t
	GBrybpAa+UnNJhCZnHAP+Mxr29RbK6+UVntXXeXwgrqEpipX265eN06ZA7Pr+83k2Vwv7BKppyP
	POEUa3SrHQ5fsYiPMDIPjaVdp27Qdlq7qMqFvEL+QyqrjqiL5IKvYFSwucZWlPI44r6oEyWsaEA
	40iBirepBdhAGVU//ZAP/agi7Lzr0Iq8fHPY=
X-Received: by 2002:a05:6a21:6da8:b0:3bf:9e85:b423 with SMTP id
 adf61e73a8af0-3c90da9f0e9mr1921619637.34.1785450150418; Thu, 30 Jul 2026
 15:22:30 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:22:29 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:22:29 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-10-35f9aec2aed2@google.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com> <20260728-gmem-inplace-conversion-v9-10-35f9aec2aed2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 15:22:29 -0700
X-Gm-Features: AUfX_mw9STeH1QmcRlHkiOeSUMR5OU477trBpGu6VFzJOghNh8UuiEXaLRojjC4
Message-ID: <CAEvNRgHEDMnz7Fc7iyegC9wrc1R_AMHiWUN_rx=3Ly67bg1dNQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/41] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

> From: Ackerley Tng <ackerleytng@google.com>
>
> Add a new ioctl (and matching struct), KVM_SET_MEMORY_ATTRIBUTES2, using
> the same base ioctl number (0xd2), but with R/W semantics for the kernel
> instead of just read semantics.  "Officially" documenting that KVM writes
> to the payload will allow KVM to support partial/incremental conversions,
> instead of all-or-nothing updates (which requires complex unwinding), by
> recording the failing offset if an error occurs.
>
> Opportunistically add a new struct as well, even though KVM could squeeze
> the error offset into "struct kvm_memory_attributes", as there's no cost to
> doing so in practice.  Pad the struct with a pile of extra space to try and
> avoid ending up with "struct kvm_memory_attributes3" in the future.  Use
> the same layout for the fields that common to version 1 of the struct,
> e.g. to ease upgrading userspace, and to provide flexibility if KVM ever
> adds support for KVM_SET_MEMORY_ATTRIBUTES2 at VM scope.
>
> Introduce KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES to advertise the
> availability of the KVM_SET_MEMORY_ATTRIBUTES2 ioctl.
>
> Update the KVM API documentation to define the new ioctl and its behavior,
> and add the necessary UAPI definitions and capability checks.
>
> The process of setting memory attributes has a clear point of no return
> because, for CoCo VMs, zapping stage 2 page tables is a destructive
> operation. Unlike regular VMs, where re-faulting pages into the stage 2
> page tables merely incurs a performance penalty, CoCo guests must
> (re-):accept pages after every fault. To preserve CoCo security guarantees,
> guests will not accept pages they did not explicitly request faults
> for. Consequently, during memory conversions, any operation that could
> cause the process to abort must be completed before the stage 2 page tables
> are zapped.
>
> Zap only the ranges that are not already in the requested state to avoid
> inadvertently destroying (CoCo) data. ARM CCA guests will try to mark the
> entire DRAM as private at boot. If there are no shared pages at all, the
> to-private conversion can be skipped, but the existence of a single shared
> page would require the conversion process to proceed, and if it proceeds,
> zapping both shared and private pages would destroy data and break the
> guest.
>
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Suggested-by: Michael Roth <michael.roth@amd.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>
> tmpo

tmpo is a stray addition from my rebasing/squashing.

> ---
>  Documentation/virt/kvm/api.rst |  63 +++++++++++++++++++++-
>  include/uapi/linux/kvm.h       |  15 ++++++
>  virt/kvm/guest_memfd.c         | 119 +++++++++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c            |  23 +++++---
>  4 files changed, 212 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>
> [...snip...]
>
