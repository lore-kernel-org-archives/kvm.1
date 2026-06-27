Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839E3AEF43;
	Sat, 27 Jun 2026 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782568725; cv=none; b=dk11+bUy9QGnxbcAEhvA2KZ47nrDC5ziSEFvkfha0aur+0ikR3u4vMXmd+z29HPoUbE2KqfoCQH3DZy4lDpgQuj/uypDAsqy/yFtqinTTFfRt86GfF3jIGnYeKk5wXorMmtRuSYw4zDgxIhhf42Zw/MoygbU6397lSNmWXPjuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782568725; c=relaxed/simple;
	bh=m9Js2iVSVe1Hvys0yoCqBUM7Mu3+Tg+ED7GrlndOixE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BF33xyqZuWy4u/cPaWktjUZ3dRGtPoBmZ8/rY5cMZv2+0M3Qb1gd69y693zQOQhB+B63KO/Wr79Z7aIy0L8rLcUJYBSqTUBwqPeVcW8pY3tbar6WgeN+VOkSA03ZID8lhQyK4OKWl4mb37TAuPa2qwrtoef3sNWSwqSGvqxXEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RVSI9B0g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RVSI9B0g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nyjCEgUuVZ/YvrblmZDXtqdD2ewOWOi8MRDAdyIfkcI=; b=RVSI9B0gg2hrZbykW3y7Q/kBPT
	mrH2Ntz1EBzUfz+kbEpk475qPPHrixxPEOFpNo7QUWLxcEKvx/RFmpHJjhUARNsi9xx90kx+fw8bu
	geeEGUEk1RaNZI/H+TZ6CZU7HzjLGV8EZxFyNJBlnPVoug6A59iuByIRejHE3b+o3I024SH8aHGLs
	uZpGR4PmlHbeF2gEwk6sX//NPTJPiwPfWM34gFDxA4isPt1Ux91cEWEoSFXs9pk8QLBBywnVeMbXU
	CZStQMVzPhP07JKi5MK0u8OqSP51b9vcGodla26d7Q07DhTi10F4vbG4gd9OevIdGJGAbMsGoz0Wu
	/Q5rPLaw==;
Received: from [2001:8b0:10b:5:2974:86dd:e981:2b24] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdTY8-00000000O7B-3Iy8;
	Sat, 27 Jun 2026 13:58:25 +0000
Message-ID: <f45b6d2310bb650438ffa67adf66f5be16736df2.camel@infradead.org>
Subject: Re: [PATCH] KVM: x86/xen: Add
 KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jonathan Corbet	 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Thomas Gleixner	 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Paul Durrant	
 <paul@xen.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Sat, 27 Jun 2026 14:58:24 +0100
In-Reply-To: <aj6BSMT2LOd4JRpu@google.com>
References: <c855535b4262ecd41f67734d19e8f48a7f014c2a.camel@infradead.org>
	 <aj21KctIXuf7b_5G@google.com>
	 <8edfdca645f691cb856e80ade830d78925fdc19d.camel@infradead.org>
	 <aj6BSMT2LOd4JRpu@google.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-WLSoS8+/tKgjvv3ggQmc"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa6 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-WLSoS8+/tKgjvv3ggQmc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-26 at 06:40 -0700, Sean Christopherson wrote:
