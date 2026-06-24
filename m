Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C913E5EE4
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336267; cv=none; b=ahola6p0OJnsiCxpUw/O0fjWjzIgxhAv033y7TurmrrcDEXmCaSlYg+lG8W4OesAAwlNfcEKUbJ1Rkeb1SiKBa9l6dngRTeck9XwKJaY23yv7If64pGVDnK2o/lyp3qdebSLYdb5OkzUzx6m7ri1291NQwsq5MMdPdX7TTAWSMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336267; c=relaxed/simple;
	bh=2lge+Pd4W0zB1s/tSHgdzijBtMZQZMA5TRxQYp4mKkY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dqcO24PmekbPBSLfs8shlPWQYrFd4p6tagN/uHCwVdF45vBP7FjO3BYKMIqjfrIYL7pvtm3Ug3WZzzL5rSBwS17lYbp02CkFxCiy9dCsyNUHu6AMK7CEhnUt1587ThRfJ5zNmDX/0Om0E60wjfvk5PfEJWg+3GXt5ubJWdU8N2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIfMF2EF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIfMF2EF"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84245e2bb00so1371661b3a.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782336265; x=1782941065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgd+lmmBeOYJKxFSRKtOvJkSqu6mdzwXWBeZO2ZkeHQ=;
        b=QIfMF2EF/Gnul6sPAFsDJtaTHPjPYIyyjO9SyMY7LtNv52VD3qjohquccSAwdRie4d
         EYwTC5daqJSnLb3HgMhtl0XC4LJ9COka6iSSINOOP6H5ncAQIE+tLVMgTbtFysOSH+0G
         X8dyMNB8FK+Xde26GaX5k+UbOlE+n0PnJ3kVHKsVPLBqZeVaBiuKXk8+H3C/8Cl/IaaA
         /J+B5lbGX5vsZVab8nAJuGFCnpXw2Lwf26kCvmGwQ2+zX7lgCbgwEKtgswA9hh9zQpmV
         B27Gk5/Dzv+3eQ4K3z4gEX0R1JyfCpH9IIYttf/6GRhgEGJjzBe5U3fkGPwhstKD0u9G
         bfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336265; x=1782941065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgd+lmmBeOYJKxFSRKtOvJkSqu6mdzwXWBeZO2ZkeHQ=;
        b=pCOCzr1AvJOF6+YHsbzsFDlGgJJ/s1BLVZBS4Y/6EGwzPp3kXWaglZg6HBBdzb5eO2
         K8nZUtKnDjp5WdAkjoWLFyOc8Q98HHbzXLh+HumkAjjVF/El6PP08lM+cK6bdZTH2mDN
         F54xfOyDfEDFSZdkrw4SU+BbrRtysB/bhbDo7IN1y4N/i2aQW4UgVq2kaRfq5XReSUV+
         2CEeLp69HLrm/ufPFGF+k6YmUAfwxkZHzPrK0+edWj2OoOWIGs2Y/b8WIzkA3nVYB+QW
         BT2ZCAblrpNgSHB0rw1KCDo5oUxyZNBvqKkqcfJFGd0Nb4IClp4fmqcs2AJJMCDiFoRz
         O5Mg==
X-Forwarded-Encrypted: i=1; AFNElJ8U/nptbzyGxcm6HnTz7TpRF0/a1usxecixe97jVkUgYNOkRU/IdnpBaAQ48reBlC2bdp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwllAh2uNOuXiTycSKXw+mYqJRd2QyzXkJ0KWfea1ewnR/lnpkZ
	nchcT0HNoj8Ss36gRYb11ElJHBpqzlLqaUZ30ZVk8FvqpB5WnoiLBOBqoZW5X0FlWsYlb3oloMt
	U2sKYNQ==
