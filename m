Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593791;
	b=wGbl4aysKPISMjiol7mDlZjLdh80nRDULWuaSLWbBRBJmCEBlbJXHfuFIoFVnWLGDrdv
	 El1JYPE7ss8rwRrywCZMz8M5sLRSUIRlg+Wmtm4SSZaOil0oHGewqfezf5x9/35fSZEKR
	 icJahAk0W2TE7/bbjOvzgQT7fhTuUXH8ardKH4kTolr55oK5Merka6vgdHPZBpwgy9vHU
	 qk7rSuwKSxETjWgNeoK3yTHTTdt3wAzQ50b5Ix3p65c8OfbiZz3HrbZHphAxR6Zq4Gshe
	 8E+TzyKCk3FdfspnRSMdtrfcRES0rZPBDFn/VbjDz3FiEajzEQzjwAJOkjtYcaNIdBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593791;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 X-SRS-Rewrite;
	bh=cFSJJ0QBLS+4V7pmjf8IWax5Ur3cpjNCmc79i/EDqN8=;
	b=k6M5Uh1q4Q5BBw8pSECw0onYabPExD9d5pyEQu2BDVtonjKlURazURieQiz3fHaiGEBl
	 9m3oawI9uinEzM7Qz12pKOzKrJqAXUMKUEFz0ip3vLLJd5KNHkcYIFvr/ouNQOM1wbKrH
	 4M6ncA1WKyEN1kH3fhYm/VT9/7EPU2mPOi0PMr7K2xeObKrzjdFRjC4kirEUpYmzzBLWl
	 iQDCGIRZU9xM2ckky8a14258FI83qdPVfaMSdiH1r0vgW9ez11pT4Wndg+wdbiHK37YTF
	 xv7zAtk1ZeahIimrDCvCtrQ8URGC4n6fHySXTXec20n6AesLcWZawChiD26FoFiFMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZpC+zsQY;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0D60A382C;
	Fri, 13 Nov 2026 18:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D0D60A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZpC+zsQY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cFSJJ0QBLS+4V7pmjf8IWax5Ur3cpjNCmc79i/EDqN8=; b=ZpC+zsQY6RMkL2oexGq0Gm39F7
	eAXx6LPweLYs3AhMLQLK9JYKmJduNBtaL3Gv72ggZcrY540zbZiY7PIaxrzH+Cj46hyOXyXrqpS4S
	CLWw3TAknSxQFBSbgj+Wri+pwM31UDadyhSAFO6UKkq5zHAY9my4ltsS7r0PNZtUDVQSKu6sY+zgT
	1ckDSZdiVYDzrWEaHYFT+V9hFhJiVbjtdElmQp1fUTMaTmL9XKV92Im+FBR9jWfBNid+jEyDgxdKh
	wNHk8tIGRFElzxpnMI3tXLVL+dL51PntY1MMsEVtTzxqq0PRp+loZ9KwZlXH0ZyIHFqoOlGJm3Jqj
	2dd48BUA==;
