Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD23314D9;
	Tue, 12 May 2026 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563329; cv=none; b=Gr0DDAl9Qsy/jWslJDC2/aoh3LDhXVgtAoNFRHTUkY5U/DIznOgVIg3Y1rjizW1CIH8fTpus7MUb2ncrp6ftO+6Rr9VgWfWqCOA52u/vF74dU2rkIwz4dClHshjl+px65rcxFt0N46P8hf/cVSJDi43Jswy61OgGgSUA5XIYkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563329; c=relaxed/simple;
	bh=8Ydtit5BWBcDIEW78DgjpNtuyZBU9y/zrplqNnO5jAg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/IDSeAR6ZHJnQc3MqltCrnSEvWXObQW4W63N6LXcptYw6gNFqYoKwfpV8zKSjqfaFExSt3usxeQJ/YtP4m0290muPc+lIVHh2g63/hKMnJR/GLZgRGxhXB91RuQ7AUUyLNzK9tXsN/RSw6DA40JcfV8tEQ0rqk2hhDegxtfShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tk9J1Q3h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tk9J1Q3h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Ydtit5BWBcDIEW78DgjpNtuyZBU9y/zrplqNnO5jAg=; b=Tk9J1Q3hwYqy2eq2g4GMCiTD/1
	OCl5lqn6Adx4JOQfsRwwk3HxzDX3R/ftcxOm+rVM983/cJpr/nxu/IjgC8+busL+FvMo4q+1uZXof
	Ug9x5NDu4XTHxGFAvXQShmF1UwY+f9/Jwi2XsuRALiA5+UsgXEf/gjSPE9lRWfCiB5ThmTEka/Uq2
	x3wfxcbCE6aSfjjLnHO55cY2NWP7ctgkY62yFljzCtiX0MXivM/aFBuJE9BElg4zS03uJ1Go5raBO
	YVpla/9o8M8MRQlgHxYDHL38wPLS/eEx/OIcaVs4MpkbfXA5myPTqti7yjGOPYiZjSss+5tSFhRww
	olzoewsg==;
Received: from 54-240-197-236.amazon.com ([54.240.197.236] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfZ9-00000009CJb-0wB9;
	Tue, 12 May 2026 05:21:59 +0000
Message-ID: <94bbb27100ac85508f00234e4ffdb619de855d7c.camel@infradead.org>
Subject: Re: [PATCH 3/3] KVM: x86: conditionally update masterclock data in
 pvclock_update_vm_gtod_copy()
From: David Woodhouse <dwmw2@infradead.org>
To: Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, paul@xen.org, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org,  hpa@zytor.com, linux-kernel@vger.kernel.org,
 joe.jin@oracle.com
Date: Tue, 12 May 2026 06:21:58 +0100
In-Reply-To: <dfc032bb-c17e-45d2-bce2-7e09d8b2b187@oracle.com>
References: <20260115202256.119820-1-dongli.zhang@oracle.com>
	 <20260115202256.119820-4-dongli.zhang@oracle.com>
	 <16b69905d5d14a06dbb68f29355c58e2c7d2f0d2.camel@infradead.org>
	 <dfc032bb-c17e-45d2-bce2-7e09d8b2b187@oracle.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-W4eKE2T4X4hWQ/rqAiFG"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-W4eKE2T4X4hWQ/rqAiFG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-11 at 17:16 -0700, Dongli Zhang wrote:
>=20
>=20
> On 5/9/26 5:22 AM, David Woodhouse wrote:
> > On Thu, 2026-01-15 at 12:22 -0800, Dongli Zhang wrote:
> > > The pvclock_update_vm_gtod_copy() function always unconditionally upd=
ates
> > > ka->master_kernel_ns and ka->master_cycle_now whenever a
> > > KVM_REQ_MASTERCLOCK_UPDATE occurs. Unfortunately, each masterclock up=
date
> > > increases the risk of kvm-clock drift.
> > >=20
> > > If pvclock_update_vm_gtod_copy() is not called from
> > > vcpu_enter_guest()-->kvm_update_masterclock(), we keep the existing
> > > workflow. The argument 'forced' is introduced to tell where it is fro=
m.
> > >=20
> > > Otherwise, we avoid updating the masterclock if it is already
> > > active and will remain active. In such cases, updating the mastercloc=
k
> > > data is not beneficial and can instead lead to kvm-clock drift.
> > >=20
> > > As a result, this patch minimizes the chance of unnecessary masterclo=
ck
> > > data updates to avoid kvm-clock drift.
> > >=20
> > > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > > Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >=20
> > Hmm... so the only caller of pvclock_update_vm_gtod_copy() that doesn't
> > set the 'force' argument is the one in kvm_update_masterclock(), so we
> > are asserting that kvm_update_masterclock() never needs to *change* the
> > masterclock origin point, if it was already set?
> >=20
> > The gtod notifier callback in pvclock_gtod_update_fn() also ends up
> > setting KVM_REQ_MASTERCLOCK_UPDATE, and is triggered by an actual host
> > timekeeping update (which could potentially be from a clocksource
> > change). It also hypothetically possible that the clocksource changes
> > from TSC =E2=86=92 HPET =E2=86=92 TSC, switching back to TSC again befo=
re the
> > masterclock update ever gets to run. Or maybe a suspend/resume?
> >=20
> > Are you *sure* that the optimisation is always valid...?
>=20
> Thank you very much!
>=20
> I didn't validate the scenario you mentioned. I missed that scenario beca=
use I
> assumed that most production systems nowadays use STABLE/CONSTANT/NONSTOP=
 TSC as
> the host clocksource, although I sometimes forgot to add "clocksource=3Dt=
sc
> tsc=3Dreliable" to my AMD L1 KVM guest (acting as the hypervisor for L2 g=
uest).

