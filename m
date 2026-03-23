Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29900175A79
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774232872; cv=pass; b=jfa/9TaAmE5QalMWskqtTV4MRt/nr2QtLOOhit1KgmOZXYjjKmZkMtIUoB3BI8XFm1w0HV6we07jsBTMC/WKoLNjTaZCW1u874nWcAKy3ORF5ariycZ5HPJyp7gpe6D/Qz+ia94lNDS3jRdk7VIHqQSuhxC8IqePL4GMTq5ux1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774232872; c=relaxed/simple;
	bh=zEZa9Wr0skmqjMVvVDy9uPoO3DMj+c/a53qKgG77QT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uu7tnc5kApKjSDQLNl33dmH4aUgRb0T2V1XfwqvVm0aRok8fyHyjOYnVfDyoULumPZIHCG8T+ZygyqFlIg1sC2jszgNV394WwRYddusY8whkkQ+y1uYjDOhBrsyAQyTbH8OEwFEpySv0J5vmbRqi5S5cyvH3sPWsUCoCMt1/EYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=Z8i8L7us; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="Z8i8L7us"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79ab520caffso2894907b3.3
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 19:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774232869; cv=none;
        d=google.com; s=arc-20240605;
        b=BzRA1pUuPsvG1GJFoMBrwMBukTUjLocdbKaSmDPNlvKeMsIzU1JNpcFujas9bPIN8d
         B7gbm1tXNl7oXftTfQzyUt8Q3D7hmmEggUcSQOT0tQB5sdrUz2tfIqQiYT/dhveXZGYz
         ufihNOKX3RxxEizr/NxW7lC3F7ncoKlpn7qsaGuFIC4jKklPDN5GNQ0Z/ygOTFIUzpE9
         TDAZa6UzFLOWvHpGTE0ksMIpSmXFAwHzo9TZZmZAdgS5crNhwnrJKdrlXm6UZoRyCEli
         jS4iFjDaTf7CSbYT88PZQeqM62sc/8nDXHUErcDbztHTpwjPa/TBrPy/lN08DZfcnvIu
         5JzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9elGqvJY6+M5d/qIdBXVWRcH1XW5uw4L+DyEI5sJ7Ls=;
        fh=kJsGwlLbW04L8HptDFosttQcqYxf5rmAvnR+TsiWZaI=;
        b=IwAM7hIfiJ6ZJ7ta7NPrCeeENl4xRIQVpdWpF4Np1gx76Rvoi7Ki3BzxDRQktri7Kp
         mLe29D+6mGEbspA4GqkvkL/0pCADDJsfbU9ZFYQ/DQxLlyrINmTJOfDO+yJEmbHqaHmw
         bVf7MFPeZfR88639rJ77CtxzoZ91WFMGyZqzby/SVpawdfXMdPKMQpZDwguKBbsl52Wp
         zPqP3IPLLUVYNKlNQ9nCoo2a4RHd8aK/A8DHV2Nkiz/ReflNV+PY/XPkqH2bWaUilKzO
         r61l6AZE1EwvG9jy4qCFgGtmN8Vh1ibMfxd3T1R4Fdu08BLHFAW297Of8uk8+bYrw7WH
         vLpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1774232869; x=1774837669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9elGqvJY6+M5d/qIdBXVWRcH1XW5uw4L+DyEI5sJ7Ls=;
        b=Z8i8L7usULLIPuKq2zflxwQg8rJRKuOaouIqKxTjsIj4BYpwk4tAIFp0EATujNhSBH
         xiAcQ9UEnQHtbn2FPAIoMkOaiRTNx56Aclkqze1NmEGsMk5ghSXTMW4D2+vO1Gs1kMiW
         TS/iT58qHWGS9UlOAe7ZlDeVSalullOWBDaYRxYkr+xfHS2+RD0BduR10y6xYCzmicS6
         /BTKFxfOXxKBtM8I8Za5y4i5LWictuv3o17h9uQotR41NumtaowPuToC3Sh17hLN9dp5
         bNW/vatRIx+KDpzJbJX3es+oAX1hINuxAKJG4yzwO8RaTx4iOBuA6lpy1k/1v/E158Dh
         oWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774232869; x=1774837669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9elGqvJY6+M5d/qIdBXVWRcH1XW5uw4L+DyEI5sJ7Ls=;
        b=C4nvLwRChxKYnvXNB5/qKm8V/GYOQ0AAPtUEGNQYUfnv+2yMaQWNHAV1JCvxb4f+UY
         ftn6NGhekNN3T/uojGU1rTi3SuGYHLHUl3qcdj+pL6x3mokGV5+B9BdYg8aMTL1UC2Ag
         nBjWd5Zv4MPTxTZwOCk0/hVNsjCUQ9dRxixvgeUldyX90vaqdWZwDQ2+PHmOSPJNiL/5
         oZXbDARsngoe/rrQgRY3PGF8ft27sjndH/Egua5WADwlC2YpuDHPHRrClRSOXCnXJhbc
         co7AJ+J5751vpsY9z8Yfj5KkAKSfeTe8cVnv6Va1maSY1R189DwjZWkASQZt0ZTVYspT
         Ltvg==
