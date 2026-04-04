Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55318872A
	for <kvm@vger.kernel.org>; Sat,  4 Apr 2026 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775279806; cv=pass; b=cyQKFkmYsepoP235awBC2TE5Vn2G4GM8uzFH1qc5iXudQpyVMhuXv7jvjaJvtLUn5q0ZxHXG4xQXX3QyUZdiJioM4bTMLTK/w/6NzaR7/TNjSpwYeaVwHe6+2h1Afm2BT3xjMyuE7eAKitwJm/uhjrffoTVrWHpfgTqaLrXWZMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775279806; c=relaxed/simple;
	bh=z9w2BPOEP2Fm0qWHO1DDZbKstsy/XcFCNhrEcPkFTuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfvcKWVthIQSm8S/df8+ViA38bhiO3iehh7ttDsiKKVWYq+vJAXpMOx879dsdDJt9QSHArOuAOuTrknGV2EL0JGOHcWoDRXvP6b59uyTCE4YMKHHbASgjT/RlerZRNsitKyAj9IJHN71phUYVQwgPfyhoyucLlNZx+/ZIlJFFvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVZ5fLbT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsMZs3tI; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVZ5fLbT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsMZs3tI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775279803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9w2BPOEP2Fm0qWHO1DDZbKstsy/XcFCNhrEcPkFTuk=;
	b=GVZ5fLbTkOG7Il67/j4B6kxoxYvE8Uqo+5LQLqksRE+Qm3zQrBnoBbumPut2sD0UfUABUp
	bPCh9qrgxxgsUbZHYx+tdRacUpqG3hW0g1g8/4emddEj15REyYE9h7guZwjj2g9d/YTAYA
	XKDvJBAoF2c1ec0XYB2xex5C229k6cA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-E5sGFzkrMca5YJAur0D6PQ-1; Sat, 04 Apr 2026 01:16:41 -0400
