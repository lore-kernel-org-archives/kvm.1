Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BC34A788
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589217; cv=pass; b=VCPx2C8y4WeV5fw+NnRPL4yGY/wWLJP63J4jEbgSINwBzeqoH6uzWBSFN9lAHRYRAYO8HdBRCgbRjYtFr13eOiOX7LjnOvVi1yKsE+o1GexNhWcy6Mtz0qrIOsVh97nJSBGdve7F+4ya+skSC3N4AfhcIzlD6BGEFuDGZ+Rpazg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589217; c=relaxed/simple;
	bh=70tWaAzZa+jzrQnDv2R9Rxn4KZ9eR0MLbNZz/k7omYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0zAmW9iIq6iOT4y30WdccEvjxIdDtbb6YbmHtaEETrxiv92u5fb3+32XtbTA3KRHCZs8nqAVKNNUiCxGFlTAZJo3Z3NuAMA0QNDgmjTzWpe/HTvsCqnBUcct2Et0AwMZ7I6apHNGydeuwO4MGKFc7wBegzi2EJReQxi0wKVRqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvluTWE0; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvluTWE0"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82cf96ca071so2416897b3a.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 12:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775589215; cv=none;
        d=google.com; s=arc-20240605;
        b=CD6o6ieYctZIkcrYs3epJA+nQXKfEEdpcXGtk6hFStRKKYhWPdAACvSwy6QVrBtEDH
         RWur5P70mMTicEQAp+nk22f128kcAf+li/dm1ZOHzFElp55dPKgNEtqlbOYsKqWtkocO
         ekSjz9R/6AtfCLEi3dqz/EcJHXmofyVOpDAa0z22x0JUnvJLiq4BXxA84xbVxzAkQxXL
         bdKWRd3bbsiD+mhq9xTb8sLrMkFJGafzFdJxOLC3fDm6Q9VzgPVVFMT7EJ8AevY9iKXL
         K0cCK0dQHUgvOi1tIlmsQiJUiXQ/e7/aCOA8U2MvMaiLqVcWO6/mt+iwN9ePZr3aaAWQ
         zMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKKNNefQ6F4KOIwdpnmoM01ICjxZ7ueWf3b8LgkodGg=;
        fh=bGfbQ39Om8I5QbU3OvJxMJ/VQrFKS5AsNViS0/sSW5I=;
        b=WxnBjhFHn6ZNZ/Yann7q3UfpaviodAciWdgYXhLk+AcxGvdv1qJ+lj7Y/Qe9kU1eRr
         KCGJ7O743BuBtqgodsABA+yJ5JE7I78Z3NIb3AoE6yMw+mCJaSw2YGE95rov7lSthjlD
         NnGtVKQdUYAcOvINBWbqtTofZyt6fujB1Gl+VH9LGM6ZYkhvvoVKck31jHgQbmDdnozf
         5nc+rXYorIByFgD4rqF3qJ1Qn89mxT4f6kU5vYWag1M5fL+NuKfKB26g2BqkHImWVWYt
         MxVmj6s3tUzJ2NYHKf643EOJDDRm3jq6SJqC0V/DZLd9CxXZ1YGXLkBo722dFFlKq/9O
         89sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589215; x=1776194015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKKNNefQ6F4KOIwdpnmoM01ICjxZ7ueWf3b8LgkodGg=;
        b=OvluTWE0YhnreMuM0K9gWAZYMBLSYPuD/jIyvn5B/C7deIU1zqDjKrzyws17zmLUM3
         xsR1fi2Co8Ousq2u6cUTeAUSGyiczwL73NgpA5ECyLMj46E5g/E7BKUTP2nLsXiqYNb9
         1s1LctPWvcDkHo2G07zIfPMtaYVb3kWCBnDck4deQNqgN+EEyyHKTb8010ZSdACIhdUr
         48zq0Nimii9FsLKKk9eM4wWMc5USPm5YKiXxZqUqP76sm0YsTnmtSMatzWS/IraUR9nD
         mPSAOkXCROq+al+5UHftVqB3723JgKSmGK2TrmfAhRmokQw/6n8JP6d902/tGsRmncSt
         xRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589215; x=1776194015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKKNNefQ6F4KOIwdpnmoM01ICjxZ7ueWf3b8LgkodGg=;
        b=c0NN/mPmTWk1QlRiQRvqEcLaYmTL4oycH9BWARd7GVOinFf4U96YlurCVVxjBpoZ+q
         47AB3aEVKix+iijh0kSwYUPXu38QmCCUK5ZR4k4B2chZSoZOKLj2xwKA6HgceWyYlUxk
         p2WBAY9spqetEn4mlU/B1W0iX+kuUZmvf+3q2cVmfyvxMBWBu0dyyT5mAs2CQC88F5gM
         lgwdi0BpVPhn9vsV+4Ape0gT08iBVwboLg3npfRZuxM1PJWPtyDj8AtYSZpq/jgcCvVL
         i5yiC+u1x3BLLDBwZlXAAuaGBDpHQ/OGoff4lQWF8kyn+9Tx8DYjLVuTYlqCqkZsT7QR
         VCSw==
