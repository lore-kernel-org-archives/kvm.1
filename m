Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B222370A
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774105213; cv=pass; b=N0ye8bzHFruHFoI14/fq8L3zXJzUSWH1ivqMFem8VRSsV3hnmvW5NKJk9SOD1O8CtFA73taqXIfg8s59MctIUEfJj2ZpAfyFxXdZ6Ut33s74RzQRfdUR+7EW4CTmu8BfkZJRSzmLX7eC/yLRNS1uVZfVAuS4XjNM2r8WrXn6mR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774105213; c=relaxed/simple;
	bh=lJA3zVnptFmujgyzahO2FU56UifVFVHzw6lDxAUADcs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lPQNAQE06TVBWm8/LhppBhhodKIPWqs5PzvR4N+DHzbBkDsfwNuiUXr7f/tw4qrdGSqIw0VFDkvYCFRP76lS0nXRmvB69gH7LeZJGdLcTmYl64258NCX05Vsx1xVJkmnUUtUKKAQBNicNPEJVIkYQ1oBxuJqvhAEKvYluCdkQgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=nOhqbn9/; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="nOhqbn9/"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12732165d1eso3719230c88.1
        for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 08:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774105210; cv=none;
        d=google.com; s=arc-20240605;
        b=eUYKvRRMclZXknOMaMryvLabBTaMTvT3R90bwkuHROxOJxoChCe9kWjWR66ROeeVEo
         LYXC3/9+dJlErni1smT9gTUdhnaJxHbDmNMGov4Sr2yTK3YWTr0gcsiujqGS5sEFZo5S
         bI1fUe0EvUQDs9nOP4yO9P0Mxsbza14ZtFPrtzrZKDb0NZvaj0vDiOUZmz6GrvB+KARt
         O61OGZDiDs7HbRAnJxMxy/Uk/q3FxbHohCZtDv3Bibz8BbbCElcLf5MYDYMkQbC/KgUU
         wfYKAOTHUJZyUx+lr72+VfBbG5QOEPnkVy61p4IjFc2SleBWE7Q5Nnw+eca0Ri6aUhyP
         Oh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=fZuVY16DukHmQOQcv1OssEFVm50dsJzgS8VxJwB80UQ=;
        fh=x8NTJ6vNWvVKosfTKs6M2kCZ88nXtY12kvIQXU0QJbc=;
        b=O+nGgYX+mLGJOlLGU4P7RIvmBQHNAPsB+ZOarefkjD+x03KUbKvAzVtiftSLLYGUKT
         sD3mLfgiP4165RJCSWUgmndMLrsixkdpoKazmSUF/3I3lU1wwSRkXfvuO/XGCnylkqKS
         6c6O0xIkOMB5rvc7jU4YlXc6NotGTxuufA63WgGQkdPK3XNQrLeg+FlSy1x04xYe4OXk
         wt52s9+0gVUO+wXouRf+siHAxRFAxSikQugLj3rSbq3MqTOfkOvaTpP6SlqKTy+Gi2kP
         xdsRexWgMiDpIsPkHKWwfOV2K/zRR8ErbX+WyEqW3JpSqAoojlIBbioJX9vWSrIaE28B
         PPYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1774105210; x=1774710010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fZuVY16DukHmQOQcv1OssEFVm50dsJzgS8VxJwB80UQ=;
        b=nOhqbn9/ObKrwxWgurE2A1Ma68UxMf3uGIcTovvvGFyvLAyP8lHJHQ7ZqrUcznLpyT
         KWdP0KbvhvyuzQ6LQTmKE6BmSR99SxV9AbId8OsgaBgAP+xc8+Xw8QWUMu3pccAg94A1
         HPyAAGjLugMHi1baTt9OHKAvXnq4iTCxAtLKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774105210; x=1774710010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZuVY16DukHmQOQcv1OssEFVm50dsJzgS8VxJwB80UQ=;
        b=O8BW1qaUR74mrHbz7xbLWJyLBjxM6tq+4lJtujf59KX4gmVDprWpRFMBnze/79yiJh
         bsdMKSG0CpuemXZkuD01Wmwx/gG+M+t2Y4EQPbKC/YJ9W3mTSRdNInuyDDnbYi8u2ybm
         6a1uVOkjKxg4WT3yzxx9hT0mKi/B37EkJmLbmabfRH014Vpo8DQ+6gcjA3ba6fZyF+Dx
         lzp3rfS0jY/rSLQqi3yBanKUgCjJHg62KDwFQqe/OlHK0WJocFTX8Y5VsGSAZC3i9IDn
         c275AG/f0ZjDg+ZgxuFNmT1CFUB2q8qGQFseEXbmxYkjQLUN7GlAvOiZnkE3gSJZz66z
         74yQ==
