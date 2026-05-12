Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620528C2A1;
	Tue, 12 May 2026 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570392; cv=none; b=Qulri0MndqqXloSaXzGC6wIEplmsKkUAgsAGAPovGA3zhV5s4AcIt22OboZ0Mn+AhyocyWiQEmIh9w2XpdK8+KGb8KY/V0WUijeKTqqk9eghKIztUq96dV1LgApmFOqWEuaUR9wbBSLdhDsW6TH3HwizMgPUW2EA/TuGMlZLCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570392; c=relaxed/simple;
	bh=wXZeqiM6Z1TbiTyk/nGA1XS+9uz1jIEUwLky+cTGv6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iSgePgwkxlqO+VrMqizM7xcRI/U+rUEkPY/MF9mORtWavsKswuPsyrRujfbd0qFbvzs4ygmzFza5ohpr72az04B4V+bVv63yZlBlu05McoV8u4ftslLEILf9HDuX7n9d4sUy+J1+ZpmNQw4aYf1rAltaUUJoQc0Oj1PmXZA1izQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OsI0EDnC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OsI0EDnC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XbiblmVv2C1yyit7uRTwkkPYjfSmMffWSysQctajfik=; b=OsI0EDnC81ERAS5wcN5ex7qRw1
	QbJS2A2KZPBQgeY4GG50Vi7v/vXVpZfHNiZI9yEmxAYX5cBF8IZvPUHUNcHemdrmFUcxaXJ7HPQX3
	7ZLXef9Ux2YybPWg5IN7NX1wfuouNOZzjNVQ3WxIBOx0QiXaZxfTSv/O07OShV4aW81yrm0lItwTN
	K80Eli/Hx3V/BJaCTd9OWlYOYc3fyy3wSf27LsCZ9oReId8IGDaSIWZFRDmZC8BHNsTKScTCrKVqq
	mxhvYE2XXYZqLjvYDO2fY75iFQtGXLJ/sYtretOSzB9Xf7z1JUHHwNYxmp07PTUh/7YsqBsawO8Cx
	P4V16Wvg==;