X-Forwarded-Encrypted: i=1; AJvYcCUbebtxxJmWVy3PsFFNzizji1T3u4+y2Wr0WZYWDyuf3Mo2tXEg3EPtjKMAOtetBBTprHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYo9aiL0ziKYHespJ6xGrWkLHacb4KYcLvkapK2YMZPjZt6Rq0
	b4v624/nL4Fo0De3lbkjrX9yvERaul0yhpbylKw2opgiUAECtr57+cpgyPcUekaW3oGVZ7/i3XS
	DDJx60qoEkdfsQOaUItRTL+EgZzwDpEw=
X-Gm-Gg: AeBDieuHjInmhrv4iAxVrZZaW5qbExYb5wNGa+L9UM9Fk6gxTvpHrIO0B2KEsFFyPa8
	du1qi8yzkTDQm8nKlmjTiySHdfp8UG7yrX+IoLuAkVRsvsueg1+MBDlKYRA3cch94ft4EezVc5u
	UK1p7/SS1Cr+9luxNbfhIe/OOh9n5VIbHWLUQJ7TS+O9yO+MZIJz+tUv53wTNIycfJtH36Ferm4
	dvDGUpJ0QNT7qMHHnW9agGjYuUdO32EXFZFeCyowv1KJEII2LeBha6Bov+4E/LZlloe+u67qczl
	S91y1qMFGOlYs3+V4v+TWI5PS+oqq82/VrDEJg1UqNLbMyHEkIM=
X-Received: by 2002:a05:6a00:13a3:b0:82c:6aee:b232 with SMTP id
 d2e1a72fcca58-82d0dbb6bcemr17847195b3a.45.1775589215239; Tue, 07 Apr 2026
 12:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
 <87v7e3mbgj.fsf@redhat.com> <adU0LAW1h8q9HsGu@google.com> <SN6PR02MB4157F82E4907C1B3305E86D5D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157F82E4907C1B3305E86D5D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Thomas Lefebvre <thomas.lefebvre3@gmail.com>
Date: Tue, 7 Apr 2026 12:13:24 -0700
X-Gm-Features: AQROBzB6n2L3p3eiSH6AzW8E7pKt0evKvgrqHUehDDdOUES-tfa9ZTYQ7r_VkSM
Message-ID: <CAKdXbaXdSWq-NYk8z6_OtSgb6xsp+GJxrnF2iBMRdk0nfYne=A@mail.gmail.com>
Subject: Re: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
To: Michael Kelley <mhklinux@outlook.com>
Cc: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone, thank you for your attention to this bug report.

Michael,

