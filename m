Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793076789;
	b=SkIQyvsSPlL4MRuBIRwcZtUW156rNbX0m8FGtW+737f0h+R3f3VU+nH0UeOwin+qYla6
	 S0p/irK2Mi9n7KpbkRLdA2onsvB6ApDRCUsrFqUcYhAgyOAGEZurajWwV02m9e/xxGAbh
	 G36amh9ZOk/lJLuzLUlSXA4wE6OGT5FUHo7yoKO8Xm3AHmDNaJ6GPNm+clD5WhY2euqns
	 21Q5gucG+sqlmEJupTVD7XN+PjHYF2U3T4vGnWHUhENyGcwPM0WkvUO3etg+bGyv87FO1
	 AfOipuIsOrnfivMWAkHhADZIugj6AXWnE4Acnawl/RtFtykaPZYSm2ibZEucc5GvNZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=DCDubLpUdcTdTfwK+twCDFU1KNLCrndR6LLOcDTM5d8=;
	b=TOp0FqUPNvsj5owVXO7n6yy1ALovB12tBFSd1PHv7yopEcNynaNggZwt0tl1f/P4NM7j
	 i2UHUOpUpeFn6AxydQiFpEu6bZ596mXjOZnc+TnnAOyc6+cfoDt/NnDDdUeBIHhQSINHk
	 olpjFbq2fEkHd7umgkYuOU/LQWm+KErETxkRvECainoZC9l6ReJt2KqEl+mgYFqayK250
	 r8pFWABOsXUOroVRYKe21gHlMs1cNoOIR2Z1yFlJQoSg+HWQutTGZd0Ntv8d5siKa79NP
	 Vc+wfBG5Xwf49rkw1qCDZdxOQvUd4FrVtG6toYFYlyfQWjDaw5y8IToT06pHtq2RSaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lDZ+cvv0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0248606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 04:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0248606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lDZ+cvv0
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-55c05f69296so620291b6e.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 21:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793076788; cv=none;
        d=google.com; s=arc-20260327;
        b=a2DhsJzihdvAzzaBltAJ4BzEx+MFkSWwdYNgBXsJUs6nIk+hCRUojlqAxZLwZ57FWg
         g7LmflVy0h6vn6F2+xDzDKOwABrp2iPLNuvYauNRNH0pf73ug6QOtviicGHIJ6tmTxiD
         J/M/hCBdIkoj5r1OfaaJtGGklbOpSIpLw0d3xsbBpIsywNLrQaN91Apl6HXHMYopIBkl
         2yCk8+SGfrwftQXuWoy2hK7jeGemqULxGZeJm/4JHQBdwwBOuhZGyzFu6C0a/rDMTUm1
         iQ8vzst26UV+zytvsatHLtU9HlnfJH3ZW7oCjLuUl29Cn/dym7Eyf1YfzmLzcd/4b0kO
         CJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DCDubLpUdcTdTfwK+twCDFU1KNLCrndR6LLOcDTM5d8=;
        fh=SkYeDQHuSnkUsj0t+mHHuwFo/r0J494Vr5wO1orZ1B8=;
        b=K+SjJ3CTtwel7dGFUuZvdRuK/ysASp1iMuEUUok4Zuzlho3phfPilutcAo0kM6+j3y
         Og40ZBb3a8USD4dDcaCHUX4UFMu5OKJfD945ebf9iJUk9MLbYUbURhg+ep3LHxUyFAHy
         QxcVp6MzHQI9fmIsHF3Lt8lMzj11JDxImVwxhxOWMvM1a2XEgV4AEBGa+5Eg0s8rIU5b
         +44K9ZG7Ir85Qupc56KBk5tHRJ7mijN/7V/x+z8MXc9fqAzsDgNVl2AYWMEWP9vXUAZz
         zrbiHKGXT5oqEXJ0AEuPww+b6ZyzZRnKMuFturQm1dLX/8zd2BvqHi+mY7nnJbtivX3D
         hebA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793076788; x=1793681588; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DCDubLpUdcTdTfwK+twCDFU1KNLCrndR6LLOcDTM5d8=;
        b=lDZ+cvv0cElMCo/DUbpS+7/oGhuhBtW6iPpuw9BVfujoWuVqFSa9Zg2J/nziHNIf0A
         46xzTlm0H3DLFz43QRhf+gBwBXjZ0ZyCo4CN/20QusBKSYuri3ebtU84+C39gNvgWQUl
         rdOFhKBnJZE09iyJF7RYcHerc6WVPpBb9Knp8QYf8FHIF9+9aKsNOHtEP1fgE0ljXzvx
         oEKPw80gHfFfDKuXCtoEvxuRft5f9jJU/l3OxpzR+FaEAJiJ4fJzeJiUTfF7Yw8P5sJg
         /aCEdMa6Jv0cunFHyDg9bh7Sz7FlKobDiFu6z+JLm1Iz6zZ5w8dzXM/xZwU+F+tNIuKI
         ZmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793076788; x=1793681588;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DCDubLpUdcTdTfwK+twCDFU1KNLCrndR6LLOcDTM5d8=;
        b=CnveU3BIhV+JY7bIkbWhHBvv1OXsd7pNlnaILInr0lAkLOWGqHYcWUve3L1n81TD7P
         iNCV0n8HVEfcavjlVaVc0wCnwVp5P2WWKIxaCj3v+YBsh8m/O4e/QGHeWHXksq6y2cyR
         nRyLYuc1aeh2X2BRer7egP2BWBBplY6IEpcI8fXtWSElSYbfV9SKdwQAozsY+AxEzgQH
         tfet4GbnPb9vmSMXvGLq3DuIcQ2SNANcsIbiTHuOflTlUNQt8a3ds37SiAgRs6ijcWf4
         0gTqJeaY2cBgEqjGY308uj/+hVAZOJOVSC5L7vW02i+G/1LgOgNIlwLSLRItT2tj+C7Z
         wGkg==
