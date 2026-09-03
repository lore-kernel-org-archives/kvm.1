Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37823ED6A
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425238; cv=none; b=mvswpGccPVUKbQNKn8AJmvYg1GV1gRMt0pGiEFQT3tK9vgj48u+6MgApoOey1Vd42sCY71jJrD4wn3GtS/u2YPBY7AmUulhluo7an4xI2JqYy/O1HUiMnXDSPyZmk4hVaRsWxoHenCDyyceHTxsJRIzl3pdE5vrRXShjOYt8+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425238; c=relaxed/simple;
	bh=vYKysxn+FGbuqwHprmCIZNNJmLUeRadwwraIpEujUWU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=unHKQU+5awI74tmi9K8BgApeaJgM2Ron6OzXBwJpFTWv/a6wtZewDBAhFsmXrIF1TV0g3Sb4ALoNqe+LmWa3zMFT5Fe8SZw6CFD60TIuv05X9csV/EbZx/ZpftYGlK4nmXek5/we3AnrnqD7FnPjrXy613lpOlsY0lzLYmi88zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aoiDe1cw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnoYNcRI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoiDe1cw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnoYNcRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788425234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSusju1pkpd9GhS5C6FBQjPzNYyvC0nJfUY5xeLk78U=;
	b=aoiDe1cwbOJOTjJGwzSbjkWfCtx5cn/gnkVeEeX4wHnt4gogcm4y+Rf635Ojwdz7Q12HVC
	S4YNwV1sG+7hjUmm8fVFoO8M+UM8CuCJLiYbncqYjmrWohpuGNPpa5gxrBiib33grTjrtu
	9sRWNPZu2VG10Ab5hKIcfjcrCacGud0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-gefJZdirP3GQL2ROIRizIQ-1; Thu, 03 Sep 2026 04:47:13 -0400
X-MC-Unique: gefJZdirP3GQL2ROIRizIQ-1
X-Mimecast-MFC-AGG-ID: gefJZdirP3GQL2ROIRizIQ_1788425232
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so4129533a91.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788425232; x=1789030032; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QSusju1pkpd9GhS5C6FBQjPzNYyvC0nJfUY5xeLk78U=;
        b=BnoYNcRIv0advGWKN/fDxvfAklS+Nb/k51fUxzxvs8u0Li9WWYpwj+zSqBRZTcTx/h
         BvAjYnkdakQfp1rbESr5WS69qQ+UGLQifnCtCFg8YlgIZffjZ3viYh7husdnpGtNVE1G
         WNL209Bi7b+2e/crBrHPBNGFlln0ZUMEvZ8UORGJlMdqU3wOgk07uloliRZsaYiq+pHD
         qWcKRYjgc5aCM/Migwx1FdgDItZge8G4cuvEPcT0KSPYqQSnsuC1s2A7e/yoNFoQ1dZM
         4gJqsUQmmRd0sBEEzhKnzVoKvdAq1FWGc3z9tN958W472v1enEtON8rVzujaJNmK2kT6
         6OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425232; x=1789030032;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSusju1pkpd9GhS5C6FBQjPzNYyvC0nJfUY5xeLk78U=;
        b=ka/xnVAY6QXlTdjSfgA9Jxgozd+NJh546axai5SjBB2L6RFrsnggRkoakZDODOTNx3
         2MuluCv9x+pOvyyrlh2xdZY6qw5U+bIZmxR1OHZr+GI5cXZBHh+jth5co8Jvn1FF2Koc
         sCBg9UOLVy6wjMIQq4Ly7kPGdlp1Zk4Q6PtoQfOAcgqgPm/0C3Qdwmd+zFolU1/dvj6D
         ak8RkdFaWR6No77evBs+PWCh8MSUVhg0rVVYLGFZVTmHygSgW2v17RR51+spoOxn2QJw
         H0Bei9pBazlaRSX42AKz0p2W3M6UEjFPFu+Ey9YvuORNKvH/c/H9ZJdqaIo8Ppu8tWTA
         iSvw==
X-Forwarded-Encrypted: i=1; AKwUvByIDsCaYbv8tdcB1Jy9tbjOHnDfFln/Ylx4fuKIUc/7zwtC/3tzWUraq/efMIoITWKlSCY=@vger.kernel.org
X-Gm-Message-State: AFuF++lgkvGVs9LqUqbrtaP3lRp7jqsFeuJXCKLDJ4lbt3tNuBikbv+A
	ppcCXK7dyy/jXBvTBjFbPY+TEfV1wpzveXrna82GgnaduVpxssGe71meYIGFJoi1hQpmyLJuj9b
	P6i6hYzrRiF+RIF2TmxpMGgh8T8IC7bL8wIFhebZJApqe1LCcKrXQDg==
