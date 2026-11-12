Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462534;
	b=TXA5v8opcumeKB8nJPgmEtrBGMVbEek9iPXKja4uya/eAfq5vUpjBTIAKw1rwIoZESqD
	 NDwB/GTL484lXllvorSiUKGE9yX3CmaGYr/apPXPlbePPk1zxyYP+BfW/fqvVrfi5NJ53
	 6xfrt0H5p0uVDGTUR1JettusQu+RUNzIKboAF5M4ZZgvUO7o8MyMcu+qVwdTCShEU2N4r
	 3nXp0F/D6+eVRKJ2aF5izMkINSg9Yu6x4BEIndXLv7GF53N3yLvGPCYlQu6j3EoyoSx4t
	 rt3Tn/GCwHVDoQf/SOFi2TFQnXDzvjNbICW9ODFbOADacWtirAgj8ZAjqiZcbmm05HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462534;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=3hq6g/fR60cf9Qvu6aivD2xz62zztDPeMjEjKudVlmM=;
	b=wauB/kBDscuCJEWAg7eSzsOt2hdYJAA8gDleBxnIkmdvEy/9oX5zjCHShPkCZ3/HlDNT
	 RXy45vOS0c0E34PdykN+RoiPVknTavrgJtqZF7PBWhwEhZo5T5aRd4ndTzskEf62fLfrg
	 LF8jNf9eLMIs3+AgCP1TCTWmsk5scH/zchaeZm4bPHDXN8eDn9E28gOjjdanBLEkWyZsp
	 XMrjj6k/1LadPl46Wwq8ZSotPLhLV5xwyYLEknyTw6L3JRRjDdsSOh2kqTwQFxIXOooeF
	 iEI5cBAnUFWvzlkttaWAisVJ2PKh6ttcNrSBAgJLSB+fI64MyDsxz6+8TSTkXnOkLBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Dr/5Bzw3";
	arc=none smtp.remote-ip=74.125.224.99
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F836606A321
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 05:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F836606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Dr/5Bzw3
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so5000811d50.2
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 21:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794462533; x=1795067333;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hq6g/fR60cf9Qvu6aivD2xz62zztDPeMjEjKudVlmM=;
        b=cpapAyOUIjB1j6D80oOCCoyIXL0pe9mT5zpPcadwDzDRMAsxvh2Y+uMqFoQay7hJ4w
         bvOOy+7P2jPMoauH56qFn/ajq4/CHR568e8Ps6suJHxlV0oLPd43d0kmCqyuDCNOET/F
         9cM2WnUw/k8d+ovcZbv+sDYtHhIpkfAa409mkkTU1lQkKm0R9XxGOzUrIVQzUQjV3hBb
         pY0HlGz8Kg4F76JEJjBD4qfepNJKU0Zy+R7mdxmz2kc+DPBmojNiXeAwlCKA9qcvXnqK
         PphNrqpe9yMEQqjQvjwYPBaTpZ6CdBLzGeUt39zEhfd+xpUwNbqYkaZTGKrjWFXjNIgK
         Jjsw==
X-Forwarded-Encrypted: i=1; AL+hErFCzJF8QS+t1N7cPReCXDt5xrhRmPNNd647n5ql7rK1wDLF8iqaIN6vmfUO/b6r8Sb86Xk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WQDgnqFjObEmM34JObWou6o2nVL7p8waTyNo9nBvxOKC5LT7z
	UvSb2TBnGE/f4PbMdAvusBxh898oHmDb3Uzvfmx0xzb8wOskv5euPg7qVIejIEUlLWizD4lzfB6
	fgx/66OUqouMzBU8dPqewC3cFp2ST7fqJELN7I0IlxQLGBK7n5ZE9m1JZFG1XsSjXsMslRW/7KZ
	EoIdiMgRswamDA5Pe81gSVIGaNamaZHa50mGegdCVltqIZUZ2yBvj6W75Cga+x4iRLdadH477xV
	Bag
X-Gm-Gg: AYBFou20OBrtLpf8uG6644LD9Y/mU8b1LndGtOhiixvnFX+QDQvwBUGFV6PGmwvI4a2
	YPfUjVjGp0No6oX0bswC2HFRxBBwWkMXAMDujm5wn1LaGOGdqeVAwFIY3VBWBxsnzyNzGB4P2pC
	B7eABkmgPWVafkXV/7PICkXkw64v2VtcWgeHqB4sX6Jx/dOWKbalHIpcHV25qGJtTgLQ5MokJSw
	d7AgHJU7DxwlcX6NssNrSuTUbVyzFsQZ1w1Va+XVWPA52OE4s22qD7EYVE/vXNooH2AApozDoiG
	yDdJ9vE10mxFMZiffO6b7wykuNrbUnRj39qsLrzYzrL2d/AevWMW/+B5LKqCnK886PaHjEBAHq4
	VHTueLarq4eIWhbzFdsBQgNjk6dss0RyIYmtRIxzvU13ct79DTXP38PJOuEhvm7Gojqqkie8bIK
	gIFyGbCpCkvJ0gyVhtFJPqtX+E+RQSfhDm