1. No, lscpu in the L1 guest does not show the flags "tsc_reliable"
and "constant_tsc".
$ lscpu | grep tsc_reliable
$ lscpu | grep constant_tsc
$ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
hyperv_clocksource_tsc_page

2. Windows 10
Version 22H2 (OS Build 19045.6466)

3. Hyper-V: privilege flags low 0x2e7f, high 0x3b8030, ext 0x2, hints
0x24e24, misc 0xbed7b2

4. Yes, the laptop hibernates and then resumes.
When the problem occurred, the laptop had gone through multiple
hibernate and resume cycles.
I haven't seen it happen after a full reboot before a hibernate/resume cycl=
e.

Thomas

On Tue, Apr 7, 2026 at 11:37=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Sean Christopherson <seanjc@google.com> Sent: Tuesday, April 7, 202=
6 9:43 AM
> >
> > +Michael
> >
> > On Tue, Apr 07, 2026, Vitaly Kuznetsov wrote:
> > > Thomas Lefebvre <thomas.lefebvre3@gmail.com> writes:
> > > > Under Hyper-V, raw RDTSC values are not consistent across vCPUs.
> > > > The hypervisor corrects them only through the TSC page scale/offset=
.
> > > > If pvclock_update_vm_gtod_copy() runs on CPU 0 and __get_kvmclock()
> > > > later runs on CPU 1 where the raw TSC is lower, the unsigned
> > > > subtraction wraps.
> > > >
> > >
> > > According to the TLFS, reference TSC page is partition wide:
> > >
> > > "The hypervisor provides a partition-wide virtual reference TSC page
> > > which is overlaid on the partition=E2=80=99s GPA space. A partition=
=E2=80=99s reference
> > > time stamp counter page is accessed through the Reference TSC MSR."
> > >
> > > so if as you say RAW rdtsc value is inconsistent across vCPUs, I can
> > > hardly see how we can use this time source at all, even without
> > > KVM. scale/offset are the same for all vCPUs.
> > >
> > > I think the fix here is to avoid setting up Hyper-V TSC page clocksou=
rce
> > > in L1. Unfortunately, with unsynchronized TSCs this will leave us the
> > > only choice for a sane clocksource: raw HV_X64_MSR_TIME_REF_COUNT MSR
> > > reads.
> >
> > This feels like either a Hyper-V bug or a Linux-as-a-guest bug.  For "R=
eference
> > Counter"[1]:
> >
> >   The hypervisor maintains a per-partition reference time counter. It h=
as the
> >   characteristic that successive accesses to it return strictly monoton=
ically
> >   increasing (time) values as seen by any and all virtual processors of=
 a
> >   partition. Furthermore, the reference counter is rate constant and un=
affected
> >   by processor or bus speed transitions or deep processor power savings=
 states. A
> >   partition=E2=80=99s reference time counter is initialized to zero whe=
n the partition is
> >   created. The reference counter for all partitions count at the same r=
ate, but
> >   at any time, their absolute values will typically differ because part=
itions
> >   will have different creation times.
> >
> >   The reference counter continues to count up as long as at least one v=
irtual
> >   processor is not explicitly suspended.
> >
> >
> > And then "Partition Reference Time Enlightenment"[2]:
> >
> >   The partition reference time enlightenment presents a reference time =
source to
> >   a partition which does not require an intercept into the hypervisor. =
This
> >   enlightenment is available only when the underlying platform provides=
 support
> >   of an invariant processor Time Stamp Counter (TSC), or iTSC. In such =
platforms,
> >   the processor TSC frequency remains constant irrespective of changes =
in the
> >   processor=E2=80=99s clock frequency due to the use of power managemen=
t states such as
> >   ACPI processor performance states, processor idle sleep states (ACPI =
C-states),
> >   etc.
> >
> >   The partition reference time enlightenment uses a virtual TSC value, =
an offset
> >   and a multiplier to enable a guest partition to compute the normalize=
d
> >   reference time since partition creation, in 100nS units. The mechanis=
m also
> >   allows a guest partition to atomically compute the reference time whe=
n the
> >   guest partition is migrated to a platform with a different TSC rate, =
and
> >   provides a fallback mechanism to support migration to platforms witho=
ut the
> >   constant rate TSC feature.
> >
> > My read of "Partition Reference Time Enlightenment" is that it should o=
nly be
> > advertised if the TSC is synchronized and constant.  I can't figure out=
 where
