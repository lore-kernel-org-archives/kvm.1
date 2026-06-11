Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5BBA45
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781136263; cv=none; b=jn2ifs19Q1Sh3f5j1hctQmrtN7AZyMSBR4Qwj/MR0/TL5d+l+oMiwMJ60CLs9PU/wEWWSGzrBiKuzvqLckHz+oW/6QC9zy9H7elkou1Z9wdr5MMMBNLR9jJ1uGsxL7bPj63zbh5M0kZ/nLmjXLGPj3uaM71sgvddoo2wnIEsYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781136263; c=relaxed/simple;
	bh=k16BFMFuWnffR2W4m5q6+452K4IrrHfQsWZ43V8QZV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxXcELEnTp5tqSfp3e/pRFQnWEJISrMibA4ZciiTTgFJD2daz26+328EQDH99dvqQ6N8FNccSu6cxSxh3UZr7VdD+eIfZOMnQkffH4kbcvmRc7MWueCq7SHkZkQVCEhEALRarNS58SYiTl0+3DecsDhKgMIwafrF77/QjqiGrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYVzcqUJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYVzcqUJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b828c8so9887683a91.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781136262; x=1781741062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAagoI590NRsHfaC6ZKFCTRhTqsBID3sOd7ryKQqams=;
        b=lYVzcqUJkcyAgd3J37otrXlqcDML2O6nJm6adiHrezZUVe3lQjRFCRc95FMoFd98x7
         dQi1H4Co2Eg2thd1COHwgnr54Oou23u33WRARxk2Xf1dPNnTcEocHqFh8Uin66+AWA6k
         cKtUcYGbLlQaigb3Bq+h7LXDnHBuPPzE+qzzbNRYbLs1Bk66fC6/+xAgP//7HUM565AS
         vetAYyLwZtcx+RiW4c6Sb848v6DfsaCgtQjpe0pUw7GjM9hd/IsTfdHF/PwXz8Dttlm2
         4O1jy4dVCW8PCh1tYW9eWXLQhneABn3o7jIi0E3BoDuGBkKROFT9x+FGKuZARZ7fmq3I
         vmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781136262; x=1781741062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAagoI590NRsHfaC6ZKFCTRhTqsBID3sOd7ryKQqams=;
        b=T17W7v4e8/G/dGIsgKecZ/lr3itqVDN/x/Wdm4Jk9j7KA0JoI4t+IdZf3oxxmtVtOf
         5ymys9j0HCVOj27yRgr4S+Pqbhu8otBk2pBBtTt2MwVOsD56p5Ab9cjMh24FikApIMOj
         OwSyw1SfOhS3docryN+sMRzz8yXzdb1wYFsGj4e5p4caWOrreSvi5QR7E9t/1yndEcM/
         GOLldw8NzfevMGVFxuEWxEOmjWzKY4w3prGpl+XR7O5tnIjQdMbHnEPFtstJcVzilhGl
         1pe4Oa0ScqLw+0K2dY7ayHxE/1CYeA/KKvHc5psLA9vLV+m4isgMVHMFgoG/M6EoupKC
         mQKA==
X-Forwarded-Encrypted: i=1; AFNElJ/CdkOhJJkULvTQQA6HjQVc1BW69rlb0p6r2zfmVzcZHgd+j2tQrb77GSNUUE267VUwt1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXS2Cu//E66Hddn2ZkVsJK6B5VmLm+HmjIiy+9I2lnHnKiRwSs
	8QWuy0uFNVwyzwQbUmf2fE8kBtyouuXUnhf+0FzQyBmY+/sl6FECdUO5fb+DlT1TKEMvATXuct0
	tDSSXDQ==
X-Received: from pjaa15.prod.google.com ([2002:a17:90a:8f:b0:36b:d415:c531])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c0f:b0:36b:9c4a:e05d
 with SMTP id 98e67ed59e1d1-377a8dbbd07mr520543a91.17.1781136261604; Wed, 10
 Jun 2026 17:04:21 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:04:21 -0700
In-Reply-To: <5230F158-B766-4BDD-8D94-FFE6AA46BF8C@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610070512.85463-1-m18700951735@163.com> <ailce3eU59J4bv6x@google.com>
 <5230F158-B766-4BDD-8D94-FFE6AA46BF8C@163.com>
Message-ID: <ain7hUsLC2VSlkP6@google.com>
Subject: Re: [PATCH] KVM: SVM: Clear dummy V_IRQ in vmcb01 when deactivating AVIC
From: Sean Christopherson <seanjc@google.com>
To: xinguo <m18700951735@163.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 11, 2026, xinguo wrote:
> Fair point, my changelog reasoning is incomplete and I owe you data
> rather than speculation.

Oh, I'm not doubting that there is a bug, I just don't think that purging V_IRQ
when AVIC is disabled is the right fix.

> What I actually trigger is a workload that repeatedly toggles AVIC
> on and off, i.e. avic_activate_vmcb() / avic_deactivate_vmcb() get
> called many times in quick succession.  Under that load the Windows
> guest blue screens with STATUS_INTEGER_DIVIDE_BY_ZERO.

What kernel version are you using?  And do you happen to know what exactly is
causing AVIC to be (un)inhibited?  I ask because these commits that are landing
in 7.1 might be relevant:

  fa78a514d632ed2428b7c573108d9658c00d536e KVM: Isolate apicv_update_lock and apicv_nr_irq_window_req in a cacheline
  5617dddcfa30129562d7028ec766797d8c345f36 KVM: SVM: Optimize IRQ window inhibit handling
  6563ddadd169cc6f509a75b3ff8354309dcb9080 KVM: SVM: Fix IRQ window inhibit handling across multiple vCPUs
  7b402ec851cb66e73ee35913c7d802bba820086b KVM: SVM: Fix clearing IRQ window inhibit with nested guests

> From the dump, Windows takes the bugcheck while dispatching an
> interrupt: an unhandled #DE is raised inside the interrupt dispatch
> path and ultimately reported by nt!KiInterruptHandler.  The faulting
> RIP saved in the trap frame is:
> 
> 	je   nt!KiInterruptSubDispatchNoLockNoEtw+0xd5
> 
> which is a conditional branch, not a div/idiv.  In other words, the
> guest is being vectored through IDT entry 0 (#DE) at an instruction
> boundary that has nothing to do with division, which is consistent
> with the CPU delivering vector 0 from KVM rather than the guest
> actually executing a faulting div.  That is what made me suspect a
> stale dummy V_IRQ (vector=0, V_IRQ=1) becoming effective once AVIC
> is disabled.
> 
> I agree this needs to be backed by traces, not just by that
> hypothesis.  Let me instrument svm_set_vintr(), svm_clear_vintr(),
> the intercept-recalc paths, and avic_deactivate_vmcb() to capture
> vmcb01's int_ctl / int_vector / INTERCEPT_VINTR / is_guest_mode()
> at each transition, reproduce the crash, and come back with the
> actual call sequence that leaves vmcb01 in a state where V_IRQ
> becomes effective once AVIC is disabled.
> 
> Please hold off on this patch in the meantime; I'll resend (or drop
> it) based on what the trace shows.