X-MC-Unique: E5sGFzkrMca5YJAur0D6PQ-1
X-Mimecast-MFC-AGG-ID: E5sGFzkrMca5YJAur0D6PQ_1775279800
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cffbe261eso2091365f8f.2
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 22:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775279800; cv=none;
        d=google.com; s=arc-20240605;
        b=NMVjhYJTn0u98KlgnnpmVU+fvouDlk6DpMLG0KnEGUS9paxy5YA9qzt39mde/PVZG6
         hG3xb60sU16wCz0owYSSaHMac12utesaTGFBo1ytJOT+LTrgCyhpKCRmnfpEEqNzYWpm
         IrUahL+IGbrQuklBMubXG8DIhb7Djivxb2EnBytdyczgbObk4Mp6gDiUvtYhfINaaAC/
         sB+JS17k11LK81ZwMAhyDJcx0VNFyDcpC7v3ZMIBIYL9GzTpELzEwMHgBUTcYlMW+jxb
         6Xa/2Ba2vl7b+CTdHcesx0bVkZ5asQ7lnT3j/R9pnT/lzvW0nlgvB6ZYaHmtvH56ztmA
         QEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z9w2BPOEP2Fm0qWHO1DDZbKstsy/XcFCNhrEcPkFTuk=;
        fh=vUkeHMyuDtGMNRCPQceMhjuN11EuG8hvgL87oknqRcM=;
        b=WXiU6uZzb6APamRo/KnnOOzPH6eCvV4nfqwBf/WvNvo3qY04SC2UXI/8QllSxIwEIQ
         wXxSgBDyZ1Nd8qai1hFwhSffQpqrdGV8fbE/TFr2+FlSGiVfjf08em19zu7hbHAFb2gn
         Vnezjf7xuwiTpyjOwWMNLYFtoeRd34F8ZtGJZmTRqy0fncgPzkRiEjLjxGRaup8mp+o7
         wOUGmqAXfBc6tHRiu7HFvnXk7B4S9X+DgZpHlT5wFrMp1dK8/+N7aIhObdCepNocLqw4
         AN0w4RkHrl/iHTQU4OfU5OU/8uUSu/SS9eE+HjQYBS+U7xUN8Ec/nIkvjg9keGt2h58p
         4weQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775279800; x=1775884600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z9w2BPOEP2Fm0qWHO1DDZbKstsy/XcFCNhrEcPkFTuk=;
        b=DsMZs3tIA1840LrbRbRcZi+XbKakp76+8w/mE7jn4Cka5dtONnpnqyl6PjMgeus8Mo
         6ZQ8I9Ona/8bygms435zxrJOOo6KyrpZpqb73OXLGlUCPDDJGidNz0OLP01I1C/YDwe7
         CbDBaI0lKrKCe49yqnh9fakI812DCEixCwWVZUI05CdXdn7W+xanBlvlqfIEwUXpbL0q
         WvKmzmct8sxLbdKuGIB7Vnmmftyd3UcqapS4xrx7ieyldW1NP/AqQLTt+PlGPUMmOcii
         eOtpXIpFW7UIElrh8rub2EwgnoEY/GI83iGqIxq3wITfr2ZEcpcUpqI+3BNEBMXAeNf9
         nX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775279800; x=1775884600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9w2BPOEP2Fm0qWHO1DDZbKstsy/XcFCNhrEcPkFTuk=;
        b=kn1kO87u8r5KflmiwT6QM1WkuUiUtcoDmAr5viD8Xks9pNVZpbdmWiLofk9/KJIxX+
         MUjnZm3sVxiIH+DTyShzW+UTEMzfoztXva5SOiHK6tYbfsOhplx6KkhVY0JTHWGGRSxZ
         9pJXj78n/g4FKTfalez7l+x3QzIxT7qYs3XFUNnS8ksAaD55jEUH/RUwpJfbnemYSq1+
         FvgxmiWd5VWgGvSCE+A26CT/EvdJCDO8zG5C1ZR9dD1HvV0rpzF6kTsLDnjNXe7Ukh81
         BwwLWgsORINjYqmI/IU78kaQtVtyq/b45rR86woSDMoB3fYNTlMBZ1YZ5G7g1dl3D10/
         jAQg==
X-Forwarded-Encrypted: i=1; AJvYcCVkmJXNDQRCKFOFk+5aJlqxNJeH98JrJBfD2gqEbVsJvywcYPiqEg+LdVm8Oe7/BT1YS08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPmq8Q03R6iJOahPTEg0BBjSyHFsMp3szJHhvcHdu5A8b3p9M
	xFtA8GrPpwTP1lMir3ssFBsbpWUy8IXndJQqVwZHGSBYltge8G9sK2u/KfW6Cl04H3liGgs8EhY
	kPeU5S9sEpDpzId9x7Stn6dUBSUIC6u27UY1gtDCc5n4Zy0yuU/J4xthSrZW2UAqXoABTUQb5MT
	RlWWiwjQCIym7x5X9omzaVZ5FtHwzY
X-Gm-Gg: AeBDietGD88R9In4EUpIkGNYCONn0RuddNYQKReI6H8S1N4iiQPRAlSju34NN5Hllzn
	axjP3suMEu0go7hqLOfW/Aoe9FzNshX6Ehr8aiyW+Y4b3uLs5+WU4VnrQBU2Ct8sNWdb3W6Qo1R
	uGhTjKFAUEj7lAQoI8jHEft8WI0D/oA4ytrvy2eFJM199EuHvjVtOvD/qalgD0J57//m+P5O2Tw
	Cpa5MYP5JPQy0vwDAcWtjeQjb7Dvi5gbQOK99QUOFNRkWUwmSd3Q7pYr7PwtXjInDI/Nx6QfoQi
	gZ0M
X-Received: by 2002:a5d:588c:0:b0:43c:fbde:310f with SMTP id ffacd0b85a97d-43d292e40bfmr8144762f8f.36.1775279800440;
        Fri, 03 Apr 2026 22:16:40 -0700 (PDT)