> On Fri, Jun 26, 2026, David Woodhouse wrote:
> > On Thu, 2026-06-25 at 16:09 -0700, Sean Christopherson wrote:
> > > > diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> > > > index 91fd3673c09a..c16b4560c9e7 100644
> > > > --- a/arch/x86/kvm/xen.c
> > > > +++ b/arch/x86/kvm/xen.c
> > > > @@ -907,6 +907,13 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcp=
u, struct kvm_xen_vcpu_attr *data)
> > > > =C2=A0{
> > > > =C2=A0	int idx, r =3D -ENOENT;
> > > > =C2=A0
> > > > +	/*
> > > > +	 * kvm_xen_write_hypercall_page() manages its own locking.
> > > > +	 * Handle it before taking xen_lock to avoid a deadlock.
> > >=20
> > > Do we actually want the side effects that necessitate taking xen.xen_=
lock?=C2=A0 From
> > > a uAPI perspective, it's odd to effectively bundle KVM_XEN_ATTR_TYPE_=
LONG_MODE
> > > into KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE.
> >=20
> > That's *guest* ABI, and it's derived from Xen behaviour. Xen will
> > 'latch' its idea of whether a guest VM is 32-bit or 64-bit, for the
> > purpose of shared data structures (shared_info page, vcpu_info,
> > runstate).
> >=20
> > Xen latches this from the current mode of the running vCPU in *two*
> > places:
> > =C2=A0=E2=80=A2 When the hypercall MSR is invoked
> > =C2=A0=E2=80=A2 When the guest sets the event channel GSI (HVM_PARAM_CA=
LLBACK_IRQ).
> >=20
> > Thus far, the former has been handled in the kernel (in the code you're
> > looking at), while the latter is why we have the ioctl to explicitly
> > latch the guest's long_mode from userspace too, as userspace handles
> > the HVMOP_set_param calls.
>=20
> Right, and I'm pointing out that from a KVM uAPI perspective, bundling th=
e first
> one in a "write hypercall page" call is rather odd, especially since ther=
e's
> already uAPI to handle the latching.

Mostly just because they came in the opposite order. The kernel was
writing the hypercall page for itself for about a decade before there
was anything to latch. And userspace wasn't *involved* when it happened
(initially because there was no facility for userspace intercepting MSR
writes).

> > > The other question is, why does kvm_xen_write_hypercall_page() drop x=
en_lock
> > > when writing guest memory?=C2=A0 That seems odd and unnecessary.
> >=20
> > Huh? It takes the lock to do the thing that needs the lock, then drops
> > it. That is not "odd and unnecessary" at all.
> >=20
> > You've been spending too long with these scope-guarded locks.
>=20
> No, I'm asking why KVM doesn't serialize the writes to guest memory.=C2=
=A0 Usually
> when KVM writes to guest memory, KVM is emulating something that is very =
much
> vCPU-specific, and so if there are races it's the guest's problem to deal=
 with.
>=20
> The Xen MSR here is clearly VM-scoped though, which is why it feels odd t=
o take
> a per-VM lock, and then deliberately drop the lock before completing the =
operation,
> In practice it shouldn't matter, since it sounds like the same repeating =
16 byte
> pattern will be written every time, but it was a bit head-scratching when=
 reading
> the code.

The lock protects the long_mode latching. It wouldn't make sense to
hold it around the actual writing of the hypercall page. It's not
intended to be an *atomic* write, and holding some random lock around
it wouldn't make it atomic with respect to all the other things that
can write guest memory anyway.

> We can/should return whatever kvm_vcpu_write_guest() returns, i.e. litera=
lly
> return its result directly.=C2=A0 Which of course is only ever going to b=
e -EFAULT,
> but in the extremely unlikely case that ever changes, we won't have to wo=
rry
> about creating misleading behavior in the Xen code.

Yes, and if we do it with a wrapper as you suggested, we can return a
proper error code and the MSR handler can convert that to 0/1.

As it is, we were doing the conversion the other way round, which is
why we were making up error numbers for the failure cause.

--=-WLSoS8+/tKgjvv3ggQmc
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYyNzEzNTgy
NFowLwYJKoZIhvcNAQkEMSIEIANHxB7zs0L7fZk5nRi5g06KcJolZJwzABUO076PhpXTMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAk01ZilFDQoyD
qF+weac4wUZAjUwuCQVuDdjo1iF48OUHT0L3ZyaistowYBlQwYgFcaWwFgXMQPw4wYFrS4AOejK9
rMMwVwxh9xaqURUUi+mUvxpZIELj1fNwIH9P4Mfm06kkKnUkVmvMpt0euzbstdd2VhkcBv1mcMSU
nbg9hYnED1lBdw1ve+p2XMZR1rPmRKf9idWwqMxBNARqJStFTfxxf/ZEkw2KmKn3fRXTfaEa/zE7
FthLYL6wEO8dEvwHB19Lquwl1VNePiPrL4QJ+gpat2G6a0M6lQTQdogMa+um5Q/buHJoVqbxXNSs
YLQraCNxAFY991M4WSc/aY/0RrhGyDA6U07k4CzoDqDvTsNekYBGL3NxhtyLx1rADxXxu4zxfrvp
O5SOIDFpcB/o/RdqHE1w+mUMQn1hkA8faWvtheLUP/MKzEoYkm3gXDQQ74DXOe5F3Bn+f9IPnNvW
T7E3XsN1KJB1Q1Veuce9FXCt9/Egq54Dxh8+nqEysPyKs1OtwJfWRoZd6Xj93QXKoQHqypuN7oZj
/uo7apxJCDvyia2e++UEX/0NnAVqUGCXKpJa/UEgIO5xct5FSvbWr4xio2yH+0z7BvUUrY4jl7C5
WJkPX+m78vIQdiN5luO5mygNzGrNrOTeQphLhR227JUmjfq8Hb7qX94UKmMUlsgAAAAAAAA=


--=-WLSoS8+/tKgjvv3ggQmc--
