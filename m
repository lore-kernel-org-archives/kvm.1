Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9C36F41C;
	Tue,  9 Jun 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021649; cv=none; b=hUykCkRdx39Uzx/XanDyepwDHx958HsG805oPdQxTeznY8Zag6k6npiUOvHOUrYICSw/WrTks8z7ySkGekgCE7HdoHYfIKw7zhWjHzKzstbQ4eW1aZGj05vVUPCtN25hnig2ZD8pV3KiHGTkOxgrDI60u8AqYpre9tceRhH93UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021649; c=relaxed/simple;
	bh=hEGIYmg99T959Mj+q/QmmbCVht/dFQK7i6Smhw3uozE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YP9liG9PHUaKZBCz6lpl8B6bvtA5zu+EARoDC12827TLpnizAiFoI82V3E+OVU1i6G3b8bGcJx+K/5b+QcYEjm67WIvkSX8kxns0xaJFGA5KWWlFqMy2rb0o8mmMwaLeg2Xch+Qk4dLNNvkJw9OeCoKmFbZJUE2NeejJrbaYCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=epRW6HV6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="epRW6HV6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FG9ACw88AF4qrzNjpLIHq5swESHvtf5TUmSvHSTULSw=; b=epRW6HV63WxnKwjXgdsSHbN51f
	kCnmMQNyR5QVnnNHSq9aX29CyuvC3X4+WNqtfqDhP/wf4CKvohCWqqpH9hrqO1UAjiz0SstUITTvV
	v3JaJZGd3ZLvaKjQ9mxkRr7SMfLBtBprzFrYhPlfphfeK7G8NV6UpHPWqTziHM2eFpiJ6mUCr/eTJ
	iND45liugGPBHwd0gy7BN+DIVGAv1R4DSd+mTTGMGkDJ4emHtYHYtmoVlRiPLcGPU8nKCCa6y6Q1u
	Gb5wrIPiB188jbN34J3sReyFWQ4zjVC98qW5d9/VLsnyB3v/GDKUaOlYDChWyV9mkS8iIOVJK7h0u
	bHNdvxpQ==;
Received: from [2001:8b0:10b:5:6142:9ddd:3a45:5d21] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWz5W-0000000G0cY-49WB;
	Tue, 09 Jun 2026 16:14:03 +0000
Message-ID: <58c5a521b94e8d90e101602cfe160d1fb128a5dd.camel@infradead.org>
Subject: Re: [PATCH v5 07/34] KVM: x86: Activate master clock immediately on
 vCPU creation
From: David Woodhouse <dwmw2@infradead.org>
To: sashiko-bot@kernel.org
Cc: kvm@vger.kernel.org, sashiko-reviews@lists.linux.dev
Date: Tue, 09 Jun 2026 17:14:02 +0100
In-Reply-To: <c1f6ae6779d6475d6ad86a6a721a1ae080dad015.camel@infradead.org>
References: <c1f6ae6779d6475d6ad86a6a721a1ae080dad015.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-60Y8BU3YYwhTLPRhBNp4"
User-Agent: Evolution 3.60.3 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-60Y8BU3YYwhTLPRhBNp4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-09 at 00:29 +0100, David Woodhouse wrote:
> On Mon, 2026-06-08 at 16:27 +0000, sashiko-bot@kernel.org=C2=A0wrote:
> > [Severity: High]
> > Does this cause an O(N=C2=B2) scaling issue during VM creation if the h=
ost
> > clocksource doesn't support the masterclock?
>=20
> Good catch. Fixed in v6 by replacing the synchronous
> kvm_update_masterclock() call with a simple
> kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu).
>=20
> The vCPU will process the request on its first run,
> avoiding the O(N) iteration over all existing vCPUs
> that made vCPU creation O(N=C2=B2) on archaic hardware
> without a TSC-based clocksource.

Hm... that actually isn't sufficient. Some of the test cases do use
KVM_GET_CLOCK{,_GUEST} without running the vCPU first.=C2=A0And arguably it
*ought* to work.

By the end of the series it's actually fairly reasonable to just
initialize the masterclock *and* the TSC synchronization generation in
kvm_arch_init_vm(). Patch below.

I've tried working that into the series earlier though, and it's a lot
more painful. So I think I'll leave this patch as-is  to make things
sane and bisectable through the series, and then do it more cleanly at
the end, thus:

=46rom 747468e6fc743d39f9ac31488f943c073b655e63 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Tue, 9 Jun 2026 11:23:12 +0100
Subject: [PATCH] KVM: x86: Activate master clock from kvm_arch_init_vm()

Initialize the TSC generation and master clock state at VM creation
time, rather than relying on kvm_update_masterclock() from
kvm_arch_vcpu_postcreate().

Set cur_tsc_generation=3D1, cur_tsc_khz, cur_tsc_scaling_ratio,
cur_tsc_offset, cur_tsc_nsec and kvmclock_offset from an atomic
ktime/TSC snapshot. This establishes a coherent epoch so that:

 - The first vCPU synchronizes to the existing generation (getting
   the pre-computed TSC offset) rather than computing its own.
 - pvclock_update_vm_gtod_copy() succeeds immediately (no zero
   tsc_hz from uninitialized cur_tsc_scaling_ratio).
 - KVM_GET_CLOCK returns valid {host_tsc, realtime} fields as soon
   as any vCPU exists.
 - KVM_[GS]ET_CLOCK_GUEST works without a prior KVM_RUN.
 - No O(N) iteration of all vCPUs on each vCPU creation.

