Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8844E56FD
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450518; cv=none; b=a3qOFGyoUMmKWbQj4KgUBtCG85HAEHex8IJwQzlo1cxdR5ZN5gGhIgtCtZzvEF9mrF0IjZaYs/JKNarGuuzPcMYyEW5TKvre/iZGDM/6y805mspx1+sj2qw72/g7mnFyCeulmmndrQGRG7VvgpJZ8eG7pTnaDVLTudpMCJ7aj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450518; c=relaxed/simple;
	bh=qKmRoYSbK4pggjfQTTrO8FbbOoauwacbfUdwqi26JN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cQVVevhSLbkam67jd4ZYEMuzkoJ/KDbkez2ECUceRuGfJScAzkH2GyFgf0cChgZUybgqV9mA+J0kzvOUXHBFtn6Oqs8LCaAukvq+/lcG7Rvk4Pk63BvT5LTbgznVPoszrqSCCbYJgnR1Sergwd11/vtMy4AjOZ1ZCgbH8E3aZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSEKNUit; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSEKNUit"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacd6d37edso34754715ad.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788450517; x=1789055317; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmHR9VMSgZvTyS5Rd9T+V8oik7z2Cr4I+UuO+iaoSDc=;
        b=dSEKNUitVPGXgu5NXqV/b4gRUizHj/nDbdrMqeQ1bUV1Sd91iJOG/ei6bu7zt2KMGM
         1lXEEPxyQ377bb/NqriW7/odVkHo6SchsNsSxm7+QKQB1gpSthXVFub2BzaHB5c93Jz6
         evE5nVPgubHZdv4aZLcYRiF37gzHCL2gq2+4plh2/2ghKBh4xy2l0EpbJoMa/SVgXXbQ
         QcNbxsb/gW2Yop0ZYbKf44iqiBCCFIDMxAdc1Q5Twndrgjfg4K1ko/82vPdTEwPTD9Ep
         W0ARJF+r0D6Ygox8dYozz1b4wK3Os0jKE1YLjnvucQi5OmG2mh/D5z4OAUF98KRZww/x
         Jd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450517; x=1789055317;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmHR9VMSgZvTyS5Rd9T+V8oik7z2Cr4I+UuO+iaoSDc=;
        b=EUoKYxVo5ObG8rwHGHZkZ630zh0dFPmghN1bJPWaFpfUtnyLFRuCzLJ/u1BVl09Bo3
         xE851eG69nd59qbki6copP0G1w0LF33z/qczgjITjB7PAei659EL5eckJZe2hBGtpdL9
         +lRPU/X+jRcacfgXzG1ATEDIdzApoh9Vk0wedTLt2PANZCNsPNyKf2swUTLQuoUz6fr/
         VfWRaqQLSCyniz6wWTnq44GNiNUufpPjhCXcXmWJWtGAoyJXHsm2JV+XcVE+IKOptG+m
         FBQA8gEWqOlLkDxLNX8gcaIoXc2pzLQk7W9UAQ8nHyvUrvqibUxFVGJR42xi3pwR6ttB
         gWpg==
X-Gm-Message-State: AFuF++kKvk63I2otFFzc1njsgInPRYQve/phbbvS6OHWNzUpUP2vKAEA
	pfG1KcXDRzwlJ2QbVb6gl4DYLVT6SK9rBU1egaKfjoPcoFYTHW8NZHX37Necvc+OtTf0QIRpab6
	9FUtdaQ==
X-Received: from plce19.prod.google.com ([2002:a17:902:f1d3:b0:2d9:2fc7:bb3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78c:b0:2c9:df1b:e948
 with SMTP id d9443c01a7336-2daec5dfa20mr199165855ad.4.1788450516176; Thu, 03
 Sep 2026 08:48:36 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:48:35 -0700
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
Message-ID: <apmW0xFe7zgzheGe@google.com>
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
> > On Wed, Sep 02, 2026, Steffen Eiden wrote:
> > > On Tue, Sep 01, 2026 at 05:40:25PM -0700, Sean Christopherson wrote:
> > > > On Mon, Aug 31, 2026, Steffen Eiden wrote:
> > > > > Allow KVM implementations to choose alternative device names. This is
> > > > > especially useful for architectures providing multiple KVM
> > > > > implementations simultaneously. Architectures providing multiple KVM
> > > > > implementations must compile the KVM common code once per
> > > > > implementation and mange symbols.
> > > > 
> > > > What about tracepoints?  Or do those show up as "kvm" and "kvm-arm64"?
> > > 
> > > Yes, I want them to show up as kvm and  kvm-arm64.
> > > 
> > > Thanks for pointing that out - I just noticed that I forgot to switch
> > > the trace system to kvm-arm64 for the common tracepoints in
> > > trace/events/kvm.h
> > > I only did it for the arch-local traces in PATCH 21.
> > > 
> > > I would just do the following:
> > > 
> > > diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
> > > index b282e3a86769..5d4f8a0693a3 100644
> > > --- a/include/trace/events/kvm.h
> > > +++ b/include/trace/events/kvm.h
> > > @@ -5,7 +5,11 @@
> > >  #include <linux/tracepoint.h>
> > > 
> > >  #undef TRACE_SYSTEM
> > > +#ifdef KVM_S390_ARM64
> > 
> > Side topic, I recommend choosing a macro name that doesn't have a near-collision
> > with CONFIG_KVM_S390_ARM64.  This *looks* like a typo, i.e. it looks like you
> > forgot the CONFIG_ prefix.  Especially since the macro is defined in the Makefile
> > and won't show up with e.g. "git grep -w KVM_S390_ARM64". E.g. KVM_S390_BUILD_ARM64
> > or something?
> 
> Interesting. The name was deliberately chosen to be similar. But I
> see that it could be confusing.
> 
> I am not totally happy with KVM_S390_BUILD_ARM64 but I cannot find a
> better name either.

Y'all need to pick *one* method.  KVM_S390_MANAGES_S390_GUEST was already added
by a07276d5d188 ("KVM: s390: gmap: Make storage keys optional"), and then this
series effectively adds another macro to provide the inversion of that, except
they're not even tied together.
