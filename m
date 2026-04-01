Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2933ADBC
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025833; cv=pass; b=hzzLNHqgyFkTMhvppqm1g8wA0Kl8TIxOMh7lHb0BSmgWMf5CFq1vVJbUMdR5kYsod6hqEXbBSOhhrENMGXAMiFKR/iHBCwUzYt15exbuNj9HR+3Qf5w1RdEuo4Pj/gKz/j8vePuMlXe2bpRH6wv4a7Kl1wwNimvMRDWyjJT8ecw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025833; c=relaxed/simple;
	bh=notROa6jM+OxVjqhORSXOtxXweE8TOJJVWuhz5TXAxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFkR8jxURZAysDeveBt8cAzi9HYDvrJh2tSYb0TbDcIOWSktTj9TdMqFXhQiKyj62aWELSrF0kvWUsbJPWDGazMqlML2jYYHn4SI1bOyT4yilT/ILrALvDEOlsa3HK8g/D5r20NtMA5lF6c6WlCpJDRwMb8IAMuqOcBm0o0vwWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=IgUciSRg; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="IgUciSRg"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79495b1aaa7so30320357b3.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 23:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775025829; cv=none;
        d=google.com; s=arc-20240605;
        b=ITk3OU4L9RsD5s/HDf5evtT8tscTxCtKI8Y4DA4/xyf7InxvSDK6IF7bEPx4zzoDya
         4pbJ7TJUmBFGS06z2FbIuYUXD9b1zH/XC6SeEeELOUnHzWKKC0zF8uU2zCP/1XwlWosi
         IWLBiALDIrZ0p2nCWyUqnx5j482U1W3xmIJvQrGVjjPyYZPTEy/3KLFKBgM7+Fhr80DH
         Wzy2zdiQUbKWlIyIgKZ7VtoYTEQo+z5SXj2L6kP4MMhuoYrF7a24Kp3gDrlhdhgyYKlN
         ozI+0Jnrrm9pnbJwSHntVtiV+Ur4F0IQ76TK2B94dXbzqGASETRop6bBgWPerWca0z/s
         bvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4hKT2sMz3+DdIQQ32asHdstbuMyoWTz8ct+lrn7Mf2E=;
        fh=kJsGwlLbW04L8HptDFosttQcqYxf5rmAvnR+TsiWZaI=;
        b=LjfKfP20Utfmz01KCxG6vfwFM9mpa5p/gXEKh8LuzQnJsxgIH8plBEGoxXRZLQm3K3
         6UiX//2TWJs/hZC8uWHKThnzQn55bWSeAJXEc6VIT22qVmjhDeUHjTsZcxzhZ0qXIuOR
         QIIREKnKFSYVPzuWL8t2civa73baMHuYZKXDhFc5pvge/d8hnhAOC41dZMoXRilZJlJ5
         JplHRfulAUTmr85Nag+c7zT0RSsKJFhvkekDDwmQtqhvjMmQNFjJC6BEZC/HU3rtunsS
         gJcy6Cth5xycneLmzu3B1USXxgsbBzxACJ8+RlkKSLb53s25vJw/dYndkMw5whDslBy6
         Qhzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1775025829; x=1775630629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hKT2sMz3+DdIQQ32asHdstbuMyoWTz8ct+lrn7Mf2E=;
        b=IgUciSRg8/XX2ZeduEHKXfwTEW7o/okisS1iXvW2+NHpcDyuTR0/CFuzAyh93AOdM8
         ReQvL7NHBYjHRJ9yEUDwntETo3qbAV7UHx0O8nVFGDTs23BYHwbr7aWTvEuthcM6PQyi
         XfH+Fuej/AyQEOEIhEXJq399D6k3hzUpL46UcnWX6qFTGg0vmpV0DHdCZp7PwAtZI+9Z
         cUmn1RBINlBs/xY0kAvzfx6jUtGys/4AfPGrgF/GvGfEBI8C/ws6ioxsPgsNgbW/uMxd
         hQAkfUAZcg0Mod71QQjMpfjOQSgXCpTl7e+3+MPj4pywhc0btXa6ir6f6l/G4I49wvte
         Gh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775025829; x=1775630629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4hKT2sMz3+DdIQQ32asHdstbuMyoWTz8ct+lrn7Mf2E=;
        b=HDB1/08Bn+iRAAIwcUouqzan2m8PRjtgZTAQuTC3Zk7Dk7B1GtB5KlHnW6WyBR2gOJ
         zL6TD8jNoDPE9etwG8XkULS8M6X9tKMzRPmm6R+EouWgnIkGg1nRVQX41EIC7fBDaHRK
         fQnBXwPSG34evzOgooIi7pVAMATcb6I00r5X4F+twapt67hQR8GUo+DKwLwwkTFu2YYf
         7aDcJNqbxO0OureBwAgBHBHjPr3AyF03y+5yLc3PY3ZvqEPMzUhpZXXAUbZcBdJ9pLJe
         B/3fCvDAFPFxJxx9D3hBw5fwiA5rmlaAdCKXiLZm7AohYPtGdkS2CuuvnlYZ3XMYSyNc
         BtAg==
