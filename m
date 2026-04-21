Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE93624C8
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813548; cv=none; b=GP4DyWy5QRS6Pqfpbg9MrRRk+edYXXA5x6EtpDPc21wrxBaF0ZdoeA1YYyMj1OKFVtDrr0AIbR7zqIoHjgJ1uhea42zh1aq/ZKue5TSGfc7e1a0nVWl4XgRQSMj5vmBwR64J7/Q2MCJ6CtlC060Fj6rR5po6jroVL5zHs2w5EEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813548; c=relaxed/simple;
	bh=YfWSGbEp3Ri5vampl4rizakqWYJxYDI1iUywls5D1TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QPw+jD5hbeSTo1Zi2f7pcAWL+1GuICY75ryilm4mnd2rPpApJgXfwuw9PQkfjGgbnzDrDIYkXi5O9AkGIyMYwSebk+26SexgTHTvhlJDXgJNByQb9Hjw+5ETzzpAaaG2JNgFf4mw7MGTzZMjQy29Zlw4LIs87fPvzN0I+JD+sus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNcOPW6X; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNcOPW6X"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b249541063so42247305ad.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813546; x=1777418346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzFNL3zJHiQW2Vbyq91237YpRLX6Z7YBrHD5R7EMXmY=;
        b=gNcOPW6XuAwnGlPCGvTAVzswebAL7Dt0ebJoQye+2ZWDxK4arDOLu1R0X7fxBiRIq0
         rjDkA/uvqLpTt+Ae7V6R2tqNoDLvNie9AzR1fEJC+YFU0npqeyiPULOAhHh05+i4QsA0
         IpIPByJ+XcqVPQa02ouy16KpKLYiWcFWYCQGaEGMwShfSacnphFoqDrw0cFUet3AlZQt
         DEncMjytLqP9Z5z3pNaxStFnjfvNUMZaCeoPpK9gmlhWiZQAX+c63deuwDo6tERNyqhA
         Tfnw05UvjNA+ytzfI7BQNYrs55AUHIeBDSFqPU1N2e3w6TaH8mOzDcKBkSMIlMYe7KOT
         NhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813546; x=1777418346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzFNL3zJHiQW2Vbyq91237YpRLX6Z7YBrHD5R7EMXmY=;
        b=iiRHTEiItArimsPj0Z6o2u5cdW4Ffjq8so6Cy4VSNHIVVeXPMPY1Xn+Mak/m8nHTzE
         JPnJPW4LcA9Sk0+CIookPKtFhlgy65AtCHQ9gh3Uz+egItgJUhd/q9pMLjWsH0Jd9o4k
         /KvrUzByUGOQ2AdVP+Xlkq8d/WEpRmfkjZs3dlVmJPRFOtGF+CrLDOJY9mVdpfb7lwv3
         zJtLf1CxQHljZwVA91faxu3iGB3ZpmvNDPsgI+XKOopzlWZLHjkV88ANVzDBVapTH8Zo
         aSV/dIJtHbxegj3x8Q6ODzPY/chadKSAlvDGFCGVxiUyNDA9fOpqIU0Qgy0EdTa0BdrJ
         GGSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8I7OFMBs4W+snkJrLPUmGV3wMZSaXii0HM74R8kuiOlmjIdOySp16w6dIRhEu/B1p4NH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTvzzu/WeWrjeFBHHhi7GB/EeF+dM7lwnEMYyBRTvVoPTHHCmD
	6IPl2m0G0CcuGJjocluFisRJaUtK/ePY/3avLHnC/Jh6YioWwTZ/mbf865zhrDeAqUCUgpzskOl
	B14PTzQ==
X-Received: from plu17.prod.google.com ([2002:a17:903:3691:b0:2ae:39ef:fd8a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c9c4:b0:2b2:712c:61be
 with SMTP id d9443c01a7336-2b5f9ed0b48mr140812005ad.18.1776813545519; Tue, 21
 Apr 2026 16:19:05 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:19:03 -0700
In-Reply-To: <aegDJssx-ZvbfggI@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
Message-ID: <aegF59gToidudIUC@google.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
> > boilerplate at call sites.
> > 
> > __kvm_vcpu_map() still takes a gfn_t because guest page mapping is
> > fundamentally GFN-based.
> > 
> > No functional change intended.
> > 
> > Compile-tested on x86 and ppc, which are the current users of these
> > interfaces.
> > 
> > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > ---
> 
> I was going to suggest a WARN in kvm_vcpu_map() and
> kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but Sean
> usually hates my paranoid WARN suggestions.

Heh, for good reason.  Adding such a WARN would be triggered by this code:

                if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, map)) {
                        vmx->nested.pi_desc =
                                (struct pi_desc *)(((void *)map->hva) +
                                offset_in_page(vmcs12->posted_intr_desc_addr));

The PI descriptor only needs to be 64-bit aligned, not page-aligned.
