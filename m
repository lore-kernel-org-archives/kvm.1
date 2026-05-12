Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813E379C4B
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573212; cv=pass; b=CyCwV/lvAmBsi9Q+lMjuViTp6MhtImOLlnm205T8i9MPsUDHyTNr1G5WHLkmjJzZlOqYrGNphbGn/8EACJ5WL86RUH5J28cGQbk0cKDvpZbL/MJUE/wYQY8/Q3Z5cwivDj2KSbvtjfDmPO0I2rsdX6GtjF5XyCoPTT4RgNpB7AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573212; c=relaxed/simple;
	bh=CEPI/IQy+YJsaCiP6F0+ttkRfE9DuAoAzIjprwjhmd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXeX8NKh4bKHwaJ7Bizi0gUxcVGDvVGpEWZjWd2elms+CFkHF24SrrIBaemOMEUsb5/NE/mfU7DUTZg4R6sj2GCyTM+TWeHls5pyHCQrt7mCLC5uVQMJaZUCXu19g70oiITM1MzTgtFK2SKrZmtmYHvwTHI+rP+/AjCMUCyHnt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/OiResI; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/OiResI"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d864c23bdso13271cf.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 01:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778573210; cv=none;
        d=google.com; s=arc-20240605;
        b=icyZA7dup1rgGzqKCkyEnS+EqEDAyIawgj0WMPySPz/Uhj51ldwaZBjz/Ax3hhfeVf
         cs5aaxN/wk7rFGq+sZJztxcHw0ST9CidSOY5GU+AtvCHhwsqFGHW+4vz16tQ5l9JHZlq
         AxxlQVy5+ayy3Oa87bYgaL3/YHSIT2pgQdNA3Nugl2ztxVYHIBOsxkPigZAAzj5ag0LS
         Uh6roVIMgM9xPUVhvZUJ3z46UCdKpybh2+fHYCoL1YDQ2x9G9+cESe38qyVVuuRISJhG
         WEBJMxxTMyzQ4p6JjsEzfZgbzhP+1vCSZj1Ik3V8QVcwlhYXV1OHaRZ9MS6OOjwhl7wm
         R0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UcX628tp7zp2ETdFQrXxdl3RL6TmG7KIBWzuiytzzfA=;
        fh=cCdTFcvI8XBv9HfFSl8ApUimSk0XDF9OLF2/uXnB+38=;
        b=HjBkMHcZ8/XiXFadzXil/suGzP9ywfMqlCF95Ocne3BwgmQ2koavxqPxpTRiFv3twK
         SnlfNKVIlFVdUzznNURFJNU8mmy5LopqUbWaAbxfGmK7vuc4DfXwRHv+mseF4JS7W5U5
         H6nu+K1Viqh10VDTH6UAIn8uwvpozV5jUnp1hM4YLZHfRAl7lSS9FN8vSCxuDVREIsot
         yTCFw5MWn/p8Ab8rVqgkvtkjZnejfQQIcAoEk+mCs5LT6+MTDOGdu/cm9w2qAbphn/BW
         2fZAsYcV/QGE0o8uHxFUa739N/GXhgPWMJfmzWJlv2yBD0ppSozsDElJdJHKVaSwU0dt
         9c4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778573210; x=1779178010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UcX628tp7zp2ETdFQrXxdl3RL6TmG7KIBWzuiytzzfA=;
        b=q/OiResIaDUq5Dt2h59sPjwruHV3s24oa4TChS6rP4f9Oqz1k+/ATPP9i+cf4Hxmoa
         uMFqNpWxRv3HAQNuY0hYBcLrtdid6U9Z/gpeJvzkCxY3Jf2/l49fpodUk4PC6ire32Dp
         DBhoKn5plMFGCCk7adii53eKN9T/6RXJmvAGca7EtKotNUAmvpVVB8q7kWR6ghis5uVd
         mJOlbcqTMk8lK/TM2OmDQA/EY8htueCJyVep2YjZCFqYWprVmrRWeGjmmu3L2vQ/CVig
         NKqgKgMdM5lk4ix5DubPHe0v1NF8+mgHJLDmAKZ6XbAZwqIbIZs3FyEavKGfKFYCULD7
         a9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573210; x=1779178010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcX628tp7zp2ETdFQrXxdl3RL6TmG7KIBWzuiytzzfA=;
        b=i0z92XIdNIAf9en6gExgn+BC+P1eg4M307/f9vvcUszt3u3TvsbcY4oDVyvZXPDrrs
         47m9C+yo2lxno5b6/mxOBX6qK+akfhLsqmmI0eM5ZIfDSnzJZIiwcK2RrXOBmF2Gk7WZ
         /T6mQj3RpFUtzkFy9d5Nn+N3yh+2Wl2pxrQ9Tonh0mG0oI95JFsiSL6nQZfwjy29ZJ/9
         AzLWtq+Ud+EJu5GlAexG4B3ooDAvHeh8ewqzepdsPsuOHYMqnjMVXL+k6qQ8APQ1H4rr
         D1HJG+fVbvaUJKEAhaQA7C7mK11Av11Yfq2h9hzTYM67RXelC9OnVmpFoVCZ4V3tgBvA
         hekQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QfzqO9Nxufn/pD4WzKlb9CCGm0G9Ssz8qzb/efw8RcoKc8NnaIIGQ+xI0CpggavRCXqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwmwvqkkBN+rAlv9GCMkJ4vCXJpysT17Ith4sJALlKoa55I4I
	zZujnRdfpdqw4jmDpwaR7M46e+kCvJdRvSW0RRt055zBkIJ/zwvTtWff/dtcWSvULbsnlCa/mlb
	vZHog/zO+iFyhPHxh391Nx9HMvCWB+0JHn9mUrzqh
