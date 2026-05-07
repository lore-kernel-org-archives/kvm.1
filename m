Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9F3EF0A0;
	Thu,  7 May 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161412; cv=none; b=qMkWWKs6Vwh/hmIa7Y+xKUNLWHbQDaaxfVg+apCHA94ACJ7miCxJ6ygq3BRbw5Q1vEppzM38UOzg3YVebHXtJrd1zQYpqSrpDXQ8xRu9WU2Ufb3vzZyqkT6dKV+tEwLu4gUuNVbmD8GUVOtMeBqa5x+XqW50V+81kZERjxvWK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161412; c=relaxed/simple;
	bh=QUm506ZL5SLevPs4jte/E6h2zGVUtWm7sHkg+PLjsX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oavuwXCFKT3I/6nuRanzBere/A88HZSj6G7Hvs+yVNt8AI58V0cS3eAiQWt/FcuME2m9p6cySDOr6DohMLYi6l+4cDCr/qvWqYSXTdXRkA3cnVqbg63nGRN3asALsSXP+b38AGxD5keLy0X6mtds6lumAF/gDPOOdAQgqX1+pIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pwc5yMAu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pwc5yMAu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mzt+2bXJYcRgYV5+nFdzTfFzH5NJ08dyQfJICccEyiE=; b=pwc5yMAuAGWok6Ejw8VCUOFVZP
	jDGd3te4Md5OSAVZpmAT0T8WxJSofpb+g2CupFYzQPIPzcMlMN2qmH5j/CePmhyLPRGoxaFAEHeGn
	yhZLqhfsUeghiS8fK31ASzqmutYOmgSlzKWm9l4uOkC+sXaXbCKdriXWAhQ/GGWyqt1OxCbzadsWT
	NCt61uvagH0yx/vIjdVEEkfvas7wh9CnrJACD3crkougUC24CxeQEjNE1fHWuKYZam4AEM4Pbezm/
	kZijw3T+1caTGdLwFIqhGPJNUPRWEgPA3jszT7rh7QLdtJ6I7pIp+ssVXJ0XDsV49Xcn+THVRkdF3
	+qoTSlAg==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKz0a-00000003f2T-2Swo;
	Thu, 07 May 2026 13:43:21 +0000
Message-ID: <e082f19aecf2d2acd30782ea9220aedac3d3f990.camel@infradead.org>
Subject: Re: [PATCH] KVM: x86/xen: bail in IRQ context on PREEMPT_RT in
 kvm_xen_set_evtchn_fast()
From: David Woodhouse <dwmw2@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mauricio Faria de Oliveira <mfo@igalia.com>, Paul Durrant
 <paul@xen.org>,  Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,  kernel-dev@igalia.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-rt-devel@lists.linux.dev, 
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Date: Thu, 07 May 2026 14:43:20 +0100
In-Reply-To: <20260507132115.w1nOBvlS@linutronix.de>
References: <20260506-xen-rt-sleep-v1-1-53b6b60a671d@igalia.com>
	 <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>
	 <20260507071235.rdb4aGeE@linutronix.de>
	 <f0f447dea6c8f2deb7f153f745add15d3ecadd19.camel@infradead.org>
	 <20260507132115.w1nOBvlS@linutronix.de>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-UKAELhCR8fiUKJc+NKYG"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-UKAELhCR8fiUKJc+NKYG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-07 at 15:21 +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-07 14:00:49 [+0100], David Woodhouse wrote:
> > On Thu, 2026-05-07 at 09:12 +0200, Sebastian Andrzej Siewior wrote:
> > >=20
> > > So the cited patch does not look bad. That read-trylock should be fin=
e
> > > on RT (as in I don't see anything wrong with it). What did happen to =
it?
> >=20
> > The read_trylock() may be fine... but does a read_unlock() try to
> > "re-enable" hardirqs?
>=20
> Yes, I missed it while looking for it. This could become a _irqsave().
>=20
> We do this already for spinlock_t/ rt_spin_lock()/ _unlock() because it
> is used during early boot where interrupts are disabled and locks are
> acquired. So it needs to preserve the state and since rwlock_t is not
> (yet) used during early boot it was not done/ observed.
>=20
> The try-lock on the read lock just increments a counter in order to
> acquire the lock. This is it. The spinlock_t on the other hand records
> the current context as owner which can lead to a mess. Therefore a
> trylock on a spinlock_t from hardirq context is wrong but it should be
> doable for rwlock_t. I don't see anything wrong with it (except for this
> one thing can be corrected).

