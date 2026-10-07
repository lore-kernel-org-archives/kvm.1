Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59749B1FC
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371932; cv=pass; b=smaDNR8xVVmyaLHaCswkqeAYX9sDhw3ojDf7gMS6lyfmSoDrVtiYtNGuSYlXJIVny9myxMQ4yT2TT0UuobK2m/U6WxR3bWQtxlPCLTOt1IN6/KhobqW8VhlfktPqu4KoDgplLfNK2aULkfaRcTOikv1KkYXlvyk7o5F4T++Y+0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371932; c=relaxed/simple;
	bh=15MfhKy4clnihufpUM2lv7a5emZi1Pg04u4PTy2QoMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtXJp3/f4TfeMU94nGvCTR3mXPnbvVGdLQ+NFMi47DAE0rcOThxFFsotYrv67xEJin1NTz6ibdIV45vLevau6hmzA6R8nBFu+xicTIpHATX8voG/uaiWd/30o8nB13E6tgMCPIx06Mk/jO7PDbFqRMORVFYiguLbew+7Czx2Rh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaCnG2Ww; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1vyCb+O; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaCnG2Ww";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1vyCb+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791371900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Kt0cEXXkZaJKRQTQU2oPrws+LiLDtl87//9ntMPha4=;
	b=YaCnG2WwiBkC5gOnTDzqZfRh1BI19wY0DR+AhjkU7sSg8ZCUQegsuFM4Mhmc+oY30JOvR9
	6BQUE/WpOZhQ5Kyn51Km8/DiPFv2NGAB6EPCsfhM2BSWioXWqBDnkZ3/+t1useNl+pEOXQ
	ao3cA+HmJlhOJ46EjfZipJZTo1GrUK8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-UVJLZEHSObuH62rExjLWnA-1; Wed, 07 Oct 2026 07:18:18 -0400
X-MC-Unique: UVJLZEHSObuH62rExjLWnA-1
X-Mimecast-MFC-AGG-ID: UVJLZEHSObuH62rExjLWnA_1791371897
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c437ae7dbso1617301f8f.1
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 04:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791371897; cv=none;
        d=google.com; s=arc-20260327;
        b=UvPFP5yodS7i5Py62EsmG/A7YimKaQ4qyGkFKT2xjdhKxNb9Dw0DV2i2piy2+MyKmM
         prsAyTHm9kOln+qE+s31Lm//sNCItgaNtrW1XdE4uYlXCNirGWSDjtMlZ5jhuhAr/26X
         v1oMPmOr395fl9btqTuH1Gm5KtWewRTfOzMr7xdyxSqMbGZfdSTErAMIIEud5ijgePKm
         m1YKEbgXe+5idG8ShWVbTUISF+5eYy+HDNrodNz+LDkNe3GA6l2FQubHD1nz4VYQFisE
         3f1gVkC+owytjZspsDHc9Sca0OzLrgbXcsEnClGqixxY6VbgIFVv20hmy7k6qV98euYG
         Xavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4Kt0cEXXkZaJKRQTQU2oPrws+LiLDtl87//9ntMPha4=;
        fh=5dJ5JTbViu1Zsid35WbQBqqhegziNgc6XyqFJNbey+o=;
        b=Y3jxy1uvihazZPI6iP4tsmqr00DnyDNocqqMEv0zs/Svjm7rtKPQqamd9m8c4UdSFl
         SdWEaHnWduvb+y0FerazJrkf9xLsYDQgeoT6yKzn5vDZKSqixeQnEJ3rsvFDxUOCGTXE
         /GRAIBpmxn9ErBEQPrE03wbrdwDO4RO24EshBDbOm6ivuXiAU2ZUov3RTYOf6CtHavXE
         d/U0hYzLIiR9PQE6u3HSVGMWwdQhpLJqk7V2sQFbWNXP8FLb58XmB3FgsviiDWGyK4Dr
         9jDYTT/F16msvWroT8f7C8xmz3YhBL30BXF7biHWKD6VqWRYP/Q9ed6dxMLgZJ2ZIueo
         RvpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791371897; x=1791976697; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Kt0cEXXkZaJKRQTQU2oPrws+LiLDtl87//9ntMPha4=;
        b=P1vyCb+OvBDLqwHHtxTMdn2D1w6D3TeWD9Z4dB6UDj1HpjD1IuPNi2s/ZEcnulDD4a
         SYP2aUh3HtopNkb6JQSayUkCgI8NqJsMLkzARQwHbtWiFLqcHXstnQdndrPyWqyeNV8C
         jd+YMllXUsEAKGxw3FhSuin5ljPw8zqEj16U1JI+M5SqVme6nElnPSbSn4MgbRHQxKp0
         iQfp0r9kjDrxdZZScKYli5Nk9fcrXkDF7qvgPov6DzVQmsvUfZ7LvRtPOdFaTKkmdwj/
         HvI6tQ5iyYzn03/vZHLCodv4hINZNln0puNWGqMy+gdQsIRQkYvnSYpl7sjc576XKh23
         91ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791371897; x=1791976697;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4Kt0cEXXkZaJKRQTQU2oPrws+LiLDtl87//9ntMPha4=;
        b=0nJNGUjvb6ZYCJOXHpJLZS8ik6koKDWcQhSOy1T2ZMxmPEo8vt2J9Ylw9jE+N/oV1Z
         pk7NpvOH4tzThZsmjg9/lOWqPXz9DUBH1xrLUPjF5Cxb+cp0nwNUChud8BLOKfApKIJi
         ZUOyWDzZeeRBDzqpYaSohjB8b+3d1hln4ddelx0ZAHQWqvNKyVWQ9ttXxgD51MVhLiXs
         ehxTCfqHOSUo4EZAQdUO5fLac/OS910Dt6JSbzt49HPz7XcjQJRKrYYkYr6AyFJjm6JM
         JqIxJliBdSGA+JEPt6adg9cNAZhCtGAdSJD0z/Z3X8jl3KUQanofc4E9xCgLHzEyL0Gg
         ci3w==
