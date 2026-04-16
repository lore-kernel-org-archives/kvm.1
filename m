Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716FA39EF2D
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344415; cv=pass; b=XgkNPmoWEygvXfjezZ+3sdU3K3UyBvY9xMwPVFCu1rTMVlrIKW4LytzzWznM1PgcA2dMb/DlLWt/WtlVmTQmwk5IIxjUynfDDbB4EA/kTRp2626V15372cMPrJVnQkGFWmeEr7E0VPQVIiojK18Egy7AWdC7QtH98mMGnMYHpw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344415; c=relaxed/simple;
	bh=0m2xx2jA5Q16sLQ4TDh35Sw3p9QLy9ti+hc/1dTrKUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxKtsaVFDMrWAGIvlRbgJMC+WqmYcDbSkLoVK373dBQzlMUgXyserMWWMbBYBUAb4wiV8JNeyq2nsDvNCEjEQiiPSjdOWSqHhpwz/NWBa/AaF4VA+hHacC+aQKCjo8BJbKxZmOqlngl0+g3rS0TLcyfMBWfJS6dfThPOyALHPnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQq63YOe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sIyq4ke5; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQq63YOe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sIyq4ke5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776344412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0m2xx2jA5Q16sLQ4TDh35Sw3p9QLy9ti+hc/1dTrKUU=;
	b=YQq63YOetJ9IxqUerUaFoappDMp09LrlIOzAwWx92WHEPGV8/fvXt4lpAjA8nsakP8lWAm
	AoUh6Q989ozsgwellqBi4XXxgOZySE/fJrdtX/YtS3u24ijbtcq3DEY8dy0Cl0lSG6pDUg
	c0mZuRTrY6l4ksu0BpQNJT/17GNhH04=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Zb2PFkEiMXq_towLDK9w3A-1; Thu, 16 Apr 2026 09:00:07 -0400
X-MC-Unique: Zb2PFkEiMXq_towLDK9w3A-1
X-Mimecast-MFC-AGG-ID: Zb2PFkEiMXq_towLDK9w3A_1776344407
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so4995776f8f.1
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 06:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776344407; cv=none;
        d=google.com; s=arc-20240605;
        b=G0dpOp5JYeyw1AnqbfIvAjOrCWB8rOZCPjEF/4WcqhEudwaMbO1GyT1eRqPyzclUlf
         ewmWyXojQAg4KLqlQyzfLTCs3yb0bnJfka59XsxE9dDXPwM+4gX2XXvgtRTB7qElq6/r
         JDa2P7iPVlU9ARulWgTT7UPq2oAurzoKZu398OzkTrcXeEVnQ8SSyFjwfpcYoCFgbLJq
         2sBheDzc0hQ9FrzsaGqrOrqnGPjq7wrkdFHogAYJGVLktXl2j3RxIeSJpZpTV+eNT1HI
         nrxF+WwE4tmm1pjrwko+ENzAopP3WXp6VUyjh/9ACwDWCKJv+OiJkvC3s8dhd2oK8P6O
         fSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0m2xx2jA5Q16sLQ4TDh35Sw3p9QLy9ti+hc/1dTrKUU=;
        fh=GQ+AW4wBYDHa0QeDExAvhx01hh0qb2c4MEwzjE6WmNg=;
        b=i3oXiAKSwduyJs4nV3RFn8ONpye0PK0eoMhQSk1Aflq20MSBt7dUTaHVMSdZg6SY3/
         CeB2MQXpXmla7JjljkCP6QVmbndwQaiBFQrsiiekdcUMgbGRLOiy7PGfHN3qb0SFyIXh
         x3Ehfxj+9ecWaNQkoGNgVpHuqS3049NVYyAb0Obr1Eh/NyBzLvIdR0aWTUxCdrmQKnM8
         3ZiIS7Zh2FSdpCutLA7rX+VdiG/QIAAVwwBOwiSHU3qBpWh6JziE9XMcuR0fbfXeAMbJ
         Nu4pGCNEoG2DVRgllh5iwLwDHbe3ifhCcGnuCW77+/uKVkJOxG5mAzCaGOm6UDBIXp+3
         0jDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776344406; x=1776949206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m2xx2jA5Q16sLQ4TDh35Sw3p9QLy9ti+hc/1dTrKUU=;
        b=sIyq4ke5gtq8eQwTdr3jFSL47a4qeBA3wlyho7YHYtFDv5HqyzyCsPRm0+lUNTJjeJ
         F4dzZ8Ceyn2xyFKgDlXAgPTWHy0ENoWLTECk3ZKF57k3IBx7gr7F5vhUAWcesTqftiR1
         vnLAgUBzzVSSFvanJuTHEB85A7Uyf1BxN2xPH+dxIwe13QhOgpfA8iLFIMKJvRVhaIZl
         VYgoPMt5D8Wd/JpmIXoTYw6NuYq/8Zqwo3eLR1ReN6RTGkMO6CO1ymXcMeeGCbwmKzv0
         SLL6/ktbnOPRKTw+Y0MvgQen/6SX18r0dqN8ncofojlVdJg+DJjDkGv3d7ep6ImUcX9S
         GSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776344406; x=1776949206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0m2xx2jA5Q16sLQ4TDh35Sw3p9QLy9ti+hc/1dTrKUU=;
        b=pZSTihP94yXg5i4rQQ7VXpTTGbagtIbrRXNzRljp19ZBO2AdRPPqAnKHL5tdWxzS5N
         LMK5lUVA9WvQT07zgBaU/gHWv7wFwqEGT/QHFMJeLrUBz82t0CGVdAKXzSLnWUbYcnnQ
         g2bACcmosJulYphAv51JIzTVh5rjl950QeCj7VQYDfl+t6/CoAV8XR8BumoM+j+NkpwC
         TxF1EmCwyreRzcINkG5oxqntqtWHKoKH+5jn3AqcmohzKhEMz4eC2i4trRQJYwB1Svac
         E2EA0Tj0KDcwiYspiBvBNvbEmk8aqbs8yvz3gvkFZEffqY1OM5bLILxqGWi0l2cfA7w3
         p/ZA==