X-Gm-Message-State: AFq9FYLJ0LN3735Wonskr2yRysYS7VhjyrG9k3ECA7St98Q85qfK822R
	H2h+W5ZdFH6OEBnnk8uZXuVAI0ZDXea0k3E9bghR7MwkteDrgD0kmLPF+uhJWtDT6fKnVyXRUC3
	M1qRrT3a4BQIwtkF3flBZXils3dOMWEdSSPsn
X-Gm-Gg: AYBFou14fQSLYzzN9NDY6XCEFKGhV3zie0qQWL9Pm3lR3m63gz/EB+JiHfsK1+KpY7l
	4KmKfHgWa99VKnN5+nZcCree3qOHL4HyEYyb57h1BdwVSPWsziGW63QSEtOgJWsgsevr1Tj9S9j
	pGSyPKdTHO+8FRTWwz/7PXoQRreV+Tld0hW6M5bbJS5hd0ICtrqsMgttGsXQTMhfbmQmRIK/k7R
	7/RTML4qBFGx6g4GE4L9ywuhOsp1jHvbVpBtrVtKA3Yg1wUvF9/IjM3qaVkgagseJDyJY13hNbP
	uA5yp8/Y4MlnJ6Ivzz29dLkVOVn/fWyaPirGg/RU9gXR/hFG4lR1UB35EGXPOXi688Q6EfkEDa1
	o4JDV9SAGf+cposXgkA702QSctqORoLP16vz0zyk7gZ9ci7KRwctWWArrO+uniWJWn7SkvKzx22
	uRtv8qN2pyrBMkazjspMnvsVBRXgjmX7PjEED7GTAXnvDOIT6s6MeE6o+C
X-Received: by 2002:a05:6809:24d:10b0:55c:a67:d111 with SMTP id
 5614622812f47-55c0a67e298mr3242952b6e.19.1793076787598; Mon, 26 Oct 2026
 21:53:07 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Sam H <sam.martin.howell@gmail.com>
Date: Tue, 27 Oct 2026 14:52:57 +1000
X-Gm-Features: AclHuK-TsAvmDveBO8uRBsyC0lDErqOWNb-fsZTA-Pv7X2-qgEmi-FUOhLZ8rck
Message-ID: <CA+qxPTe6Dh7Yafw5zRJg1HxU61z7SvZuCOHDrpY2xe5X+M68iQ@mail.gmail.com>
Subject: KVM: SVM: 32-bit PAE Windows 2000 guest crashes with AVIC on Zen 2
 (EPYC 7402), reproducible in seconds
To: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey KVM Team,

I have a 32-bit Windows 2000 guest running the PAE kernel that
bugchecks within 15 to 134 seconds under a process churn load on an
AMD Zen 2 host with AVIC enabled. The same guest survives the same
load with AVIC off, or with PAE off. I have a disk clone that
reproduces it on demand and can test patches against it.

