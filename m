Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C64309F00;
	Tue, 16 Jun 2026 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608422; cv=none; b=RNHUQlKTirAEBlFs9s0DdcEe8peVvEAF0SNhsUPMqHgWTsFyq1VLIehmSkRC4RPOyc9NW7Qd/m+DZlSC6XEXqNRcpCijFoAknla/LaINgbM1cAhrEpCDXBEvb7srRl1LMbCQ5ROahwazPPaKaIHR/3PMnfdpFE4uJIso6yW01pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608422; c=relaxed/simple;
	bh=0kkV5eTmHO2Wv3uC6lJwILGDtspJUOhMlj3zb9vu+lI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nmy/CNcAjMRHAt1NyQmWKY/2dBb2yHTFlVEj5w5z0mVu3CHq/yMwgLPuRnijWLIPTpL7IPh/YxDi6l7AErR4fEyS+rn3ZAWPxdcbspi5q/F310L+ZWN0hj7mejg9NK6upzD+O1JgQflTMz2zPr3g4Ty9m8AOg0rw+Ry8rNSbB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cIG2iAaf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cIG2iAaf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0kkV5eTmHO2Wv3uC6lJwILGDtspJUOhMlj3zb9vu+lI=; b=cIG2iAafBHwUcYqzPajEALtQ/Y
	U+zfrpntB1GSIwLxDvCqY4yXUMqv/4r1RMg3oHPu3gcZQ4J0/kfQzjkXG7AdFcSN5rDsjBRPe2xTA
	phMJwgZRJeBd5WZ6sNvwpCyEFm269CfQsYXKnHG0AEyyIH8Sh4NHaWCqHACEecMUNrgMp6cX+EaB8
	3BgE+FTZ2rSi9o523IkI1XvYMNtkBDIHPtpnsPFZ2SMzlY7KHJ3s6sbslQkHa89k33Hu5M52c6lcj
	t8IdJo8Dos4DFGX04te/l8rCIED46hgAoFZgW6IIqjJfrBCi4VO2rHNexRP6uiaVaitCjreeNXzpF
	y+91Fb7A==;
Received: from [2001:8b0:10b:5:7e25:c5e1:47b2:baf1] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZRjY-0000000AcxR-1BsU;
	Tue, 16 Jun 2026 11:13:32 +0000
Message-ID: <913f6048e1193e65278cb3f4b4dbf04a151e85f5.camel@infradead.org>
Subject: Re: [PATCH v5 04/34] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
From: David Woodhouse <dwmw2@infradead.org>
To: Dongli Zhang <dongli.zhang@oracle.com>, x86@kernel.org,
 kvm@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 linux-kselftest@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner	 <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Vitaly
 Kuznetsov	 <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, Boris
 Ostrovsky	 <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>,
 Jonathan Cameron	 <jic23@kernel.org>, Marc Zyngier <maz@kernel.org>, Sascha
 Bischoff	 <Sascha.Bischoff@arm.com>, Jack Allister <jalliste@amazon.com>, 
	joe.jin@oracle.com, Joey Gouly <joey.gouly@arm.com>
Date: Tue, 16 Jun 2026 12:13:31 +0100
In-Reply-To: <77f541f7-b346-4c86-8e66-3d2439e29cbb@oracle.com>
References: <20260608145455.89187-1-dwmw2@infradead.org>
	 <20260608145455.89187-5-dwmw2@infradead.org>
	 <77f541f7-b346-4c86-8e66-3d2439e29cbb@oracle.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-z8fsZ4KdYGvpldBfCjRo"
User-Agent: Evolution 3.60.3 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-z8fsZ4KdYGvpldBfCjRo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-15 at 23:47 -0700, Dongli Zhang wrote:
> I tested patches 02, 03, 04, and 26 by customizing QEMU to support kexec =
live
> updates (LUO and KHO), preserving the memfd across kexec.

Thank you.

> For my use case, I used KVM_[GS]ET_CLOCK_GUEST instead of the existing
> KVM_[GS]ET_CLOCK. I didn't account the downtime in my QEMU code, although=
 host
