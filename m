Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391181;
	b=m6fd0i+wIRHIyKn3xNtcW3rIukXrWLeCfrcyYDgyxR/y7ns9e1rxOdAGZYrCv+cYIsqr
	 EVtiHseJ4wGq08l1tvQoUKAnEdhBHuxDEZh6x1Bn2qYemF76t3OvWqeILZFfnG8mQ2W8q
	 jeloUq9tXkRM6mDuCqLrj0f2bo1GoSrNiifvhjBspNjKlCDvtjpx61v6Iil1OZouEeTem
	 c97Qm4T1hP1yVW/OWmiQzcfUXsIc5pa5osuCfLKm6w0un7kfh4BHF3bo7eBOCenAC+2Bo
	 Z4RMmWZHq8aoUdGZED+XxTsz4NduHIVHjqjA7XQX326blkXOp1T8xSL4VU9XuO9Xr/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=ua+C9vpOidUeh38X5VWKBRe9NwFSaOtLQgMBx+NbHhE=;
	b=3LYtV/a94153qCCCpxzf8T7aEDGQ3+jW78RLWO0Yqh5oFlUmGJTFgpdG9CKt0Q1ivCJ2
	 vCtCASt3yhCWeWLm5eyzET6nT+IDTdm6Y31dEFYbgac9WsUYSGNaeqtf8xSAMIuK7P2pN
	 POAEygbBNBmPNQG63dWcOuzKE4LLVMLNrJICyxsvviwu4EZnzV37piVVZ3WiwKqafn1gN
	 GbLBAoxwIZ9+1HBn39cP6jDiPunTAxOytaV37mOW5KchYRudbLy1yWARhrXvGIIEQbGgT
	 F+By1ZTqaYgZVYc3o386fxBtQkOW127bmkMHHu5563ApUpnD8OyC6PWJAn9GrzK0y4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bBIGQQUl;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64001606A320
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 20:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64001606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bBIGQQUl
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a5971cf7ceso1376574b3a.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793391181; x=1793995981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ua+C9vpOidUeh38X5VWKBRe9NwFSaOtLQgMBx+NbHhE=;
        b=bBIGQQUlZU11drb/YdFP19thgVsO6QOFUewvM8uTGj9M+dlBtUlEyYAJrqOaKrY0Ry
         ZF/Z6VGVe3MMd03CD5Fb65U7josq/sX+OAZTyj4s0lOpru20jpEG70EJHE0TaPcIVrCJ
         0gqE3M1IQvGGYNqyDLAImm3T9amMsXOJG0aEjOnTEaTDShiI4RvuE0CHjoQEcFdEF2hH
         hNjqb8gzMNFXB5oBceQHMg9Omp37T0WV/oHmkBx7odrvwT8oxOu05Q+R5YR2mJ2XdqAc
         F4pfAJKagJjscnMr31jT8gi1LoKuza6T4XKZv8b270LH23krUcwq9Skon3EkRUqWmnOL
         hrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793391181; x=1793995981;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ua+C9vpOidUeh38X5VWKBRe9NwFSaOtLQgMBx+NbHhE=;
        b=Fkb+O2+/uwLiJoWmSDZeP+CvIUWnKWYAoEACApcS4DxTvDZTB40LGCDo9AkIpAWvDd
         IjsMGWA1HsbNt7rnmhmmG9LHqoo2UmKltWEtyEXOu88tm7NIM6h+R1UObEm40O4m/NEc
         L+yU+uq4R2KP4+xC273CInqDbO7/kW7rOgKf01juZy9XWYsYCjemxBj25E8DHh2D5UVB
         Iq+fgVTb/nycibiPF4NmZqv8eBGtyAlPgqnURlz+QvDY2FLGvtAnzMvWWA/jKzxmyoNn
         JomFOFJs0pHngLvN7oroecxehi1rk/ddilnCupKe86aCn1iYmPpUSArFUJhN8goZVwwn
         8cWQ==