Host
- 2 x AMD EPYC 7402 (family 17h), microcode 0x830107d
- Proxmox VE 9.2.21, kernel 7.0.14-25-pve, QEMU 11.0.3 (pve-qemu-kvm 11.0.3-4)
- kvm_amd: avic=Y, enable_ipiv=N, npt=Y
- Also crashes on 6.14.8-2-pve (no enable_ipiv parameter on that kernel)

Guest
- Windows 2000 Datacenter Server SP4, boot.ini /PAE /3GB (ntkrpamp)
- Crashes on both the SP4 kernel (5.00.2195.6717) and the Update
Rollup 1 kernel (5.00.2195.7045)
- -cpu kvm64, machine pc-i440fx-5.1, 2 sockets x 4 cores (8 vCPU),
8192 MiB, numa on
- Extra args: -machine hpet=off -rtc driftfix=slew -global
kvm-pit.lost_tick_policy=discard (the PIT policy is what keeps AVIC
active for this guest)

Crash
- STOP 0x0000000A IRQL_NOT_LESS_OR_EQUAL, IRQL 2, always in ntkrnlpa.exe.
- SP4 kernel: 0x0A (0x00000154, 2, 0, 0xDD537EAF), ntkrnlpa+0x137EAF,
mov ecx,[ebx+0x154] with ebx = 0 or 0xF000FF53 (the real mode IVT
pattern, i.e. the contents of guest physical page 0).
- UR1 kernel: 0x0A (0x00000098, 2, 0, 0xDD53C9E6), ntkrnlpa+0x13C9E6,
read of [esi+0x98] with esi = 0.
- One write variant was also seen: 0x0A (0x00000098, 2, 1, 0xDD53C84C).
- The faulting code is the PAE memory manager's hyperspace page table
walk: it maps a page table page into a per-CPU hyperspace slot by
writing a PTE, then reads through the slot, and the read comes back
zero.
- When it crashes, 7 of the 8 vCPUs are stopped at the same EIP
(0xDD4335C3) and the crashing vCPU is at 0xDD06A1A6.

Reproducer
6 concurrent sessions, each looping 200 short cmd.exe processes plus
one debug.exe, so heavy process create and exit.

Results on the clone (stress started after boot, same disk each time;
8 vCPU 2x4, kvm64, numa on, 8192 MiB unless stated)
- AVIC on, /PAE /3GB (baseline): crashed at 134 s
- AVIC on, /3GB only, no /PAE: survived 300 s
- AVIC on, /PAE /3GB, 3584 MiB (no RAM above 4 GB): crashed at 26 s
- AVIC on, /PAE without /3GB: crashed at 30 s
- AVIC on, /PAE /3GB, QEMU vapic=off: crashed at 26 s
- AVIC off (PIT reinject), /PAE /3GB: survived 600 s, twice
- AVIC on, /PAE /3GB, repeat with tracing: crashed at 15 s
- AVIC on, /PAE /3GB, 1 socket x 8 cores: crashed at 50 s
- AVIC on, no /PAE, 30 minute soak: survived 1800 s

The production copy of the guest also crashed 3 times in one day on a
single vCPU with AVIC on (7.0.14-25, enable_ipiv=N), so one vCPU
lowers the rate but does not remove it. Setting the CPU vendor to
GenuineIntel made no difference. During a traced run the AVIC IRQ
window toggled about 1 to 2 times a second, so I do not think it is
the IRQ window inhibit issue.

The same guest image ran on an Intel Xeon E5-2620 v4 host (Proxmox VE
5.4, kernel 4.15) for years and has no crash dumps on its disk from
that time.

What I have not tested: npt=0, because AVIC needs NPT, so npt=0 would
also turn AVIC off and could not tell the two apart from the AVIC off
run above. It would also be a host wide change on a host running ~70
other production workloads/guests, and we can't risk performance
impacts. Also kernels other than 6.14 and 7.0.

A possibly relevant difference: AMD APM Vol 2 section 15.25.10 says
that under nested paging the guest's PAE PDPTEs are not loaded at MOV
CR3 the way they are natively or under Intel EPT. I have not proven
that is the mechanism, and the AVIC off result says interrupt delivery
or timing plays a part as well.

I can provide the two minidumps, register captures of all vCPUs at the
moment of a crash, and KVM traces, and I can run any patch against the
clone.

Thanks,
Sam Howell
