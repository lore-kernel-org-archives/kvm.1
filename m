Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669DA318EEE;
	Mon, 18 May 2026 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097829; cv=none; b=P0LgHUrVNtSwo1yLYMvdirntqoyW6WjztuIMHsT+YcWXwhM+428Pxy2ZQJn9+yEi7JF3eYeIaHO3b36xJEF/gMeEsEvkF16j725dtMg1KD0p0dNLti48hGGJd+chm3baB6EpYm24sAwRzbTD2EWJ4EySz6CideQBLxvtQQekEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097829; c=relaxed/simple;
	bh=WlfiYH044M9bAnIYrN2ZlMtD0G8yAY509ApbShPCZT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YTvN0x4nGHt+BY205p4dPDFeILCxBnRMaikqtDq9C9NZAxb+V5Mr8Cc8hl80li5LfmvWNNeHLLgVkkQyZLhOcBLOT7bX/Q0gooappraYoY5yyOjUB3HuVqRACXflje2qsxdoVMe3P1PtCAlFIY8WJyiq2GwiVLt7RlKBL1TBP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L4D6n7Yq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L4D6n7Yq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J++IwiY4nqzdcuMADqzdm/fGjZ5/9iEdASyTc6teaR4=; b=L4D6n7YqW5103sDaR4oTL/r3GF
	j1+CFM/ANlzbd1iJihJTvRzprFF/KXiMzw4qQQqHw5REsOUu4ZJeyZHg+D6Z6EfKJGEx3dSx7Vj6c
	BBuxAnPeVl6FLr84do9tRi57Xvi9r+D/udh9AAPRplrPNJphT9tnYf2jNKcI7TIASC7R+sesd9FGp
	GD4QSNXrHmc5DthLGlMThELynPYyzkig3h4DoWqPO48O3po6097LioZ6OdnoRpCsm/Tkec88Pn674
	XGfUjpm3gJIs6vWplhccCBoB0WsTRumQ0vWCr8QVeHZznC7+7iL5bX8lJDeKjHueqNO3tTdWa+ZlS
	Lp2bKidw==;
Received: from 54-240-197-233.amazon.com ([54.240.197.233] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuc8-00000004bGa-3uer;
	Mon, 18 May 2026 09:50:21 +0000
Message-ID: <d7af5a04a11432ea1878431e8b51061f19c16061.camel@infradead.org>
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
Date: Mon, 18 May 2026 10:50:19 +0100
In-Reply-To: <868898e6-1c57-498d-848d-1df9cbeac23c@linux.intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
	 <20260514215355.1648463-4-seanjc@google.com>
	 <27ba35fd-5563-4bbd-8f95-2285b50efa7a@linux.intel.com>
	 <agcXr2FP4C3I_jbQ@google.com>
	 <52fdc61a-60e8-4547-8ff7-f249b4d667b9@linux.intel.com>
	 <ad4934f4a663c448924aeabe6418e68ae3ef9813.camel@infradead.org>
	 <868898e6-1c57-498d-848d-1df9cbeac23c@linux.intel.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-3MaBQhulVS8WYOO356pa"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-3MaBQhulVS8WYOO356pa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-18 at 17:43 +0800, Binbin Wu wrote:
>=20
>=20
> On 5/18/2026 3:15 PM, David Woodhouse wrote:
> > On Mon, 2026-05-18 at 10:19 +0800, Binbin Wu wrote:
> > > =C2=A0
> > > > > > =C2=A0=C2=A0	longmode =3D is_64_bit_hypercall(vcpu);
> > > > >=20
> > > > > Is the variable name misleading?
> > > >=20
> > > > It most definitely is.=C2=A0 However, @longmode is passed around qu=
ite a few locations
> > > > in xen.c, and so I don't want to opportunistically fix this one var=
iable.=C2=A0 Though
> > > > I'm definitely not opposed to a separate patch to rename them all t=
o is_64bit or
> > > > something.
> > >=20
> > > OK, I can do it.
> >=20
> > This one (as shown above) is clearly indicating whether this particular
> > vCPU is in 64-bit mode for this particular hypercall. Changing that to
> > is_64bit makes sense.
> >=20
> > However, there is a separate overall mode for the VM, which is stored
> > in 'kvm->arch.xen.long_mode' and accessed by userspace using the
> > KVM_XEN_ATTR_TYPE_LONG_MODE attribute. It affects the datatypes used by
> > shared memory data structures, and is also latched by the kernel when
> > the guest writes the MSR for the hypercall page. That one should
> > probably keep its name.
>=20
> For this one, I think the current KVM code is consistent.
> The format is determined by EFER.LMA, whether the guest is running in 64 =
bit or
> compatible mode doesn't change the ABI.

Agreed. For the hypercall case you're looking at, switching the name to
is_64bit makes sense.

> struct compat_shared_info is used only when the guest is running natively=
 in a
> 32-bit build.

The struct compat_shared_info is also used in !kvm->arch.xen.long_mode
on a 64-bit host, as that's what means the guest is considered to be a
32-bit guest.

It's somewhat orthogonal from whether any given vCPU is making any
given hypercall while in 64-bit mode. The 'long_mode' is *latched* at
certain specific times which are defined by Xen's historical behaviour.

I'm suggesting that you clean up longmode=E2=86=92is_64bit for the *hyperca=
lls*
but leave 'long_mode' as is.



--=-3MaBQhulVS8WYOO356pa
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxODA5NTAx
OVowLwYJKoZIhvcNAQkEMSIEILxzaq/tg+g6ofrIRyObXFxM9ODiRlTunDxTUwGwXuiKMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAUyoxR13d/RiH
8dC3WiUAbKsxwc2GJPB94WBC7iObBmmAo8dAPTKr7gDyw5iwzwtcdd9lXyRns6nahUO4uBDWdvie
ZACJLNYlH5IlLI9uSQqJin6ITHzfWEXCPdzwE6voaslA40G/kyiitLaqkS534mJ/pdcRg16qAgyt
Nimd0SeJ4nS7w2OP1FupeX2fCt6exZWkuwNG6utB8qxQDVaUS1KVillrVN2oC7zE0+vnWGEPdZi7
nd24eBVnBUU1rqV8Ksgl9Ui3f0aVr+v+Qy336MbiUtl5hhgRZvMdqyRq1q20JiAEStXBblsOsEj4
DFYT7cnOIi8KHO/L3UxQrjJ+N9PE8v1wntqtyjBERNWQ6wIROmrQ+xlWQSJZICqU/cPiDddxFfic
0D+zeAr9Z0xYuT5SB1/JE2j+ULfFDKsbkvcBvyULjb6L3plA2mAk2YauwhQu4mm9LKpTs1tAofM5
dPIXpBmup6mGzX1OQbf4h/RM/FxWopqkdqf0rkplOjTGScthnl7XXkbqLA24QHQEq1CJrH+ef5Z7
atwLcLvnIz7JYBOPPqw3/XsB5nBf6qH9za8De2sYsSkordnPnZvjW/O/frHAemlcA5OV+biufdzB
9Wja1Y2aZE5AQyzSO1jAJtCEgR5sOYjC8j2oPA91vh7V5obPx0VHjvma8N+gbd0AAAAAAAA=


--=-3MaBQhulVS8WYOO356pa--
