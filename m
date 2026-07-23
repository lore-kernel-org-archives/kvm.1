Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6583F7877
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842195; cv=none; b=uBC/LoTAk7tF9/9CgaiuNtrwIqVYlP4kUNqVQd+HR3dBowqBq1geMLqNasMvQz1W2r3k/iDxAf/7iPvsDAG5b53eHCRe6+6/bMtW4p1JPHSyUdDR8KcPFuTsxenN8d7QvUyQFV/15qLfNnUIlSerJFZyc+YnagPPWR93gaC3bGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842195; c=relaxed/simple;
	bh=e6IZKxUEbVEBK1Pw8ModRySJJQgk6Sw+j+2PnssWMCA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sfATHoySzb47vx4XWYiVLf9uD6fRu+fF/8YNJW8CG/uqyVbVgO1xt+pXVtggOm1dri4jkugvXR5Ah94E7lkuW1rL/ZGP2xOIeuZGAraxLmPpjpMh1Z4su6GZpO+ivvgQEOE1VPiYaxZbawvCCqWVc5zXVfeb9HNi8BPdUWELE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RKxQEdxP; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKxQEdxP"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfca8558d2so93305ad.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784842193; x=1785446993; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YK/O6RuCYEF9evxzm6qmAAEvfpjWfPoAD75w9yRXmBI=;
        b=RKxQEdxPOOVII8UiHkWofHALwiZIwjA/ehLkj//OOZ9+M/QqrqDx/ab/8APvzMFXo/
         aJexGpMnHiqh/lB0cSjRliQQEIK/moWKa9V8F6UIviprjAOmyCPD1MJyQk0VEMm8SS2U
         wRvDhunaxCN1nP+i+icVTyzbrJU2OlRVRIqloFC2w1ayL4S8gFuWJPUpWHL0cA7Hhr8b
         1czMK+lknR2kPQLzyZ61pWavagNEeKytLZcnAYY9IqAL25rcMsBM56dap/wLhsrXPSaQ
         wWAppp2ZVh6Ddv4VGqnf2F4Oa0qRCRQsq8e4VUVp3b+6T/oNh6CRMF8dRNNP7Bka/l6h
         oGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784842193; x=1785446993;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YK/O6RuCYEF9evxzm6qmAAEvfpjWfPoAD75w9yRXmBI=;
        b=YvFzimBrXehQORPdZIkXLDrIPkJu9+LEQDBax7ro3p+n5Uzh5JONMJVr12E+Kq9HSE
         Cfy+v0u9mbL/23X9uqhKo0yIeOM4VGt/YYUuL7dq1Dg2I5SZVRVAQVYj8dpNJSFNxSop
         gwffxC4SpDJLkYna5XSGGIMyhEMBDvSx8IFYar60N1PZ9zwxUs1JxL7jLrM2zdmkK92E
         Do3GXNcvzGR+iCPmfc9Bdzj77Dna6k68G0NidMBGweQ5k5P2jQjYyWDJ/C3l1PKhiRJI
         4spIELjrfB3nj824CWvQdNr5XMI9cmBoKKtZ2xk+nhkfaHKR9ghi+rCdbeaIsyticklh
         76nw==
X-Forwarded-Encrypted: i=1; AHgh+RpzJFBVDcsO59BIdWncmPX2jWW2sgXqWuVsxNO4JCn0AetA+5JlYMm75uJY51hzXN2Hxuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybkDtrnXymj6mCmzsywU96YZmXJw3GopLIf3Yg/OI1+iyOHHXI
	I6vucIsMj7HWBAQanwhLrEK2mQk41evI6ZI2W+kQoi48fjpVpBiqh6JUOmBMJQXcUyGPFU9pVCT
	Jt+KANg==