X-Received: by 2002:a05:690e:5c7:b0:676:8cc2:bee5 with SMTP id 956f58d0204a3-67c67ff19b3mr1892281d50.85.1794462533427;
        Wed, 11 Nov 2026 21:48:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-67c58a52343sm56414d50.41.2026.11.11.21.48.52
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 21:48:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3ab20dc2aceso2114041fa.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 21:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794462531; x=1795067331; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3hq6g/fR60cf9Qvu6aivD2xz62zztDPeMjEjKudVlmM=;
        b=Dr/5Bzw3HbtL2m/d/Dz3VEXTFoICOd7iG5cPDglpzIGTYqKE0Jgl9B6KTy3XhtLi1l
         Bh4FRN/I5garRO8RSBnKBXrdbfS8lWXlHGE7qwrwbUqbX7Mn74lagYJ24G3W2rD2rJ9t
         /x/Mnu8y4Z9imAAJjlTN2I5MoHWcxpFnNiAX8=
X-Forwarded-Encrypted: i=1; AL+hErEAgGCpLIRMCEHst+dP7muarUC2qJuGPnmTgWy+AunXTq1igFfAWNrgklmlsOa84QI27r4=@vger.kernel.org
X-Received: by 2002:a2e:a98b:0:b0:3ab:1dcd:934c with SMTP id 38308e7fff4ca-3ae1bf10d93mr2744371fa.1.1794462531192;
        Wed, 11 Nov 2026 21:48:51 -0800 (PST)
X-Received: by 2002:a2e:a98b:0:b0:3ab:1dcd:934c with SMTP id
 38308e7fff4ca-3ae1bf10d93mr2744181fa.1.1794462530604; Wed, 11 Nov 2026
 21:48:50 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794374897.git.zack.rusin@broadcom.com> <90467782be23b83fd3e9a6afe2f1d2149eaf9db9.1794374897.git.zack.rusin@broadcom.com>
 <CALMp9eR2tm=RkNk_cYsYj0SZmcUBTfxpYiqtLbtCE4TJ4H6jzg@mail.gmail.com>
In-Reply-To: <CALMp9eR2tm=RkNk_cYsYj0SZmcUBTfxpYiqtLbtCE4TJ4H6jzg@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 12 Nov 2026 00:48:37 -0500
X-Gm-Features: AclHuK8ZMoRLTwx7GdlQFNy0IhAHQdBDtS2QIwUSLiDD8CGm6dyYo5afDPhKYYI
Message-ID: <CABQX2QNsMCke2vKuXarXbvVcC2H4FNq2=zNqrq2PO1Hv2cfSDA@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] KVM: x86: Forward VMware hypercalls to userspace
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>, 
	Francesco Lavra <flavra@baylibre.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Liran Alon <liran.alon@oracle.com>, Arbel Moshe <arbel.moshe@oracle.com>, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c0d85206600dddb0"

