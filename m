Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA923939B0
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244530; cv=none; b=RlMzvsatGBN5wywolTTZA0hEEfzHT23WDLjoknjIy715GWp2QRNJWcNiCrxjmvnrQYDtTqG+yrbea2RfywODIZlaKgItXg9jNTw+bM9hnaEkJLeSqkz7BxDRntp71t59jIADwMIsj4De685ajf7BkrVGR10lLE2DLhrRf5mGUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244530; c=relaxed/simple;
	bh=63sbJHarhRjl2iOQAD0mHNtnHScOAjCdBhb1R1qPxoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U9XWmrW+lih0QvQUbyaj4eFRHrSRC4i9BRj+jaLukOZGjHjXlxeaO2ARxTQ/AsWTCKAAT1SiE96n6+MtJbPF1rQepILqvW1kI+JejPH2aqaA2MteuDAGzJ9YiJgSGAEfCmuEWpmGbod7B9hxR2CYzJC0gi/56av497lQtMhypqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzTcvnbi; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzTcvnbi"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88e0f04e51so108781a12.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782244528; x=1782849328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIpRVKbnPB3e1icAr2g1HCqVBQNdkLJ4J5hLjJ9OhkI=;
        b=vzTcvnbiYr4iY7b/e0mGNzuiVzoekU5uJLh3zeMJTqJ+Q6+67oJ7tC7rQnlPCHhQry
         SJsmpguPA4mg3EmjFg+bCx7vMULQShFpNaiAj0rRiJDVRjJLjfPsuhZ0xNdZXUh/3biu
         EP0xclIbTIvmBSSN7uSyeQ+7NbitnwIJn6rGmqPX/FB3ERz6wYgnAzffGBeOSs8/J9bo
         WfUgcnu2zlfVvQbTJsuhMoQwOAWnQ+YAwpiWmyUSBvU/lS8p+QXEEIM9kreF1cFp0QlA
         5reSbsb2dKqV7B7upsXjqdAlLPokCjLr6tpNmdfrPdM3GxIWpeG59qCZTueyg5QcXaxd
         aoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782244528; x=1782849328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIpRVKbnPB3e1icAr2g1HCqVBQNdkLJ4J5hLjJ9OhkI=;
        b=G5FF11AqbfSzgGNFgbYcxTTKEvHywJEqNT9G5dAHYK8hu1n9RoPgfVtDjY4rzR/Pbm
         qT/olvYobVRIil6v9EAkgZjSf7SOEv8AgsJP9yh5mIkJknPc+v8HaVHEln88HbGpfv7a
         u3saks99n/8aP4uGfJofnGD5oil9cnaEOmNgjzlLEpJG686SC6o29PagkjCmew4DDdfK
         IgcvH9z19Nvf3PaDLLAJ8OJ+DjWLbEH1A/wwrJo8Rp6nORTThLP55mO4g9pYFalOAdLn
         O0VgnxKgeLNpWq4vuMgQgYMkHNJc/KHiqJgcM+jjGwClmPunV6LVjfqpv/nCbkaPKvJ2
         +zPw==
X-Forwarded-Encrypted: i=1; AFNElJ/Wi40cH+wagehpJbk8Q0QAPfXAGcwO1FP682oRF0D7DVa07h0jVJKWsrFEy3ujxvtbEjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYbEX9B8/o9HPwZ6gsfoG1f675Dgv6Gr/rQ9z8dif8HlciT8z
	XI0ygXYX/aigJTFYETkLxWvSHFEsVq9y/N1nxl1afmaLX+n2CCtzZxCTJvwY3kNw0RgWzzEHJCR
	Fmu1Jgw==
X-Received: from pgct16.prod.google.com ([2002:a05:6a02:5290:b0:c8e:650d:c415])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e292:b0:3b4:6026:6c5d
 with SMTP id adf61e73a8af0-3bd2d047b32mr236285637.5.1782244528090; Tue, 23
 Jun 2026 12:55:28 -0700 (PDT)
