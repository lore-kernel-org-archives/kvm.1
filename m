Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5326377ECC
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214737; cv=none; b=YvY98J0HXWrwtC+Xh+fixQMVZl20ejxh/ZvFmv+N55QSabcQ9D3jwGiSkW2WBAHOp96zmKw7M3+xUYX23iWGnZ2DnClYNLqfF5G9KT9zrxkiswJcp6eT4ce34hEBPelpCs6bNV4bDzE5Jj6iRDVzRYyKy6hIanO6ALscTQ6LJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214737; c=relaxed/simple;
	bh=cICNO+GpkKwT6fZYIeMBONTZ5Ru+RCAqdtnTX5JLvvk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hHYm9oZZE+Ov/JpEbNM3NydTZkD2+RsvbmivGaL2t9bVNd5EUB+zbBRTaioimS6QZI6CK2ATM+jNsEZtE8xhvcg20p2crrhtxSGS23afUtsl6PtsUljre6yTHPnilkMHerWjfF9kUB0zQCqUZUvzF0cv1Ds2mpOwT1Edc4U0n9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ytwr/B6S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rY0StW4l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ytwr/B6S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rY0StW4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773214731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgd9oM6xhLN40jOEiECQu2rTW8IXyv8HdUzwIF8sY9s=;
	b=Ytwr/B6SJWNRciXwC2kI2LmtCDW+2rc1OVMOLi5Eah0hBEEYQmtYS6GDxhaNlRtiM7Dvh2
	xznEcYMnhyfeRrAaazPdquSt2c+vwwJbAdoRVzlylATNM6+p2bbybxONZXk7MaGSwG59hV
	VRGTBbgf4fktD3ErcMCBvxdOQwWjwn4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-jYQ_wzUOMAybdSsPaXv05w-1; Wed, 11 Mar 2026 03:38:50 -0400
X-MC-Unique: jYQ_wzUOMAybdSsPaXv05w-1
X-Mimecast-MFC-AGG-ID: jYQ_wzUOMAybdSsPaXv05w_1773214729
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35a0998a441so689451a91.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773214729; x=1773819529; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgd9oM6xhLN40jOEiECQu2rTW8IXyv8HdUzwIF8sY9s=;
        b=rY0StW4lTDrnyZT7OT/pov8r6Q6+0IG4RXKntDBmmiMjek9co60pSD6DuNRxQKtrgz
         sd7Vt1iOQx3hEk6Ib0ZKLKX9zfAGxlHtAgDvwxBux5a8TYHbDpMdgGVm9lmBjFlyeW/I
         jNojOYJ1ntNJ17qHx2gzAl/KTp+qoxXMnaR1R6wTxQQ/MoOk1llT1RKWqgcEvgq5J9N1
         y/a3IGHGflvpvV0xErQIzWhDfp7PW3HG2fd9LYV1biTjFIZoelqv9gsJ+IhndWAOrzBX
         c1fDWMv3QFoTpWdz0VN8iOmEDjUl30Go7nRnqVP11EKiuymx67hfGwtac7WIG5dLjoHO
         UXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773214729; x=1773819529;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgd9oM6xhLN40jOEiECQu2rTW8IXyv8HdUzwIF8sY9s=;
        b=nY/I0eTKq1zhLmub2dq/YV85G9sCaI2fkvLCUhip5pNCdPxCd6PJbSEALPYC/qbXlI
         UbinRBdtyl3E8xK5mueArr9GD3PlSDcowqWnPsWxsYC5H1KWpD8Dv4EQzbPNZb8AjgeB
         hOC776TtabUpgM1Xxaa+ro0cQMFwTWTlNuXWdfALO5I98cQkjMEenOAYqAZeOSTOstMQ
         zOefSdUkk48Qm+jHkQpUlfuBgbv8gnj3H+ciuml7cTsd8y8P14nS/PbHc4COSfN4kUhx
         INAJ+jlvmtB9AXskN5N2jy0mx7xSyIF23hjqVUSUgrLz9atnplX47wyyu/YuihHxn3J3
         ojCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBQ6+XSPpAaFdMMb/PoS//xXbvoMzJ+6AYgGGTcwfEakaCmNRlKSnKiqf11nQ44Yh0sPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGeG2lYMm9k77lgILoWaifTx6kRJlx28Emu4sI7omPRDj0hM2
	esloy3tLLzi9T2vC1q9PO9fGEF3PTwYLiy/6S6ldozJIRUJ3hwZ+5ZDOTjL0Zx8FerTbcAhHwBt
	OWztzSyZw17Sd4Mk9GpZTCpx2+lL9bLXxJaxh0nKLeJmNj7gOlfxMi7L8cfUC0Q==
