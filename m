Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D45315D3B;
	Thu,  7 May 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160953; cv=none; b=dLzyI+RH8qFmX94cf20Vli9RD3v8clipqmEOjwx/tQ5CYTyixVeWakU8rKnrQRqXS0l+tedUN9fzVxmm8SkSU1mcufpn1vwUinHpecuhDyjfLOnLBBWYk5/Gfpe6E0HwuWUsNez6x7RSSZUofz2TLVSxRQ9dz9u5iThvb+CkRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160953; c=relaxed/simple;
	bh=DQMHpgBnsCMDJt3GBwfOd6OYFPe/Fnx4upnJ4hAMzGs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmOONGagsH9cgz1h53tMFN0ukuYmeN7ErYHL8lv4FSpb4NDROZHdK1VpHuhwKKFPwHa04BI0euMJ+Uemj3cr2xNgkRliqZYo6pS40tKfJxSEOh0+3xtbxFydhR/q1l0H5wm33pD6WgmLgsgpuJGKK42YK/l8kmxa8WubnC9rWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YQuVm+Ou; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQuVm+Ou"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tyUxRUVrHdhzs0FVQzhxrTIZ/JvvUrRJB/rO2nikeiQ=; b=YQuVm+OuteptGlXOu0zbOThcHW
	Vzir8I3iSTulk8hHRqt2Nl7GWLYiIcfJmHQ1PGJjwJ3VZ+duEC9Km32/kG6gvPQG+N7MV6caELW/D
	0umA8mio6TzXPWDrHKdLZ8wzvx60N5nGpB7wJTFFo/Kf+eXtj9zpoRMUmWuH9bLpf5njl186VMiQC
	ohvTVatz1EGDB49LD8pQtCgPEKkGCrLMA932noIXIbwwUHJqv/4tcmtY+JP+bFcLEh3lo3iTLfkAq
	cD3HF/XQYRWcBNgVgbyASZA4T+2L8M/5C4pPGWRGLFUqzaaXcqYjTSm4htfIplAqdidDtX14yeivN
	xmyM1z8A==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKytB-00000003dtI-2tLF;
	Thu, 07 May 2026 13:35:42 +0000
Message-ID: <1146015e19d441f135d81f376c158c938a7ba340.camel@infradead.org>
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
From: David Woodhouse <dwmw2@infradead.org>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin@zytor.com>, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org,  "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
 pbonzini@redhat.com, seanjc@google.com, corbet@lwn.net, 
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com,  x86@kernel.org, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org,  chao.gao@intel.com,
 hch@infradead.org, sohil.mehta@intel.com
Date: Thu, 07 May 2026 14:35:41 +0100
In-Reply-To: <afxm400MglHAjoje@wieczorr-mobl1.localdomain>
References: <20251026201911.505204-1-xin@zytor.com>
	 <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
	 <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
	 <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
	 <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
	 <afpPt7gObsyFkPRy@wieczorr-mobl1.localdomain>
	 <f4650572ea8277dcde8d68e4fa5317e1abdb988c.camel@infradead.org>
	 <afxm400MglHAjoje@wieczorr-mobl1.localdomain>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-oBYDOWa1JcV/H/R4Nr8z"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-oBYDOWa1JcV/H/R4Nr8z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-07 at 14:59 +0200, Maciej Wieczor-Retman wrote:
> On 2026-05-07 at 08:49:27 +0100, David Woodhouse wrote:
> > On Tue, 2026-05-05 at 22:20 +0200, Maciej Wieczor-Retman wrote:
> > >=20
> > > I take it you mean dropping the ICEBP selftest test case and just che=
cking INT3
> > > and INT $0x20? In that case the other two tests pass after a minor ch=
ange -
> > > namely in guest_code() the expected_rip needs to be volatile as well.=
 Otherwise
