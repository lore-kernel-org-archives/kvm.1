Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAF44606A
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514310; cv=none; b=dD+cjj5xpmz2SAJ9roIj+smi+A1eAs9kxPRNXaKwOSv5TqL9Kp8ZKw5kUQnBFsTM83xUOA7yVH1pOobi4ViDN314OGwX8pAcPw2tArifzJrLKs8deNyaqfGOcAFxTMhk4HDufbYMy4YnkO6ZHLn/WmoHuuOgn7BtRtQeasG0OIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514310; c=relaxed/simple;
	bh=ZHuGxhrJ3MrlsbogF2sbcHpAeby7swdSHdnCo3MZvUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tqI923bdVrmoB/mInRCOGTusi35zbN7bc5cK9khZxFlbzd9rZ89iZfCmrLqWN3L1TDcTevtzZ895RallqMAaFwhe8rgZ5m4XeUDQJIxfM6p0XPxhGWc0K61XLWK+xdMx7ya4XbBsBOKepX6XHLlKi+7b7Vypqhh2ddd836uDVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FNsquI40; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNsquI40"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848544a8496so1423466b3a.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785514308; x=1786119108; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bm06E1ea+m3fCfij6trKrrVxSCnF5pTP6S2pONTnQSo=;
        b=FNsquI405OAyDg3DfoezRZ/2NOz2pxC1lHjzZaU63iXcJW+W49WaLVw6IKEmg+Lgo+
         MKkI4Cq9XkJhOMZl7ChRNuqVl4c3cga8aHB9KiSFS40wy073Kvnv/tbXDzpjkog7Z6WS
         vo57B5jwjoRpVUtlq31kvm00NdWVjZd0dT7t/vQ4l8sy6lG6SNE7nVwo8R7K7d9tpwd4
         IsDr5vGeGreZvPtNOAZVkvkTh2He3GkPVNbkoaxFfERVsEgUrzwEQpkpbDDaKDv4RHw2
         bF0ZNtK+bSkN5ATX/2hymbT5f2izZg29iMuT5pfHXTEP3i5MjGkoUlAwB+foOtwSO7Ne
         gMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514308; x=1786119108;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bm06E1ea+m3fCfij6trKrrVxSCnF5pTP6S2pONTnQSo=;
        b=D9rZhstCK6NwthgvKntMEvxtCbX5Okq+MuL9ceaVCTF1vj8l3G6goiuizmf+VYggUB
         3I5UDKnwDYVWKHt15sabacwpo5RxgoGndBpbeCeDl781Okfq8AVLOyg4W4kIgu4chA7y
         SyX6eRKiCEirh3sgfdxJdRh5fh2/U6KQgpk/rS+zPfWnfaIy8akLBHZpisxk+lWy0JyL
         gqmQK4WUre4rCZExQ5IZuD6Nf3LSt0TmgK5NGN+Lh95XsMWl8TiDjgSHTMwcqrq+hg5m
         HFQB3nk7Q/Ctef7EQvKKKwMSiYYCyCS2uVr609MGWbB9GJ1G2ICJl+oJoFJ5jQ/W49r1
         YfLg==
X-Forwarded-Encrypted: i=1; AHgh+RpZDpqZ4Mz/TkLrhgyifVq7+hL97rbcYD7LVGNrewT/gD85bxl/cYPX5mSwfPNoeXS7FTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJdV+orxNtMVTJ4/T6r9nZxETjVECxonCHgkBO6+l0vhg+sUP
	KlrdoTnRdPv/RtqGSccFaeD60vdJrDDHkNH57flcOThOVeN6QnNFFMq3VDoncV+W81PCYkYP7sR
	yQ7NyrQ==
