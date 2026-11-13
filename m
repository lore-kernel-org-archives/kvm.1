Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794545775;
	b=D6R+bsF2UsEoz50t6kstrcLYH4UqXpHLPkN323lM3k+wHGYa232KAzjrzHePiZMYL3pC
	 kWJsWYeif7Uj7nC1alyyEkVimfd9nHoH0kFb4Wy6AXysHCrFYjdjLbhUqdK5kKSNxLPoT
	 kW6PNPUB6YjIBuSQ+FBh7WYIJ3Fskup4xIhfuYdCQdKpDg27Gxuqu1K03RSpD/3xXwKjN
	 gHUMlaFacApFLoZfNsigVXHHUluASpvogUAAEVsJA3qDC/0T0bzBBdTMju9/p9DEi3UCH
	 lNRZ/CzgMQOo7pdWQ6xEXCL7LGlNm+axCgf7wa2ZkJ+K/93W2odI97EYqvnaucBilQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794545775;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 X-SRS-Rewrite;
	bh=T+oEfjvUYfeS2jcEjbGNkeJDkSZMlD9O6coiA1vHEUY=;
	b=UVhTrys2JxNO58parJKInvIPPXamMj57fk0BssVpODZFn8MUqnt364edq0Xw9dqWRh09
	 S+P18F3TbtJxNUpd3KYYTcTRh/LheNIfhrrh9vgK8HzJRHc+waoMT/EUlPvX1kS22b+U6
	 v+Goq80J0z75IBxZIYcQfDCu2YImQhIlHZdjlJ6NeyKgc542c8faD92XL4vTHTUN9aepZ
	 Gt2b5uPHMuj4LLTYR0gM+uGrvIGTMQjZ9zvh736tfIhzh+kGSLjp1P9Alarz3GA8HE+7p
	 wIazrkYci5kdNFkxc3yKwzTkKzSvslMugFov1CBTb6zxa38/1OFwfLcCWAfSeL6PcTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=VWv8nlJn;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB8606A32A;
	Fri, 13 Nov 2026 04:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6DB8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=VWv8nlJn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T+oEfjvUYfeS2jcEjbGNkeJDkSZMlD9O6coiA1vHEUY=; b=VWv8nlJnBo0alPWwnCOhfmtoG7
	Z6nAmPyqZdXPCQLN9e3UdNDRowzb/Rc0NgaCqSimU1QDoqR9AkIQJ/JAZgbm8Rh4Vl2KYS82PO0rE
	hjYhaywSkBT6LgcYxflibcpScVO+52sh9mzNI7QHTzN/2jUbiBazKpCUvXXUy8DUzYhnSVcPUtTid
	gCthSE65B75/7Z9SjBe8PBcO9B45WI+mtAyedNftaMd1CALETVQMtZRbpZzyp6ia4oicQZf/7ffqy
	HN8XdoVUshbVvpaqgQlihmlT8hEfQ+tLw7GFYCNjacF0RGBopWmUKrRu49mZSV2TvuHrSDOP03dC8
	oI5iPLew==;
