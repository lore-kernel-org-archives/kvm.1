Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766E2E285C;
	Wed, 20 May 2026 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265648; cv=none; b=EFjE8qB9YTTOZT7NFDTNQZ9svAX5LRvGkuSjImRus0oJxKDrc00gbQomhW39vyQoSa393bhBcmCFGrRxnUR9P5rA1RC6fQSH8HUOuIACRm7qC0zgSaeNhNUeUkgyM4PqcpFEGm1nsDSab5BOrE7AW+JnZFp0AlMnH7vvb5ZIOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265648; c=relaxed/simple;
	bh=7K/T3SyA2cmNcBSU8rl98YYr2iwX6JMD2Boiij4U5sU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3x1gCwwIjohNTOPJrNy6nNarteOm/n0YSehClqrAXBKN/ruemIW3Sf6waLXYhLT+hYOXk7XFasZ11YBvbGV3XA2r5HkCNuU/ETr+Ob0Zs3Mg1NUd9KirxVuh2zznweml3FNPEv+qshyXcNWGWFaUu5TXgVKJdbUTSEgqRlf4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jk+QeA/E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jk+QeA/E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7K/T3SyA2cmNcBSU8rl98YYr2iwX6JMD2Boiij4U5sU=; b=jk+QeA/EA9Qgp6+ZBgSPS3R0Wj
	nkv1MuGNm0WWfgdI+k9460CGTQwlpqO4DOjzv5GQ19fqkCZ7XC8S9a2KAcWhUOfhidO/BPwfXUl4w
	Lh6miuCR+efbDjZuTTYU8LwH4io82vAo/iVCKdkgXkffejvcE2cbNiuLbCS18WMmljDH08QOiJoEc
	9ysEKre+Gyo445uaQAV+CgldWshypB055HtdQQnWAMIF/RABfLL8p3JDY+PcTpbcx8PtB0NgORqm/
	xpVgCj97sTA9BZT1fDM9ckrgmC4oW7ToYf7EGe+45gVuoD/6OR0PKnBZz/IeIEGHQkdwVrfsAHnOF
	Vd8OJU3Q==;
