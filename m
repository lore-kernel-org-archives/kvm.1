Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C1397E83
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549827; cv=none; b=EFGF1OEX20KitCDkhUdWITM45/DGK2FwAwgC+XuYHgCYDB03Gq2VDQNX1i/icvfQmzRBApGFrSoIVNiBfS/nui0i3Dns319eCEj9nXaMONz28ZE8Lvboae0YTAT2Tn9qb7oj0/ROEBaIVM0FDIg4b5i0g0gjIlOSSolT9HkKW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549827; c=relaxed/simple;
	bh=hdjwIFn1qOEej0kT9LXbO92EUVDNIZ/ROtNZgj4YB9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s5d8g3Ot1xu+vMcAxI/xGKHzlXEQwu1u9xvKs5g/vK2JhI0ZOQt92//hmk+CCo0i001mukx5x7DoWYj20B+lHbbwCRMw/ODNZ59vm3hQRZ+img4AzSlf6mA8WsNOdkNAi8KaB0BtoBtV8n2y3XYEyjddrdX6e3CONyP/Oltmap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1h/t4nL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsrFzs6S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1h/t4nL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsrFzs6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775549825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdjwIFn1qOEej0kT9LXbO92EUVDNIZ/ROtNZgj4YB9Q=;
	b=J1h/t4nLNr0ZPHKLP09HkJ0fchjOAm7oau//002ubfUwaKSksLXaXsTjYrzvZcHjlPrbJT
	XZ9WiBgvg9F/q2mh+WzW6zcOLnNo2lSHswTtf6cBo6Qt1FjJCC1ue1rvwFbphNIpXvhNzU
	mO1vQVrDC37hl9fJTkmgX+GUesKPBAg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-l6HVZRTzMMiyVUsHOZmKew-1; Tue, 07 Apr 2026 04:17:03 -0400
X-MC-Unique: l6HVZRTzMMiyVUsHOZmKew-1
X-Mimecast-MFC-AGG-ID: l6HVZRTzMMiyVUsHOZmKew_1775549823
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b96365ea8so6044124f8f.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 01:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775549822; x=1776154622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdjwIFn1qOEej0kT9LXbO92EUVDNIZ/ROtNZgj4YB9Q=;
        b=gsrFzs6Sbq0J1wv6COo7PViQDUPmFjQivXFJO/P0dOihFmfO64qlGksjtMRxvWaNbu
         eJ+rbrSFxJffPp3r4jE5IzShromRkKgIFNcThHOXSTTjadbjzwr1RJ+PYytNYiQHt415
         c+70r/U6Dc9oUSylfkNv0pQ01BtE1zS+55k02/1fbyli+6TLp6JGOgiU5Xnu20W9fg7r
         /2YaYQaKk8zT0oH5tcBPCMFk1+zVtNLsSrMOdSXGYoJm1hpKNhoQS+F/5ZZILA4DsY/H
         jCxJs3hKDSJQfLOvovmogjOhPFOw+zQBGnytJMey+C/cEjET3LLjTX0fyi0CWHFYD04Q
         ZWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549822; x=1776154622;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hdjwIFn1qOEej0kT9LXbO92EUVDNIZ/ROtNZgj4YB9Q=;
        b=hEVh414vtB1ZFKRmyblqdYyKqLmsKX5lam4eCES12ds+KkGStmXQeyUNl2TAuPY+iJ
         ye9CoGPuRQaeR0lMq7ascWx6gBgiMqojS6ee7+yFMr2OTZIvJ9LgISpOzuuOYfJ054wV
         3Uj5GzUUYJTciPMoy6tXv9pUQrUWNDNpLWvnu/eWlBH5ZykZxOxuAn8EB7bdcEazUEWs
         385bbvCtkCtUCQERulocdD7FFUBG9CnDdRN/4bnFinn64DYE/En5VJH6Df+mrhDG4cW+
         JjPs/DEI42fv93DtGiAj/Q/+If1FLhRsDRVgDaAJb8rJpd6JL4vYcbl0RagwRLFw/CdX
         MFWA==
X-Gm-Message-State: AOJu0YwH5ko8I/SzSwaHY26/DYpfziuwl0AG/ggNYlo4HwiDmQO1F5H4
	9td0CNFupB8OGzJKuhz9gyuDLmFlcbaqq2/GlahpUcwpajdP9y8Y2Zri77gXiFYUKBRMyvcKMgh
	hCCSU+mJ54jVsNqAZ0BXw63SWTIcdJC4hQdjsayB8Faxm0p49/N7ekA==
X-Gm-Gg: AeBDiesqHYnSMMYBTmAAaw0UZG4rJ4UCLiYJCMhml8c5lGhfkj/eFNqTXQ/IUHpJfa+
	/hzqCJIAEZMouuE3yxLBrdT9ymegjoJXRVm7wfGeHFAf4NaZOH68nAySg+O2NIkbSA80bAglNi4
	pch3lv2hccLHR4WWrwtn2njqKsBVhPA37cxlYyuY2x2Yk0ubFtYO/EkImYPExQ5fMM4z0rPMZw9
	sDNHNxUt9hL3+dJW/EfdEcbN/esMLzqbCWOCDZ3a2uwK3trKub8R0ZZIT0F54gJrmmWWimXL+gn
	glRRGDsw5zQHjTZlzKInXRAQNToIMcIVssF0dBD7l2rWY5ZpiBHMNUDTr7HepPdQqEqDVurG3gv
	XleBvF8288XKdmDW29g==
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr26277105e9.30.1775549822590;
        Tue, 07 Apr 2026 01:17:02 -0700 (PDT)
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr26276545e9.30.1775549822144;
        Tue, 07 Apr 2026 01:17:02 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897b8176fsm183373255e9.0.2026.04.07.01.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:17:01 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Thomas Lefebvre <thomas.lefebvre3@gmail.com>, seanjc@google.com,
 pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
Subject: Re: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested
 virt due to cross-CPU raw TSC inconsistency
In-Reply-To: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
References: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
Date: Tue, 07 Apr 2026 10:17:00 +0200
Message-ID: <87v7e3mbgj.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Lefebvre <thomas.lefebvre3@gmail.com> writes:

...

>
> Under Hyper-V, raw RDTSC values are not consistent across vCPUs.
> The hypervisor corrects them only through the TSC page scale/offset.
> If pvclock_update_vm_gtod_copy() runs on CPU 0 and __get_kvmclock()
> later runs on CPU 1 where the raw TSC is lower, the unsigned
> subtraction wraps.
>

According to the TLFS, reference TSC page is partition wide:

"The hypervisor provides a partition-wide virtual reference TSC page
which is overlaid on the partition=E2=80=99s GPA space. A partition=E2=80=
=99s reference
time stamp counter page is accessed through the Reference TSC MSR."

so if as you say RAW rdtsc value is inconsistent across vCPUs, I can
hardly see how we can use this time source at all, even without
KVM. scale/offset are the same for all vCPUs.

I think the fix here is to avoid setting up Hyper-V TSC page clocksource
in L1. Unfortunately, with unsynchronized TSCs this will leave us the
only choice for a sane clocksource: raw HV_X64_MSR_TIME_REF_COUNT MSR
reads.

--=20
Vitaly