X-Gm-Message-State: AOJu0YwD2ofH8MD6Q8a0+pn1GSHK7WwhUoa+O9Iqitrhs0kt4h77kYzf
	dHRzR/oU3lb7Qww5oon9zHzxFAGFq0DWnDtRMQ8HClIXQncvviIScK6GA13wA3qnuTfKgH7FMjC
	++smu/y7SjYKdxIkEc2LkMV/XeOG9w5TQM8fuK5IS86HVS5uXL0SyGWPH2d6H4VBW4g/lfUYyA6
	wpn4PgClWcP9/ccz65RTRgGA==
X-Gm-Gg: ATEYQzywRd2v4HcLPje51rrbqEcD2kjYkc1f5jUhs3zWyMT6s0mhsKHD7FpRvCHheFP
	K92T//G7HCuoXTB7YiwwvLI26F0UbfPIDZ6huVMnGaIP2CL95vOucDJ20gUmP5qwBhwdbIu+ZNO
	0iINAShiGq2BEiDsMtmgHMkFDln9pjY6HN/66+lW3hA8qtcHaF0qFv5ylfZb+2nE9/hlmrE8mhu
	zwIMrZ4E/dEuX9rMk0wUUCfkM1kEInZ/b0NqYSnxdN3uuGy3Y9qPkH6EAydNKp9GX8PuPhrSWOn
	WxLNyerKXHzLQowp
X-Received: by 2002:a05:690c:397:b0:79a:b1e1:49cd with SMTP id
 00721157ae682-7a211c48daamr26309107b3.33.1775025829433; Tue, 31 Mar 2026
 23:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com>
 <CAKcXpByCeeqCg9gMnsNzz1hhS36gZuJ6YsBAMBZJWG0n35bcRQ@mail.gmail.com>
In-Reply-To: <CAKcXpByCeeqCg9gMnsNzz1hhS36gZuJ6YsBAMBZJWG0n35bcRQ@mail.gmail.com>
From: Lei Chen <lei.chen@smartx.com>
Date: Wed, 1 Apr 2026 14:43:37 +0800
X-Gm-Features: AQROBzA2IwwuSmwD3asfU0gQoNYFPjxRGiyedwZDJFqiGvoMgeLTmFIsR47I0Ys
Message-ID: <CAKcXpBzJ=ZNL=_XJBoG9sFXb0pt4JrF0wP3u_2eQSx-FizbOcQ@mail.gmail.com>
Subject: Re: [REGRESSION 6.19, BISECTED] KVM: x86: kvmclock rate-limit removal
 causes IPI storm and high guest steal time
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, seanjc@google.com, 
	pbonzini@redhat.com, Igor Raits <igor@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jaroslav,

I apologize for the late reply.

I have reviewed the code and identified two scenarios that currently
trigger the KVM_REQ_GLOBAL_CLOCK_UPDATE request:

Scenario 1: kvm_write_system_time
This code path occurs when the hypervisor (such as QEMU) adjusts the
time, or when the guest writes to the TSC.

Scenario 2: vcpu schedule in kvm_arch_vcpu_load
If this function triggers KVM_REQ_GLOBAL_CLOCK_UPDATE, it indicates
that the virtual machine is not using the master_clock.

Those two cases are uncommon. Could you please provide your dmesg and
help check which code path triggers KVM_REQ_GLOBAL_CLOCK_UPDATE?


Best regards,
Lei Chen

