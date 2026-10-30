Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793362289;
	b=guIZcWAImPiTWxtMILk6F7wWOFe/sXkA5l1HtRdbBJTKfnLXZEW/Rm0qNTQ2GsoWyxFq
	 KSa5Hqpos7pWIqbG//KexmQR8V5KZpb6AlcqbtFnjUg6TIm8JO8zKoqawteuP3qOMs0Fm
	 vOYVoK+mpJtixaJk8Gz8rF26za+emb25mwDiOSIjGP3gtYeek5Mh+kHjzu1eNts2qMj5Y
	 beULiueIhI5zrwGrMYsaCnsZeSM+gcGSoHj8gOwqVjopQhPtE9akT19bOx03oQ2OOeqGK
	 ITJhfeo/mUcM8lQjf598/PQtCKj4RYN9jj5YNWFTMgARr1rKdbzX45LdUJRbXgPyy5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362289;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
	b=30g4AeW4Ape3IWFUm9Aa2/lAJfegI8SPcNrNHHiRWjcQtNrsAstDTo71043kkWlxyTVC
	 9Ih1ynZEZyEurm7wuTSW4Q50Y1P2PoggV9CUEJCpiPrTW2jO6PEG5p3ZvmXTpFW9nNTw5
	 wcdfQqM86eYC06kejFnhA3V+TDtMF8J5wN+MJdSN956+nPny4Wpa/n+U5rqmkozf96UoV
	 NEog+odkiRgxcEijndjjuGpJr1SWv/7nHEo0YbpDjihyVf5DuzRQwzheqc4g3pIYYobr0
	 5LKZKlG/ER+z1AJ233vUm8NCPK8ZZCWapq/HpEXBChtHPHCgjUHI5wn15+kp5ADzKFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQOa9Uir;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=V36OEiHH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507D606A320
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 12:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2507D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQOa9Uir;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=V36OEiHH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793362288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
	b=DQOa9UirA6se8ZCtd6+NTOnhD+doNcFc0nnF7SrxG0Z5hU6s9serkhqSYEbgiXgwZw06OF
	hZgx5XaA3oeXgcATPEpShBrCsyeOnFA/WaOQiZUlSliLje0nVI6mY7COfw+SoFzZpyXpMB
	6EFPzdJC+ekBxnQl7+b8bjR/3OIUOMI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-XJZQh7vePoitgEETa5DfXQ-1; Fri, 30 Oct 2026 08:11:26 -0400
X-MC-Unique: XJZQh7vePoitgEETa5DfXQ-1
X-Mimecast-MFC-AGG-ID: XJZQh7vePoitgEETa5DfXQ_1793362286
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so618007a91.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 05:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793362286; cv=none;
        d=google.com; s=arc-20260327;
        b=pILBb87NhXF3qZqAZMqru9DrfEpqELdSXZ2+HGHAMlHukQoXgnTcRLvU6kdqJ4wcPB
         /9LPMg+VSErT4x8ZbvLiRD6Dwy+/eSwI3FHiY9T49QDqnXcNgYkwyNI9Tm07/aQUmJgQ
         3cYn2+z4IA2EY5BIRAo5IeEhHYlyeceSppUEE2h14GmldzKpyAoSCR9LmL7ZvKC6sO95
         vUTeQAG/sAbnqxNNPl9uiknqq4eY59NT8q3/rDjgsecV1ArXlveYVlvSQyiTx7mSqd9p
         I+ANOF7LQs0y85hwEtU93xZXJKefkmiuI2MeJ71h2WLzDw4b2VIwWWzmaGEesCQJH01x
         RBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
        fh=9PN4DmpWaetDxWyshJ4gKy2QLIyLVyeTi+qCQMXCJGE=;
        b=k4UyC9c01rdoR2al7f3ns8L4EiR5deuhQRzrdEmsAZ5vE3c0P8wd2dajlVAshsev7V
         BcOYqdP0ORTezJnmhL5rz585qqFdquS78EvyBa1FqyB7756s13CI9Z0ipyW/vWOcRgXO
         thPN8fW4t3IsMK5I3j+D+eoInFpyrmNyVbx1JfOK9Pbv8378E0NcOqzABns+tlFiNSx+
         ODeIb3bRDsdVip1H64PjeEuDQhov5XYpcqR15baLiw9lIhJgVXrQ02S3RDK9keac/WLZ
         GuskTKBj/DI0a/XLXT3D22P2NSbkMm/n/LH9ZKPEw49e6jN/HTyvHlbkB3fWAhM5uSOc
         JU3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793362286; x=1793967086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
        b=V36OEiHHdiKHTXDdNgzBL4O88CWoAs8KSDRHsXh4aDrSU8E0aHoWFzGsa6CTSYeWrs
         qIYZzSomCRneqwgBh+VN0r1pD1IbN5QeEwyKmvk/2hI4khrjh6Rxtn5A8n6ax0/tUoM5
         llTLUWn0g8ldKR9Aga+xIDYrPZ6hG+WLa+4a0uVMUJPvnkpZ25jNSRp9uamRFwWD7ucQ
         HWZWlx8xa8J13m9FArvGK0mecMpnBY2uDX62KiOq5e4LMd3KbZFhN7MW5p3fHK9B+SPA
         zOQeB6hM4EhKNY18/8sSJ9ZvdtgqppMbUn0AVeE57qNZuT+uDdQSECMjNwmSwW7H8el0
         AkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362286; x=1793967086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
        b=iDJEoR7KAs4cbDKCjt2pkprvYCtO98668k3j0Iv03lYuRtcrCAKoJEKQX2l34Gli8q
         EhgAaowO7icVASnI45FVa5QOmh1Kw2CcrbXxTjz+tROs7LH7DVkjNsByh4uDDWEh1vhm
         w359UQ3QcQPsR5JNK72s6rWGYpwoUVShijXGh/0m4jQtLzg11TD4F8SNuUm51LrkSSek
         Y2b/+aOqBk83lyJQckmb/q+gZGNvL0pZ/4JhxmrtR9R+IpiavVvc7mNVqgo93m3x9q7f
         SEG7e413Ec1KvVehaoYMhm5LyunWPzoXM4hjMs5NHW9NURpPfnkpKdIXP4TqMhwRqSNB
         Y3Tg==