Received: from 54-240-197-236.amazon.com ([54.240.197.236] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMhP2-00000009M1n-3lJl;
	Tue, 12 May 2026 07:19:41 +0000
Message-ID: <a1ab80b4fb24677e1007f3be411e2954e88a36cf.camel@infradead.org>
Subject: Re: [PATCH 2/3] KVM: x86: conditionally clear
 KVM_REQ_MASTERCLOCK_UPDATE at the end of KVM_SET_CLOCK
From: David Woodhouse <dwmw2@infradead.org>
To: Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, paul@xen.org, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org,  hpa@zytor.com, linux-kernel@vger.kernel.org,
 joe.jin@oracle.com
Date: Tue, 12 May 2026 08:19:39 +0100
In-Reply-To: <3363ed64-75f9-4a5c-93b9-882d72bfb7f2@oracle.com>
References: <20260115202256.119820-1-dongli.zhang@oracle.com>
	 <20260115202256.119820-3-dongli.zhang@oracle.com>
	 <f37f0ae0ae1dfce3ad3c6fce653f5df34adecc0a.camel@infradead.org>
	 <3363ed64-75f9-4a5c-93b9-882d72bfb7f2@oracle.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-Gh3fBTu6fLXPt5fN2Il3"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-Gh3fBTu6fLXPt5fN2Il3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-11 at 17:21 -0700, Dongli Zhang wrote:
>=20
>=20
> On 5/9/26 1:04 PM, David Woodhouse wrote:
> > On Thu, 2026-01-15 at 12:22 -0800, Dongli Zhang wrote:
> > > The KVM_SET_CLOCK command calls pvclock_update_vm_gtod_copy() to upda=
te the
> > > masterclock data.
> > >=20
> > > Many vCPUs may already have KVM_REQ_MASTERCLOCK_UPDATE pending before
> > > KVM_SET_CLOCK is invoked. If pvclock_update_vm_gtod_copy() decides to=
 use
> > > the masterclock, there is no need to update the masterclock multiple =
times
> > > afterward. As noted in commit c52ffadc65e2 ("KVM: x86: Don't unnecess=
arily
> > > force masterclock update on vCPU hotplug"), each unnecessary
> > > KVM_REQ_MASTERCLOCK_UPDATE can cause the kvm-clock time to jump.
> > >=20
> > > Therefore, clear KVM_REQ_MASTERCLOCK_UPDATE for each vCPU at the end =
of
> > > KVM_SET_CLOCK when the master clock is active. The 'tsc_write_lock' e=
nsures
> > > that only requests issued before KVM_SET_CLOCK are cleared.
> >=20
> > Hm, I think we should do this in kvm_make_mclock_inprogress_request()
> > instead.
> >=20
> > Currently, things like pvclock_gtod_update_fn() and one or two others
> > set KVM_REQ_MASTERCLOCK_UPDATE for all vCPUs. Not just one, because we
> > don't want *any* vCPU going back into guest mode before doing the work.
> >=20
> > So they could *all* end up calling into kvm_masterclock_update() at the
> > same time. I have a vague recollection there was once a mutex there,
> > but now there isn't.
> >=20
> > So all vCPUs can each, in parallel, set KVM_REQ_MCLOCK_INPROGRESS on
> > all other vCPUs. That's an unhandled request which just makes a vCPU
> > spin (preventing it from entering the guest until the clock update
> > completes).
> >=20
> > Then each vCPU tries to take the kvm->arch.tsc_write_lock in
> > kvm_start_pvclock_update(), and from this point they'll be
> > serialized... but every vCPU will go through the whole of
> > pvclock_update_vm_gtod_copy() for itself, updating the masterclock one
> > more time for each vCPU in the system?
> >=20
> > I came here to say that kvm_make_mclock_inprogress_request() should
> > probably clear KVM_REQ_MASTERCLOCK_UPDATE on all other vCPUs, since
> > it's about to do the work, and the other vCPUs will no longer need to.
> >=20
> > But... it's more broken than that now.=20
> >=20
> > I think maybe vcpu_enter_guest() should call kvm_update_masterclock()
> > if *kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE)* (i.e. not *clear* the
> > bit by using kvm_check_request()).
> >=20
> > And then after getting ->arch.tsc_write_lock,
> > kvm_start_pvclock_update() should check if KVM_REQ_MASTERCLOCK_UPDATE
> > is *still* set, and only proceed with the update if it is?
> >=20
> > I'll play with it some more... something like this perhaps?
> >=20
> > From 91e37d74ee267c722bc2c8f26754fcdfbc040e29 Mon Sep 17 00:00:00 2001
> > From: David Woodhouse <dwmw@amazon.co.uk>
> > Date: Sat, 9 May 2026 16:54:01 +0100
> > Subject: [PATCH] KVM: x86: Avoid redundant masterclock updates from mul=
tiple
> > =C2=A0vCPUs
> >=20
> > When a masterclock update is triggered (e.g. by the clocksource change
> > notifier), KVM_REQ_MASTERCLOCK_UPDATE is set on all vCPUs. Without this
> > fix, each vCPU independently processes the request and redundantly
> > re-executes the entire pvclock_update_vm_gtod_copy() sequence, serializ=
ed
> > only by tsc_write_lock. Each redundant re-snapshot of the master clock
> > reference point introduces potential clock drift.
> >=20
> > Fix this by having __kvm_start_pvclock_update() check, after acquiring
> > the lock, whether the requesting vCPU's KVM_REQ_MASTERCLOCK_UPDATE is
> > still set. If another vCPU already did the update and cleared it, bail
> > out. Otherwise, clear the request on all other vCPUs before proceeding.
> >=20
> > The caller in vcpu_enter_guest() now uses kvm_test_request() (non-clear=
ing)
> > since the clearing is done inside __kvm_start_pvclock_update() under th=
e
> > lock.
> >=20
> > Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>=20
>=20
> Thank you very much! Feel free to add me as Suggested-by or Reported-by.

Already did!

> I will also help test your large patch series.

Thanks.

> Regarding the issue, I would like to confirm whether there can still be a=
ny
> KVM_REQ_MASTERCLOCK_UPDATE after KVM_SET_CLOCK_GUEST.
>=20
> Per my understanding, I would expect KVM_SET_CLOCK_GUEST to be the last p=
oint
> where the masterclock can be updated (during live migration or live updat=
e).
>=20
> After KVM_SET_CLOCK_GUEST, any further masterclock change may cause kvm-c=
lock drift.

I believe that for a guest with ->use_master_clock, there should be no
further masterclock change once it's running. We trigger
KVM_REQ_MASTER_CLOCK update only in exceptional cases:=20

 =E2=80=A2 kvm_set_guest_paused() =E2=80=94 vCPU 0 writes kvmclock MSR swit=
ching
   between old/new MSR (boot_vcpu_runs_old_kvmclock changes)

 =E2=80=A2 kvm_track_tsc_matching() =E2=80=94 TSC matching state changes: e=
ither a new
   TSC generation starts, or master clock needs to be toggled on/off

 =E2=80=A2 pvclock_gtod_notify() via irq_work =E2=80=94 host clocksource st=
ops being
   TSC-based (e.g., TSC marked unstable, clocksource switched to HPET)

 =E2=80=A2 kvm_arch_hardware_enable() =E2=80=94 host TSC went backwards dur=
ing CPU
   online (suspend/resume, CPU hotplug) setting backwards_tsc_observed

IIRC the timekeeping code does call pvclock_gtod_notify *all* the time
even when the clock rate is stable and NTP isn't applying any skew,
because a cycle rate of e.g. 333333=E2=85=93 cycles per tick will result in=
 it
counting 333333, 333333, then 333334 cycles in consecutive ticks. And
calling all the notifiers whenever it flips between 333333 and 333334.
But KVM only updates the master clock if it becomes non-TSC-based, so
it doesn't hurt.

--=-Gh3fBTu6fLXPt5fN2Il3
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxMjA3MTkz
OVowLwYJKoZIhvcNAQkEMSIEIIHkGH2Wdt279n1jTI0mB73NzeLTQm71+VjSgcn7Lm/lMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAEJvVCduSHXv3
FeZzZtNiJ+V4NE/EoOTsIFOb95R8/p8aEwBcPtfpLGzxVjcq2hn8F6wAfwzH0grI1IEUrnjBZ+ZA
JiQqXx7j+LhhVuGuwYcJV5w7/RCrYpCSMGTviVsHRZIpwuFOno9FFp+8OPOGllk/RQC/sBXvU0i8
NjfujdJu1dPYoLgovY759GaBv+IY1EJRBjXZSDbAMAXxljWwDdUK0ddQdvZW1yESbqp3L5wUi7s0
AAT0cGOXbzQX/d7bMKryhsTurNT06t9Zom+HNNdDeO2wzue18b18m5vy2Vc5argg5C16BBiLdMbg
ahvyEGuW4PHs/VFgtOy0egRLiST0rPoWmcgtILCxweo0cHgegV8epABDmwo44GoVwhpz1trGcsN2
zbHLcUC1yAHJNPxaOPnpoLBzs8snk8rRmWuKDk6kh1NAieV9Dr9Hovh/q1dzEB4+XiSiwYulAcCG
4ke7hz5+p5bWYetQn3WrNV/1wtUAgnUvN6V6/0KUaUEuYW9fukdTng4z7oofJ9RbU8PVIZoGJlJ7
vNupbJkhjAUkJC8krr+wKmnFlfPIYpGm/bBRc+YYeGpjE/PkrEcPog2x2mI+bBeOK59989MHZza9
Sv8aA/rW4Mg96pGFXnd47Oq0OSZVlz7AhvEZnSfInfWRMXwldZJO1mqG8mqdf2gAAAAAAAA=


--=-Gh3fBTu6fLXPt5fN2Il3--
