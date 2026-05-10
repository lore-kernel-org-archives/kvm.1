Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984402FC876;
	Sun, 10 May 2026 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444003; cv=none; b=a92WojnN3O5TTKlzwCo4DUQRhntJsU2I8ZpC/rmZbKmk1IY+cksHlApkp7mhSjXMMKVADdHJU8gBMntJQcFJDNs/+Z7G1siA1TebbU31SZJG5mvg3ni/Aar2hTADS3AgLmICoKPaK0/8JrOu19vTMa965kj8Fl/275cy3Rs3xSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444003; c=relaxed/simple;
	bh=uGnf+cZbQ/xULfqLaHtWJbjyE0PaFM1XhhydZbYHJRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+72kRDmto46Cuzg/BSpkzx195QcSsRw84JnKkqJH2ZK6SwFfdKXN1UBz9T8pGO6htmzMsvr1BIXoHkywi+RROADXsIIhsrzoFK9vVTsTQSqSYy4Dq9F+t31O1QB/KRkR3BLYZaj0x9xD0Q/3ac+7R2mz0p8MJjWoTYNW7gNsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P27427FS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P27427FS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=63TzbL95yIyUqYaOr0uSMC+eOizKawWIfYhjegmlkP0=; b=P27427FS4vjy2R9ErnUOomtuPB
	SIgcJl+yhn3CkuBAJD3pmdJ9+VORwVDMPrg2FEwnx6kVZDO5If+1EVo9aeGtleKScOwTsL5ttTmCe
	WwnupN13xeaz7GEKsxYqhFXjvzVtJjcy46JaYR3CEVmRkevk8E857sfHjHy12ZbjuQCvBEbBrVwqO
	PdB3MFLGLycp+Cb1iKqO9ME9D9MNG+JnnhKYcSPNQH/YXw+zDXYtKe6STRVAkVwU6qL2aIlE/51aM
	loC6Snk55a7cN3VfHlK7k4Bc9OtVBwdv3huj1hM7tgU6ZI3s99IdxlzP/jNTdgSLyyTZOAOKnDyqw
	d5SvwfRg==;
Received: from [172.31.31.240] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMAWW-0000000A8xE-0dBj;
	Sun, 10 May 2026 20:13:13 +0000
Message-ID: <87691b4969fa963b332b0be209361d6f206f493f.camel@infradead.org>
Subject: Re: [PATCH 3/5] KVM: x86: account KVM_SET_CLOCK downtime in steal
 time
From: David Woodhouse <dwmw2@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Dongli Zhang
 <dongli.zhang@oracle.com>,  kvm@vger.kernel.org, x86@kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
 tglx@kernel.org,  mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org,  peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, 
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de,  vschneid@redhat.com, kprateek.nayak@amd.com,
 jgross@suse.com, joe.jin@oracle.com
Date: Sun, 10 May 2026 21:13:12 +0100
In-Reply-To: <2C6E66BA-B225-41E7-A1F9-E6B2DAE0B392@zytor.com>
References: <20260505003044.78693-1-dongli.zhang@oracle.com>
	 <20260505003044.78693-4-dongli.zhang@oracle.com>
	 <09b261dafa3b50d358debe1fb13163703bc6e0a1.camel@infradead.org>
	 <2C6E66BA-B225-41E7-A1F9-E6B2DAE0B392@zytor.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-BT/0IeJ9WiHM4Yq+RtYQ"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-BT/0IeJ9WiHM4Yq+RtYQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-05-10 at 12:11 -0700, H. Peter Anvin wrote:
> On May 10, 2026 11:54:38 AM PDT, David Woodhouse <dwmw2@infradead.org> wr=
ote:
> > On Mon, 2026-05-04 at 17:30 -0700, Dongli Zhang wrote:
> > > The KVM_CLOCK_REALTIME has been introduced to help track the downtime=
 of