X-Received: from pfbbm3.prod.google.com ([2002:a05:6a00:3203:b0:842:5659:67de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2301:b0:822:6830:5900
 with SMTP id d2e1a72fcca58-845b3607627mr8582b3a.6.1782336264898; Wed, 24 Jun
 2026 14:24:24 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:24:24 -0700
In-Reply-To: <ajsjQtpZb-h2BdPh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com> <20260501203537.2120074-3-seanjc@google.com>
 <ajNQ_Ix5e0p6FuFT@google.com> <tx3hcnrhfbcz2p7e7umc5o2zrw74pluzuzgtlqt4dz5cc5nhxx@6tzzorc25nqw>
 <s7jfbw3tnfgmp6blfqlfoi7yhq6f5n6xl62zzty5up45cqtsty@ljpjlvqw2gyy>
 <ajrkryMxHZtsMvga@google.com> <6xyh7xa53k2s7bytlkcys4pyq4756rwoly5q7swrifv3td6dey@3h5e2e67lkvj>
 <ajsjQtpZb-h2BdPh@google.com>
Message-ID: <ajxLCMgLQe-JiRfq@google.com>
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV
 {en,de}crypt debug ioctls
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 23, 2026, Sean Christopherson wrote:
> On Tue, Jun 23, 2026, Michael Roth wrote:
> > On Tue, Jun 23, 2026 at 07:55:27PM +0000, Sean Christopherson wrote:
> > since your proposed fix seems nicer and more complete anyway.
> 
> It's missing a case though :-(

Ah, but so is the revert, and it's not a coincidence that the old code didn't
bounce buffer the destination for KVM_SEV_DBG_ENCRYPT.

> The final write for ENCRYPT writes to the destination directly:
> 
> 		r = sev_issue_dbg_cmd(kvm, __sme_set(__pa(buf)), dst_pa,
> 				      nr_bytes, KVM_SEV_DBG_ENCRYPT, err);
> 
> More at the bottom.

Once more, with feeling...

> > > diff --git arch/x86/kvm/svm/sev.c arch/x86/kvm/svm/sev.c
> > > index 87025d0d2f91..7e3334c90c57 100644
> > > --- arch/x86/kvm/svm/sev.c
> > > +++ arch/x86/kvm/svm/sev.c
> > > @@ -1406,7 +1406,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp,
> > >                 sev_clflush_pages(&src_p, 1);
> > >                 sev_clflush_pages(&dst_p, 1);
> > >  
> > > -               if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16))
> > > +               if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16) &&
> > > +                   (!cc_platform_has(CC_ATTR_HOST_SEV_SNP) || cmd != KVM_SEV_DBG_DECRYPT))
> > >                         ret = sev_issue_dbg_cmd(kvm,
> > >                                                 __sme_page_pa(src_p) + s_off,
> > >                                                 __sme_page_pa(dst_p) + d_off,
> > > 
> > > But if firmware temporarily converts *both* pages, then we're "stuck" because at
> > > some point KVM needs to actually target the correct guest-owned page.  The only
> > > option I can think of is to require capable(CAP_SYS_BOOT), *if* the above doesn't
> > > suffice.
> > 
> > Not sure I understand fully, but snp_populate_cmd_buf_desc_list() in the
> > firmware driver requires the transiton for the destination page that we
> > write to both for 'encrypt' as well as 'decrypt'. What the issue with
> > using a temp buffer as the destination for the 'encrypt' case?
> 
> The problem is if KVM does NOT use a temporary buffer, which is the "fast" path
> where src, dst, and len are all 16-byte aligned.  In that case, KVM does inline
> {de,en}cryption between src and dst.  But those pages are also mapped into
> userspace (they have to be, since KVM pins them via gup()), which means that
> userspace could feed the same pages to a different chunk of the kernel that
> reads/write userspace memory via gup() (or gup-like equivalent).
> 
> E.g. pread()/read() on shmem-backed memory.

pread() doesn't work, because the source or destination needs to be a userspace
address, and so any RMP #PFs will get eaten.  But copy_file_range() makes the
world go kablooie.

Weirdly, I haven't been able to get a splat of any kind, the host just goes
AWOL and reboots.  But I'm very confident RMP #PFs are the issue, because doing
the same operation via writes in userspace yields:

    sev_dbg_test-24385   [049] d....  1892.853197: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
    sev_dbg_test-24385   [049] d....  1892.853202: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
    sev_dbg_test-24385   [049] d....  1892.853204: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
    sev_dbg_test-24385   [049] d....  1892.853206: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
    sev_dbg_test-24385   [049] d....  1892.853207: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
    sev_dbg_test-24385   [049] d....  1892.853209: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
    sev_dbg_test-24385   [049] d....  1892.853211: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
    sev_dbg_test-24385   [049] d....  1892.853212: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007


> Looking at the full picture, isn't this a bug in the PSP driver that affects all
> commands?  With pre-SNP VMs, "guest owned" isn't really a thing, since nothing
> guarantees that the destination page is accessible *only* by the guest.
> 
> If we rip that out and always bounce-buffer, then KVM won't have to force its
> own bounce buffering of sub-page lengths for SNP, and that would eliminate the
> race I described above.
> 
> Completely untested (I'll give this a whirl tomorrow).

So this doesn't work.  Dredging up some knowledge of how this all works, I'm
fairly certain the issue is that the encryption is salted with the physical address,
and so encrypting at X instead of Y will yield different ciphertext.  I.e. any
command that encrypts the contents in the destination (or in theory, decrypts,
though AFAICT none of the commands do so) *can't* be bounce buffered.

I don't see a way to salvage SEV/SEV-ES on SNP systems, short of requiring
CAP_SYS_BOOT or some other elevated permission to do *anything*.  Or redo SEV/SEV-ES
support to require guest_memfd for operations that require putting pages into
Firmware state.