This replaces the kvm_update_masterclock() call that was added to
kvm_arch_vcpu_postcreate() to work around the missing initialization.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro (claude-opus-4.6-1m)
---
 arch/x86/kvm/x86.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6a541483a77d..dc64a5bf4711 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13174,8 +13174,6 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu=
)
 		return;
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
-	if (!vcpu->kvm->arch.use_master_clock)
-		kvm_update_masterclock(vcpu->kvm, NULL);
 	vcpu_put(vcpu);
=20
 	/* poll control enabled by default */
@@ -13585,6 +13583,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long=
 type)
 {
 	int ret;
 	unsigned long flags;
+	u64 kvmclock_host_tsc;
+	s64 kvmclock_ns;
=20
 	if (!kvm_is_vm_type_supported(type))
 		return -EINVAL;
@@ -13614,18 +13614,47 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned lo=
ng type)
 	raw_spin_lock_init(&kvm->arch.tsc_write_lock);
 	mutex_init(&kvm->arch.apic_map_lock);
 	seqcount_raw_spinlock_init(&kvm->arch.pvclock_sc, &kvm->arch.tsc_write_lo=
ck);
-	kvm->arch.kvmclock_offset =3D -get_kvmclock_base_ns();
-	kvm->arch.all_vcpus_matched_freq =3D true;
-
-	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	pvclock_update_vm_gtod_copy(kvm);
-	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
=20
 	kvm->arch.default_tsc_khz =3D max_tsc_khz ? : tsc_khz;
 	kvm->arch.apic_bus_cycle_ns =3D APIC_BUS_CYCLE_NS_DEFAULT;
 	kvm->arch.guest_can_read_msr_platform_info =3D true;
 	kvm->arch.enable_pmu =3D enable_pmu;
=20
+	kvm->arch.all_vcpus_matched_freq =3D true;
+	kvm->arch.all_vcpus_matched_tsc =3D true;
+	kvm->arch.cur_tsc_scaling_ratio =3D kvm_caps.default_tsc_scaling_ratio;
+	kvm->arch.cur_tsc_khz =3D kvm->arch.default_tsc_khz;
+
+	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
+
+	/*
+	 * Establish the initial TSC generation for synchronization logic.
+	 * The first vCPU will sync to this, starting its guest TSC at the
+	 * number of cycles elapsed since VM creation rather than at zero.
+	 * This ensures coherence with the kvmclock epoch (also set here)
+	 * and means the master clock snapshot taken below is immediately
+	 * valid =E2=80=94 no need to redo it at first vCPU creation.
+	 */
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&kvmclock_ns, &kvmclock_host_tsc))
+#endif
+	{
+		/*
+		 * If not simultaneous, we want the TSC to be zero slightly
+		 * *after* the kvmclock is zero.
+		 */
+		kvmclock_ns =3D get_kvmclock_base_ns();
+		kvmclock_host_tsc =3D rdtsc();
+	}
+	kvm->arch.cur_tsc_write =3D 0;
+	kvm->arch.cur_tsc_offset =3D -(s64)kvmclock_host_tsc;
+	kvm->arch.cur_tsc_nsec =3D kvmclock_ns;
+	kvm->arch.cur_tsc_generation =3D 1;
+	kvm->arch.kvmclock_offset =3D -kvmclock_ns;
+
+	pvclock_update_vm_gtod_copy(kvm);
+	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
+
 #if IS_ENABLED(CONFIG_HYPERV)
 	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
 	kvm->arch.hv_root_tdp =3D INVALID_PAGE;
--=20
2.43.0



--=-60Y8BU3YYwhTLPRhBNp4
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYwOTE2MTQw
MlowLwYJKoZIhvcNAQkEMSIEIHeO6fLvaqRl17wxGuTNaq0CRP+mopWe5HE8k+tfs//FMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAjlQKtjXbo5IB
hkYL9yP6zRJ1OjzA17dkLXsVYHtNGBRhGbtHOZP661WR6uwJbHjOckLASERaPHtZS/gmNWh/0Oac
CO1YAsmU/W/ly6CqkyocKYCsMBelYYfh5u0THtis3D8pbkbGsgKe9XWjRIjVVrEiXaLefuuJnnvx
WUa5TJN4JQ79rZWW1VFVJNqpgfG2b1DsSF/Te6/PKLj9KD0MMX46QncNXELUZexKGJRTFgdf53Mq
tiiOy9fbTtz2Fd5W6cRLhEKHk94HjtK+ZxHuwKntTd7nRqcrTV67My/Et+xLfjoaCtYm3ssd4X4a
8Sz8wXX34nworuzufwTX34pH+YaVp+jQEfqGbB9X9WdlKTI9hS8LBcdiWQlIz3+DKal2EwXEd2kz
MX7tEpfpxvDfLElC6Z8hRm5HKPgkKAcTCnAvwxX9dC/hutHlD5SqSSIby7pC1pVcsviXgV35H/CW
tF1Xjc+Cp1XqkcyvgyOGM1ztlx3ZQ6K4dv5OcJn6GfigztXVklUnWVhKvPqciSGyGl1v6xBoFoDU
t/c3b04HRXjyAjuPKcqxyWOf6Gsh8x/Ed4ayV/sGZxgpcAraD/KWiCC9ek45KYFVHe2m6y//SaL3
QmS5tttqKA4cjWktxpicPQ+LURnTqO0NBgjspku96efqLoN9Q3yRqIaKyUeWyIkAAAAAAAA=


--=-60Y8BU3YYwhTLPRhBNp4--
