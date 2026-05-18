Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F13932F9
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136774; cv=none; b=htgy+p/NVIJs7tq0UCWbxF6fnTGvf2+RiXZt8Pmc/3fpCIjUXLjLHXSP/eMaIVpjvGOkudmVpLcG5MlWT5qWMKo/Trc441yslXaDh4r20M3gHhvm0doYW+aBZ66DPII1eYf5vvR6DP8R95aOKZZGAPHZr8iyd5IxXlTAyGdnfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136774; c=relaxed/simple;
	bh=1DQgFAuOo/ufJExWgbAin5UszAM9EvUvWON9Wa22hNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BkJjYz4ly1EfvgLmkOQJ1m2GmYeGcTMTRBIGo56WF2+A3o9EDKFfRkLJ6E0F7QcPLJPyCBU4Ssa3d0ZXuAGrWK2s5LCPYDODK7mfKecK0C51laNcUt1Q7P+B0yAhV/sixVX56CuHU4qu/pXJldR79x3FEN2bZrXPYGXWXZycPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvaCfsmP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvaCfsmP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc763c7256so67048195ad.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779136772; x=1779741572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGd6BbSJy5OvNTaNiXv/yILYTZDNFNlp8vbkFDJsHGY=;
        b=rvaCfsmPyRHOCOqn7UErpvCXq4cbJbTI7vdDUu5cMfoce4rwkN0w3+oTUM/NbF8YY1
         ZClhKoXmLgHXv2z2MBZLwC1Q7BOgMz995p6xoXiH1cyAFcfX6V329Qo2tShQ1z3aKb8q
         ALKJgy8R9Yrjp2NhcmEiZMc4E0WGLbGRTYlLHWdZX0y3NHAH0rKuDWzKgcBs1tNfTatv
         VfXdbVSJ4yPxPhzhdD6U/XeGby2imNWbz6MZDpI8PmfMNPYs+h+j0CW24QzNsiNOrEvZ
         G6lPVsj7cIGWblKI4gcuIUt/DcX6jlv4kSYztAD6EveohgVKAw+nRTnRNhs+3EbZlMB7
         mnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779136772; x=1779741572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGd6BbSJy5OvNTaNiXv/yILYTZDNFNlp8vbkFDJsHGY=;
        b=OlyNhKucqyyTlR4EN5+DOINbhdv48lgR2pcSEW6u/33qmvWgs2UoHgsQWuLv2+3nda
         U2cWXEz+YsnNz9VvlUayuv+FaL6CGjGiv3b0At5b/uv+nTncpONl9ysNHK1r6WH2kGCv
         xOOaBciADU43eW6bAirUxsPnGiYZFIdcguuAq0c1izXNjbaOJ+9rQ81tMHcf1bkXEpUO
         E0g3x3P3p9nl+nQZ5FO95QoZ2zElMCgkalY3XZWzvvg6oIFGk3TPIP8cAxOGt/6jeQ91
         DioLuwRvoKHljrRnqEJt6nHLwM3HfBJZpcNFlVIanLqDpAzTQlqlekczC4BWBg9AWtRb
         p+jg==
X-Forwarded-Encrypted: i=1; AFNElJ8t3KcRlalXMAwREv4kxOc8yqDda01+lnSJWkjntE/3FdMp+/bx+bPZzmFZzf6gHPjso+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkTsWamdYR7g0YvLx++W4yEg+hiNa7ozjMnbG5VuCfHbGx2vT
	7cEOZHoHFM8EF0dWU5TU0Udshkr1GS0WmmG82gD6kvhNNKHXkYJr8eXnpGD+CI51u7QsIzsvKsc
	gmVDrOA==
