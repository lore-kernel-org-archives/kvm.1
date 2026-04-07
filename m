Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A55270ED7
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580207; cv=none; b=K+YZVAyQXLvTSY+U7trWaF/ngaf3BvZd8KU8ZbWa0mOaMz3bk5//Tlx9WZVM1yZLzLfqFxek2tLirAJMFfjVJ7/UbCjQVPTI24VN6pgjUFn9ZjKukKM76T0o9uwV31NdSw5ReaQHL7ZaK+ULSSHoeUPxhuEMtEGXa+WdpfCFWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580207; c=relaxed/simple;
	bh=piKGVge9Yb6LzViiwrtHIfs8Cp1CAE8dyjebH7tdWu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cl/51KuH+/W6zI3QhayodjOoGLGBsaUaMFmnoZ90l11im59iMgMcAALHeqHthnJEoI5oIy7E+L3G4Vwoz/gJrLevYHgAJD698lOXJu9g3TUrhGkBx69QdWZM1UkbkIWMe8IY3BkvA11LE4Zo0oKlqF+i2PeqNqpas5joNyNxNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4wu38Wi; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4wu38Wi"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce0a9e558so3615725b3a.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775580206; x=1776185006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsGIQx+4wtk7Ww8hRZpziV10Jym6LxKEhHGykJkgBK0=;
        b=l4wu38Win1m3WS8fJPIk2m6EVfMfdexWL1QHEm1OyNX4vaktDu1c8XhklswuQwu+gO
         y0bG3T3VDBFeg8/0vS5mj9KrFwPAzlrqXyBUgBBKWQTZRjLkvn41+Hi1EtrndR6ya16e
         74yccpZQcKlgpk6xQVfhKpJn3LQ407gfNFFWMcLyKtdiHj39m62fRz9oXK1RJyM6YtYz
         aaxSIwvl8jsq78pDaDGlhoTTcLuzF3UhmkaTIcZ2ttNnTTIIh8/yC2sHMhg84PZF0YFX
         idTYSD0iav1HIAwxk5RVpI//njy7aJ1d28YjY/hF8tubmYEGLvGhMLQrzr2mahjqBUz9
         2u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580206; x=1776185006;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SsGIQx+4wtk7Ww8hRZpziV10Jym6LxKEhHGykJkgBK0=;
        b=aGm6vvItWjvQVFS5nyVA7nYKt58AoK3c7iKqo10l7HNuUgKxOhJh434KQm2qkYTJ2o
         iohTGTTp2JO4Pfkk0B66OyOlL7HP56Bj30Txsw28GZjCM/zsGI8QRViegzo151HKp2gm
         UlzQanltF1kSj1W9urfX3XZtY2b2XUyP41W4LvquLKWCuHsEF+zllClw/i+MwLcae7Fd
         Off3QVXm/7D0R8svBcdtCzWd2tHNLG3CtDGKE3norJ2CedNt2I7jfkbXGTa7rL3GOqBm
         LEwom7POWPb9aaiFJRqIVZP+OWKifLckyeArc7Z17YXU9qNKhJYCn8NX9vJlCGw3aNDk
         9hbA==
X-Forwarded-Encrypted: i=1; AJvYcCWZvW+6VEZSKqibsOmM+/9QRv5KKakf81Y068GkCWHXGh6kXyjQ+MhmEBWhHgB4j0NiwP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBb2cnbubzL1t9xIXxVdxrcW2Vw967LwC91EFJSA4BuPQ2B9XJ
	xvf0adUrrzhqj3gw+mWJleoAT3eBzjCe9Z4N8DKK42rSBxUkXCcJiZtisOLnBkf0wHmowG2qTTR
	AWwtEhg==
