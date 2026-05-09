Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4558C1F;
	Sat,  9 May 2026 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778357073; cv=none; b=baE0c3v+gchR7lh/Ar/vIOeH5+dNmMtWt8lqJ0EtgCU2hVLn3uysPjNT7WMZcYhNN+XbYKn3m80gVJVgPpRjYyT6nSk0ng0U/ulUuOs92P8Yl2qJ78/Lt603D7qQgS9pEz9Sb/mItny9bWn4rQoBbFOYrg+W2YPH++aHb+kuigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778357073; c=relaxed/simple;
	bh=WGh2Jf3psqPykvLuH63MEjEO2oUIDtYUKKnSTt/EUwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H91vRJiSBh07jcyROoCioPO+IAgXUpJF/fdAFhYMzxazO8p1XfykDXgEoVPUKTfO6g3iNOmZ/eUgVkT7HkJqM9/eYBwl1qYfuIuX6hRsOPmwrYOn63O0do77/H+9yTIQPVMrYjw/MPuFjdgf8664vk04MhjKpsCUKVJT7p6Z7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sbfyr5ge; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sbfyr5ge"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QpiEqEep9lpNIc0nOkdVY8IEWGql96w36gYjt32ZehE=; b=Sbfyr5get43KEDCs4C7+Rvs1DX
	a10KlTxNPrz8LjAjB6SRm6cfuMQCr9R/O4R06ko6wrJkkCOwd8WXos+uvyvNbRNExSkV+UmNOCf6I
	yIUElxE7DNac+DSZaYZxU9kzzqNftf3aad+fwzG+fzIHZ/8wBQHv//qqJqo00816DkD85kgBS3FTV
	fz0K90mT9DS7roXP+uKdiadUszR9YaKSpvrJvEotQJ61znkeD81hzFG+HZuTrb2MXp+Kp4fSaz9V3
	S5BSNfDJtpGlK0LPYjlKnMhTlZLyPFspUao9LSe0Y2TTaIiLQzhc4Uy+TlRRqCJwkpctlo/7pH2hC
	6o6Jf9zA==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLnuS-00000008p1C-0zzQ;
	Sat, 09 May 2026 20:04:24 +0000
Message-ID: <f37f0ae0ae1dfce3ad3c6fce653f5df34adecc0a.camel@infradead.org>
Subject: Re: [PATCH 2/3] KVM: x86: conditionally clear
 KVM_REQ_MASTERCLOCK_UPDATE at the end of KVM_SET_CLOCK
From: David Woodhouse <dwmw2@infradead.org>
To: Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, paul@xen.org, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org,  hpa@zytor.com, linux-kernel@vger.kernel.org,
 joe.jin@oracle.com
Date: Sat, 09 May 2026 21:04:24 +0100
In-Reply-To: <20260115202256.119820-3-dongli.zhang@oracle.com>
References: <20260115202256.119820-1-dongli.zhang@oracle.com>
	 <20260115202256.119820-3-dongli.zhang@oracle.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-uO867jHlf1GngfDO+c/9"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-uO867jHlf1GngfDO+c/9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-01-15 at 12:22 -0800, Dongli Zhang wrote:
