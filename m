Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68772E8B82;
	Thu,  7 May 2026 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175967; cv=none; b=FehXuUVmwRt36t6yO3+a+DMFylcGtWwV2KgpxIOZTBaigAgfAYegbrPJUmznoulxgHISzPzhVQnFo/nOqyH+hq6AuN/19FVTuABiq91GZFg/lYWklxgim2KoZdZwopeYeDc4iAWB7GRaCjSNtE+uT2GcFbQyGDwvv8NS+y3oRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175967; c=relaxed/simple;
	bh=yGon/nWi7gndXSyOl0iGbfMcmQqtLRLv0CvWdIu6P2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ojJGHJWouUPjHVhJW8cwL4OoOEqXpzCaiDsj2ByNSzq8KkQyvxnq/IBYRFaotPCW6LxR2nXMhFUrHBAfK/6QFKTOiRpSuNDYcNuo49f3ugjoYm7w1p6uDZlYifPj3xVHHnJENqXbD0lDn+ZKJCQ8ehOkb9QMazRHvaPGeLB96rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bLbBX5dT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bLbBX5dT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LDdUTevgTTnfnOfFxrbqbR9l7LydSdwN8DDSqJTbiqM=; b=bLbBX5dTeMyP0UdSaGJfEaVm02
	f0O2PWScJ2M29FH9YcLbVwpZb7TpmwGEaq9nRVcdHdAbBrHoJ9Qglg/Ctlm+Bfx150E7+Jlf88ljx
	GGpmY1Vnsq06/OPSo034//v6ru4eZ6poBEN0OU4H9Z7Ak3lg2oE2wlu7Z8xmhcEJz8di5uNmw9OjZ
	wzgwLNJEAgvHL6+g5i35C5G+RDFQo0QVeS1TLvUEjsWacGtxQFJrDks9BSZ9L7FLqshnnA7j0h41F
	aJjr6NVUMf8jjc85xjqFnOWH0uzmY+IsRIS3CSqSG03azpDpXWCdvBc2fQKQ6S99jcL3AutLo/6d5
	9MYLPCrw==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL2nF-00000004Dc3-2pot;
	Thu, 07 May 2026 17:45:50 +0000
Message-ID: <c48279f6f7c9efa6c995472b8a88a6afc7f54370.camel@infradead.org>
Subject: Re: [PATCH] KVM: x86/xen: bail in IRQ context on PREEMPT_RT in
 kvm_xen_set_evtchn_fast()
From: David Woodhouse <dwmw2@infradead.org>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Paul Durrant <paul@xen.org>, Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kernel-dev@igalia.com,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Date: Thu, 07 May 2026 18:45:49 +0100
In-Reply-To: <d47d2c7e58abed48332902e34f4e9984@igalia.com>
References: <20260506-xen-rt-sleep-v1-1-53b6b60a671d@igalia.com>
	 <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>
	 <e23df9d183c2c421946ea73b8053e4c4@igalia.com>
	 <876c720ab963f550d3166b067f6457fcd78ec415.camel@infradead.org>
	 <122adcacb2a6ccc3a5b78c750fe85e0b@igalia.com>
	 <9bc8666e63d7de8b32dd23934fe0097f98d72726.camel@infradead.org>
	 <d47d2c7e58abed48332902e34f4e9984@igalia.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-r/EM5EAljKavVNTsgM2f"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-r/EM5EAljKavVNTsgM2f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-07 at 13:34 -0300, Mauricio Faria de Oliveira wrote:
> On 2026-05-07 13:15, David Woodhouse wrote:
> > On Thu, 2026-05-07 at 13:02 -0300, Mauricio Faria de Oliveira wrote:
> > > On 2026-05-07 12:22, David Woodhouse wrote:
> > > > On Thu, 2026-05-07 at 11:56 -0300, Mauricio Faria de Oliveira wrote=
:
> > > > > On 2026-05-07 03:58, David Woodhouse wrote:
> > > > > > On Wed, 2026-05-06 at 23:36 -0300, Mauricio Faria de Oliveira w=
rote:
> > > > > > > kvm_xen_set_evtchn_fast() calls read_lock_irqsave(), which mi=
ght block
> > > > > > > on PREEMPT_RT, but that is invalid in IRQ context, as when it=
's called
> > > > > > > by xen_timer_callback() (even on PREEMPT_RT per HRTIMER_MODE_=
ABS_HARD).
> > > > > > >=20
> > > > > > > Check for that case, and bail out early.
> > > > > > >=20
> > > > > > > Note: there is previous work and discussion on this [1] (~2 y=
ears ago),
> > > > > > > which involved continuing to execute the function with change=
s, but it
> > > > > > > was not merged. That was a different, more complex approach.
> > > > > > >=20
> > > > > > > [1] https://lore.kernel.org/lkml/ZdPQVP7eejq3eFjc@google.com/
> > > > > >=20
> > > > > > ...
> > > > > >=20
> > > > > > > +	/* Bail in IRQ context on PREEMPT_RT; read_lock_irqsave() m=
ight block */
> > > > > > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && in_hardirq())
> > > > > > > +		goto out;
> > > > > >=20
> > > > > >=20
> > > > > > The approach in Paul's earlier patch was better; we absolutely =
*want*
> > > > > > to deliver the interrupt to the guest immediately whenever we c=
an, and
> > > > > > only fall back to the workqueue in the rare case that the share=
d info
> > > > > > page has been invalidated.
> > > > >=20
> > > > > Certainly, that was better. This was a simple workaround, but wit=
h this
> > > > > clarification, it indeed doesn't fit.
> > > > >=20
> > > > > > We should switch to plain read_trylock(), *without* the
> > > > > > local_irq_save(). And since this was the *only* case where the =
GPC lock
> > > > > > was ever taken under IRQ=C2=B9, all the GPC locking can drop th=
e _irq part.
> > > > >=20
> > > > > Ok, I can take a look. Or do you plan to work on it yourself (as =
you
> > > > > hit the issue with read_unlock later in this thread)?
> > > >=20
> > > > I'm working on it now; thanks.
> > >=20
> > > Ok, thanks; I'll drop this. Could you please Cc me when you send it o=
ut?
> > >=20
> > > > Currently confused by the fact that the read_trylock() seems to fai=
l
> > > > more often than it should under RT, causing the fallback path to be
> > > > taken... and the fallback path doesn't seem to work properly...
> > > >=20
> > > > Your version should have seen this too, surely? Did the selftest in
> > > > linux/tools/testing/selftests/kvm/x86/xen_shinfo_test work with you=
r
> > > > patch?
> > >=20
> > > Yes, it works, apparently. Timing is similar with/without PREEMPT_RT.
> >=20
> > Huh. Something weird going on for me. Would you mind confirming it
> > still works with my version:
> >=20
> > https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Dr=
efs/heads/gpc-stealtime
>=20
> Yes, it also works with that tree [1].

Thanks.

> Is PREEMPT_RT enabled in the Xen guest as well? In earlier tests, that
> caused interrupt issues on boot (a few 'nobody cared, try irqpoll' and
> 'Disabled IRQ #'), but that also happened without changes in the Xen
> host kernel, thus not a regression, and I disabled it as couldn't look
> further then.

I haven't got as far as actually running guest kernels under
PREEMPT_RT; I'm only using the selftest for now.


--=-r/EM5EAljKavVNTsgM2f
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUwNzE3NDU0
OVowLwYJKoZIhvcNAQkEMSIEIPp04C2esJ5xMZAyOe2C8c8og+nY7J7DnmT76jaqOWHHMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAeC23a52+NDu2
YQ9Au/0ZRVHInWCnG5PvIg2zPP++nkqsVIDsn1cV7YnN63hsG2DhIbzvu5IaWjNx7vqssVTzDifs
ZZqI7XRrzYasbsaIbaW0N+V+RFT8dscP0VXupNj4Yevyy9W+ZkDScZbbCApbmgnh7rlx9A66vHYk
HABJNpeyVzUh/2o4zcfutGgDWxu1R0lxL2KmGurjAx1j5GN/OY9LJyy4G2r6Y5zGRs+AfvpVqnpg
SZGjbqxG3R7R3SBVL31kAnk8RNILYAutWcL74ACDBzR6amOdAdluY/s0kviHlqKURq+lamY8BpIa
KFZ7ZUHEDHitZhN/Pbex2en9Nc3iyD4BU1wYjWkXUTmkB+MJeLgG5HzQWluwPHeoCwgK7OH2fOrS
M7WB/E/6vSrCvTeMgAl+ix4cUQtFp46OA+4PuhaVGDqGAdXug7zm1jUjHLT9xO4/p1eg6wB/prjC
W+zFOPUVUjA2lj76Le4gas+BL4P/27N+Q64Nf9ZFbJPm5ZEF1E01keRn/lUnwlkbDqzjgwXNhwnV
dBZOJ4PwTNApEYeLNhb2VxoKZxzx6cPiFksOPvsz9FNp+qaHLPy2nILr7Q7NDp8WE/9H/lNrP2nb
8ajy2NrkTC9KSkSabPE7rdM7NwmSazszuePmY6A93thARyouAw+DHlRBD019fd4AAAAAAAA=


--=-r/EM5EAljKavVNTsgM2f--
