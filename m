Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114E34D922
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775621610; cv=pass; b=fxC40j+Egsfk8sVYM5mOUvf+VqEV1CbQ/ndgTflnM/Ty9anjj5HS85YKeXvzF9zQDWSeJVFyse0Jn4yjpccZzAGIOGxyGFWrc2kPaeaMTLgVZcszI53Sgl/hVfpwqg1aqGFzxYS0jVNeuH9a31UKzlUP7guG9wV2p4rz9Yiny+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775621610; c=relaxed/simple;
	bh=mSu21n7FtXaiXm7xUkvFg5Z4GAfXF9LADkpKmy8CBU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwLWbFYfJs0fLChJmaOQt1jefyQA9dL1BAUzniydymKi/kEKmNlsfM96v1WZ3zz9KPsZwok7sTi+CzdgaBlR95gvIe38NM3p+y+68GpdrQ1RljyBlGPILDQzdQkV/fRZuVdGPnChkWtZ4LVffNIbYj6BtXLMZLEcjEFZEgaNwXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlOPUBf8; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlOPUBf8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so2292909a91.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 21:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775621609; cv=none;
        d=google.com; s=arc-20240605;
        b=SoB328PgAPfOpL4O7LAGPiIKyXv9LZHBHD44vFHQu5G1ugocQ+yZz/YpuzL3lNSrI0
         znsQgkOrkcG6xOI5XfYXLMWIG1vRDNlfmFG33WrUC32+fXbPvUFi/zvOGNHFskI3Expd
         tJ5xE2cd1XgB9UK8b13d2bhrwnCvfNVYAAYtkoz+hy+6Tb6hdesUSOpW+KNo9qBXtNAK
         c++x2PpuipkY0XrmMUJyg//GzjSg13PMm1qejYKz5wlF407H18tS42xBJH1X/dj35GrP
         5cvREfO/yMAC1xeoUVzJ+Ayi4GmtlM7/S6/4yJnQIA/0lUkRNQzHqXTj2/B5mTAjzswF
         ioog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mSu21n7FtXaiXm7xUkvFg5Z4GAfXF9LADkpKmy8CBU4=;
        fh=mNwuzDoB9JwQJPad7F+VgACUKm7H12B9iUDvxMXyOOY=;
        b=Zi8NJTROi2nnDyio7YELvRM4uhqv3iqqJaH0HM3+9vTnUsNP9HK/zxhc9P2syypZgw
         EIJtPDDWFol3lBg5qRb/ukWwPEQZuMbTeDN3fy56PcXVOOylo4FCKg2zTZpOnULYae+X
         OEjkb60gNprgqaTI4vk3PHyjUIftbv5oTrP5jRSNR18sJt2h8Zp2i5py0e1XZuIlYE3T
         CpOiMHICQuF0oKp+1PPg9+N2LsCZIyWDxBbDdqQeZR9VHhq+Q0Dyay4AWX8rhDI4Mq11
         DFsX1fht/7hwuW+yKMtS3I1lAYqwrx+YtNA8pizuFsCXdSXUg391cnYBZAMjODGCSIXw
         LkhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775621609; x=1776226409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSu21n7FtXaiXm7xUkvFg5Z4GAfXF9LADkpKmy8CBU4=;
        b=rlOPUBf85DMmPWFiVD05kriRJmZiH71jVCY1+hYVkqkQopganQI6uoiEQirJDaD6Gn
         OfptHV78/3ABCAGrWTTv2usfwW2JRfqku+iqhDEbhPdFixgfKATHmg1wVOu3Dn/EQUZp
         jR4zPkqQoeWvk8QDfy31mWxPvtaaE1iZ5Lr4l5EuHuTRleJ6Aa/MekLO9tdkPLin3eny
         Kdof7R0oUc3xXLwqlfJXjBQqgLmLTH6y7Df1o3YfKteGV/b5jTHrbzkwqsrYgLmHdAhD
         R59jrXgiDyroTVnjNQzg1vGaMHBsaNTTW/QrpZzM9GFi0B1XEhv82Pw2ftuoJ4ZPJP0b
         AYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775621609; x=1776226409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSu21n7FtXaiXm7xUkvFg5Z4GAfXF9LADkpKmy8CBU4=;
        b=D+GwGLAb0LFkh9qr4TCysLmxq0JBu6OvlPowZbC/MRIzmV7AhSR42xdfHgEZHpJ0dH
         p4dCM0SYMFqOWitGlZEM4n6c9RTehiySA7AaYGF8GbFB9Ow34c+xdZ6WS4egZ5Smgfp+
         REFIBVADHptLU4C+cva/BYls2cNCE1Ukhe6ryzijp3L+NEY6yFI0TE/HQbFEgkGL0uOG
         0MOzDrsiDtAF3DZRbBjm045MQeTowSXIawiidoSMMVP+EMuBaiQ3L6UZ+03GrkBjRcEh
         bFbWcda8WOS4eRDFzuo0HT9S56XkdiUElfcjgqt4cL50e58VrEC1rkt8zIfY1yXUipKA
         5quQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUbepfxZYK8ClQyQ1knCRPlZ8EnyzmusoIUof2V2PECMWLi6WqbTVIGx6YNCcBWCcf5fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEresFyAJ/I96d0qy+F5tiCLXKCb6DcgLZZtZy7YJAP+0LRqn
	fivWgbWgwhfH6DR8s2oGC/6O+TCNAYT4WoN5uztd5DiYrgv6g6wMd5ToYrSCsOGQKYu7+EOpmpg
	wzd8ujf35don65S2xkiyY4vtyLMY1//M=