X-Gm-Gg: Acq92OEPCqMoasesVGaewxy5LrCgCJYJOwTFoeXChtM7xrbk8j670aRYMiNbLyG9DWv
	uz7ogeVoQUxY9Flq6D28a/z69wc2i+Qam9AaspWX8A5Jljh6wZKvuUMCaXYBzIZqQHQ+1zP2IzN
	2+Ojbcf5cWRbq+upsenHsAKe9BECX2oLRSuXAtVOqaPr1V3fazzxck+gmfmPQwzoF7b5yODJPEL
	hxF62uJQNPc1by+Fbspr+4hpUTPyLLqW2EQkC3eL5s4+xcehJIqNmKBPKk55iQzDPMiv3yu3a5j
	AXlA/YCUu5RoD+mYpnacBTb7DnYdf4bBrAE/sDeTwe593/xi
X-Received: by 2002:a05:622a:4c85:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-514d44cc15amr7418571cf.2.1778573209581; Tue, 12 May 2026
 01:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113759.610924-1-tabba@google.com> <20260511113759.610924-3-tabba@google.com>
 <agHugdIrptaXZW-2@google.com> <CA+EHjTw1z7ROF7u0fKqxDGao7S1kELxNWtyWhLoPQx5uwVfuWQ@mail.gmail.com>
 <agI7M7rZ_NZJyjhj@google.com>
