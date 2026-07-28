Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E759282F1B
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201540; cv=none; b=jRsbgMy/XYF//KovxDc1YxUVpGlzDGl5/n5qAHRoLlM9RXXpDgRt5yu0yhkzPJp8tqc9x1NHTSkRMJ+RiirNogMMdLtLd5fyiotsfTFQxOTBOo2HXxF1tWtl9y5IGHnpJ1id9T2J4QsAufCQKcrCXgCXrAQGOqxcORtpa36WP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201540; c=relaxed/simple;
	bh=+5DkeVGWBTDD19jKdpMEnZdIcumnltaM7M+hf9rHv1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TaZa1YIulv9M1u+u0jpDnHdM+lD8SqDlK4w/kaxvOne+iVCXtFUwkcIvVDUDLWSPuwNY9aJRL8PxNL/TzXlWN/y5M3FCtBegWXiqaDJO3GoGYGnzeNPT65crwFaIJpSzBeCcl4II55YzWj2EEbO+gsU0wHsthamQhLps1/L5NpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YoeBEZvk; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YoeBEZvk"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b13so3711147a12.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 18:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785201538; x=1785806338; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+PYFdEx6jGoHPrXaWg/P5adSzHhZT94sZkOpxSRlebU=;
        b=YoeBEZvkMxK37jFa+QbMS0eaI3QMnMoPfM8iwv1/MrIYzunDVfrxjWRdOgC2/PMruj
         rnUUhkpCrGPrUZPrG2Cps/N9wyKchJsZ86Rzk0/ccRRciwJwhHuxc1Jtlbf6zfxh7L6z
         +g/cw+Q762scdN7SWPwfY8U+HM16lPv2itUZAcfXjp7ARYWNzWE0PjdFLPHSFIX1Pg7J
         d+RkKMRk6r9L3Vcg9Ldi3IHKXiw9E5P0Zx6BfhPzqv8UxJDTNiRTljPWlqqK/+sdJm9C
         o6DNMarOoH1FD6+Rrv8EjuVvW7gXbHq+F/vhDxpr4Wmd9zaNMSNra5KPsQIw9qw8QN0C
         VEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785201538; x=1785806338;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PYFdEx6jGoHPrXaWg/P5adSzHhZT94sZkOpxSRlebU=;
        b=cEohU5GD9rAjo0aqsJ+F9kvfTNQByrrv7dSgWMWTTbOWxxveuAyLDK23PkPST0F09n
         ZKoCcr/DAEgCXzWQoelQWpBbbH06qhdJ4LkoJ8BMRf2k7gt5zulz/0J2lzK8cTEr71+e
         EnaPiIsoENboM0RgI/XG7UYkmxUgBThyvyNLY/TTG5Vl02igOXZVK0JPxRxblXCQa+Pe
         pI8DXFgKuk9e9uZucyR7uN2pJHXPGtLGKWcQi3+NoO18pCUcTgcIDoj1wwxgDuGVymAJ
         rEbt+jkZO0Qi4LSDtx7Xj6A339h26yBvBIS7tQ00QO1cZQ60jTF9DmvXKXYuNiZAGR6f
         EVLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4Q/uHjLGDyNwa9WAb6y3ejRYDYG51tuH5rvO2F0mgMHZwADIE5o9Dfb/dCUhc9b4844M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCQ+M4f39Qw13g2YUz4nQUPL1oL1Lk4ZHuEDNlAs7LOvDV1By
	sEce9srYhqHcOoh40XFKOZtJH0qQL89mQrmvECyEm3ij+6Sa+xsLlWM6KXCkppxz1ZqKrn5J7eO
	OTiaaAQ==
X-Received: from pgam4.prod.google.com ([2002:a05:6a02:2b44:b0:c8b:ed9c:4468])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2291:b0:3c3:83e6:c705
 with SMTP id adf61e73a8af0-3c8ba5beec0mr399309637.35.1785201538348; Mon, 27
 Jul 2026 18:18:58 -0700 (PDT)
