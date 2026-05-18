Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4949659;
	Mon, 18 May 2026 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094147; cv=none; b=d76sA2Sq1afdCuyJztGd9DnqLmp4HeUalDzwIYcyu3ffaCKZFWXteit4yvWTwjxf3DPkh8Jq1SA4RmAForchCj8D4/46KoKj22qJGzP+1Ap34XUiFKDEl4ObdIj6PU49MyICgBT3OhpvaQuSIPI0UVKKBI2ZjzSj4RJPDXmtp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094147; c=relaxed/simple;
	bh=YOr8SpsPMBANbgfzFo+ah52+xTNRDli15C2M+cHMFFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PI3R8puHd8EomX4DeAOTFvN2RFoKyydczHGvD9Z0DLOBQ9l0u3y2i3jKYMaf0Nb/EX/Ke0h+r4uBjxOIDwdJV2BmZzg6fyZ9fg7UlCriqGCQg+I74eJVCETCzPtG2gw/hkyXRO5uo8+IqQzvHVRG4bbk+XqbjSsotUosyXomuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OKRaAom1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OKRaAom1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g1+eVz8k9W+ci4EcKfxUg7T4Q5pV1mWJW3UUNSLBkTE=; b=OKRaAom10YDl6l9nhetetvzXGk
	UAyRyLCYa3RV3coaFntWB6FvzbaNUq1VEr+HMIEHITv0/ixgYmORJn2Vm/ONJYtS0cidesb6jsqGT
	O7d4+9ujI7VaRzqQsARrrr7B/q5PiZ2D+5kUP4Evay4MKItS+WQaqM4o+jZtzT/w0x9HErlzQY6V2
	z1uE/nSsmPdEpg58I1CY4+4l/LoomUOEUv+q0+P1wmUdk8jSq8dUAfg2VFG0IwDOl1e4DcUEh7Zco
	IQAnQTe2UcariMDSpLtgiI9Ujf2z9ctjsQzxo9LYWq8mcETml5cKdgrf8cQ61ZoOia4KpKkH9Pimj
	uqHORrgg==;
Received: from 54-240-197-233.amazon.com ([54.240.197.233] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtej-00000004XhK-32Yc;
	Mon, 18 May 2026 08:48:57 +0000
Message-ID: <d3c461415e05345a9b82e6f995828c1ae64a4e61.camel@infradead.org>
Subject: Re: [PATCH v4 04/30] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
From: David Woodhouse <dwmw2@infradead.org>
To: Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  x86@kernel.org, Marc Zyngier <maz@kernel.org>,
 Juergen Gross <jgross@suse.com>,  Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, Jonathan Cameron
 <jic23@kernel.org>,  Sascha Bischoff <Sascha.Bischoff@arm.com>, Jack
 Allister <jalliste@amazon.com>, Joey Gouly <joey.gouly@arm.com>, 
 joe.jin@oracle.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  xen-devel@lists.xenproject.org,
 linux-kselftest@vger.kernel.org
Date: Mon, 18 May 2026 09:48:56 +0100
In-Reply-To: <0ae8e471-db7a-4842-aca4-8ef643acde8b@oracle.com>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
	 <20260509224824.3264567-5-dwmw2@infradead.org>
	 <0ae8e471-db7a-4842-aca4-8ef643acde8b@oracle.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-PC39DHWiBkFfVKw6GO8r"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-PC39DHWiBkFfVKw6GO8r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-18 at 00:52 -0700, Dongli Zhang wrote:
> On 5/9/26 3:46 PM, David Woodhouse wrote:

Huh, I didn't write that then; it isn't September yet. Did you mean
2026-05-09? We aren't all in the US...=20

Strictly speaking, you just misattributed a quote of mine, which is
very poor form :)

What mailer are you using? Can it be fixed?

> > From: Jack Allister <jalliste@amazon.com>
> >=20
> > Where kvm->arch.use_master_clock is false (because the host TSC is
> > unreliable, or the guest TSCs are configured strangely), the KVM clock
> > is *not* defined as a function of the guest TSC so KVM_GET_CLOCK_GUEST
> > returns an error. In this case, as documented, userspace shall use the
> > legacy KVM_GET_CLOCK ioctl. The loss of precision is acceptable in this
>=20
> The description here confused me a little. It sounds like userspace shoul=
d call
> KVM_SET_CLOCK if KVM_SET_CLOCK_GUEST fails. However, I assume it actually=
 means