X-Received: by 2002:a5d:588c:0:b0:43c:fbde:310f with SMTP id
 ffacd0b85a97d-43d292e40bfmr8144741f8f.36.1775279800008; Fri, 03 Apr 2026
 22:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <ac75iuf9gHIhvm9u@google.com> <88e9d7f0-35b8-4559-9f4d-c7daf1af6012@redhat.com>
 <aea176c8-35de-4042-bf98-e42ce05f93fb@intel.com>
In-Reply-To: <aea176c8-35de-4042-bf98-e42ce05f93fb@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 4 Apr 2026 07:16:26 +0200
X-Gm-Features: AQROBzDQA26cAfp7NPZjzYYi6dicwa5PG83CE0Y0WcKOPna2MiaisgEoSw_NxXo
Message-ID: <CABgObfY05NU8DS82jkwpF89_p1nR7VJ30HBq_xaMg_u+-j=0Cw@mail.gmail.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000db6bc9064e9b897a"

--000000000000db6bc9064e9b897a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 12:05=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> On 4/3/2026 9:03 AM, Paolo Bonzini wrote:
> >
> > But until the kernel starts using APX, I would do the save/restore near
> > kvm_load_xfeatures(), because __vmx_vcpu_run()/__svm_vcpu_run() would
> > have to check whether xcr0.apx is set or not.
> Right, I'd much prefer this. Then, it requires to audit whether any
> fast-path handler could access EGPRs.
>
> But there are cases with the new {RD|WR}MSR (MSR_IMM) instructions that
> appear to access GPRs. Because of this, the EGPR saving/restoring needs
> to happen earlier.

You're right about fast paths... so something like the attached patch.
It is not too bad to translate into assembly, where it could use
alternatives (in the same way as
RESTORE_GUEST_SPEC_CTRL/RESTORE_GUEST_SPEC_CTRL_BODY) in place of
static_cpu_has(). Maybe it's best to bite the bullet and do it
already...

Paolo

