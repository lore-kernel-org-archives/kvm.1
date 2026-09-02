Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2EC4A92F3
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364245; cv=none; b=c9b39gxGRF4xRF+9vtoriA5O9WN21C/00bdeW/s0HZRQEr6p3TtuFf2pC2QzNnb7aX9bbwZeCANng4vt3HhmSb6J9xBVC67o5dMHCosgGfx3nQHCByNLv/LOcOoYYqnFu9rb26u9apEiNFHX5BUUfOagjGiY3VsUNVapTFOfgus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364245; c=relaxed/simple;
	bh=x/aSspVi1izw2ohQt29OQIs4Z647EroW5SPSwlyZz80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qhKtlUSyhKBEgenvuT/y6X/c+ZRjaJdnvNqOdAROxW9vtBXBNXzpRstfzNcAtwWmP8biRfWU2SLH5MIKkxA7uUsyBBxHbx7S0fkirO9Uv6wAoNWlAyVsHunNfzbm20mUIIvJjEzBIhSJtC+0YjmM83MNHLW4pzpI9zsCiRcc418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyZC6T/L; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyZC6T/L"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1cade6b71so13276a12.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788364242; x=1788969042; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2atBUez5/3AnWCQ3IY6Ohn5PAS7hQON2CkUYdFYqUoU=;
        b=PyZC6T/LQtiadLBf3zv8wSlRiingp+XWfEoQTB5Ct0FiAEYY21mNcg2a9nb1QrVVww
         dXYQg2SKiKYFEoBeVxLVhlaHBgNiYdEcLe4RK5mZFQNW0te78CvsndhPQ/eOAktA9lrZ
         vfzDe+rhHDt50oUagkKTXegnv4+Z8AN4IyV6x+t365miWB3Gv+U94Y/4Mp/EdsQIemiS
         j2A/n2cTlTBcesT1+r2CGy43t9pyE5R+Gc0UFygeGiXRg6FX1I743wjRPI1ImVf05E+9
         e3K2g/9Yl79P0GxEauN41BVa2BQ2xy9SB8cVq7X/g9rrGzDFKRgJMpUzLvrQZNDgp7TY
         14Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364242; x=1788969042;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2atBUez5/3AnWCQ3IY6Ohn5PAS7hQON2CkUYdFYqUoU=;
        b=PN+KgP96C/zAnj1ICvTdPnHgQJD20Vx8leeSvDVWeU+x6azo6exM5FmacArm83/lmi
         dm34yTMS7MjUQiKIVyTRMpEFb4bOGkZZkgyOTzq9KLDGpo5eGjoKRzQwsC9iHIOI3luU
         Y+vGM+blgncZ6pAbNWpEAfncmt+U2rGSoZFWBIT+OVJpyV86/UE9gYsvZi/fD0MSPe4V
         l4nXdiLzUGGqWRk5wUoHFz/lXiSs3ynI607wlbtykc+gWEgkXNNZzKGhkDq7074dSnWL
         RgxJNa8ZEjPvc9/LP4jqPn/ixTitTs3v7nOIULG2C+7utfqD892TNvCVpqemGuJhnQ+9
         UB2g==
X-Forwarded-Encrypted: i=1; AKwUvBzIVOu9zyZi8poM/cjHmslJk7tLCmAfNOHcRPdtdqDa6pCeytARv/GnBtabxQGnK5mY8fo=@vger.kernel.org
X-Gm-Message-State: AFuF++lFNpVr2EX8J57T+7YMuEVz0aISo3X5VAoUcY7dRtYx2RNuUXFS
	I/W8gEp3rVM3sDdM1EbHzHeQfoSt13GLjswU6vZFpcuPjJehXt/XcSSNs7tE2fxoJ8PPkByaj+M
	TCcZXww==
X-Received: from pgp19-n2.prod.google.com ([2002:a05:6a02:62d3:20b0:cc4:337d:af34])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1449:b0:3d3:aed2:6f29
 with SMTP id adf61e73a8af0-3da2168db67mr89360637.29.1788364242090; Wed, 02
 Sep 2026 08:50:42 -0700 (PDT)
Date: Wed, 2 Sep 2026 08:50:41 -0700
In-Reply-To: <apgeAJKF--dZvKvF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-4-seiden@linux.ibm.com>
 <apdwHcdy2iYRTrww@google.com> <87ik4om4x2.wl-maz@kernel.org>
 <20260902091351.438647-B-seiden@linux.ibm.com> <apgeAJKF--dZvKvF@google.com>
Message-ID: <aphF0ewDGuZxsrJz@google.com>
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

On Wed, Sep 02, 2026, Sean Christopherson wrote:
> On Wed, Sep 02, 2026, Steffen Eiden wrote:
> > On Wed, Sep 02, 2026 at 09:30:17AM +0100, Marc Zyngier wrote:
> > > On Wed, 02 Sep 2026 01:38:53 +0100,
> > > Sean Christopherson <seanjc@google.com> wrote:
> > > > 
> > > > On Mon, Aug 31, 2026, Steffen Eiden wrote:
> > > > > Only defining KVM_MMIO is not flexible enough for multi-KVM systems
> > > > > where one KVM implements MMIO but others do not. Solve this by
> > > > > additionally testing for the non-existence of KVM_NO_MMIO before
> > > > > including MMIO code to KVM.
> > > > 
> > > > Ewwwww.  IIUC, s390 ends up with two KVM modules, i.e. there really are two different
> > > > KVMs being built.  Rather than have a KVM_MMIO and NO_KVM_MMIO, I vote very
> > > > strongly to drop CONFIG_KVM_MMIO entirely and replace it with __KVM_HAVE_ARCH_MMIO,
> > > > a la __KVM_HAVE_ARCH_VM_FREE and others.  Tracking two separate macros is going
> > > > to be annoying to maintain, and will definitely be confusing for non-s390 people.
> > > > 
> > > > It'll mean linking in an emtpy coalesced_mmio.o on s390 when building without arm64
> > > > support, but I'm guessing that won't be at all common for s390 builds.
> > > > 
> > > 
> > > I ended-up doing something very similar locally, because I couldn't
> > > really make head or tail of the logic while being in holiday mode
> > > (which doesn't help). However, I kept the negative logic, so that we
> > > don't need to add anything to any architecture but S390 (they are the
> > > odd one out here).
> > negative makes sense. 
> 
> Ya, an opt-out for s390 works for me.

Actually, I have a better idea.  I'll explain more in the subthread about tracepoints.
