Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F63BBFD7
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610213; cv=none; b=jx7YygpD3ZHKbbgaqH5n5F8mNe7bqX2uFo8G2GKb+BtEEnFcjcLqVp9Nbos9n3JD0UC8yhmS1fs4r4m+pY/OXkO7j2Ka9VksfE/DGGnSn+zjHpf6YAH2v3izEFtkuJpweg75RfRtPjeu3miBS8ZSK+3lebHh44n/+/qHI+CY7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610213; c=relaxed/simple;
	bh=DjcRwaNvNZvjwwNXlBNivwc/9ebM+89HSSqWxTPmc98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W8atsRWjjheeva+J0FRQyUV4DSq+wgdP0/eZ8YlVr28aKeKjqzjssaSrHhGzQIg9LMKEXpdpLTaG/ReN8o1zhj5gjaOvs+WYZRCyuDPpl9oSX1xJugPM3ZW66Jpvld6m4BRgng6ja0yRKQ+h+Bop3gXqfKNkJIjASyej+V6afRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=niWTgsgm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="niWTgsgm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+KbZLBzJg7GMa/4IxNp4Z+2mDG5ZhmPCPv6l8NFP/FQ=; b=niWTgsgmxA0zIHxBDsN/lTTq0Q
	rWKZVQjCIl7yO1szR4Es/Yn8Jr+u1unoecb/8/w0Wd7X8Rih+4ZDwiG5ntTCEyu5q5qb23UBWsjoM
	Cq+w029Sszxx/paGXr4Xx0MkSWv7piLDYhXvjPk88DbuGkIUY4QCXfyDpIwWlbhsgzvU/dwR2QUYT
	WTbIcwhGUOpyhnz3y1+FJ2Bz5WXJJQfomleuGRgwLt1MK7F58YEDcrtzCLWkldQpCGrJYLAkCt6OC
	tUPVY1wKJyC+A69X4ET50JXEUhLWh++eduLYoC7reaJT9PWqhZNwQXdIdDd7yvP0JQ6eo8KxNShUq
	AayMif9A==;
Received: from [2001:8b0:10b:5:2fb1:ec7c:80ac:932e] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVG3H-00000006pfM-20vC;
	Thu, 04 Jun 2026 21:56:45 +0000
Message-ID: <24043b30cdbe70bc227b4203ece94e3e23010efc.camel@infradead.org>
Subject: Re: [PATCH] KVM: x86/xen: Read long_mode only once in
 kvm_xen_set_evtchn_fast()
From: David Woodhouse <dwmw2@infradead.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: paul@xen.org, seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, 	hpa@zytor.com, kvm@vger.kernel.org, Andrew Cooper
 <andrew.cooper3@citrix.com>
Date: Thu, 04 Jun 2026 22:56:35 +0100
In-Reply-To: <aiHxOgVLGyQ2fa61@v4bel>
References: <aiHPPUk5DY7rH-zL@v4bel>
	 <c6fd97fa3e592c3c3734920e1a45f9af1a389a16.camel@infradead.org>
	 <aiHxOgVLGyQ2fa61@v4bel>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-qlC2sHN2eJEyRwmyaSUS"
