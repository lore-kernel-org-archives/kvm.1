Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB693BB9F8;
	Fri, 26 Jun 2026 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782461110; cv=none; b=q2yQoKdrTWGlGVtThHyBCIgZkCztFCIrgPs1uKPVZlw5gGHG0BcbFXL7/HnHOpS5zlQ0Kh3D+o8glGZnwDxj9XaAQqJ/M+R2Ab4sVg8IJqHnTm618hsRYDSBugq8wyYPghhWCgW2jKKdKahIJgWIQkngi4cpDT/LqMdC495D/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782461110; c=relaxed/simple;
	bh=L7aTMYE1X2Qr9oZ5P4BPqx+ISf3ALZC0HLvnwog4xz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rISlKRR+jtla/YjGlRAnsOGvv8CFzTS2cSHZKASFJKANk/HQBWMgZmlbpDPsEzxQzfqcQLoDuh6nUy3PaPbkw/FT7tUkqhWUVzmRI++S5XiPucM7/Z2eakWXLAZXfyFddmQMsaSLfyOg+Z+BnkVSYFNVcWb0KnpevAz5ljsQTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PW9AkTGy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PW9AkTGy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CAeUsyedYIR9IfToxIda2dxWQPnvP4514OAg9vqw08Y=; b=PW9AkTGyhxC101ui32X7LJPycd
	wn9jpHl92OYneaRNVniZl51IqQ+RVqvnFUSAvkLa0jxDjcaijlsO0Inz11FQpy23LKDNZUpKcdsK/
	pi3cPidpkxEOViZfyN8+5ntTnMKZm2QGt2PhnFCaXsEeT0nJqoRHW+x/pqx+ZvFYnelJokSTAE9kR
	VPR+twPf1SlFpdOu2O21FWU8uUY/FK+JD12R9/FYlSlS6HQMcpNGYVqj+7WbVcZBSUMqtM33aAsMb
	GPsmo24fNbQnDLQonCV8tWd51JC5GdkxUB/5I8eCPuKv29P5zULqovgGDV8U1q7c/lL6rUxdnqxL1
	+HgHM08g==;
Received: from [2001:8b0:10b:5:f3d6:3c0c:6c61:8d10] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1Yc-0000000BTDo-3VHP;
	Fri, 26 Jun 2026 08:05:03 +0000
Message-ID: <123bd3932db959a9c26b9ede46632e482dbdc4ab.camel@infradead.org>
Subject: Re: [PATCH v3 04/10] KVM: x86/xen: Punt singleshot timer hcalls to
 userspace if Xen vCPU ID isn't set
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov
	 <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant
	 <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Date: Fri, 26 Jun 2026 09:05:02 +0100
In-Reply-To: <20260625223623.3376478-5-seanjc@google.com>
References: <20260625223623.3376478-1-seanjc@google.com>
	 <20260625223623.3376478-5-seanjc@google.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-tSKYhoy/41trbzcwTFn2"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa6 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-tSKYhoy/41trbzcwTFn2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-06-25 at 15:36 -0700, Sean Christopherson wrote:
> Explicitly invalidate KVM's internal Xen vCPU ID during vCPU creation
> instead of *trying* to set the Xen ID to the vCPU index by default, and
> forward singleshot timer hypercalls to userspace if the VMM hasn't set th=
e
> Xen ID via KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID.=C2=A0 Using the vCPU's index a=
s its
> default Xen ID is reasonable in concept, but in practice is horribly flaw=
ed
> as the index is left as '0' until after vCPU initialization completes, i.=
e.
> every vCPU gets a Xen ID of '0' by default.
>=20
> Forward hypercalls to userspace instead of trying to salvage any kind of
> default behavior, as all userspace implementations that support multiple
> vCPUs either don't enable the timer, are guaranteed to set Xen ID, or wor=
k
> only because *all* guests also screw up the singleshot timer hypercalls.
> The last scenarios is extremely unlikely given that Linux-as-a-guest uses
> the actual Xen vCPU ID when making timer hypercalls.=C2=A0 In other words=
, for
> all intents and purposes, KVM's ABI is already that userspace must set th=
e
> Xen vCPU ID, so just commit to that ABI.
>=20
> Note, KVM's handling of KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID restricts the ID t=
o
> KVM_MAX_VCPUS, so there's no chance of a valid ID colliding with -1u.

