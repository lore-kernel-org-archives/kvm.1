Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E63357D0B
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534100; cv=none; b=IH4JSI3pwK1z7+Egi7iMrz0YND4v0wHZJDJ7Aqi/a1bEZIi5nEFygJOE52eUClgk2i7Vu5otZ4Cz0Kfn8buBWe9wE0ejd8IraOyLYG8ESodKJ2iVScMQqEvZh8GddmA9S8yQcdBnYDz/aYmsnKSM2ZvBCHC9oGulJUg4ZTbaLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534100; c=relaxed/simple;
	bh=bq31RPSAnTvewVks7PBfBFUyA5BKHmft85kpTD6XW0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VeQlIBWO/eNYjRtnFxYYFLYqkJYuY2jxb7HVHwowH+CUXPMOg7HTve2wtR9dLtNnfs0fO4RSog6uunmMCp8koVgRuZFUdnxQTEcuKO+xVULR1SiKN50+VH6N8Sb/DabIx463JdRXdUJtlGnmvpXD9WaxftQtIutllwgeiIOZXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChhJ17XY; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChhJ17XY"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee894b3d8so26030335ad.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785534099; x=1786138899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PVR8QujnOvE/gsZcroLlAokjVOxh8pMAit+Zm+cALWs=;
        b=ChhJ17XYLBXgJrVsg7zJSfQACX032iXfaA4Lpe+y+CY/0AGLRLCU6jZeMvL6LrWGtA
         kR309Pa/y0K2QVODUGEH1G4xhnj8e2vO45TcLAKfwPCeWrH+DrX8FK7NlhOWi6n6DfiN
         Bfy2GX9BHp3tk7698qRZUyQFb7GeT+hupyL14jx9WmAc5+cSjOxyXha93+SQCOqVI2Lt
         l40SC6AlBZjyI5agr92CVMOktsV3hcN1KJS3sI12qab9mwTLYaHucPuaam8WXRQUYX0m
         sFWzIbv9RkY6UsBemtItZN10NmqV+GRupHJAwYdfsQ6c71uSwa0/Rx0nJQ3JJOb3BiEq
         6fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534099; x=1786138899;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVR8QujnOvE/gsZcroLlAokjVOxh8pMAit+Zm+cALWs=;
        b=Sstdmms1syPCob0xytofMiWA1PEj/dbL+Hk+kuaqdg8+6IpBty9gsYXE67tSb6GRbS
         oQA4vn+0zGkgJ4ypSHCb+pkb7OGxHr/H8gLknhYGKOOfKU6acI4qBY7j3WOKLVscnoKR
         PbNZ/TOmHRZWKYzVtLmzJYYtPpHpxD0EjtHTtYoCGoMmj4iJyftMBcCIGFEPhZuWdCjL
         fq7WFaB7bq6pvyEZkLVmVqIEFVaLIc9fMQSYgYwdkGC3TwwD233p1fd7D1UJGfsCj/ve
         VAoUftJw+lW+UpzdJxqehkT8+rsmG4nnsDJCvo/ghcg1m9WslOEXjK9j0by1PDOqD8/z
         FPnw==
X-Forwarded-Encrypted: i=1; AHgh+RqjQfIP+8mK/+1Hs/GjFnnpdJeGGDYR4gMCyP50wgByAtbNdSDGY2Nltw3BB6O6/wxwq8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMBKwInP3jYU5Pyy3e0+JNMZVjtbT/Sqw32yTvz7H3DkS/e2j
	+TC9bNNFkQFjK6rYMdD237Vytwn1b05ZPsn9en/NOh2VCg/jH9wOog20CTlZNSGiwMvn+JKJB6/
	qZrb4MA==
X-Received: from plpm7.prod.google.com ([2002:a17:903:3de7:b0:2cc:77e3:3ef0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2d1:b0:2cc:6817:d9bc
 with SMTP id d9443c01a7336-2d0523e6ee5mr13779535ad.38.1785534098681; Fri, 31
 Jul 2026 14:41:38 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:41:37 -0700
In-Reply-To: <CAO9r8zO-eCz-4Gpa_FUjRKPaDj82PP7et7KON4S5QfhRU2J-Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731195612.2697986-1-seanjc@google.com> <CAO9r8zO-eCz-4Gpa_FUjRKPaDj82PP7et7KON4S5QfhRU2J-Ug@mail.gmail.com>
Message-ID: <am0Wkak_vhy1n_xu@google.com>
Subject: Re: [PATCH v3 00/12] KVM: selftests: Add more syscall wrappers, fix hardware_disable_test
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026, Yosry Ahmed wrote:
> On Fri, Jul 31, 2026 at 12:56=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > Third time's a charm.  Sorry for the spam.
> >
> > Buried in the middle of this is a fix for the hardware_disable_test whe=
re
> > it can end up with a runtime of multiple minutes when running a preempt=
ible
> > kernels on a large NUMA system.  Turns out my analysis/guess in v1 was =
wrong;
> > the problem isn't direct CPU contention, it's that letting the workers =
do any
> > amount of "real" work on any CPUs leads to pthread_create() slowdowns f=
rom
> > the perspective of the caller.
>=20
> How long does the test take to run with this series?

Less than 5 seconds if nothing else is running.  ~12 seconds if I run it
concurrently with mmu_stress_test using default settings, and ~25 seconds i=
f I
run it on an overloaded system (naively running all selftests in parallel).
