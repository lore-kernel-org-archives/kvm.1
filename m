Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532CB2F8E82;
	Thu,  7 May 2026 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194831; cv=none; b=bkEwIGGGwIMOytNnERnGtUHnmv8Gx7iM9xEtxCrFX7Kj6yeSo/S0QOSW1oUT67Bi1BSwv1e7TtmdJ2KAYzb89VuxpGTmk1QuKlOc7e6RNsRHjYkCpaknN+V/qgagtkloVjsYSBp33PtRMkfI9vY8cQQeT6Bw/S+IeASgcIXs0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194831; c=relaxed/simple;
	bh=6Dm4hXH4o6oGBRf9PHFm5jvQg9V0nkMjf8aRjNzhHY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H9BRf1TOC735ZDIIBAgtgnGR5a9AYEYXOzxVjzjj4HJOvZUVD6dcahnevcwM7s7y47gjk1YfdZOc5FckE7QTqWuaB0N5L4WobRkWjfkyiytFVZ/o/UebOru6uHfpa5ZLMKNHNm9fqURAVhtDnnZX1OWapgB/A7hCCfPxCRbTmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hylZe76Q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hylZe76Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1eyRFt7KxgxNwPrjXchyQHWQHHMjRq6rE0uvPcHhvSg=; b=hylZe76QEMyDYdB4YSvznQmLGO
	uBolLIN+lCsQn5ayD32gwRVvC+1NGM49Ih3Y/gW6T4xk+MkVhRmQpeIcBFFnuu/cLde8xnJ5YUIWA
	kpjv/2e7dB/W5PlzqtSkI5l9U2xfqSz0qGgArktAZQgUmToIBJ5kBQWRk+klLDqQhyqD6kezpHX4h
	ydb6tq0iTId2JPVRNR28Nvy7fxDis052lyCOoZEVV4ttGPhtNDKjw5yqFUJryebb/gTZX3OfgDzah
	n6rHRNMOR4O4OP8986MwCPbp7X7V6ViQGWb5KdtCn3uy6aS2bvtF+IKXiW8AjOj4aPyE3nV/5O8lf
	O4bwvqrA==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL7hd-00000004kSN-15os;
	Thu, 07 May 2026 23:00:21 +0000
Message-ID: <e2c20e1773b9579ea4cea3b26d7eec02671757f8.camel@infradead.org>
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
Date: Fri, 08 May 2026 00:00:21 +0100
In-Reply-To: <afyXgQdzdTr_JNXf@wieczorr-mobl1.localdomain>
References: <20251026201911.505204-1-xin@zytor.com>
	 <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
	 <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
	 <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
	 <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
	 <afpPt7gObsyFkPRy@wieczorr-mobl1.localdomain>
	 <f4650572ea8277dcde8d68e4fa5317e1abdb988c.camel@infradead.org>
	 <afxm400MglHAjoje@wieczorr-mobl1.localdomain>
	 <1146015e19d441f135d81f376c158c938a7ba340.camel@infradead.org>
	 <afyXgQdzdTr_JNXf@wieczorr-mobl1.localdomain>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-D33cGU03nwedIdd4gfI2"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-D33cGU03nwedIdd4gfI2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-07 at 15:53 +0200, Maciej Wieczor-Retman wrote:
>=20
> My theory is that after 'int3' call the FRED event is handled elsewhere a=
nd %rdi
> is not preserved. So the original version of the assembly looks okay but =
I was
> thinking that int3 has side effects.

Please could you try the version at
https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dcommitdiff;h=3Dfre=
d
or this incremental patch:

diff --git a/tools/testing/selftests/kvm/x86/int1_fred_test.c b/tools/testi=
ng/selftests/kvm/x86/int1_fred_test.c
index 7ffb54b56047..b91600abda62 100644
--- a/tools/testing/selftests/kvm/x86/int1_fred_test.c
+++ b/tools/testing/selftests/kvm/x86/int1_fred_test.c
@@ -74,7 +74,7 @@ static volatile uint64_t fred_ss_value;
 static volatile uint64_t fred_saved_rip;
 static volatile bool fred_handler_called;