X-Forwarded-Encrypted: i=1; AKwUvBySk9LOcBwJS/776/8fh8iyLa/KZDyKI1AHbkK+eive/QKlhYk0LTb50AX2eX6XQbBQDYQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/6rKFcdHhtshwfaXFIb+9HbOzVxkXG0iVk5xCWnH+A3NsRc7F
	4rqdBQD1jsEG2yMsZ/ilLTOv76Mo8fTN1m3AtzL0E7ZLUyHrBLQcTkjd8TZFvG95noXD7to8s1c
	0bs1gv+uEclLQg/Im71qbgT+HGgnyWVTb4ICjTGpvF29AfXGo6YRnWczxp0i4Tz/bbuGuLTFjRq
	Utv2rlizXS+/gD8fr0HPhNivpTal0x
X-Gm-Gg: AYBFou1xVsn8repyWit+CDBo2JRb0mhq/ncLNgyKs72v/aH3UZCu8pu58qaaDuxxiUG
	LstQdgRCMPP3Ac0l2zYRJMUTjlf1f52t2b/IeK55F3njZw5WmuBYMVUetbp12lCavtDTeiZmPeB
	+dDSYz284a3m6PVSjnRYFq4//9FNu5kDAo4Jb+OJvS+Su6c0twBJfO7Q0ZLyhKkPLQ4PURyClU8
	3aPVPLnKfVA7IFuJVaIZT1eOUSFlUC3AZ0DvIg0FrEzDnaXfttA6To6skRUEIiZOOvkHBucQEgQ
	Mg==
X-Received: by 2002:a17:90a:c2cc:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3ae8980bd04mr1669695a91.50.1793362285579;
        Fri, 30 Oct 2026 05:11:25 -0700 (PDT)
X-Received: by 2002:a17:90a:c2cc:b0:3a8:f70f:2437 with SMTP id
 98e67ed59e1d1-3ae8980bd04mr1669589a91.50.1793362284955; Fri, 30 Oct 2026
 05:11:24 -0700 (PDT)
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
 <20261020-qom-qapi-v7-17-431a86b02b58@redhat.com> <871p97a4mf.fsf@pond.sub.org>
In-Reply-To: <871p97a4mf.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 30 Oct 2026 16:11:12 +0400
X-Gm-Features: AclHuK9SdcKVottvuTeAWY4qSYFB8MXW7mNBnZIWRbyUXQq4NjRMq0jo7wIcSr4
Message-ID: <CAMxuvayHXMftaQP6X_14pAf63bjX8mXxsW4TsXnLf_wbOq6eUA@mail.gmail.com>
Subject: Re: [PATCH v7 17/65] qom: add object_{class_}property_add_qapi_enum
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
	John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
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