X-Forwarded-Encrypted: i=1; AKwUvBxgcwQHwrRZlujSd+AXWHCe2HWfIqd8NSvxqKLsBa/KcKXgiQ+CoNapCcw9SYklOfUvAEI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4ue04fd31KHbmlbN8ZbOMi/QDPh6iI3qMqJOKZQ4mnWCVn9ci
	0GGleKw9uFDW99UVIxNLaTa+2OeR2nVmshjCnydnLD/poFiNOeT+smMokty1XKCNq1cFXPzwSZT
	NckSxSlSIpByfzodDDv/OvUwsqY9hVvwNpkLieyW/ufTM4rgNliinGZZURoGjEaU5wnZgec4/Rt
	/0ceyMy/W91WhGb1z+MJqgJWFAVKYG
X-Gm-Gg: AYBFou1Nr5KIrEohrpCmY7p31quMi8FUKT82xVdEpntEJhmnnUcE8yEw13rWElgt6uN
	XSnmGUeC/Rjel2HhkdaIJg6it2Klt4RFtPGw+DzYBFlJykzWTJhD8+ubjc/fTIrWowCqc+I6Mqe
	iT7U/J0q2WK1u0JUtTnONirjTMH+WpVtWVuiI1rDq7rpKjqNkezPKhmiwbr+sLZPLG/kMazy7ms
	9h/H4Ym135l1BMLypLylB5ZGuzwL8lVq65yjySlfip0uaY83PUPy/0g6Qs=
X-Received: by 2002:a05:6000:3cd:b0:48c:69b3:6114 with SMTP id ffacd0b85a97d-48c69b362fdmr10420074f8f.3.1791371897553;
        Wed, 07 Oct 2026 04:18:17 -0700 (PDT)
X-Received: by 2002:a05:6000:3cd:b0:48c:69b3:6114 with SMTP id
 ffacd0b85a97d-48c69b362fdmr10420012f8f.3.1791371896962; Wed, 07 Oct 2026
 04:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <asUqYEisPp9MJ8mQ@rika.bernkas.tel> <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
In-Reply-To: <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Oct 2026 13:18:03 +0200
X-Gm-Features: AclHuK8CoQxW5s4Obw7KWlVyYHn9uj7JzMDejgQI7kJC0bFp1IqPraLVx3Njs9k
Message-ID: <CABgObfYMRUzDSUPY7MMp2fbRbU+eMCdDVZT9vQxUcT_Bwm9z_Q@mail.gmail.com>
Subject: Re: [REGRESSION 7.2, BISECTED] KVM: x86: Starting Windows guest
 triggers UBSAN: array-index-out-of-bounds
To: SimonP <simonp.git@mailbox.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000946b08065d3e454f"

--000000000000946b08065d3e454f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 1:16=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On Tue, Oct 6, 2026 at 7:37=E2=80=AFPM SimonP <simonp.git@mailbox.org> wr=
ote:
> > Hello,
> >
> > See subject. Happens in permission_fault() on line:
> >
> >         fault =3D (mmu->permissions[index] >> pte_access) & 1;
> >
> > Some output from a printk I added, not spammed but keeps happening:
> >
> > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
>
> Can you confirm you are using nested virtualization, and if so what is
> the L1 hypervisor and L2 guest combination? Also what is the processor
> model?
>
> The issue is weird; it is caused by the SS bit which is apparently set
> in the #NPF exitcode; but it shouldn't be unless bit 4 is set in the
> misc_ctl field, and KVM never sets it. Can you check if the attached
> patch fixes it (modulo the fact that it shouldn't happen in the first
> place)?

Attachment added now.

Paolo