> that userspace should do nothing extra if KVM_SET_CLOCK_GUEST fails, and =
simply
> rely on the prior KVM_SET_CLOCK and KVM_VCPU_TSC_OFFSET workflow describe=
d in
> patch 07. Is that correct?

Yes. If KVM_SET_CLOCK_GUEST doesn't work (which might be because
KVM_GET_CLOCK_GUEST didn't work so userspace doesn't have the data in
the first place, or because the actual ioctl returns failure), then
userspace should rely on the old method using KVM_SET_CLOCK imprecisely
instead. That includes on a migration from an older kernel that *lacks*
KVM_GET_CLOCK_GUEST, of course.

I don't think it strictly matters whether userspace does KVM_SET_CLOCK
first, then *tries* KVM_SET_CLOCK_GUEST, or whether it tries
KVM_SET_CLOCK_GUEST and then only calls KVM_SET_CLOCK on failure? I'd
probably be inclined not to use KVM_SET_CLOCK at all unless it is known
to be needed?

> > +4.145 KVM_GET_CLOCK_GUEST
> > +----------------------------
> > +
> > +:Capability: none
> > +:Architectures: x86_64
> > +:Type: vcpu ioctl
> > +:Parameters: struct pvclock_vcpu_time_info (out)
> > +:Returns: 0 on success, <0 on error
> > +
> > +Retrieves the current time information structure used for KVM/PV clock=
s,
> > +in precisely the form advertised to the guest vCPU, which gives parame=
ters
> > +for a direct conversion from a guest TSC value to nanoseconds.
> > +
> > +When the KVM clock is not in "master clock" mode, for example because =
the
> > +host TSC is unreliable or the guest TSCs are oddly configured, the KVM=
 clock
> > +is actually defined by the host CLOCK_MONOTONIC_RAW instead of the gue=
st TSC.
> > +In this case, the KVM_GET_CLOCK_GUEST ioctl returns -EINVAL.
> > +
> > +4.146 KVM_SET_CLOCK_GUEST
> > +----------------------------
> > +
> > +:Capability: none
>=20
> Do we need a KVM_CHECK_EXTENSION capability for this? If userspace wants =
to
> support the new API, should it detect availability via KVM_CHECK_EXTENSIO=
N, or
> simply try the ioctl and handle failure?

That might be conventional, I suppose. But I suspect Jack's thinking
was that userspace is going to have to *try* it anyway, and still might
have to fall back to what KVM_SET_CLOCK can manage, so userspace
probably wouldn't even bother to check that capability; it doesn't
matter.

Since then, we've added some more attributes in this series though, and
it probably is worth adding a cap which advertises them *all*?
Something like KVM_CAP_CLOCK_PRECISION_API?

