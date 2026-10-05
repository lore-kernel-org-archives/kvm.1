Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B04C33DA
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213586; cv=pass; b=odjFYsdEBBzzmSz8kkP4C6SxGaANKm1K3W1exxldwS71W2UW7NTTnowpjV1yzzW0Rk/HZuxMNRe687vL+oq6NldATzhk2VrIztHtN3tcy0xoxXeog6EM4VYTQIBikt+kGuW8Y8owVQ3kcfIG+PVocw67+XVAEi2KqZm4VJqJJRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213586; c=relaxed/simple;
	bh=UIl4kdhOZ2E8Ywuw71YkjmtzARY2f4WIsxfjGE5sW2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4SHFkQn192yzKd6aCrXDz+gmhpWwgmwqBpli3onhew72K20CfgubV2fjeUovu9NOBjB3iq8wLOHZycbIwNJ2RW30oBcS9t5jr7HvZ3DvZgc55VwC+4GGVqBVSl8v2STjulJaqESupa2ursYss+Fx0fpPvSk0LE8eH40qYT0QQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=DB3qFyiP; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="DB3qFyiP"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8aca68653e3so4995437b3.3
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 08:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791213582; cv=none;
        d=google.com; s=arc-20260327;
        b=ZlBx2wvq2nlRFikOYfHJowdVN+9zzlMrNAE7yywt4QTVihuuvzk0IjVsjynIUi94IK
         WgPKOu/Zqi++v8yf15SVWUA07hF91bN0QEQcBXdN+vb5Zul5Fr/QxLYNpx4tyLmhbuxo
         Jh/Dtzc9ViaWdJs0oBbHttHJqmebmXbLC3usZ+0F8Q0tsF0BgyQ38A6PunpJR2RVByaM
         VimRujx8TbTYMAgOJ8ddxvNqqlZ+tLv+Ik1XU1TcHEque5hkVwpmlhn7yqy1eWkxccYr
         trlzcV9ysxoPP3LACTYvGbiUBUPem+nYbOIx7tvvtzyQ+lrQ03qGKkpUue8FVdnvH+A8
         FuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T+dMDT3scTIxkiT9pgs5QLVQ4RLiEtpfcAYTaBoUr5g=;
        fh=W6HxQOwiyR4LU1rnjVgZTG3Ev4iMTTum5Ko9eRehUPo=;
        b=RFknAyZ8kqViyzmbTXujFItlUmRxuFXJlcjS0SqwwMIWcaocIdnAHGacjgOiEfqOH4
         SiCGHWFKwpUfVvLuwr+SnXSAqpEGwXSVa0JL+FcFfZDYEnrG1ZuQGvgFJy7jBTRdts6d
         t09H+tSDfozGrHvJphFyvfSFWPi1IRL3G8csaV0BX8QypdFY8mx0CAUd++z74zjFUBCz
         maf/87mIG4J9lNeC0wGv5z9soDe+eLKGuwxd3OQjiw9sepfYfxcH4ym47fnqkS5Rq+bn
         At85508YOLqTVZn/y3EsZVVFYpp8V6qUJ567zeekG3txHZCnG8vY5+dccafc5ykgKb9T
         m7jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1791213582; x=1791818382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T+dMDT3scTIxkiT9pgs5QLVQ4RLiEtpfcAYTaBoUr5g=;
        b=DB3qFyiPRuQSc6yWtUaXp0WtMEZp1VVcP29Bf/lhUeG9CvIm+9/MrilJAUXa7re+JV
         eJDsiYUVkiVYmb8nZv80Ig2gTke3bksKtLFzaflVx+1F5EuJ5AdidZfAmnZIR9QT50o5
         8+1LOJInDtgHVBoclRjjpX4SpzCRIsGvUZA7vgdaNNut0aRP92oyn1eefhvEVx82mf3D
         vc/6xF5VUclbtfw0f9bAVkG0a4572h2fqNIcNxTOecHqdyhvaOqjjfRdGB5/51MrD+EM
         dHeq6SI01JKq5P4bkTmJYw6COVzgAHlQ/UwdAC0r/DYqlySJfdgoHZLAOtOt3av6AVbx
         jHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213582; x=1791818382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T+dMDT3scTIxkiT9pgs5QLVQ4RLiEtpfcAYTaBoUr5g=;
        b=M70yCFN6MCi/KtMpXY//KBm072Xm3oQ54nKsgqkln4HnWRci78AzIzDpwurCQdU6HD
         A/CzhfLvPLoL3yboUkjike6R6TeEfE4ony/sBkusbT3JzDo8BOqHOdft1LQxFDpigwTs
         6bfVksDwGhk3M4DPZ2PNwyGCRunTaQeyGbSYbLDrVOKVi5mezRg4xK75kzc1qFwZijwL
         MWwZ16vpv0znDxqM+HXyjcd/NURUuaO8tlzBvosA3OuKaqES3rVo2/P+qHT8qFcN2nn8
         uBrBEmTUQ7YpBPlCJQluY5owakNFpErGx/lOPlhBZZAmLg5ee3bBa1NoMn7VZPCIVMZu
         0V3g==
