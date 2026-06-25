Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14543ECBED
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404470; cv=none; b=Aq4ji8X44Qxo9aclTbMjYsGxZPx/4mEb2AC+ZopwQ5EK6UN4OC9WNiFHupu/CsM5KA8wNOhJIpr6cJxe4IB4uChI9LHTc3fRjexKeznC3XQTJKZDBTyNPn4Cv6Gg88wqNPyGSHNqojN+EnolbZcODMnRqv3tnGFlS3UKEecKpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404470; c=relaxed/simple;
	bh=cWoMyE2Jt9LI5QWmHop8a7As2DpqmKqDzIfcUPR8gok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JSURNnxyMTyCNaqHPj8LB9XZdet1xzviQ9wYUFVsUFD8LVg4Fszv2BTpnRupjXEPkGo62gk6TIJqxxR20Ao5dIHZ2buk+k0Rb2R9CMsN0AgBfkzfGbu49+kRjDhilmjStnWGZSjA+iUfMIacK5QDa9fzVKzp9L6vtDmjmW2vtEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z70+GDa+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z70+GDa+"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c889d1eebafso57564a12.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782404468; x=1783009268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0Iegm3XWpEU50W87frBJm5VEN9NWiBbsMScWatf8rs=;
        b=Z70+GDa+yZiGdrM1xvJ6lL9WnsaRLQG9TdY0mAy+OFmyLEzsW5AxcfUG95LFOeOWNl
         t2Xn6CweLUjoUMFNbg74n0GdtpZyne3ojyDprFuGF8zjTEJaMoLHw1fL+ZOTbkHFAziL
         PqEGpvN9El9k1aWIA8xTy4VYMbbmjJrQAXsnaTQujvwniEPK+3kmF7TQIyaGPeX0aJQA
         RY0sd1rcWzvT9CJ7iDlpKJ8GgKP0D0fbEqE93yQgUIWoUSsJW2c1mjTrsdwoFxke7GwT
         OkaoWUS8k+tGuTINJEb0LKThDgy/nmJ8429ue5uXFXdJrNqcxhrQrisf6oy8AL6xm/+v
         fy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782404468; x=1783009268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0Iegm3XWpEU50W87frBJm5VEN9NWiBbsMScWatf8rs=;
        b=SBJbFSCBTarxMiNXE88e8u+Ln+nUpHDd0nRuu0cOLhi0MCFR/z+3GoS4AqJa0s5jRq
         NPJulL1UYwyrotCbZlLgQqsu2WJ2IfJG/aKQv4n5oS5oUhWKRscd3Z20IUlqVELnMrBx
         qlMKhFNDCITSDvLwEdvpWIzh13V7gzKDj2CuAjPMLDGCEB9IgeYjAbxOhPdxzP46/uDf
         Xau7p39ftMJZXMzWNf/udnglq425WRo+Vl3aZDjaMuZ3rWKiVXg8xKtvDx8zL3ahJ8yd
         01eE4Uhaax0hdi0MYJ8qgHlvonMOEC7PKgSXlpkJMu92YpbsjFBqfRTkcjWAU8MINoZz
         ZiTw==
X-Forwarded-Encrypted: i=1; AFNElJ/M16wwANFo/uEnAc2fpljJeu3LyBYlZLGu3BIdTPwCtUs1m+B11avaUESAC51/T5xB0kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeHsNKZvUKoojGYsz/yFiQsN3ZoQqVS2eD4aJzeem73Al//mS
	nTX9TeOhvZtojf6SYphNuSWky8pgLyIKVU/q6nawE4ECOXShzNqgpVBpWEXYm9NSgeW3/orBQQW
	tDEFTJA==
