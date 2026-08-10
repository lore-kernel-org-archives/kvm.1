Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABE41CB5E
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379769; cv=none; b=mplef+t/I7ybGz708lzNc2xL0gIcqo8EYF/Mh94A2shSlqHpNnOBpXWT2ip7ajhVmMpWC3w3oBBgZok1YIwO6cUcykXnS5Xk74ORZoisUh2ZfKOkP7IP6TYzSq9J1ZnvkMEDmAmrDbAKsTv6+tjemns85O3x2/RpwJz2KrzPcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379769; c=relaxed/simple;
	bh=UYFmrHoKtDWA2aQ1qnVNWRDXLNp/XAbJM4t5IWIuVYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uiQJrQcHxltxlNCwanYiAWUNySXJRfsFw4qSbdON9L06wN4d8D2L55S++gxXva72FC/22Eru7+YbAOf2rW4twTT7LoJ+q2eTi+UEFJ0LTsY2EMWzYmbg8eBCjjYz7NgrP/kzVpVm7w89np1+rTRjZy1TJk8ofzZUsy2nijHtGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CbE3ku+1; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbE3ku+1"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc88e22f92so53167415ad.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786379767; x=1786984567; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lRMQd0SPOAoztEBxOxylxHyAxYOMklYuLFXSrpeNZY=;
        b=CbE3ku+1YXRw99uvrkdD0XXNlu8DWL7gPhhie9xDAkAnwjf+1JRkVkw+nlPeyqRmAB
         QwpnHFX7FByj+at7VG+TKmUtJ83tkjEg80u7if2TEkhds6+9I8krqPgSDr6lfrawmUMG
         0GWYxlDigaNnKItTviegO06ijnBcZAVkdpnPjMA4XSlV8WfqCTxA2BBsTT1ah5LU/LDo
         jIJ10QiXCkDj8jNdV4T3MHLUMgURfenrBrV73cxnWxtYGIRyVZVZutBYbKlAg1YIaeKw
         xZNDgqxvyweaF6yeTPP2TdRkuIt9ts0ehsJEjziCahZHZDZLK39CTmquvrVAjGqzVsIW
         oEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379767; x=1786984567;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lRMQd0SPOAoztEBxOxylxHyAxYOMklYuLFXSrpeNZY=;
        b=ZXNbvy5Ce7bBgqIAdWDCehmgBrHWbkw6D242MRZkvT21IgShFopT5GYXHB9287Pywj
         CdgOHLzfXMmfNgfa4BQauQVdjYAxrCQhISWBOjhrhbSJb67vgeqyLBMWVR40H0oH3Bjr
         Rn78WmjeaQmJ+nKC4PucR9pJCop3BmnZLRw8SGVMfyOHItzrlqx1QHZZOuwtpOt47hyr
         QVJeNnBsdq8n3yy+/65eMNF2p9YQKksTh9jAvEfwcYj/U8J7L0plFumQJ9k6EFOCsaO0
         3n65ByRFfqiJxqpHwOKIzT4XHf8FrJB5eTsXz0vggWRpKGIHJGDgVQu/Q305XTPERxbU
         x07w==
X-Gm-Message-State: AOJu0Yy1hTnznCXIN/xUiAY1kDKYWGg7PWSSfBv1x9baKHWjcweJNxM8
	rKp4bBR+xpaqlfsEK1MVn3eVvP8Lo6GzjY/865fuVd9enJgrOUdP+pVA4QBrJIhiaP578dw/YYg
	BU26BDg==
X-Received: from plbh22.prod.google.com ([2002:a17:902:eed6:b0:2ca:d209:8089])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fda3:b0:2ca:ecf6:910e
 with SMTP id d9443c01a7336-2d2ffa72f8emr39181145ad.0.1786379766926; Mon, 10
 Aug 2026 09:36:06 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:36:06 -0700
In-Reply-To: <178611991391.356691.13642495513205529979.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804210046.3413149-1-seanjc@google.com> <178611991391.356691.13642495513205529979.b4-ty@google.com>
Message-ID: <ann99kPLL6xjAxx7@google.com>
Subject: Re: [PATCH v3 0/2] KVM: selftests: Reduce PMC test runtime by ~17x
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 07, 2026, Sean Christopherson wrote:
> On Tue, 04 Aug 2026 14:00:44 -0700, Sean Christopherson wrote:
> > Reduce the runtime of the PMU counters test on an Emerald Rapids system from
> > ~85 seconds to ~5 seconds by (a) testing one random GP counter in the arch
> > events test instead of every GP counter and (b) creating one large VM per
> > "major" test and then running each subtest with a different vCPUs, versus
> > creating a new single-vCPU VM for every subtest.
> > 
> > AFAICT, there aren't any bugs anywhere in the VM creation flow, there's just
> > a lot of work to be done.  And VM creation isn't even that slow, but creating
> > something like 1000+ VMs for the test adds up.
> > 
> > [...]
> 
> Applied to kvm-x86 selftests2, thanks!
> 
> [1/2] KVM: selftests: Test one random GP counter in PMU arch events testcase
>       https://github.com/kvm-x86/linux/commit/a53d1602e3bf
> [2/2] KVM: selftests: Create one VM with many vCPUs for each major PMU counters test
>       https://github.com/kvm-x86/linux/commit/f6e01d4fa1e8

Squashed a fixup for patch 2.  I meant to drop the unused perf_capabilities param
reported by Sashiko, but forgot to do so when applying.  New hash:

[2/2] KVM: selftests: Create one VM with many vCPUs for each major PMU counters test
      https://github.com/kvm-x86/linux/commit/4fe8b4e1545a
