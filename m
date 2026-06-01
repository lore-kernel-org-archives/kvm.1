Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F63603C7
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323873; cv=none; b=ZEs5WdduBErA9icKxYP8uZaifBel4DX8naG1+Tt2vVrg2xSDoNkJGZe4tdIU+bUr/gqL6b78DVkGhw88rqe2g27d3S/F0kG27y9Lx23+N6t0FGD+CAdpE/rKcc17z9oatax/h1Shv/4sXHcYMKWqsfP/RA/y9FdhtaZK2GBOB0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323873; c=relaxed/simple;
	bh=LV92VYjV6Qz4zqtIQI89lNEtCBsYv2pr5TpzqZga1Kw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DjWOHy9wKILyYtZSLDxeJ2QSAK8HhqN7CL/IEdHo9z8fJduLWxrxul3rOLArqpsBKd2xcO0tm7jQNOoaNqqK+PLfnqmSw3ZnDJCeNPbf1DidRVlncT92kKizWU/MEqRT5oJ39iHe8gOP6Nu2NT2WhaBpY2jPpEywGGVk3LAJan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTWQbIq0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTWQbIq0"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8592a62f32so1122413a12.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780323871; x=1780928671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmhRpZ8fkE8fPmVKF1pA/Lfu19TASa6X3/30/SzP5vA=;
        b=DTWQbIq0HX1SkehwykrCBC2k46YfLZYydQes4QG7/SYKtIFTaFshhvY2s6HqysmJsm
         giAPrpi4kch8WKJDgK3g6Fdt3Eu3LCptjIJQBWDLVoyMZjrmRwRyQkeEpXrifX4tdXNW
         NhQRcIIBPODTVzL4sF6BgNTL0WaKhP6+Mihf0FiTCX24v0QRBMvzM7At/4OsGEs8Bv2f
         CmTPvnDltgGlvHrLo6hjncfsWnCcTKWJoiPojKhR+T1W1JoW3Gj16seHUaGbwHG1GNKe
         SvCWVzK61DbRGRPgtulVHHgawPBo/Qd2vNtr1BkSEWXXLcTQvl8Wj60kG+EpCzBTNp96
         30BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323871; x=1780928671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmhRpZ8fkE8fPmVKF1pA/Lfu19TASa6X3/30/SzP5vA=;
        b=eV1fb37yRpDkTVMOrC9JmPquasOrmbjgsWogW7OqemxOeorFl8zp83wf07Y14lmeCO
         bV8DFLhtiadlS20zltgvR3nIw4ZIeIMXQgAgevJ6q0SvrXPXBiYhOYWlOO/PFzT+qrfd
         vk+GpIK/jNWDNL+wn1LONMY7PfPwrh11Gprhm/XMoS9gWAS7raDci8Fo11Ey82d36Po3
         e0VB7JMdLsvjnPgQ41hSb7cm5jyziyi+IUXHlXm5ZMIW7WR4+JHFO3TCxhnQyJ/MGspW
         9QJHA479tA2t2P4Yo36U3ndqZ81i6/qvlaTW/VCEsUeBrqRmqAQ7OerLbNRi5V0YRUUn
         Ef/w==
X-Forwarded-Encrypted: i=1; AFNElJ8b6Ge4SKjm9abeUFr1JVJlTVTaziPBYIxr69WTw813MriNZbu+e9Kf7Vsx82r7uJT2Y9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCaWwXcQEZHj7TTfnzWF/xwyI8pATCEDSMWEquDk3/lD5tR7qd
	ESJQLb7VYoLqLWtkrux6R4pwnYJzFWU86X4dTPcMjKluX8ZPe62/hnGK9YHd2zC7KXTgt6hZpYG
	yrfM5BA==
X-Received: from pgju13.prod.google.com ([2002:a63:f64d:0:b0:c76:6cef:34e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a4a:b0:398:78c0:6dca
 with SMTP id adf61e73a8af0-3b427eb09eemr11835863637.15.1780323871207; Mon, 01
 Jun 2026 07:24:31 -0700 (PDT)
Date: Mon, 1 Jun 2026 07:24:30 -0700
In-Reply-To: <aho1wgNn8pSgaBUU@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-28-seanjc@google.com>
 <aho1wgNn8pSgaBUU@google.com>
Message-ID: <ah2WHuMMKDfpADHF@google.com>
Subject: Re: [PATCH v3 27/40] KVM: x86: Move register helper declarations from
 kvm_host.h => regs.h
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Yosry Ahmed wrote:
> On Fri, May 29, 2026 at 03:22:10PM -0700, Sean Christopherson wrote:
> > Relocate declarations of Control/Debug Register, EFLAGS and RIP helpers
> > from x86's kvm_host.h to regs.h, to continue trimming down kvm_host.h.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h | 17 -----------------
> >  arch/x86/kvm/regs.h             | 17 +++++++++++++++++
> >  2 files changed, 17 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 19091d89d3cc..0f4b16b26a27 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -2186,8 +2186,6 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
> >  void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
> >  void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
> >  
> > -int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
> 
> Why are pdptrs helpers bundled with register helpers?

Page Directory Pointer Table Registers
                             ^^^^^^^^^

Or as the SDM initially describes them, "5.4.1 PDPTE Registers".  When using
PAE paging (not 64-bit paging), they really are CPU registers, and their lifecycle
is tied to CR{0,3,4}.  I.e. I was thinking of them as an extension of Control
Registers.  I can explicitly call that out in the changelog?