X-Received: from pfld9.prod.google.com ([2002:a05:6a00:1989:b0:82c:6f5f:fa9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:13a8:b0:82c:9c90:58c9
 with SMTP id d2e1a72fcca58-82d0da34825mr15902553b3a.4.1775580205724; Tue, 07
 Apr 2026 09:43:25 -0700 (PDT)
Date: Tue, 7 Apr 2026 09:43:24 -0700
In-Reply-To: <87v7e3mbgj.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
 <87v7e3mbgj.fsf@redhat.com>
Message-ID: <adU0LAW1h8q9HsGu@google.com>
Subject: Re: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Thomas Lefebvre <thomas.lefebvre3@gmail.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+Michael

On Tue, Apr 07, 2026, Vitaly Kuznetsov wrote:
> Thomas Lefebvre <thomas.lefebvre3@gmail.com> writes:
> > Under Hyper-V, raw RDTSC values are not consistent across vCPUs.
> > The hypervisor corrects them only through the TSC page scale/offset.
> > If pvclock_update_vm_gtod_copy() runs on CPU 0 and __get_kvmclock()
> > later runs on CPU 1 where the raw TSC is lower, the unsigned
> > subtraction wraps.
> >
>=20
> According to the TLFS, reference TSC page is partition wide:
>=20
> "The hypervisor provides a partition-wide virtual reference TSC page
> which is overlaid on the partition=E2=80=99s GPA space. A partition=E2=80=
=99s reference
> time stamp counter page is accessed through the Reference TSC MSR."
>=20
> so if as you say RAW rdtsc value is inconsistent across vCPUs, I can
> hardly see how we can use this time source at all, even without
> KVM. scale/offset are the same for all vCPUs.
>=20
> I think the fix here is to avoid setting up Hyper-V TSC page clocksource
> in L1. Unfortunately, with unsynchronized TSCs this will leave us the
> only choice for a sane clocksource: raw HV_X64_MSR_TIME_REF_COUNT MSR
> reads.

This feels like either a Hyper-V bug or a Linux-as-a-guest bug.  For "Refer=
ence
Counter"[1]:

  The hypervisor maintains a per-partition reference time counter. It has t=
he
  characteristic that successive accesses to it return strictly monotonical=
ly
  increasing (time) values as seen by any and all virtual processors of a
  partition. Furthermore, the reference counter is rate constant and unaffe=
cted
  by processor or bus speed transitions or deep processor power savings sta=
tes. A
  partition=E2=80=99s reference time counter is initialized to zero when th=
e partition is
  created. The reference counter for all partitions count at the same rate,=
 but
  at any time, their absolute values will typically differ because partitio=
ns
  will have different creation times.
 =20
  The reference counter continues to count up as long as at least one virtu=
al
  processor is not explicitly suspended.


And then "Partition Reference Time Enlightenment"[2]:

  The partition reference time enlightenment presents a reference time sour=
ce to
  a partition which does not require an intercept into the hypervisor. This
  enlightenment is available only when the underlying platform provides sup=
port
  of an invariant processor Time Stamp Counter (TSC), or iTSC. In such plat=
forms,
  the processor TSC frequency remains constant irrespective of changes in t=
he
  processor=E2=80=99s clock frequency due to the use of power management st=
ates such as
  ACPI processor performance states, processor idle sleep states (ACPI C-st=
ates),
  etc.

  The partition reference time enlightenment uses a virtual TSC value, an o=
ffset
  and a multiplier to enable a guest partition to compute the normalized
  reference time since partition creation, in 100nS units. The mechanism al=
so
  allows a guest partition to atomically compute the reference time when th=
e
  guest partition is migrated to a platform with a different TSC rate, and
  provides a fallback mechanism to support migration to platforms without t=
he
  constant rate TSC feature.

My read of "Partition Reference Time Enlightenment" is that it should only =
be
advertised if the TSC is synchronized and constant.  I can't figure out whe=
re
that feature is actually advertised though, because IIUC it's not the same =
as
HV_ACCESS_TSC_INVARIANT, which says that the virtual TSC is guaranteed to b=
e
invariant even across live migration.  And it's not HV_MSR_REFERENCE_TSC_AV=
AILABLE,
because I'm pretty sure that just says HV_MSR_REFERENCE_TSC is available.

Michael, help?

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlf=
s/timers#reference-counter
[2] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlf=
s/timers#partition-reference-time-enlightenment