Thanks. Something like this?

=46rom 7199173d543d25333418537bcf07d6b2fce18ff1 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Thu, 7 May 2026 14:39:22 +0100
Subject: [PATCH] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()

__rwbase_read_unlock() uses raw_spin_lock_irq()/raw_spin_unlock_irq()
which unconditionally disables and re-enables interrupts. When
read_unlock() is called from hardirq context (e.g. after a successful
read_trylock() in a timer callback), the raw_spin_unlock_irq()
incorrectly re-enables interrupts within the hardirq handler.

This causes lockdep warnings ('hardirqs_on_prepare' from hardirq
context) and can lead to IRQ state corruption.

Switch to raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() to
preserve the caller's IRQ state, matching the pattern already used
for rt_spin_lock/unlock.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 kernel/locking/rwbase_rt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 82e078c0665a..25744862d627 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -153,8 +153,9 @@ static void __sched __rwbase_read_unlock(struct rwbase_=
rt *rwb,
 	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
 	struct task_struct *owner;
 	DEFINE_RT_WAKE_Q(wqh);
+	unsigned long flags;
=20
-	raw_spin_lock_irq(&rtm->wait_lock);
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 	/*
 	 * Wake the writer, i.e. the rtmutex owner. It might release the
 	 * rtmutex concurrently in the fast path (due to a signal), but to
@@ -167,7 +168,7 @@ static void __sched __rwbase_read_unlock(struct rwbase_=
rt *rwb,
=20
 	/* Pairs with the preempt_enable in rt_mutex_wake_up_q() */
 	preempt_disable();
-	raw_spin_unlock_irq(&rtm->wait_lock);
+	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 	rt_mutex_wake_up_q(&wqh);
 }
=20
--=20
2.43.0



--=-UKAELhCR8fiUKJc+NKYG
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUwNzEzNDMy
MFowLwYJKoZIhvcNAQkEMSIEIJKwkAazIv77MjmfsvjHLIEbQMQBcvcPNr/ahkZ+qh0dMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIANhAOnuHBM61L
GqYZP7WH02+pAgEgRdnVSlx/p5YOJ/Su/M1ynA84z/sL9A4kwnsa/SjiWlPcwP0n2oO631FqqZoc
wA96YPt4Xj/lEau6pQRFGarw5Q6SSIfmp1FlpxdClbCjbx1AB6s0f4yv4hsRl/LMiYcKNj0TQarT
LqoVqMjhucvyTZ3yyAj42FcoSrTmrviwWteGctS6e7j5cptMccFZO/kMD8+vPEPmy5Blp9TORjyl
fNH3D+IQZZxE1m1eZ6bQmcEO6oKVkSc3Jbo1Tpcut9bjHYycSBxsugc/IehlGJTx62DYVyNXvI29
ydO9D6spp1P/3Cflovb8Qrg1VKf3WY0uQxXKKdLBwdUT7iahnoM2o3xWUsUvB9MDd7JSDmbVzhzR
OJLD/XwCRDpS+8AIimtL54VJZSh4iOaODKCAeLxVpRCEHSlRW4FkgOgn3wl1eCGsmHsbHbDMrdXy
M5wb2f0jfMM58sUFLUnHjJuSa4F/5ebh/+M8dbX/lrtgzxoSdT1hXjPENc4j01bMxiQt0jwYrwpQ
Hp05wCfWLLcht+k7RaYziwCt2tsmRHxG6krmgixF1k+nxDiHLlVsk0PyuEYEi01dn3SHZKp3sRGe
5e7rpFRMqFalrH3YdFIvjZOnMU8u6AW6H3RrYEPQChjIqfX0DEfXLHEq6raYqZ4AAAAAAAA=


--=-UKAELhCR8fiUKJc+NKYG--
