Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0244102B;
	Tue, 28 Apr 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388082; cv=none; b=IeWpg0IwGszpXY2C7lohPxxRXp9zZqTzGBpqBFnCmhwTd9w1zh/4SCEr3ppPuAb03JAJKUnVL5qEm/syZdYMktXRobtWek7gSkuVGgD8DMPr9Cs/U0Cjo2HrN+HgeMv5W9I4ZN+wAhzdlnO+5vBtEA3Uxily5hD1RUXTxl+Rilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388082; c=relaxed/simple;
	bh=qcw1/DuQoLk7cCrzWZwg5WEvXeuuf2AKc5s4H51c4WQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N3uwHvK/gtFFk71KeZdFbUEC/QSHYnBBvLuqJILe+++Fs0PfgZhzjKnNV0Ta+OpLJyw5OJtWDsKnBrxA1wv0OVXm6NouBxhacIcbYQB2O+92BE+q/jJLq7tiG2NqHE5P/fa4oVrvsM+8KFebhkw3Ur/xoDe5Y8GvR+PGipo4/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E8W3mchc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E8W3mchc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qcw1/DuQoLk7cCrzWZwg5WEvXeuuf2AKc5s4H51c4WQ=; b=E8W3mchcRcObh60YgYvSPRT/bF
	6ySkQ4yfhyJlr0ID+dUEmQOU73FGTeicIyAkpLZWhfL6HTSjJtbXVxuNaOJeaPLKokUUI6Nw/z0df
	PcnC3y0wkWoWKFY3c8fx+9au1tuxG+Pl+KMpEHFFeeGlyVzoUsMIPe9rKPd5mCsD+8TPPeklDCPaN
	bv/KKrFa8bqU6PTMk3GFpn4woveONVxllognHWHSPh9yTCYPgwgGmIC1Yf7svLNJe6umluyQn8Utq
	H1HV8aiZJqQ1QVRGCegb5BFQXJ2lEp59EDfHTSGAlU9MnBZx5EDnPvEG2WtnQjM/w40g6T6t9fZWK
	aeoh96rQ==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHjpZ-00000003Oar-1p7O;
	Tue, 28 Apr 2026 14:54:34 +0000
Message-ID: <d771dee8cf01a914a90da54bae90eb1ade020d5c.camel@infradead.org>
Subject: Re: [PATCH 1/5] KVM: x86/xen: Restrict hypercall MSR to unofficial
 synthetic range
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+cdeaeec70992eca2d920@syzkaller.appspotmail.com, Joao Martins
	 <joao.m.martins@oracle.com>
Date: Tue, 28 Apr 2026 15:54:33 +0100
In-Reply-To: <cd3fb8dd79d7766f383748ec472de3943021eb39.camel@infradead.org>
References: <20250201011400.669483-1-seanjc@google.com>
	 <20250201011400.669483-2-seanjc@google.com>
	 <43f702b383fb99d435f2cdb8ef35cc1449fe6c23.camel@infradead.org>
	 <Z6N-kn1-p6nIWHeP@google.com>
	 <cd3fb8dd79d7766f383748ec472de3943021eb39.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-3m+frVvsqM/hG5Lc+xiv"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-3m+frVvsqM/hG5Lc+xiv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-02-05 at 15:26 +0000, David Woodhouse wrote:
>=20
> > > @@ -3733,7 +3733,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 msr =3D msr_info->inde=
x;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 data =3D msr_info->dat=
a;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (msr && msr =3D=3D vcpu->kvm=
->arch.xen_hvm_config.msr)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Do not allow host-initi=
ated writes to trigger the Xen hypercall
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * page setup; it could in=
cur locking paths which are not expected
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if userspace sets the M=
SR in an unusual location.
> >=20
> > That's just as likely to break userspace.=C2=A0 Doing a save/restore on=
 the MSR doesn't
> > make a whole lot of sense since it's effectively a "command" MSR, but I=
MO it's not
> > any less likely than userspace putting the MSR index outside of the syn=
thetic range.
>=20
> Save/restore on the MSR makes no sense. It's a write-only MSR; writing
> to it has no effect *other* than populating the target page. In KVM we
> don't implement reading from it at all; I don't think Xen does either?
>=20
> And even if it was readable and would rather pointlessly return the
> last value written to it, save/restore arguably shouldn't actually
> trigger the guest memory to be overwritten again. The hypercall page
> should only be populated when the *guest* writes the MSR.
>=20
> With the recent elimination of the hypercall page from Linux Xen
> guests, we've suggested that Linux should still set up the hypercall
> page early (as it *does* have the side-effect of letting Xen know that
> the guest is 64-bit). And then just free the page without ever using
> it. We absolutely would not want a save/restore to scribble on that
> page again.
>=20
> I'm absolutely not worried about breaking userspace with such a change
> to make the hypercall page MSR only work when !host_initiated. In fact
> I think it's probably the right thing to do *anyway*.
>=20
> If userspace wants to write to guest memory, it can do that anyway; it
> doesn't need to ask the *kernel* to do it.

In the meantime, our VMM actually did start to intercept the MSR write
and then 'replay' it to the kernel with ->host_initiated.

It does so because the MSR writes correlate with kexec/crash in the
guest, and tracking that allows the VMM to deal with resetting e.g. the
blkback/netback rings in order that the crash kernel can actually
complete the crashdump.

I pondered reverting commit 3617c0ee7dec but I do still think it makes
sense for all the reasons we originally discussed. I pondered making
VMM do everything for itself which kvm_xen_write_hypercall_page() does,
but that's a bit icky.

Settled for adding a KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE attribute
which basically does the same operation directly, instead of triggering
it through an MSR write. Patch incoming.





--=-3m+frVvsqM/hG5Lc+xiv
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQyODE0NTQz
M1owLwYJKoZIhvcNAQkEMSIEIEKY82bg4/e9H8/steghtyM6U1mIi17e5pwmKE8FlvsPMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAzl2drtU2612u
666MKMu9wNztd9+UjpC65+OnX/PiHrCS//y4iYhrFq9VqMDf6OToO+Ph0hXedN6G8O/SQY3RLLLg
XHUK/40nG3jpS+zSBcYhoDpaAvSMFi23cOTVRjqebLZyxXWy4/6RUepvKSYMhHwiMLmUm7riBgsK
BvyeXJjVwu+83zQHoXlxRxAklim7kXxiECVRAezFEzIpNxhuO+A+ilXZrsmcWfglKBsfQuRhj1HP
FtGb9HjU5FlkGXuGdsASM7nVggTvrThCeSHbbqZhjo73/4+Ygjz+PJ/6fD4BDf73mRlJ2OMmLqXo
1Vj51PJb15o+M3Dxpx56a2qdA+EryiBLJBbgZP7511jSs+e/UnB2YTg0kfPCzdOchww6/X6PsAwv
vUHYCYcW13or9MlVsbGszAwpxq3vteIuqpqtNmhg+nA1S499g5EFSGLGTjrnF/ti2FKIMBgIIAiB
PSXGdtr3s3/kLyPg3+wxuD6CVF1wdCeJz19OhXCF/EtSVRyE3MyK+IwuMVnBCPzQjWO2LLnEHzxv
iblQBkSXyL2MSdV6Y9i6UfzRN1nR9uDuuXHNVsSwKFvrdZL561Zv3HFmySIy944Qg4fXcDZsB9Tn
1Z466ReO63viEJhmTUEyCv61rxQrSszN0zTbXc5KeCMPVUgF+fhxZ1MTc2DFEw8AAAAAAAA=


--=-3m+frVvsqM/hG5Lc+xiv--