X-Received: from ploh9.prod.google.com ([2002:a17:902:f709:b0:2ca:ceab:34ae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:9ce:b0:2cf:83bf:6b05
 with SMTP id d9443c01a7336-2cfa6f82203mr53916385ad.41.1784842192750; Thu, 23
 Jul 2026 14:29:52 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:29:52 -0700
In-Reply-To: <7rg4rrbyecgoy32qzrye2r2wdy7bbalgl73anx6gd3qfndc2ar@7auj6hyujjg3>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tx3hcnrhfbcz2p7e7umc5o2zrw74pluzuzgtlqt4dz5cc5nhxx@6tzzorc25nqw>
 <s7jfbw3tnfgmp6blfqlfoi7yhq6f5n6xl62zzty5up45cqtsty@ljpjlvqw2gyy>
 <ajrkryMxHZtsMvga@google.com> <6xyh7xa53k2s7bytlkcys4pyq4756rwoly5q7swrifv3td6dey@3h5e2e67lkvj>
 <ajsjQtpZb-h2BdPh@google.com> <ajxLCMgLQe-JiRfq@google.com>
 <45ixyum4upln4b2yvasovm2bmsfxyfezsi23vsr75r4fklelef@utxv4mymvfcd>
 <ajx1Y93iX2oV-DLa@google.com> <2b4d5faf-1568-4080-92b3-1e525a11b194@redhat.com>
 <7rg4rrbyecgoy32qzrye2r2wdy7bbalgl73anx6gd3qfndc2ar@7auj6hyujjg3>
Message-ID: <amKH0E_VKOR5wyEG@google.com>
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV
 {en,de}crypt debug ioctls
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 23, 2026, Michael Roth wrote:
> On Thu, Jul 23, 2026 at 05:17:26PM +0200, Paolo Bonzini wrote:
> > > > > I don't see a way to salvage SEV/SEV-ES on SNP systems, short of requiring
> > > > > CAP_SYS_BOOT or some other elevated permission to do *anything*.  Or redo SEV/SEV-ES
> > > > > support to require guest_memfd for operations that require putting pages into
> > > > > Firmware state.
> > > > 
> > > > Yah, short of maybe the above approach, I don't see any way around it atm :(
> > > > If you think it's worth pursuing though I can give that a shot on my
> > > > end.
> > 
> > The unavoidable ones include, if I understand correctly, not just
> > DBG_ENCRYPT but also LAUNCH_UPDATE_DATA?
> 
> That was my understanding, e.g. a user could try to use the HVA to
> trigger the copy_file_range() path right after
> snp_map_cmd_buf_desc()->rmp_mark_pages_firmware() is performed as
> part of servicing the KVM_SEV_LAUNCH_UPDATE_DATA request, and it seems
> like that would trigger the same issue. And bounce buffers wouldn't work
> for that one either.
> 
> and it's kinda important =/
> 
> > For encrypt the destination is the guest memory, so how would adding
> > guest_memfd support for SEV/SEV-ES work?  The guest doesn't have a
> > page-state-change call and neither does it have RMP nested page faults, so
> > how would you communicate the private<->shared switch to userspace?

Yeah, I was spitballing, I don't think guest_memfd has a viable path forward.  

> During early SNP hypervisor development (when guest_memfd was called
> "restricted_mem"), the patches were actually based on top of some patches
> from Nikunj that added guest_memfd/restricted_mem support for SEV-ES.
> One nice thing about that is it brought about support for lazy page
> allocation instead of relying on KVM_MEMORY_ENCRYPT_REG_REGION.
> 
> The support piggybacks off the KVM_HC_MAP_GPA RANGE hypercall that was
> added on the guest side to enable SEV live migration so the VMM could
> distinguish between shared/private (and punt private page handling to
> something else). By coincedence, that's also what SNP/TDX ended up using
> to forward conversion requests to userspace.
> 
> However, since SEV live migration never became a thing upstream there's
> potential that the KVM_HC_MAP_GPA_RANGE handling might miss some of the
> newer cases, which would lead to silent corruption (though with SNP
> enabled we might still get an indicator of whether or not the guest had
> the C-bit set, so we could detect a mismatch that way and maybe even
> be able to handle implicit conversion requests).
> 
> The big issue with this approach though is hugepages: we'd be dropping
> existing SEV support for both hugetlb/THP unless we implemented in-place
> conversion support for SEV-ES so it could eventually benefit from the
> hugetlb patches at least, but if in the meantime it's 4K-only I'm not
> sure anyone is going to get much use out of that, or still care about
> this support when gmem+hugepages is eventually enabled.
> 
> > 
> > > I say we wait for Paolo to get back from holiday (in a few weeks) before doing
> > > anything drastic.  I'll send a patch to fix the existing selftest though, no
> > > reason to leave that hole open.
> > 
> > Well, everything is drastic.  "Fortunately" AMD helped us with the firmware
> > update that already hides SEV-ES on SNP machines (CVE-2025-48514), so at
> > least there's a precedent.
> > 
> > Could we say CAP_SYS_BOOT is only be required to create the VM, after which
> > it's up to userspace to not screw up?  Probably not, because userspace can
> > then drop privileges and operate on the file descriptor; which is the actual
> > dangerous part.

Hmm, but there may be a path forward with CAP_SYS_BOOT.  It might require some
heavy lifting in userspace, but IIRC, LAUNCH_FINISH is typically called before
doing KVM_RUN on any vCPU.  So while it's not simply KVM_CREATE_VM, I do think
that "users" that care deeply enough about security/stability could implement a
VM builder that runs with elevated privileges, and then drops priveleges (or hands
off the VM) to actually run the guest.

> > The only not-horrible alternative would be a default-disabled module
> > parameter that allows SEV/SEV-ES on SNP systems but adds TAINT_USER when you
> > create one.  And downstreams that don't like the idea can just rip out the
> > taint.

What if we have the module param require CAP_SYS_BOOT for the affected iotcls?
Then TAINT_USER if it's disabled.  That way, if someone is sufficiently motivated
to harden their runtime-VMM, they can implement the builder without having to
manually remove the taint, and without having to completely trust the VMM (because
it's more than just a potential DoS; I wouldn't be at all surprised if someone
can turn this in a local privilege escalation).

> It might not be as elegant, but either of these seems more useful as a means
> to allow users to continue to be able to run existing workloads if they
> trust their userspace/VMMs. I'm worried the guest_memfd support would end up
> being mostly-wasted effort at this point since it's not a
> straightforward/drop-in replacement.
