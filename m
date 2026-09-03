Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA003290C2
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445845; cv=none; b=TppGt1ixuDNIB5fVBBxe14RBL8MNDkMoij93dUhQSM8gp1u/oI7FAvX+M1euCIDIc6OnQaCpLqrNec67QewzizpxA+FRTE6yshKlClTFUr7dahZ0RfFxL/pYk3L2UEsDHsk7mdEOK4yR7kYzdH8QrbCSK324E4NWdwTYm+hc1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445845; c=relaxed/simple;
	bh=nqFrkxbwZnIGD0jt6PBMdWC/YYiKHoC8Dbvm0EmPTSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BYljwcqxEcIS9t5SlKWMCn2qpPet1ZiBN7evGloS7duWW33G6fosYzJaYRKOu+CfaXCVy5g+istq5WAgtCHEEHQ+K97LPOLJE+XyGt/ABIIcFZpUSHemXgXr75ihPuHnbqY9ldNF1klV3d9dWnq3fN+dV5l1xEPw4lpZaKNmYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTFRg1tT; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTFRg1tT"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485d853b08so205188b3a.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788445837; x=1789050637; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KU72ElW/WJuvWFFEt8qn0cRYWtv7/uUdQgw0J+lE/vo=;
        b=LTFRg1tTdsTxAzBabBRjIWOvV1FKMSeCKNg8WlA7IdHkRXijCYXbMVxF+gTN3KU0Gl
         FPSidD1OqgUvWq4wBSdHh/EkXqmYHjf2YRg5eR/kIGNku5L3HJ3GdBo9/ke7VvvIg1/v
         0u+jKiM1XkCyONYdstSnMRXf3nKR2UTBFcjgOaQuDEhP1h1FsFBpYm65FvRg1DB8bT/d
         VVbWsnkVcVXufD9wZ89z5a0T8j3PbBfi/PLiMtxyyyRNJXAYRI4vGcCbq1K/jjxIRWPt
         nHFkR25kHZcc7O0jEsLbwpIb4rAkVbCFhTCygsCPHLEhX0zBoqMOXAafuCm6JDAa+URZ
         5fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445837; x=1789050637;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KU72ElW/WJuvWFFEt8qn0cRYWtv7/uUdQgw0J+lE/vo=;
        b=cvg9yVHc3FycS/EeZYWcmwpoy5ARuGKGFDmRBgJbSlqLUw/rpHJKwPpmhpOQ0w8R1k
         0ZrRK6a2Hgoq0J9xVUbASB2HlQ2jARtKpNyDx1R4dWhoXecL25GxX1pHRx+EflSrY1Fc
         uZhSCn9cEw8tvK6oVGyOuDZEQjZSLe5UvyYKbEUQcVTJOJgvIRE8QB/lYQDhyxCGv+wJ
         bq1KI/jHzOLZ7scPajESQAL1Atg2ajdHlpaziERB59PaV+81NH8gRnsilMtu3qevl04M
         I7jy4ffpTSw+6p18CPxeub15tlNAtGHsQvBauczXVwJ/R5yBKCdMy7WKApmaxlFZazLm
         KQiA==
X-Gm-Message-State: AFuF++np7DVhyAgQJ4LXCiC68khHikubzJUqky6kLwBRBYlJvzIpT/HJ
	riS+j0n35R5a+20SWSXp8O/VudHf5gzVaZ42o/VVLxMA7dbTCwUWAlK0TnG4IAErGY+RGCa+/+o
	Wuepjqw==
X-Received: from pfll28.prod.google.com ([2002:a05:6a00:159c:b0:84d:f9cf:1f3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4106:b0:847:8449:2ba6
 with SMTP id d2e1a72fcca58-85ed23def83mr20907159b3a.8.1788445836362; Thu, 03
 Sep 2026 07:30:36 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:30:35 -0700
In-Reply-To: <20260903114241.33034-C-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-3-seiden@linux.ibm.com>
 <apdweRfqt4dTxcU9@google.com> <20260902075028.231001-D-seiden@linux.ibm.com>
 <aphLXQL1H2zYZgTi@google.com> <20260903114241.33034-C-seiden@linux.ibm.com>
Message-ID: <apmEi1NmOUvmUBFP@google.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 03, 2026, Steffen Eiden wrote:
> On Wed, Sep 02, 2026 at 09:14:21AM -0700, Sean Christopherson wrote:
> > And taking things a few steps further, we can solve the MMIO issue in a more
> > elegant way, and eliminate the runtime string building in this patch (after looking
> > more closely, that code needs to be jettisoned no matter what, there's simply no
> > reason to specify the names at runtime since they're separate compilation units).
> > 
> > Rather than splatter #defines throughout header files, deal with the bulk of the
> > pain in Makefile.kvm.  By feeding conditionals into Makefile.kvm, the s390+arm64
> > build can easily omit coalesced_mmio.o and async_pf.o, define __KVM_HAVE_ARCH_MMIO
> > programatically without having to change other architectures, and solve the naming
> > stuff.
> 
> Yes, this is a great idea. Thank you. I second you, this looks more clean
> and stable than the stuff we came up with :) 

Looking more at arch/s390/kvm/Kconfig and virt/kvm/Kconfig, we might need/want to
to build out infrastructure to handle this sort of thing in a more generic fashion?

Which probably isn't that much infrastructure?  It's more just changing how arch
code communicates with common KVM?  I.e. instead of providing boolean configs in
virt/kvm/Kconfig, formalize communicating HAVE-type macros through the Makefile.
That might even be a net positive in the long run, as it will make it easier to
provide defaults for the common cases.

I say that because unless there's magic I'm unaware of these Kconfigs also needs
to be configured per-KVM, not per-kernel:

  - KVM_MMU_LOCKLESS_AGING, otherwise aging on arm64 will unintentionally be done
    outside of mmu_lock.

  - KVM_GENERIC_PRE_FAULT_MEMORY, so that arm64 doesn't need to provide a stub
    for something it doesn't support

  - HAVE_KVM_MSI, because presumably it's needed for arm64 support.

  - HAVE_KVM_READONLY_MEM, same story as HAVE_KVM_MSI.

Which isn't _that_ many knobs, but add in KVM_MMIO, KVM_ASYNC_PF, and
KVM_ASYNC_PF_SYNC, and it's enough that I think we should think about the big
picture and not play whack-a-mole.

Actually, thinking about this more, what I've proposed here, plus the pattern of
#define-ing macros in arch-specific kvm_host.h files, should suffice.  For things
like __KVM_HAVE_ARCH_VM_FREE, it absolutely makes sense to #define the macro in
kvm_host.h since it's very directly tied to an arch callback.  Whereas with KVM_MIO
and KVM_ASYNC_PF, because they enable compilation of C files, it makes sense to
define them in Makefiles.

So I think the "gap" is purely that the four knobs listed above need handling
(and arguably KVM_MMU_LOCKLESS_AGING is ok as-proposed).  But I do think we should
try our best to be more thoughtful than we usually are when deciding how to enable
common code, because obviously s390+arm64 is adding wrinkles no one has had to deal
with before.
