Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998D46C846
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719902; cv=none; b=E5zkFI34KJrOA1YOVOGGoKNQtesp0YG/VVrWSe+8dGasoEvIixK0QfKAgWNP0q88kS1Alflpg98z1LfqsZh8y6+q6fgZFEfH2N/2Gi5aOO6H4Jsi/T5r7Bc2WnURLOuhgyOJFU8E0rf7CJQ/w6oj3RjKNQp8DfXdy5bwMS+mp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719902; c=relaxed/simple;
	bh=pVdzRyvW45rvXQGvNo+BCyzF6lziyPoiK3U6O6uRqdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SS5QZclFxOqAoEEu8LKZem904OpCZSzOuJ6o2aWv3j231gg0NhH3LsTGoGcwCRQpZJteM6DDnvXbEhu0SYw/P9yTxT6C1W7/gbyVeay3+0yGDhtFmhb4lqlOhYXEQkTCKTMnawNKDh3VsaGXhN0NE3tZGFurSH/Ky88cjz1tmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZdPFpI+e; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZdPFpI+e"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso768149a12.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786719900; x=1787324700; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clu0oQ935OCDJt7mErg8+zYCCTgXtjG+YSt87i0Zh9g=;
        b=ZdPFpI+eTJIyh5llgXTLWVt3hCNKE8B2z8XPXjjbClsUKJLxHvIKTIOQVpybjss04k
         RYlOpUm9JYe+lONMNkDRoGDxCwVhkftkjXFTBnoUGNLhH0L6ZrdS2B6DXVyDUvrB30IN
         OGkz7KT/p693IRnUhNZWXYMtYlHqqt/I0OqHiMnUrd5SV1wSkefhJscABosO8AR+utCw
         gORav+LdNBG+P6t+kdQDQWnHplC0LmpJDADskiXckCFPcEq3ZAOtfhOxbvEsCdpbdx4G
         koTAJ2NhE0O4+xgcS7/82mmJUZ+fL3PuLY2D/CBuriebZ43OtAYL5VTdxm6hmrzBxL5d
         qEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786719900; x=1787324700;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clu0oQ935OCDJt7mErg8+zYCCTgXtjG+YSt87i0Zh9g=;
        b=ljswJwBgeMc4CPjh2CnGUMEHgLuV3sLwfvNuxWIk+FqvHp9t6DjBJ6W127LFxNbYB9
         otgf/07Qp9Jx5e86/Ld1Yy7p7LF4m0kEF4fNX0UqNvc9Tf1yM2BP+mvG+xx/yp5Gh6Bq
         HJkZgQv4U7h+BknS72SvkJlqt3mHW8vDvfKynwbpnJpSVNXzVxcqLJXz3HSkVs+S5w69
         3xwFuwXo1fgFyMP09scn/jb4iyK0DRArHtFS6vW3+qYtzeV1weFIururs3ZpK8qNiBaU
         vrKcBnyg1VL7MCHQ9A2PtNf3RbSY4gMEGClIc5z9H988UFEEWpZuMVDPSw08u+ysxB99
         Yq9w==
X-Forwarded-Encrypted: i=1; AHgh+RoqfjmkTMBTet4z0qCP1zxlE54+7zZAoWlW0cExs0RAlSWvytpoq8qZNWU2du9AORX+5BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vuhmOGS7DqJwU28zo6sjqRJame9zyVuyHuFkVP6tgt/nHkPL
	CvwqssOl660vXGpu5peJXdLquJ7HiVP5PwrJCp0i8VKEGUEJ91vlpIe9X97UVO+lEuErhdUkwsS
	e1kydhw==
X-Received: from pglr26.prod.google.com ([2002:a63:515a:0:b0:c79:65ab:b3b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430a:b0:3c3:9c4e:de3a
 with SMTP id adf61e73a8af0-3cc71989601mr7356121637.6.1786719899335; Fri, 14
 Aug 2026 08:04:59 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:04:58 -0700
In-Reply-To: <CAEvNRgE+05c9U8C=Zkm1S9hLw3Lw6YMmijZhEe7J4rYQAuNyEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-12-2fc18ee6d3ba@google.com>
 <1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com> <an3o4h-E8mj6CUaM@google.com>
 <CAEvNRgGpCVCGVjc9jCt9Yr+XypF=71h6eBahkXNkrXhfrtGY+g@mail.gmail.com>
 <an5AcEG9mqDgnBYk@google.com> <CAEvNRgE+05c9U8C=Zkm1S9hLw3Lw6YMmijZhEe7J4rYQAuNyEw@mail.gmail.com>
Message-ID: <an8umm0qisEidt4n@google.com>
Subject: Re: [PATCH v10 12/41] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 13, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > That's why I think it's worth analyzing the cost: if it's in the
> > noise, leave it alone.  If it's meaningful, figure out a not-too-gross way to skip
> > the entire thing if kvm_arch_gmem_make_shared() is a glorified nop in the end.
> 
> Is noise defined relative to the entire conversion process? Would this
> benchmark look like
> 
> 1. Convert 4G to shared on TDX with CONFIG_AMD_SEV defined
> 2. Convert 4G to shared on TDX without CONFIG_AMD_SEV defined
> 
> and then compare the difference in time taken?

That'd work, though I was envisioning something even simpler: use rdtsc() to
count the cycles it takes to iterate over various ranges of memory.  Do whatever
is easiest for you though.
