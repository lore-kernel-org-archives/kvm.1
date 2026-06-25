Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E423033F5
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395861; cv=pass; b=f60QB2ZQj2E7GU9syeezBQDUIbUh9oY7xzrb72rrJpUBgrrb41V70bYbo6ueNXnncprWDGqnI2yXhryaArlsWyVgFjK+TuCft1xgHo5a+I3xiQbRMlF/7CtcEVF6/6LgkDYzZerhFErJf4ZogyFpYBBVup+wxxzCRfnIRaXF18M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395861; c=relaxed/simple;
	bh=09kGKULuxwNRdpnt9MiE6ht8gMXa9r8db2ODWamPlG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIdDDTGPKNDiicjufRNY3pWIa2DA7wKRhjQjT5VFpvtYdMjxfPCFr/A//fnliyI1Gdd/Y4zR+q1tqCT6X/Kr/6iHHAbUZlNm2ELvwLN556Lw4GwZ7Aul1Gz1QteLsxEddGB5D4Uc6kP8kveAm2kmZ0OwhJECg/Klu+Q3I+WFyYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwJy/w+G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLdwYRen; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwJy/w+G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLdwYRen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782395858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoPQZfQWpHp3NoKHnLamjdykEZkB9/wUFW3GNiNJpas=;
	b=MwJy/w+GeWVAdaDYVIEeNTh7modpmENdfrWmdJhd8SrMIKapdRQi3WB9lRgbjTTataCDld
	2w+r3KiEsUgtFCdD2PQgrwI3ouaEDmal2Oarb8PCxvDqBuKopRzEOrWtqo5ixvW/nf8jpC
	deFkRw7WTGsHN1YbEUsChiT8M4qPKrg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-mkwULE0TMT-Ue6rOTGcnGg-1; Thu, 25 Jun 2026 09:57:36 -0400
X-MC-Unique: mkwULE0TMT-Ue6rOTGcnGg-1
X-Mimecast-MFC-AGG-ID: mkwULE0TMT-Ue6rOTGcnGg_1782395856
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-662e19fad94so3706901d50.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 06:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782395856; cv=none;
        d=google.com; s=arc-20260327;
        b=N8rr3XCCiLMP1653T58VSOriwFbUCOgJfdB1ZvoMCYROmoJvy/NMFzGosnieubNPOY
         BDMRlillwHdzpI027yhf2Qc4xbmIv0xnYVPkVf5T4WpvrvCx4XYBSdN6CuHx5iWFQlUC
         9c9Kr5Z2I35flI2sJLWB1CqYmuDwDKVtpcyaCm70IJs+gBxSfiVhatxmplG537jx4/6x
         GFqJ7pCok+dn97IkWk0BQR6uwcH2Rb/PxE8riPd8W1H10CQNzCuq5LkovcgeumZX/Ve/
         r6cYvLG4YyzefmGddFNZMwap6Ds96+aa8k8U7vUkilqvgVp+ePqhhxdNbiuaUWbHBiga
         fU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yoPQZfQWpHp3NoKHnLamjdykEZkB9/wUFW3GNiNJpas=;
        fh=1ZXMqGaCk7HCqYfLhllGwU8CTVgOMw4dfJZ/UAQeRFU=;
        b=gxfccLeNYouIhTE1r52LwaYoSqwT0yvScQcZK66PS/rMuLPqvCGVnOdXaIQb+a+D/o
         IOGWFB4SiGzG46OpEHExDGs3BMetuXyGEOlYpFDZ/sAwos6k2w8AU8ICOii12loEfvnC
         NZJoz4PT+9vZpMH1030BOkGXQiusKNgx1mdJQC5vr/ZI87dbcnBXQshF4Rpak8Hm1Nz8
         dVUdb4jJXx0KdmdPoTyApk7oyBF1V03eSqf5nlkAnOs1+stqFAMUkZABio+CBPb8ZAXt
         FzlE1FZHcwMVhgHL6CaB9GfPZfff5lbmbN2aZVimh8ZeRAwr9WEi6PzdCsrF6N6DXmdw
         0P4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782395856; x=1783000656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoPQZfQWpHp3NoKHnLamjdykEZkB9/wUFW3GNiNJpas=;
        b=RLdwYRen0dW4CkxlAw3QordlhwpJKtaCTg2zS/uPJ+dxrKH2CYUvzOZ0HKDhIp2ubD
         MSpP42gYfXcAGZYC1RE0ZEJ8Pj3nMmWku4QEgifPQCqync1aoN67QMeFP4c76TlIFlyB
         wmX/bWWcEeRg2lEchp/PLj/Rx1rFxQG9DVwfUIhyYAgjnv6yJG4Q4CrjcS/UPU7MHeNb
         fMIZko1J8LneVxoRwwTqSg5qGUJ9ptCs30tVzLQh7yvytlsSdelwZWl3pN++y8cg5a8F
         CWgRnCLyJwtzMtlvMb44INWHoggHr44y8kzENljxQ8S5oRAdJ9eD72u1kkw8bjujHWSZ
         G0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395856; x=1783000656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yoPQZfQWpHp3NoKHnLamjdykEZkB9/wUFW3GNiNJpas=;
        b=hRLKSgpmO5qoBAObasdcBcrXVR5WUFiQg6G/HHVBhM+e1hdp4NdbWU4AW07XOPPwcT
         t2oDepIobEbW4tQttzjAMiXNuZ7bnCpBjXXIlFRihqNIrN5fy8lvNoerJQEe2v5KY83q
         5aeXuwAIIDrwGV2AZqOYLEH1xv3wmdLD2ycJor6JPYgMNr4OoIcHDQo95a5pHhpiq9dK
         iVaMDrNV60LdtzIfG8ZLlHKKjRyFsuc/ryai3vi1ClvXU147ejg/NkwLwuG0agiIhENy
         Hr5sPX5DEjdUJhBCmeuLcruJ/rRG+wk+qyboA3gL3fvM5nwRucIgwiHG1f5+qi2GDUdf
         zXrw==