On Fri, Oct 30, 2026 at 2:02=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qom/object.h | 74 ++++++++++++++++++++++++++++++++++++++++++
> >  qom/object.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++=
+++++---
> >  2 files changed, 159 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index eb61d8842b80..e04be4caed57 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -2027,6 +2027,80 @@ ObjectProperty *object_class_property_add_enum(O=
bjectClass *klass,
> >                                      int (*get)(Object *, Error **),
> >                                      void (*set)(Object *, int, Error *=
*));
> >
> > +/**
> > + * struct QapiEnumProp: Descriptor for a property backed by a QAPI enu=
m type
> > + *
> > + * Binds a QOM object property to a QAPI enum, providing automatic
> > + * string<->int conversion through QAPI visitors and optional
> > + * default-value initialization during object instance init.
> > + *
> > + * Use the QAPI_ENUM_PROP() macro to construct instances inline.
> > + *
> > + * @name: property name exposed on the QOM object
> > + * @description: human-readable description (shown in ``-device help``=
, etc.)
> > + * @default_value: initial enum value applied via @set during instance=
 init,
> > + *                 or -1 (the QAPI_ENUM_PROP default) to skip initiali=
zation
> > + * @qapi_type: pointer to the generated QAPITypeInfo for the enum
> > + *             (provides the string<->int lookup table)
> > + * @get: getter that returns the current enum value as int, or -1 on e=
rror
> > + * @set: setter that receives the enum value as int; %NULL for read-on=
ly props
> > + */
> > +typedef struct QapiEnumProp {
> > +    const char *name;
> > +    const char *description;
> > +    const int default_value;
> > +    const QAPITypeInfo *qapi_type;
> > +    int (*get)(Object *, Error **);
> > +    void (*set)(Object *, int, Error **);
> > +} QapiEnumProp;
> > +
> > +#define QAPI_ENUM_PROP(...) ({                                        =
   \
> > +    static const QapiEnumProp _prop =3D {                             =
     \
> > +        .default_value =3D -1, __VA_ARGS__                            =
     \
> > +    };                                                                =
   \
> > +    &_prop; })
>
> This is a cute and reasonably well-known macro trick for optional
> keyword arguments in C.
>
> The example [*] below specifies all arguments.  What happens when we
> omit any?  They default to zero via default initializaion, except for
> .default_value, which defaults to -1.
>
> Trap for developers: some arguments aren't actually optional!  If you
> forget to specify @name or @qapi_type, the code compiles, but crashes at
> run time.
>
> Not a fan.

Agree (not a fan of C either). We could probably add more
static/runtime checks. Or clearly state that there is room for
improvements, or just drop it altogether - either as follow up or with
the series. I leave that up to you since you are going to respin it.
thanks!



>
> > +
> > +/**
> > + * object_property_add_qapi_enum:
> > + * @obj: the object to add a property to
> > + * @prop: property descriptor
> > + *
> > + * Add an enum property with QAPI type association.
> > + *
> > + * Returns: The newly added property on success, or %NULL on failure.
> > + */
> > +ObjectProperty *
> > +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
> > +
> > +/**
> > + * object_class_property_add_qapi_enum:
> > + * @klass: the class object to add a property to
> > + * @prop: property descriptor
> > + *
> > + * Add an enum property with QAPI type association.
> > + *
> > + * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
> > + * inline. If .default_value is not set, the property is not initializ=
ed
> > + * (default_value is -1). Otherwise, the setter is called with
> > + * default_value during object instance init.
> > + *
> > + * Example::
>
> [*]
>
> > + *
> > + *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> > + *       .name =3D "policy",
> > + *       .description =3D "Set the NUMA policy",
> > + *       .default_value =3D HOST_MEM_POLICY_DEFAULT,
> > + *       .qapi_type =3D &HostMemPolicy_type_info,
> > + *       .get =3D my_get_policy,
> > + *       .set =3D my_set_policy,
> > + *   ));
> > + *
> > + * Returns: The newly added property on success, or %NULL on failure.
> > + */
> > +ObjectProperty *
> > +object_class_property_add_qapi_enum(ObjectClass *klass,
> > +                                    const QapiEnumProp *prop);
> > +
> >  /**
> >   * object_property_add_qapi:
> >   * @obj: the object to add a property to
>
> [...]
>