X-Forwarded-Encrypted: i=1; AKwUvBxf7+VgOAGEZFfkwBzgHiI/hKYodsnO3G3CjLaEdIhUGiZOFA64/qb8Mc5rgHwpo/xrICo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfVXFTIBgQ1nBXp4wn47/iCFq9n5O5jXOK6AqLTGYc8oOylJ6B
	OVTCQMEasXJw/PZrAzguRR9xxXmnV6NyF8xOC7x0DFkE2YA89e6rs+FNM3D2TLhsSOiSZUFF84Y
	xKxyBdOr8Ecyka/VXooiMdtkdSuUd2x0Io6sHJctIQQ==
X-Gm-Gg: AYBFou0JU3Yhwyx5nfLSGC34L8Ynyw3cRLEEd/djFltymn6CGBJTtgs2Adzf/BLq+Fr
	0WXn5ok8DUcwa1j4cFhIy/qFoQL1ua6GLMdcXxtE3h/7rObLpcuH2uof42tEbV5/Xyh1O9owUeo
	6NwhV2ZnXnLTo0lqi6DHpxbAjG3qcwPZeKTxffipkWmjVpSQsK5H0HnK2ZJzHBhzKHfosWd2fC1
	ToNOy/Chz+8uEI2Ol6Ydxu0Bw4aDT0+7VpP9OLi65Gz1708iC5ISjZ3bEL5raZKkNIb69Ni5b5i
	on58aZ4s/HaEJ4a5cgCG8tLqPa6rdwafkR0YIRPyx/U5duZMadS5+Q==
X-Received: by 2002:a05:690c:e0c6:20b0:88e:edf8:e375 with SMTP id
 00721157ae682-8ae948c7652mr24080357b3.5.1791213581979; Mon, 05 Oct 2026
 08:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e61df396-356f-4ef2-9c3a-db3c05cb5c52@linux.alibaba.com>
 <asA7ixFlhNJpANoR@google.com> <CABk29Nu5rnd3wZq8XR5Q3BA2dQzT68hHSv1JihxT3V6GTSyRHw@mail.gmail.com>
In-Reply-To: <CABk29Nu5rnd3wZq8XR5Q3BA2dQzT68hHSv1JihxT3V6GTSyRHw@mail.gmail.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 5 Oct 2026 17:19:29 +0200
X-Gm-Features: AclHuK-zIbzN8D_HOP9FBWUlLNlIQG4wLIZCCdCvUIczbMj8moj0m1yI42dbwwg
Message-ID: <CAO7JXPiBZ5xQp1P9taEe3Qpy_pLDCzXgSWtEMbbHNvya93wi+Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kvm: introduce pv idle time
To: Josh Don <joshdon@google.com>
Cc: Sean Christopherson <seanjc@google.com>, He Rongguang <herongguang@linux.alibaba.com>, 
	pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, vkuznets@redhat.com, 
	geert@linux-m68k.org, sammiee5311@gmail.com, lirongqing@baidu.com, 
	schuster.simon@siemens-energy.com, kai.huang@intel.com, 
	shannon.zhao@linux.alibaba.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:20=E2=80=AFAM Josh Don <joshdon@google.com> wrote=
