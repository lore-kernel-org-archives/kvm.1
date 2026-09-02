Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311349B1E2
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354051; cv=none; b=DrZnPOVGvS1wdhRSowPN8mP4uAO6Qkg1sm71BkTHWJMYHeIr4bYfBawU+O+1kfv6dTe6BtGpQzDSkhLIQDTcvsW0iLtNTuOymwx5DvTaFvCqJsLjujBnmykzOU65cfM6E8i+sCIZ2AX2um5KyiGQOIw7x/y8fXqbePqM/7TilOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354051; c=relaxed/simple;
	bh=vMETqGmsLv+O1ZisrqmhUsbiFFXLQKrBrDQkabWILoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tmi7wyCGMDnD3VRGtDRtOWrD7wcAwja76Ih2FD677B/VNJihZA3nMY//WsckR5V++x7yDovp9b+0Z8BFLdPxkhL0viA/ieCoz/8ZGCAP4giA8l0wG11UJCkqK0EG59Jf0l/vi8jwOQaqZs3R9rsEUAZHgudbnO7V8g8tsjn1BmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3QVmVyP; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3QVmVyP"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so1566959a12.2
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788354050; x=1788958850; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VNGwYj2t4glIGNOen6FjZQq8vvtMMzT1HX41CF0kxhE=;
        b=n3QVmVyPqaNvPfltqGhv/gYU7NG9CkGCh5RimxzCuq2KgnDmrZBfBmCU7RYV5UxNSb
         9PVWZF3LrqcCNili++kIyaNVXs88WpDIvBYdoK4zWS3P91/yOnCHsTFiwe7DcKo5N5MG
         WCA3ZsTwHol8spgomiHR98OgJuSmE7J+dCU3pLEqmSHCIK5lTX6eZIX+xeXg/aInlttM
         ERgAz9Ci160R6SefgWqrnA2TWnqx5XWE8i9P0XlFCDqbeXT9SHBmXyBRGq8qoFqBJbgn
         tDvToSj7Uee4UpUAcPS+YYCHUCjRZnTLXDWynbuajy7uPrqAAgKKzxyArSuVu0FFnB0A
         VO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788354050; x=1788958850;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VNGwYj2t4glIGNOen6FjZQq8vvtMMzT1HX41CF0kxhE=;
        b=Y+onN9R3Pwihy+WlKkdAH6s6jo/TtX3wNCjp2RSC4wrO4jUhAfl7YbD5Le+1B5WgD8
         rgF2uzq8S9mhqbV1zuae2I71MGphU15NCU+KEUl8A11j12Uiy7rdsk5ooJ3cJ97P0mSU
         Ir9U3XAYpwmyemvgvlpLLSUXXLLaYpReMuJk7ZLWcAl9N4f3yUCOOJHMl4K2gUhr8hAk
         5az2Pmv9X4BMqAkzAVzQqmtuTFxoPizZbe8a9F/yjkWoop6gCZpirbkpHzvlxJzEwCYR
         SusIQuqdBLELHVL9yLnYzHwkAJ/y9E6PhbMohH6UqD7K0aHtSVLMjVpWPcJ8ovkbmvfg
         W7Pg==
X-Forwarded-Encrypted: i=1; AHgh+RqXQKMR7yuwms+8j9KBf9M4knUEN94BMvTCCfO8t3O7lxCRxbh2yw0TP6f0V1XLVwxcEik=@vger.kernel.org
X-Gm-Message-State: AFuF++nnCE8yTa9ezNKTA0qoBbmXu3hY+TyBTyvGFVc/5KTGm0pPnR9/
	DEQ2JyRaer1pPyUYdoN3J28hCw1Chu8CnZbBObnF/knLpICkx4in53p690qZyjh8iK4T56iJ6s4
	BB0L/qQ==
X-Received: from pgdo11-n1.prod.google.com ([2002:a05:6a02:620b:10b0:cc1:5155:bdd1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9151:b0:3d3:b02a:7252
 with SMTP id adf61e73a8af0-3d9b0f39b5emr5405095637.28.1788354049347; Wed, 02
 Sep 2026 06:00:49 -0700 (PDT)
Date: Wed, 2 Sep 2026 06:00:48 -0700
In-Reply-To: <20260902091351.438647-B-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-4-seiden@linux.ibm.com>
 <apdwHcdy2iYRTrww@google.com> <87ik4om4x2.wl-maz@kernel.org> <20260902091351.438647-B-seiden@linux.ibm.com>
Message-ID: <apgeAJKF--dZvKvF@google.com>
Subject: Re: [PATCH v7 03/23] KVM: Allow KVM implementations to switch off
 MMIO independent of Kconfig
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, Steffen Eiden wrote:
> On Wed, Sep 02, 2026 at 09:30:17AM +0100, Marc Zyngier wrote:
> > On Wed, 02 Sep 2026 01:38:53 +0100,
> > Sean Christopherson <seanjc@google.com> wrote:
> > > 
> > > On Mon, Aug 31, 2026, Steffen Eiden wrote:
> > > > Only defining KVM_MMIO is not flexible enough for multi-KVM systems
> > > > where one KVM implements MMIO but others do not. Solve this by
> > > > additionally testing for the non-existence of KVM_NO_MMIO before
> > > > including MMIO code to KVM.
> > > 
> > > Ewwwww.  IIUC, s390 ends up with two KVM modules, i.e. there really are two different
> > > KVMs being built.  Rather than have a KVM_MMIO and NO_KVM_MMIO, I vote very
> > > strongly to drop CONFIG_KVM_MMIO entirely and replace it with __KVM_HAVE_ARCH_MMIO,
> > > a la __KVM_HAVE_ARCH_VM_FREE and others.  Tracking two separate macros is going
> > > to be annoying to maintain, and will definitely be confusing for non-s390 people.
> > > 
> > > It'll mean linking in an emtpy coalesced_mmio.o on s390 when building without arm64
> > > support, but I'm guessing that won't be at all common for s390 builds.
> > > 
> > 
> > I ended-up doing something very similar locally, because I couldn't
> > really make head or tail of the logic while being in holiday mode
> > (which doesn't help). However, I kept the negative logic, so that we
> > don't need to add anything to any architecture but S390 (they are the
> > odd one out here).
> negative makes sense. 

Ya, an opt-out for s390 works for me.

> IIRC KVM/power does select KVM_MMIO most of the times but not always.
> I'll check that.

Huh, indeed.  KVM_BOOK3S_64_HV=y && KVM_BOOK3S_64_PR=n ends up with KVM_MMIO=n.
Though I'm not surprised given the multitude of variants PPC has.