X-Gm-Message-State: AOJu0YyfBlAgrSDsTHqPzA4zBqtdMExSnzEW36zcG17QVibE1VW3H8Iu
	tQlbKP6JSPkR3or4JMX4HbyBdw9U6iEuaZTzgA/mmernu56jOvQtMWVvpbX7OrbVuJg6AkMee0S
	8k/XDHSNGSzMcQNjkidJC+0/LZ2ZO8GjcJh7npSn22omz1R1G9pEV+Q==
X-Gm-Gg: ATEYQzyQzTyiK+SKkgf0jUcct+1VRczCtwqnU6NSuBIdcH8yOF5AaLk24eaU4m6ExpA
	/qFHfewuMcv5tvh8SQkYiVz/ZciemBx1tOSkn8kJkvlXGj4hWT//nukDPw9KK3h4pu7CMvieksU
	tSsFlw1dCS9ftZkAx2N2D9H3x4Ri+WAmn183e0zgNrZpo+V4H3gVmSDLg8Txd3WdFbTp2YVjBVe
	AZiR+2Jr05nLz2H+oUVqJcyxx9oOMF6ReMuee53xvgXjsZpW4L6edmqgkzn77Kqy6GvQRmfhTlQ
	ab81jFBw
X-Received: by 2002:a05:7022:ef09:b0:129:fe5:117e with SMTP id
 a92af1059eb24-12a726a2f31mr2780652c88.26.1774105209923; Sat, 21 Mar 2026
 08:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Sat, 21 Mar 2026 15:59:43 +0100
X-Gm-Features: AaiRm529UE_G1M8HYwMaEwnJUTFL4R9WDhv1PM9VZ4NM5QLUW3ss_2QFuZEdcYU
Message-ID: <CAK8fFZ5qLeA3b9P+_N3QejwGLAmeAA0XJyQnCXROu-0a5gzH2Q@mail.gmail.com>
Subject: [REGRESSION 6.19, BISECTED] KVM: x86: kvmclock rate-limit removal
 causes IPI storm and high guest steal time
To: kvm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, seanjc@google.com, pbonzini@redhat.com, 
	lei.chen@smartx.com, Igor Raits <igor@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am reporting a performance regression in Linux 6.19 that severely
impacts KVM hosts running many Firecracker microVMs.

=3D=3D=3D=3D Bisect result =3D=3D=3D=3D

446fcce2a52b533c543dabba26777813c347577c is the first bad commit
commit 446fcce2a52b533c543dabba26777813c347577c
Author: Lei Chen <lei.chen@smartx.com>
Date:   Tue Aug 19 23:20:26 2025 +0800

    Revert "x86: kvm: rate-limit global clock updates"

    This reverts commit 7e44e4495a398eb553ce561f29f9148f40a3448f.

    Commit 7e44e4495a39 ("x86: kvm: rate-limit global clock updates")
    intends to use a kvmclock_update_work to sync ntp corretion
    across all vcpus kvmclock, which is based on commit 0061d53daf26f
    ("KVM: x86: limit difference between kvmclock updates")

    Since kvmclock has been switched to mono raw, this commit can be
    reverted.

    Signed-off-by: Lei Chen <lei.chen@smartx.com>
    Link: https://patch.msgid.link/20250819152027.1687487-3-lei.chen@smartx=
.com
    Signed-off-by: Sean Christopherson <seanjc@google.com>

 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/x86.c              | 29 ++++-------------------------
 2 files changed, 4 insertions(+), 26 deletions(-)

=3D=3D Symptoms =3D=3D

Measured on a KVM micro VM host running many Firecracker microVMs
(node_exporter metrics, 2026-03-20):

  kernel 6.19:
    steal time inside guest VMs:    3=E2=80=9324% per vCPU  (sustained)
    host system CPU (kernel mode):  3=E2=80=9312 CPUs saturated
    host steal:                     3=E2=80=938%

  kernel 6.18 (same host, same workload after rollback):
    steal time inside guest VMs:    < 0.02% per vCPU  (~200x lower)
    host system CPU (kernel mode):  2=E2=80=933 CPUs
    host steal:                     0.3=E2=80=930.5%

=3D=3D=3D=3D Root cause analyze by AI =3D=3D=3D=3D

The regressing commit removes the rate-limiting from
kvm_gen_kvmclock_update(). Previously this function deferred the
all-vCPU kick via a 100ms delayed_work:

  /* 6.18 */
  static void kvm_gen_kvmclock_update(struct kvm_vcpu *v) {
      kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
      schedule_delayed_work(&kvm->arch.kvmclock_update_work,
                            KVMCLOCK_UPDATE_DELAY);  /* 100ms */
  }

After the revert it kicks every vCPU of the VM synchronously on
every call:

  /* 6.19 */
  static void kvm_gen_kvmclock_update(struct kvm_vcpu *v) {
      kvm_for_each_vcpu(i, vcpu, kvm) {
          kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
          kvm_vcpu_kick(vcpu);
      }
  }