Nit: XEN_VCPU_ID_INVALID isn't -1u; it's U32_MAX.

I'd have been slightly happier if you'd used an explicit -1U, perhaps
with a name of its own (although I guess we wouldn't want to call it
KVM_VCPU_IDX_INVALID in the *Xen* part).

But this works.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

I'd have put this *after* your patch 5 though (qv).

> Link: https://lore.kernel.org/all/20260612233017.1F9771F000E9@smtp.kernel=
.org
> Suggested-by: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> =C2=A0arch/x86/kvm/xen.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 694b31c1fcc9..27c1aeeab8af 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -22,6 +22,7 @@
> =C2=A0#include <xen/interface/version.h>
> =C2=A0#include <xen/interface/event_channel.h>
> =C2=A0#include <xen/interface/sched.h>
> +#include <xen/xen-ops.h>
> =C2=A0
> =C2=A0#include <asm/xen/cpuid.h>
> =C2=A0#include <asm/pvclock.h>
> @@ -1610,6 +1611,9 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *=
vcpu, bool longmode, int cmd,
> =C2=A0	if (!kvm_xen_timer_enabled(vcpu))
> =C2=A0		return false;
> =C2=A0
> +	if (vcpu->arch.xen.vcpu_id =3D=3D XEN_VCPU_ID_INVALID)
> +		return false;
> +
> =C2=A0	switch (cmd) {
> =C2=A0	case VCPUOP_set_singleshot_timer:
> =C2=A0		if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
> @@ -2299,7 +2303,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vc=
pu *vcpu, u64 param, u64 *r)
> =C2=A0
> =C2=A0void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
> =C2=A0{
> -	vcpu->arch.xen.vcpu_id =3D vcpu->vcpu_idx;
> +	vcpu->arch.xen.vcpu_id =3D XEN_VCPU_ID_INVALID;
> =C2=A0	vcpu->arch.xen.poll_evtchn =3D 0;
> =C2=A0
> =C2=A0	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);

--=-tSKYhoy/41trbzcwTFn2
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYyNjA4MDUw
MlowLwYJKoZIhvcNAQkEMSIEIPZkZ00iBG6okSyDXcMcXbYKhC1JcFuJBppa6hxgVRxsMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAjFYvlakW8Wp5
evsEQ01PiiJ4IYeRU8FvqmmK8haNb4/pMg5uSYacwsYZ2qixyptQieJ313Jny8rCwf0vI6u8Kt/I
BjFIFMVjFyT3szqFYD5OyKxEs4UDz0/k0VrOB4rwCVE0QSCVFIq9JljNI5sZ6fPVnDgwNa1IqTAw
HiImOTtXeORTnhLn1xFRbj49ABmRfLDsg+UudS2GMTdlwdMliYWeaQiO+3SqwqfpTgYJABehs1CQ
mgZgyAddoTmHEvUVBQMFH7pAUrchW44hc/g+y3NyTJM1KBv402RVIMIzEmKiV8SrvvxnquqTgBiF
r35uSYbhV+rp5m3LlPzTiHvOuUDaTXHmBUdWmNji/d5wNyaLJ1KLAApp14nqXsXDuIWxN/3xMAUa
En7CF6w+mGvFeOF4glPax9YKcgwj+sVLuctnEb0hdvrBFRE/WieL39vU8WsiCGAPjQgbxU5lSV8J
v3hKSNUg9NtZVpRkvLoamzOP8Nutxn72tnS8a6njETj8fiSCkOK8SXnpK0c13OfaC9wcwJg862Y+
BU0eleptnCcYzT3WDWiYABV49WPLG8A0Mjx89HE5t8DmdvwOsOLCuyRT2dBLWw/OsjdnWDq5/3B2
2Kwf0J4H4nU9D3t5dnUxdoviKeyjwLoK+DaaiLjy6tXRw9y2cFp446tP/7fpJh8AAAAAAAA=


--=-tSKYhoy/41trbzcwTFn2--
