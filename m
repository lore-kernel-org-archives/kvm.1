Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792755579;
	b=Y6FkM3+Be1rFi/IPF5vgYJXjQ1td2MFJdWft8Ik7cq6/ii5/boyLkL2R+S3yskiCLitD
	 kiIBQWJg3c3cOkbtBxMEdOJwPHPFMLCBl+5NcnbUzCH6OzD/0787sdmAfctYj60YbBMEr
	 McPKXd7Qj399oJucYOl+ZhV39Or1pvblrhv9g3z/K/SVXu730PAp/SjEF4Z9+WFSLpq8S
	 Ue1ZyPSFDVeTcZiOMRZVEX1QXczeg0Z/M/1dVyxhV6pUyk8RB7YZ1kMof7jgARgkIHSz6
	 MS8BiUsERvy/463Zj+JQqLuvlfNgJEDBNXUgUxZNCtu8DKorVe2EEwaIR1tLykPteuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755579;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
	b=vQg5rvRSisincSCzNBjAlNKRit1tMsxOdPYqvWz7Pp2tvubVu9dr3+XoUr7a25O4kMnf
	 mNP+9ixaaZltBNvimlg3X/tpI/48KKtU3odOuC4ggzR3B2VuY/59846ov3uyy8q+CnNdn
	 Sil6WbFG/puVDj3H6eg3Cy+Sjpg80dFDbsjXxp9GFvtrdb6T8yAp8c5/VP1HonPRa94bx
	 kl4gp1IxVxFl9B9iYJGFB5g7eio1RmeRSegzq/dtc4sd6TZ2VXrJRoAKn7jOFIcdr8pcp
	 TWiGwBUJPKE3lJVmDfyhuUlFWIKSnTIv88N+uQrDQ1EqDWKN/Wrq+zoj32iOQXYc6Yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aqa7FbgG;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DRCnFZXy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B695606A31D
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 11:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B695606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aqa7FbgG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DRCnFZXy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792755578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
	b=Aqa7FbgG+y24GyAqMkXLrjublyxPemhdCvGAybNmKiR0JKJIM08rOFmhz8RUPT1S/oPtcE
	HvSEb2nUL8qJ9Ls9q2l3yzRH67H9Ig26L5X7U1MskK4yPoe81aDBWD8moPnxVR2Eb7K+dq
	zgiflRKszSi4EgaHr9Ory7liolUJzF8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-oNeTWMYwP1KRlK_dzr4XTQ-1; Fri, 23 Oct 2026 07:39:36 -0400