KVM_REQ_GLOBAL_CLOCK_UPDATE, which calls kvm_gen_kvmclock_update(),
is issued on every vCPU load when use_master_clock is false
(arch/x86/kvm/x86.c, kvm_vcpu_load):

    if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu =3D=3D -1)
        kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);

With many Firecracker microVMs, the vCPU scheduling rate is high.
Each scheduling event now IPIs every sibling vCPU of the VM, instead
of coalescing all-vCPU kicks into at most one per 100ms. This creates
a continuous IPI storm on the host, visible as high kernel (system)
CPU time and high steal time inside guest VMs.

The commit justifies the removal with "Since kvmclock has been switched
to mono raw, this commit can be reverted." That reasoning is correct
for the NTP-correction use case, but the 100ms rate-limit also
protected against IPI storms when use_master_clock is false =E2=80=94 a
concern independent of clock source.

=3D=3D=3D=3D Full bisect log =3D=3D=3D=3D

git bisect start
# status: waiting for both good and bad commits
# good: [7d0a66e4bb9081d75c82ec4957c50034cb0ea449] Linux 6.18
git bisect good 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
# status: waiting for bad commit, 1 good commit known
# bad: [05f7e89ab9731565d8a62e3b5d1ec206485eeb0b] Linux 6.19
git bisect bad 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
# good: [02892f90a9851f508e557b3c75e93fc178310d5f] Merge tag
'hwmon-for-v6.19' of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
git bisect good 02892f90a9851f508e557b3c75e93fc178310d5f
# bad: [edf602a17b03e6bca31c48f34ac8fc3341503ac1] Merge tag
'tty-6.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect bad edf602a17b03e6bca31c48f34ac8fc3341503ac1
# bad: [09cab48db950b6fb8c114314a20c0fd5a80cf990] Merge tag
'soc-arm-6.19' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad 09cab48db950b6fb8c114314a20c0fd5a80cf990
# good: [36492b7141b9abc967e92c991af32c670351dc16] Merge tag
'tracepoints-v6.19' of
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect good 36492b7141b9abc967e92c991af32c670351dc16
# good: [7cd122b55283d3ceef71a5b723ccaa03a72284b4] Merge tag
'pull-persistency' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect good 7cd122b55283d3ceef71a5b723ccaa03a72284b4
# bad: [63a9b0bc65d5d3ea96a57e7985ea22a8582fbbe5] Merge tag
'kvm-riscv-6.19-1' of https://github.com/kvm-riscv/linux into HEAD
git bisect bad 63a9b0bc65d5d3ea96a57e7985ea22a8582fbbe5
# bad: [adc99a6cfcf76d670272dea64bbc2d43ecd12a2f] Merge tag
'kvm-x86-mmu-6.19' of https://github.com/kvm-x86/linux into HEAD
git bisect bad adc99a6cfcf76d670272dea64bbc2d43ecd12a2f
# bad: [c09816f2afce0f89f176c4bc58dc57ec9f204998] KVM: x86: Remove
unused declaration kvm_mmu_may_ignore_guest_pat()
git bisect bad c09816f2afce0f89f176c4bc58dc57ec9f204998
# bad: [f6106d41ec84e552a5e8adda1f8741cab96a5425] x86/bugs: Use an x86
feature to track the MMIO Stale Data mitigation
git bisect bad f6106d41ec84e552a5e8adda1f8741cab96a5425
# good: [9633f180ce994ab293ce4924a9b7aaf4673aa114] KVM: x86:
Explicitly set new periodic hrtimer expiration in apic_timer_fn()
git bisect good 9633f180ce994ab293ce4924a9b7aaf4673aa114
# bad: [e78fb96b41c6ac85c1a02c7e9610d1ebaa9b5d98] KVM: x86: remove
comment about ntp correction sync for
git bisect bad e78fb96b41c6ac85c1a02c7e9610d1ebaa9b5d98
# good: [a091fe60c2d3943b058132a64682a509d55bd325] KVM: x86: Grab
lapic_timer in a local variable to cleanup periodic code
git bisect good a091fe60c2d3943b058132a64682a509d55bd325
# bad: [446fcce2a52b533c543dabba26777813c347577c] Revert "x86: kvm:
rate-limit global clock updates"
git bisect bad 446fcce2a52b533c543dabba26777813c347577c
# good: [43ddbf16edf5c1790684b32d5eb920a1b0eea285] Revert "x86: kvm:
introduce periodic global clock updates"
git bisect good 43ddbf16edf5c1790684b32d5eb920a1b0eea285
# first bad commit: [446fcce2a52b533c543dabba26777813c347577c] Revert
"x86: kvm: rate-limit global clock updates"

Best regards
--=20
Jaroslav Pulchart