On Mon, Mar 23, 2026 at 10:27=E2=80=AFAM Lei Chen <lei.chen@smartx.com> wro=
te:
>
> Hi Jaroslav,
>
> Thanks for your test and report, I'm looking into this problem.
>
> Best regards
> Lei Chen
>
> On Sat, Mar 21, 2026 at 10:33=E2=80=AFPM Jaroslav Pulchart
> <jaroslav.pulchart@gooddata.com> wrote:
> >
> > Hi,
> >
> > I am reporting a performance regression in Linux 6.19 that severely
> > impacts KVM hosts running many Firecracker microVMs.
> >
> > =3D=3D Bisect result =3D=3D
> >
> > 446fcce2a52b533c543dabba26777813c347577c is the first bad commit
> > commit 446fcce2a52b533c543dabba26777813c347577c
> > Author: Lei Chen <lei.chen@smartx.com>
> > Date:   Tue Aug 19 23:20:26 2025 +0800
> >
> >     Revert "x86: kvm: rate-limit global clock updates"
> >
> >     This reverts commit 7e44e4495a398eb553ce561f29f9148f40a3448f.
> >
> >     Commit 7e44e4495a39 ("x86: kvm: rate-limit global clock updates")
> >     intends to use a kvmclock_update_work to sync ntp corretion
> >     across all vcpus kvmclock, which is based on commit 0061d53daf26f
> >     ("KVM: x86: limit difference between kvmclock updates")
> >
> >     Since kvmclock has been switched to mono raw, this commit can be
> >     reverted.
> >
> >     Signed-off-by: Lei Chen <lei.chen@smartx.com>
> >     Link: https://patch.msgid.link/20250819152027.1687487-3-lei.chen@sm=
artx.com
> >     Signed-off-by: Sean Christopherson <seanjc@google.com>
> >
> >  arch/x86/include/asm/kvm_host.h |  1 -
> >  arch/x86/kvm/x86.c              | 29 ++++-------------------------
> >  2 files changed, 4 insertions(+), 26 deletions(-)
> >
> > =3D=3D=3D=3D Symptoms =3D=3D=3D=3D
> >
> > Measured on a KVM micro VM host running many Firecracker microVMs
> > (node_exporter metrics, 2026-03-20):
> >
> >   kernel 6.19:
> >     steal time inside guest VMs:    3=E2=80=9324% per vCPU  (sustained)
> >     host system CPU (kernel mode):  3=E2=80=9312 CPUs saturated
> >     host steal:                     3=E2=80=938%
> >
> >   kernel 6.18 (same host, same workload after rollback):
> >     steal time inside guest VMs:    < 0.02% per vCPU  (~200x lower)
> >     host system CPU (kernel mode):  2=E2=80=933 CPUs
> >     host steal:                     0.3=E2=80=930.5%
> >
> > =3D=3D=3D=3D Root cause (by AI analyze) =3D=3D=3D=3D
> >
> > The regressing commit removes the rate-limiting from
> > kvm_gen_kvmclock_update(). Previously this function deferred the
> > all-vCPU kick via a 100ms delayed_work:
> >
> >   /* 6.18 */
> >   static void kvm_gen_kvmclock_update(struct kvm_vcpu *v) {
> >       kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
> >       schedule_delayed_work(&kvm->arch.kvmclock_update_work,
> >                             KVMCLOCK_UPDATE_DELAY);  /* 100ms */
> >   }
> >
> > After the revert it kicks every vCPU of the VM synchronously on
> > every call:
> >
> >   /* 6.19 */
> >   static void kvm_gen_kvmclock_update(struct kvm_vcpu *v) {
> >       kvm_for_each_vcpu(i, vcpu, kvm) {
> >           kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> >           kvm_vcpu_kick(vcpu);
> >       }
> >   }
> >
> > KVM_REQ_GLOBAL_CLOCK_UPDATE, which calls kvm_gen_kvmclock_update(),
> > is issued on every vCPU load when use_master_clock is false
> > (arch/x86/kvm/x86.c, kvm_vcpu_load):
> >
> >     if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu =3D=3D -1)
> >         kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
> >
> > With many Firecracker microVMs, the vCPU scheduling rate is high.
> > Each scheduling event now IPIs every sibling vCPU of the VM, instead
> > of coalescing all-vCPU kicks into at most one per 100ms. This creates
> > a continuous IPI storm on the host, visible as high kernel (system)
> > CPU time and high steal time inside guest VMs.
> >
> > The commit justifies the removal with "Since kvmclock has been switched
> > to mono raw, this commit can be reverted." That reasoning is correct
> > for the NTP-correction use case, but the 100ms rate-limit also
> > protected against IPI storms when use_master_clock is false =E2=80=94 a
> > concern independent of clock source.
> >
> > =3D=3D=3D=3D Full bisect log =3D=3D=3D=3D
> >
> > git bisect start
> > # status: waiting for both good and bad commits
> > # good: [7d0a66e4bb9081d75c82ec4957c50034cb0ea449] Linux 6.18
> > git bisect good 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> > # status: waiting for bad commit, 1 good commit known
> > # bad: [05f7e89ab9731565d8a62e3b5d1ec206485eeb0b] Linux 6.19
> > git bisect bad 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> > # good: [02892f90a9851f508e557b3c75e93fc178310d5f] Merge tag
> > 'hwmon-for-v6.19' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
> > git bisect good 02892f90a9851f508e557b3c75e93fc178310d5f
> > # bad: [edf602a17b03e6bca31c48f34ac8fc3341503ac1] Merge tag
> > 'tty-6.19-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> > git bisect bad edf602a17b03e6bca31c48f34ac8fc3341503ac1
> > # bad: [09cab48db950b6fb8c114314a20c0fd5a80cf990] Merge tag
> > 'soc-arm-6.19' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> > git bisect bad 09cab48db950b6fb8c114314a20c0fd5a80cf990
> > # good: [36492b7141b9abc967e92c991af32c670351dc16] Merge tag
> > 'tracepoints-v6.19' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
> > git bisect good 36492b7141b9abc967e92c991af32c670351dc16
> > # good: [7cd122b55283d3ceef71a5b723ccaa03a72284b4] Merge tag
> > 'pull-persistency' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> > git bisect good 7cd122b55283d3ceef71a5b723ccaa03a72284b4
> > # bad: [63a9b0bc65d5d3ea96a57e7985ea22a8582fbbe5] Merge tag
> > 'kvm-riscv-6.19-1' of https://github.com/kvm-riscv/linux into HEAD
> > git bisect bad 63a9b0bc65d5d3ea96a57e7985ea22a8582fbbe5
> > # bad: [adc99a6cfcf76d670272dea64bbc2d43ecd12a2f] Merge tag
> > 'kvm-x86-mmu-6.19' of https://github.com/kvm-x86/linux into HEAD
> > git bisect bad adc99a6cfcf76d670272dea64bbc2d43ecd12a2f
> > # bad: [c09816f2afce0f89f176c4bc58dc57ec9f204998] KVM: x86: Remove
> > unused declaration kvm_mmu_may_ignore_guest_pat()
> > git bisect bad c09816f2afce0f89f176c4bc58dc57ec9f204998
> > # bad: [f6106d41ec84e552a5e8adda1f8741cab96a5425] x86/bugs: Use an x86
> > feature to track the MMIO Stale Data mitigation
> > git bisect bad f6106d41ec84e552a5e8adda1f8741cab96a5425
> > # good: [9633f180ce994ab293ce4924a9b7aaf4673aa114] KVM: x86:
> > Explicitly set new periodic hrtimer expiration in apic_timer_fn()
> > git bisect good 9633f180ce994ab293ce4924a9b7aaf4673aa114
> > # bad: [e78fb96b41c6ac85c1a02c7e9610d1ebaa9b5d98] KVM: x86: remove
> > comment about ntp correction sync for
> > git bisect bad e78fb96b41c6ac85c1a02c7e9610d1ebaa9b5d98
> > # good: [a091fe60c2d3943b058132a64682a509d55bd325] KVM: x86: Grab
> > lapic_timer in a local variable to cleanup periodic code
> > git bisect good a091fe60c2d3943b058132a64682a509d55bd325
> > # bad: [446fcce2a52b533c543dabba26777813c347577c] Revert "x86: kvm:
> > rate-limit global clock updates"
> > git bisect bad 446fcce2a52b533c543dabba26777813c347577c
> > # good: [43ddbf16edf5c1790684b32d5eb920a1b0eea285] Revert "x86: kvm:
> > introduce periodic global clock updates"
> > git bisect good 43ddbf16edf5c1790684b32d5eb920a1b0eea285
> > # first bad commit: [446fcce2a52b533c543dabba26777813c347577c] Revert
> > "x86: kvm: rate-limit global clock updates"
> >
> > Best regards,
> > Jaroslav Pulchart
