Received: from iad-out-004.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-004.esa.us-east-1.outbound.mail-perimeter.amazon.com [18.207.52.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032B3254A3;
	Mon, 30 Mar 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.207.52.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882304; cv=none; b=O2OGa6qstioaGNSUIu36iR8F/1CPMA4r5gwfyDtqIahhMIr2dK131HnkRjQDfwaghQxEdcgkK+JKQyG3BRU4WakXtc2PTGWEuaLRJlBBpvgF96VYe7MPHHT4oxrhnNlsiGd9UuEAfetLwuzDpMXwUvMpKZLDOSNpLkh2BakX1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882304; c=relaxed/simple;
	bh=bG8Z1D3gbKWP/yDjn+ezIFhT0Ed0AS+oYaKyJds5mHw=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:Date:Message-ID:
	 References:In-Reply-To:MIME-Version; b=gltxpX9LGxNdIGtLO8qhchlO+5namnkUwnwRDe0TUHFR3LbAXsHa1t3ZUysPs4fdvkd2/2nIMBNv147ynQe3gh+Au+h6fOXlRcpQdITJtw9NYfKwvSkosy6q1kN3wF1TxhLn03RYaCHKG0w12bgjUIpr5QqCqmZAYNFym+urS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=lqrSjnTx; arc=none smtp.client-ip=18.207.52.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="lqrSjnTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1774882303; x=1806418303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to;
  bh=dTSvER0RGyHjky6bHxPduzBZMv+zJjLg7A0MuNE3W3o=;
  b=lqrSjnTxTwDaJiv+nqbEcHWA5QVf7FV95VJVL5FnU8g0uCMtt4eN/JZp
   xN5M0RjbRqrMbvXd1HOHc9+nLFtEm+tiqKeuaPhKcGsmSIZDBlsvTt0wm
   7nBcqMn6mdOtQ3FeN+QdMO7HrsaHOPb+cMDT6NuybjWT+QfBjO/hgGWp7
   bz3KJvQFgnMAZUjLgLz49B7CviwKJLxzx1I88IhNMJmXeBFvdxWWriaLI
   QcQA7yN/JGY5D0Fw5iFmz8HU3RxIMvTP2sppRaqhnCsn0aF73tfRnDt3f
   yskLOv4QrGMGpxSZTaXkjByHQTOZqXF/YA+6vS8zcP4mTMX3feTdoYq1N
   Q==;
X-CSE-ConnectionGUID: +0asUoQYSxyHVIgULdB39g==
X-CSE-MsgGUID: FsB5EcsZTQmIp7oQMwpQZg==
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="6.23,150,1770595200"; 
   d="p7s'346?scan'346,208,346";a="15100306"
Content-Type: multipart/mixed; boundary="===============4823398576471499449=="
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from ip-10-4-22-235.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.22.235])
  by internal-iad-out-004.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:51:39 +0000
Received: from EX19MTAUEA001.ant.amazon.com [72.21.196.67:31057]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.12.35:2525] with esmtp (Farcaster)
 id 9722e371-26e5-4702-94ef-c0b8ac460937; Mon, 30 Mar 2026 14:51:39 +0000 (UTC)