> TSC never resets across kexec.
>=20
> Clock drift was zero, and I did not observe any unnecessary master clock =
updates
> after KVM_SET_CLOCK_GUEST completed.

The kvmclock drift won't have been *zero*; it will have been a
nanosecond or two. Which most people won't notice, but is annoying me.

It believe it comes from both pvclock_update_vm_gtod_copy() and
kvm_vcpu_ioctl_set_clock_guest() rounding *down*. I think we should
tweak the latter to round *up* so they're at least not biasing in the
same direction.

We could also do better at picking a snapshot cycle count which
*doesn't* lose in the rounding. But those are definitely improvements
for another day; this series is long and complex enough and has already
gained a dependency on fixes in core timekeeping snapshots.

> Another interesting observation from my experiments is that tsc_khz chang=
es
> across kexec. Since the TSC value itself does not reset across kexec, I'm
> wondering whether there is any reason to switch to the new tsc_khz value =
after
> the kexec.

This is the host timekeeping, yes?

We really ought to pass over *all* the NTP synchronization data across
KHO =E2=80=94 not just the frequency. There's no excuse for the new kernel =
not
reporting *precisely* the same time that the old kernel would, for a
given TSC reading.

The work I've been doing at=20
https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Drefs/=
heads/ffclock
lays the groundwork for exporting and importing the full reference
data, and maybe I should use KHO as the example use case while we
continue to bikeshed the userspace and vmclock parts.

> While live migration involves two different machines, kexec is performed =
on the
> same machine. Given that the TSC value itself is preserved across kexec, =
would
> it make sense to reuse the pre-kexec tsc_khz value instead of using the n=
ew
> tsc_khz after kexec?
>=20
> I tested this by using LUO to preserve tsc_khz across kexec, and the resu=
lts
> looked good.

Of course, what we should really be doing is exporting the timekeeping
reference to see what frequency the source host TSC is *actually*
running at, at the time of migration. That gives us a function of guest
TSC to TAI. Then we can restore the TSC on the destination host as if
it has been running at precisely that frequency during the migration.

The TSC might be at a slightly different frequency on the new host, but
we provide vmclock and the guest can clamp its timekeeping to that
fairly much immediately (see qemu patch I've been posting with the
ffclock/timekeeping series).

--=-z8fsZ4KdYGvpldBfCjRo
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYxNjExMTMz
MVowLwYJKoZIhvcNAQkEMSIEIJ5VAk35+dGCrCRUWFXxqcuWDPC83HDVQTsGwz+Tl6bIMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIASkw7sYl3kwHW
VqDqOKkb8TmubpwZH0kYFfy1eJORlgVtltDfEnu/TBYuwuNbj1+qyocm4LdVcecQuaCarSqZqAQb
VO+uK/uScxLsebmWRLslgX6hqlyOUzDvt3N3bCWSHWB8kEpGI0OMMCyomrqjIPE2nfiV8wyr2+KG
pyGCvnR2YUM9mOfSb0OfUQnD7M8kyfctMcl9V2ppqbCVY9JW5F0NZ8QgCagLImoxIMDwN4X8YYNT
v2A1dgSlCBkSejw3/b3o5gHs5Unotlvt6zflgDgZ8YF0o66/gmv0dv3fhEUVrIREQJdjPjcEXugH
HY2B8LLfGQESrESfojA+saX11myjZ+CkQ+Lbktjptf9aFWuU+alI0IXqkT1e+Axq7UnVhqXnd9X1
XJS0+jUerOFGhCjczqHHv52eeieFp89tx1brtKo0jFnSShrd9Ro6FrCD8nyN0z6zWwd9o2f35TRE
umIxXfT15cltcVHq9oOzIsO99TGDxGE2vNPbc+s5oNbQqzy1xCe+tauDMgX/zZYWF6fSx7luLdNR
L3ExRdRKdGrY3mMXFwPLXPPq+9ne2K23TcFRTMfwT0s2B8wAIftQhFqV1AbgrlOyu49BjdzRvfHD
XL3o31Q1IWnNGcqdtFFKT5rM371ap05RpDDgaowri0/grGlCIXj4vssW3iXgG7oAAAAAAAA=


--=-z8fsZ4KdYGvpldBfCjRo--
