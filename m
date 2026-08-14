Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A840B101;
	Fri, 14 Aug 2026 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692471; cv=none; b=HnfH4fcE4QcuRYPcdWCgRMzt56XBeoTQIy0IN1v7nPCHryOyR50Ha7CH3BW3Owp7TFLzqaQS55IIunYyAUjoJs3xNijonJYYyJYpAIyXLcweZaE9Y1cTl7rqA9fSa7PTrwDBlKgQUOQxD34ap2eTAwKvL0xc8JeR9qgCfrJxD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692471; c=relaxed/simple;
	bh=Kd0q8V5dV4Y6+XrUTBtPO9T7qu721ViH0XAhvS67hsA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g29/PHv8HS3gj40ICjNEBKkO7wVPZHgz76pT/aE6Xo5japWLnxUvdBQssAqpKOcrWKwRnryF/1fpyXOXmWYYnD2w2sXa6qMVToOu5pRleBlECfeS1YcaDPFAX/KHgVj5mtLGclW2I0HVu91vm7Yhli+PoTDx+6eSjNZeep4ZGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n9M+1nUZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n9M+1nUZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XgbACiF0VbZQ3qTHeTv3h3pqeu4o7TCVK0pEMR7P+5Q=; b=n9M+1nUZlJt8tJ67mjvev4cQFd
	sYq7ADrcn5SliAXKKRtIA97idnKt8ci6mvXXyN8bTgh5qfyRpQU5AGTkiVfN+PaA6iXJiMBJpKgtp
	FLhBo8ORKw9nrU0IbeS7hyyAcGRmfl42TqhbAU3b++ilVruvKF7kaH7eJUmcSe1UTcGBl//vZeV4K
	iitnGvLVzwy6sMQO7msIbZWSFBS3t+3mO3wgyjvXCTBkbMPlAVsgcCyl4kkd1DqQmn4M9MBJQjxlY
	DbMRHQunsmo5E4hyR/GnixqWJcJP32keo2WGJgQthe3KV8IJuZpu20wk7N14HkUfciJhnk9YyhPYA
	DY5INBig==;
Received: from [2001:8b0:10b:5:84af:4c52:575c:6551] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wumK8-00000004oGV-1zYP;
	Fri, 14 Aug 2026 07:27:28 +0000
Message-ID: <4420099fedce20021d6cc5aeb1aa270c7951c552.camel@infradead.org>
Subject: Re: [PATCH v7 31/36] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,  Borislav Petkov	 <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"	
 <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross	
 <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul
 Durrant	 <paul@xen.org>, Jonathan Cameron <jic23@kernel.org>, Sascha
 Bischoff	 <Sascha.Bischoff@arm.com>, Marc Zyngier <maz@kernel.org>, Joey
 Gouly	 <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, Dongli
 Zhang	 <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Date: Fri, 14 Aug 2026 08:27:19 +0100
In-Reply-To: <anuy6QxUVLcSSVCn@google.com>
References: <20260728144954.355376-1-dwmw2@infradead.org>
	 <20260728144954.355376-32-dwmw2@infradead.org>
	 <anuy6QxUVLcSSVCn@google.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-i/xjFyj0sIBrhyIUdgpg"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa9~24.04 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-i/xjFyj0sIBrhyIUdgpg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-08-11 at 16:40 -0700, Sean Christopherson wrote:
>=20
> Invoking kvm_guest_time_update() here is probably a deal-breaker.=C2=A0 U=
pdating the
> master clock and other internal state is far from ideal, but should be ok=
.
>=20
> However, writing guest memory is not.=C2=A0 Specifically, dirtying memory=
 after the