=20
-static void __used fred_handler(struct fred_stack_frame *frame)
+static __attribute__((used)) void fred_handler(struct fred_stack_frame *fr=
ame)
 {
 	fred_ss_value =3D frame->ss;
 	fred_saved_rip =3D frame->rip;
@@ -99,8 +99,41 @@ asm(
 	/* Pad to +256 for ring 0 entry */
 	".org fred_entrypoint + 256, 0xcc\n"
 "fred_entrypoint_kernel:\n"
-	"movq %rsp, %rdi\n"
+	/* Save all GPRs =E2=80=94 exception must be transparent to interrupted c=
ode */
+	"pushq %rax\n"
+	"pushq %rcx\n"
+	"pushq %rdx\n"
+	"pushq %rbx\n"
+	"pushq %rbp\n"
+	"pushq %rsi\n"
+	"pushq %rdi\n"
+	"pushq %r8\n"
+	"pushq %r9\n"
+	"pushq %r10\n"
+	"pushq %r11\n"
+	"pushq %r12\n"
+	"pushq %r13\n"
+	"pushq %r14\n"
+	"pushq %r15\n"
+	/* Pass pointer to FRED stack frame (above our saved regs) */
+	"leaq 120(%rsp), %rdi\n"
 	"call fred_handler\n"
+	/* Restore all GPRs */
+	"popq %r15\n"
+	"popq %r14\n"
+	"popq %r13\n"
+	"popq %r12\n"
+	"popq %r11\n"
+	"popq %r10\n"
+	"popq %r9\n"
+	"popq %r8\n"
+	"popq %rdi\n"
+	"popq %rsi\n"
+	"popq %rbp\n"
+	"popq %rbx\n"
+	"popq %rdx\n"
+	"popq %rcx\n"
+	"popq %rax\n"
 	".byte 0xf2, 0x0f, 0x01, 0xca\n"	/* ERETS */
 	".popsection\n"
 );


--=-D33cGU03nwedIdd4gfI2
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUwNzIzMDAy
MVowLwYJKoZIhvcNAQkEMSIEIOXj5oygGANQEyUaeyj8lABb5n5K2/TiqlJnvo3aZxHhMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIATwARSWUn20y4
wPkVJ9ZUSL+pVaZCAfAd/5ypgkKEb7oKY+rq1saw/zaaJLvCsSa9+CiBnQQJQpMpUZcZRGM0vXwT
7k8u84/uNgFh2kR0s0cORxPXNFWD7CV2Q2B7aom2Kl7nYGkSL/xPqFIagODuAA6rAo8p2ZWm7NUC
dz09k+3iwAwoOdjMis8vP1lX42Q9LNbA77+hlI1Q573MAZp8vUTkkiqweSj83HKtQx5/3n71Q1hH
f0LBK8Rua2JO8x8b1DvpmxoTbH6lRyA7Em7iLRb6uIf72nweVN5abi6yICuRhiKongZ4FDcalPkK
kGPp7/nggw/swj2iqeWzNO3vE8mk4bCWZQRLHnDmKUJ+VgO/jfMLdRtlx63bNqVY2neixgF9PV4R
FZY88mIUm+Q/GTlQMy4IZWSMfyqYCVG54lytLK29G9fHiKOAT54LZOK9NtUgcNQbwVAAZrR9BdMc
HMr9vZoVHYxvWTXkKVWoHE+zdijRNHgrm/qoWVSGBmgKGrJo19FQLpuxIMtwfUMAKnBkW93zbPk/
AnK2CLK11v2aQTrYLQBqa2cqDirrcgWbPaXPIKPE8O2IJ4eRZwqReh+PNyw7Anz6zFZYkz1vRJDc
xQTqLIVI1q3Uv7R9+GVJ5luLY081tUyTS3ArAmbyTaeM2M7Zm/Eud6DKhED328QAAAAAAAA=


--=-D33cGU03nwedIdd4gfI2--