User-Agent: Evolution 3.60.3 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-qlC2sHN2eJEyRwmyaSUS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-05 at 06:42 +0900, Hyunwoo Kim wrote:
> Thanks for the review.
>=20
> On Thu, Jun 04, 2026 at 10:01:01PM +0100, David Woodhouse wrote:
> > On Fri, 2026-06-05 at 04:17 +0900, Hyunwoo Kim wrote:
> > > kvm_xen_set_evtchn_fast() assumes the port range check in max_evtchn_=
port()
> > > and the bitmap layout selection observe the same long_mode, but each =
reads
> > > kvm->arch.xen.long_mode separately. If the guest changes long_mode in
> > > between, a port accepted by the 64-bit range check is handled with th=
e
> > > 32-bit layout, and port_word_bit falls outside evtchn_pending_sel.
> > >=20
> > > Read long_mode once on entry so the range check and both layout
> > > computations use the same value. Since max_evtchn_port() reads long_m=
ode
> > > as well, compute the bound directly from the latched value.
> > >=20
> > > Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN an=
d event channel delivery")
> > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> >=20
> > Thanks. I think we have the same issue in kvm_xen_schedop_poll() too,
> > don't we? Just slightly harder to see because the bitmap access is done
> > in wait_pending_event().
>=20
> Yes, kvm_xen_schedop_poll() needs the same fix.
>=20
> >=20
> > > @@ -1809,7 +1810,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evt=
chn *xe, struct kvm *kvm)
> > > =C2=A0		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
> > > =C2=A0	}
> > > =C2=A0
> > > -	if (xe->port >=3D max_evtchn_port(kvm))
> > > +	long_mode =3D IS_ENABLED(CONFIG_64BIT) && READ_ONCE(kvm->arch.xen.l=
ong_mode);
> > > +
> > > +	if (xe->port >=3D (long_mode ? EVTCHN_2L_NR_CHANNELS :
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 COMPAT_EVTCHN_2L_NR_CHANNELS))
> > > =C2=A0		return -EINVAL;
> > > =C2=A0
> > > =C2=A0	rc =3D -EWOULDBLOCK;
> >=20
> > Rather than open-coding that, I wonder if we should make
> > max_evtchn_port() take "bool long_mode" as an argument instead of kvm?
> > Those callers which only need a single instantaneous answer can just
> > pass it kvm->arch.xen.long_mode instead?
> >=20
> > We'll want to pass a 'bool long_mode' down to wait_pending_events()
> > too.
>=20
> Makes sense. Shall I send that as v2?
>=20

I'm working on it. WIP at
https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Drefs/=
heads/xen

David Woodhouse (4):
      KVM: x86/xen: Rename 'longmode' to 'is_64bit' in hypercall handling
      KVM: x86/xen: Introduce kvm_xen_is_long_mode() macro
      KVM: x86/xen: Make max_evtchn_port() take a bool long_mode argument
      KVM: x86/xen: Fix TOCTOU race in kvm_xen_schedop_poll()

Hyunwoo Kim (1):
      KVM: x86/xen: Read long_mode only once in kvm_xen_set_evtchn_fast()

> >=20
> > To be clear: these are not security issues because we'll only ever
> > scribble *within* the vcpu_info or shared_info pages, even if the wrong
> > places therein.
> >=20
> > I'm actually more concerned about what Sashiko saw. Xen does enforce
> > alignment, so we should do so too. I'll take a look...
>=20
> In addition to what Sashiko flagged, kvm_xen_inject_pending_events()
> looks worth checking too.

Yeah, working on the alignment thing next and comparing with what Xen
actually does.

Thanks.


--=-qlC2sHN2eJEyRwmyaSUS
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYwNDIxNTYz
NVowLwYJKoZIhvcNAQkEMSIEIA6uCULyqO0kWjLpmNzluKasE9MQUANi1aeTxnIw1g2kMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAbBeV+lI9zwZo
K4nebUlBDM4Et+poy2u9m574DARBeg+izEM32MCu+wOJeRVwZ+xMWSzCyu8Ludx+EVegeKqYppqm
vt+OCEOJWj3WHl9CnQMd9MQY271t4UT6uy1Ry0UUKqADJiXq4HYr8ZgFBF//uhDzN1t9jb/Pl+R3
14s+gXopXgzfv5+I/OOpcajliZPfegNwE8IHGJcij//bNQy7g4KxbHqDNlRLBkvfQs1m+XBnVy9o
jGJrCB9YrIWQw/0aUAIJmLAG3PU+BOmMxcSIMI2zs/ZbZ5dHw+14cWtbxYu2LAyv7nOSyqVp7knb
Ghi0GHA/FVwhiGgtmd6+V0+oPsO3QSOIzr7zdJXorv6zwKA9n8idBQ1fUUDSJK6keXSPn8/iDhK1
skKWZkazMeGSZ5g4l5O2yK5xvXYnNjFYSnaB9A24eBkm9rtWI53cmKSFpTZBm8peyUoB6c8y4tWW
BSIeYj2YfueV891tr3/gP8ejZx/d/vpwdS288+VeiRgRrk2ZB/0ElBFtROOt26IvE654BHjxcI2D
zsY1+Wet3l6qtkEv/9sa21pewb/AGjMkMPEqdIogQ3kCqSr2FhU52KXClX0JDPuqxx/g/IzyL2eU
wdR2M0RiW+7SOSMgJsnjNdnHVTjiW9dpIVeSAl7PvpF3CE2u2erd8iv+NcZKgjsAAAAAAAA=


--=-qlC2sHN2eJEyRwmyaSUS--