> > +#ifdef CONFIG_X86_64
> > +static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __u=
ser *argp)
> > +{
> > +	struct pvclock_vcpu_time_info hv_clock =3D {};
> > +	struct kvm_vcpu_arch *vcpu =3D &v->arch;
> > +	struct kvm_arch *ka =3D &v->kvm->arch;
> > +	unsigned int seq;
> > +
> > +	/*
> > +	 * If KVM_REQ_CLOCK_UPDATE is already pending, or if the pvclock
> > +	 * has never been generated at all, call kvm_guest_time_update().
> > +	 */
> > +	if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, v) || !vcpu->hw_tsc_hz) {
>=20
> This was flagged by AI, and I am still checking whether it is a real issu=
e.
>=20
> What happens if KVM_REQ_MASTERCLOCK_UPDATE and KVM_REQ_CLOCK_UPDATE are b=
oth
> pending?
>=20
> From my perspective, I am also curious how we should reason about this in=
 other
> scenarios in the future. Specifically, when do we need to process
> KVM_REQ_MASTERCLOCK_UPDATE before KVM_REQ_CLOCK_UPDATE, and when is it
> acceptable not to? I noticed that kvm_cpuid() already processes only
> KVM_REQ_CLOCK_UPDATE.

The way I've been thinking about it =E2=80=94 and I'm only two cups of coff=
ee
into Monday so take those words literally and don't think of them as
British understatement of something I believe is absolute truth =E2=80=94 i=
s
that MASTERCLOCK_UPDATE is updating the actual clock for the whole VM,
while CLOCK_UPDATE is about *putting* that information into the per-
vCPU pvclock structures.

So after a MASTERCLOCK_UPDATE, we need to do a CLOCK_UPDATE on all
vCPUs to disseminate the result. Which means that if CLOCK_UPDATE is
already pending before a MASTERCLOCK_UPDATE, it's probably redundant
and might as well be cleared because it's only going to get set *again*
in kvm_end_pvclock_update()?=20


> > +	/*
> > +	 * Calculate the guest TSC at the new reference point, and the
> > +	 * corresponding KVM clock value according to user_hv_clock.
> > +	 * Adjust kvmclock_offset so both definitions agree.
> > +	 */
> > +	guest_tsc =3D kvm_read_l1_tsc(v, ka->master_cycle_now);
> > +	user_clk_ns =3D __pvclock_read_cycles(&user_hv_clock, guest_tsc);
> > +	ka->kvmclock_offset =3D user_clk_ns - ka->master_kernel_ns;
>=20
> I used to explore adjusting ka->kvmclock_offset in KVM_SET_CLOCK based on=
 the
> old hv_clock and the new hv_clock long time ago. At that time, my concern=
 was
> what would happen if userspace provided bogus values. Theoretically, this=
 is
> possible with any ioctl. My concern may be unnecessary.
>=20
> Would it be helpful to validate that the delta is within a reasonable ran=
ge,
> e.g. that the drift can never be more than five minutes (forward or backw=
ard)?

Setting confidential guests aside, which have their own way of trusting
the TSC and should never even *consider* using kvmclock, surely this is
supposed to be *entirely* under the control of the VMM? The kernel has
no business deciding what is 'bogus'?

If a guest has been running for months on a previous host and is
migrated to a new host, don't we expect that the KVM clock of the new
VM on the new host is tweaked from its default near-zero after
creation, to some large amount?


--=-PC39DHWiBkFfVKw6GO8r
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxODA4NDg1
NlowLwYJKoZIhvcNAQkEMSIEIB6QrOyGWiQGu0gwZYzVi/UTjfzXQXvYkSLfXocOC1k8MGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAIuYCC1JFBO6F
VHKhI3jauVlAXJD+QyZevE+gU11/CtMaOJuOhulaIJc3fm0A+R6vDht0Dp2Uoa3v04q2q0TGHl+c
AwHsgX1aSCib7RJoPvNeDyGIrByYl4jVMV7CKXSHs/eoHPUHRzQZqQsW3PqHE9n2kZGUCDGjtvJf
UnKt51y9uQQEFt4O3UlxMJmFFzY6Ah+02IMor6xamxxgHrE6jyIO9oLzfnArXbgtY42iIyJFzC/w
bu80URv0TgJvttgg8bz7NDSrlYX9rzkvtgDGsGghP7NjwtgCueOVcwb3GP2KVt6M+lXwL6hgb5Py
jmNMkUhE1tWm/N9WSUgllnEVA/buC8pKKnFFr+4w+0CJFNkf2qvqnMMkv+fYLiUBvkcC2SzbrvCn
7e8J/bbhLB0+ull6V0FYWDbMEha3rBLiya8OcpTUBCVPBZ20l19kp+UnwMUo2gr5jlkGDfFvHtQW
N9h0xFlpCmYsB8IPEIG4oZCu9bBXDq8a0cGKydqIQV1xsAlXRKkYE4CBjFIdA2PU42i2zkI7ZcqA
qM7htyE7mK/b4o/i6u5T0jLKYsVFo5dO+v6pAs9JwWqRcGlg0W/hpsquU5eijb4GTZ4z6An7UDSd
hs2Frd9KxzpOWIm9zUvO0sODrHipNx2gqvmef7eghUx7/DGNIPiwc2AKXLD55t0AAAAAAAA=


--=-PC39DHWiBkFfVKw6GO8r--