Date: Mon, 27 Jul 2026 18:18:57 -0700
In-Reply-To: <CAO9r8zOVyea=7yRD25JcRmar4-0JtTpuoDpK__J431o9MJYj2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <CAO9r8zOVyea=7yRD25JcRmar4-0JtTpuoDpK__J431o9MJYj2Q@mail.gmail.com>
Message-ID: <amgDgTpPGsE451QP@google.com>
Subject: Re: [PATCH v1 00/28] KVM: nSVM: Optimize nSVM TLB flushes
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 27, 2026, Yosry Ahmed wrote:
> > Yosry Ahmed (28):
> >   KVM: nSVM: Flush the TLB after forcefully leaving nested
> >   KVM: SVM: Document number of ASIDs CPUID setting
> >   KVM: VMX: Generalize VPID allocation to be vendor-neutral
> >   KVM: x86/mmu: Support specifying reserved TLB tags
> >   KVM: SVM: Add helpers to set/clear ASID flush in VMCB
> >   KVM: SVM: Fallback to flush everything if FLUSHBYASID is not available
> >   KVM: SVM: Duplicate pre-run ASID check for SEV and non-SEV guests
> >   KVM: SEV: Do ASID initialization at VMCB initialization
> >   KVM: SEV: Expose sev_get_asid() outside of sev.c
> >   KVM: SVM: Use a static ASID per vCPU
> >   KVM: SVM: Only flush the fallback ASID when used by a different vCPU
> >   KVM: nSVM: Add a placeholder ASID for L2
> >   KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
> >   KVM: x86: hyper-v: Allow puring all TLB flush FIFOs
> >   KVM: nSVM: Drop svm->nested.initialized
> >   KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
> >   KVM: nSVM: Always switch VMCB before leaving guest mode
> >   KVM: nSVM: Split nested_svm_transition_tlb_flush() into entry/exit fns
> >   KVM: nSVM: Service local TLB flushes before nested transitions
> >   KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL
> >   KVM: nSVM: Flush the TLB if L1 changes L2's ASID in vmcb12
> >   KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on nested VM-Enter
> >   KVM: x86/mmu: Rename __kvm_mmu_invalidate_addr() to
> >     kvm_mmu_sync_addr()
> >   KVM: x86/mmu: Refactor kvm_mmu_invlpg() to allow skipping the GVA
> >     flush
> >   KVM: nSVM: Flush L2's ASID when emulating INVLPGA
> >   KVM: nSVM: Flush the ASID on nested transitions if shared by L1 and L2
> >   KVM: nSVM: Use different ASIDs for L1 and L2
> >   KVM: selftests: Add a test for nested TLB flushes
> 
> Sashiko wasn't able to apply the patches:
> https://sashiko.dev/#/patchset/20260728003557.1136583-1-yosry%40kernel.org.
> 
> For some reason, it failed to apply on the baseline commit,
> 271255273d5ff348fe29d89fe4712b2f7f7907c3.
> 
> This is the top of kvm-x86/next tho, so I am not sure what went wrong:
> 
> $ git show upstream/kvm-x86/next
> commit 271255273d5ff348fe29d89fe4712b2f7f7907c3 (tag:
> kvm-x86-next-2026.07.27, upstream/kvm-x86/next, upstream/kvm-x86/HEAD)
> Merge: a204badd8432f 2abcdf03fda13 9c66085e6dcfb db3a46e200df2
> 2708ecca4dbdb 710b3a30f407e e428f9779a437 653857a5af462 ec9a16c6aeba8
> 05a0b701d1089
> Author: Sean Christopherson <seanjc@google.com>
> Date:   Mon Jul 27 12:44:28 2026 -0700
> ...
> 
> The commit was from earlier today, maybe Sashiko only fetches the
> trees every once in a while?
> 
> kvm-x86/next is not among the list of branches it tried. I don't see
> the tree in MAINTAINERS, so perhaps this patch was never picked up:
> https://lore.kernel.org/kvm/20260428171541.1342335-2-seanjc@google.com/.

Yeah, I need to get Paolo's eyeballs on those changes.

> Adding Roman here just in case. Sean, let me know if you want me to
> resend this series after we figure this out.

This is probably my fault?  I force-pushed to kvm-x86/next this morning to fix a
stupid goof I made, maybe Sashiko was confused by the exact objects not being in
in linux-next?  I would say do nothing for now, we can always do a resend if us
humans don't find anything in this version to necessitate a v2.
