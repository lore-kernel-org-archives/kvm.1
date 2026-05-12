Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB835F5E0
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601195; cv=none; b=I6Ff1Y3IL2vKy3Ikvvk54JTM6Qw0CsNwLRCe006M9SObivf2EISnws5PJ9SyEYhZvn4afDuY3dc44E7wvAtzu4D5nF9aaLxeRD/F0DeZjJKUO8/pfKK4Ykkb2pZkFrdbKceigMKZC2/iTW475QAWl9aVAS7/lQy/jibmjUgBkKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601195; c=relaxed/simple;
	bh=WgBwFfkUAGnYzD2OlUsYs9T3doLgjxOO4xn97PfaOo8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sveDu/ghkO1tUlk1wDH6yapnCccYGHy8dJbBNOifj1+BmKhOenR0XUtzqi1VpIrRJLfvn/B9fHznQ1L3ejQRwAARY9CQR6GqqXmg2GraL8swyaIi+++UECOema+0mgvJow2yFN8qgyCqxUoIKNvbEmnabo1rOZH6PAOQyrjQkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPcspOLB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPcspOLB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b7aba0af02so61139865ad.2
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778601193; x=1779205993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzzb2jJ1jA7GZ4TPN3DcMZIn6KxUjt0dYZxw4XPowVU=;
        b=UPcspOLB7TQiqgaY0hsCOhyne9ImvbIIyaHelySrv2hJmPaQwJVMqhRIog3p4R2pqM
         HhnFUHUFQNf7KnwDuiM3XC55gHFzKfIZphmaikVUiLtgmpdIV2x+Ke3nZudchAgZ0Dav
         wv4pYWKIKwt1ZVR419gAFu4NPJ23/b+RQLXH/HYBwfbXn5cE0Xshco9E/BCO4J8Y8+b8
         HQ3b5kZ1cE29kaBfMtJKlt7xr9YKZ/5KPEb8iGHy+EaLgsN8RJUiYLoatnnM9OSbIUTv
         shz/iHI/h9yuOigLN54PQrtm8Je8C0iQ659l8Pq5G731NBKDIemhCbPPPPnHgaDYCgfk
         Qf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601193; x=1779205993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzzb2jJ1jA7GZ4TPN3DcMZIn6KxUjt0dYZxw4XPowVU=;
        b=d+4S7eKgHvwmFi5IEOwt4yA738XXuGWP1C4xlGps9agnTI4AH47UdNI7fH1utlmyBM
         OJLtDba0R0Y3FfmfAdXUjHC6Blk+atXsfqTB4m2jZHZpb6tk/0gwFgbDRGss1hVl8wJZ
         crICm4x+NfR2PnBW2ZTUlUTS9D3CbMW5pcaBArxbnKuMyMcd4jNaNBDTVcom5btTPRd/
         3xkuvgXkoi7ta7XofXNlN0vzaGYp4O1MJJhuSqVo/vfuZvm7imdQjxkC4TUr/usL4wPL
         jk8K8ZnPs4rxO+yB5v/rY0cwMWL4TbhMv2pzd4LutzOaQyWJ7TVa9gnB/x9Gq8V5I1E7
         d0GQ==
X-Forwarded-Encrypted: i=1; AFNElJ+l3JQ2OnJIO+LcByiBYb3OT2KQ/dDAptySBgETw7dgkXxPN7WhQHoJVSE8+VUhTKGiTzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0XqzaS3eoLwfIfzTb4PtFRl7XPtieGGfOcfeCPTn6PcpW8WqG
	H7bK2UiVLe346UlTGVAlTphOoPZWb3WZqUAW1zL+/mSWY4jubTBQvIHSIs5otuw75fE6RXgAbmL
	arXG9oQ==
X-Received: from plhq5.prod.google.com ([2002:a17:903:11c5:b0:2bc:a589:91c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b03:b0:2b0:b290:f2f4
 with SMTP id d9443c01a7336-2ba79be43f8mr289028985ad.32.1778601193243; Tue, 12
 May 2026 08:53:13 -0700 (PDT)
Date: Tue, 12 May 2026 08:53:12 -0700
In-Reply-To: <c17d864a-42fc-afbe-345e-c728e2735d0c@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com> <20250729225455.670324-25-seanjc@google.com>
 <0064952b-048c-455d-ad89-e27e5cb82591@linux.dev> <aeJkCGwsrRmuBikT@google.com>
 <c17d864a-42fc-afbe-345e-c728e2735d0c@huawei.com>
Message-ID: <agNM6KSlsFjOaSUv@google.com>
Subject: Re: [PATCH v17 24/24] KVM: selftests: Add guest_memfd testcase to
 fault-in on !mmap()'d memory
From: Sean Christopherson <seanjc@google.com>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: Zenghui Yu <zenghui.yu@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Gavin Shan <gshan@redhat.com>, Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Tao Chan <chentao@kylinos.cn>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 12, 2026, Zenghui Yu wrote:
> Hi Sean,
> 
> On 2026/4/18 0:47, Sean Christopherson wrote:
> > 
> > Does this fix things for you?  If so, I'll send a proper patch.
> > 
> > diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> > index ec7644aae999..c682bda722f9 100644
> > --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> > +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> > @@ -510,9 +510,15 @@ static void test_guest_memfd_guest(void)
> >                     "Default VM type should support INIT_SHARED, supported flags = 0x%x",
> >                     vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));
> >  
> > +       /*
> > +        * Use the guest's page size for all accesses, e.g. to avoid having to
> > +        * map multiple pages, but create the guest_memfd instance with the max
> > +        * of the host or guest page size, as KVM requires gmem files to be
> > +        * aligned to the host page size.
> > +        */
> >         size = vm->page_size;
> > -       fd = vm_create_guest_memfd(vm, size, GUEST_MEMFD_FLAG_MMAP |
> > -                                            GUEST_MEMFD_FLAG_INIT_SHARED);
> > +       fd = vm_create_guest_memfd(vm, max(size, page_size), GUEST_MEMFD_FLAG_MMAP |
> > +                                                            GUEST_MEMFD_FLAG_INIT_SHARED);
> >         vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL, fd, 0);
> >  
> >         mem = kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> 
> This results in another failure at
> 
> |	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size,
> NULL, fd, 0);

Gah, the memslot size also needs to be a multiple of the host page size.  I
actually tested on a CONFIG_ARM64_64K_PAGES=y kernel this time, patch incoming...

Thanks!
