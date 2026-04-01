Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183123AA4EB
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058011; cv=none; b=JHC6UkNVrdwMFywW9PZ5BZXpysyHSyYtv/jZzkd1YX9+b779CdEpNZaQPFUmCKnsnIKdGpG67zvZqPZWBDMEu0UunvxJZnHPUcZ8JuSQK1nzdaTcRiNhFe7vyKbCdhGVRvccy/0sBuVeRmwFp0oX7Ey/JlT6QRNE9V3cXD8Ovlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058011; c=relaxed/simple;
	bh=CTgR8YuZPM7++i4knWDv7+I4feJbJZe/+D43E6jozRs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d3yoAHRsjdkCRU9BPZlakPNQv6SJ2IaAXB0tGcpKXAN/qkx9fW4JicQn0aN7gTQOT48/RlkIrR8mxN6AQdRWJ05Eaa5nB2o6uEZnkg7LPOy+ahMPE736t6AfZX6TeyuoND+WFHALX8s1lvNs3t/Se1UxzBvJxL/Q8LezpF0yP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d73znA1D; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d73znA1D"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358e425c261so8608152a91.3
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775058009; x=1775662809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhzWUdsAadf2bCm0BnwhX4D6ZCPWNLP0D/pAuORC/t0=;
        b=d73znA1DjsNxAQnmTg4Q5MPbJeL8XE1dnk5ODfp1B9uV1FUM92Xxh6c9lmI5L7h4g3
         oYiStoD6+V3jRVXz90d5nPd6c3FzQlVK/6ZonZ2zsi/GsgFnoEtNNj2ye9+2+NBWgRXy
         4GQLYo9jBpZVj2Bw/ddd+T6RL9NkDQSPDG9KbAGiRA9oFtjYaOX7WaGA/oMUtj8Gl5MV
         I0gyYQVR8+MkydvwL0bOnzt6v3/DtV7WYCqswk2iBDP0vf8IlfPjqjouUgiKhZF8DxBt
         1c5i1PhAD31MjYpc4EncJR64KnGDxtsKUi7JQTEKI1F2d7BXtG7FcvXwlIn8mKMymgUm
         XziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775058009; x=1775662809;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DhzWUdsAadf2bCm0BnwhX4D6ZCPWNLP0D/pAuORC/t0=;
        b=qdOfeQDJ+W/LLt5yzFph2NB4j5zKmX94DBFlV/El0LCFh5uu27vZtjK1hng5RZyHWe
         CmbGbLo6smB4RL/iztQDSiMhCoKpfGsSA+x61Z0LJKKxvmJ4KfiGIAD+LfIdXHGKsvM6
         Uvvfe7GQCPKgko6ZfQ5QcDGmQy5h7/y3ZkjUfIMjwKrsfKrIP2IVvavCNHHUCqSN0I9Y
         vDVs5ZxznJpo6Nd8ru0VbusCWBuJqmWgN65jGKMX4O9XC6vQA2WAQBBTZRfI6Kz0t3nS
         ZeH2HbxtQiZwQQihhdgnwe/CfnXGYHZvqe4Rav+DxpHHIOHTDihi0xOCy6AwlfNMh20A
         DwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFXN1zyVllLBwud+QcLB39pOBV8DngS+85QpWvx2k1HRTXG46HTo6xqqeU62JTX2jqj8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQ+fboOakwoOqekGh+L1bjau+oZ/6XdPM/GVBMwUWSLco4QH4
	C2u2V7kw7CQ4uyWyWS3PRkDwAVcxyjyDPo4Hxx9KBfKGmFJgEDGbGvOJCs7HOBWZEupkHZedD4N
	xt2HK4w==