--000000000000946b08065d3e454f
Content-Type: text/x-patch; charset="US-ASCII"; name="not-really-fix-npf-ss.patch"
Content-Disposition: attachment; filename="not-really-fix-npf-ss.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_muy0jjgk0>
X-Attachment-Id: f_muy0jjgk0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9tbXUuaCBiL2FyY2gveDg2L2t2bS9tbXUuaAppbmRl
eCA0MGRjYmNiYWUxNzMuLmVlZTdlZGJkOWM2ZiAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL21t
dS5oCisrKyBiL2FyY2gveDg2L2t2bS9tbXUuaApAQCAtMjc1LDggKzI3NSwxOCBAQCBzdGF0aWMg
aW5saW5lIHU4IHBlcm1pc3Npb25fZmF1bHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qg
a3ZtX3BhZ2V3YWxrICp3LAogCQkJCSAgdW5zaWduZWQgcHRlX2FjY2VzcywgdW5zaWduZWQgcHRl
X3BrZXksCiAJCQkJICB1NjQgYWNjZXNzKQogewotCS8qIHN0cmlwIG5lc3RlZCBwYWdpbmcgZmF1
bHQgZXJyb3IgY29kZXMgKi8KLQl1bnNpZ25lZCBpbnQgcGZlYyA9IGFjY2VzczsKKwkvKgorCSAq
IE9mIHRoZSBlcnJvciBjb2RlcyB0aGF0IGRvIG5vdCBjb250cmlidXRlIHRvIHRoZSBpbmRleCBp
bgorCSAqIGZtdC0+cGVybWlzc2lvbiwgUEsgaXMgbm90IGluY2x1ZGVkIGluIEVQVCB2aW9sYXRp
b24gYml0cyBhbmQKKwkgKiBub3Qgc3VwcG9ydGVkIGJ5IHNoYWRvdyBwYWdpbmcsIGFuZCBSU1ZE
IGZhdWx0cyBhcmUgaGFuZGxlZAorCSAqIGVsc2V3aGVyZS4gIFNTIGhvd2V2ZXIgaXMgaW5jbHVk
ZWQgaW4gdGhlIE5QVCBleGl0IGNvZGUuCisJICovCisJdW5zaWduZWQgaW50IHBmZWMgPSBhY2Nl
c3MgJiB+UEZFUlJfU1NfTUFTSzsKKwlpZiAoV0FSTl9PTl9PTkNFKHBmZWMgJiB+KFBGRVJSX1BS
RVNFTlRfTUFTSyB8IFBGRVJSX1dSSVRFX01BU0sgfAorCQkJCSAgUEZFUlJfVVNFUl9NQVNLIHwg
UEZFUlJfRkVUQ0hfTUFTSykpKQorCQlwZmVjICY9IChQRkVSUl9QUkVTRU5UX01BU0sgfCBQRkVS
Ul9XUklURV9NQVNLIHwKKwkJCSBQRkVSUl9VU0VSX01BU0sgfCBQRkVSUl9GRVRDSF9NQVNLKTsK
KwogCXVuc2lnbmVkIGxvbmcgcmZsYWdzID0ga3ZtX3g4Nl9jYWxsKGdldF9yZmxhZ3MpKHZjcHUp
OwogCiAJLyoKQEAgLTMwMSw4ICszMTEsNiBAQCBzdGF0aWMgaW5saW5lIHU4IHBlcm1pc3Npb25f
ZmF1bHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3BhZ2V3YWxrICp3LAogCWt2
bV9tbXVfcmVmcmVzaF9wYXNzdGhyb3VnaF9iaXRzKHZjcHUsIHcpOwogCiAJZmF1bHQgPSAoZm10
LT5wZXJtaXNzaW9uc1tpbmRleF0gPj4gcHRlX2FjY2VzcykgJiAxOwotCi0JV0FSTl9PTl9PTkNF
KHBmZWMgJiAoUEZFUlJfUEtfTUFTSyB8IFBGRVJSX1NTX01BU0sgfCBQRkVSUl9SU1ZEX01BU0sp
KTsKIAlpZiAodW5saWtlbHkoZm10LT5wa3J1X21hc2spKSB7CiAJCXUzMiBwa3J1X2JpdHMsIG9m
ZnNldDsKIApkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21tdS9wYWdpbmdfdG1wbC5oIGIvYXJj
aC94ODYva3ZtL21tdS9wYWdpbmdfdG1wbC5oCmluZGV4IGRjMDE1NWVkMWNiZi4uYTFhZmUyYWUy
OGNhIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vbW11L3BhZ2luZ190bXBsLmgKKysrIGIvYXJj
aC94ODYva3ZtL21tdS9wYWdpbmdfdG1wbC5oCkBAIC01MDQsNyArNTA0LDcgQEAgc3RhdGljIGlu
dCBGTkFNRSh3YWxrX2FkZHJfZ2VuZXJpYykoc3RydWN0IGd1ZXN0X3dhbGtlciAqd2Fsa2VyLAog
CXJldHVybiAxOwogCiBlcnJvcjoKLQllcnJjb2RlIHw9IHdyaXRlX2ZhdWx0IHwgdXNlcl9mYXVs
dDsKKwllcnJjb2RlIHw9IGFjY2VzcyAmIChQRkVSUl9XUklURV9NQVNLIHwgUEZFUlJfVVNFUl9N
QVNLIHwgUEZFUlJfU1NfTUFTSyk7CiAJaWYgKGZldGNoX2ZhdWx0ICYmIGhhc19wZmVycl9mZXRj
aCh3KSkKIAkJZXJyY29kZSB8PSBQRkVSUl9GRVRDSF9NQVNLOwogCg==
--000000000000946b08065d3e454f--

