Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308159;
	b=hDXUUG41odvxe0l50CjcNNzfAtfvo8gd3qJrKIbi9P8rRSfo9BJqXn62MNvpp6TrBqto
	 AMitPEfYhCw+L+iGc1QO7FibTfL8NbCP3ncmyxWiAHBjhHeYki02Mcl5TXAuJTQ2BnCKL
	 XKIZ4km5w+0BNMO6JlSjBeBAokqCBjdaA+u34dzqKsEY0jfpVxRoL2FAHdYrlVCxBh5lZ
	 v7wwccuzNZ0AWpv+3kLlPeqmQq739kfxl+wcbOTd1Cn3dmoLxjtbAVh834TabL671D5Qw
	 V0ahIzKW3AuceGrX7HPv2tuyq0hSzF03OAl+fQ9rxVK6xnzCKI9jKEdrbfj+V1w+yyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=UZTQQFl2Xa9cNGYHC+qyfUooFiuQyHGk98xX353r+qY=;
	b=i3SsaCLwfZoosbEjfwrWjhji+DyUX8UbWRTVInAYpyD3Pm20IOVApWfyJp/VS6BKdsYU
	 a/rkIlTespz9UZAymk4MGDaXykd0GQ1bIHVPS/sJ7qb02uGf1KTMP5Qod2pi469O2Hr6v
	 HA19P9UN5ib5RerRWLwDRbZMwQ4NK52cPfU7UIy8Oe8YFWiaFzJc7zVLAKTR1+7Ze4Wf0
	 6IuHLpDNyzFghammFlpDgaRVROBhHjoxW4SIctxpNtLQ9CiNeqGxH6zf2rd2odGDW4zXw
	 ENphnOyYgiwwX14jDzTqxWeQwdzdJVFcUdxODngdBVsN9BwRIkSNUXmLkmcxpvqEOkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lX5yng3c;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E1606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 21:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E28E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lX5yng3c
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so53010a91.2
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793308158; x=1793912958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UZTQQFl2Xa9cNGYHC+qyfUooFiuQyHGk98xX353r+qY=;
        b=lX5yng3cJrilLmgre+XF6cWaCORTkxbMYGTQ27oLnG9B34rlaYEmnwsqLb+AyL+C49
         z5Rp/X00V1BXhQuQF1+Ch6W0sfSOtPXIjFI3ETVrfufZI8r27XqztpvW6K7VJ0ZA7682
         xn4WPtchzaCtluDwPAnBJCVDYTOCu73xf6CUk6ezPgFeIa7/5o7Ge/kNJkPd0zrL5EtV
         02ybCwKdo4zIa6JVJuw56zSYlhijS7KrzLvz0405ViUgVLzFeKloy1z0qr5NuAiaHlRg
         inoRJvlpqw25y8Y2jAxcHcaNKhTV2kJGpMBD8smeO0ayuX+Djxs9xR8YPHzF4eN8MhU4
         wPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308158; x=1793912958;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UZTQQFl2Xa9cNGYHC+qyfUooFiuQyHGk98xX353r+qY=;
        b=SkD4mUmUYokHq/lcTlvX6aLqoDattP5SkldQ5M8w1PaOaF4xPq9FzZK0MYQ42Iyz9E
         gTe+bzCrUcZOzFZWlNxza7TTfxwjuU9Ls5HWAnohSVyPRSUVU3dqJV37BZXguJ2qTE9t
         QCPuROXK3tVpZl5zUKeQYzHqWKMblkXeVmV4ERt+7zTiKGlDpRO4vk4E2Y6IshJLeHmx
         H307DbMa0APUpyjZppGUq0SPixiICof/FqJFqKdIeVCWKe4njL3+OtuF5068I7bAuWWr
         VfMWgWIup2PZH/WJGu94qRd96NcKglc0qXxZta5emGjc29ttj3Qfgh9Dg3Os58AFM7HI
         +67g==
X-Gm-Message-State: AFq9FYKw77frB1Q81A961d39chH4Fj3tMP1IagkrdZcxnnC6EUCH5LLd
	89bhy1D6Z4HAH0T+KjWRxNzEe0rjMfgT8Dc34b7uZM8EmXGw8KViLcTJ+yYmdk2oxsgMQeG9kxv
	1pUHtoA==