X-Gm-Gg: AYBFou2n2q/XG8IJAjsvVdj+gfqJdfwDAlj9wlzAX1+eeSql3ISvmq2bapQTizw8exP
	WElXN4QRERFhT6rqyRqj87f1o1J1SRlO7Af602j5IywXVl25GTOUnjoecVI7/uFFOTAYv0XfhGi
	BY09DqTa9HiHvR+tzkdglVNfTi9eeu7X7UFXr+JMFm50vQAcp40+v2HyDg7TRfcKzXkYvAFWKR5
	b/WGzJZuhnAEnI+r6bryMVs2XQwdGnmm1sfaAVieU0NJ0PSgssOixu3gdnB0UVTVb+hpzAsAiYa
	/GeSI2lfVRx56G/PcNOWqF/vn/ptsfMT+B7ejUy4LEA1jnCUYpt3lmjvmIeYw//w5ONc2LSg646
	N3+3jBb/VprwWe2kxGYBlX2M/GHgyPJ4csfbMgQX+JN4SOxJWVmR8i4Y=
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39aee04acdamr18160220a91.14.1788425232361;
        Thu, 03 Sep 2026 01:47:12 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39aee04acdamr18160115a91.14.1788425231825;
        Thu, 03 Sep 2026 01:47:11 -0700 (PDT)
Received: from smtpclient.apple ([106.219.132.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1431994db8csm4119845c88.9.2026.09.03.01.47.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:47:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 3/4] i386/sev: convert the guest policy properties to
 custom accessors
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-3-e93a6cf8c5ac@redhat.com>
Date: Thu, 3 Sep 2026 14:16:58 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <005FBE44-E87B-4CA7-8BB3-5A8A3024A00B@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-3-e93a6cf8c5ac@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On 1 Sep 2026, at 3:39=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> Both SEV/SEV-ES and SEV-SNP expose a "policy" object property. The
> SEV/SEV-ES one was registered as a plain uint32 pointer property, and
> the SEV-SNP setter ignored the result of the visit.
>=20
> Give both properties explicit getter/setter functions and check the
> return value of the visit in the setters. This is preparation for
> tracking whether the guest policy was set on the command line.
>=20
> No functional change intended.
>=20
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> target/i386/sev.c | 30 +++++++++++++++++++++++++-----
> 1 file changed, 25 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 465415c535..c76cdba8d2 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2956,6 +2956,22 @@ sev_guest_class_init(ObjectClass *oc, const =
void *data)
>             "use legacy VM type to maintain measurement compatibility =
with older QEMU or kernel versions.");
> }
>=20
> +static void
> +sev_guest_get_policy(Object *obj, Visitor *v, const char *name,
> +                     void *opaque, Error **errp)
> +{
> +    visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp);
> +}
> +
> +static void
> +sev_guest_set_policy(Object *obj, Visitor *v, const char *name,
> +                     void *opaque, Error **errp)
> +{
> +    if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
> +        return;
> +    }
> +}
> +
> static void
> sev_guest_instance_init(Object *obj)
> {
> @@ -2964,8 +2980,8 @@ sev_guest_instance_init(Object *obj)
>     sev_guest->policy =3D DEFAULT_GUEST_POLICY;
>     object_property_add_uint32_ptr(obj, "handle", &sev_guest->handle,
>                                    OBJ_PROP_FLAG_READWRITE);
> -    object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
> -                                   OBJ_PROP_FLAG_READWRITE);
> +    object_property_add(obj, "policy", "uint32", =
sev_guest_get_policy,
> +                        sev_guest_set_policy, NULL, NULL);
>     object_apply_compat_props(obj);
>=20
>     sev_guest->legacy_vm_type =3D ON_OFF_AUTO_AUTO;
> @@ -3004,9 +3020,13 @@ static void
> sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
>                          void *opaque, Error **errp)
> {
> -    visit_type_uint64(v, name,
> -                      (uint64_t =
*)&SEV_SNP_GUEST(obj)->kvm_start_conf.policy,
> -                      errp);
> +    SevSnpGuestState *sev_snp_guest =3D SEV_SNP_GUEST(obj);
> +
> +    if (!visit_type_uint64(v, name,
> +                           (uint64_t =
*)&sev_snp_guest->kvm_start_conf.policy,
> +                           errp)) {
> +        return;
> +    }
> }
>=20
> static char *
>=20
> --=20
> 2.55.0
>=20