X-Received: from pgl1.prod.google.com ([2002:a63:b01:0:b0:c99:7baf:125f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4091:b0:84e:4d6:78fe
 with SMTP id d2e1a72fcca58-84ee47dc3aemr250368b3a.3.1785514308039; Fri, 31
 Jul 2026 09:11:48 -0700 (PDT)
Date: Fri, 31 Jul 2026 09:11:47 -0700
In-Reply-To: <d3fef015-0546-4993-b354-a8464d79e48c@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-18-35f9aec2aed2@google.com> <d3fef015-0546-4993-b354-a8464d79e48c@intel.com>
Message-ID: <amzJQ8u8I18B4Gdm@google.com>
Subject: Re: [PATCH v9 18/41] KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 31, 2026, Xiaoyao Li wrote:
> On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> > 
> > Update tdx_gmem_post_populate() to handle cases where userspace requests
> > "no source page". To handle "no source page", populate (perform
> > TDH.MEM.PAGE.ADD) using memory in-place at the target PFN.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Tested-by: Shivank Garg <shivankg@amd.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > ---
> >   Documentation/virt/kvm/x86/intel-tdx.rst | 4 ++++
> >   arch/x86/kvm/vmx/tdx.c                   | 8 +++++---
> >   2 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/virt/kvm/x86/intel-tdx.rst b/Documentation/virt/kvm/x86/intel-tdx.rst
> > index 6a222e9d09541..d8d9409120e61 100644
> > --- a/Documentation/virt/kvm/x86/intel-tdx.rst
> > +++ b/Documentation/virt/kvm/x86/intel-tdx.rst
> > @@ -158,6 +158,10 @@ KVM_TDX_INIT_MEM_REGION
> >   Initialize @nr_pages TDX guest private memory starting from @gpa with userspace
> >   provided data from @source_addr. @source_addr must be PAGE_SIZE-aligned.
> > +If guest_memfd in-place conversion is enabled, pass 0 for @source_addr
> > +to represent "no source page". A source page is required if in-place
> > +conversion is not enabled or not supported.
> > +
> >   Note, before calling this sub command, memory attribute of the range
> >   [gpa, gpa + nr_pages] needs to be private.  Userspace can use
> >   KVM_SET_MEMORY_ATTRIBUTES to set the attribute.
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index d1af0a752e97e..e890da5f18aed 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -3192,7 +3192,7 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> >   	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
> >   		return -EIO;
> > -	kvm_tdx->page_add_src = src_page;
> > +	kvm_tdx->page_add_src = src_page ?: pfn_to_page(pfn);
> >   	ret = kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
> >   	kvm_tdx->page_add_src = NULL;
> > @@ -3238,7 +3238,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
> >   	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
> >   		return -EFAULT;
> > -	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
> > +	if (!PAGE_ALIGNED(region.source_addr) ||
> > +	    (!gmem_in_place_conversion && !region.source_addr) ||
> 
> Sorry, I still want to discuss why we only allow in-place PAGE.ADD for
> gmem_in_place_conversion only. Though Yan raised this opinion[1] in previous
> v8, I'm not quite following her argument. So let me try again.
> 
> I think in-place PAGE.ADD of TDX doesn't need to depend on
> gmem_in_place_conversion. There are two use cases actually.
> 
> 1). Userspace sets the gmem page as private, and invokes the in-place
> PAGE.ADD by passing a 0 source_addr. Due to patch 16, the target PFN will be
> ADD'ed to TD as a all-0 page.
> 
> 2). Userspace sets the gmem page as shared, and writes the desired content
> to it. Then converts the page to private, and invokes the in-place PAGE.ADD
> by passing a 0 source_addr. The target PFN will be ADD'ed to TD with desired
> content.
> 
> For gmem_in_place_conversion == false, only case 1) is possible.
> For gmem_in_place_conversion == true, both case 1) and 2) are possible.
> 
> Basically, this patch is changing the behavior of KVM_TDX_INIT_MEM_REGION.
> Before, it returns -EINVAL when region.source_addr == 0. Now it wants to
> allow the "region.source_addr == 0" case. If we can allow it
> unconditionally, why bother adding the restriction to allow it only when
> gmem_in_place_conversion == true?

As I said[*] in that thread:

 : Because retroactively adding support for out-of-place conversion is pointless
 : (requires a userspace update for a feature that's being deprecated), KVM can't
 : generally support using the source for out-of-place conversion (it's effectively
 : an obscure zero-page optimization), and IMO rejecting the out-of-place conversion
 : scenario is valuable for KVM developers, e.g. to help newcomers understand what
 : exactly is and isn't possible.

[*] https://lore.kernel.org/all/akMPZePBdwQlD74H@google.com
