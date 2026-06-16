Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989B39282C
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620594; cv=none; b=EpjOwRFDjWoKv9VVGDB1ypAWEp0XVufvgm4/NoqwA+ba/BKeKdoB74k0aLMKnKcbpQdpCQACm/avjFBEFpxHYfq87DsIxvd+kYkG/SFGmf+Gcw0AS+iX/tRP4uknNndqH2KJNFjBerYTvYDIDFhP2WmHUj9C83GqWLYKuFcSdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620594; c=relaxed/simple;
	bh=AbpNe24xlhwm/PgmZ5FVGnfkuQ7wHlOr/56VCgER2Wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eCPaAhAAIKL9DDbpAy7+LNpDKDhfcURQyxZecH/Bn6bJSTtl1DO5We4KEQ6nebxte1A7t7ir+C+bS2iFFa+6nKdGyIj1opl2GNsA0eTNZK5SdPGkIjKgYLi4dKXZPxe4rKfZOKUGlsJWfrXANCVVF9Ej164J6GxeQdEFb3EICtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAHr/Tfd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAHr/Tfd"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6a20348ceso5331525ad.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781620593; x=1782225393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gyflg7buPy8xj/laUw+X3H9z80FdaQb7zGq2p9sCm08=;
        b=DAHr/TfdSROSIq0FEJ9RBEdIil+2lmlExRzPHAssaIIZTUzmf2QLoC4+3FdqCEKFAc
         NLtgxT6+QgDj+gg+owC2G7K+KfRaiNKynGA2Giu1B2RRiX8dbsexuomd1JWpaPeet17S
         0pPuoXePMHgbVhM6ehzyZUTk3uXzIhf//3HAvCuIdF4hu0XS+63w7tkhKCfylKlNKvCK
         57x+uoPqm3a+xQZ4VsDv5nTJXOIxJ/7JeFiAGLH7RoDX6KWacUEdIo3K0X1tOU6OvF3+
         q1MUtTmbjbqUekG9Aw01V4zraM/0+n00D434Q55n9Apo7QpJVRyvEUn8qz0r+Ugc9zy2
         TiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620593; x=1782225393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyflg7buPy8xj/laUw+X3H9z80FdaQb7zGq2p9sCm08=;
        b=VntIn+YVJvyoykac0c5E1G40Fzw7iXd9NO4T3g1mdNugtsKw+FG6bzdfYK3dS5+QTR
         bkUNolaIae0MkjSHsMYMsYZN3h6ES3m005aQHzt4meK7rjNGMDcTFsrCPNBVnjmsi/7y
         B80HxSWHZELAJaiITV3FuNgEfafIouN0azyxn4JNhRC8ApvlkI5ElWTEqdWgO0/uk5gP
         NuRoH6R38PGacpchl8Nc2LQ0YCg9p4ewhHp9wuhDsnlgshMIRYqEleAkoPWowvqPzk1F
         E/41uoi2Wxp6Y37m+IZYdfP3keOQ42iuix2fCF6W5N7kb/TEoWPtHJ/pKE+23HPblQ9M
         i3eA==
X-Forwarded-Encrypted: i=1; AFNElJ8yXKXh7aidZ9yDX21+9n9x26l6xa/haDENWXDY9x57Le12SncgI+T0lPxC0J0TlopqCCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLCy7WYn9aflnpclzUXGiIctH/2TSG/NKF4jfLEhhq8C129vB
	MFYMvRdlvaJaKJDjIyxJi+l46aluNTmp4p345r4vrflXyQlWtywDOgE+3EF8p4imtd8IMsLmrc/
	GrbJ7Mg==
X-Received: from plsk16.prod.google.com ([2002:a17:902:ba90:b0:2c6:779e:5007])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70b:b0:2be:e3bc:e8e4
 with SMTP id d9443c01a7336-2c69a186b29mr41194995ad.18.1781620592472; Tue, 16
 Jun 2026 07:36:32 -0700 (PDT)
Date: Tue, 16 Jun 2026 07:36:31 -0700
In-Reply-To: <CAEvNRgHjno=XDnMpTvZcNCR6D5RAi1rbynrL4CnnEa7Y-M3VLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-19-6983ae4c3a4d@google.com>
 <CAEvNRgHEq-hHcTivUw8TYBeMu-RpS=Ho4DXaNXKQKLPL_biTgg@mail.gmail.com>
 <aiMOWkiVBqoQDAPd@google.com> <CAEvNRgF09SfDm=OgbrS8-wpfxbNecQkqAQwf1ELq1jWu7NjbUA@mail.gmail.com>
 <aiM2Nm9Eh68mIVX3@google.com> <CAEvNRgHjno=XDnMpTvZcNCR6D5RAi1rbynrL4CnnEa7Y-M3VLg@mail.gmail.com>
Message-ID: <ajFfb9u6dU47Nj3v@google.com>
Subject: Re: [PATCH v13 19/22] KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 15, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Fri, Jun 05, 2026, Ackerley Tng wrote:
> >> Sean Christopherson <seanjc@google.com> writes:
> >> Many tests use vm_userspace_mem_region_add(), CoCo tests that require
> >> finalizing shouldn't be disallowed that option.
> >
> > What does that have to do with finalizing the VM?
> 
> I could add more memslots after finalizing the VM, but then I'd have to
> make the guest accept more memory. Hence, I'd rather set up all the
> memslots and then finalize the VM.