> The KVM_SET_CLOCK command calls pvclock_update_vm_gtod_copy() to update t=
he
> masterclock data.
>=20
> Many vCPUs may already have KVM_REQ_MASTERCLOCK_UPDATE pending before
> KVM_SET_CLOCK is invoked. If pvclock_update_vm_gtod_copy() decides to use
> the masterclock, there is no need to update the masterclock multiple time=
s
> afterward. As noted in commit c52ffadc65e2 ("KVM: x86: Don't unnecessaril=
y
> force masterclock update on vCPU hotplug"), each unnecessary
> KVM_REQ_MASTERCLOCK_UPDATE can cause the kvm-clock time to jump.
>=20
> Therefore, clear KVM_REQ_MASTERCLOCK_UPDATE for each vCPU at the end of
> KVM_SET_CLOCK when the master clock is active. The 'tsc_write_lock' ensur=
es
> that only requests issued before KVM_SET_CLOCK are cleared.

Hm, I think we should do this in kvm_make_mclock_inprogress_request()
instead.

Currently, things like pvclock_gtod_update_fn() and one or two others
set KVM_REQ_MASTERCLOCK_UPDATE for all vCPUs. Not just one, because we
don't want *any* vCPU going back into guest mode before doing the work.

So they could *all* end up calling into kvm_masterclock_update() at the
same time. I have a vague recollection there was once a mutex there,
but now there isn't.

So all vCPUs can each, in parallel, set KVM_REQ_MCLOCK_INPROGRESS on
all other vCPUs. That's an unhandled request which just makes a vCPU
spin (preventing it from entering the guest until the clock update
completes).

Then each vCPU tries to take the kvm->arch.tsc_write_lock in
kvm_start_pvclock_update(), and from this point they'll be
serialized... but every vCPU will go through the whole of
pvclock_update_vm_gtod_copy() for itself, updating the masterclock one
more time for each vCPU in the system?

I came here to say that kvm_make_mclock_inprogress_request() should
probably clear KVM_REQ_MASTERCLOCK_UPDATE on all other vCPUs, since
it's about to do the work, and the other vCPUs will no longer need to.

But... it's more broken than that now.=20

I think maybe vcpu_enter_guest() should call kvm_update_masterclock()
if *kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE)* (i.e. not *clear* the
bit by using kvm_check_request()).

And then after getting ->arch.tsc_write_lock,
kvm_start_pvclock_update() should check if KVM_REQ_MASTERCLOCK_UPDATE
is *still* set, and only proceed with the update if it is?

I'll play with it some more... something like this perhaps?

=46rom 91e37d74ee267c722bc2c8f26754fcdfbc040e29 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Sat, 9 May 2026 16:54:01 +0100
Subject: [PATCH] KVM: x86: Avoid redundant masterclock updates from multipl=
e
 vCPUs

When a masterclock update is triggered (e.g. by the clocksource change
notifier), KVM_REQ_MASTERCLOCK_UPDATE is set on all vCPUs. Without this
fix, each vCPU independently processes the request and redundantly
re-executes the entire pvclock_update_vm_gtod_copy() sequence, serialized
only by tsc_write_lock. Each redundant re-snapshot of the master clock
reference point introduces potential clock drift.

Fix this by having __kvm_start_pvclock_update() check, after acquiring
the lock, whether the requesting vCPU's KVM_REQ_MASTERCLOCK_UPDATE is
still set. If another vCPU already did the update and cleared it, bail
out. Otherwise, clear the request on all other vCPUs before proceeding.

The caller in vcpu_enter_guest() now uses kvm_test_request() (non-clearing)
since the clearing is done inside __kvm_start_pvclock_update() under the
lock.

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 56 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ed0f7dec08bd..b249c4a6048c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3259,10 +3259,39 @@ static void kvm_make_mclock_inprogress_request(stru=
ct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MCLOCK_INPROGRESS);
 }
=20
-static void __kvm_start_pvclock_update(struct kvm *kvm)
+static void kvm_clear_mclock_inprogress_request(struct kvm *kvm)
 {
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
+}
+
+static bool __kvm_start_pvclock_update(struct kvm *kvm, struct kvm_vcpu *r=
equesting_vcpu)
+{
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
 	raw_spin_lock_irq(&kvm->arch.tsc_write_lock);
+
+	/*
+	 * If another vCPU already did the update while we were waiting
+	 * for the lock, our request will have been cleared. Bail out.
+	 */
+	if (requesting_vcpu &&
+	    !kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, requesting_vcpu)) {
+		kvm_clear_mclock_inprogress_request(kvm);
+		raw_spin_unlock_irq(&kvm->arch.tsc_write_lock);
+		return false;
+	}
+
+	/* The update is VM-wide; prevent other vCPUs from redoing it. */
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_clear_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
+
 	write_seqcount_begin(&kvm->arch.pvclock_sc);
+	return true;
 }
=20
 static void kvm_start_pvclock_update(struct kvm *kvm)
