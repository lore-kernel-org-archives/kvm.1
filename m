Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7129A9C3
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180506; cv=none; b=C3sBT4ciFaU60lwC/IKBAbFTjQcmOMhkZJpzO4B5jXkJZ+5dJRA7Kjl5fzQgVkVDGSDxJhcyUK4sEZz3JwBJ12MgqMWU29d/YH5ioaDO+9w3ToZi2m+FlzOQybv6cfoabbQ7MX0xbCLpIZcxaQrR4PjME4HrLF49qOiZDGKJhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180506; c=relaxed/simple;
	bh=/szOEFlEuCK8HzH40tWXZI0IjYEZzIV5NiqgkgiQ/q8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GzkNWqttfwfvwRBrn1ulYehzoe+fHEGiOl2x4JEIFERLpf7RsYX8NGx/bMaYgQ5K5UiVyX0oCf2HJh9mGJkP15VuDN00/zI1H2GY2iu233ux6yY8XDMpw+TLeDd6LoyUwmR8WdaleC2/G/GrhPZAWsFLXyEOLZxft9MCvVlpktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBzKuRp6; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBzKuRp6"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-88b9d8c9e55so1186866b3a.1
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791180504; x=1791785304; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IITz2XbwrAyv27W8DNZJyeO2sE+zaKLd0NzyMXZbO5I=;
        b=CBzKuRp6NUdR1iVhRMhStG+t8DgZsrWN3udvwyk4jhHo8qX2g2yLzD8k8KPaIfnkwo
         lHwFZbJd2KhjYLkxQG6qD34vAMBcKjjbIJ99dMrYuenovomgB2WDQvjIHe8KtGbJDzMy
         dwX8duBOLDFMpiMHRgJljxmtXMErfaKBBulzKh8nEBxmdB5CTEayxPtinOrkBLTvXSlp
         /3TbucqyOD1oNjejh116hgdvC6h1aP3EIRxlpXpOOB9HiWQT42u11EgEBMUeRk3+uGGI
         vL2bwTHVHjkgrvBplbhysprpArScuLDetpJSIe3EWV4RZg1wGvpxW9zx3vB+w9ha0qm/
         9bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791180504; x=1791785304;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IITz2XbwrAyv27W8DNZJyeO2sE+zaKLd0NzyMXZbO5I=;
        b=P3nhX2HhkG4yk6f3XNHSeqq6Hjs2/17XCE9S+rGCnjt2tkyKgBY/dwmGfsMWiAQLCd
         FiCTaAyfsFlgoNmI/GXgWc9rzIDVKETdTBhItneFX62Ej9EJzR2LvmyoV1DzpOnZb1xb
         Om8Gqy6KmMPdze+5E4zntv1rK/8iLbck7F59OtfLwZjhPmA3Z1MObt6Hkpo7oOjyy3NB
         euDjWUA8e/PWgmmVOwtq4b4Q5MDuE/8IM8Ewku0IB8a3RB4zjQPc1PBw+7yDCNQA716V
         leexaDrlIq17Q2lg7rfzP9pntfmTuHM1jZ5XXbb4KmCi2z/tBwwZSGw1SyUE8zo9ojGw
         pYQg==
X-Gm-Message-State: AFuF++lv7+uKoKQlu8Jgx+KQ6jzEp3lhsFmHty6kOViUTYXhqcNw/Upo
	cs/3WD3aXoL3XIB6kFNVgVvHnDVzpaEJYDj965gikkvSo9DTl/47h9RRI1UM2bS4y9xzTkvZ3lL
	JHZ8Y/A==
X-Received: from pfbga7.prod.google.com ([2002:a05:6a00:6207:b0:87f:22a2:2139])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1da4:b0:884:e190:1b94
 with SMTP id d2e1a72fcca58-887fe2e5855mr8812734b3a.34.1791180504209; Sun, 04
 Oct 2026 23:08:24 -0700 (PDT)
Date: Sun, 4 Oct 2026 23:08:23 -0700
In-Reply-To: <fqykkc3j.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com>
 <asAydfQLscU6rXQL@google.com> <h5j3jn86.ritesh.list@gmail.com>
 <asMN_TAX-1_J3jiP@google.com> <fqykkc3j.ritesh.list@gmail.com>
Message-ID: <asM-1-ptu1b_URqR@google.com>
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 05, 2026, Ritesh Harjani wrote:
 > I think I'd even prefer to take on an #ifdef (to scope it to PPC if necessary)
> > over open coding TEST_GEN_PROGS_COMMON.
> 
> Sure, so will add this check for kvm_create_max_vcpus()
> 
> #ifdef __powerpc64__
>        TEST_REQUIRE(!is_pseries_lpar());
> #endif 

Or maybe to avoid too many ifdefs, something like:

  static inline kvm_is_ppc_pseries_lpar(void)
  {
          /*
           * Comment about how this setup has unique limitations and isn't
           * compatible with tests that create many VMs and/or vCPUs.
           */
  #ifdef __powerpc64___
          return !access("/proc/device-tree/rtas/ibm,hypertas-functions", F_OK);
  #else
          return false;
  #endif
  }

Probably redundant naming to some extent, but having "ppc" in there would make it
super obvious it's a PPC-only check.
 
> Actually I was thinking we may as well use the same check for now for
> skipping hardware_disable_test on pseries. Because there also we suffer
> from the same resource limitation. Let me know if that sounds ok to you
> or do you want us to skip kvm_create_max_vcpus() only for now, since it
> is part of TEST_GEN_PROGS_COMMON?
> 
> > LoongArch open coded its full test list
> > for some reason, and in less than a year it has started missing out on new common
> > tests.
> >
> >> (& maybe few others like vm_types_test) from that in v6.
> >
> > What's wrong with VM types test?  That one really should Just Work on all
> > architectures.  It doesn't run on LoongArch, but I assume that's
> > oversight?
> 
> So the test doesn't fail (it gets skipped). However this cap
> "KVM_CAP_VM_TYPES" is only supported on x86 and since I was planning to
> open code all common tests, hence I thought I may as well not add this
> in the first place.

/facepalm

I completely forgot KVM_CAP_VM_TYPES is x86-only.  FWIW, I'd still say use
TEST_GEN_PROGS_COMMON if possible.

> BTW, based on this discussion, I think I will re-arrange the patches in
> the following order and send a v7. (The Makefile.kvm changes will only
> get added after the main patch which adds powerpc support).
> 
> cfabdb049bd7 2026-10-05 [Ritesh Harjani (IBM)] (HEAD -> feat-ppc-kvm-selftests-new-sean-v7) KVM: selftests: Skip hardware_disable_test on pseries
> 2b51fab87b95 2026-09-22 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
> f5d1de1be4e9 2026-10-05 [Ritesh Harjani (IBM)] KVM: selftests: Skip kvm_create_max_vcpus on pseries
> e45ba15cea25 2026-10-03 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Add helper for checking if running nested

Doesn't this one need to come first?  Or is this different than pseries LPAR?

> 178c9bca0e20 2026-09-22 [Nicholas Piggin] KVM: PPC: selftests: add support for powerpc
> 22320662e776 2026-09-11 [Ritesh Harjani (IBM)] KVM: selftests: Fix kvm_create_max_vcpus test for powerpc

This should come before "add support for powerpc", and should have a shortlog
more like "Skip max vCPU IDs test on PPC with <whatever is a good description of the SMT cap>"

> 11b5712b213b 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
> 63c900860b5f 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
> 
> 
> Please let me know if this sounds ok?

Ya, works for me!
