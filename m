Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132754;
	b=MvkF4qgYyjmB3G7aztM/QBnwOD9Z+6uITR/LPb9PWkacsM9zRQDl7oHY2WBNVnR+dwWS
	 FNifg27sQbJpnZo8Ilbr6f+EVHUqLS+T65xZ8K7R+VEy6AE4d/DidqV3AwbKrzuLEzHsV
	 DYZnAegoyG/a42VDkll3oJ2MU7n56ghi0yFrNeC2nV+WymirXMs3u7V3hycJt/7BZV9aR
	 bdZirV0ec6OU49jAjVY+2Fqmd7TtcizRBo645Pzy8mjmr1NmblCPRWw9s53CWdAHT+jSi
	 OgWVy9cGrJYpu5RgPjYohoELfIhjdU7Lxqu/GMuWjLTVj0PBoZAak09vRAh562wSmpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=v43jU0e7RC9RWtFvXaEewucUmBHe6fOFYcJcLeSXNZY=;
	b=P5OeEMUzPJc0bohMpTPj5A9ejbb/QFETPn7gbNcaFBcMLWMUO4ypGaevcbr+hx646bfY
	 Vt7Wt/4MFYKNseV4vXTvYlxQLchvXvLcbBdG4dz8bu4+8DNSTxsklaQxU2tLFuG9JHTI8
	 OyiAGUpr1rijP3DAiok/seHmMGRxIJSMlSjdJNgRT4NCwpFRP9FPd/u41PVD+BgfZOBSe
	 nS2eiJeVlECjkn2Mkgn7qXQaFmIhtzHxICc23T4t80X8TlAvLYOBY9ZDZNFf29DTAmi6U
	 5j99Xz6rEjxvjvU+TjqBaL+qT0HQcrAU+VZtN2wNf5Vc2izDi6sPoWB6U5E3Qnqd1CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jMJ2XrUE;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356E606C902
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 20:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8356E606C902
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jMJ2XrUE
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd634ac49baso642926a12.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793132754; x=1793737554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v43jU0e7RC9RWtFvXaEewucUmBHe6fOFYcJcLeSXNZY=;
        b=jMJ2XrUEWIsDJmE2y/9yluM6UnlcY0/ai2kxR+h/Dyd1obZcfWvlFGA5+nK8RbUN/d
         oOvyNEGJ93bvgk31m4p2B1HnPmXhcyPjt/cIvHLfwgvjiJxz5CzjiOW+sLNPcFIjpMTw
         gNHuiHdWN5BJ1MeZrf2gf/0dqK/WluZ1az/ffC6vneKt7/AEmqybnHDFaf6ogGPvEFH8
         XrNWteueV810LRv1RukjO8Sfkc4hKGa9RJVGr2BMvVDWnDjnoFpVAlq3DuLSeLyItdjG
         atRkkTNa+DCuH7T+tM2AyM7HWkXC2ZqdX19l/on2kMK/HhjM/vioL65ASWHch/zHMvWG
         jbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132754; x=1793737554;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v43jU0e7RC9RWtFvXaEewucUmBHe6fOFYcJcLeSXNZY=;
        b=sUXK3qDtopkcl2s7U/1Y64aAx6idi1nISe0kC+FYIdfOOqpzKStE9wUvJWD9AqJONI
         2jxVF//VYH9Mwrgpp7X8mSe7CtvISRPXHGfqUm0xjcIMDy+Nolpw82pA7nhNnGAe06mh
         1MmZeb58+WVRfp5yVlUDs3xnRG4BG/Yv+QZ4oXY62ru2rH+eey5rTeFEyLV3ztMLbFu4
         mZ6NRmzwiqluW6FkIbq+zZdekvKlezPRHLOpa+Pcf9vl10TEX+rpE46CpAJaTd2mr6Kv
         l41VIDe7nrEF+Zcq7OpnRMukwocPg5Aq+kmEzxdb/kEGXIr1QsA56mutHcEZoM3Q0vKT
         Q50Q==
X-Forwarded-Encrypted: i=1; AKwUvBx7pqdITkthi9bKaVjW0YPoUdFN/2Ds6BSnasGbiZQemM0UusvSxriNrHE/1wOY7s0p830=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxJbtsJy4zOHAqzmyWFPOOMk50yJcLYLy1ixeO0HdDV3QJ3MQn
	uyss0zGk/Q5V5nI2morWk+MHv+qW4xI5zFRrIcaHEuWTMtDjgJ4WvhZ9A5VZzNAGB4tePsPmyG3
	6Z6qQLw==
X-Received: from pjbhs19.prod.google.com ([2002:a17:90b:2013:b0:3ad:99d8:e894])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a51:b0:3a6:d2ac:74ce
 with SMTP id 98e67ed59e1d1-3ae580d24a9mr93283a91.19.1793132753147; Tue, 27
 Oct 2026 13:25:53 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:25:52 -0700