X-Forwarded-Encrypted: i=1; AKwUvByGd2ysORENXiGfNPCmTjLgOdmiO24zhiFOJNAMgTkVeGQtF2MPSZabeN2JCROETUPPrTo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbNv4yKmB2D7UaXd1et28icTlF61Fjh6SRk/A7DWt3VMMOx2do
	PfVz+sZu6Urw/VSuXmm8SVJUSlbIQ4L3uMeOVA9nFadnfVJ9QG0Qq7p47YXjSVLU6oq2UL7x6/C
	B8/lLUQ==
X-Received: from pfbgr18.prod.google.com ([2002:a05:6a00:4d12:b0:888:e7c7:5580])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1daa:b0:882:956c:58e2
 with SMTP id d2e1a72fcca58-8a9bd2f071fmr3325949b3a.17.1793391180582; Fri, 30
 Oct 2026 13:13:00 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:12:59 -0700
In-Reply-To: <62e09b20-b839-448c-90ad-0c63233b523e@oracle.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027051808.243000-1-partha.satapathy@oracle.com>
 <auDF9WpqW8OCu_8w@google.com> <85b0e3aa-0b84-4a00-852a-821aed4a0649@oracle.com>
 <auEI0B7QkIhg-lLG@google.com> <62e09b20-b839-448c-90ad-0c63233b523e@oracle.com>
Message-ID: <auT6S-I5b5ordXy9@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Select lowest vCPU ID for aliased xAPIC IDs
From: Sean Christopherson <seanjc@google.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Partha Sarathi Satapathy <partha.satapathy@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	wim.ten.have@oracle.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026, Alejandro Jimenez wrote:
> On 10/27/26 4:25 PM, Sean Christopherson wrote:
> > On Tue, Oct 27, 2026, Alejandro Jimenez wrote: > On 10/27/26 11:=E2=80=
=8A40 AM,
> >> The issue was triggered with QEMU and a tool that uses libvirt API for
> >> resizing guests and balancing their vCPU allocations across NUMA nodes=
. I
> >> am not sure if similar work has been published upstream, so I'll defer=
 to