X-Gm-Message-State: AOJu0YxOIg59hY/EUR3gc5btvHtTBasj+5ICNVELt/OaqsXS3OtVrXZs
	X8zk5FG5IXZQNHHBna1LIgQgKm/ouZs6jyzAlVx/CohF8TE0i49KMq5xHqWzH2EctZTYmGUUrpx
	H03YhSo3KkS69+LTL7rUkEnfhAMN5qK2JkQYcDft4WF5cQPQhCVnoZ+Fq8gNH/Xvn5TyUTg2CG4
	s1eN6i1yQWwoZ8J8sFGeGDjA==
X-Gm-Gg: ATEYQzyqraLK1deU9eWD19817n404+kuuB3oouktzbYjZqeaW5xjAh6Bu8G/0VmF2ZE
	PGqrJtByp4U+AVrAdlkQ7nJjteY3tEIg2wll9l7oVFdsSjqKFUTUXODNcugRYmnW3Sy00E9D2m5
	WRZGCo08DcKbcNkV1Qdd6CtADgYlFwLuQ416C468N5CO7OzRkImQKRdqT4WxVwdctW4+AoPAS6j
	l06OzrHJu+v6BkbNTQ7GiJX4rrROZ2jWlAPHT+HNaeNJN5qzF0f+aN1p2eUeuskPX5+Foz7qIcC
	yhixY0A8
X-Received: by 2002:a05:690c:398:b0:79a:8f65:e95f with SMTP id
 00721157ae682-79a90be809fmr110160657b3.45.1774232869129; Sun, 22 Mar 2026
 19:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com>
In-Reply-To: <CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com>
From: Lei Chen <lei.chen@smartx.com>
Date: Mon, 23 Mar 2026 10:27:38 +0800
X-Gm-Features: AQROBzDwIXCoxuPpEyNqvybSA_R-6eTfsE527l-03O8XMeVCWNCdZlwF7IUDwaI
Message-ID: <CAKcXpByCeeqCg9gMnsNzz1hhS36gZuJ6YsBAMBZJWG0n35bcRQ@mail.gmail.com>
Subject: Re: [REGRESSION 6.19, BISECTED] KVM: x86: kvmclock rate-limit removal
 causes IPI storm and high guest steal time
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, seanjc@google.com, 
	pbonzini@redhat.com, Igor Raits <igor@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jaroslav,

Thanks for your test and report, I'm looking into this problem.

Best regards
Lei Chen

