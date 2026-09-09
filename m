Received: from mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF575519B5
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956633; cv=none; b=HBUlUFCz+bHR4fYrFFZ/pi6UlvGzuGKarsmY9rlhhFKAI3M5G+I66Sz+YmXEgMWN1f7Ukqu1jzLebUih81KkijE4GV/CcHWFpZDjxQioDwkHiUkmcQvPYMaIb6KGBB93J1kXw+1daVzHmIMC4nHuMVsp4g+Z2LEtRB6KP3qigzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956633; c=relaxed/simple;
	bh=Cp5gjjtRZvsGv/c5qbUz1QdnpXy0ZN7bcc5rSOhblwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBdt2XV4Tp5tknSVZtn1fgIxylSh48f/5AuyzcpVNZdswJR73S+uaXuNKg777/Hb6kXd+1fFSZCSu/ysRN7BqX8zh2HkbbU8pksXiPvLtaUM5T4KO7JWFXNDGKQsPMWHCR6fd9yUw8SrnLYdci9VFW2EabIWBvv6GyLvmnSta4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QeyZEueA; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QeyZEueA"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Cp5gjjtRZvsGv/c5qbUz1QdnpXy0ZN7bcc5rSOhblwE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788956628; v=1; x=1789561428;
 b=QeyZEueAsyVMG3aJ9xVDectn6k0lo6ZSMBP0DDdCsaJQbWN1ovus13E4PHPBb+XBa0ZNWXRF
 Uyg6sOQH1oiaTktOvrqrCuCRhDfEZ6crWMZsRNegqUixuEyXoh3hOgfj9WcxTkmUsmBl6OEYoPE
 LuX/p9+IuDToSABd8BHMCHI0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 686445b5203a50fd;
	Wed, 09 Sep 2026 12:23:48 +0000
X-Mizu-Trace-ID: 686445b5203a50fd
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b384c4so6269e87.1
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 05:23:44 -0700 (PDT)
X-Gm-Message-State: AFuF++nd5jvLQR/VYkQrmUOw9KHxN+6LGIy9Ai3+UcsFuF3qFe8T4QpA
	0ZG9odekwxczvobF9cMYI0yXuox80fbFMTjsGMHaSbc5xAmtprYOl6nipGmu4vVevGHiGxJ7lJv
	g94kpvxx5OtbKgOB4ZSUJMtmRztA6zTNoNADulAI7
X-Received: by 2002:a05:6512:3b14:b0:5ae:b9c5:f29f with SMTP id
 2adb3069b0e04-5b7654ce193mr107092e87.2.1788956623620; Wed, 09 Sep 2026
 05:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908162223.1683432-1-suzuki.poulose@arm.com>
 <20260908162223.1683432-11-suzuki.poulose@arm.com> <CA+EHjTw9ReyvsNT=y+-P6ng7VQ6Pvz9PFK9bO71qvTR1pOxx5Q@mail.gmail.com>
 <6152fc41-65f0-460f-90b4-1454c11bcba6@arm.com>
In-Reply-To: <6152fc41-65f0-460f-90b4-1454c11bcba6@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 9 Sep 2026 13:23:07 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxjk1JLR7Tf5LEfB_xypbUWnw3G3H-FT7bTE=nWTTRgAA@mail.gmail.com>
X-Gm-Features: AcwNN1UdAORP9MO5wBUrYIVset4_Bi4mGv_qouuDykVa7m9ydt_n5FV9_UkyP28
Message-ID: <CA+EHjTxjk1JLR7Tf5LEfB_xypbUWnw3G3H-FT7bTE=nWTTRgAA@mail.gmail.com>
Subject: Re: [PATCH v17 10/20] KVM: arm64: coco: Disable Steal time accounting
 for coco guests
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Wed, 9 Sept 2026 at 12:52, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
...

> > I think it would be better to leave KVM_CAP_STEAL_TIME reported and
> > instead reject the configuration for these VMs, returning -EPERM from
> > the KVM_ARM_VCPU_PVTIME_CTRL attr. A capability query should report
> > what the kernel supports, not whether a given VM may use it; gating it
> > per-VM here is also inconsistent, since the !kvm clause leaves the
> > system-fd cap at 1 while the VM-fd cap reads 0. And -EPERM says that
>
>
> But isn't that we want from a VMM perspective ? i.e., enable PVTIME if
> it is supported for the given VM (type). Rather than PVTIME is supported
> by the KVM, so I can go enable it by default. But, we endup getting a
> failure while we enable it. I encountered this with kvmtool, where
> CAP_STEAL_TIME is reported true and even the HAS_DEVICE_ATTR goes
> through fine, but SET_DEVICE_ATTR seemed to fail.
>
> Isn't it better to allow the VM to decide if the capability is supported
> for the given VM type, like we are doing for other capabilities ?

You're right, per-VM capability reporting. My wires got crossed from
the pKVM series and the kvmtool fixes. However, I'd still return
-EPERM rather than -ENXIO from the attribute. The capability exists,
it's just not permitted for a confidential VM, and -EPERM says exactly
that, whereas -ENXIO reads as "no such feature".

Cheers,
/fuad

>
> > steal-time exists but isn't permitted for a confidential VM, whereas
> > -ENXIO reads as "no such feature".
>
> Cheers
> Suzuki
>
>
> >
> > Cheers,
> > /fuad
> >
> >>
> >>   int kvm_arm_pvtime_set_attr(struct kvm_vcpu *vcpu,
> >> @@ -81,7 +81,7 @@ int kvm_arm_pvtime_set_attr(struct kvm_vcpu *vcpu,
> >>          int ret = 0;
> >>          int idx;
> >>
> >> -       if (!kvm_arm_pvtime_supported() ||
> >> +       if (!kvm_arm_pvtime_supported(kvm) ||
> >>              attr->attr != KVM_ARM_VCPU_PVTIME_IPA)
> >>                  return -ENXIO;
> >>
> >> @@ -110,7 +110,7 @@ int kvm_arm_pvtime_get_attr(struct kvm_vcpu *vcpu,
> >>          u64 __user *user = (u64 __user *)attr->addr;
> >>          u64 ipa;
> >>
> >> -       if (!kvm_arm_pvtime_supported() ||
> >> +       if (!kvm_arm_pvtime_supported(vcpu->kvm) ||
> >>              attr->attr != KVM_ARM_VCPU_PVTIME_IPA)
> >>                  return -ENXIO;
> >>
> >> @@ -126,7 +126,7 @@ int kvm_arm_pvtime_has_attr(struct kvm_vcpu *vcpu,
> >>   {
> >>          switch (attr->attr) {
> >>          case KVM_ARM_VCPU_PVTIME_IPA:
> >> -               if (kvm_arm_pvtime_supported())
> >> +               if (kvm_arm_pvtime_supported(vcpu->kvm))
> >>                          return 0;
> >>          }
> >>          return -ENXIO;
> >> --
> >> 2.43.0
> >>
>