X-Received: from pfux48.prod.google.com ([2002:a05:6a00:bf0:b0:845:b531:adf4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa3:b0:3b4:8bc6:138
 with SMTP id adf61e73a8af0-3bd4ae9cd56mr4201086637.23.1782404467957; Thu, 25
 Jun 2026 09:21:07 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:21:07 -0700
In-Reply-To: <178221517808.3589966.15538835749975810737@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260621133708.3454718-1-mike.malyshev@gmail.com>
 <20260621133708.3454718-2-mike.malyshev@gmail.com> <ajnEAkFGyJWmomhq@google.com>
 <178221517808.3589966.15538835749975810737@gmail.com>
Message-ID: <aj1Vc13mqb-fXiow@google.com>
Subject: Re: [PATCH 1/1] KVM: x86/mmu: Emulate, don't kill the VM, on access
 to a disabled passthrough BAR
From: Sean Christopherson <seanjc@google.com>
To: Mikhail Malyshev <mike.malyshev@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 23, 2026, Mikhail Malyshev wrote:
> On Mon, Jun 22, 2026, Sean Christopherson wrote:
> > I really don't like this.  It's an ABI change that affects years of precedent,
> > and the ABI it creates is very haphazard.  E.g. why should PFNMAP memory get
> > emulate MMIO semantics for this case?  And a PROT_NONE VMA really shouldn't get
> > MMIO semantics either.
> >
> > I would rather have KVM exit to userspace with KVM_EXIT_MEMORY_FAULT and fill
> > run->memory_fault, i.e.
> 
> Agreed, thanks - that's the right layer, and the PROT_NONE case alone is reason
> enough not to overload the pfn classification the way I did.
> 
> For context on v1's shape: localizing the fix in KVM was a deliberate scoping
> choice - it was the smallest change that stopped the crash without updating
> another major component (the VMM) at the same time. I agree that optimizing for
> a single-component change put the policy in the wrong layer; KVM reporting
> KVM_EXIT_MEMORY_FAULT and the VMM applying device semantics is the right split.
> 
> Plan: implement your suggestion (kvm_mmu_prepare_memory_fault_exit() in
> kvm_handle_error_pfn()) and pair it with a QEMU change that recognizes a
> memory-fault on a vfio-pci BAR whose memory space is currently disabled and
> emulates it as an Unsupported Request (reads all ones, writes dropped) rather
> than aborting. Note QEMU's current KVM_EXIT_MEMORY_FAULT handling only covers
> guest_memfd shared/private conversion, so this is new vfio-pci handling on the
> VMM side - I'll test the kernel + QEMU pair against the reproducer before
> sending v2.
> 
> FWIW this is the concrete user the 2024 KVM_CAP_MEMORY_FAULT_INFO work
> (Zr-8M9rYplgN6IS3) was missing: an assigned Intel iGPU whose guest driver clears
> PCI_COMMAND.MEM on one vCPU while another is mid-MMIO to the BAR, which kills the
> VM. Reproducible on demand and seen in the field.
> 
> Two questions before I respin:
> 
> - Prefer I revive Anish's x86 patch from that series (rebased), or a fresh
>   minimal change against kvm-x86/next? The tree has moved a lot since 2024
>   (kvm_follow_pfn, etc.), so I was leaning fresh with a Link: to the original
>   and Suggested-by: you.

Oh, I forgot that Anish had posted the x86 MMU change as an isolated patch.

Given that patch 2 still applies cleanly, I would say take Anish's patch, rewrite
the changelog, and then give yourself a Co-developed-by.  I.e. give attribution
to both Anish and you.

> - You'd asked for KVM_BUG_ON() + -EIO conversions on that x86 patch - still want
>   those folded in,

Yes, please tack on a separate patch to convert the WARN_ON_ONCE()-protected
EFAULTS in x86's fault path to KVM_BUG_ON() + -EIO.

> and should this stay x86-only or also cover arm64?

Definitely keep your patches x86-only.  For all intents and purposes this is a
bug fix, let someone else deal with the pain of enabling KVM_CAP_MEMORY_FAULT_INFO
on arm64 :-)
