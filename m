Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B12486653
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781375; cv=none; b=RcPW0mXJJfGW1B17RLz7hlNxs5v623m2xyBTy6fEVGU8g1rKVj0HCsjRn59IGjfGp4C9UDkzTEHO4HvqrUMMTW6EKKuiq7OpnclfqDuq8u1Ao4u3uerodOLDYihL5QtQSEDPmCwPz1HOXgpBPZbyhxrJGp6cq0uWybB2Y+ufj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781375; c=relaxed/simple;
	bh=sU+Q4g/pVzWeY7//8CsskTgcUXrCPa9PzzQF1WlOdjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qQcHLs9zxw2NQ7il0M09g8A6QdOa0wgohn76vdxa7aLJqeL6GAHu28socoLT9SLL43xl87s8fi9sH+5RMBmsKP8mtsUgUmZezAiCUBAqoYAS2IpwHk1mhzRazBaO+BiGEgB35wlBHCyD8I3GufDYiujwYBFuX74ct3uv8qNsns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oulf3e1r; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oulf3e1r"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d63c16fc5bso31395565ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787781373; x=1788386173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=is+fk7S2hTSHxPwtMEFfacfrRyTeQfS5m4vtXdJKY74=;
        b=oulf3e1raR6JMtujl6i75QFUdiWDBf1lLePrG1Q4n1sxRfqkuwEKFBbLD3I0xjryTj
         3ZpK2o4QayObdn5c1TmMrio1zw+cBlxpvJsCTAi7eV3f4ScuHEOUNEnykpprqu+FFgzT
         OjSzD6FXONbYptS71YDgzh4LwSlbaZmhHrPdj8te6aMxoj3MDj793sJ4fvT/QRzhnKDH
         6MTy4eg5AG6S5aquDXoTOX1rLMlK0O4Zo5xVrJ9I5dKbq0zi0gw6CjhWixwF+2Tjp9It
         a6hRcOFUqt3++JSop0ic7Vvb4SnGSessEDH/+Ya8q5UvzAIfskjkExWIBBgXtNQMxDFY
         jIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781373; x=1788386173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=is+fk7S2hTSHxPwtMEFfacfrRyTeQfS5m4vtXdJKY74=;
        b=cUf9DHAUqhpJhngPyN8aDP6bD/7luzfd40FJU5USzOHGmcriwO/MOhmk/nlBsi0oRc
         pXzbqyckWjv6LYczexJbOlp7mCCxXnyV9GPJuCgp02OL+M+fv7gjIdcSWuf6ltDjrbrh
         1RxGWnL8n6P5wCcX8h2NZi49ni1lznjnu5GfcyIFUfQlBd67QtXx4DDy3dk2+Gdf4ZeY
         cNqrxpXbnivxZzRdxOXQp7wsTxIvW/OmnMhE9r17b2tauZB42+NBpq3eyQcwZGnGsgZs
         7Oz4i2zkWKjubcbORtzCwDAPb5uoRoyX+gUW2W11Sxf/85t+wRgAZ14Sa+/j3sbSOxA9
         hebA==
X-Gm-Message-State: AFuF++kaYFYXak31s1xN2Ra2YlWTHHE2QpoCBICnpqlBUAm3m3FQDskG
	9CnVHbQ7pyZheo5kYwutNTqh5K0HMYXvJJF6ht3cGQaNEfKzeDGdX8aD0losN2WQwSbSZ08GKEV
	0F/Fj3g==
X-Received: from plbkr5.prod.google.com ([2002:a17:903:805:b0:2cc:cfa0:3117])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c7:b0:2ca:6d87:cda0
 with SMTP id d9443c01a7336-2d7079fa6d5mr151579565ad.6.1787781372474; Wed, 26
 Aug 2026 14:56:12 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:56:11 -0700
In-Reply-To: <20260826214101.CE1681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-3-seanjc@google.com>
 <20260826214101.CE1681F000E9@smtp.kernel.org>
