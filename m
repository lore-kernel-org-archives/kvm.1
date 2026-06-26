Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92863A0E8E;
	Fri, 26 Jun 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487944; cv=none; b=iOZu6j8xEtvMrtFybODlAjRNAV8RAMg0Cbr6fLLHJbnzJEFPqzaI1I7usdeYH5ZWMb8nmHHYSP23Ma4X6YlmlbVYiNkqfAr81ajZm2+Brw2j1mtSZLKWHbhGxSSv58uAfTDIbB/VPiZqa5KDrmcYdylojAngjplRiesji2kPFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487944; c=relaxed/simple;
	bh=LRrrPV0C2lwlJlfheh2Ix3Mvgvt4MhcczHrcjNc1NtE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e7vOLtmqUPYlGmfOlUoTMb9NdQcbYSndaV2uVN1oFCdWeh2/16MGAHdHykjsGYt0Cy4eTxpTrlTT3wWOHuDmItamDCzzcidT8ei8jYpEDp6Oli03RpchFTS0Bgb3fIhtUJSRvN8KficZMPcAuT+EzXn242W639d61Twijn9DzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XnZ7hXDe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XnZ7hXDe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MwnEOm2MSH1g5bL8KIgjW/5YiQmxgiRGdQW3CxWCmwU=; b=XnZ7hXDehiGUR3CpFmvDp4AW60
	1NB2rhcX7XfEF8ap06GYi9whgfjpI5ARgM2Q800HVEyLgGZiiMqMYlSHFE3H6scjfcD12GS1nakyG
	Mb/b8hnVDAbBCrd8UmGkU61rqlGSo2ncIsttZ9RRhKLqSWS1r/OV2M+SokSr7X3CXrez+JDENG6fS
	sYnNw6kwL68d+xe1J8xlDJ/FWNuGPB2cmY/GIdJAOZWiK2bgD5yi1+Cg34+5YMI3/qaR9h0/1b8e/
	axrM2+Zm9/myWAJ46by//Ruj3uh9GDnUZB+0/G/UDa920/bJou/RzAK3+jXm4gHBHQvzG6sp4V/8W
	ZWm6yp9Q==;
Received: from [2001:8b0:10b:5:f3d6:3c0c:6c61:8d10] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8XS-0000000C4LQ-3Mjt;
	Fri, 26 Jun 2026 15:32:19 +0000
Message-ID: <5838fbf9c799d135b06ba61b7879a231e314f7b5.camel@infradead.org>
Subject: Re: [PATCH v3 05/10] KVM: x86/xen: Consolidate checks on Xen vCPU
 ID for singleshot timer hypercalls
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Paul Durrant	 <paul@xen.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Date: Fri, 26 Jun 2026 16:32:18 +0100
In-Reply-To: <aj6KireObWQXDF-8@google.com>
References: <20260625223623.3376478-1-seanjc@google.com>
	 <20260625223623.3376478-6-seanjc@google.com>
	 <c574f7c48c2e4805fb63f38e7d31240ff4497aff.camel@infradead.org>
	 <aj6KireObWQXDF-8@google.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-NlWrZjyY72EUYde9YI8W"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa6 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-NlWrZjyY72EUYde9YI8W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-26 at 07:19 -0700, Sean Christopherson wrote:
> On Fri, Jun 26, 2026, David Woodhouse wrote:
> > On Thu, 2026-06-25 at 15:36 -0700, Sean Christopherson wrote:
> > > Hoist the checks on the Xe

+	if (vcpu->arch.xen.vcpu_id =3D=3D XEN_VCPU_ID_INVALID)
> > > +		return false;n vCPU ID when handling set_singleshot_timer and
> > > stop_singleshot_timer hypercalls out of their individual case-stateme=
nts,
> > > so that both checks on the ID are in common code.=C2=A0 kvm_xen_hcall=
_vcpu_op()
> > > is already doubly committed to handling only singleshot timer hyperca=
lls,
> > > and even if that were to change in the future, the function could sim=
ply
> > > be renamed and turned into a helper specifically for timer hypercalls=
.
> > >=20
> > > No functional change intended.
> >=20
> > Makes sense. In fact these hypercalls are the *only* VCPUOP_xxx calls
> > for which Xen has that restriction (otherwise it would be pointless to
> > have the vcpu argument at all). Which is why we did the check in the
> > individual cases.
>=20
> Sashiko pointed out that the patch is broken as-is, because the effective
> "default" case will reject hypercalls if the vcpu_id doesn't match instea=
d of
> routing those to userspace.=C2=A0 The easiest way to deal with that is to=
 pull the