Received: from [205.251.233.178] (helo=edge-m3-r3-132.e-iad51.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRjKa-0000000EeIl-3ssr;
	Fri, 13 Nov 2026 04:56:09 +0000
Message-ID: <1bae109338ab6ff1ff14eac811f7e86ced785b22.camel@infradead.org>
Subject: Re: [PATCH v3 06/12] KVM: x86: Forward VMware hypercalls to
 userspace
From: David Woodhouse <dwmw2@infradead.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, 	kvm@vger.kernel.org, Doug Covelli
 <doug.covelli@broadcom.com>, Thomas Gleixner	 <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,  Vitaly Kuznetsov
 <vkuznets@redhat.com>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>,
 Francesco Lavra	 <flavra@baylibre.com>, Radim
 =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=	 <rkrcmar@ventanamicro.com>, Liran Alon
 <liran.alon@oracle.com>, Arbel Moshe	 <arbel.moshe@oracle.com>,
 linux-doc@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, 	linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 21:56:02 -0700
In-Reply-To: <CABQX2QNd7DehBsH-pGL=EJK4b5vC60PymL_YP27xDxGT6_6=uQ@mail.gmail.com>
References: <cover.1794374897.git.zack.rusin@broadcom.com>
	 <90467782be23b83fd3e9a6afe2f1d2149eaf9db9.1794374897.git.zack.rusin@broadcom.com>
	 <876c4f4fc442116c9bff8abd8c34f99fcfa65531.camel@infradead.org>
	 <CABQX2QNd7DehBsH-pGL=EJK4b5vC60PymL_YP27xDxGT6_6=uQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-CFyM1B/XdFivdA2phzjc"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-CFyM1B/XdFivdA2phzjc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-11-12 at 20:05 -0500, Zack Rusin wrote:
>=20
> > And I wonder if the cleaner answer in both cases is just to give
> > userspace a way to cancel the pending hypercall completion and use
> > KVM_SET_VCPU_EVENTS instead of piling all this stuff into the hcall
> > structs? It could even just be a KVM_VCPUEVENT_ flag to make it cancel
> > the hypercall completion?
>=20
> I agree that this would be cleaner, and if KVM grows such a flag,
> VMware userspace could use it too.=C2=A0 But it's new API in
> KVM_SET_VCPU_EVENTS, and we'd need to agree which completions it may
> cancel: simply clearing the callback leaves pending I/O state behind
> for PIO and MMIO, and KVM_EXIT_HYPERCALL also covers TDX completions
> with different semantics.=C2=A0 So I'd rather not make this series depend
> on it because it significantly increases its scope.

I won't necessarily defend my suggestion above to the hilt on its
technical merit, but I'll observe that as a counter-argument, yours
*really* isn't a good one. We don't design a userspace ABI based on the
fact that we're impatient.

To your concern, I actually think we could get away with aborting *any*
pending complete_userspace_io callback. Userspace *already* needed to
know about those=C2=B9 because it can't migrate while those are pending; it
has to do at least one more run, even if it's with the immediate_exit
flag set.

If it's deemed clearer, I'd also be OK with an explicit
KVM_VCPUEVENT_CANCEL_HCALL which cancels *only* hypercalls. But I don't
really see the point; userspace shouldn't be getting confused when it
was actually some other kind of completion that was active anyway.

=C2=B9 https://lore.kernel.org/all/20250111012450.1262638-1-seanjc@google.c=
om/

Looks something like this in my Hyper-V hcall series (except I already
shouted at the agent for stupid struct layout and made it go run pahole
on everything it's working on).

=46rom bc25df8c84af07f7ddf74dd762ba35adbe5fba75 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Fri, 13 Nov 2026 04:39:31 +0000
Subject: [PATCH] KVM: x86: Let userspace cancel a pending hypercall complet=
ion

A VMM implementing Hyper-V hypercalls behind KVM_EXIT_HYPERV_HCALL can
only complete them: write a status, advance RIP.  The TLFS specifies
some hypercalls to raise an exception at the hypercall instruction
instead, and the exit has no way to say that.  The KVM_EXIT_VMWARE
series has the same problem for its backdoor exits, so solve it without
touching the exit format at all: cancel the pending completion, and
queue the exception through the machinery KVM_SET_VCPU_EVENTS already
has.

KVM_VCPUEVENT_CANCEL_HCALL on KVM_SET_VCPU_EVENTS drops the pending
completion: no result write, no RIP advance, so the guest re-executes
the hypercall on its next entry unless the same call queued an
exception to be delivered there.  Hyper-V hypercalls are restartable by
design, so both outcomes are architecturally sound.  If nothing
cancellable is pending - nothing at all, or a completion KVM armed for
its own purposes, like the MMIO and PIO emulation continuations - the
ioctl fails with EBUSY and changes nothing.  Only the Hyper-V hypercall
userspace exits are cancellable.

KVM_SET_VCPU_EVENTS offers no way to probe for a new flag, so
KVM_CHECK_EXTENSION(KVM_CAP_VCPU_EVENTS) grows from 1 into a feature
mask: KVM_VCPU_EVENTS_BASE keeps existing truth-value checks working,
and KVM_VCPU_EVENTS_CANCEL_HCALL advertises the new flag.

Link: https://lore.kernel.org/all/876c4f4fc442116c9bff8abd8c34f99fcfa65531.=
camel@infradead.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  | 18 ++++++++++++++++++
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/include/uapi/asm/kvm.h |  7 +++++++
 arch/x86/kvm/hyperv.c           |  6 ++++++
 arch/x86/kvm/x86.c              | 29 +++++++++++++++++++++++++++--
 5 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rs=
t
index e95c9cda085d..69c5523b8265 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1302,6 +1302,24 @@ If KVM_CAP_X86_TRIPLE_FAULT_EVENT is enabled, KVM_VC=
PUEVENT_VALID_TRIPLE_FAULT
 can be set in flags field to signal that the triple_fault field contains
 a valid state and shall be written into the VCPU.
=20
+On x86, KVM_CHECK_EXTENSION(KVM_CAP_VCPU_EVENTS) returns a feature mask:
+KVM_VCPU_EVENTS_BASE for the two ioctls themselves, and
+KVM_VCPU_EVENTS_CANCEL_HCALL when KVM_SET_VCPU_EVENTS accepts
+KVM_VCPUEVENT_CANCEL_HCALL in the flags field.
+
+KVM_VCPUEVENT_CANCEL_HCALL cancels a pending, cancellable hypercall
+completion, i.e. a KVM_EXIT_HYPERV_HCALL exit that userspace is holding.
+KVM forgets the completion: the hypercall's result is never written and
+its instruction is never retired, so the vCPU re-executes the hypercall
+instruction on its next entry unless the same call queued an exception
+to be delivered there instead.  Hyper-V hypercalls are restartable by
+design, so either is architecturally sound; this is how a VMM makes a
+hypercall fault (e.g. #UD, or #PF with the address in
+exception_payload) rather than return a status.  If no completion is
+pending, or the pending completion is not cancellable (for example an
+MMIO or PIO emulation continuation), the ioctl fails with EBUSY and
+changes nothing.
+
 ARM64:
 ^^^^^^
=20
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 1ee4b127004d..c2e7e90016fb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -857,6 +857,8 @@ struct kvm_vcpu_arch {
 	bool emulate_regs_need_sync_to_vcpu;
 	bool emulate_regs_need_sync_from_vcpu;
 	int (*complete_userspace_io)(struct kvm_vcpu *vcpu);
+	/* KVM_SET_VCPU_EVENTS may cancel the pending completion. */
+	bool cui_cancellable;
 	unsigned long cui_linear_rip;
 	int cui_rdmsr_imm_reg;
=20
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kv=
m.h
index 00ce265391e1..a886830f663c 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -330,6 +330,13 @@ struct kvm_reinject_control {
 #define KVM_VCPUEVENT_VALID_PAYLOAD	0x00000010
 #define KVM_VCPUEVENT_VALID_TRIPLE_FAULT	0x00000020
=20
+/* Cancels a pending, cancellable hypercall completion on KVM_SET_VCPU_EVE=
NTS */
+#define KVM_VCPUEVENT_CANCEL_HCALL	0x00000040
+
+/* KVM_CHECK_EXTENSION(KVM_CAP_VCPU_EVENTS) feature bits */
+#define KVM_VCPU_EVENTS_BASE		0x00000001
+#define KVM_VCPU_EVENTS_CANCEL_HCALL	0x00000002
+
 /* Interrupt shadow states */
 #define KVM_X86_SHADOW_INT_MOV_SS	0x01
 #define KVM_X86_SHADOW_INT_STI		0x02
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5d2e3617c952..549da771d620 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2712,6 +2712,12 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	vcpu->run->hyperv.u.hcall.params[0] =3D hc.ingpa;
 	vcpu->run->hyperv.u.hcall.params[1] =3D hc.outgpa;
 	vcpu->arch.complete_userspace_io =3D kvm_hv_hypercall_complete_userspace;
+	/*
+	 * Userspace may revoke this completion through KVM_SET_VCPU_EVENTS
+	 * instead of completing it; the guest then re-executes the hypercall
+	 * instruction.
+	 */
+	vcpu->arch.cui_cancellable =3D true;
 	return 0;
 }
=20
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff8a0..20d7940a7e74 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2237,7 +2237,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
 	case KVM_CAP_IOEVENTFD_NO_LENGTH:
=20
 	case KVM_CAP_SET_IDENTITY_MAP_ADDR:
-	case KVM_CAP_VCPU_EVENTS:
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_CAP_HYPERV:
 	case KVM_CAP_HYPERV_VAPIC:
@@ -2305,6 +2304,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
 	case KVM_CAP_EXIT_HYPERCALL:
 		r =3D KVM_EXIT_HYPERCALL_VALID_MASK;
 		break;
+	case KVM_CAP_VCPU_EVENTS:
+		r =3D KVM_VCPU_EVENTS_BASE | KVM_VCPU_EVENTS_CANCEL_HCALL;
+		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
 		return KVM_GUESTDBG_VALID_MASK;
 #ifdef CONFIG_KVM_XEN
@@ -3047,9 +3049,21 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct=
 kvm_vcpu *vcpu,
 			      | KVM_VCPUEVENT_VALID_SHADOW
 			      | KVM_VCPUEVENT_VALID_SMM
 			      | KVM_VCPUEVENT_VALID_PAYLOAD
-			      | KVM_VCPUEVENT_VALID_TRIPLE_FAULT))
+			      | KVM_VCPUEVENT_VALID_TRIPLE_FAULT
+			      | KVM_VCPUEVENT_CANCEL_HCALL))
 		return -EINVAL;