X-Received: from pjff12.prod.google.com ([2002:a17:90b:562c:b0:3aa:ff61:94d0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b90:b0:3ac:da41:ef7e
 with SMTP id 98e67ed59e1d1-3ae89851099mr137795a91.52.1793308157908; Thu, 29
 Oct 2026 14:09:17 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:09:17 -0700
In-Reply-To: <GV2PR06MB10711171A7A8F225207FACD6BB96E2@GV2PR06MB10711.eurprd06.prod.outlook.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028202607.1844883-4-seanjc@google.com> <20261028215143.2913059-1-jthoughton@google.com>
 <GV2PR06MB10711171A7A8F225207FACD6BB96E2@GV2PR06MB10711.eurprd06.prod.outlook.com>
Message-ID: <auO1_YE89Q0T0hfI@google.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Add automatic prefaulting/prefetching
 for TDP MMU faults
From: Sean Christopherson <seanjc@google.com>
To: Marco Marangoni <mamarang@amazon.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"cc-open-source@amazon.com" <cc-open-source@amazon.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026, Marco Marangoni wrote:
> Hi Sean, thanks for the patch!
> I run some benchmarks on it, and it definitely helps! This is the time to=
 fault 128 MiB linearly after a snapshot restore, with an UFFD page handler=
 that faults chunks on demand; medians of 60 restores. Baseline is kvm-x86/=
next. Each entry is nr_pages: change vs baseline on the patched kernel; neg=
ative means faster.
>=20
> - UFFD 4 KiB handler (baseline 2228 ms) 0: +1%, 1: =E2=88=925%, 2: =E2=88=
=923%, 4: +1%, 8: =E2=88=923%, 16: +1%, 32: 0%, 64: 0%, 128: =E2=88=922%, 2=
56: +1%, 512: +1%
> - UFFD 512 KiB handler (baseline 543 ms) 0: 0%, 1: 0%, 2: =E2=88=9236%, 4=
: =E2=88=9251%, 8: =E2=88=9259%, 16: =E2=88=9264%, 32: =E2=88=9271%, 64: =
=E2=88=9267%, 128: =E2=88=9268%, 256: =E2=88=9267%, 512: =E2=88=9266%
> - UFFD 2 MiB handler (baseline 513 ms) 0: 0%, 1: +1%, 2: =E2=88=9234%, 4:=
 =E2=88=9250%, 8: =E2=88=9259%, 16: =E2=88=9264%, 32: =E2=88=9268%, 64: =E2=
=88=9268%, 128: =E2=88=9268%, 256: =E2=88=9268%, 512: =E2=88=9268%
>=20
> 8 is the series' default; 0 and 1 both disable prefetch and reproduce
> baseline. The 4 KiB row is within =C2=B15%, i.e. noise.  It's measured on=
 nested
> virtualization, so the improvement is probably less dramatic on metal. Fo=
r
> context, my initial patch was around ~75% faster, so I'd say that
> performance-wise, your implementation is solid!
>=20
> It seems like a prefetch of 32 is the sweet spot, but I agree that with J=
ames
> that with the normal GUP it's probably better to keep it off or very low =
by
> default.

Yeah, agreed.  Triggering zswap or any other heavy operations could regress=
 a
lot of configurations/workloads.

Hrm, but I don't want to lose support for guest_memfd without an hva.  Oh. =
 That's
a pre-existing bug, kvm_prefetch_pages() should reject kvm_memslot_is_gmem_=
only()
slots.  But that's a side topic.

Argh, FOLL_FAST_ONLY is internal-only.  But do we actually need it to be su=
per
strictly fast-only?  Wouldn't FOLL_NOFAULT suffice?  IRQs are enabled so ta=
king
mmap_sem is fine; it's not be ideal, but KVM will still try fast-GUP first,=
 and
in practice performance is going to suffer no matter what if mmap_sem is
contended, e.g. arm64 *unconditionally* takes mmap_sem for read when handli=
ng
faults, and while it shows up in micro-benchmarks, e.g. mmu_stress_test, AF=
AIK
no one has complained otherwise.

So isn't the fix just this?

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b673c8130edd..1fcf4fedc0bb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4684,6 +4684,9 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcp=
u,
 {
 	unsigned int foll =3D fault->write ? FOLL_WRITE : 0;
=20
+	if (fault->auto_prefetch)
+		foll |=3D FOLL_NOFAULT;
+
 	if (fault->is_private || kvm_memslot_is_gmem_only(fault->slot))
 		return kvm_mmu_faultin_pfn_gmem(vcpu, fault);

> From my perspective, using fast GUP has the problem that you cannot prefa=
ult
> "around" your page, but just ahead of it, so I don't mind going with norm=
al
> GUP if it makes things easier for you.

I think I'm missing something, why would fast GUP prevent prefaulting "behi=
nd"?
E.g. is that effectively a limitation of the underlying backing store you'r=
e
using, a fundamental limitation somewhere in mm/, or a limitation in KVM it=
self?

> I'd say that most setup would know the size at which UFFD copies the memo=
ry,
> so having to explicitly configure is okay.
>=20
> For completeness, I also measured how much the patch improves at various =
UFFD chunks, with nr_pages at the same size:
>   - 4 KiB: 2285 ms =E2=86=92 2321 ms (np1), +2% (np1 is "off", noise)
>   - 8 KiB: 1435 ms =E2=86=92 1441 ms (np2), 0%
>   - 16 KiB: 1036 ms =E2=86=92 860 ms (np4), =E2=88=9217%
>   - 32 KiB: 743 ms =E2=86=92 469 ms (np8), =E2=88=9237%
>   - 64 KiB: 645 ms =E2=86=92 319 ms (np16), =E2=88=9250%
>   - 128 KiB: 587 ms =E2=86=92 242 ms (np32), =E2=88=9259%
>   - 256 KiB: 561 ms =E2=86=92 200 ms (np64), =E2=88=9264%
>   - 512 KiB: 543 ms =E2=86=92 165 ms (np128), =E2=88=9270%
>   - 1 MiB: 534 ms =E2=86=92 171 ms (np256), =E2=88=9268%
>   - 2 MiB: 523 ms =E2=86=92 151 ms (np512), =E2=88=9271%
>=20
> These measurement highlight a possible limitation (why didn't 8KiB improv=
e?):
> it seems like the prefetching doesn't kick in the first time a page is
> getting faulted in the chunk, is that expected? I asked an LLM to
> investigate, and it seems to be because with async PF, the first fault
> doesn't reach the kvm_mmu_auto_prefault code path.

Hmm, right.  I deliberately hooked kvm_mmu_page_fault() instead of
kvm_mmu_do_page_fault() so that prefetching wouldn't trigger auto-prefetch,=
 but
the existing shadow MMU prefetching does kick in for async #PFs, and it doe=
s make
sense to prefetch in that case if we buy my argument (from this changelog) =
that
async #PF should punch through dirty logging.

Auto-prefetching for KVM_PRE_FAULT_MEMORY feels "wrong", but we do prefetch=
 in
that case for the shadow MMU, though I'm like 99.9% certain no one is runni=
ng
TDP with the shadow MMU these days, so I don't think we should consider tha=
t a
valid datapoint.

Untested, but I think it'd be this:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b673c8130edd..c0ff50c52ad5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5024,6 +5024,9 @@ enum kvm_prefetch_type {
 	KVM_PREFETCH_AUTO,
 };
=20
+static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
+				  u64 error_code, u8 level);
+
 static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				 u64 err, enum kvm_prefetch_type prefetch,
 				 int *emulation_type, u8 *level)
