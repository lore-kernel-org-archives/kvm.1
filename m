Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9391DF261
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 00:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223971; cv=none; b=jpHV4+Mm28JQ3vZy+pEPD0MB5f45GcuoEFDx2/ae4nAVOd873J9xUoFSILZIBClko+n73i8+IrKZlp944C4XHkEIY0PYyYeDEbQnyqqZc5v1EuHQ+NX9QydE3BFKvZco54LO9BGqMnogLs9ejLVIOZKnqDvRQDZu+6h3YFlhk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223971; c=relaxed/simple;
	bh=MM2F5A0mC2yQl4blcZuiDI52PqLyDNFHHrq3s+npiAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R/INaHqI0vY6pBjFELzkJ67ZvC40C6iA/awWT89sbJ4ylkGQdpMLfSvcPiwPzJDnjuhJcAOPWLW4sls9Ns06xmYMlbxUx7pY0BI0EnRLBiCi1zBsh9ki0wSQ70FpXUn5cdKPIL/rLIbIl/SePN1nJDpsmpx07cw0RyUOQZ40D+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btKOfW01; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btKOfW01"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso5471713a91.2
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 17:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788223969; x=1788828769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+gjL0JYfUDhxDrumg1eHLE2TTMOQAAjlB1FcXj6jZVk=;
        b=btKOfW01LzBYdjZ3EBhg3r0PPf8hjfJvtgNV7Y9S4YQ4l9kx6IuZPZ3Q8xZeBM1vs+
         VcFSE248jPEp1eSOGdll6iWzghXl/Ns54PJqMxJfIborQaf5VB72K+7ucEbgvaaVbNr/
         B+K2n9OARttiQUoWSp1BAy1LUOpXhDo+9dDiiTt9OWsPNlbcY0AZ519IML/VJ+D8Odl5
         84WvtQvcqeTgg4IO7ciXe1ivk3c4DqYqONsjYAdM71wmG/pPlLRXeVAiEn2L4598E5X0
         3O6BwmvnAzMY/mABNp0qgA/Kv3GiMKC66a3hAHPxYgBD4gj1kpFBvSotkXYyvFyLLjlD
         xS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788223969; x=1788828769;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gjL0JYfUDhxDrumg1eHLE2TTMOQAAjlB1FcXj6jZVk=;
        b=OrsD/XTqhXDkLMrAkTZ9veLum2okGB/OKhyvkl510VgiNfdbxOlycnaIRNqP6QZLiC
         ISuK5tVw5FvhVAQLL631/zq//3rq5el8Nmnu45UvBxmQsilTnHbSfx5LrzEvazbG3hZZ
         qy0SYN0VKs/7CQHWQwdNlJP93ZVl9OaafaL6You5M4iIJN+MXY6Fcn9+d+4UlA5I2GuG
         xPyAcN+UxpahInl4WGcECE9S+NYZEntka9LN5ANm8xZgpV0I5nBJj/EV53uafBHNOMcC
         0Hc9eusRfh3ntDoOKaoQ2PSq9hLbg6ctp6yPWdBqgjl3G0UEcrFhhFLORSP+7teKYsW+
         nn6A==
X-Gm-Message-State: AFuF++lFJQusMJ9cdVdo7RUxy1S5lhcMl6QfuI5o0+DlivuKuDSfjzl2
	2jjQqnFYWObNsviG3Rx6Fvi8ZLxuKsetPtT8/lGlNWo2gSsLT8tD1S4gLvQ3isUoeBrNIXaleeQ
	r8hFFRA==