X-Farcaster-Flow-ID: 9722e371-26e5-4702-94ef-c0b8ac460937
Received: from EX19D001UEB002.ant.amazon.com (10.252.135.17) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 30 Mar 2026 14:51:36 +0000
Received: from EX19D001UEB002.ant.amazon.com (10.252.135.17) by
 EX19D001UEB002.ant.amazon.com (10.252.135.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 30 Mar 2026 14:51:36 +0000
Received: from EX19D001UEB002.ant.amazon.com ([fe80::19d6:e954:f18:6292]) by
 EX19D001UEB002.ant.amazon.com ([fe80::19d6:e954:f18:6292%3]) with mapi id
 15.02.2562.037; Mon, 30 Mar 2026 14:51:36 +0000
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>, "shaikhkamal2012@gmail.com"
	<shaikhkamal2012@gmail.com>
CC: "syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com"
	<syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com>,
	"me@brighamcampbell.com" <me@brighamcampbell.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul@xen.org"
	<paul@xen.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Subject: Re:  [PATCH] KVM: x86/xen: Fix sleeping lock in hard IRQ context on
 PREEMPT_RT
Thread-Topic: [PATCH] KVM: x86/xen: Fix sleeping lock in hard IRQ context on
 PREEMPT_RT
Thread-Index: AQHcwFS04Gd7OxUeTEezGEroO0FIQQ==
Date: Mon, 30 Mar 2026 14:51:36 +0000
Message-ID: <bb7b66ad99097c5326196b61d644cff255e30394.camel@amazon.co.uk>
References: <20260329131543.91733-1-shaikhkamal2012@gmail.com>
	 <20260330101814.7fa1e31e@gandalf.local.home>
In-Reply-To: <20260330101814.7fa1e31e@gandalf.local.home>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
MIME-Version: 1.0

--===============4823398576471499449==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-4TfNX9rrV7rNrltxw1Z9"

--=-4TfNX9rrV7rNrltxw1Z9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-03-30 at 10:18 -0400, Steven Rostedt wrote:
>=20
> > +static void xen_timer_inject_irqwork(struct irq_work *work)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_vcpu_xen *xen =3D container_of(wor=
k, struct kvm_vcpu_xen,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_inject_irqwork);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_vcpu *vcpu =3D container_of(xen, s=
truct kvm_vcpu, arch.xen);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_xen_evtchn e;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int rc;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 e.vcpu_id =3D vcpu->vcpu_id;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 e.vcpu_idx =3D vcpu->vcpu_idx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 e.port =3D vcpu->arch.xen.timer_virq;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 e.priority =3D KVM_IRQ_ROUTING_XEN_EVTCHN_PRI=
O_2LEVEL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D kvm_xen_set_evtchn_fast(&e, vcpu->kvm)=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (rc !=3D -EWOULDBLOCK)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 vcpu->arch.xen.timer_expires =3D 0;
> > +}
>=20
> Why duplicate this code and not simply make a static inline helper
> function that is used in both places?

It's already duplicating the functionality; the original
xen_timer_callback() will already fall back to injecting the IRQ in
process context when it needs to (by setting vcpu-
>arch.xen.timer_pending and then setting KVM_REQ_UNBLOCK).

All you had to do was make kvm_xen_set_evtchn_fast() return=C2=A0
-EWOULDBLOCK in the in_hardirq() case in order to use the existing
fallback, surely?=20

Better still, can't kvm_xen_set_evtchn_fast() just use read_trylock()
instead?