Received: from 54-240-197-227.amazon.com ([54.240.197.227] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPcGs-00000006tkc-0Vll;
	Wed, 20 May 2026 08:27:18 +0000
Message-ID: <438916491be31a7f50ad7a84f11a7faf394cfbc1.camel@infradead.org>
Subject: Re: [PATCH v2 03/15] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
From: David Woodhouse <dwmw2@infradead.org>
To: Binbin Wu <binbin.wu@linux.intel.com>, Sean Christopherson
	 <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  Kiryl Shutsemau <kas@kernel.org>, Paul Durrant
 <paul@xen.org>, Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,  kvm@vger.kernel.org, x86@kernel.org,
 linux-coco@lists.linux.dev,  linux-kernel@vger.kernel.org, Yosry Ahmed
 <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Date: Wed, 20 May 2026 09:27:17 +0100
In-Reply-To: <3beeaf04-e4f9-44cf-a3a3-04fa12912848@linux.intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
	 <20260514215355.1648463-4-seanjc@google.com>
	 <27ba35fd-5563-4bbd-8f95-2285b50efa7a@linux.intel.com>
	 <agcXr2FP4C3I_jbQ@google.com>
	 <52fdc61a-60e8-4547-8ff7-f249b4d667b9@linux.intel.com>
	 <ad4934f4a663c448924aeabe6418e68ae3ef9813.camel@infradead.org>
	 <868898e6-1c57-498d-848d-1df9cbeac23c@linux.intel.com>
	 <d7af5a04a11432ea1878431e8b51061f19c16061.camel@infradead.org>
	 <dc62e58e-b6ee-41e1-84a5-0716822fefc8@linux.intel.com>
	 <3beeaf04-e4f9-44cf-a3a3-04fa12912848@linux.intel.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-h9/NkfzlrAaTTiqUEi8g"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-h9/NkfzlrAaTTiqUEi8g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-05-20 at 13:02 +0800, Binbin Wu wrote:
> > > > For this one, I think the current KVM code is consistent.
> > > > The format is determined by EFER.LMA, whether the guest is running =
in 64 bit or
> > > > compatible mode doesn't change the ABI.
>=20
> I still have a point of confusion.
>=20
> I noticed a behavioral mismatch between KVM and Xen regarding when they s=
witch
> to the standard/compat shared info.
> - In Xen: The 32-bit shared info structure is latched if the current vCPU=
 is
> =C2=A0 not in 64-bit mode:
> =C2=A0 hvm_latch_shinfo_size
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d->arch.has_32bit_shinfo =3D hvm_guest_x86=
_mode(current) !=3D X86_MODE_64BIT
>=20
> - In KVM: It evaluates is_long_mode(vcpu) instead. E.g.,
> =C2=A0 kvm_xen_write_hypercall_page
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool lm =3D is_long_mode(vcpu);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm->arch.xen.long_mode =3D lm;

Nice catch. That should probably use is_64_bit_hypercall() too, yes?

> In theory, these two checks could differ when the guest kernel is running=
 in
> a 32-bit compatibility mode. However, I believe this mismatch is fine in
> practice for two reasons:
> - Mainstream 64-bit OSes don't run in compatibility mode for kernel code =
after
> =C2=A0 the early init.

Although... some of the early init does involve 32-bit mode and it
wouldn't be impossible for the guest to build the hypercall page from
32-bit mode during startup.

> - By default, HVM guests cannot issue hypercalls from userspace. The only=
 one
> =C2=A0 exception HVMOP_guest_request_vm_event is not related to the share=
 info.

A third reason: This is only one of *two* places where the guest mode
gets latched. The guest's mode is also latched when it sets the
HVM_PARAM_CALLBACK_IRQ parameter. When running under KVM, the VMM
handles this and tells the kernel via the KVM_XEN_ATTR_TYPE_LONG_MODE
attribute.

So even if it doesn't latch correctly when setting the hypercall page,
it will later.

And Linux at least will set KVM_PARAM_CALLBACK_IRQ even if it isn't
using it, in xen_set_upcall_vector() with a comment saying 'Trick
toolstack to think we are enlightened'.

> So the vCPU will never be in compatibility mode when a related hypercall =
occurs.
> In this specific operational context, evaluating is_long_mode() yields th=
e
> exact same functional outcome as checking for 64-bit execution mode. Am I
> missing anything here?

I think you're right. We have thus far launched about 5 billion Xen
guests with this, and I've never heard any report about guests latching
the wrong mode. And there are a *lot* of random home-grown and network
appliance operating systems out there, and basic things like event
channels would fail to work if the shared_info was in the wrong mode.

That said, I would not be averse to fixing it. We could just use
is_64_bit_hypercall() in kvm_xen_write_hypercall_page(), right?

Or at the very least a comment saying that it *should* be doing so, but
that we're too nervous to change it now?=20



--=-h9/NkfzlrAaTTiqUEi8g
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMDA4Mjcx
N1owLwYJKoZIhvcNAQkEMSIEID2/SpuErpK24ZhvH2U2aD2OC6tMfwrBBnhhsId2TJv2MGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAxYwi+D91zDcP
qcs0jnKveLA4k5A3HPTyLeK3R5LiEkPfVneXLcFPqXpHBAqWitAlVNzfwnVW87q6+9gx6DvubeIN
FS4uB8iKu0xGJ6M3e2mbLpVELLY4Rrgi/b2KK8h9hg414T18jNG8bnsovCkE337E91MDYAgPMdnm
cfAq/XLQHJ7JMQU6DfuCedEdzPsE18eSDsYhC6wk206uMJvftmbmaoGiO0Yyd9agSKAwF8WlcDwu
qFiH3rIFEzh8HQR1s1e8xNsalA974wU0QkyBN17JYD/6VQcanShnFVh8und6O0SQR3HtlvVgsSev
AFhI3aCopUkzGvG93OIyvYoPoTsZsUHpYnz5OIGKaKIIOOw8ZX8zOYejbbkNFZzgdIXR2gPC3jGQ
Q6epfJ+hw44lHrOH1XQr6FILLP8+Cjw3SzGFgTW2u/HXW/Uk3+vxhX3KALTwaX6dXBEz0Qqf4UJ/
DPXsnU0kA/Y8Xqnce8teVRlF9NaafXcXI6gDFkQ1FwdB0b9We0icvadrnJldlcgoEI6tAUn1ljtN
jY8LD3aEoUakgRge0HDlUhd+q+4bTsMJ7K6Z/OaV6/BxRYvVnG0jcc48tnohyv5x0MF/jE5ZyJbY
jWUc2CuEnTm2hBi55oaTQA0VdOS4XRwvLPNeO3qVqnvImcDYdfxQSsyryte+UK0AAAAAAAA=


--=-h9/NkfzlrAaTTiqUEi8g--