=20
+	/*
+	 * Refuse the cancel unless a cancellable completion is pending: the
+	 * flag is only valid on the vCPU whose KVM_EXIT_HYPERV_HCALL exit
+	 * userspace is holding, and a completion KVM armed for its own
+	 * purposes (MMIO and PIO emulation continuations) is not userspace's
+	 * to revoke.
+	 */
+	if ((events->flags & KVM_VCPUEVENT_CANCEL_HCALL) &&
+	    (!vcpu->arch.complete_userspace_io || !vcpu->arch.cui_cancellable))
+		return -EBUSY;
+
 	if (events->flags & KVM_VCPUEVENT_VALID_PAYLOAD) {
 		if (!vcpu->kvm->arch.exception_payload_enabled)
 			return -EINVAL;
@@ -3147,6 +3161,16 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct=
 kvm_vcpu *vcpu,
 			kvm_clear_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 	}
=20
+	/*
+	 * Drop the pending completion: nothing retires the hypercall
+	 * instruction, so the vCPU re-executes it on its next entry unless
+	 * this call queued an exception to be delivered there instead.
+	 */
+	if (events->flags & KVM_VCPUEVENT_CANCEL_HCALL) {
+		vcpu->arch.complete_userspace_io =3D NULL;
+		vcpu->arch.cui_cancellable =3D false;
+	}
+
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
=20
 	return 0;
@@ -9046,6 +9070,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	if (unlikely(vcpu->arch.complete_userspace_io)) {
 		int (*cui)(struct kvm_vcpu *) =3D vcpu->arch.complete_userspace_io;
 		vcpu->arch.complete_userspace_io =3D NULL;
+		vcpu->arch.cui_cancellable =3D false;
 		r =3D cui(vcpu);
 		if (r <=3D 0)
 			goto out;
--=20
2.50.1



--=-CFyM1B/XdFivdA2phzjc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
jeIVGHKLsFqoF7npFEmndlkAAAAAAAA=


--=-CFyM1B/XdFivdA2phzjc--
