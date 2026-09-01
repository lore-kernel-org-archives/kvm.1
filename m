Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F39416124
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275266; cv=none; b=VprEY7omUJqYvo4Yc7FjpaeRcg51oMjBNjEhHfRj6nBb4q4f4Vqhq5uL3nxYoHTjCk5hLEzWvNnkaHmh4zs0ecCU4i80LtoeBMBDL+Zh6I8kmEjCLGTWqva/76TgxP5OUcDVdf8K5SU8sr0OZ69POR/tZ7+Y1ic0q4naEDE6ELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275266; c=relaxed/simple;
	bh=kpVTPF6YcMH1QZmiPfRQzvfUeeNBeoMwT+uB/2f6RVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MixByAuJcq5F/g7fXOvlytWFpGJtsiqZwQUwDngQS1qkg9qT0u8KTfaUa6p4w8HXZxgZ4mld3c0168oVOYILXFEA6DRgUuV6zUbzcT7AiTDPpgYdUnjAXkSZ4oj1X2fgEEoVyqlAnEmfB4E/nVlto5hZojC/mkfphxksGGJaLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIbSAMn7; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIbSAMn7"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1c5810451so1525043a12.1
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788275265; x=1788880065; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V87m4tzcVVZPHB4ukY5ehbJLwQ14VPIAPm5q3nc4QvU=;
        b=OIbSAMn7oUfsfJOXCvZgsPtsAMQTUpnUCyCDCUpb+h8lGRk9cG4dB9FnDsLEVhN+Jt
         cH3KnD0hrrMiMpaiH1uPjJTcPNHD0McQu8TqlmHX81SXV3E1VS0YXIDSp5dE494PUZ+Y
         XTPvXK6069Z1YVAZCS3yoR+TMP3ir5LYlSpcod32SvGzoWcexMFG2PNhhK6kxdIwgwDz
         nI/bPCMA6panslISGG1u7miUB942Q1wsrFUAfTf2BC/NlH1x5FJwNyFs+ryqiNRAg94P
         BrNJAJE73YED5Rzg6/9l7M/+SX9oNyR9tVYoiJsmZJFVkvHASbH0fON4rwSH4xH2FScT
         Pb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275265; x=1788880065;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V87m4tzcVVZPHB4ukY5ehbJLwQ14VPIAPm5q3nc4QvU=;
        b=p1gKZ4715i0YNO73fOwr8lV/7Po6hTVczthIbkF/r1Dr72rEjDeZEBxITkMcTwklxT
         LTAZ+VsDor5GcPtfh7G73Cchso32dulKUi8FlXi/QjSyrXnADOPQ1Hcl7BOuUQAl4SbH
         29qw4fnE7iUOz/CYMWtLOlQ/vooo5teBHX8jWyQaAShMA7aIRAYYobxtO5ybEB+/ciw7
         Cp46ELVWj8scFTgkV0aD0hri+q1AWjl8DPkxGCwu1xYduMQkhfanl6fM6S6q+koXJtoS
         xOE+n37iI6B9x1J3wUe0axYNXNVatQD6YGcvERPdaQ+Wj+WR02byE/r5v89c5oXN1iWj
         wqNQ==
X-Forwarded-Encrypted: i=1; AHgh+RofPIowvUeg9vYirolpYkHeTtLxN0Tg1td0YJNnqQSZntOv9V8Ortjr8sbC/MJdQt72OiQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kEMWoBhl2si4VlUS1uY/vh7fpfSRJnfg2FF8LBXZQvqzF6lGn4
	vH+c/CtiW5oO0uOHkbtHG9bvW4566RCK8HHLo4zFCUgAWb0uWwTawxR+FJe/pVXBEIR0Bj89yt3
	m5IMF/Q==