> cmd check out of the switch-statement, e.g.
>=20
> 	struct vcpu_set_singleshot_timer oneshot;
> 	struct x86_exception e;
>=20
> 	if (cmd !=3D VCPUOP_set_singleshot_timer &&
> 	=C2=A0=C2=A0=C2=A0 cmd !=3D VCPUOP_stop_singleshot_timer)
> 		return false;
>=20
> 	if (!kvm_xen_timer_enabled(vcpu))
> 		return false;
>=20

You dropped the=20

+	if (vcpu->arch.xen.vcpu_id =3D=3D XEN_VCPU_ID_INVALID)
+		return false;

part. Although that's kind of fair since I did ask you to put this
patch first, before that.

But really, while this rearrangement you propose would work... this
patch was intended as a cosmetic cleanup, and this seems less pretty
than what we had before.

How about keeping your patch 4 which just returns false for invalid
vcpu_id, and dropping patch 5 completely? Or if you really want to
tackle it, start with this...

--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1745,8 +1745,10 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
                                                 params[1], &r);
                break;
        case __HYPERVISOR_vcpu_op:
-               handled =3D kvm_xen_hcall_vcpu_op(vcpu, longmode, params[0]=
, params[1],
-                                               params[2], &r);
+               if (params[0] =3D=3D VCPUOP_set_singleshot_timer ||
+                   params[0] =3D=3D VCPUOP_stop_singleshot_timer)
+                       handled =3D kvm_xen_hcall_vcpu_op(vcpu, longmode, p=
arams[0], params[1],
+                                                       params[2], &r);
                break;
        case __HYPERVISOR_set_timer_op: {
                u64 timeout =3D params[0];

>=20
> > But these are *also* the only VCPUOP calls we're ever likely to
> > accelerate in the kernel, so that's actually fine. I would prefer to
> > see a comment above the check though.
>=20
> This?
>=20
> 	/*
> 	 * Reject the hypercall if the guest is trying to start/stop the timer
> 	 * for a different vCPU.=C2=A0 Xen per-vCPU hypercalls take a target vCP=
U as
> 	 * a common parameter, as all per-vCPU hypercalls *except* single-shot
> 	 * timer updates can be cross-vCPU.
> 	 */
> 	if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
> 		*r =3D -EINVAL;
> 		return true;
> 	}

I guess, although I'm no longer keen on the consolidation at all.

--=-NlWrZjyY72EUYde9YI8W
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYyNjE1MzIx
OFowLwYJKoZIhvcNAQkEMSIEILJsMp+IKvf5fp215Dbt7BzIuHvoqw8biBYWRuwV3VUpMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAiNR7iaFxs2BD
7bSc59oR1E+3zQ+JAB3aqg3Tfa6tpT4gltIIzgc6knGiWG1jnqXTB2vbIR8m11cRk52PFF5Gy/6I
Htnr3F2ii22gqnYW+6qGO/ylEpPtsAkJJrAFAsKIsvp7MF7ou+kYUQVGUEMHSy/rh8M0Y4i/AxSH
pr0BbOZo6Z09vQ3Inzi2+3r2/Hs3HE6I8eJcxS6Xi57GbRnMxgH+VZZSmuUppYTFG5gi/4o7fkQI
8CW/2lsKDT+pL9fcdlV2xWbE74ZfYLkDkN2unP2SV83oD1knpIPzQ38JwelIOUlKFsdew5Hi1AVp
UsNniSg4cLtzwMX8csfE8yd9lh7MS3n0GJTzz3V92NOoyHJ/cPcLftHpet4NEiji7z2jaTXmOQb4
xu1O3V/5jMHAQj1C7fJWcqPGo3uhOrl6OCL5HRQmU3B1O+esmkI54GBuD1DgluEQbE2ImxbhHFaN
cmneGu/92ieK+1YLxHR63YcB46r8qklOpREXf9OMHkgHHpblrOgYGCM2GG0RjO69e0X2BIpjohmO
dimvpnuHcFTM5TFmKGODFTFhkfGP7+rvc9jy9gUBHkgqrkwxHeIZZ2dFc1aWNt9CwzjenKeMgQ7v
E4nyqL6k25dhjIRqdRPQ5QFNTpmjwrCh5u0BcWpPuKiUmgVzfiqZ14hpaDv2ZI0AAAAAAAA=


--=-NlWrZjyY72EUYde9YI8W--
