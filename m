Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2A213E9C;
	Mon,  1 Jun 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311153; cv=none; b=n9NVoKYhUmi2BA9e84sQTesNTRLFfqse2hf1d/EyXgO08Xg6wtpg2OpPow+8//RCrXcX9JzRZhZFG66PGhUSY4whF53q5SFp8Nax/TQC3wQv1f9lh0OvxOVGH5MnKUI/xv7HAQz05FT7heKHWVoQxK/P54IMEq+SDZ5hk1gY3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311153; c=relaxed/simple;
	bh=CtXY1b6tCj45p3S7bybTQ04xhyf53r4tD+62rDu/o+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CYdAgcdF2x/Cv6dmQ21due92Hsd/qwjMPmmwPU6a2cLoq+ebmViRYfip4cYHrWU8/vOnzJi1IDu20R3jhMS4UXBMVxr7SMnRMUNTlCz/O8s//W+G7PzQGGh75rZKViMo+fmOLd38qvqMZWuEst7Th9lmvzz1FcZ9DDrNj+a6cT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vnuW0ArK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vnuW0ArK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z6ZbsAlUCa8+QBzbwfMgPm3rG9mHqJLXlJm0HxvP0B4=; b=vnuW0ArKiZNLzZwDwCYMO2LR/z
	iE/xF5GUJyxxnkgmNRhswn6LDOGAUWzYKEdAboD2RD+Kly9nCyQeYFiKI/m9x3RxgLWJUUayc/QkS
	zpa84krOgVeEJPtS7CsmZSo7ZktYe7tJTsVn3C3f10QoJzQMZ4X6CErbQpyVNK1RBH/z99HlrbLRo
	4/Ezi81BQKDwZOfIH2YKR7kvEkyQFbLO06MNIVD9jrtRU3ImPhy4bbnlsqZtlmQR8aBdP42XUHwNd
	+dUCKtErNHMfL6ULXPnajMBPTnQWu7PQsC7PjS/ymomeIcVB8T8SUIthzPbC1rfc4c69+VWxR7DkO
	QdSYDRpQ==;
Received: from [2001:8b0:10b:5:a9ac:3853:5e3b:fafd] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU0Ft-0000000B6ka-2uPK;
	Mon, 01 Jun 2026 10:52:25 +0000
Message-ID: <14442dbf1e6d758fdd4756f2ed5c8cb2738582fb.camel@infradead.org>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Paul Durrant <paul@xen.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>,  Waiman Long <longman@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,  Carsten Stollmaier
 <stollmc@amazon.com>
Date: Mon, 01 Jun 2026 11:52:24 +0100
In-Reply-To: <CABgObfYJsacrCDHRouLDsEz_QF0EBQd8pu3g-V_gta6Eac2e+w@mail.gmail.com>
References: <20260529165114.748639-1-seanjc@google.com>
	 <20260529165114.748639-2-seanjc@google.com>
	 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
	 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
	 <ahnxfACTGeVFbJMk@google.com>
	 <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
	 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
	 <aho1M7fvK1Qzmiai@google.com>
	 <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
	 <58d17a623c1c5c9c09bd91baa30510aaf42f899b.camel@infradead.org>
	 <CABgObfYJsacrCDHRouLDsEz_QF0EBQd8pu3g-V_gta6Eac2e+w@mail.gmail.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-F2/tfdnQKjMoFnpMgqMn"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-F2/tfdnQKjMoFnpMgqMn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 16:40 +0200, Paolo Bonzini wrote:
> On Sat, May 30, 2026 at 3:04=E2=80=AFPM David Woodhouse <dwmw2@infradead.=
org> wrote:
> >=20
> > On Sat, 2026-05-30 at 12:26 +0200, Paolo Bonzini wrote:
> > >=20
> > > Yeah, I think so.
> > >=20
> > > The write side needs kvm->srcu so it would have to be yet another SRC=
U.
> > > I initially thought that sucks for the code that calls kvm_gpc_check(=
),
> > > but maybe not because it simply replaces read_lock/read_unlock.
> > >=20
> > > By using a seqcount for the data, SRCU only needs to be synchronized =
in
> > > gpc_unmap().=C2=A0 So, something like this:
> >=20
> > It isn't just gpc_unmap() which does the invalidation. We also
> > invalidate from the MMU notifier in gfn_to_pfn_cache_invalidate_start()
> > which would also have to synchronize, wouldn't it?
>=20
> You're right, the write_lock_irq() there drains the readers and that
> is needed because khva is not pinned, only kmap()-ed.
>=20
> That is already broken for the OOM case under PREEMPT_RT, where
> rwlock_t becomes sleepable. But using SRCU would break it on
> !PREEMPT_RT as well.

I don't think 'sleepable' is the problem per se, is it? *Why* does the
OOM killer use mmu_notifier_invalidate_range_start_nonblock()?

Commit 93065ac753e4 ("mm, oom: distinguish blockable mode for mmu
notifiers") did say:

    There are several blockable mmu notifiers which might sleep in
    mmu_notifier_invalidate_range_start and that is a problem for the
    oom_reaper because it needs to guarantee a forward progress so it canno=
t
    depend on any sleepable locks.

But that was in 2018, when mmap_lock was an rw_semaphore.

Is "sleepable" still a problem even when PREEMPT_RT where almost
*everything* is now strictly sleepable? Wouldn't that mean drivers
aren't even allowed to take their own spinlocks?

I think the *real* constraint in the OOM path is that it mustn't block
on anything which might be waiting for memory allocation. So waiting on
an actual mutex is bad... but waiting for an rwlock which PREEMPT_RT
just happens to have made sleepable... should be OK?

And waiting for the in-guest CPU to respond to the IPI in Fred's patch
should actually be OK too, but then so would returning -EAGAIN if any
vCPUs really did need kicking.


--=-F2/tfdnQKjMoFnpMgqMn
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYwMTEwNTIy
NFowLwYJKoZIhvcNAQkEMSIEIC9PUSKwkU0FJzGAghb9NpPFJE0dTxIX5IbLEAzZuI4wMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAKEWTkmMc1lv2
rOs8ux1qfmOpCqWkFx3q7AWP23rlXLF4BolFIuTATdIEwdbdjEvWRahPdIOB9uCH8vzJ0QLwwmzt
8A1GY2bSPEYPEUyfV94Za1q6B4DHS2g0Pnj1rVe/+2QQLjEVSaG0hKo6ZE9o/Xi6PcYITywnrqFW
IxQtfXmVSnkdzjDihB0uNjqDubP3efDnvUh0vD3HdDvxx6S5XWpq04EbboA2JII9P7f/3zBE5jyy
IuK8QtHlmZW8DrraMP623On8a5LzHV8Eg+ZXEwOOXBbgID+MX9vKDBlhZ9U+krC3artTwUJLBxv7
L/2p9ikj3hc2LMRloMOU/VFEjKzr/b54lLBTJgDuE8umQFYoNtcRNZRljOSZXo4NWrHqzl4Y8DRn
R/8IS6DKQCw4yV17D71R0C/q5KniQg7zWyrUOw67aEdAZRGuO6fCFknM7JBjF+H4RO4Xu6m+2fvp
VKIjpIX3lSeidPejnvlzslczfsLW988AAbfGiReh+qNOY1BNsGjU0fXfr+oDTsFHm0/LZZiO3DOl
JJG1hPBPOekrndwXrdW0orldzJVHcHa/5q6oqzeCgnFH/iCxJqTucD30PEn46ZS45Cdo97sqX4PT
WhnR7Vgqsb6a6qrgSpq1Zso4wrCeCMVQKeJoSysDgTEUXkGSRdiWRiEvxh4NRMsAAAAAAAA=


--=-F2/tfdnQKjMoFnpMgqMn--