@@ -5098,6 +5101,9 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcp=
u, gpa_t cr2_or_gpa,
 	if (level)
 		*level =3D fault.goal_level;
=20
+	if (r =3D=3D RET_PF_FIXED && prefetch !=3D KVM_PREFETCH_AUTO)
+		kvm_mmu_auto_prefault(vcpu, cr2_or_gpa, err, fault.goal_level);
+
 	return r;
 }

or to disable it for KVM_PRE_FAULT_MEMORY:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b673c8130edd..ee31a35f6a55 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5021,9 +5021,13 @@ static int kvm_tdp_page_fault(struct kvm_vcpu *vcpu,=
 struct kvm_page_fault *faul
 enum kvm_prefetch_type {
 	KVM_PREFETCH_NONE,
 	KVM_PREFETCH_MANUAL,
+	KVM_PREFETCH_ASYNC,
 	KVM_PREFETCH_AUTO,
 };
=20
+static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
+				  u64 error_code, u8 level);
+
 static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				 u64 err, enum kvm_prefetch_type prefetch,
 				 int *emulation_type, u8 *level)
@@ -5098,6 +5102,10 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vc=
pu, gpa_t cr2_or_gpa,
 	if (level)
 		*level =3D fault.goal_level;
=20
+	if (r =3D=3D RET_PF_FIXED && prefetch !=3D KVM_PREFETCH_AUTO &&
+	    prefetch !=3D KVM_PREFETCH_MANUAL)
+		kvm_mmu_auto_prefault(vcpu, cr2_or_gpa, err, fault.goal_level);
+
 	return r;
 }
=20
@@ -5215,7 +5223,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,=
 struct kvm_async_pf *work)
 		return;
=20
 	r =3D kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code=
,
-				  KVM_PREFETCH_MANUAL, NULL, NULL);
+				  KVM_PREFETCH_ASYNC, NULL, NULL);
=20
 	/*
 	 * Account fixed page faults, otherwise they'll never be counted, but