> > > there is a RIP mismatch.
> >=20
> > I don't understand the part about making expected_rip volatile. Are the
> > asm constraints there not correct? If not I'd rather *fix* them than
> > use 'volatile' to paper over it. I can't see the issue though.
> >=20
> > Can you show the generated asm both with and without it?
>=20
> ---------- not volatile ---------------- | -------------- volatile ------=
-----------
> #APP						#APP
> # 156 "x86/int1_fred_test.c" 1			# 156 "x86/int1_fred_test.c" 1
> 	lea 1f(%rip), %rdi		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |		lea 1f(%rip), %rax
> 	int3						int3
> 	1:						1:
> # 0 "" 2					# 0 "" 2
> .LVL42:					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <
> 	.loc 3 159 2 view .LVU146	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <
> #NO_APP						#NO_APP
> 					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >		movq	%rax, 8(%rsp)
> 					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >		.loc 3 159 2 view .LVU146
> 					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >		movq	8(%rsp), %rdi
> 	movl	$6, %edx				movl	$6, %edx
> 	movl	$3, %esi				movl	$3, %esi
> 	call	check_fred_event.isra.0			call	check_fred_event.isra.0
>=20
> I think that when the FRED event happens it doesn't save RDI and overwrit=
es it
> before going into check_fred_event. In the volatile case it is saved to t=
he
> stack before check_fred_event() (.loc 159 is the check_fred_event() call)=
.

That looks OK to me. When it calls check_fred_event(), expected_rip is
the first argument and thus lives in %rdi. On the right hand side where
it's volatile, it gets explicitly loaded again from 8(%rsp) for the
call to check_fred_event().

On the left hand side, the compiler doesn't mess with it at all; just
chooses %rdi as the register to use for the output %0 of the inline
assembly. So it's loaded *directly* into %rdi by our 'lea' and it goes
straight from there to the check_fred_event() function as it should.

Your version turns it into a memory operand and forces it to get
written out to the stack, after which the compiler has to load it
again, so yes it'll look a lot more like your right hand side.

But I don't see anything actually wrong with the original.

--=-oBYDOWa1JcV/H/R4Nr8z
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUwNzEzMzU0
MVowLwYJKoZIhvcNAQkEMSIEIFGNnpsnAkEZ/zJ24PYoGWeMYLfqn3eRl2BIWMnQ7pUKMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAByFl7oD2qFx6
Yz2N6Pdy96O5mj3UIQUk4XYEDG69knkU+M/sUw2Pe0Ilg0HV4fjtBm1spLsogLzJ64kUwMkdSRXT
r4VCjvDSdeOdxyYo5KNB4QCbqPdnbRUzr2z0+kB0dGogunAEbX2GVx9WKl5JDvYenjwGksvXS3PZ
jhj5MQSR8ucz6FMc4XusY9Z+DS4QxoyHQOElYuZ3TpagVw+P4zPcnLQhzsCdB24NPujV2PpRTNJY
MgC4NH4SHqnFNXrogq5Q5ejPMC9TDIcjPmRCcchrVSR2jJBxByKbtucnQq3J9UzGX5P9cS//Ik3t
HcUA5d9LSXHYLk5ZUMMFTPigbKTzLl07mrRPbopNl1MZSreJdgd0zxWhIy3Nw9P9qHNNukcgF9Q+
U3C1lmTAa7Pk2MhFAk6dTkQc49LAshcxlrPsjue+2q6N3pCYYdlzMd8BccLFEcRmHOwiPM15WmVx
+1KqF5eLZRXi2Yh1+1mPM2NsAwQB2W7zmuD/pR3POtzz5P5su43mvs/CF5QWELQ+1dk/vL8lVOTT
RMuLIUs/cFNAZZh/7YoTWnPNW2E4OY4kKIGHdQFxnN6Zh0gXiAzP5kN2JkugTD25xSV8PBZAAkQp
bvr+5o7nPs75tsKBaP182zotvgkuQ49mH0HRQr15e/LU89BYkn+o2J7YiiD4oxkAAAAAAAA=


--=-oBYDOWa1JcV/H/R4Nr8z--