> >> Wim (CC'd) if you want more details.
> >=20
> > Oooh, actual hotplug of vCPUs.  That makes sense.

...

> > I suspect there's no solution that will magically fix everything.  E.g.=
 if you're
> > trying to resolve an issue where vCPUs aren't recognizing SIPIs, then t=
he example
> > you provided means vCPU_531 will never wakeup, i.e. which vCPU is  "bug=
gy" changes,
> > but the bug itself is still there.
> >=20
>=20
> Sorry, I don't follow. vCPU 531 would not receive an INIT/SIPI addressed =
to
> the aliased 0x13 APIC ID in my example, but it will be reachable using it=
s
> full x2APIC ID of 0x213, for which an entry in the phys_map was installed=
 in:
>=20
>         if (vcpu->kvm->arch.x2apic_format) {
>=20
>                 /* See also kvm_apic_match_physical_addr(). */
>=20
>                 if (apic_x2apic_mode(apic) || x2apic_id > 0xff)
>=20
>                         new->phys_map[x2apic_id] =3D apic;

Oh, duh, the hotplug hack allows using the x2APIC ID even if the target isn=
't
in x2APIC mode.

> My interpretation is that behavior is "the KVM hotplug hack", and that
> behavior is not changed in the proposed patch.
>=20
> My example was meant to show the conflict of your proposed change with th=
e
> "deliver to the lowest ID" rule, which you clarified is not a rule after
> all :) (but perhaps it should be since it has been working so far..?)

Heh, "rule".  More like half-assed description of what KVM kinda sorta does=
.

> > If this is about SIPIs hitting the all CPUs, then I think to have a rob=
ust (well,
> > as robust as this mess can get) implementation, we'd have to disable us=
e of the
> > optimized map when processing SIPIs with PHYSICAL delivery, e.g.
>=20
> But then we would also have to disable the optimized map for INIT as well
> (APIC_DM_INIT), since those would still be routed to the wrong vCPU other=
wise?
>=20
> And if both INIT & SIPI are using the slow path, they will be delivered t=
o
> all matching vCPU IDs, which is likely to cause problems e.g. hot pluggin=
g
> one vCPU will potentially initialize and start all of its aliases too?
>=20
> I need to test this with proper instrumented kernel so I can "bring
> receipts" (and I think Partha is doing it already), but hopefully my
> concern above makes sense.

Don't bother testing my patch, my brain was slow to catch on.

> In short, I think the original proposal of allowing a replacement of a
> phys_map[xapic_id] entry only with a new "low" entry (i.e. one with vcpu_=
id
> =3D=3D x2apic_id =3D=3D xapic_id) fixes the creation order issue while pr=
eserving
> the existing behavior for the typical cases.

Agreed, though I think we tie the overide to "xapic_id <=3D 0xff" instead o=
f letting
the "lower" vCPU win.  I.e. to make it a bit more obvious that the goal is =
to keep
the non-truncated xAPIC ID reachable.

Ha!  Yeah, looking at 5bd5db385b3e ("KVM: x86: allow hotplug of VCPU with A=
PIC ID
over 0xff"), it had:

                /*
                 * ... xAPIC ID of VCPUs with APIC ID > 0xff will wrap-arou=
nd,
                 * prevent them from masking VCPUs with APIC ID <=3D 0xff.
                 */
                if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
                        new->phys_map[xapic_id] =3D apic;

so the goal really was to prevent an truncated x2APIC ID from clobbering a =
"pure"
xAPIC ID.

Actually, even better: what if we only let the vCPU whose ID exactly matche=
s the
aliased xAPIC ID win?  Unless I've gone into the weeds yet again, that's wh=
at we
(and more importantly, userspace and guest firmware) really want.  It shoul=
dn't
matter in practice, but it lets KVM provide a stronger, and hopefully easie=
r to
understand, guarantee in the errata.

E.g.

diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm=
/x86/errata.rst
index a9cf0e004651..09c6e6a29ae2 100644
--- a/Documentation/virt/kvm/x86/errata.rst
+++ b/Documentation/virt/kvm/x86/errata.rst
@@ -63,10 +63,11 @@ When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM activ=
ates a hack/quirk that
 allows sending events to a single vCPU using its x2APIC ID even if the tar=
get
 vCPU has legacy xAPIC enabled, e.g. to bring up hotplugged vCPUs via INIT-=
SIPI
 on VMs with > 255 vCPUs.  A side effect of the quirk is that, if multiple =
vCPUs
-have the same physical APIC ID, KVM will deliver events targeting that API=
C ID
-only to the vCPU with the lowest vCPU ID.  If KVM_X2APIC_API_USE_32BIT_IDS=
 is
-not enabled, KVM follows x86 architecture when processing interrupts (all =
vCPUs
-matching the target APIC ID receive the interrupt).
+have the same physical legacy xAPIC ID, KVM may deliver events targeting t=
hat
+xAPIC ID only to the vCPU whose vCPU ID matches the aliased x2APIC ID.  If
+KVM_X2APIC_API_USE_32BIT_IDS is not enabled, KVM follows x86 architecture =
when
+processing interrupts (all vCPUs matching the target APIC ID receive the
+interrupt).
=20
 MTRRs
 -----
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d6e5fbc3c58c..e89c4fef1832 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -297,8 +297,8 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map=
 *new,
 	 * Apply KVM's hotplug hack if userspace has enable 32-bit APIC IDs.
 	 * Allow sending events to vCPUs by their x2APIC ID even if the target
 	 * vCPU is in legacy xAPIC mode, and silently ignore aliased xAPIC IDs
-	 * (the x2APIC ID is truncated to 8 bits, causing IDs > 0xff to wrap
-	 * and collide).
+	 * but make sure the non-truncated xAPIC ID always "wins" (the x2APIC
+	 * ID is truncated to 8 bits, causing IDs > 0xff to wrap and collide).
 	 *
 	 * Honor the architectural (and KVM's non-optimized) behavior if
 	 * userspace has not enabled 32-bit x2APIC IDs.  Each APIC is supposed
@@ -312,7 +312,8 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map=
 *new,
 		if (apic_x2apic_mode(apic) || x2apic_id > 0xff)
 			new->phys_map[x2apic_id] =3D apic;
=20
-		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
+		if (!apic_x2apic_mode(apic) &&
+		    (!new->phys_map[xapic_id] || vcpu->vcpu_id =3D=3D xapic_id))
 			new->phys_map[xapic_id] =3D apic;
 	} else {
 		/*