X-MC-Unique: oNeTWMYwP1KRlK_dzr4XTQ-1
X-Mimecast-MFC-AGG-ID: oNeTWMYwP1KRlK_dzr4XTQ_1792755576
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab868fe362so1354370a91.2
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 04:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792755576; cv=none;
        d=google.com; s=arc-20260327;
        b=BVAL3PW0k7p2P0pfLhtPbDK3BxRnSYGMpGfhDCiN0PfysvgpeGjNu2R1BA3CpH3kgN
         XZ5OWKWzO2V3sRpgE1Zr8xeRicuuMBBQ/EC9SQqPB/dihn+iJ1s2m0gW90I9HtBabLUm
         VKEOBlhofW1eUKuQ0WqrzVuH3DsUB+R9ip7uKsNB6raJZwgXgfr+JW1WBM/FcRtJqcl1
         xn+QAb4CAgr8FIQg62LSsJOgOeIeV4dg0mJGcEeVSlyh+B8ZvS6v+7YGRd8806s0/TTa
         t4UJSGsvGneAUjmc6iceGjoSUau9JNVCTK3eD5u3rTqYyWMJ+ru0+HFsYgTwpdRotqT7
         /JCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
        fh=e42n8KD6GjAa9B7HVlzibtTwdLDMsCMMseUGxey+CWQ=;
        b=o+G1vZUIA1kq8FmdmFfBKbpY7CALK4I7E7eTpxSqq9NS5zxjK01bnxDIc+Er6Xq92t
         GpU0i3aVo9w6HT2Feuj84dmOiQvJxuhjYH52Q4LrbSuAZYi1RZK0lCCZPTh7Mc5RAjRG
         h0ra+6I2AJIxgww3SemLd9+jE645WelR9l/NQcJoI4PRPuOryEUmXhxU5tXDGdrJTCKY
         2y/P/a/O6kWouZu+YA5YuaxFeY73//2rkoXJAmbR9m33PK4lfHLalz5hK/0cyTLH+o7g
         FjXI/tkZ4gO+/5oc1oTMnYmdc+kakI/I5MSi1ywQEe4aSYhrWLY36vx9OD5Cc5sHHP+q
         QWSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792755576; x=1793360376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
        b=DRCnFZXyLuufz0XPaKfHziItzBqZktKF+JC+khEGBsCpNlVYHdHBflWWLpNiwBQI42
         Kg9Qq0W4tYpsPFhZENgZtozyCRowOo5IUmFZtfibaM8mlTsjva9e+28zN3iGXl26viaJ
         PqXDZI5vVGRJW/E8p8EwXRQgGnrlZAXIhougfZ13wAYF2DIETllhbGuXWL64vwiWHyRJ
         tqGWS3nLf1lqzQeqIIJTmhhPvTzoe2jnUiftCqSEhn3fQS8Y+JsJp5ePMZQ/Tzj1Slci
         SoJ4uuV7uy1qVAWmvVA5gOZFEfszAnU0IWoroHf+IK3nLmkov3Bol8IGPrMa01UgpMVB
         iESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792755576; x=1793360376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
        b=k5ZH17fJYcW/egw9lPwua9MZjUPZJHtXfxPKHbH/SEWwWxeR9ZCi0gFn5ar9FuLXqR
         okCQAs5VAZZCg/XrVHi/XqMuRWUeXsPXwHkcrB9WbwWG2mKLJqG0nn5RULggjgj8AYwx
         8TstWReMQ25zIv2K3I3oljJ1hxEXwun/BGlTMRWYDPxXX1/ZX2fLtxrp6Tsq2n2bOAjv
         Wc4wrPGHXKkYMj/SkgJYID/nX6KLiX9gBeoWQg0ov0QZUbqBNDMjZzir57BjErxonbBG
         5bELqvjo/ULDsbmVWd2aqyBogda9BFHjSOYE/c65o1SZ9tuJB7+OjCRktrkZsOxn6tmh
         Ncyg==
X-Forwarded-Encrypted: i=1; AKwUvBwKABJS/5avxOOfU7Gekwv3ckxwV4Dt1sIlFIA/r4JWkkzifdSy+c99wGRGck426qM70TY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvPOseiNmYVSivPr3WgLo/kUWq/G6ikKaR4auwrKIpSxtGvX5Z
	a+q17Iq1uPSRO8CVeBdK88JJQKfhByN8YCsTAVqSp2Ozqra41pWV77II544VzjliLVvfXuhrmOC
	KjueQ28A1ahp3kTlLT7jmKCEyL68yAprJv+35Pj9LNIQfg6mLKhLrsoH+CeZuZZcM2Z2XUEcZ7c
	uQG+tMDEARjzAWJw5yPfS+PTDqTPSa
X-Gm-Gg: AYBFou292QH4RKDWnYVwsMo8EccSAaugnuVzZaseid0XeGYULPBxIOqo3dI0sEpbCj9
	ypJ7PwYMlgh5I66xj6pn93bWquVEmBwx4b9EOJUyUfSHKBXrAo8AAAPgRtcENfFw/ruY5Wm+5Ym
	m9NtgPCTzetGs41ko3mb1M+lqGAyMQYWe05ODiXuq+kL1lCXOx/1GaIy8EiL2xGWyIh0x6h/ESf
	7erJeXNxT8rAPGPnVW4kaQVxhnVgubg1AzaPMC0oF77vljZywhc80oNk9r6LpNUHp1UbYVKOhM0
	2A==
X-Received: by 2002:a17:90b:4d06:b0:3ac:ffb8:1809 with SMTP id 98e67ed59e1d1-3adce45dd72mr1525600a91.39.1792755575424;
        Fri, 23 Oct 2026 04:39:35 -0700 (PDT)