X-Forwarded-Encrypted: i=1; AHgh+RqCq9So5u/gcgUDpOZ38xedMnmZbSa/FzzhLBLoGOwEGGRP7o/nYE9PqjWZQfeH0bXDtC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpybP/YGZX8eHBmTBd0/84fdtWjN7to1mSYMYd3IY2UC3kJFc6
	zQjk9PnkG0xc2flwwNGegPc/pXCiWsQI971Ko7MsTKBFRSGmyeKJAGKtSTdJYzoDenIcwNTqeVm
	vH3P27hA3OTgMYO1TuDTU3RFjZZZBV2dPXWr1LQaktFyq2q9mmmcn9XlAbZKJki55KPlEVYf3IZ
	yTx02QXc15SA2AHFqoMhMKCV2nME8Y
X-Gm-Gg: AfdE7ck0GfrtTXVhclgeAR7llWen0A4c3jAFe07/MlnyOVOp7nfLcQL12vcGif5I/f4
	sQtxc3MEvW+U9tPRdDv0yDAG+YljtnQMhJrktSuipwURrmFyf6RQkHbJH1UCXWrfxvTG/4aTLvc
	Gtk0QHLc4BPFqxKycFWcko7e7S7+48xD8ZEZuZOfIYQkNSyhGrPcxoyp2bFV2y3fce+00=
X-Received: by 2002:a05:690e:118d:b0:664:9032:656e with SMTP id 956f58d0204a3-6649032684dmr1013800d50.17.1782395856203;
        Thu, 25 Jun 2026 06:57:36 -0700 (PDT)
X-Received: by 2002:a05:690e:118d:b0:664:9032:656e with SMTP id
 956f58d0204a3-6649032684dmr1013773d50.17.1782395855647; Thu, 25 Jun 2026
 06:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526080336.61296-1-r4o5m6e8o@163.com> <CAJaqyWcFm0A5ucL5TLP8+T8JNOiZyaL-_mb747_fKhH9Qm83ig@mail.gmail.com>
In-Reply-To: <CAJaqyWcFm0A5ucL5TLP8+T8JNOiZyaL-_mb747_fKhH9Qm83ig@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Jun 2026 15:56:58 +0200
X-Gm-Features: AVVi8Cf6xgF5zkdsxl65CjXk9mAqqpZ16WJN5rElDgN4AmLJNI0ZYQtf2VXrmew
Message-ID: <CAJaqyWeGTKZB7BCHV4MzjRsg0B43qoTDCYjUKvqyyAjyB3edqQ@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yufeng Wang <wangyufeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 3:48=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, May 26, 2026 at 10:04=E2=80=AFAM rom.wang <r4o5m6e8o@163.com> wro=
te:
> >
> > From: Yufeng Wang <wangyufeng@kylinos.cn>
> >
> > The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
> > at argp, which is the beginning of the features array, overwriting the
> > data just written by copy_to_user(). It should start after the copied
> > elements at argp + copied * sizeof(u64) to only zero the trailing
> > unused space.
> >
> > Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> > Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
> > ---
> >  drivers/vhost/net.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index db341c922673..70c578acf840 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -1777,7 +1777,8 @@ static long vhost_net_ioctl(struct file *f, unsig=
ned int ioctl,
> >                         return -EFAULT;
> >
> >                 /* Zero the trailing space provided by user-space, if a=
ny */
> > -               if (clear_user(argp, size_mul(count - copied, sizeof(u6=
4))))
> > +               if (clear_user(argp + copied * sizeof(u64),
> > +                              size_mul(count - copied, sizeof(u64))))
>
> The fix looks good to me, but why not use size_mul() macro for copied
> * sizeof(u64) multiplication?
>

Also, could you add a new switch to tools/virtio/vhost_net_test.c to
use the VHOST_GET_FEATURES_ARRAY and VHOST_SET_FEATURES_ARRAY instead
of VHOST_GET_FEATURES and VHOST_SET_FEATURES?

> >                         return -EFAULT;
> >                 return 0;
> >         case VHOST_SET_FEATURES_ARRAY:
> > --
> > 2.34.1
> >
> >