--000000000000db6bc9064e9b897a
Content-Type: text/x-patch; charset="US-ASCII"; name="apx.patch"
Content-Disposition: attachment; filename="apx.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mnjvqk5p0>
X-Attachment-Id: f_mnjvqk5p0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9rdm1faG9zdC5oCmluZGV4IDk1OWZjYzAxZWUwZi4uOWExNzY2MDM3YjZmIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCisrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKQEAgLTg4Nyw2ICs4ODcsNyBAQCBzdHJ1Y3Qga3ZtX3Zj
cHVfYXJjaCB7CiAJc3RydWN0IGZwdV9ndWVzdCBndWVzdF9mcHU7CiAKIAl1NjQgeGNyMDsKKwl1
NjQgZWFybHlfeGNyMDsKIAl1NjQgZ3Vlc3Rfc3VwcG9ydGVkX3hjcjA7CiAJdTY0IGlhMzJfeHNz
OwogCXU2NCBndWVzdF9zdXBwb3J0ZWRfeHNzOwpAQCAtMjEwMSw2ICsyMTAyLDIwIEBAIHZvaWQg
a3ZtX3phcF9nZm5fcmFuZ2Uoc3RydWN0IGt2bSAqa3ZtLCBnZm5fdCBnZm5fc3RhcnQsIGdmbl90
IGdmbl9lbmQpOwogCiBpbnQgbG9hZF9wZHB0cnMoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNp
Z25lZCBsb25nIGNyMyk7CiAKK3ZvaWQgX19rdm1fbG9hZF9ndWVzdF9hcHgoc3RydWN0IGt2bV92
Y3B1ICp2Y3B1KTsKK3N0YXRpYyBpbmxpbmUgdm9pZCBrdm1fbG9hZF9ndWVzdF9hcHgoc3RydWN0
IGt2bV92Y3B1ICp2Y3B1KQoreworCWlmIChzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9BUFgp
KQorCQlfX2t2bV9sb2FkX2d1ZXN0X2FweCh2Y3B1KTsKK30KKwordm9pZCBfX2t2bV9zYXZlX2d1
ZXN0X2FweChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOworc3RhdGljIGlubGluZSB2b2lkIGt2bV9z
YXZlX2d1ZXN0X2FweChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJaWYgKHN0YXRpY19jcHVf
aGFzKFg4Nl9GRUFUVVJFX0FQWCkpCisJCV9fa3ZtX3NhdmVfZ3Vlc3RfYXB4KHZjcHUpOworfQor
CiBpbnQgZW11bGF0b3Jfd3JpdGVfcGh5cyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdwYV90IGdw
YSwKIAkJCSAgY29uc3Qgdm9pZCAqdmFsLCBpbnQgYnl0ZXMpOwogCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rdm0vcmV2ZXJzZV9jcHVpZC5oIGIvYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaApp
bmRleCA2NTdmNWY3NDNlZDkuLmU0NGNmZWQ5NDE2MCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3Zt
L3JldmVyc2VfY3B1aWQuaAorKysgYi9hcmNoL3g4Ni9rdm0vcmV2ZXJzZV9jcHVpZC5oCkBAIC0z
MSw2ICszMSw3IEBACiAvKiBJbnRlbC1kZWZpbmVkIHN1Yi1mZWF0dXJlcywgQ1BVSUQgbGV2ZWwg
MHgwMDAwMDAwNzoxIChFRFgpICovCiAjZGVmaW5lIFg4Nl9GRUFUVVJFX0FWWF9WTk5JX0lOVDgg
ICAgICAgS1ZNX1g4Nl9GRUFUVVJFKENQVUlEXzdfMV9FRFgsIDQpCiAjZGVmaW5lIFg4Nl9GRUFU
VVJFX0FWWF9ORV9DT05WRVJUICAgICAgS1ZNX1g4Nl9GRUFUVVJFKENQVUlEXzdfMV9FRFgsIDUp
CisjZGVmaW5lIEtWTV9YODZfRkVBVFVSRV9BUFggICAgICAgICAgICAgS1ZNX1g4Nl9GRUFUVVJF
KENQVUlEXzdfMV9FRFgsIDcpCiAjZGVmaW5lIFg4Nl9GRUFUVVJFX0FNWF9DT01QTEVYICAgICAg
ICAgS1ZNX1g4Nl9GRUFUVVJFKENQVUlEXzdfMV9FRFgsIDgpCiAjZGVmaW5lIFg4Nl9GRUFUVVJF
X0FWWF9WTk5JX0lOVDE2ICAgICAgS1ZNX1g4Nl9GRUFUVVJFKENQVUlEXzdfMV9FRFgsIDEwKQog
I2RlZmluZSBYODZfRkVBVFVSRV9QUkVGRVRDSElUSSAgICAgICAgIEtWTV9YODZfRkVBVFVSRShD
UFVJRF83XzFfRURYLCAxNCkKQEAgLTE1MSw2ICsxNTIsNyBAQCBzdGF0aWMgX19hbHdheXNfaW5s
aW5lIHUzMiBfX2ZlYXR1cmVfdHJhbnNsYXRlKGludCB4ODZfZmVhdHVyZSkKIAlLVk1fWDg2X1RS
QU5TTEFURV9GRUFUVVJFKFRTQV9TUV9OTyk7CiAJS1ZNX1g4Nl9UUkFOU0xBVEVfRkVBVFVSRShU
U0FfTDFfTk8pOwogCUtWTV9YODZfVFJBTlNMQVRFX0ZFQVRVUkUoTVNSX0lNTSk7CisJS1ZNX1g4
Nl9UUkFOU0xBVEVfRkVBVFVSRShBUFgpOwogCWRlZmF1bHQ6CiAJCXJldHVybiB4ODZfZmVhdHVy
ZTsKIAl9CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jIGIvYXJjaC94ODYva3Zt
L3N2bS9zdm0uYwppbmRleCBlNjQ3N2FmZmFjOWEuLmMwYTgxNDNmMjc0YyAxMDA2NDQKLS0tIGEv
YXJjaC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCkBAIC00
MzU5LDYgKzQzNTksNyBAQCBzdGF0aWMgX19ub19rY3NhbiBmYXN0cGF0aF90IHN2bV92Y3B1X3J1
bihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHU2NCBydW5fZmxhZ3MpCiAJICAgIHZjcHUtPmFyY2gu
aG9zdF9kZWJ1Z2N0bCAhPSBzdm0tPnZtY2ItPnNhdmUuZGJnY3RsKQogCQl1cGRhdGVfZGVidWdj
dGxtc3Ioc3ZtLT52bWNiLT5zYXZlLmRiZ2N0bCk7CiAKKwlrdm1fbG9hZF9ndWVzdF9hcHgodmNw
dSk7CiAJa3ZtX3dhaXRfbGFwaWNfZXhwaXJlKHZjcHUpOwogCiAJLyoKQEAgLTQzODEsNiArNDM4
Miw3IEBAIHN0YXRpYyBfX25vX2tjc2FuIGZhc3RwYXRoX3Qgc3ZtX3ZjcHVfcnVuKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgdTY0IHJ1bl9mbGFncykKIAkJdmNwdS0+YXJjaC5yZWdzW1ZDUFVfUkVH
U19SU1BdID0gc3ZtLT52bWNiLT5zYXZlLnJzcDsKIAkJdmNwdS0+YXJjaC5yZWdzW1ZDUFVfUkVH
U19SSVBdID0gc3ZtLT52bWNiLT5zYXZlLnJpcDsKIAl9CisJa3ZtX3NhdmVfZ3Vlc3RfYXB4KHZj
cHUpOwogCXZjcHUtPmFyY2gucmVnc19kaXJ0eSA9IDA7CiAKIAlpZiAodW5saWtlbHkoc3ZtLT52
bWNiLT5jb250cm9sLmV4aXRfY29kZSA9PSBTVk1fRVhJVF9OTUkpKQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva3ZtL3ZteC92bXguYyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKaW5kZXggOGIyNGU2
ODI1MzViLi5jNGMwZGE5MjgxYzEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMK
KysrIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYwpAQCAtNzY5MywxMCArNzY5MywxMiBAQCBmYXN0
cGF0aF90IHZteF92Y3B1X3J1bihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHU2NCBydW5fZmxhZ3Mp
CiAJZWxzZSBpZiAoZm9yY2VfaW1tZWRpYXRlX2V4aXQpCiAJCXNtcF9zZW5kX3Jlc2NoZWR1bGUo
dmNwdS0+Y3B1KTsKIAorCWt2bV9sb2FkX2d1ZXN0X2FweCh2Y3B1KTsKIAlrdm1fd2FpdF9sYXBp
Y19leHBpcmUodmNwdSk7CiAKIAkvKiBUaGUgYWN0dWFsIFZNRU5URVIvRVhJVCBpcyBpbiB0aGUg
Lm5vaW5zdHIudGV4dCBzZWN0aW9uLiAqLwogCXZteF92Y3B1X2VudGVyX2V4aXQodmNwdSwgX192
bXhfdmNwdV9ydW5fZmxhZ3Modm14KSk7CisJa3ZtX3NhdmVfZ3Vlc3RfYXB4KHZjcHUpOwogCiAJ
LyogQWxsIGZpZWxkcyBhcmUgY2xlYW4gYXQgdGhpcyBwb2ludCAqLwogCWlmIChrdm1faXNfdXNp
bmdfZXZtY3MoKSkgewpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYv
a3ZtL3g4Ni5jCmluZGV4IDA3NTdiOTNlNTI4ZC4uNjlhYmZkZDk0NmRkIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94ODYva3ZtL3g4Ni5jCkBAIC0xMjIwLDkgKzEy
MjAsMTMgQEAgc3RhdGljIHZvaWQga3ZtX2xvYWRfeGZlYXR1cmVzKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwgYm9vbCBsb2FkX2d1ZXN0KQogCWlmICgha3ZtX2lzX2NyNF9iaXRfc2V0KHZjcHUsIFg4
Nl9DUjRfT1NYU0FWRSkpCiAJCXJldHVybjsKIAotCWlmICh2Y3B1LT5hcmNoLnhjcjAgIT0ga3Zt
X2hvc3QueGNyMCkKKwkvKgorCSAqIERvIG5vdCBsb2FkIHRoZSBkZWZpbml0aXZlIFhDUjAgeWV0
OyB2Y3B1LT5hcmNoLmVhcmx5X3hjcjAga2VlcHMKKwkgKiBBUFggZW5hYmxlZCBzbyB0aGF0IHRo
ZSBrZXJuZWwgY2FuIG1vdmUgdG8gYW5kIGZyb20gcjE2Li4ucjMxLgorCSAqLworCWlmICh2Y3B1
LT5hcmNoLmVhcmx5X3hjcjAgIT0ga3ZtX2hvc3QueGNyMCkKIAkJeHNldGJ2KFhDUl9YRkVBVFVS
RV9FTkFCTEVEX01BU0ssCi0JCSAgICAgICBsb2FkX2d1ZXN0ID8gdmNwdS0+YXJjaC54Y3IwIDog
a3ZtX2hvc3QueGNyMCk7CisJCSAgICAgICBsb2FkX2d1ZXN0ID8gdmNwdS0+YXJjaC5lYXJseV94
Y3IwIDoga3ZtX2hvc3QueGNyMCk7CiAKIAlpZiAoZ3Vlc3RfY3B1X2NhcF9oYXModmNwdSwgWDg2
X0ZFQVRVUkVfWFNBVkVTKSAmJgogCSAgICB2Y3B1LT5hcmNoLmlhMzJfeHNzICE9IGt2bV9ob3N0
LnhzcykKQEAgLTEzMDIsNiArMTMwMiwxMSBAQCBpbnQgX19rdm1fc2V0X3hjcihzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsIHUzMiBpbmRleCwgdTY0IHhjcikKIAogCXZjcHUtPmFyY2gueGNyMCA9IHhj
cjA7CiAKKwkvKiBBUFggaXMgbmVlZGVkIHRvIHNhdmUvcmVzdG9yZSByZWdpc3RlcnMgZm9yIGZh
c3QgcGF0aCBXUk1TUi4gICovCisJdmNwdS0+YXJjaC5lYXJseV94Y3IwID0geGNyMDsKKwlpZiAo
Z3Vlc3RfY3B1X2NhcF9oYXModmNwdSwgWDg2X0ZFQVRVUkVfQVBYKSkKKwkJdmNwdS0+YXJjaC5l
YXJseV94Y3IwIHw9IGt2bV9ob3N0LnhjcjAgJiBYRkVBVFVSRV9NQVNLX0FQWDsKKwogCWlmICgo
eGNyMCBeIG9sZF94Y3IwKSAmIFhGRUFUVVJFX01BU0tfRVhURU5EKQogCQl2Y3B1LT5hcmNoLmNw
dWlkX2R5bmFtaWNfYml0c19kaXJ0eSA9IHRydWU7CiAJcmV0dXJuIDA7CkBAIC0xMTA1Niw2ICsx
MTA2MSw0OSBAQCBzdGF0aWMgdm9pZCBrdm1fdmNwdV9yZWxvYWRfYXBpY19hY2Nlc3NfcGFnZShz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCiAJa3ZtX3g4Nl9jYWxsKHNldF9hcGljX2FjY2Vzc19wYWdl
X2FkZHIpKHZjcHUpOwogfQogCisvKgorICogQXNzdW1pbmcgdGhlIGtlcm5lbCBkb2VzIG5vdCB1
c2UgQVBYIGZvciBub3cuICBXaGVuCisgKiB0aGUga2VybmVsIHN0YXJ0cyB1c2luZyBBUFggdGhp
cyBuZWVkcyB0byBtb3ZlIGludG8KKyAqIGFzc2VtYmx5LCBhbmQgS1ZNX0dFVC9TRVRfWFNBVkUg
bmVlZHMgdG8gZmlsbCBpbgorICogRUdQUnMgZnJvbSB2Y3B1LT5hcmNoLnJlZ3MuCisgKi8KK3Zv
aWQgX19rdm1fbG9hZF9ndWVzdF9hcHgoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQoreworCWlmICh2
Y3B1LT5hcmNoLmVhcmx5X3hjcjAgIT0gdmNwdS0+YXJjaC54Y3IwKQorCQl4c2V0YnYoWENSX1hG
RUFUVVJFX0VOQUJMRURfTUFTSywgdmNwdS0+YXJjaC54Y3IwKTsKKworCWlmICghKHZjcHUtPmFy
Y2gueGNyMCAmIFhGRUFUVVJFX01BU0tfQVBYKSkKKwkJcmV0dXJuOworCisJV0FSTl9PTl9PTkNF
KCFpcnFzX2Rpc2FibGVkKCkpOworCisJYXNtKCJtb3YgJVtyMTZdLCAlJXIxNlxuIgorCSAgICAi
bW92ICVbcjE3XSwgJSVyMTdcbiIgLy8gLi4uCisJICAgIDogOiBbcjE2XSAibSIgKHZjcHUtPmFy
Y2gucmVnc1sxNl0pLAorCSAgICAgICAgW3IxN10gIm0iICh2Y3B1LT5hcmNoLnJlZ3NbMTddKSk7
Cit9CisKKy8qCisgKiBBc3N1bWluZyB0aGUga2VybmVsIGRvZXMgbm90IHVzZSBBUFggZm9yIG5v
dy4gIFdoZW4KKyAqIHRoZSBrZXJuZWwgc3RhcnRzIHVzaW5nIEFQWCB0aGlzIG5lZWRzIHRvIG1v
dmUgaW50bworICogYXNzZW1ibHkgYW5kIHplcm8gb3V0IEFQWCByZWdpc3RlcnMgZm9yIHRoZSBo
b3N0LgorICovCit2b2lkIF9fa3ZtX3NhdmVfZ3Vlc3RfYXB4KHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSkKK3sKKwlpZiAodmNwdS0+YXJjaC5lYXJseV94Y3IwICE9IHZjcHUtPmFyY2gueGNyMCkKKwkJ
eHNldGJ2KFhDUl9YRkVBVFVSRV9FTkFCTEVEX01BU0ssIHZjcHUtPmFyY2guZWFybHlfeGNyMCk7
CisKKwlpZiAoISh2Y3B1LT5hcmNoLnhjcjAgJiBYRkVBVFVSRV9NQVNLX0FQWCkpCisJCXJldHVy
bjsKKworCVdBUk5fT05fT05DRSghaXJxc19kaXNhYmxlZCgpKTsKKworCWFzbSgibW92ICUlcjE2
LCAlW3IxNl1cbiIKKwkgICAgIm1vdiAlJXIxNywgJVtyMTddXG4iIC8vIC4uLgorCSAgICA6IDog
W3IxNl0gIm0iICh2Y3B1LT5hcmNoLnJlZ3NbMTZdKSwKKwkgICAgICAgIFtyMTddICJtIiAodmNw
dS0+YXJjaC5yZWdzWzE3XSkpOworfQorCiAvKgogICogQ2FsbGVkIHdpdGhpbiBrdm0tPnNyY3Ug
cmVhZCBzaWRlLgogICogUmV0dXJucyAxIHRvIGxldCB2Y3B1X3J1bigpIGNvbnRpbnVlIHRoZSBn
dWVzdCBleGVjdXRpb24gbG9vcCB3aXRob3V0Cgo=
--000000000000db6bc9064e9b897a--