> > > live migration. KVM uses that realtime value to advance guest clock, =
but
> > > the same blackout is not reflected in KVM steal time.
> > >=20
> > > Account that same delta in steal time directly in kvm_vm_ioctl_set_cl=
ock(),
> > > only when KVM_CLOCK_REALTIME is used. This keeps the KVM-only solutio=
n
> > > self-contained and avoids adding a new KVM ioctl or requiring additio=
nal
> > > userspace changes (i.e. QEMU).
> > >=20
> > > Record the per-VM downtime delta when KVM_SET_CLOCK receives
> > > KVM_CLOCK_REALTIME, and fold it into the existing x86 steal accountin=
g
> > > path. Initialize each vCPU's local cursor
> > > (vcpu->arch.st.last_downtime_steal) when the guest enables
> > > MSR_KVM_STEAL_TIME so previously accumulated blackout is not charged.
> > >=20
> > > Note that this means a vCPU may observe additional steal time after
> > > blackout even if the host side contribution from current->sched_info
> > > did not increase during that interval.
> > >=20
> > > Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >=20
> > I really don't want to see KVM_CLOCK_REALTIME used for anything more
> > than it already is. Or, indeed, even for that.
> >=20
> > There is precisely *one* place where it's OK to use 'real time' as a
> > comparator, and that's when setting the guest's TSC. And even then it
> > should be using TAI not UTC unless you like your guests' clocks jumping
> > around by a second if you migrate at the wrong time. KVM_CLOCK_REALTIME
> > was never the right thing to use, for anything.
> >=20
> > The KVM clock is a function of the guest's TSC (see
> > KVM_SET_CLOCK_GUEST), and steal time is a function of that (as it's
> > measured in nanoseconds).
> >=20
> > Don't bring UTC into it *anywhere*.
> >=20
> >=20
>=20
> Unfortunately TAI is often unavailable. One can hope that the
> proposal of abolishing leap seconds by 2035, fixing the TAI-UTC
> offset permanently, actually happens.

I was hoping for the opposite; it's just pandering to stupid bugs.
Yes, leap seconds are fairly rare; instead maybe we should *always*
have a leap second in one direction or the other at the end of the
year. Otherwise it's just building up to be a bigger problem later.

>  The difference between atomic and solar time is better handled with
> the already-existing "time zones" mechanism, which tends to change
> far more frequently for entirely different reasons than the TAI-UT1
> difference slowly accumulates.

I have absolutely no faith in a 'time zones with second precision'
model ever actually working either. Although maybe if we ditched UTC
completely (and the pointless 37-second offset frozen in time for ever
like the GPS offset), and our second-precision time zones were based on
*TAI* we could exercise them from day one?

Either way, as long as it isn't the awful abomination of *smearing*
leap seconds and screwing up time precision, nobody actually needs to
be nailed to anything.

And none of it matters here for *steal time*, since the *only* thing in
a migration that should be based on any kind of real time is the guest
TSC, and everything else should be based purely on that (perhaps via
the kvmclock).

And even then it's only for live *migration* to a different host, as
live update on the same host across kexec should be purely based on
offsets from the host's TSC which remains unperturbed.

--=-BT/0IeJ9WiHM4Yq+RtYQ
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxMDIwMTMx
MlowLwYJKoZIhvcNAQkEMSIEIBxrpP5dXTAoTePTQcU7YUqM5yj4EUFSCeuGuYJub1MjMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAXwZJCI0N5rAn
JN0PLw75ryIIFfWZjC8mZ208PYdrahOafUet23vItf1taX9iLbON6/IriLC8GA9omE0Mt7ufRhA3
8bE5YzZ7fslxAON8IRXUktHUh02GJHm9RXka7m8EMTXKM0tEGKpM2XtjOdpExZJOcAAA06GD+fF8
FLvP4HAljvrG9N+QKnx3aw4FAtCeggQcYv8PbJqDQwRD/OupsGx/RFmm6BgvlQION/PvsJpR6ssz
QIqneAE+GcdxIxhHSFbRWXAtzW0RWKP7lFIFBcvYHF+ocXRSfrJxObc15BZeMN6skujs/j/r3XSt
1LxeBfHGgSuy98MftgW4Un4AtzhdaOu+NFwHnBrzPUycGx4Zh84AY5y9Gfa5y1oiD/jnSPJjAfyW
N6iE/kcSiwG09fWpnJd9zTcLy83RxL8rvePWt2k6NmxmuFTn3VRV3FF5y9vzqPzRwJu7poot+2tb
uSiZHvRkq7L1BI14yeGSLjxz4gne7W/9+9VaPV7xNJQBMK2ouKNdLo/rSJw93ET+jsx7561wzLLz
Wj92En76jw1V9oV5rJktbSX9s6wAEpZu6EtSap1qIs9sHUVeccGtbcO9aH17PvSQ47mQ/IL4TLIq
2HXZ+bTx1WLWiFnWXS7Y3to0iwtnawZaipjVAGB3Z6AAYoAZkn3JZfHoFSAtSoAAAAAAAAA=


--=-BT/0IeJ9WiHM4Yq+RtYQ--
