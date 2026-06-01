Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA793D9DA3;
	Mon,  1 Jun 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326723; cv=none; b=MQGauEhXgllh8Fc3qnxL6UJbHXuQ7CbIwVlw/XtQz9yL0dLZPUt+f7Hr4NVeClVu1l1CEXvbOMgtevaNIC8SbyqF3imE00u1RIjuQlJdQRBwwRR9jdmrxGmDkr4PSysAgnRlxte1+peXQSIDyKyo71PiWXmzt+W7ZsyZQHHNmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326723; c=relaxed/simple;
	bh=fMftG3NJd81P7I06BN+8vTqGyWsFeCGiCV6oS/EA8t8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6t2VZfquRtetIyIecT9yvAI5sV8J1j8QYs+bUB+WAE0u6KAzbZE2DaQbBWSBOrUGbxpuIeaAK4bpACRl/HhRlo/1yNjFnAonofXmtg4iMWB4up3dNNy/UPyeRdFlnRJ1Z3RBhRq4SfGzgngMxgMyjUfLxP2xjoOBkonBw378eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gKkHuHgD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gKkHuHgD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fMftG3NJd81P7I06BN+8vTqGyWsFeCGiCV6oS/EA8t8=; b=gKkHuHgDwvWDTuzoq2nMpSibd8
	WdasK9JNcn3g/2xtoZjttV0QRD3OUfrHSS8yXKJJGp67D8N45XHrTrl7meWVKfrOv0WvSE1hMRqAo
	1hboJ4Xb92AiK8+tBYQDVACMACxg/AZJjhXv3g5TDdZ7h8utbQ9N1vSav8xbSEBYl3P0gus3/UD9i
	Ic8185scV5Cr6X1dfHq3fHnWWriidV7/CKL86PKoSHytMnhp9jeq1pOBLrSub7E1xZTFtlhKUHBep
	qZzeKc68MGrLVzPvBiuBgjR2paBtbdRvKsC2E2RrJf0kbvufHiCYiMDIexFhs8n5tCeO1PTB7dagt
	fvhbfiGg==;
Received: from [2001:8b0:10b:5:5b40:b57d:669c:36f4] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU4J0-00000000IVs-0AIJ;
	Mon, 01 Jun 2026 15:11:54 +0000
Message-ID: <17bef051da24e7f219076eafafbe883c141613c2.camel@infradead.org>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
From: David Woodhouse <dwmw2@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>,  Peter Zijlstra <peterz@infradead.org>, Paul Durrant
 <paul@xen.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, Carsten Stollmaier
 <stollmc@amazon.com>
Date: Mon, 01 Jun 2026 16:11:53 +0100
In-Reply-To: <20260601144724.ARQR8tYh@linutronix.de>
References: <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
	 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
	 <aho1M7fvK1Qzmiai@google.com>
	 <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
	 <58d17a623c1c5c9c09bd91baa30510aaf42f899b.camel@infradead.org>
	 <CABgObfYJsacrCDHRouLDsEz_QF0EBQd8pu3g-V_gta6Eac2e+w@mail.gmail.com>
	 <14442dbf1e6d758fdd4756f2ed5c8cb2738582fb.camel@infradead.org>
	 <787aa26cf62dfd361eea8ed19f384fc517892501.camel@infradead.org>
	 <20260601134008.rllwJtn-@linutronix.de>
	 <a9867c036a1f6b6d29c0838b8e6884d814dfde66.camel@infradead.org>
	 <20260601144724.ARQR8tYh@linutronix.de>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-DR9lJXNTWWaJRD2gDl70"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-DR9lJXNTWWaJRD2gDl70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 16:47 +0200, Sebastian Andrzej Siewior wrote:
> On 2026-06-01 14:53:14 [+0100], David Woodhouse wrote:
> > On Mon, 2026-06-01 at 15:40 +0200, Sebastian Andrzej Siewior wrote:
> > >=20
> > > Okay. This complains about non_block:
> > >=20
> > > =E2=80=A6
> > > > [=C2=A0 429.927260] KVM: non-blockable invalidate_range_start, non_=
block_count=3D1
> > >=20
> > > and commit 312364f3534cc ("kernel.h: Add non_block_start/end()") says
> > >=20
> > > > =C2=A0=C2=A0=C2=A0 Peter also asked whether we want to catch spinlo=
cks on top, but Michal
> > > > =C2=A0=C2=A0=C2=A0 said those are less of a problem because spinloc=
ks can't have an indirect
> > > > =C2=A0=C2=A0=C2=A0 dependency upon the page allocator and hence clo=
se the loop with the oom
> > > > =C2=A0=C2=A0=C2=A0 reaper.
> > >=20
> > > so a lock which becomes sleep-able on RT vs !RT shouldn't be a proble=
m,
> > > right? We also don't complain about about scheduling within a
> > > rcu_read_lock() section if it is part of spin_lock().
> >=20
> > Right. This is just a false positive in the debugging check, AFAICT.
> >=20
> > It's actually *fine* to take a spinlock or rwlock in the OOM reaper
> > path, *even* if RT makes them in sleepable locks. And I think even the
> > KVM_REQUEST_WAIT IPI is fine.
> >=20
> > But to fix the false positive warning, *either*:
> >=20
> > =C2=A0=E2=80=A2 non_block_start() shouldn't complain about "sleepable o=
nly in RT" locks,
> >=20
> > OR=20
> >=20
> > =C2=A0=E2=80=A2 The OOM reaper path shouldn't use non_block_start() und=
er RT.
>=20
> Looking at the list of users it was probably introduced for the mm
> folks. Let me add this to my list of things to look at=E2=80=A6

Thanks. For the purpose of KVM we shall ignore the issue and assume
it's going away. It is safe to take both spinlocks *and* rwlocks in the
"!may_block" invalidation path.

And probably OK to IPI a vCPU to GTFO too, but we'll discuss that under
separate cover:=C2=A0
https://lore.kernel.org/all/7428996952122d5943715c8682c6ad1c353566f9.camel@=
infradead.org

--=-DR9lJXNTWWaJRD2gDl70
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYwMTE1MTE1
M1owLwYJKoZIhvcNAQkEMSIEIE7WZe7TfANnr34R7AlhsZd0A2IY9jxPvWuAVH96mUPqMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAxbzolDbMPG38
IdwXsw6LjiG3Ak2xanPladkgKWFB63dY9r76vkOi9xoAwF79fcTJN5QnP5gqn9sDKjSF7XoEisJC
rhqesn+xx83mK74p2zqY27Q7wtUGTn/HX+sGht8sERCAwLQ7Dq5iI1EbFnFWFOGwEK8uRD0BXWce
WMbCPYnuwbdXHKphbMZeXuqMGWVS9/LTgvdE6FthaydRvaj7idm1o+o++nTFPnfg6qNQ76GJ38Od
9VMZp7i1nb29+NLmeKw1jiXhf0klVWWNuarAASUHCnJXOPH2Kl9Cpd+Ub6hoMzBzDj3lmyjx5MIC
7m3JKyBz2PUzmXQizEls56rQXG4ZXcL/rIu/dfERhApubFCd3enGPNkJXDk2Zg2+JU0niCHrj5/u
feKVShVi2JhavVjmLNbZJ4YXbbhuO6hWhhVDuFStm+I54cxZT4qkO7AGRLbf2NC0+lu6RW11clMF
KRnqyXkk2tu+oZWrLkSR9kC935v9qULQwDErlREYtgNhNu8LP8z5C/5KiyuCAjB/0kW+RWGfW/KQ
C4yqyhhKaxeYnHrTjAfT8qi+asUjgE4+p6U0RZOHJbKayaY3p6Wn9fzgrNXdhGDKClpkhU7f6HaP
HRq2mGOo3wJXfRcET6frg0UM6TZ8WBHX55NGVsAgF2I9J+Pf0KZZ+pdwH12ECE0AAAAAAAA=


--=-DR9lJXNTWWaJRD2gDl70--