@@ -3270,7 +3299,7 @@ static void kvm_start_pvclock_update(struct kvm *kvm)
 	kvm_make_mclock_inprogress_request(kvm);
=20
 	/* no guest entries from this point */
-	__kvm_start_pvclock_update(kvm);
+	__kvm_start_pvclock_update(kvm, NULL);
 }
=20
 static void kvm_end_pvclock_update(struct kvm *kvm)
@@ -3279,22 +3308,25 @@ static void kvm_end_pvclock_update(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
=20
-	write_seqcount_end(&ka->pvclock_sc);
-	raw_spin_unlock_irq(&ka->tsc_write_lock);
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
=20
 	/* guest entries allowed */
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
+	kvm_clear_mclock_inprogress_request(kvm);
+
+	write_seqcount_end(&ka->pvclock_sc);
+	raw_spin_unlock_irq(&ka->tsc_write_lock);
 }
=20
-static void kvm_update_masterclock(struct kvm *kvm)
+static void kvm_update_masterclock(struct kvm *kvm, struct kvm_vcpu *vcpu)
 {
 	kvm_hv_request_tsc_page_update(kvm);
-	kvm_start_pvclock_update(kvm);
-	pvclock_update_vm_gtod_copy(kvm);
-	kvm_end_pvclock_update(kvm);
+	kvm_make_mclock_inprogress_request(kvm);
+
+	if (__kvm_start_pvclock_update(kvm, vcpu)) {
+		pvclock_update_vm_gtod_copy(kvm);
+		kvm_end_pvclock_update(kvm);
+	}
 }
=20
 /*
@@ -11481,8 +11513,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_mmu_free_obsolete_roots(vcpu);
 		if (kvm_check_request(KVM_REQ_MIGRATE_TIMER, vcpu))
 			__kvm_migrate_timers(vcpu);
-		if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
-			kvm_update_masterclock(vcpu->kvm);
+		if (kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
+			kvm_update_masterclock(vcpu->kvm, vcpu);
 		if (kvm_check_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu))
 			kvm_gen_kvmclock_update(vcpu);
 		if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, vcpu)) {
--=20
2.43.0



--=-uO867jHlf1GngfDO+c/9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUwOTIwMDQy
NFowLwYJKoZIhvcNAQkEMSIEIC6HKbZhsf2x/Bu2K+nCJLu5zhOVsqIRkzV18wZ7U9xdMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAPSQ+QSUFXnta
0SZOsmqjF8fjWnhq3FRtO5ZGrkErEcX08v3B56u7EpQ8UHKgtBKqRgoiarxO82Ijl+3g0gbBkm7h
7CB5is0jkPk6PdrDlO7LWWg7SwXa0Zbseu+SxsJ8LF6FRJ7ekpXzxvwWGmy6ow6DjWfC4LZs/zov
s8flo5SWzYz1U7p1ojaJn3q11b7R5+LJFJcCtZ0xFFgCnvGBGCXxzTPduONmFKEDY2q+dEia7WVV
OpgWTEoj46IKBRbUfNKqUbaoaZgs3lFznuwHBk0oPYA6mkC4aKfMayqDp6DNpgUUR6+6Jx3ohpDJ
j0ADdjlgYkgoYAxtDHWsT8rXB0fO9zCC0+B2DfjrfC0QoEjK8Hwsa53H6/vAtQCpP/3vHx2U4r3a
odY8veHs9Bz8nCY1IrOCyQ4nDtbOYzH86LUEgZTUwmI221bW55kx7gXDYkwynxL67x9i1E5VUmGY
O8fVJmHHaINm1O5ReE+ZcLbohl3ltVwhWW8TS60I16XfevA+LL+W+GE4bSu2k0SXNHO1l286lROT
HEW33gzWFxWAh3NHxBJQQVz1Y5GVnyEv1eGzDlhyI4y0odB0fmbML5aYnxTlJwAiSdjbNl8x77t9
0qDJNn5hZ4AP5gO0X+w8qL9mRqSngOZznI8s8ddM7D8PVB2G4GyVDbHRcG9AKygAAAAAAAA=


--=-uO867jHlf1GngfDO+c/9--