I'd love to assume that, but we do still have to cater for systems
without it (or where it goes wrong). And where userspace sets up vCPUs
with different frequencies... although I'd quite like to ban that too
:)

> I didn't follow up on this patch because I noticed another issue. I found=
 that
> the tsc_timestamp in the PVTI can become a very large number if we simply=
 reboot
> the guest VM. This happens because the patch stops updating the masterclo=
ck data
> when the masterclock is already active and remains active.
>=20
> For example:
>=20
> current guest TSC: 122763682
> PVTI->tsc_timestamp =3D 18446744073656540006
> PVTI->system_time=3D196515164269
>=20
> Although I could not reproduce any bug, that still made me feel uncomfort=
able.

That's just negative (-53011610). Theoretically it's OK; it's just a
consequence of using a reference point in the past. Probably just
*asking* for guest bugs though, so best avoided.

I'd like to understand how it got like that though. Did your 'reboot'
reset the guest TSC to zero but *not* its kvmclock?


--=-W4eKE2T4X4hWQ/rqAiFG
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxMjA1MjE1
OFowLwYJKoZIhvcNAQkEMSIEILVNWRi6HS0aGUM+vHb7gSfRvQjcbdW0c1DzFy/CWa81MGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAGA30KlmXC+ZE
1rfHIYBC+ZVj9NpXmFz4Xs0VKEGGcaax7ogXCiIS2c7wc361SHbl8AI22uv7wyYfKZ8H8Ck+K0RM
N6jE/bpZNQqqiYMOcuQY0TrbXfiOEnuKFZy3FAAqJ9jWLec1mbGCA/t0t2N+MJ1pPhIMXs4KVKlg
Uwnl7RCJIqruKarVYKda3a3KzSslkVy0Vhh5yyHFrZ8azz+J+Sgbs2N2ywrhBsWWho0H7aiCksFH
5ByTtzb8zZVdEVTUeeW2USQgaxENaBX2yEuBwtrdkdxry26yvs9fiyYFNAWeIXkWBwfgTE49GM59
L0wKFO57Pidh/d39cxAcg2ktsh9S+J8yklxR7ybgKj3cX5hF+jDmk0Leeliz1XVlfeAFyG/kmW6I
JIvzZ2/onn543x2GjQZbi6VDZpX/p81IeIeFp8AG2nv6KKsTFQ8bmlspa+sexFunkQCT6JN5n8td
aR4l/tXiDkDQXegzBFtF5asJNTk1y1c3sMRqFMxsC2j5P2EklvMAyhD+o7jB9c8GJkvdg6VuDJ7G
Yps1FIZQ8lGlcQKfKBaFjBlRls7uN3Mnd3g2d39Nc5FvaN1XEAhq+NQlZt86pfH/LWM0ESqfVTHM
eTKdRR/ziH2Gp0tkgykIM+mgKnmw1r8g9uB/HkXRwrzgLCCQ86k4c7NlpxZAKT0AAAAAAAA=


--=-W4eKE2T4X4hWQ/rqAiFG--