X-Received: from pjbrr14.prod.google.com ([2002:a17:90b:2b4e:b0:398:e613:7ab3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17ca:b0:395:4de5:1054
 with SMTP id 98e67ed59e1d1-39907d65648mr5020588a91.16.1788223969099; Mon, 31
 Aug 2026 17:52:49 -0700 (PDT)
Date: Mon, 31 Aug 2026 17:52:48 -0700
In-Reply-To: <apIf7eoMxdfV_7kE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <56a4bc35ee605588b7cc36c8e45c12b5f3b506cb.camel@guillain.net> <apIf7eoMxdfV_7kE@google.com>
Message-ID: <apYh4GDHD3Tdb8t4@google.com>
Subject: Re: BUILD_BUG_ON failed for kvm_vmx struct size sanity check in vmx.c
From: Sean Christopherson <seanjc@google.com>
To: Jean-Christophe Guillain <jean-christophe@guillain.net>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026, Sean Christopherson wrote:
> On Thu, Aug 27, 2026, Jean-Christophe Guillain wrote:
> > Hello,
> >=20
> > Since yesterday, my daily compilation of Linus tree fails with this
> > error:
> >=20
> >   CC [M]  arch/x86/kvm/vmx/vmx.o
> > In file included from <command-line>:
> > arch/x86/kvm/vmx/vmx.c: In function =E2=80=98vmx_init=E2=80=99:
> > ././include/linux/compiler_types.h:702:45: error: call to
> > =E2=80=98__compiletime_assert_1411=E2=80=99 declared with attribute err=
or: BUILD_BUG_ON
> > failed: get_order(sizeof(struct kvm_vmx) - SIZE_OF_MEMSLOTS_HASHTABLE)
> > && !IS_ENABLED(CONFIG_DEBUG_KERNEL) && !IS_ENABLED(CONFIG_KASAN)
> >   702 |         _compiletime_assert(condition, msg,
> > __compiletime_assert_, __COUNTER__)
>=20
> The immediate problem is more than likely commit 97d65b544f48 ("KVM: Chec=
k for
> duplicate vcpu_id as early as possible"), which increased the size by 512=
 bytes.

/facepalm

Note, my claim wasn't 512 bytes, it was 256 bytes.  From commit 97d65b544f4=
8
("KVM: Check for duplicate vcpu_id as early as possible"):

  the worst case scenario is 256 bytes per-VM (on x86, which allows up to 1=
6KiB vCPU IDs)

Dmytro was the author, but that blurb came from me.

And I didn't _completely_ fail at math, just mostly failed at math.  I was =
write
that it would require 256 somethings, the small problem is that it's 256 "u=
nsigned
longs", not 256 bytes (I did the mental math to compute the size of the arr=
ay in
number of entries, not in number of bytes).

So it's not 256 bytes, it's 2048 bytes, which is basically just a rounding =
error,
right?  Right!?!?.  *sigh*

In other words, the compile-time assertions added by commit ac777fbf064f ("=
KVM:
x86: Use kvzalloc() to allocate VM struct") are doing exactly what they're =
intended
to do, but I failed at math and at incorporating the sanity check into my t=
est flow.

Looking at my semi-temporary xarray idea, that approach doesn't make much s=
ense.
An xarray node is currently 576 bytes, so in practice it would either bleed=
 more
or less the same number of bytes, or would result in alloc+free on every vC=
PU
creation.

Stepping back, all of this complexity exists purely so that the guts of vCP=
U
creation can run without holding kvm->lock.  AFAIK, everyone, myself includ=
ed,
has assumed that dropping kvm->lock was a performance optimization, e.g. to=
 allow
userspace to create vCPUs concurrently for latency purposes.  But I've scra=
ped
through all of the VMMs I know about, and several I didn't until now, and u=
nless
I'm misreading Rust code, no VMM actually does concurrent vCPU creation.

And looking at the history of this code, before commit 11ec28047118 ("KVM: =
Convert
vm lock to a mutex"), kvm->lock was a spinlock.  I.e. KVM *had* to drop kvm=
->lock
when doing the bulk of vCPU creation, otherwise it couldn't do normal memor=
y
allocations.  When kvm->lock got turned into a mutex, no one update vCPU cr=
eation
to take advtange of that.  And 19 years later, we all just assumed the comp=
lexity
was for performance reasons.

Furthermore, naively parallelizing vCPU creation in userspace is likely a n=
et
negative due to the overheads of task creation.  Unless a VMM specificaly a=
voids
extra overhead related to parallelization, e.g. spawns each vCPU's thread b=
efore
creating the vCPU, creating vCPUs concurrently is a net *negative* up until=
 about
~64 vCPUs, after which the times are a wash.

The speed of light is faster if KVM doesn't hold kvm-lock, but at vCPU coun=
ts of
~24 or less, it's probably in the noise when considering total VM creation =
time.
E.g. 190us vs. 390us for 8 vCPUs, 1170us vs. 420us for 24 vCPUs.

On top of all that, we've had a *lot* of fatal bugs (found by syzkaller) re=
lated
to vCPUs being created while trying to do per-VM operations (basically, see=
 every
flow that locks all vCPUs).  I.e. the parallel vCPU creation "support" is a=
ctively
harmful.

So, rather than trying to come up with a scheme that is performant without =
being
too complex, I'm planning on fixing this by simply holding kvm->lock for th=
e entire
duration of vCPU creation, so that KVM doesn't need to do extra tracking an=
d can
instead rely purely on the array of online vCPUs.  Then we can revert 97d65=
b544f48
and do more cleanups on top.

I'll send a series (hopefully tomorrow) after testing.

P.S. I was also wrong (though nowhere near as badly) in commit ac777fbf064f=
 when
     I said the size of kvm_{svm,vmx,tdx} was below 2KiB.  That was true, b=
ut only
     for a KVM built without Hyper-V or Xen emulation.  With those it was a=
nd still
     is about 2.7KiB.  So bigger, but still in the realm of "shouldn't cros=
s the
     4KiB boundary anytime soon".