--000000000000c0d85206600dddb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 7:29=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Tue, Nov 10, 2026 at 10:05=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.=
com> wrote:
> >
> > Add KVM_VMWARE_ENABLE_HYPERCALL.  When it is enabled, exit to userspace
> > with KVM_EXIT_VMWARE when an L1 vCPU executes VMCALL or VMMCALL with
> > VMware's magic value in EAX, and let userspace complete the call by
> > updating the guest's registers or by having KVM inject #UD, #GP or #PF.
> >
> > VMware guests reach the hypervisor through the "backdoor": either the
> > I/O-port interface that KVM already emulates or, on newer guests,
> > VMCALL or VMMCALL, with the same commands and register conventions.
> > VMware's userspace implements the roughly one hundred commands, and
> > reviewing the command list on the mailing list found none that needs
> > to be handled in KVM (see the Links), so leave them in userspace.
> >
> > Only claim calls that carry the magic value, so that the same VM can
> > still use Xen, Hyper-V or KVM hypercalls.  Never claim a call from L2:
> > the only L2 hypercall that L0 handles itself is Hyper-V's L2 TLB flush,
> > which doesn't use RAX as an input.
> >
> > Pass operands and results through KVM_SYNC_X86_REGS instead of defining
> > a second register ABI; KVM_EXIT_HYPERCALL returns a single value in
> > RAX, while backdoor commands use RAX through RBP.  Report the CPL and
> > leave the privilege policy to userspace, as VMware Tools call the
> > backdoor from user mode.  Instead of completing the call, userspace can
> > have KVM inject a validated #UD, #GP or #PF at the hypercall, and may
> > update the registers as well to keep the partial progress of a
> > high-bandwidth transfer.
> >
> > Don't forward hypercalls of vCPUs whose state is protected, as KVM
> > can't access their registers: reject the flag for VMs with protected
> > state, omit it from their VM-scoped KVM_CHECK_EXTENSION result, and
> > ignore it once a vCPU of a VM set up with the legacy KVM_SEV_ES_INIT
> > becomes protected.
> >
> > Link: https://lore.kernel.org/r/c60b32a3-e699-4a8c-8d52-09b34c4d5269@re=
dhat.com
> > Link: https://lore.kernel.org/r/CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=3D0YZ3=
j2gGhgmaFRdCFg@mail.gmail.com
> > Link: https://lore.kernel.org/r/CADH9ctBivnvP1tNcatLKzd8EDz8Oo6X65660j8=
ccxYzk3aFzCA@mail.gmail.com
> > Link: https://lore.kernel.org/r/aIEmawm9gLflg8zt@google.com
> > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > ---
>
> [ ... ]
>
> > +static int complete_vmware_hypercall_exit(struct kvm_vcpu *vcpu)
> > +{
> > +       struct kvm_vmware_exit *vmware =3D &vcpu->run->vmware;
> > +       u32 pad1 =3D READ_ONCE(vmware->pad1);
> > +       u32 inject =3D READ_ONCE(vmware->hcall.exception.inject);
> > +       u32 pad2 =3D READ_ONCE(vmware->hcall.exception.pad2);
> > +       u32 vector =3D READ_ONCE(vmware->hcall.exception.vector);
> > +       u32 error_code =3D READ_ONCE(vmware->hcall.exception.error_code=
);
> > +       u64 address =3D READ_ONCE(vmware->hcall.exception.address);
> > +
> > +       if (pad1 || pad2 || inject > 1)
> > +               return -EINVAL;
> > +
>
> Should this check kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip),
> like the fast PIO completions do?

Yes, I think it should. It seems Xen has the same check. Thank you for
spotting this!

I'll fix it in the next version alongside the issues sashiko found
(most of them valid). afaict one thing that this fix doesn't cover is
if userspace swaps in different vcpu state that happens to have the
same linear RIP. That's a preexisting blind spot though.

z

--000000000000c0d85206600dddb0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVIgYJKoZIhvcNAQcCoIIVEzCCFQ8CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKPMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWDCCBECg
AwIBAgIMYT8cPnonh1geNIT5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NTUwOVoXDTI2MTEyOTA2NTUwOVowgaUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKWmFjayBSdXNpbjEmMCQGCSqG
SIb3DQEJARYXemFjay5ydXNpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCwQ8KpnuEwUOX0rOrLRj3vS0VImknKwshcmcfA9VtdEQhJHGDQoNjaBEFQHqLqn4Lf
hqEGUo+nKhz2uqGl2MtQFb8oG+yJPCFPgeSvbiRxmeOwSP0jrNADVKpYpy4UApPqS+UfVQXKbwbM
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHh2
ojIoVc+3rn2irljZv3qzzE3vW23R3iHaCmMN+AQSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTExMjA1NDg1MVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAA6K3wUCPVcdX/KTXHg0WvMYuBl83T1MRwsPq4Fg
TtIJamnHoRyG9hIrpfGcBkNDYNhKCU6IlIfP+NCiHctqFspBnCk+A8Fcqz6xaFAg1aGPMu5IhCgm
/dOzGq9QUJ6v/aVCF0PNK0JRB0CEKew6aDAnZkKw6t9g3hZ0jkmU9uVQxKfXwW6njrvWd8ow3dEy
lZsMQ2WosgYdHOdrIRglt260kTCzTIvO0L3MFTIxsS1N5iD2fCSGJ5Wx7O1G4JNy98uWRgqyFVel
z111ia6n47Y5NVkrA1MfW+KR0lk9dds1z0CAyc0XaAA5ta22UJXamPo0B+xFUrsa3EQKzIHOVLQ=
--000000000000c0d85206600dddb0--