X-Received: from plhi13.prod.google.com ([2002:a17:903:2ecd:b0:2b2:4f3d:3df4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec7:b0:2b4:5d51:ce96
 with SMTP id d9443c01a7336-2bd7e87ed84mr179781255ad.24.1779136771910; Mon, 18
 May 2026 13:39:31 -0700 (PDT)
Date: Mon, 18 May 2026 13:39:31 -0700
In-Reply-To: <CAEvNRgFgobnW+O=t32gu-0YDy0n7ZqvmdCtg+DzLT3uf0+BDeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com>
 <20260518070943.2091287-3-ZongYao.Chen@linux.alibaba.com> <CAEvNRgFgobnW+O=t32gu-0YDy0n7ZqvmdCtg+DzLT3uf0+BDeg@mail.gmail.com>
Message-ID: <agt5A90k9lS9JPWp@google.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Test guest_memfd binding overlap
 without GPA overlap
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: ZongYao.Chen@linux.alibaba.com, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 18, 2026, Ackerley Tng wrote:
> ZongYao.Chen@linux.alibaba.com writes:
> 
> > From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
> >
> > The guest_memfd binding overlap test recreates the deleted slot with GPA
> > ranges that overlap the still-live slot.  KVM rejects those attempts from
> > the generic memslot overlap check before reaching kvm_gmem_bind(), so the
> > test can pass even if guest_memfd binding overlap detection is broken.
> >
> > Recreate the slot at its original, non-overlapping GPA and use guest_memfd
> > offsets that overlap the front and back halves of the other slot's binding.
> > Expand the guest_memfd so the back-half case remains within the file size.
> >
> > Fixes: 2feabb855df8 ("KVM: selftests: Expand set_memory_region_test to validate guest_memfd()")
> 
> Thanks for fixing this!
> 
> > Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
> > ---
> >  .../testing/selftests/kvm/set_memory_region_test.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> > index 9b919a231c93..15607e0bec90 100644
> > --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> > +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> > @@ -510,7 +510,7 @@ static void test_add_overlapping_private_memory_regions(void)
> 
> Shall we rename this to test_bind_overlapping_guest_memfd_offsets to
> make it clearer?

Hmm, not if we make the change additive (see blelow).
 
> Perhaps also update the pr_info() to "Testing binding to overlapping
> guest_memfd offsets\n".
> 
> >
> >  	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
> >
> > -	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 4, 0);
> > +	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 6, 0);
> 
> I think this technically only needs to be MEM_REGION_SIZE * 5 for this
> test to work.
> 
> >
> >  	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
> >  				   MEM_REGION_GPA, MEM_REGION_SIZE * 2, 0, memfd, 0);
> > @@ -526,19 +526,19 @@ static void test_add_overlapping_private_memory_regions(void)
> >  	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
> >  				   MEM_REGION_GPA, 0, NULL, -1, 0);
> 
> When I re-read this I was wondering why we created and removed the first
> memslot. Was it meant as a confidence check that set_memory_region works
> with the given MEM_REGION_GPA? Perhaps we could add a comment/pr_info()
> to check that.

Rather than "fix" the check, why not have both?

> > -	/* Overlap the front half of the other slot. */
> > +	/* Overlap the front half of the other slot's guest_memfd binding. */
> >  	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
> > -					 MEM_REGION_GPA * 2 - MEM_REGION_SIZE,
> > +					 MEM_REGION_GPA,
> >  					 MEM_REGION_SIZE * 2,
> > -					 0, memfd, 0);
> > +					 0, memfd, MEM_REGION_SIZE);
> >  	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
> >  		    "Overlapping guest_memfd() bindings should fail with EEXIST");
> >
> > -	/* And now the back half of the other slot. */
> > +	/* And now the back half of the other slot's guest_memfd binding. */
> >  	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
> > -					 MEM_REGION_GPA * 2 + MEM_REGION_SIZE,
> > +					 MEM_REGION_GPA,
> >  					 MEM_REGION_SIZE * 2,
> > -					 0, memfd, 0);
> > +					 0, memfd, MEM_REGION_SIZE * 3);
> >  	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
> >  		    "Overlapping guest_memfd() bindings should fail with EEXIST");
> >
> 
> Since this test program is meant to test set_memory_region, should we be
> retaining the original test? The original test is wrong in that it
> doesn't test guest_memfd's binding, but it does test that
> set_memory_region returns -EEXIST on overlapping GPAs.
> 
> Perhaps to just test overlapping GPAs we can use anonymous memory
> instead of guest_memfd.

Eh, I see no harm in having both.  E.g. if we do this, then we don't have to
explain why we're not testing the other case :-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 9b919a231c93..283392bcc3a0 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -510,7 +510,7 @@ static void test_add_overlapping_private_memory_regions(void)
 
        vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
 
-       memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 4, 0);
+       memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 5, 0);
 
        vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
                                   MEM_REGION_GPA, MEM_REGION_SIZE * 2, 0, memfd, 0);
@@ -542,6 +542,26 @@ static void test_add_overlapping_private_memory_regions(void)
        TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
                    "Overlapping guest_memfd() bindings should fail with EEXIST");
 
+       /*
+        * Repeat the overlap tests, but so that there is overlap in the
+        * guest_memfd bindings (i.e. in guest_memfd file offsets), but _not_
+        * in the GPA space.  Regardless of where there's overlap, KVM should
+        * return -EEXIST.
+        */
+       r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
+                                        MEM_REGION_GPA,
+                                        MEM_REGION_SIZE * 2,
+                                        0, memfd, MEM_REGION_SIZE);
+       TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
+                   "Overlapping guest_memfd() bindings should fail with EEXIST");
+
+       /* And now the back half of the other slot's guest_memfd binding. */
+       r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
+                                        MEM_REGION_GPA,
+                                        MEM_REGION_SIZE * 2,
+                                        0, memfd, MEM_REGION_SIZE * 3);
+       TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
+                   "Overlapping guest_memfd() bindings should fail with EEXIST");
        close(memfd);
        kvm_vm_free(vm);
 }