In-Reply-To: <85b0e3aa-0b84-4a00-852a-821aed4a0649@oracle.com>
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
Message-ID: <auEI0B7QkIhg-lLG@google.com>
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

On Tue, Oct 27, 2026, Alejandro Jimenez wrote:
> On 10/27/26 11:40 AM, Sean Christopherson wrote:
> > On Tue, Oct 27, 2026, Partha Sarathi Satapathy wrote: > From: Alejandro
> > Jimenez <alejandro.=E2=80=8Aj.=E2=80=8Ajimenez@=E2=80=8Aoracle.=E2=80=
=8Acom> > > When
> > KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM's x2APIC hotplug > quirk
> > allows events to target a vCPU
> >=20
> > On Tue, Oct 27, 2026, Partha Sarathi Satapathy wrote:
> >> From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> >>=20
> >> When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM's x2APIC hotplug
> >> quirk allows events to target a vCPU by its x2APIC ID while the vCPU
> >> is still in xAPIC mode.
> >>=20
> >> In xAPIC mode, APIC IDs are truncated to eight bits. Consequently,
> >> vCPUs with distinct x2APIC IDs can share an effective physical APIC ID=
.
> >> KVM's x2APIC erratum specifies that an event targeting an aliased
> >> physical APIC ID is delivered only to the vCPU with the lowest vCPU ID=
.
> >>=20
> >> However, the optimized physical APIC map does not guarantee lowest-ID
> >> selection. When rebuilding the map, KVM retains the first xAPIC-mode
> >> vCPU encountered for an aliased 8-bit xAPIC ID. Since vCPUs can be
> >> added in any order, that vCPU need not have the lowest vCPU ID.
> >>=20
> >> For example, vCPU 19 has x2APIC ID 0x013 and vCPU 275 has x2APIC ID
> >> 0x113. Both expose xAPIC ID 0x13 while in xAPIC mode. If vCPU 275 is
> >> created before vCPU 19, the map retains:
> >>=20
> >>   phys_map[0x13] =3D vCPU 275
> >>=20
> >> An INIT/SIPI targeting physical destination 0x13 then starts vCPU 275
> >> instead of vCPU 19. vCPU 275 executes the secondary startup path for
> >> the firmware CPU entry with APIC ID 0x013. After vCPU 275 enables
> >> x2APIC, Linux observes APIC ID 0x113 and reports:
> >>=20
> >>   Firmware: 13 APIC: 113
> >>=20
> >> KVM hardcodes a vCPU's x2APIC ID to its vCPU ID. When populating an
> >> aliased legacy xAPIC entry, retain the vCPU with the lowest vCPU ID.
> >> This makes optimized-map selection independent of vCPU-add order.
> >=20
>=20
> First of all, apologies for the confusion since this is an earlier WIP
> version and due to a miscommunication it was sent as v1. The selftest als=
o
> has changes that are not included in Patch 2. I will send a v2 after the
> discussion on this thread.
>=20
> For this patch, the intended commit message is phrased/focused on
> maintaining the stated KVM hotplug hack behavior i.e. the commit should b=
e
> more like:
> --
> When KVM_X2APIC_API_USE_32BIT_IDS is enabled, events targeting an aliased
> xAPIC ID must be delivered to the vCPU with the lowest vCPU ID. However,
> the optimized physical APIC map does not guarantee lowest-ID
> selection. When rebuilding the map, KVM retains the first xAPIC-mode
> vCPU encountered for an aliased xAPIC ID. Since vCPUs can be added in any
> order, the initial entry does not necessarily map to the APIC of the vCPU
> with lowest vCPU ID.
>=20
> Compare vCPU IDs when populating aliased xAPIC entries and retain the
> lowest one, making destination selection independent of vCPU creation
> order.
> --
>=20
> > I'm genuinely curious.  What VMM adds vCPUs in a "random" order?  I agr=
ee a fix
> > is needed, as KVM should be internally consistent (kvm_apic_match_physi=
cal_addr()
> > will always try to match the truncated ID).  But this also makes me won=
der exactly
> > what userspace is doing, and why.
> >=20
>=20
> The issue was triggered with QEMU and a tool that uses libvirt API for
> resizing guests and balancing their vCPU allocations across NUMA nodes. I
> am not sure if similar work has been published upstream, so I'll defer to
> Wim (CC'd) if you want more details.

Oooh, actual hotplug of vCPUs.  That makes sense.
>=20
> A basic reproducer (besides the selftest) simply uses QEMU to issue
> 'device_add' QMP commands and starts with a vCPU placed on socket 1,
> followed by its "alias" on socket 0. e.g.
>=20
> { "execute": "device_add", "arguments": { "driver": "host-x86_64-cpu",
> "id": "cpu117", "socket-id": 1, "die-id": 0, "core-id": 11, "thread-id": =
1 } }
> { "execute": "device_add", "arguments": { "driver": "host-x86_64-cpu",
> "id": "cpu017", "socket-id": 0, "die-id": 0, "core-id": 11, "thread-id": =
1 } }
>=20
> I wondered initially if this approach was breaking some convention, but I
> have not found anything stating even a "random order" is disallowed. So
> here we are...

It's not disallowed, just unusual, obviously.

> >> The separate full-ID entry remains unaffected, and destination 0x113
> >> continues to select vCPU 275.
> >>=20
> >> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> >> Signed-off-by: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
> >> ---
> >>  arch/x86/kvm/lapic.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> >> index 1597dd0b0cc6..5dedffddebec 100644
> >> --- a/arch/x86/kvm/lapic.c
> >> +++ b/arch/x86/kvm/lapic.c
> >> @@ -245,7 +245,9 @@ static int kvm_recalculate_phys_map(struct kvm_api=
c_map *new,
> >>  		if (apic_x2apic_mode(apic) || x2apic_id > 0xff)
> >>  			new->phys_map[x2apic_id] =3D apic;
> >> =20
> >> -		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
> >> +		if (!apic_x2apic_mode(apic) &&
> >> +		    (!new->phys_map[xapic_id] ||
> >> +		     x2apic_id < new->phys_map[xapic_id]->vcpu->vcpu_id))
> >=20
> > Hmm, I don't think KVM should always override a smaller ID.  It should =
be a moot
>=20
> Why should it not always override the smaller ID (in cases where
> KVM_X2APIC_API_USE_32BIT_IDS is enabled)? I interpret the wording from
> x2APIC section in:
> https://www.kernel.org/doc/Documentation/virt/kvm/x86/errata.rst
>=20
> "KVM will deliver events targeting that APIC ID only to the vCPU with the
> lowest vCPU ID"

Gah, foiled by my own documentation.  I had this wrong in my head.  It's no=
t the
aliasing logic that matters, it's literally the behavior of the optimized m=
ap that
I was documenting.

> as having the consequence that we should always replace an existing entry
> in the map with an incoming lower vCPU ID, but the potential corner cases
> in this space make my head hurt :).
> I think xAPIC ID is unfortunately writable, so perhaps that is the sort o=
f
> scenario you are thinking about?
>=20
> > point, since xapic_id_mismatch will be set if "xapic_id !=3D (u8)vcpu->=
vcpu_id",
> > i.e. if the incoming vCPU has a smaller vCPU ID and a true xAPIC ID col=
lision
> > (not due to truncation).  But to match kvm_apic_match_physical_addr(), =
I think
> > it would be this?
> >=20
> > 		if (!apic_x2apic_mode(apic) &&
> > 		    (!new->phys_map[xapic_id] ||
> > 		     (u8)new->phys_map[xapic_id]->vcpu->vcpu_id =3D=3D vcpu->vcpu_id)=
)
> >=20
>=20
> The above works for the case described in the commit, but going one step
> further, I think it doesn't behave correctly in this case:
>=20
> vCPU 531 (0x213) is created first
> vCPU 275 (0x113) is created after
>=20
> the map is not updated and will still point to the lapic of vCPU 531.
> Reversing the creation order above leaves the map with vCPU 275.
> If my reading of errata.rst is accurate, then vCPU 275 (i.e. the lowest
> vCPU ID) should always be selected regardless of creation order.

Yeah, ignore that.

Backing up a step, what exactly is the problem you're trying to solve?  Bec=
ause
I suspect there's no solution that will magically fix everything.  E.g. if =
you're
trying to resolve an issue where vCPUs aren't recognizing SIPIs, then the e=
xample
you provided means vCPU_531 will never wakeup, i.e. which vCPU is  "buggy" =
changes,
but the bug itself is still there.

If this is about SIPIs hitting the all CPUs, then I think to have a robust =
(well,
as robust as this mess can get) implementation, we'd have to disable use of=
 the
optimized map when processing SIPIs with PHYSICAL delivery, e.g.

diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm=
/x86/errata.rst
index a9cf0e004651..65b8a612bfff 100644
--- a/Documentation/virt/kvm/x86/errata.rst
+++ b/Documentation/virt/kvm/x86/errata.rst
@@ -63,10 +63,10 @@ When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM activ=
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
+have the same physical APIC ID, KVM *may* deliver events targeting that AP=
IC ID
+to only one of the vCPUs.  If KVM_X2APIC_API_USE_32BIT_IDS is not enabled,=
 KVM
+follows x86 architecture when processing interrupts (all vCPUs matching th=
e
+target APIC ID receive the interrupt).
=20
 MTRRs
 -----
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ecf611845fb1..255c8dc00e0a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1181,6 +1181,10 @@ static inline bool kvm_apic_map_get_dest_lapic(struc=
t kvm *kvm,
 		return false;
=20
 	if (irq->dest_mode =3D=3D APIC_DEST_PHYSICAL) {
+		if (kvm->arch.x2apic_format &&
+		    irq->delivery_mode =3D=3D APIC_DM_STARTUP)
+			return false;
+
 		if (irq->dest_id > map->max_apic_id) {
 			*bitmap =3D 0;
 		} else {

