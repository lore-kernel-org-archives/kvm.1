Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6A362130;
	Fri, 26 Jun 2026 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459955; cv=none; b=Id8AQ3563UAK8aiX6MKBF7BRpDUkftH+BqUF8HvDtzHCcU5va08DwqjhvoQ4YWsc5CTJe+50PT7ieE31PHAhhC6hDCa/4xdTqaTyqEl9H0FkR+XAexf2fq4iwyKMJ2v9RVa90JVZ7effgv4NSnmSxbXUIplMUcXKo9r6eFlQ7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459955; c=relaxed/simple;
	bh=Rc8WwAfijhfhMypu6KPun19UMYrTGWdC38Tc4O9jGko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hQUJQ5uc74HkwWORB6ytwostcnVOa3mIkzICwEleszeFruKAx/8/ONUNo3y8soqZohOXO40MxuocFAeHclCj1eac+lj7whlmqTnnAp84kyrvYNJyGwOEY35vZWs5M7Rd3FX8hn1dGccnQS1QpZkWegGHqlzkeuvJw5Q0AyLnqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JZQ5ZYzV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZQ5ZYzV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TwvBdpBncCHdAk2VKNUDqd1awgXNOyMgwxy8ic1McgA=; b=JZQ5ZYzVGsqAwf2NN+oevFuyzN
	zGDOpTpQ3BZ+YH8yveLFfsFMZF9H3+QWU4sY3SBL4k63Apc0BUCT4XWFNkftFwkF9HwgsU3V1Gn0a
	azV5fRxS1GUEi+eE7zpvpofCcaZNEeP2/xP15VvpZ9vfuUjuR7xaGEhkCrL/b/oek8Q14l10B3w+p
	V8x6zCL8FdorO8CZgOKTc4mPDvTl4kWqGrj+IlcVF/avqPD85fI8zKQOdLzXuRQSULg/fMMUdPol2
	a7dYqTJ5iZGPOwo2Fue5Xy0bn64sAhPobgFEDZr4OUaX+gBrgg50xdj5mPSA9ssvjykQrmRdDhujE
	m+ATFP1Q==;
Received: from [2001:8b0:10b:5:f3d6:3c0c:6c61:8d10] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1Fk-0000000BRV1-1Gtv;
	Fri, 26 Jun 2026 07:45:32 +0000
Message-ID: <8edfdca645f691cb856e80ade830d78925fdc19d.camel@infradead.org>
Subject: Re: [PATCH] KVM: x86/xen: Add
 KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>, Gerd Hoffmann
 <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,  Borislav Petkov	 <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"	
 <hpa@zytor.com>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 26 Jun 2026 08:45:32 +0100
In-Reply-To: <aj21KctIXuf7b_5G@google.com>
References: <c855535b4262ecd41f67734d19e8f48a7f014c2a.camel@infradead.org>
	 <aj21KctIXuf7b_5G@google.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-Zgc7OAjbz0Hgd13lKrY1"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa6 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-Zgc7OAjbz0Hgd13lKrY1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-06-25 at 16:09 -0700, Sean Christopherson wrote:
> On Tue, Apr 28, 2026, David Woodhouse wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >=20
> > Commit 3617c0ee7decb ("KVM: x86/xen: Only write Xen hypercall page for
> > guest writes to MSR") blocked host-initiated writes from triggering the
> > Xen hypercall page setup, to fix an SRCU usage violation when the
> > hypercall MSR index collides with a real MSR written during vCPU reset.
> >=20
> > However, some VMMs legitimately need to trigger hypercall page setup
> > from host context. For example, a VMM may intercept the guest's MSR
> > write to track an epoch (for kexec/crash recovery), and then replay the
> > write as a host-initiated KVM_SET_MSRS to populate the hypercall page.
> > The host_initiated check breaks this use case.
> >=20
> > Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE as a new vcpu attribute
> > that explicitly invokes kvm_xen_write_hypercall_page() under proper
> > locking. This gives userspace a safe interface to trigger hypercall pag=
e
> > setup without going through the MSR write path, preserving the
> > host_initiated defence in depth while restoring the lost functionality.
>=20
> This is all kinda silly.=C2=A0 Userspace provides KVM a blob, then usersp=
ace intercepts
> the MSR write that triggers doing something with said blob, only to call =
back into
> KVM to consume the blob that userspace provided in the first place.
>=20
> Any chance we can deprecate KVM's kvm_xen_write_hypercall_page(), and ins=
tead
> rely on userspace to fill the page?=C2=A0 This extra bit obviously isn't =
much code to
> carry, but it's yet one more Xen thing to maintain, and we've accumulated=
 a lot
> of those over the years...

We don't actually use the 'blob' mode. That was added in commit
ffde22ac53b6d in 2009 with a comment saying, "A generic mechanism to
delegate MSR writes to userspace seems overkill and risks encouraging
similar MSR abuse in the future.  Thus this patch adds special support
for the Xen HVM MSR."

When Jo=C3=A3o and I came along almost a decade later, in 23200b7a30de3
where we added hypercall interception support we said, "Since this
means KVM owns the ABI, dispense with the facility for the VMM to
provide its own copy of the hypercall pages; just fill them in directly
using VMCALL/VMMCALL as we do for the Hyper-V hypercall page."

I think we could probably rip out the blob mode without any fear of
breaking userspace. Even in 2018 I don't think we could even find the
alleged code from 2009 that used the old support. At least, not in
buildable and usable form?

> > diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> > index 91fd3673c09a..c16b4560c9e7 100644
> > --- a/arch/x86/kvm/xen.c
> > +++ b/arch/x86/kvm/xen.c
> > @@ -907,6 +907,13 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, s=
truct kvm_xen_vcpu_attr *data)
> > =C2=A0{
> > =C2=A0	int idx, r =3D -ENOENT;
> > =C2=A0
> > +	/*
> > +	 * kvm_xen_write_hypercall_page() manages its own locking.
> > +	 * Handle it before taking xen_lock to avoid a deadlock.
>=20
> Do we actually want the side effects that necessitate taking xen.xen_lock=
?=C2=A0 From
> a uAPI perspective, it's odd to effectively bundle KVM_XEN_ATTR_TYPE_LONG=
_MODE
> into KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE.

That's *guest* ABI, and it's derived from Xen behaviour. Xen will
'latch' its idea of whether a guest VM is 32-bit or 64-bit, for the
purpose of shared data structures (shared_info page, vcpu_info,
runstate).

Xen latches this from the current mode of the running vCPU in *two*
places:
 =E2=80=A2 When the hypercall MSR is invoked
 =E2=80=A2 When the guest sets the event channel GSI (HVM_PARAM_CALLBACK_IR=
Q).

Thus far, the former has been handled in the kernel (in the code you're
looking at), while the latter is why we have the ioctl to explicitly
latch the guest's long_mode from userspace too, as userspace handles
the HVMOP_set_param calls.

> The other question is, why does kvm_xen_write_hypercall_page() drop xen_l=
ock
> when writing guest memory?=C2=A0 That seems odd and unnecessary.

Huh? It takes the lock to do the thing that needs the lock, then drops
it. That is not "odd and unnecessary" at all.

You've been spending too long with these scope-guarded locks. I *hate*
them. I hate the way they slowly spread around the whole kernel, making
every lock holder hold their locks for just a *little* bit longer than
they need to, slowly increasing lock contention "just a little bit; it
doesn't matter" at a time. I hate the way they stop us thinking about
which locks are needed and in which order, and make it unclear whether
some action in the tail of a function actually *needed* the lock, or
was just caught up in it as collateral damage.

> > +	 */
> > +	if (data->type =3D=3D KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE)
> > +		return kvm_xen_write_hypercall_page(vcpu, data->u.gpa) ? -EIO : 0;
>=20
> -EIO is rather weird, wouldn't -EINVAL be more appropriate?=C2=A0 Ah, and=
 both are
> wrong if copying the blob fails.

-EINVAL is more for "you asked me to do something that doesn't make
sense". -EIO is for "something went wrong when I tried".

Arguably, the thing that's most likely to go wrong is the
kvm_vcpu_write_guest() where it writes instructions[] to the guest, and
maybe that ought to be -EFAULT? But I'm not sure that's quite the right
semantic to return from the ioctl?

> > +
> > =C2=A0	mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
> > =C2=A0	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
>=20
> Speaking of writing memory, kvm_xen_write_hypercall_page() expects the ca=
ller
> to be in a read-side SRCU critical section (I didn't actually run this wi=
th
> PROVE_LOCKING=3Dy, but I don't think I'm missing anything?)

Yes, good catch. Thanks.

> So, if this uAPI is unavoidable seems like we want something like the bel=
ow.
> Either that or guard all of kvm_xen_write_hypercall_page() with a lock, a=
nd put
> the entire thing in a helper so that KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCA=
LL_PAGE
> can be handled in a case-statement and doesn't need to grab SRCU on its o=
wn.

Makes sense (with the test, of course). Want me to put them together
and resend?

--=-Zgc7OAjbz0Hgd13lKrY1
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYyNjA3NDUz
MlowLwYJKoZIhvcNAQkEMSIEIBISr3iYaDd3qFcoqAvCDTS+4GADOAXk1Gl0XpGJqnYIMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAiHAYQRC6J6MS
3ASzXKqv4CzaI+MWyycM32z5SNbGEafbVLwQ01sDao1hyYHIH4LDHc6GG2YeCiJxblfH4u4L9+XJ
RxMLP8puPxv/FAXpNvxqllma+w4Jo/Gpy7R8BQJpMKQnHYXJ0GgWLw2No8tvq4AZdwGHGQBoqYkk
6qNTneF78Td5X3yyAKAi2Nr1fml/1x3KKHSjesMeSoPQtNBLYYpnoRgzdXqZFdx280gRYFp7qmX5
/fEzNWGbARqYiPnWsoTrFHTJdiGqXjP71ME56oOFLsZc8jbClarbK7ngP9sraVzIdu5Llw8wY5x4
AFVOHH7AwOIggdd+Id6vgrFY+JOpUcgsBZVV03dYVfiketxc38O+89m/cPDGrJHdJUe+WeW/qouJ
IhlYiknv5oKOK6roGfROvq9vjKk5Mn9n1pTEaEWSrIfM5YpT51r99anntEtx9FORGbC5Bovc2Kw4
J+3tN7WYHsRkvOhJtF6igH3yH9uCMRLQ1wAduiOyqfPtg7xwCF6pTO5Bm+7xZwhYs9l9mmyrLKbT
5xfE7QXI9GtNrWNGMigdszf+dT2tsVS8SX6klNMnqzUdLzlGlgzJStBOfx54Z/FbKA5mULEdjhge
D7xaUVHdwfjyqoAtkTcansFsnNsWnrbIn4dD0dNmBSUUThGH0IpAD9Oxq/3AYr0AAAAAAAA=


--=-Zgc7OAjbz0Hgd13lKrY1--