Received: from 54-240-198-32.amazon.com ([54.240.198.32] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvp4-00000004ZGw-37yg;
	Fri, 13 Nov 2026 18:16:27 +0000
Message-ID: <ca9dffb64656a392965f95d35b9d13d829f34076.camel@infradead.org>
Subject: Re: [PATCH v3 06/12] KVM: x86: Forward VMware hypercalls to
 userspace
From: David Woodhouse <dwmw2@infradead.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, 	kvm@vger.kernel.org, Doug Covelli
 <doug.covelli@broadcom.com>, Thomas Gleixner	 <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,  Vitaly Kuznetsov
 <vkuznets@redhat.com>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>,
 Francesco Lavra	 <flavra@baylibre.com>, Radim
 =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=	 <rkrcmar@ventanamicro.com>,
 linux-doc@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, 	linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 11:16:20 -0700
In-Reply-To: <CABQX2QNhRZP1Td_HQ6QpMzw-_TjqhbooipWYg3VTgTOq2_U9+w@mail.gmail.com>
References: <cover.1794374897.git.zack.rusin@broadcom.com>
	 <90467782be23b83fd3e9a6afe2f1d2149eaf9db9.1794374897.git.zack.rusin@broadcom.com>
	 <876c4f4fc442116c9bff8abd8c34f99fcfa65531.camel@infradead.org>
	 <CABQX2QNd7DehBsH-pGL=EJK4b5vC60PymL_YP27xDxGT6_6=uQ@mail.gmail.com>
	 <1bae109338ab6ff1ff14eac811f7e86ced785b22.camel@infradead.org>
	 <CABQX2QNhRZP1Td_HQ6QpMzw-_TjqhbooipWYg3VTgTOq2_U9+w@mail.gmail.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-Hw+hWHuUyyHEhRnfc+6D"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-Hw+hWHuUyyHEhRnfc+6D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-13 at 01:33 -0500, Zack Rusin wrote:
> On Thu, Nov 12, 2026 at 11:56=E2=80=AFPM David Woodhouse <dwmw2@infradead=
.org> wrote:
> >=20
> > On Thu, 2026-11-12 at 20:05 -0500, Zack Rusin wrote:
> > >=20
> > > > And I wonder if the cleaner answer in both cases is just to give
> > > > userspace a way to cancel the pending hypercall completion and use
> > > > KVM_SET_VCPU_EVENTS instead of piling all this stuff into the hcall
> > > > structs? It could even just be a KVM_VCPUEVENT_ flag to make it can=
cel
> > > > the hypercall completion?
> > >=20
> > > I agree that this would be cleaner, and if KVM grows such a flag,
> > > VMware userspace could use it too.=C2=A0 But it's new API in
> > > KVM_SET_VCPU_EVENTS, and we'd need to agree which completions it may
> > > cancel: simply clearing the callback leaves pending I/O state behind
> > > for PIO and MMIO, and KVM_EXIT_HYPERCALL also covers TDX completions
> > > with different semantics.=C2=A0 So I'd rather not make this series de=
pend
> > > on it because it significantly increases its scope.
> >=20
> > I won't necessarily defend my suggestion above to the hilt on its
> > technical merit, but I'll observe that as a counter-argument, yours
> > *really* isn't a good one. We don't design a userspace ABI based on the
> > fact that we're impatient.
>=20
> I think that's a misreading of my concern: it wasn't impatience but
> coupling the VMware series to a new cross-cutting semantic in
> KVM_SET_VCPU_EVENTS.=C2=A0 The current approach is self-contained.=C2=A0 =
The
> exception fields were already in v2; Sean's only comment on that
> struct was to move it into the x86 UAPI header.

Fair.

> > To your concern, I actually think we could get away with aborting *any*
> > pending complete_userspace_io callback.
>=20
> I'm not sure about that. I think simply dropping a PIO or MMIO
> completion can leave pio.count or mmio_needed set, triggering WARNs in
> KVM_RUN. Retrying an MMIO read can replay device side effects, while
> dropping a split-write completion can abandon remaining fragments.
> Also afaict for SEV-ES/SNP and TDX, KVM can't simply replay the
> guest's VMGEXIT/TDCALL: RIP has already advanced.=C2=A0 Dropping the
> completion can lose returned data or leave a multi-step request such
> as SNP PSC unfinished.
>=20
> > Userspace *already* needed to
> > know about those=C2=B9 because it can't migrate while those are pending=
;
> > it has to do at least one more run, even if it's with the immediate_exi=
t
> > flag set.
>=20
> True, but, again afaict, that rule exists because those completions
> have to run, so I don't think it tells us they can be dropped.
>=20
> > If it's deemed clearer, I'd also be OK with an explicit
> > KVM_VCPUEVENT_CANCEL_HCALL which cancels *only* hypercalls. But I don't
> > really see the point; userspace shouldn't be getting confused when it
> > was actually some other kind of completion that was active anyway.
> >=20
> > =C2=B9 https://lore.kernel.org/all/20250111012450.1262638-1-seanjc@goog=
le.com/
> >=20
> > Looks something like this in my Hyper-V hcall series (except I already
> > shouted at the agent for stupid struct layout and made it go run pahole
> > on everything it's working on).
>=20
> FWIW, restricting cancellation to explicitly marked completions looks
> good to me.=C2=A0 If Sean/Paolo prefer that, I'm happy to mark our
> completion cancellable and drop our exception fields.

I posted that as
https://lore.kernel.org/kvm/20261113170535.79246-3-dwmw2@infradead.org/T/#u
and caught both Paolo and Sean here at KVM Forum and both seem OK with
it (although acquiescence when badgered at a conference doesn't
necessarily translate to applying the patch... :)

--=-Hw+hWHuUyyHEhRnfc+6D
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
3efn0r2XoT1mkDx+qPB1UssAAAAAAAA=


--=-Hw+hWHuUyyHEhRnfc+6D--