X-Gm-Gg: AeBDieu8kIDusMHYL7ukox2vVyUW6k4lRRkTRu1BR1Z5HMMnHkhL+g8UB/fbdqGZHhN
	chZPGi0lb2daiWcNLjHNRF/4t6a+mUMkQCoaig8ID/p1nFA7+5b3cjLuEaZeL5rBtrGT/hRog3b
	hlgA5I/VVpWk5bT3Jei5keNme9+59TOxyjEPzXsVU9uHmovRdpOoat9+s3oDeu94SKi/2heCT8G
	Xp+v6MisGz+ET6AoqC0g22qI0BONwfNGnj6S3BPB2ZVGli1UZIryZY5aRVkYRouBUJlC85VK7JY
	SNkO6sV+RRKGesMxFOWnRu07TCgFbLdlSQtipLJ9
X-Received: by 2002:a17:90a:dfc3:b0:35b:e529:2d60 with SMTP id
 98e67ed59e1d1-35de68712b0mr18352058a91.8.1775621608929; Tue, 07 Apr 2026
 21:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
 <87v7e3mbgj.fsf@redhat.com> <adU0LAW1h8q9HsGu@google.com> <SN6PR02MB4157F82E4907C1B3305E86D5D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAKdXbaXdSWq-NYk8z6_OtSgb6xsp+GJxrnF2iBMRdk0nfYne=A@mail.gmail.com> <SN6PR02MB4157A58DA24233B77829B59FD45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157A58DA24233B77829B59FD45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Thomas Lefebvre <thomas.lefebvre3@gmail.com>
Date: Tue, 7 Apr 2026 21:13:18 -0700
X-Gm-Features: AQROBzD8Y_tEgQIjbAiFXo2wngetYtmxuzapG1FgBs4QKYX1TeAbwm6u_umXi_c
Message-ID: <CAKdXbaUwVuvnC3L38bOp-EZqf+=PjAi7tCeJJRTTnUFTja6a8A@mail.gmail.com>
Subject: Re: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
To: Michael Kelley <mhklinux@outlook.com>
Cc: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, that's very useful information.

Unfortunately, I can't easily reproduce the issue; I can't seem to get
pvclock_update_vm_gtod_copy() and __get_kvmclock() to run on different vCPU=
s
which was one of the two required conditions that triggered the
unsigned subtraction wraparound
(the second condition being inconsistent values between L1 vCPUs).

I just upgraded to Windows 11 25H2 and my Hyper-V VM config from v9 to v12,
I now see tsc_reliable and constant_tsc in the L1 Linux VM lscpu and
/sys/devices/system/clocksource/clocksource0/current_clocksource is
tsc.
I'll report back if I still encounter the problem when spinning up L2
Linux VMs with KVM.

On Tue, Apr 7, 2026 at 1:40=E2=80=AFPM Michael Kelley <mhklinux@outlook.com=
> wrote:
>
> From: Thomas Lefebvre <thomas.lefebvre3@gmail.com> Sent: Tuesday, April 7=
, 2026 12:13 PM
> >
> > Hi everyone, thank you for your attention to this bug report.
> >
> > Michael,
> >
> > 1. No, lscpu in the L1 guest does not show the flags "tsc_reliable"
> > and "constant_tsc".
> > $ lscpu | grep tsc_reliable
> > $ lscpu | grep constant_tsc
> > $ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> > hyperv_clocksource_tsc_page
> >
> > 2. Windows 10
> > Version 22H2 (OS Build 19045.6466)
> >
> > 3. Hyper-V: privilege flags low 0x2e7f, high 0x3b8030, ext 0x2, hints
> > 0x24e24, misc 0xbed7b2
> >
> > 4. Yes, the laptop hibernates and then resumes.
> > When the problem occurred, the laptop had gone through multiple
> > hibernate and resume cycles.
> > I haven't seen it happen after a full reboot before a hibernate/resume =
cycle.
> >
> > Thomas
> >
>
> How easy is it for you to reproduce the problem? Would it be feasible
> to get a definitive answer on whether the problem repros after a
> full reboot, but before a hibernate/resume cycle?
>
> There's a known bug Windows 10 Hyper-V where the hardware TSC
> scaling gets messed up after a hibernate/resume cycle, causing the TSC
> values read in the guest to drift from what the Hyper-V host thinks
> the guest's TSC value is. A summary of the problem is here:
> https://github.com/microsoft/WSL/issues/6982#issuecomment-2294892954
>
> Of course, this doesn't sound like your symptom. And Hyper-V is not
> telling your guest that it supports hardware TSC scaling, because the
> HV_ACCESS_TSC_INVARIANT flag is *not* set and the clocksource
> is hyperv_clocksource_tsc_page. But my understanding is that the code
> changes to fix the Hyper-V problem weren't trivial, and I'm speculating
> that maybe you are seeing some other symptom of whatever the
> underlying Hyper-V issue was.
>
> Of course, this is just speculation. If the problem can occur before
> any hibernate/resume cycles are done, then my speculation is
> wrong. But if the problem only happens after a hibernate/resume
> cycle, then this known problem, or something related to it, becomes
> a pretty good candidate. Unfortunately, I'm pretty sure there's no
> fix for Windows 10 Hyper-V. You would need to upgrade to
> Windows 11 22H2 or later.
>
> Michael