On Sat, Mar 21, 2026 at 10:33=E2=80=AFPM Jaroslav Pulchart
<jaroslav.pulchart@gooddata.com> wrote:
>
> Hi,
>
> I am reporting a performance regression in Linux 6.19 that severely
> impacts KVM hosts running many Firecracker microVMs.
>
> =3D=3D Bisect result =3D=3D
>
> 446fcce2a52b533c543dabba26777813c347577c is the first bad commit
> commit 446fcce2a52b533c543dabba26777813c347577c
> Author: Lei Chen <lei.chen@smartx.com>
> Date:   Tue Aug 19 23:20:26 2025 +0800
>
>     Revert "x86: kvm: rate-limit global clock updates"
>
>     This reverts commit 7e44e4495a398eb553ce561f29f9148f40a3448f.
>
>     Commit 7e44e4495a39 ("x86: kvm: rate-limit global clock updates")
>     intends to use a kvmclock_update_work to sync ntp corretion
>     across all vcpus kvmclock, which is based on commit 0061d53daf26f
>     ("KVM: x86: limit difference between kvmclock updates")
>
>     Since kvmclock has been switched to mono raw, this commit can be
>     reverted.
>
>     Signed-off-by: Lei Chen <lei.chen@smartx.com>
>     Link: https://patch.msgid.link/20250819152027.1687487-3-lei.chen@smar=
tx.com
>     Signed-off-by: Sean Christopherson <seanjc@google.com>
>
>  arch/x86/include/asm/kvm_host.h |  1 -
>  arch/x86/kvm/x86.c              | 29 ++++-------------------------
>  2 files changed, 4 insertions(+), 26 deletions(-)
>
> =3D=3D=3D=3D Symptoms =3D=3D=3D=3D
>
> Measured on a KVM micro VM host running many Firecracker microVMs
> (node_exporter metrics, 2026-03-20):
>
>   kernel 6.19:
>     steal time inside guest VMs:    3=E2=80=9324% per vCPU  (sustained)
>     host system CPU (kernel mode):  3=E2=80=9312 CPUs saturated
>     host steal:                     3=E2=80=938%
>
>   kernel 6.18 (same host, same workload after rollback):
>     steal time inside guest VMs:    < 0.02% per vCPU  (~200x lower)
>     host system CPU (kernel mode):  2=E2=80=933 CPUs
>     host steal:                     0.3=E2=80=930.5%
>
> =3D=3D=3D=3D Root cause (by AI analyze) =3D=3D=3D=3D
>
> The regressing commit removes the rate-limiting from
> kvm_gen_kvmclock_update(). Previously this function deferred the
> all-vCPU kick via a 100ms delayed_work:
>
>   /* 6.18 */
>   static void kvm_gen_kvmclock_update(struct kvm_vcpu *v) {
>       kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
>       schedule_delayed_work(&kvm->arch.kvmclock_update_work,
>                             KVMCLOCK_UPDATE_DELAY);  /* 100ms */
>   }
>
> After the revert it kicks every vCPU of the VM synchronously on
> every call:
>
>   /* 6.19 */
>   static void kvm_gen_kvmclock_update(struct kvm_vcpu *v) {
>       kvm_for_each_vcpu(i, vcpu, kvm) {
>           kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
>           kvm_vcpu_kick(vcpu);
>       }
>   }
>
> KVM_REQ_GLOBAL_CLOCK_UPDATE, which calls kvm_gen_kvmclock_update(),
> is issued on every vCPU load when use_master_clock is false
> (arch/x86/kvm/x86.c, kvm_vcpu_load):
>
>     if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu =3D=3D -1)
>         kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
>
> With many Firecracker microVMs, the vCPU scheduling rate is high.
> Each scheduling event now IPIs every sibling vCPU of the VM, instead
> of coalescing all-vCPU kicks into at most one per 100ms. This creates
> a continuous IPI storm on the host, visible as high kernel (system)
> CPU time and high steal time inside guest VMs.
>
> The commit justifies the removal with "Since kvmclock has been switched
> to mono raw, this commit can be reverted." That reasoning is correct
> for the NTP-correction use case, but the 100ms rate-limit also
> protected against IPI storms when use_master_clock is false =E2=80=94 a
> concern independent of clock source.
>
> =3D=3D=3D=3D Full bisect log =3D=3D=3D=3D
>
> git bisect start
> # status: waiting for both good and bad commits
> # good: [7d0a66e4bb9081d75c82ec4957c50034cb0ea449] Linux 6.18
> git bisect good 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> # status: waiting for bad commit, 1 good commit known
> # bad: [05f7e89ab9731565d8a62e3b5d1ec206485eeb0b] Linux 6.19
> git bisect bad 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> # good: [02892f90a9851f508e557b3c75e93fc178310d5f] Merge tag
> 'hwmon-for-v6.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
> git bisect good 02892f90a9851f508e557b3c75e93fc178310d5f
> # bad: [edf602a17b03e6bca31c48f34ac8fc3341503ac1] Merge tag
> 'tty-6.19-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> git bisect bad edf602a17b03e6bca31c48f34ac8fc3341503ac1
> # bad: [09cab48db950b6fb8c114314a20c0fd5a80cf990] Merge tag
> 'soc-arm-6.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect bad 09cab48db950b6fb8c114314a20c0fd5a80cf990
> # good: [36492b7141b9abc967e92c991af32c670351dc16] Merge tag
> 'tracepoints-v6.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
> git bisect good 36492b7141b9abc967e92c991af32c670351dc16
> # good: [7cd122b55283d3ceef71a5b723ccaa03a72284b4] Merge tag
> 'pull-persistency' of
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect good 7cd122b55283d3ceef71a5b723ccaa03a72284b4
> # bad: [63a9b0bc65d5d3ea96a57e7985ea22a8582fbbe5] Merge tag
> 'kvm-riscv-6.19-1' of https://github.com/kvm-riscv/linux into HEAD
> git bisect bad 63a9b0bc65d5d3ea96a57e7985ea22a8582fbbe5
> # bad: [adc99a6cfcf76d670272dea64bbc2d43ecd12a2f] Merge tag
> 'kvm-x86-mmu-6.19' of https://github.com/kvm-x86/linux into HEAD
> git bisect bad adc99a6cfcf76d670272dea64bbc2d43ecd12a2f
> # bad: [c09816f2afce0f89f176c4bc58dc57ec9f204998] KVM: x86: Remove
> unused declaration kvm_mmu_may_ignore_guest_pat()
> git bisect bad c09816f2afce0f89f176c4bc58dc57ec9f204998
> # bad: [f6106d41ec84e552a5e8adda1f8741cab96a5425] x86/bugs: Use an x86
> feature to track the MMIO Stale Data mitigation
> git bisect bad f6106d41ec84e552a5e8adda1f8741cab96a5425
> # good: [9633f180ce994ab293ce4924a9b7aaf4673aa114] KVM: x86:
> Explicitly set new periodic hrtimer expiration in apic_timer_fn()
> git bisect good 9633f180ce994ab293ce4924a9b7aaf4673aa114
> # bad: [e78fb96b41c6ac85c1a02c7e9610d1ebaa9b5d98] KVM: x86: remove
> comment about ntp correction sync for
> git bisect bad e78fb96b41c6ac85c1a02c7e9610d1ebaa9b5d98
> # good: [a091fe60c2d3943b058132a64682a509d55bd325] KVM: x86: Grab
> lapic_timer in a local variable to cleanup periodic code
> git bisect good a091fe60c2d3943b058132a64682a509d55bd325
> # bad: [446fcce2a52b533c543dabba26777813c347577c] Revert "x86: kvm:
> rate-limit global clock updates"
> git bisect bad 446fcce2a52b533c543dabba26777813c347577c
> # good: [43ddbf16edf5c1790684b32d5eb920a1b0eea285] Revert "x86: kvm:
> introduce periodic global clock updates"
> git bisect good 43ddbf16edf5c1790684b32d5eb920a1b0eea285
> # first bad commit: [446fcce2a52b533c543dabba26777813c347577c] Revert
> "x86: kvm: rate-limit global clock updates"
>
> Best regards,
> Jaroslav Pulchart