X-Gm-Message-State: AOJu0Yy87/icOYloNZvK1shjonaOcDwACTTLef7fpLx4N+ZKJvuIVoxV
	oPwLJZKPb/7+Vld5PV9VC7Za2f0uwfQ12A5oVDZ9BmsNRIO3aHH55qxcpdqtDsHQ7OnN8Gh+sTy
	ApfJtEmwFteSRtk87CBZlSuLXUoI9PldSv9saPXFJgzDxiwkMnhulo96++FJuqoXUdQo2hHMxlz
	JxNdqSR5yHVVoSuuBVuzBuG6mZeTTH
X-Gm-Gg: AeBDiesy7QSUE3ee/E12Cq5igCWEAePla3ncC4ZGBHh/n0z0EygHDkNOsi8l9V5GUqy
	5Kv216ju2vUob2oTAKLR4KM0ENpmnePCkcXWHYlSiTVCln/sDIeeWn6n9mkSPhhAShMftPlrxfB
	4axvbatQEsGe5rhvQTtBnblJoe1g1k7SIAHPEGbuB3JQjqCu7Bil32Iv/QOcg72HM+pQASgnF7f
	l30yNqXvJQCDZGEKlZv43BjbWD9b047CNcuf3QYyJCTZisXCFepMKHi43YV43ViV1wHqpmQDIWR
	fy5CbJiF6p2xYW8=
X-Received: by 2002:a05:6000:240f:b0:43d:76ec:91f6 with SMTP id ffacd0b85a97d-43d76ec942emr27911325f8f.41.1776344406502;
        Thu, 16 Apr 2026 06:00:06 -0700 (PDT)
X-Received: by 2002:a05:6000:240f:b0:43d:76ec:91f6 with SMTP id
 ffacd0b85a97d-43d76ec942emr27911249f8f.41.1776344406021; Thu, 16 Apr 2026
 06:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f6e9052c0c748f023e880503ed0001a9a919599.camel@intel.com>
In-Reply-To: <1f6e9052c0c748f023e880503ed0001a9a919599.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Apr 2026 14:59:53 +0200
X-Gm-Features: AQROBzB06z0j3FfHL_p7_YJA3OFk9JJD1JWJ8q8MT8WlEpmh8AyMWm-lEAm_mqA
Message-ID: <CABgObfasYTWmuqkz4TaTprcivwkzKGxAjdYZJVgO66HB1wK-5w@mail.gmail.com>
Subject: Re: PUCK follow up: Trusted IO call details
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"Xu, Yilun" <yilun.xu@intel.com>, "djbw@kernel.org" <djbw@kernel.org>, "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 8:59=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> The call I mentioned is officially called: "TAC Subcommittee: Linux Kerne=
l Special Interest Group (Linux
> Kernel-SIG)". This seems to be the info:
> https://confidentialcomputing.io/about/committees/#Linux-Kernel-SIG
>
> Paolo, unfortunately I did remember correctly that it is not an EU friend=
ly time.

This one is friendly (9AM PST =3D 6PM CEST). The unfriendly one is the
IOMMUFD one (5AM :)).

Paolo