X-Gm-Gg: ATEYQzzD4xxzPNfzcxhRW7PPt81dSeckisHU52tpAv4eQJ+aZ30FdigkQtvQ8xD9O2E
	C3pdkNyzTHrg4dHQ+orC3Xk6EPu4TFVtuZzcR9YUFST5f7pahntn9VqdAJ7PbKB5I3Hd0RzBGF3
	1TGp1no5jO0ZE2LuHdvLp83YcnFNYeWX8RtgUpYkTHc0Hnq46ELS2murhLtjTPxoG5Ip75ZAybX
	KA6pDqhiTisvo2LGzOvBasbsqKuw28N4saWDpz3ufBIfRKrpNKAo+SCTzKfNy8eKkmUY6N8TPA7
	59WHjBXGNeUkNatpNNivzG4jOsL8sirw8QTxr/SWj4/sKOqIp8EwS91F/sXOnMR+VHLTmk2HTY/
	8ZLad+Zx0SFk5Ep6Y3YWBdovOpC3EeVBoHFl2KRyFG/TUkD74/QI9xPXdeUuuByVhs163rg==
X-Received: by 2002:a05:6a21:3994:b0:394:586d:1540 with SMTP id adf61e73a8af0-398c618471amr1341962637.72.1773214729119;
        Wed, 11 Mar 2026 00:38:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:3994:b0:394:586d:1540 with SMTP id adf61e73a8af0-398c618471amr1341942637.72.1773214728725;
        Wed, 11 Mar 2026 00:38:48 -0700 (PDT)
Received: from smtpclient.apple ([122.176.129.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf92ff3sm1314383a12.17.2026.03.11.00.38.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2026 00:38:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v2] coverity: fix coverity issues related to confidential
 guest reset
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260311073551.61147-1-anisinha@redhat.com>
Date: Wed, 11 Mar 2026 13:08:33 +0530
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA24744F-71C2-4586-98B0-887ABE9D9888@redhat.com>
References: <20260311073551.61147-1-anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)



> On 11 Mar 2026, at 1:05=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> Fix issues reported by Peter.
>=20
> Fixes: ec9bafd2ea9d12c ("i386/sev: add support for confidential guest =
reset")
> Fixes: e76c30bb13ecb9d ("hw/machine: introduce machine specific option =
'x-change-vmfd-on-reset'")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

^^^^^^^^^^^^^^^^^^^^^^^^^^
Sorry my bad. Will fix in v3.

> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
> system/runstate.c | 5 ++++-
> target/i386/sev.c | 4 ----
> 2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/system/runstate.c b/system/runstate.c
> index eca722b43c..ca6730d111 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -512,9 +512,12 @@ void qemu_system_reset(ShutdownCause reason)
>     ResetType type;
>     AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
>     bool guest_state_rebuilt =3D false;
> +    bool force_vmfd_change =3D false;
>     int ret;
>=20
>     mc =3D current_machine ? MACHINE_GET_CLASS(current_machine) : =
NULL;
> +    force_vmfd_change =3D current_machine ?
> +        current_machine->new_accel_vmfd_on_reset : false;
>=20
>     cpu_synchronize_all_states();
>=20
> @@ -528,7 +531,7 @@ void qemu_system_reset(ShutdownCause reason)
>=20
>     if ((reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET ||
>          reason =3D=3D SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
> -        (current_machine->new_accel_vmfd_on_reset || =
!cpus_are_resettable())) {
> +        (force_vmfd_change || !cpus_are_resettable())) {
>         if (ac->rebuild_guest) {
>             ret =3D ac->rebuild_guest(current_machine);
>             if (ret < 0) {
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index cddffe0da8..9dde972c11 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2011,10 +2011,6 @@ static void sev_handle_reset(Object *obj, =
ResetType type)
>     SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>     SevCommonStateClass *klass =3D SEV_COMMON_GET_CLASS(sev_common);
>=20
> -    if (!sev_common) {
> -        return;
> -    }
> -
>     if (!runstate_is_running()) {
>         return;
>     }
> --=20
> 2.42.0
>=20

