Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF0B43E4BA
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626765; cv=none; b=hMAkKOFv7NQ53g4eKWQt/nNNq1ORL12pQj+juYu4Yi5XxKSW6wg2JMbVdH52JSiLKWqJ4z6ak+hM+zyLW8sFl7ABNeFJtpU+RlJRwVXQXHPZWozXF2imVYhiQpMZGKG3yNB/mXuGJwW8k+aYYwEI2Jwt8PT1l8F/GnR4bH6YkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626765; c=relaxed/simple;
	bh=tPH+WRsy5SwraqWnhh28dvKm+INysH0yq5/S01S6nZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KKaFkFa4aFUBgVy2WoxO9PxkOQqJs/pgNqWVPV7VrvqB+bbhLxHQo6uGUBPc4uYM7lGPNm4aOV3mfGsK+NN8WPJQasYUVjny2UUPB5+ywYTzFY9T4pi/wDLnFNqJ0NT6XARyJNGW6hyE1tBU67EXAB8KQT8gL/paofjC+5yNrEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAJjUqdl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAJjUqdl"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso8473524a91.2
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781626764; x=1782231564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXAbDgyEZMHiNWK9p2PL3xdiINhXLiA968E1ozdg5N4=;
        b=sAJjUqdlltaHMLgahjISS55U5GQq1abANxbXbPIeDNy/0P/uG+u9onQ3njyb1p7Eqn
         WH9qWbTIxyqxn0S7q4CrF8NYD/w93o+qrYz+Ea5DGc1XQ2g1iM0HpTPxDj5lPc4wubQd
         SRKifuwWKsH5hCVykFew+9+g9SCX+kgGwDikAvjc1Mna1wFMvmv3brfzoEPF4wwBYTEK
         ZDiFjszzZ8UhODZnRmBM0eRASv17ycbTnnTPeVOAtAVa5rwIE7o+njLkWfim+6DMvhjO
         iTbZq3sooVy97I0WXOGoPFQX88+p4cOtmTM63LMYw+4js9QnhwdTxjT6wn5fLp7+EyY2
         /aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626764; x=1782231564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXAbDgyEZMHiNWK9p2PL3xdiINhXLiA968E1ozdg5N4=;
        b=S9N/uKbxS8V20yeyJ9swNvrFJvVm9mHxJNYgGmGZhILlht2NSssuVW3N7p2JZEM5MO
         7NO435c5bJ2dadLCD6vvzxlXeVrWPsUeQrT0XRTLZwZdd1nCmQfi7NC+PxGJmzym++GB
         SpRDdimBNU9/HdRks36rG7OyBJ3tHsvDkvmeg2Akv471uU38y+dFV6fIvwv0YSgDx6lF
         Xguxvtc4yARPZ0wE7Pr79MyXyBmvOTRCuA++rcFNb52SZWoHaB+E2Z5Q9S2ZkMVBKGSW
         d8q9wh7Hwj7iizUQ7ljH5lPxGvp8payZHqRzhNkTaeMLEbwWvfCBPde+QLvBQjvQhVqk
         3L2A==
X-Forwarded-Encrypted: i=1; AFNElJ/2KF2WXDJ9pY55nIzU2G1hO/rzfWUAJTVPJbhGUtZhvBhRx8tIvo+HNLLFrtmBjQ3tF18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmjW+dH7vwbA+gn+ioL7YWJgVrCDcRcY8t09l9tktA9kPyWM9
	7opDp+uUR/dY4RVeXzZQ62f1vXhrnL0cWq9hspih8u3yHnDW80KOQfhmMN/631WaS4ElpVuP67x
	cWBFv+g==
X-Received: from pjuw5.prod.google.com ([2002:a17:90a:d605:b0:36b:ba98:4e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d81:b0:36b:7f69:c152
 with SMTP id 98e67ed59e1d1-37c9391c8d4mr137487a91.18.1781626763569; Tue, 16
 Jun 2026 09:19:23 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:19:22 -0700
In-Reply-To: <b6721d022187966290f8ea04766ffb1268407ca1.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-19-seanjc@google.com>
 <906e9797-08d4-4ebe-aed3-34002aa1f917@linux.intel.com> <3be528f30351ae8744276107fe1060cb222077ca.camel@intel.com>
 <144cfc22-10fb-46db-a42e-f4ea8986d353@linux.intel.com> <b6721d022187966290f8ea04766ffb1268407ca1.camel@intel.com>
Message-ID: <ajF3il4nLemXBOle@google.com>
Subject: Re: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"yosry@kernel.org" <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 16, 2026, Kai Huang wrote:
> On Tue, 2026-06-16 at 15:43 +0800, Binbin Wu wrote:
> > > However, does moving the structure definition to "msrs.h" fix the problem?
> > 
> > Yes, it does.
> > 
> > Similar issue for struct kvm_x86_pmu_event_filter also could be resolved
> > by moving the structure definition to "pmu.h"
> 
> Thanks for confirming.  I think we should do this.

I really don't want to go that route, especially since there's absolutely no
reason to use srcu_dereference_check() during destruction.  KVM isn't actually
checking anything, and the (S)RCU pointers _must_ be protected during destruction,
otherwise use-after-free is all but guaranteed.

Unfortunately, every RCU macro I can find does typeof(*p) somewhere in its flow.
But I would still strongly prefer to open code a __force to strip the __rcu than
expose the structures outside of msrs.c and pmu.c.

This makes gcc8 and gcc9 happy on my end.  I'll squash the changes into their
respective patches, and update the changelogs.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 95b3bc7b449e..b3c180e16e29 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9975,13 +9975,13 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
        if (kvm->arch.created_mediated_pmu)
                perf_release_mediated_pmu();
        kvm_destroy_vcpus(kvm);
-       kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
+       kvm_free_msr_filter((void * __force)kvm->arch.msr_filter);
 #ifdef CONFIG_KVM_IOAPIC
        kvm_pic_destroy(kvm);
        kvm_ioapic_destroy(kvm);
 #endif
        kvfree(rcu_dereference_check(kvm->arch.apic_map, 1));
-       kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->srcu, 1));
+       kfree((void * __force)kvm->arch.pmu_event_filter);
        kvm_mmu_uninit_vm(kvm);
        kvm_page_track_cleanup(kvm);
        kvm_xen_destroy_vm(kvm);