X-Received: by 2002:a17:90b:4d06:b0:3ac:ffb8:1809 with SMTP id
 98e67ed59e1d1-3adce45dd72mr1525520a91.39.1792755574796; Fri, 23 Oct 2026
 04:39:34 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <20261020-qom-qapi-v7-54-431a86b02b58@redhat.com> <atsxLV5YZo8dr-8G@redhat.com>
In-Reply-To: <atsxLV5YZo8dr-8G@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 23 Oct 2026 15:39:22 +0400
X-Gm-Features: AclHuK9JciU6rOmPmxGP7LAL0cKom9fJOgwoGNnQZ4aTaCAv64YMDSwyPsEK5ck
Message-ID: <CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
Subject: Re: [PATCH v7 54/65] qdev: adjust PciDevfn declared type
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
	Peter Maydell <peter.maydell@linaro.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jason Wang <jasowangio@gmail.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
	Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
	Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jagannathan Raman <jag.raman@oracle.com>, 
	John Levon <john.levon@nutanix.com>, Thanos Makatos <thanos.makatos@nutanix.com>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
	Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, linux-cxl@vger.kernel.org, 
	qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
	qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
	Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
	Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
	Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
	Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
	Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
	"Gonglei (Arei)" <arei.gonglei@huawei.com>, zhenwei pi <zhenwei.pi@linux.dev>, 
	Ani Sinha <anisinha@redhat.com>, Luc Michel <luc@lmichel.fr>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
	Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
	FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
	Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
	Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
	Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Conor Dooley <conor@kernel.org>, Sebastian Huber <sebastian.huber@embedded-brains.de>, 
	Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony@xenproject.org>, 
	Peter Xu <peterx@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>, 
	Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
	Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
	Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
	Tao Tang <tangtao1634@phytium.com.cn>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
	Fabiano Rosas <farosas@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
	Artyom Tarasenko <atar4qemu@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>, 
	Jiri Pirko <jiri@resnulli.us>, Eric Auger <eric.auger@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 23, 2026 at 2:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Oct 20, 2026 at 02:46:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > PciDevfn is a bit special, since it accepts integer and string as
> > setter, but only output integer as getter.
> >
> > Unfortunately, we can't declare an alternate str|int QAPI type for it,
> > since: branch 'string' can't be distinguished from 'integer'
> >
> > Rather than declaring it as "str", use the common type instead.
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/core/qdev-properties-system.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties=
-system.c
> > index 5bfdfe1ab9d9..3381de1144d6 100644
> > --- a/hw/core/qdev-properties-system.c
> > +++ b/hw/core/qdev-properties-system.c
> > @@ -904,7 +904,8 @@ static char *print_pci_devfn(Object *obj, const Pro=
perty *prop)
> >  }
> >
> >  const PropertyInfo qdev_prop_pci_devfn =3D {
> > -    .type  =3D "str",
> > +    /* The formatted string accepted by the setter is a CLI convenienc=
e. */
>
> IIUC, this is not limited to the CLI, it will work anywhere the JSON
> syntax is permitted which is both CLI and QMP.
>
> libvirt uses this string syntax:
>
>   -device '{"driver":"pcie-root-port","port":9,"chassis":2,"id":"pci.2","=
bus":"pcie.0","multifunction":true,"addr":"0x1.0x1"}' \
>
> > +    .type  =3D "int32",
> >      .description =3D "Slot and optional function number, example: 06.0=
 or 06",
>
>
> Changing the type to 'int32', where 99% of usage is input only
> and string based, is pretty unpleasant. Even more so that the
> description doesn't even mention encoding dev+function as an
> integer.

This is purely a metadata change, the setter still accepts both str &
int, so I don't think this change blocks this series. But I agree we
could do better.

There are multiple options. We could keep declaring the property as
str instead. In this case, the getter should probably return a string
for consistency and correctness. This might surprise some existing
users though.

We could introduce new properties like `devfn-str` and `devfn-int`
that alias the same value.

We could also introduce a new structured QAPI type.

Markus, what's your take?

thanks

>
> >      .print =3D print_pci_devfn,
> >      .get   =3D qdev_propinfo_get_int32,
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