In-Reply-To: <agI7M7rZ_NZJyjhj@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 12 May 2026 09:06:12 +0100
X-Gm-Features: AVHnY4KIFSvZuGyoufiD2HkBfoHCrSG6pWS-dmqt_3tBMtmR-2r50gULg7YpqJU
Message-ID: <CA+EHjTxDvkDGyd-uyAqW7ErVxcKnUBpCYAgmnYfCdh+CCSq=3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Fix FD double-close in kvm_vm_release()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 21:25, Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, May 11, 2026, Fuad Tabba wrote:
> > On Mon, 11 May 2026 at 15:58, Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Mon, May 11, 2026, Fuad Tabba wrote:
> > > > kvm_vm_release() closes vmp->fd and vmp->kvm_fd unconditionally, and
> > > > kvm_vm_free() calls kvm_vm_release() at teardown.  A test that calls
> > > > kvm_vm_release() and then kvm_vm_free() without a
> > > > vm_recreate_with_one_vcpu() in between double-closes both FDs.
> > >
> > > That's a test bug, no?
> >
> > Fair point.  Let me describe the actual use case and then I'd like
> > your guidance on which way to fix it.
> >
> > The pKVM selftests I'm preparing need to verify that protected guest
> > memory is zeroed when the VM is destroyed before the host regains
> > visibility of those pages.  The test pattern is:
> >
> >   vm_userspace_mem_region_add(vm, ..., GPA_BASE, 1, GPA_PAGES, 0);
> >   /* run protected guest, which writes/shares/unshares its memory */
> >   ...
> >   TEST_ASSERT(get_proc_locked_vm_size() > GPA_SIZE);   /* still pinned */
> >
> >   kvm_vm_release(vm);                                  /* trigger destroy */
> >
> >   /* host_mem is still mmap'd in the test process; pKVM should have
> >    * zeroed it before unpinning */
> >   TEST_ASSERT(is_zero(region->host_mem, GPA_PAGES * PAGE_SIZE));
> >
> >   kvm_vm_free(vm);                                     /* tidy up */
> >   TEST_ASSERT(get_proc_locked_vm_size() == 0);
> >
> > I used kvm_vm_release() because it's the only public API that closes
> > vm->fd to trigger kernel-side destruction.  But the existing callers
> > follow it with vm_recreate_with_one_vcpu(), so the "release + later
> > kvm_vm_free()" path isn't exercised today.
> >
> > I see three ways to make this clean:
> >   a) This patch: kvm_vm_release() becomes idempotent for its three
> >      FDs, matching the kvm_stats_release() idiom it already invokes.
> >   b) Leave kvm_vm_release() as-is and add a dedicated helper, e.g.
> >      kvm_vm_destroy_kernel(), that closes vm->fd to trigger kernel
> >      destruction while leaving the kvm_vm struct intact for
> >      post-destruction inspection.  kvm_vm_free() learns to handle the
> >      half-released state.
> >   c) Something else entirely, e.g., the test should manage vm->fd
> >      directly and not rely on library helpers for this pattern.
>
>     d) Fully kill the VM; validate the semantics with an explict mmap().
>
> The entire point of the test you are writing is to verfiy that a guest_memfd VMA
> doesn't somehow cause KVM to leak state.  So, make that obvious instead of abusing
> APIs that kinda sorta do what you want, but not really.
>
>         mem = kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
>                        region->guest_memfd);
>
>         ...
>
>         kvm_vm_free(vm);
>
>         TEST_ASSERT(is_zero(mem, ...));

The test isn't about guest_memfd.  The pKVM support that just landed
via Will's series [1] is built on anonymous host memory, and that's
the only backing this selftest exercises (VM_MEM_SRC_ANONYMOUS and
VM_MEM_SRC_ANONYMOUS_THP).  The property under test is the one
documented by the same series in Documentation/virt/kvm/arm/pkvm.rst:

  Status: Isolation of anonymous memory and metadata pages.
  ...
  Reclaimed memory is zeroed by the hypervisor ...

The test mirrors that contract: assert VmLck > donated size before
teardown (pages pinned), trigger kernel-side destruction, assert the
host VMA reads as zero (hypervisor scrubbed on reclaim), then assert
VmLck == 0 (pages unpinned).

kvm_mmap() + kvm_vm_free() + is_zero() doesn't translate here.  The only
host view of the donated pages is the memslot mmap, and kvm_vm_free()
munmaps it on the way out, so inspection has to happen between
kernel-side destruction and userspace free.  kvm_vm_release() is the
only library primitive that does that today.

What do you suggest?

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260105154939.11041-1-will@kernel.org/