Date: Tue, 23 Jun 2026 19:55:27 +0000
In-Reply-To: <s7jfbw3tnfgmp6blfqlfoi7yhq6f5n6xl62zzty5up45cqtsty@ljpjlvqw2gyy>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com> <20260501203537.2120074-3-seanjc@google.com>
 <ajNQ_Ix5e0p6FuFT@google.com> <tx3hcnrhfbcz2p7e7umc5o2zrw74pluzuzgtlqt4dz5cc5nhxx@6tzzorc25nqw>
 <s7jfbw3tnfgmp6blfqlfoi7yhq6f5n6xl62zzty5up45cqtsty@ljpjlvqw2gyy>
Message-ID: <ajrkryMxHZtsMvga@google.com>
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV
 {en,de}crypt debug ioctls
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

+lists

On Tue, Jun 23, 2026, Michael Roth wrote:
> On Thu, Jun 18, 2026 at 10:18:03AM -0500, Michael Roth wrote:
> > On Wed, Jun 17, 2026 at 06:59:24PM -0700, Sean Christopherson wrote:
> > > off-list in case this is double-ungood.
> > > 
> > > I ran this on an SNP host today (I think this is the first time I've run the full
> > > test on an SNP host), and it explodes with RMP violation #PFs in weird ways.  I
> > > don't _think_ it's a KVM bug?  Because I get the RMP violations even without ever
> > > running an SNP guest.  I'm using kvm/next, at commit ef057cbf825e ("KVM: x86/mmu:
> > > Ensure hugepage is in by slot before checking max mapping level")
> > > 
> > > It might be related to edge cases around pages, or maybe large sizes, as the test
> > > passes if I comment out the testcases that focus on the larger sizes.  I haven't
> > > narrowed it down further than this (reboots aren't exactly fast).
> > > 
> > > What's especially odd is that on most of the crashes, there's no apparent reason
> > > for the RMP violation, as the RMP says the page is unassigned.  I did get one
> > > crash (#2 below) where the RMP entry was non-zero.  That one was after booting
> > > an SNP VM, but it was quite some time after shutting down that VM.  The RMP dump
> > > is equally confusing to me, because AFAICT the RMP entry is corrupted.
> > > 
> > > Mike/Tom, can you try and repro and debug?  I don't have the bandwidth to dig
> > > deep on this, and even if I did, I suspect it's beyond my abilities to debug.
> > 
> > Hi Sean,
> > 
> > I was able to reproduce this after running the test in a loop for a few
> > minutes after a clean boot (trace below).
> > 
> > Not making much sense to be ATM either, but might be related to RMP table
> > memory itself. Will keep investigating.
> 
> It looks like this was a recent regression caused by changes to how the
> temp buffers are allocated. I tested the below revert patch ~14 hours
> and the issue seems to be fixed (I generally was reproducing it within
> an couple hours or so max so it seems good).

Thanks for root causing!
 
> Planning to submit upstream today if there's no objections/concerns.

I object :-)

> From: Michael Roth <michael.roth@amd.com>
> Date: Mon, 22 Jun 2026 22:47:03 -0500
> Subject: [PATCH] Revert "KVM: SEV: Allocate only as many bytes as needed for
>  temp crypt buffers"
> 
> When SNP is enabled, the data passed to firmware must be contained
> within pages that have been transferred to firmware ownership via the
> corresponding RMP table updates. 

IIUC, and I'm pretty sure I do at this point, this is wrong, or at least *very*
misleading.  Nothing in KVM performs RMP table updates, and so saying "the data
passed to firmware must be contained within pages that have been transferred to
firmware ownership" is completely inaccurate.

Piecing together the changelog and diff, and my own observations, my understanding
is that **firmware** modifies the RMP to *temporarily* take ownership of the page
while performing the {DE,EN}CRYPT operation.  So there's no requirement that the
pages be in any specific state, the only "requirement" is that software needs to
either prevent concurrent accesses or be prepared to handle spurious RMP #PFs due
to the temporarily RMP modifications.

SNP_DBG_DECRYPT does require software to convert the destination to be a firmware
page: "The firmware also checks that the destination page is a Firmware page."
But this is about SEV_DBG_{DE,EN}CRYPT, not SNP_DBG_ENCRYPT.

> This is not compatible with uses kmalloc() allocations since kernel accesses

As is the statement about kmalloc().  kmalloc() of a PAGE_SIZE is a-ok, because
the kernel will always hand out a full page.

> to other allocations within that page will trigger an RMP fault and crash the

And it's specificaly about other *accesses*, not simply other allocations.

> host. Fix this by moving back to page-based allocations.o

Always forcing full page allocations is overkill for SEV and SEV-ES, and robs us
of the opportunity to document that SNP+ is special, which is especially important
because AFAICT, none of the specs are so kind as to document this "minor" behavior.

Rather than fully revert, just force PAGE_SIZE allocations if the host supports SNP.
I haven't run anywhere near 14 hours, but I was also getting failures on every
single run of the test, and I ran the test 100 times without problem.

However, this only addresses the case where KVM is using temporary buffers.  For
small, nicely aligned operations, a misbehaving userspace could induce a crash by
coercing the kernel into accessing the to-be-{de,en}crypted page via a kernel
mapping while the crypo op is in-progess.  I don't see a less awful option than
forcing KVM to use the "slow" path, e.g. if the problem is limited to the dest
for a decrypt operation:

diff --git arch/x86/kvm/svm/sev.c arch/x86/kvm/svm/sev.c
index 87025d0d2f91..7e3334c90c57 100644
--- arch/x86/kvm/svm/sev.c
+++ arch/x86/kvm/svm/sev.c
@@ -1406,7 +1406,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp,
                sev_clflush_pages(&src_p, 1);
                sev_clflush_pages(&dst_p, 1);
 
-               if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16))
+               if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16) &&
+                   (!cc_platform_has(CC_ATTR_HOST_SEV_SNP) || cmd != KVM_SEV_DBG_DECRYPT))
                        ret = sev_issue_dbg_cmd(kvm,
                                                __sme_page_pa(src_p) + s_off,
                                                __sme_page_pa(dst_p) + d_off,

But if firmware temporarily converts *both* pages, then we're "stuck" because at
some point KVM needs to actually target the correct guest-owned page.  The only
option I can think of is to require capable(CAP_SYS_BOOT), *if* the above doesn't
suffice.

So what exactly is the behavior here?  Because I can't find anything in the specs,
I can only make educated guesses based on the SNP_DBG_DECRYPT documentation.

---
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Jun 2026 12:21:56 -0700
Subject: [PATCH] KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on
 SNP-enabled hosts

When {de,en}crypting memory of an SEV or SEV-ES guest on an SNP-enabled
host via a temporary buffer, allocate a full 4KiB page for the buffer to
ensure the kernel won't concurrently access the page that's being
{de,en}crypted.  On SNP-enabled platforms, firmware modifies the RMP to
temporarily take ownership of the to-be-{de,en}crypted page, and so using
a sub-allocation results in unexpected (and seemingly spurious) RMP #PF
violations due to software attempting to access a firmware-owned page.

Note, it is unclear whether the RMP updates are considered architectural,
or an implementation quirk, as none of the documentation for the non-SNP
DBG_{DE,EN}CRYPT commands say anything about RMP updates, nor does the SNP
specific firmware ABI spec.

Fixes: 4c735bf1bc22 ("KVM: SEV: Allocate only as many bytes as needed for temp crypt buffers")
Debugged-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83..87025d0d2f91 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1280,6 +1280,16 @@ static void *sev_dbg_crypt_slow_alloc(struct page *page, unsigned long __va,
 	if (WARN_ON_ONCE((*pa & PAGE_MASK) != ((*pa + *nr_bytes - 1) & PAGE_MASK)))
 		return NULL;
 
+	/*
+	 * If SNP is enabled, i.e. the RMP is active, allocate a full page to
+	 * prevent concurrent accesses to the page.  Firmware modifies the RMP
+	 * to temporarily take ownership of the page while the {DE,EN}CRYPT
+	 * operation is in-progress, and so concurrent software accesses will
+	 * encounter seemingly spurious RMP #PF violations
+	 */
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		return kmalloc(PAGE_SIZE, GFP_KERNEL);
+
 	return kmalloc(*nr_bytes, GFP_KERNEL);
 }
 

base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced
-- 