:
>
> On Sat, Oct 3, 2026 at 1:17=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > +Vineeth and Josh
> >
> > On Tue, Jul 21, 2026, He Rongguang wrote:
> > > Hi, this patch introduces a PV mechanism for guests to publish their
> > > vCPU idle state and accumulated idle time to the host. This allows
> > > the host to efficiently determine whether a vCPU is currently in its
> > > idle loop, and knows vCPU idled for how long. QEMU patch and ARM64
> > > support patch will follow in a subsequent series.
> > >
> > > The guest writes a GPA pointing to a struct kvm_idle_time via
> > > MSR_KVM_PV_IDLE_TIME. When entering idle, the guest sets the flag fie=
ld
> > > to KVM_PV_VCPU_IDLE. On idle exit, it clears the flag back to
> > > KVM_PV_VCPU_RUNNING and adds the elapsed idle duration to idle_accum
> > > (in nanoseconds).
> > >
> > > The host can read the flag at any time through
> > > kvm_arch_is_vcpu_pv_idle() to make better scheduling or resource
> > > allocation decisions. For example, host may overcommit those vCPUs
> > > which are mostly idle. An in-guest agent may be absent, or may not
> > > report the status in time.
> > >
> > > The accumulated idle time provides visibility into per-vCPU usage for
> > > monitoring purposes. An in-guest agent can report VM CPU usage, but
> > > this PV mechanism allows the host to obtain guest CPU usage even when
> > > no agent is installed. This is especially helpful when the hypervisor
> > > enables exitless-hlt/mwait (for better guest performance) or when the
> > > guest uses idle halt-polling, both of which make QEMU vCPU thread usa=
ge
> > > deviate from the actual in-guest vCPU usage.
> > >
> > > This feature is advertised via KVM_FEATURE_PV_IDLE_TIME in CPUID leaf
> > > 0x40000001. Guests enable it by writing the appropriate MSR during
> > > initialization, similar to the existing steal time mechanism.
> > >
> > > Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> > > ---
> > > v2:
> > > - grab kvm->srcu in kvm_arch_is_vcpu_pv_idle() before calling into
> > >   kvm_read_guest_offset_cached().
> > > - return KVM_MSR_RET_UNSUPPORTED instead of 1 in MSR handling if
> > >   !guest_pv_has(feature).
> > > - in set MSR handling, set vcpu->arch.pv_idle_time.msr_val after
> > >   kvm_gfn_to_hva_cache_init() return success.
> > > - in kvm_arch_is_vcpu_pv_idle(), remove ghc->memslot check, let
> > >   kvm_read_guest_offset_cached() handle it.
> > > - in kvm_arch_is_vcpu_pv_idle(), no need to use struct kvm_idle_time
> > >   local variable, it is too big, just use __u64 flag is enough.
> > > - remove some straightforward code comments.
> > >
> > > v1:
> > > -
> > > https://lore.kernel.org/kvm/36863cf7-61b9-4885-946d-1608179fcab4@linu=
x.alibaba.com/T/#u
> > > ---
> > >  arch/x86/include/asm/kvm_host.h      |  7 +++
> > >  arch/x86/include/asm/kvm_para.h      | 19 ++++++++
> > >  arch/x86/include/uapi/asm/kvm_para.h | 24 ++++++++++
> > >  arch/x86/kernel/kvm.c                | 68 ++++++++++++++++++++++++++=
+
> > >  arch/x86/kernel/process.c            |  7 +++
> > >  arch/x86/kvm/cpuid.c                 |  3 +-
> > >  arch/x86/kvm/x86.c                   | 69 ++++++++++++++++++++++++++=
++
> > >  7 files changed, 196 insertions(+), 1 deletion(-)
> >
> > I really, really, reaaaaally don't want to take on any (more) PV schedu=
ling ABI
> > in KVM, if possible.  And I definitely don't want to take a bunch of on=
e-off
> > hooks, e.g. for idle tracking and then for something else a few months/=
years
> > later.
> >
> > Vineeth and Josh are working on PV scheduling via sched_ext and I assum=
e additional
> > communication channels.  I'm guessing idle state is one of the things t=
hat'll get
> > communicated to the host?  I don't know the exact status of their work,=
 but they've
> > got a slot in the sched_ext MC at LPC:
> >
> > https://lpc.events/event/20/contributions/2482
>
> Thanks Sean, yea this looks achievable though the pvsched framework.
> Note that usage of sched_ext is not a requirement. For something like
> this idle time tracking, it would be trivial to extend the pvsched
> guest component, which already tracks guest scheduling state changes
> via guest context switch.

I also agree, this could be achieved with pvsched. In the latest
pvsched PoC  (not yet posted upstream), the guest vcpu infact updates
pvsched shm when it enters idle. Host side of the pvsched(default
pvsched policy) uses this information to take some actions before the
vcpu thread sleeps in the host. Idle time accounting is also not yet
implemented, but it would be trivial to build on top of this
framework.

Thanks,
Vineeth