Why?  It's not like the performance of this code matters terribly.

Regardless, nothing *requires* a test to go down that route.  As I said before,
my goal with the selftests infrastructure is to effectively optimize the entire
experience, i.e. to provide default behavior that works well for the majority of
tests.  Attempting to provide default behavior that perfectly fits *every* test
is simply impossible.

> sev_smoke_test currently has a separate vm_sev_launch(), which is the
> equivalent of tdx_init_mem_region(), and that's called in the tests
> themselves.
> 
> sev_smoke_test also uses vcpu_args_set() after creating the VM with
> vm_create_shape_with_one_vcpu(). Would that work if vm_sev_launch() got
> moved into kvm_arch_vm_finalize_vcpus()?

No, because vCPU state would be encrypted at that point.  Moving vm_sev_launch()
would also break test_sev_dbg(), which sets a global buffer to all 0xaa prior to
encrypting that data.

> >> >> It's also possible to have some kvm_vm_finalize() call that can be
> >> >> explicitly and manually invoked from selftests just for CoCo selftests.
> >> >
> >> > Why bother?  It's obviously possible to all kvm_arch_vm_finalize_vcpus() directly.
> >>
> >> Works for me to call directly. Do you mean kvm_arch_vm_finalize_vcpus()
> >> is the right function where the TD is finalized?
> >>
> >> For tests that need to do more setup after creating a vm, is the only
> >> way out to call __vm_create() then vm_vcpu_add() to avoid premature
> >> finalization in __vm_create_with_vcpus() when
> >> kvm_arch_vm_finalize_vcpus() is called?
> >
> > Depends on what you're doing.  Sometimes, the answer will be yes.  That's why
> > there are "low level" APIs, so that some tests can do fancy things, while most
> > tests can leave the details to the infrastructure.
> >
> > If there's a recurring problem, or we anticipate one, then we can and should
> > figure out how to minimize the pain so that tests don't have to deal with the
> > same boilerplate issues over and over.  Hence the __shared idea.
> 
> I still think kvm_arch_vm_finalize_vcpus() is an odd place to be
> finalizing the VM.

That's literally why the function exists though.  The one and only existing
implementation (on arm64) uses it to initialize the vGIC.

  void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
  {
	if (vm->arch.has_gic)
		__vgic_v3_init(vm->arch.gic_fd);
  }

That's *very* similar to the proposed TDX usage, where some per-VM asset(s) can
be initialized/frozen only after all vCPUs have been added.  In other words, the
name is describing where in the VM creation/setup flow the hook is called, and
perhaps more importantly, the impact of the call: vCPUs are finalized (obviously
with a different definition of "finalized" based on the VM properties).

> I would prefer to not have to explicitly call some function like
> kvm_arch_vm_finalize() (no vcpu in the name), but a common arch function
> calling vm_sev_launch() and tdx_vm_finalize() is what I can think of
> for test setup flexibility, without too much magic.

We can't have our cake and eat it too.  Either we launch/finalize SEV/TDX VMs as
part of the common VM creation flows (as proposed for TDX), or we force tests to
manually launch/finalize the VM after additional setup.  The only way to have it
both ways is to utilize crazy macro shenanigans to execute arbitrary code between
creating the VM and launching/finalizing the VM, and even I would balk at that.

I honestly don't see any reason to try to figure out which of the two approaches
is optimal at this time.  Whatever decision we make isn't set in stone, and in
fact should be relative easy to change.  And without being able to see all the
TDX/SEV tests that are waiting in the wings, it's more or less impossible to make
an informed decision.

I definitely want to have SEV and TDX use the same core approach in the end, but
I don't think we should force the issue right now, because the cost of reworking
the SEV and/or TDX infrastructure when there are only a bare handful of tests is
so low.  It will cost more to try to predict the future of a 50/50 outcome than
it will to make a completely wild guess between the two options and rework things
if we guess wrong.

> For now, I can't think of many uses of __shared. ucall shared memory is
> allocated dynamically, and we can also make it shared cleanly within
> ucall code.

Uh, every selftest that uses global variables to communicate between guest and
host?

> The global variables (sync_global_to_guest()) will appear in the guest
> as long as sync_global_to_guest() is called before
> kvm_arch_vm_finalize(), which I think makes sense to people writing
> tests for CoCo.

Yes, but that's completely orthogonal to all of this.

> So 2 questions to push this along:
> 
> 1. What do you think of a kvm_arch_vm_finalize() that calls
>    vm_sev_launch() and tdx_vm_finalize()? My key issue is that
>    kvm_arch_vm_finalize_*vcpus*() seems to be for finalizing vCPUs
>    rather than the whole VM.

Key word "seems".  I'm pretty sure Oliver picked kvm_arch_vm_finalize_vcpus() as
the name in commit 8911c7dbc607 ("KVM: arm64: selftests: Create a VGICv3 for
'default' VMs") for the same reasons I think it's a good fit for coco VMs: like
finalizing TDX VMs, initializing the vGIC effectively finalizes vCPUs.

We could rename it to kvm_arch_vm_finalize(), but that won't change the fact that
we'll need to decide between automagic vs. manual finalization, and it definitely
should be a separate discussion.

> 3. Would you like __shared implemented together with this series, as a
>    prerequisite, or later?

Only if __shared is a hard requirement for base TDX support, which I assume is
not the case.
