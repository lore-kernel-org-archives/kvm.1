Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE743CBE7A
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202859; cv=none; b=fmubR1Yn3kjExGL57pZEdNSZ4/xIwkQeW+FOqIjvHGskaaTbniXtNkL0yVZfeKjbFrch008c/hsFCL+1xyvLQLwsqbNEBQUkJQVa62RIdIvtLCpIkaeW6eQEwqqLteXH9UhWe1BcVLjvao6RkPCh5hwtG58A2o6zsqRFXUadxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202859; c=relaxed/simple;
	bh=vWncEwffRc3SYTUhcngGHajaIOMNvIgO6vhdoy3NFQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPseWRcvQP93G3j/QK8AupUcN8mKzcCR8eFYNrEf4vmJNoAJpmCCw9GdWPRjDDnzftu/qj5zrem8fAiF0wJrOq7W6iGi1KJN99c9YUhyjIeL7o/E8omsr0VG92ICo4BXUb537IPJsAMdV1fmjCZFEBLgXT0fGv6mjZqjwjsMeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d3XTPPqP; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d3XTPPqP"
X-Forwarded-Encrypted: i=1; AFNElJ9xlWo5boM7Mouc0yjXQ9x0uweqMl8Ql5aVmFVZc61lApD+fHMkWfY2QXx40f6UuBMfyTw=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782202855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXAENCcp5BDbPSOsn4f1upfQaIKMcigDEFtOKnyVkvM=;
	b=d3XTPPqP6nxuA3nZACnPD0RG7WGrmRpbiwNM6yx6agjIb+yjGJGr/tbLSyF84tKmWPRI0W
	TlrM/Rht239qLKypf7VVO0H0v4p6mZPDbn8KDzBPPjcO1Al1hCmTOzliUyNYwuz05b2FWD
	FczRKPMYV7cEaUy8DldTS4fe3/YoI90=
X-Gm-Message-State: AOJu0YwXGs3neH8maKJ/OKJK7HGBmpwGfGRpxzoGyWNj2CeVjvuj1ngm
	vAxmmGilW+YZSu9qbYtxr2OKB6/2w+nP0EFhTlDm2Gm5Y1BlUNp5mhpScNXgFW+eOfqIgnLSjMW
	qu5lRW/STg+GByzYir4DT7Zp/lLniggOjeG5E5lpv
X-Received: by 2002:a05:622a:1246:b0:519:f8a0:16b4 with SMTP id
 d75a77b69052e-51a522c6f26mr6874451cf.14.1782202842728; Tue, 23 Jun 2026
 01:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com>
 <CA+EHjTx2xKjheiW5VzHw_TdWFUqdJqfgu=dOPa=_yaYBMY8uyw@mail.gmail.com> <ajnRxuJ19OzZ8zJC@google.com>
In-Reply-To: <ajnRxuJ19OzZ8zJC@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 23 Jun 2026 09:20:06 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwLPCvZJgPv=8u3pgp+kwEwQbsXn_13FL3xUbJ7HRfXzw@mail.gmail.com>
X-Gm-Features: AVVi8Cd8AX_ogmuHxl3lyKLs763XEWuLTlPOQRHFThhzmhUCsdYVCq6sKYCvrh8
Message-ID: <CA+EHjTwLPCvZJgPv=8u3pgp+kwEwQbsXn_13FL3xUbJ7HRfXzw@mail.gmail.com>
Subject: Re: [PATCH v8 13/46] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Tue, 23 Jun 2026 at 01:22, Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Jun 19, 2026, Fuad Tabba wrote:
> > On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
> > <devnull+ackerleytng.google.com@kernel.org> wrote:
> > >
> > > From: Ackerley Tng <ackerleytng@google.com>
> > >
> > > Introduce base support for KVM_SET_MEMORY_ATTRIBUTES2 in guest_memfd, which
> > > just updates attributes tracked by guest_memfd.
> > >
> > > Validate input fields in general. Guard usage of KVM_SET_MEMORY_ATTRIBUTES2
> > > by making sure requested attributes are supported for this instance of kvm.
> > >
> > > A new KVM_SET_MEMORY_ATTRIBUTES2 is defined to support writes (unlike
> > > KVM_SET_MEMORY_ATTRIBUTES) in addition to reads so it can provide error
> > > details to userspace. This will be used in a later patch.
> > >
> > > The two ioctls use their corresponding structs with no overlap, but
> > > backward compatibility is baked in for future support of
> > > KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2 in the VM
> > > ioctl.
> > >
> > > The process of setting memory attributes is set up such that the later half
> > > will not fail due to allocation. Any necessary checks are performed before
> > > the point of no return.
> > >
> > > Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> > > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > > Co-developed-by: Sean Christoperson <seanjc@google.com>
> > > Signed-off-by: Sean Christoperson <seanjc@google.com>
> > > Reviewed-by: Fuad Tabba <tabba@google.com>
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> >
> > Note sure if it's user error on my part, if I'm applying this to the
> > wrong base, but I found a build break here on patch 13:
> > kvm_gmem_invalidate_start() doesn't exist in the base tree. The
> > function is kvm_gmem_invalidate_begin() here. The rename
> > (190cc5370a8b6) landed via a different merge path and isn't an
> > ancestor of the stated base.
> >
> > Patches 19 and 20 have the same mismatch. Fix for all three is
> > s/kvm_gmem_invalidate_start/kvm_gmem_invalidate_begin/.
>
> Ya, Ackerley used a slightly older kvm/next to send the patches.  I at least was
> testing against kvm-x86/next, which does have the rename.
>
> Other than noting that this should be applied against the current kvm/next, I
> don't think there's anything else to be done?

Agree. Sorry, didn't mean to be nit-picky, but this really threw me off :)

Cheers,
/fuad