X-Received: from pjbrv11.prod.google.com ([2002:a17:90b:2c0b:b0:35c:ba7:1b9b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28ce:b0:35c:29ba:bf92
 with SMTP id 98e67ed59e1d1-35dc6ea76eemr3856835a91.5.1775058009251; Wed, 01
 Apr 2026 08:40:09 -0700 (PDT)
Date: Wed, 1 Apr 2026 08:40:07 -0700
In-Reply-To: <bb7b66ad99097c5326196b61d644cff255e30394.camel@amazon.co.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260329131543.91733-1-shaikhkamal2012@gmail.com>
 <20260330101814.7fa1e31e@gandalf.local.home> <bb7b66ad99097c5326196b61d644cff255e30394.camel@amazon.co.uk>
Message-ID: <ac08V4TaM2yh9SY1@google.com>
Subject: Re: [PATCH] KVM: x86/xen: Fix sleeping lock in hard IRQ context on PREEMPT_RT
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"shaikhkamal2012@gmail.com" <shaikhkamal2012@gmail.com>, 
	"syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com" <syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com>, 
	"me@brighamcampbell.com" <me@brighamcampbell.com>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, "hpa@zytor.com" <hpa@zytor.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026, David Woodhouse wrote:
> On Mon, 2026-03-30 at 10:18 -0400, Steven Rostedt wrote:
> >=20
> > > +static void xen_timer_inject_irqwork(struct irq_work *work)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_vcpu_xen *xen =3D container_of(w=
ork, struct kvm_vcpu_xen,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_inject_irqwork);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_vcpu *vcpu =3D container_of(xen,=
 struct kvm_vcpu, arch.xen);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_xen_evtchn e;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int rc;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 e.vcpu_id =3D vcpu->vcpu_id;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 e.vcpu_idx =3D vcpu->vcpu_idx;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 e.port =3D vcpu->arch.xen.timer_virq;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 e.priority =3D KVM_IRQ_ROUTING_XEN_EVTCHN_P=
RIO_2LEVEL;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D kvm_xen_set_evtchn_fast(&e, vcpu->kv=
m);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (rc !=3D -EWOULDBLOCK)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vcpu->arch.xen.timer_expires =3D 0;
> > > +}
> >=20
> > Why duplicate this code and not simply make a static inline helper
> > function that is used in both places?
>=20
> It's already duplicating the functionality; the original
> xen_timer_callback() will already fall back to injecting the IRQ in
> process context when it needs to (by setting vcpu-
> >arch.xen.timer_pending and then setting KVM_REQ_UNBLOCK).
>=20
> All you had to do was make kvm_xen_set_evtchn_fast() return=C2=A0
> -EWOULDBLOCK in the in_hardirq() case in order to use the existing
> fallback, surely?=20
>=20
> Better still, can't kvm_xen_set_evtchn_fast() just use read_trylock()
> instead?

Re-reading through the thread where you proposed using trylock, and through
commit bbe17c625d68 ("KVM: x86/xen: Fix potential deadlock in kvm_xen_updat=
e_runstate_guest()"),
I think I agree with using trylock for "fast" paths.

Though I would prefer to not make it unconditional for the "fast" helper in=
stead
of conditional based on in_interrupt().  And before we start doing surgery =
to
"fix" a setup no one uses, and also before we use gpcs more broadly, I thin=
k we
should try to up-level the gpc APIs to reduce the amount of duplicate, boil=
erplate
code.  kvm_xen_update_runstate_guest() and maybe kvm_xen_set_evtchn() will =
likely
need to open code some amount of logic, but=20

Side topic, looks like kvm_xen_shared_info_init() is buggy in that it fails=
 to
mark the slot as dirty.

E.g. sans the API implementations, I think we can and should end up with co=
de
like this:

---
 arch/x86/kvm/x86.c |  14 ++---
 arch/x86/kvm/xen.c | 127 ++++++++++++---------------------------------
 2 files changed, 37 insertions(+), 104 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0b5d48e75b65..65bad25fd9d4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3274,15 +3274,8 @@ static void kvm_setup_guest_pvclock(struct pvclock_v=
cpu_time_info *ref_hv_clock,
=20
 	memcpy(&hv_clock, ref_hv_clock, sizeof(hv_clock));
=20
-	read_lock_irqsave(&gpc->lock, flags);
-	while (!kvm_gpc_check(gpc, offset + sizeof(*guest_hv_clock))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
-
-		if (kvm_gpc_refresh(gpc, offset + sizeof(*guest_hv_clock)))
-			return;
-
-		read_lock_irqsave(&gpc->lock, flags);
-	}
+	if (kvm_gpc_acquire(gpc))
+		return;
=20
 	guest_hv_clock =3D (void *)(gpc->khva + offset);
=20
@@ -3305,8 +3298,7 @@ static void kvm_setup_guest_pvclock(struct pvclock_vc=
pu_time_info *ref_hv_clock,
=20
 	guest_hv_clock->version =3D ++hv_clock.version;
=20
-	kvm_gpc_mark_dirty_in_slot(gpc);
-	read_unlock_irqrestore(&gpc->lock, flags);
+	kvm_gpc_release_dirty(gpc);
=20
 	trace_kvm_pvclock_update(vcpu->vcpu_id, &hv_clock);
 }
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 91fd3673c09a..a97fd88ee99c 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -42,19 +42,12 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	u32 *wc_sec_hi;
 	u32 wc_version;
 	u64 wall_nsec;
-	int ret =3D 0;
 	int idx =3D srcu_read_lock(&kvm->srcu);
+	int ret;
=20
-	read_lock_irq(&gpc->lock);
-	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
-		read_unlock_irq(&gpc->lock);
-
-		ret =3D kvm_gpc_refresh(gpc, PAGE_SIZE);
-		if (ret)
-			goto out;
-
-		read_lock_irq(&gpc->lock);
-	}
+	ret =3D kvm_gpc_acquire(gpc);
+	if (ret)
+		goto out;
=20
 	/*
 	 * This code mirrors kvm_write_wall_clock() except that it writes
@@ -96,7 +89,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	smp_wmb();
=20
 	wc->version =3D wc_version + 1;
-	read_unlock_irq(&gpc->lock);
+	kvm_gpc_release_dirty(gpc);
=20
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MASTERCLOCK_UPDATE);
=20
@@ -155,22 +148,14 @@ static int xen_get_guest_pvclock(struct kvm_vcpu *vcp=
u,
 				 struct gfn_to_pfn_cache *gpc,
 				 unsigned int offset)
 {
-	unsigned long flags;
 	int r;
=20
-	read_lock_irqsave(&gpc->lock, flags);
-	while (!kvm_gpc_check(gpc, offset + sizeof(*hv_clock))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
-
-		r =3D kvm_gpc_refresh(gpc, offset + sizeof(*hv_clock));
-		if (r)
-			return r;
-
-		read_lock_irqsave(&gpc->lock, flags);
-	}
+	r =3D kvm_gpc_acquire(gpc);
+	if (r)
+		return r;
=20
 	memcpy(hv_clock, gpc->khva + offset, sizeof(*hv_clock));
-	read_unlock_irqrestore(&gpc->lock, flags);
+	kvm_gpc_release_clean(gpc);
=20
 	/*
 	 * Sanity check TSC shift+multiplier to verify the guest's view of time
@@ -420,27 +405,8 @@ static void kvm_xen_update_runstate_guest(struct kvm_v=
cpu *v, bool atomic)
 	 * Attempt to obtain the GPC lock on *both* (if there are two)
 	 * gfn_to_pfn caches that cover the region.
 	 */
-	if (atomic) {
-		local_irq_save(flags);
-		if (!read_trylock(&gpc1->lock)) {
-			local_irq_restore(flags);
-			return;
-		}
-	} else {
-		read_lock_irqsave(&gpc1->lock, flags);
-	}
-	while (!kvm_gpc_check(gpc1, user_len1)) {
-		read_unlock_irqrestore(&gpc1->lock, flags);
-
-		/* When invoked from kvm_sched_out() we cannot sleep */
-		if (atomic)
-			return;
-
-		if (kvm_gpc_refresh(gpc1, user_len1))
-			return;
-
-		read_lock_irqsave(&gpc1->lock, flags);
-	}
+	if (__kvm_gpc_acquire(gpc, atomic))
+		return;
=20
 	if (likely(!user_len2)) {
 		/*
@@ -465,6 +431,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vc=
pu *v, bool atomic)
 		 * gpc1 lock to make lockdep shut up about it.
 		 */
 		lock_set_subclass(&gpc1->lock.dep_map, 1, _THIS_IP_);
+
 		if (atomic) {
 			if (!read_trylock(&gpc2->lock)) {
 				read_unlock_irqrestore(&gpc1->lock, flags);
@@ -575,13 +542,10 @@ static void kvm_xen_update_runstate_guest(struct kvm_=
vcpu *v, bool atomic)
 		smp_wmb();
 	}
=20
-	if (user_len2) {
-		kvm_gpc_mark_dirty_in_slot(gpc2);
-		read_unlock(&gpc2->lock);
-	}
+	if (user_len2)
+		kvm_gpc_release_dirty(gpc2);
=20
-	kvm_gpc_mark_dirty_in_slot(gpc1);
-	read_unlock_irqrestore(&gpc1->lock, flags);
+	kvm_gpc_release_dirty(gpc1);
 }
=20
 void kvm_xen_update_runstate(struct kvm_vcpu *v, int state)
@@ -645,20 +609,8 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	if (!evtchn_pending_sel)
 		return;
=20
-	/*
-	 * Yes, this is an open-coded loop. But that's just what put_user()
-	 * does anyway. Page it in and retry the instruction. We're just a
-	 * little more honest about it.
-	 */
-	read_lock_irqsave(&gpc->lock, flags);
-	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
-
-		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info)))
-			return;
-
-		read_lock_irqsave(&gpc->lock, flags);
-	}
+	if (kvm_gpc_acquire(gpc))
+		return;
=20
 	/* Now gpc->khva is a valid kernel address for the vcpu_info */
 	if (IS_ENABLED(CONFIG_64BIT) && v->kvm->arch.xen.long_mode) {
@@ -686,8 +638,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
=20
-	kvm_gpc_mark_dirty_in_slot(gpc);
-	read_unlock_irqrestore(&gpc->lock, flags);
+	kvm_gpc_release_dirty(gpc);
=20
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
 	if (v->arch.xen.upcall_vector)
@@ -697,8 +648,8 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 {
 	struct gfn_to_pfn_cache *gpc =3D &v->arch.xen.vcpu_info_cache;
-	unsigned long flags;
 	u8 rc =3D 0;
+	int r;
=20
 	/*
 	 * If the global upcall vector (HVMIRQ_callback_vector) is set and
@@ -713,33 +664,23 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 	BUILD_BUG_ON(sizeof(rc) !=3D
 		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
=20
-	read_lock_irqsave(&gpc->lock, flags);
-	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
-
-		/*
-		 * This function gets called from kvm_vcpu_block() after setting the
-		 * task to TASK_INTERRUPTIBLE, to see if it needs to wake immediately
-		 * from a HLT. So we really mustn't sleep. If the page ended up absent
-		 * at that point, just return 1 in order to trigger an immediate wake,
-		 * and we'll end up getting called again from a context where we *can*
-		 * fault in the page and wait for it.
-		 */
-		if (in_atomic() || !task_is_running(current))
-			return 1;
-
-		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info))) {
-			/*
-			 * If this failed, userspace has screwed up the
-			 * vcpu_info mapping. No interrupts for you.
-			 */
-			return 0;
-		}
-		read_lock_irqsave(&gpc->lock, flags);
-	}
+	/*
+	 * This function gets called from kvm_vcpu_block() after setting the
+	 * task to TASK_INTERRUPTIBLE, to see if it needs to wake immediately
+	 * from a HLT. So we really mustn't sleep. If the page ended up absent
+	 * at that point, just return 1 in order to trigger an immediate wake,
+	 * and we'll end up getting called again from a context where we *can*
+	 * fault in the page and wait for it.
+	 *
+	 * If acquiring the cache fails completely, then userspace has screwed
+	 * up the vcpu_info mapping. No interrupts for you.
+	 */
+	r =3D __kvm_gpc_acquire(gpc, in_atomic() || !task_is_running(current));
+	if (r)
+		return r =3D=3D -EWOULDBLOCK ? 1 : 0;
=20
 	rc =3D ((struct vcpu_info *)gpc->khva)->evtchn_upcall_pending;
-	read_unlock_irqrestore(&gpc->lock, flags);
+	kvm_gpc_release_clean(gpc);
 	return rc;
 }
=20

base-commit: 3d6cdcc8883b5726513d245eef0e91cabfc397f7
--=20

[*] https://lore.kernel.org/all/76c61e1cb86e04df892d74c10976597700fe4cb5.ca=
mel@infradead.org