X-Received: from pgbbz34.prod.google.com ([2002:a05:6a02:622:b0:cc2:87f5:aa80])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e88:b0:3c3:a31b:3949
 with SMTP id adf61e73a8af0-3d2686a3247mr60346849637.11.1788275264489; Tue, 01
 Sep 2026 08:07:44 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:07:43 -0700
In-Reply-To: <0a98f85d164cc7eac4ca584b094aa402508efb10.camel@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
 <20260901-gmem-selftests-fix-v2-4-5a273153354c@amd.com> <20260901083920.1C86F1F000E9@smtp.kernel.org>
 <0a98f85d164cc7eac4ca584b094aa402508efb10.camel@amd.com>
Message-ID: <apbqPyRIyR2qZeH_@google.com>
Subject: Re: [PATCH v2 4/4] KVM: selftests: use allowed NUMA nodes in guest_memfd_test
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 01, 2026, Shivank Garg wrote:
> On Tue, 2026-09-01 at 08:39 +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Stack buffer overflow in test_mbind when retrieving memory policy on 32-bit architectures.
> > --
> > 
> > commit c29a637608e8b3ee37278728fd941b62df184a8b
> > Author: Shivank Garg <shivankg@amd.com>
> > 
> > KVM: selftests: use allowed NUMA nodes in guest_memfd_test
> > 
> > guest_memfd_test assumes that nodes 0 and 1 exist and have memory. Select
> > the required nodes from MPOL_F_MEMS_ALLOWED instead. The sysfs helpers for
> > finding maxnode are no longer needed.
> > 
> > > diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> > > index 2233d871a38f4..aee80dda62295 100644
> > > --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> > > +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> > [ ... ]
> > >  static void test_mbind(int fd, size_t total_size)
> > >  {
> > > -	const unsigned long nodemask_0 = 1; /* nid: 0 */
> > > -	unsigned long nodemask = 0;
> > > -	unsigned long maxnode = BITS_PER_TYPE(nodemask);
> > > +	unsigned long nodemask, bind_nodemask;
> > > +	unsigned long maxnode = BITS_PER_TYPE(nodemask) + 1;
> > 
> > [Severity: Medium]
> > Can this cause a stack buffer overflow in test_mbind() on 32-bit architectures?
> > 
> > The nodemask variable is declared as a single unsigned long, which is
> > 4 bytes on 32-bit architectures. However, maxnode is set to
> > BITS_PER_TYPE(nodemask) + 1, which evaluates to 33.
> > 
> > >  	int policy;
> > >  	char *mem;
> > > +	int nid;
> > >  	int ret;
> > >  
> > > -	if (!is_multi_numa_node_system())
> > > +	if (!get_numa_node_ids(&nid, 1))
> > >  		return;
> > >  
> > > +	bind_nodemask = 1UL << nid;
> > >  	mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> > >  
> > >  	/* Test MPOL_INTERLEAVE policy */
> > > -	kvm_mbind(mem, page_size * 2, MPOL_INTERLEAVE, &nodemask_0, maxnode, 0);
> > > +	kvm_mbind(mem, page_size * 2, MPOL_INTERLEAVE, &bind_nodemask, maxnode, 0);
> > >  	kvm_get_mempolicy(&policy, &nodemask, maxnode, mem, MPOL_F_ADDR);
> > 
> > When maxnode is passed to kvm_get_mempolicy() here, the kernel must
> > write at least 5 bytes to return 33 bits of node status. This rounds up to
> > 8 bytes (two 32-bit words).
> > 
> > Will this overwrite the 4-byte nodemask buffer and corrupt adjacent
> > variables on the stack?
> > 
> 
> Thanks sashiko for report. This looks like false-positive.
> 32-bit KVM selftest are not supported. In kvm_util.h, no VM_MODE_DEFAULT
> exist for 32-bit arch.

Unless I'm misreading a pile of things, this has nothing to do with 32-bit
architectures.  Sashiko is simply confused by the kernel's godwaful, poorly
documented off-by-one bug.