Message-ID: <ao9g-y3F_6Sswfl8@google.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Bug the VM if KVM attempts to walk more
 levels than the MMU has
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 26, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The new bounds check falsely triggers KVM_BUG_ON for valid PAE page walks on 32-bit KVM hosts.
> --
> 
> commit c8c785606f8b5ac435db8c42d576eaf8f88c2fcd
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
> 
> This commit extends the paging levels check to ensure KVM doesn't attempt to
> walk more levels than the MMU template provides, preventing out-of-bounds
> array accesses.
> 
> > diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> > index 27427e7f22fa0..46a0f7796e55a 100644
> > --- a/arch/x86/kvm/mmu/paging_tmpl.h
> > +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> > @@ -368,13 +368,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
> >  	pte_access = ~0;
> >  
> >  	/*
> > -	 * Queue a page fault for injection if this assertion fails, as callers
> > -	 * assume that walker.fault contains sane info on a walk failure.  I.e.
> > -	 * avoid making the situation worse by inducing even worse badness
> > -	 * between when the assertion fails and when KVM kicks the vCPU out to
> > -	 * userspace (because the VM is bugged).
> > +	 * Queue a page fault for injection if any of the below assertions fail,
> > +	 * as callers assume that walker.fault contains sane info on a walk
> > +	 * failure.  I.e. avoid making the situation worse by inducing even
> > +	 * worse badness between when the assertion fails and when KVM kicks
> > +	 * the vCPU out to userspace (because the VM is bugged).
> >  	 */
> > -	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm))
> > +	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm) ||
> > +	    KVM_BUG_ON(w->cpu_role.base.level > PT_MAX_FULL_LEVELS, vcpu->kvm))
> 
> [Severity: High]
> Does this new check falsely trigger KVM_BUG_ON for valid PAE page walks on
> 32-bit KVM hosts?

Argh!  I missed/forgot that KVM only configures paging64 for 2 levels.

#if PTTYPE == 64
	#define pt_element_t u64
	#define guest_walker guest_walker64
	#define FNAME(name) paging##64_##name
	#define PT_LEVEL_BITS 9
	#define PT_GUEST_DIRTY_SHIFT PT_DIRTY_SHIFT
	#define PT_GUEST_ACCESSED_SHIFT PT_ACCESSED_SHIFT
	#define PT_HAVE_ACCESSED_DIRTY(mmu) true
	#ifdef CONFIG_X86_64
	#define PT_MAX_FULL_LEVELS PT64_ROOT_MAX_LEVEL
	#else
	#define PT_MAX_FULL_LEVELS 2   <=========================
	#endif

I tested a 32-bit PAE guest, but only on a 64-bit host.  I didn't test a 32-bit
PAE guest on a 32-bit host.  Lame.

  ------------[ cut here ]------------
  WARNING: arch/x86/kvm/mmu/paging_tmpl.h:378 at paging64_walk_addr_generic+0x422/0x950 [kvm], CPU#3: CPU 0/KVM/2511
  Modules linked in: vhost_net vhost vhost_iotlb tap kvm_intel kvm irqbypass
  CPU: 3 UID: 1000 PID: 2511 Comm: CPU 0/KVM Not tainted 7.2.0-rc7-cc46e34b6df0-x86_nested_npt_lma_pae-pae #7 PREEMPT 
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  EIP: paging64_walk_addr_generic+0x422/0x950 [kvm]
  Call Trace:
   paging64_page_fault+0x51/0x870 [kvm]
   kvm_mmu_do_page_fault+0xfc/0x220 [kvm]
   kvm_mmu_page_fault+0xa2/0x770 [kvm]
   kvm_handle_page_fault+0x6c/0x130 [kvm]
   handle_exception_nmi+0x50f/0x610 [kvm_intel]
   vmx_handle_exit+0x18f/0x5b0 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc71/0x1c00 [kvm]
   kvm_vcpu_ioctl+0x2c5/0x960 [kvm]
   __ia32_sys_ioctl+0xff/0x960
   ia32_sys_call+0xad5/0xc30
   __do_fast_syscall_32+0x5b/0x500
   do_fast_syscall_32+0x2b/0x60
   do_SYSENTER_32+0x17/0x20
   entry_SYSENTER_32+0x98/0xf9
  ---[ end trace 0000000000000000 ]---