> last KVM_RUN is a non-starter for many usecases, as is modifying state th=
at is
> visible via other GET uAPI (though I don't think that applies here?).=C2=
=A0 E.g. see
> commits:

Ack. Calling kvm_guest_time_update() is also *entirely* pointless. We
are in masterclock mode, by definition, as this ioctl only works in
masterclock mode. So kvm_guest_time_update() isn't actually creating
any new information; it just calculates the same per-VM tsc_shift/mul.
And kvm_vcpu_ioctl_get_clock_guest() could just use those directly.
Even better, it can do so *inside* the seqcount loop.

Fixup below (not amending commits while you're co-opting the tree, as
we'd both go insane). I'll push it to the top of=20
https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Drefs/=
heads/kvmclock9-part2
on top of with the offset test which is already there.

>  And we'd probably want to build on my idea to report that
> KVM_RUN needs completion[*], but that'd be a good thing overall.
>=20
> https://lore.kernel.org/all/20250111012450.1262638-1-seanjc@google.com=C2=
=A0

Aha... *that* is why I found that lore thread open in my browser
yesterday; I was confused about how I'd got there. It's missing
KVM_EXIT_XEN btw. (Of which, KVM_EXIT_XEN_HYPERCALL is the only
subtype. I suspect Jo=C3=A3o originally expected that there would be more).

=46rom d2e54f439f0a5c0f2bddeaead916b23daedb2b2f Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Fri, 14 Aug 2026 07:56:58 +0100
Subject: [PATCH] fixup! KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate K=
VM
 clock migration

Make KVM_GET_CLOCK_GUEST stateless, never writing guest memory.

Invoking kvm_guest_time_update() from the GET ioctl writes the guest's
pvclock pages, and dirtying guest memory after the final KVM_RUN breaks
migration flows which have already completed their last dirty-log pass.

There is no need for it. The only outputs previously taken from the
vCPU's shadow pvclock were tsc_shift and tsc_to_system_mul, and in
master clock mode (which this ioctl requires; it returns -ENODATA
otherwise) those are identical to the master clock's own mul/shift:
both are computed by kvm_get_time_scale() from the same guest TSC
frequency, which all vCPUs share. Use ka->master_tsc_{shift,mul}
directly, which pvclock_update_vm_gtod_copy() precomputed for exactly
this kind of vCPU-less consumer.

The only remaining per-vCPU input is kvm_read_l1_tsc(), which is a pure
read, translating the master clock snapshot into the vCPU's own TSC
domain.

This also removes the -EBUSY case and the special handling of a vCPU
which has never run: the master clock state exists from VM creation,
so the pvclock can always be constructed. And it moves the reads of
tsc_shift, tsc_to_system_mul and flags inside the seqcount loop, where
they should have been all along: previously they could tear against a
concurrent master clock update.

A KVM_REQ_CLOCK_UPDATE pending on the vCPU is now left pending rather
than being consumed: the pvclock returned here is anchored to the
current master clock snapshot and describes the same linear function
of the guest TSC as the guest-visible copy, so there is nothing to
refresh. The guest's own pages are updated, as ever, only from KVM_RUN.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8eb73e3ada66..4de98cc16751 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3460,27 +3460,22 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcp=
u *vcpu,
 static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __user =
*argp)
 {
 	struct pvclock_vcpu_time_info hv_clock =3D {};
-	struct kvm_vcpu_arch *vcpu =3D &v->arch;
 	struct kvm_arch *ka =3D &v->kvm->arch;
 	unsigned int seq;
=20
 	/*
-	 * If KVM_REQ_CLOCK_UPDATE is already pending, or if the pvclock
-	 * has never been generated at all, call kvm_guest_time_update().
-	 * Its only failure mode is transient (the TSC frequency of the
-	 * current CPU is momentarily unknown), so return -EBUSY to tell
-	 * userspace to try again.
-	 */
-	if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, v) || !vcpu->hw_tsc_hz) {
-		guard(srcu)(&v->kvm->srcu);
-
-		if (kvm_guest_time_update(v))
-			return -EBUSY;
-	}
-
-	/*
-	 * Reconstruct the pvclock from the master clock state, matching
-	 * exactly what kvm_guest_time_update() writes to the guest.
+	 * Construct the pvclock purely from the master clock state. The
+	 * master mul/shift are computed for the guest TSC frequency, which
+	 * in master clock mode is the frequency of every vCPU; only the
+	 * tsc_timestamp is per-vCPU, translating the master snapshot into
+	 * this vCPU's TSC domain via its scaling ratio and offset.
+	 *
+	 * Note, this deliberately does NOT invoke kvm_guest_time_update(),
+	 * which would write the guest's pvclock pages: dirtying guest
+	 * memory after the final KVM_RUN would break post-copy migration
+	 * flows. The pvclock returned here describes the same clock as the
+	 * guest-visible copy (the same linear function of the guest TSC),
+	 * anchored at the current master clock snapshot.
 	 */
 	do {
 		seq =3D read_seqcount_begin(&ka->pvclock_sc);
@@ -3490,12 +3485,12 @@ static int kvm_vcpu_ioctl_get_clock_guest(struct kv=
m_vcpu *v, void __user *argp)
=20
 		hv_clock.tsc_timestamp =3D kvm_read_l1_tsc(v, ka->master_cycle_now);
 		hv_clock.system_time =3D ka->master_kernel_ns + ka->kvmclock_offset;
+		hv_clock.tsc_shift =3D ka->master_tsc_shift;
+		hv_clock.tsc_to_system_mul =3D ka->master_tsc_mul;
+		hv_clock.flags =3D ka->all_vcpus_matched_tsc ?
+				 PVCLOCK_TSC_STABLE_BIT : 0;
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
=20
-	hv_clock.tsc_shift =3D vcpu->pvclock_tsc_shift;
-	hv_clock.tsc_to_system_mul =3D vcpu->pvclock_tsc_mul;
-	hv_clock.flags =3D ka->all_vcpus_matched_tsc ? PVCLOCK_TSC_STABLE_BIT : 0=
;
-
 	if (copy_to_user(argp, &hv_clock, sizeof(hv_clock)))
 		return -EFAULT;
=20
--=20
2.43.0


--=-i/xjFyj0sIBrhyIUdgpg
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
b3A3X/0eYkDc0iK6F8STZroAAAAAAAA=


--=-i/xjFyj0sIBrhyIUdgpg--