> > that feature is actually advertised though, because IIUC it's not the s=
ame as
> > HV_ACCESS_TSC_INVARIANT, which says that the virtual TSC is guaranteed =
to be
> > invariant even across live migration.  And it's not HV_MSR_REFERENCE_TS=
C_AVAILABLE,
> > because I'm pretty sure that just says HV_MSR_REFERENCE_TSC is availabl=
e.
> >
> > Michael, help?
> >
> > [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows=
/tlfs/timers#reference-counter
> > [2] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows=
/tlfs/timers#partition-reference-time-enlightenment
>
> Yes, TSC page enlightenment is per VM, so it does not compensate for
> discrepancies in raw TSC values across physical CPUs. RDTSC in a
> Hyper-V VM is executed directly by the hardware (i.e., does not trap to
> the hypervisor), so there's no opportunity for the hypervisor to compensa=
te
> for discrepancies. The hypervisor is expected to present a VM with TSCs
> that are already synchronized. I'll need to double-check, but I don't thi=
nk
> Linux guests on Hyper-V run their own TSC synchronization.
>
> The relevant Hyper-V flags are:
> * HV_MSR_TIME_REF_COUNT_AVAILABLE:  The synthetic MSR for reading
>    the partition reference time is available.
> * HV_MSR_REFERENCE_TSC_AVAILABLE: The partition reference time
>    enlightenment (i.e., "the TSC page") is available as a faster way to r=
ead
>    the reference counter.
> * HV_ACCESS_TSC_INVARIANT: As Sean said, this says the hardware and
>    Hyper-V support TSC scaling, so live migration can be done across host=
s
>    without the guest seeing a change in TSC frequency.
>
> Yes, this does feel like an issue where Hyper-V is not presenting the gue=
st
> with TSCs that are already synchronized. But I'm not aware of having seen
> such a problem before. I'll try to imagine a scenario where a problem lik=
e
> this could happen via some other path.
>
> @Thomas Lefebvre:  Let me double-check a few things via these follow-up
> questions/actions:
>
> 1. You said the clocksource is hyperv_clocksource_tsc_page. Just to
> confirm, that's for the L1 guest, right? Does the output of the "lscpu"
> command in the L1 guest show the flags "tsc_reliable" and "constant_tsc"?
> I'm assume "no", since if these flags were set, the clocksource (i.e.,
> /sys/devices/system/clocksource/clocksource0/current_clocksource)
> should be the standard "tsc". I've got a laptop with a i7-13700H processo=
r,
> and my L1 VMs show "tsc" as the clocksource, but I haven't been running
> KVM with L2 nested VMs.
>
> 2. What is the version of Windows/Hyper-V you are running? Get the
> output of the "winver.exe" command. It should be something like this:
>
> Windows 11 [as the top banner]
> Version 25H2 (OS Build 26200.8037)
>
> 3. In the dmesg output of your L1 VM, find the line like this one and rep=
ly
> with what you have:
>
>     Hyper-V: privilege flags low 0xae7f, high 0x3b8030, hints 0x9a4e24, m=
isc 0xe0bed7b2
>
> From there, I can decode the Hyper-V settings and see if anything jumps o=
ut
> as anomalous.
>
> 4. Does the laptop where you are seeing this problem ever hibernate and
> then resume? If so, do you recall if the problem occurs after a full rebo=
ot but
> before it ever does a hibernate/resume cycle?
>
> Michael