--=-4TfNX9rrV7rNrltxw1Z9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkYw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhUwggT9oAMCAQICEFQru/eJkU7BxeS7T6sWKmYwDQYJKoZIhvcN
AQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNV
BAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMjQxMjE1MDAw
MDAwWhcNMjYxMjE1MjM1OTU5WjAiMSAwHgYJKoZIhvcNAQkBFhFkd213QGFtYXpvbi5jby51azCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANhjs6T4tJ0lcw4+6sawEn2FowmhunUBsnSV
ccB+aA7s3Zd9PZV46CU6phAlCWpKk1yFVcD1Rnc4ux17o4LbUgFXiKrORS0jiF/5Oa0rXG3FISG1
Xdjt8oPKIq+9Z1s2e7Ipi5WWj4AG/xlkH/YMMctL9O8CCRHSrhiChbE/gR57x9PAnt5aeZZ2YWza
GOOeceaZe+u6vHCHITRmknSAnAX/aNoNJNsQCGcfrE83y9iHmP8BFrSRZqajBKlKq8tyJd5FnSwP
H3kSUcQlHOwiIfCRFXP4rpXSZ7nKOEZr3SXH06ADY9gZtrSpwBbuzKWDPGWMRuRnz8ogj/Y6DeU4
2zB/ZAIi5b0BzWf4u0rBEQD5xtpOCxYHc2nXQaFSWu36kP1JaNqElE51OQ92EyVKfW3N6qZcKiBr
VijXY2EtR+/5W9ixRFnEs4nIeb94Sf92UMEeG9ew2yVvcYXXNPaicGnrkESNC19/a8YXxQEZfrmB
eAPT9viQJhn3O+sD4pP0Ss3SjVZc6EO7vfoP07bt2n9YE08XSPkxcyb1J/4t/+AskkKeYFBGdpjg
xd+iLFxjSwBytZuh3+7DuHUfg876WA44ieQDrhHSjuvuAZ1Wb8WUsrpzrcLoYjqFmb/bf6/yyoxl
t31mdgPC+FLc+Yu1BQwXC3JMbrvbFBVTtn5X2EKDAgMBAAGjggHQMIIBzDAfBgNVHSMEGDAWgBQJ
wPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUWvtA1XsSV8xjgfFQL/DUTNIbJu4wDgYDVR0P
AQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwEwYDVR0lBAwwCgYIKwYBBQUHAwQwUAYDVR0gBEkwRzA6
BgwrBgEEAbIxAQIBCgIwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly9zZWN0aWdvLmNvbS9TTUlNRUNQ
UzAJBgdngQwBBQEDMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2Vj
dGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUF
BwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xp
ZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDov
L29jc3Auc2VjdGlnby5jb20wHAYDVR0RBBUwE4ERZHdtd0BhbWF6b24uY28udWswDQYJKoZIhvcN
AQELBQADggEBAED6T+rfP2XPdLfHoCd5n1iGIcYauWfPHRdZN2Tw7a7NEXIkm2yZNizOSpp3NrMi
WOBN13XgqnYLsqdpxJhbjwKczKX50/qfhhkOHtrQ0GRkucybK447Aaul80cZT8T3WG9U9dhl3Ct/
MuyKBWQg3MYlbUT6u4kC9Pk8rd+cR14ttYRUWDKTS2BrL7e8jpNmtCoEakDkMY4MrpoMwM1f4ANV
qZ8cnDntwXq5ormZIksN2DqxsKLmrFyVAONhqSST72ImBfIVWhFRTCF9tTcI5wE/0Skl25FZmSsB
B2LUgecgK7MZyw9Do/b0sYS+8YmA/ujUCqNb0fPJBE/B9vBomhswggYVMIIE/aADAgECAhBUK7v3
iZFOwcXku0+rFipmMA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTI0MTIxNTAwMDAwMFoXDTI2MTIxNTIzNTk1OVowIjEgMB4GCSqGSIb3DQEJ
ARYRZHdtd0BhbWF6b24uY28udWswggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYY7Ok
+LSdJXMOPurGsBJ9haMJobp1AbJ0lXHAfmgO7N2XfT2VeOglOqYQJQlqSpNchVXA9UZ3OLsde6OC
21IBV4iqzkUtI4hf+TmtK1xtxSEhtV3Y7fKDyiKvvWdbNnuyKYuVlo+ABv8ZZB/2DDHLS/TvAgkR
0q4YgoWxP4Eee8fTwJ7eWnmWdmFs2hjjnnHmmXvrurxwhyE0ZpJ0gJwF/2jaDSTbEAhnH6xPN8vY
h5j/ARa0kWamowSpSqvLciXeRZ0sDx95ElHEJRzsIiHwkRVz+K6V0me5yjhGa90lx9OgA2PYGba0
qcAW7sylgzxljEbkZ8/KII/2Og3lONswf2QCIuW9Ac1n+LtKwREA+cbaTgsWB3Np10GhUlrt+pD9
SWjahJROdTkPdhMlSn1tzeqmXCoga1Yo12NhLUfv+VvYsURZxLOJyHm/eEn/dlDBHhvXsNslb3GF
1zT2onBp65BEjQtff2vGF8UBGX65gXgD0/b4kCYZ9zvrA+KT9ErN0o1WXOhDu736D9O27dp/WBNP
F0j5MXMm9Sf+Lf/gLJJCnmBQRnaY4MXfoixcY0sAcrWbod/uw7h1H4PO+lgOOInkA64R0o7r7gGd
Vm/FlLK6c63C6GI6hZm/23+v8sqMZbd9ZnYDwvhS3PmLtQUMFwtyTG672xQVU7Z+V9hCgwIDAQAB
o4IB0DCCAcwwHwYDVR0jBBgwFoAUCcDy/AvalNtf/ivfqJlCz8ngrQAwHQYDVR0OBBYEFFr7QNV7
ElfMY4HxUC/w1EzSGybuMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMBMGA1UdJQQMMAoG
CCsGAQUFBwMEMFAGA1UdIARJMEcwOgYMKwYBBAGyMQECAQoCMCowKAYIKwYBBQUHAgEWHGh0dHBz
Oi8vc2VjdGlnby5jb20vU01JTUVDUFMwCQYHZ4EMAQUBAzBaBgNVHR8EUzBRME+gTaBLhklodHRw
Oi8vY3JsLnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3JsMIGKBggrBgEFBQcBAQR+MHwwVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuc2Vj
dGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5j
cnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNlY3RpZ28uY29tMBwGA1UdEQQVMBOBEWR3bXdA
YW1hem9uLmNvLnVrMA0GCSqGSIb3DQEBCwUAA4IBAQBA+k/q3z9lz3S3x6AneZ9YhiHGGrlnzx0X
WTdk8O2uzRFyJJtsmTYszkqadzazIljgTdd14Kp2C7KnacSYW48CnMyl+dP6n4YZDh7a0NBkZLnM
myuOOwGrpfNHGU/E91hvVPXYZdwrfzLsigVkINzGJW1E+ruJAvT5PK3fnEdeLbWEVFgyk0tgay+3
vI6TZrQqBGpA5DGODK6aDMDNX+ADVamfHJw57cF6uaK5mSJLDdg6sbCi5qxclQDjYakkk+9iJgXy
FVoRUUwhfbU3COcBP9EpJduRWZkrAQdi1IHnICuzGcsPQ6P29LGEvvGJgP7o1AqjW9HzyQRPwfbw
aJobMYIExDCCBMACAQEwgaswgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNo
ZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UE
AxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EFQru/eJkU7BxeS7T6sWKmYwDQYJYIZIAWUDBAIBBQCgggHpMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMzMDE0NTEzNFowLwYJKoZIhvcNAQkEMSIEIM2Hc0GO
feVx9/EuwmT3rg6/TnQ7iPK9m7u8gyKnlSZtMIG8BgkrBgEEAYI3EAQxga4wgaswgZYxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAW
BgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEFQru/eJkU7BxeS7T6sWKmYwgb4GCyqGSIb3
DQEJEAILMYGuoIGrMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhBUK7v3
iZFOwcXku0+rFipmMA0GCSqGSIb3DQEBAQUABIICAJt7GRlwnmQssNLGngtbOLR6cIXfwCHMO9Og
aLIHoGlI10+OSfwt5kSqKGUTf2zuaHG2gFKRGnEbUUD92IOb4IJoKPopwhUyftj0TZuBL6YfwAkV
aRCKKz1/016cbeLZCfGXxj/qJchnLtl/u7F1v4kaP0ZmV+oIcrLQ+GQnB5BugSzq2mAK7yQW0PTp
eQOLoxBh9GbZvG+f1K09UsgyVV3Eb56b3eJiQ8MhT/Rqg/hIVpHBXs4fIcSKeBC/0jBSgnEgZipu
ZPPtDkGfe9ssbFtwWTGPgTXyKiNk/LHx62mQhyVpRrznrm8zyWyiaK2SsmAV/AeTEenrIm5SoEN0
vx+dvEkgqdb0I7dOtV7YAgy/tdrhZuaFxmkslfLegxtdTPnpxgYXQJUHVbuHWzfWoSWF9oCFmHFX
I3pwmFPT6tXEGTlJERW9zQHno8dt0GPQWOUK3k27fgptKX4sMtHLkGW+S3aX4EJGMrOmnY4PaiwM
cOinTTngZdGJEnjyDbWyPql1hMtZAj4XPTLzwS7ZO+ccLvaaPzkhwjSuSW/ctuAAnkJ5F5Z3ct/k
Nya4s1Kl7aA1+mt9MviulpeWJKsRzb7/NvssBtnLHlPcB9npX2Iu742L34nFl8ywCwEc+lBm8WDf
ZWvXHkGaVSGSGhAidmupoZHFsBFsSok03zY+wJUxAAAAAAAA


--=-4TfNX9rrV7rNrltxw1Z9--

--===============4823398576471499449==
Content-Type: multipart/alternative; boundary="===============8858558829183178805=="
MIME-Version: 1.0
Content-Disposition: inline

--===============8858558829183178805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Development Centre (London) Ltd. Registered in England and Wales wit=
h registration number 04543232 with its registered office at 1 Principal Pl=
ace, Worship Street, London EC2A 2FA, United Kingdom.



--===============8858558829183178805==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Development Centre (London) Ltd.Registered in England an=
d Wales with registration number 04543232 with its registered office at 1 P=
rincipal Place, Worship Street, London EC2A 2FA, United Kingdom.<br><br><br>

--===============8858558829183178805==--
--===============4823398576471499449==--
