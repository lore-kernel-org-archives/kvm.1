Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC6846F
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774103608; cv=pass; b=pAWcXRzhifZT8w63sP11tfjLsyUVCWehROSSiGfGDZ9ntwMovPlDYPUQmSRqrBPsgTCGhf9AksnG3ifdiUL6TVuUq2aCtzt7LERAytCNWi9UdO927gv0UrVixEyXsZWUardMdOSqgl9jTawheoS44Pp13lZxklql084RX6eL2tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774103608; c=relaxed/simple;
	bh=F7MwGert12x9G206yLLAO/tP/xXu47T7HnKN8gb0STs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ThbL27R0xMrGvYCLboYhJfI5Da4eyahsznVb3EcmFLj7yXJG8wurjH49jDxL2SE0qJgmzRBozOM453U/KrBUzUPYnFNk3kBFypI3QeDBtthweem3cL2LEUeE5GhGDYP0ABwwfR0aTF/TRaAE+D4zyHF2nipVF8F/drQhsPnWjwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=Yar203Ow; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="Yar203Ow"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1271195d2a7so3071525c88.0
        for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 07:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774103606; cv=none;
        d=google.com; s=arc-20240605;
        b=ZK+/Zsd2RlJS3eHopRiZ1P90lP36gfuHg4Ep/2fMt9W8KUnYLyUzNXAPy7KTbMPPUL
         hqqYdpqFBU/aIktVs5um6/MxF2zXCcIlrCEEVQFtGy7QqtiMFvecR47xbYzI3JNco506
         ysQV0twPbrLnWo0o18CEf0mS/3LsSgUDvvD9MLu5fFaBpZICipkphKUDUT6ptYUCHE1z
         ikZrzy0Kwy8lTrkmQVNxNBS3zUgSnLvsKspntwkEzhSlMOsAMgnP0Yp9kkVQjePioy+H
         9O1D2N2bDLen13xXXMdDwJBKh6AjsY+v6kFfd/ueL0GnBVEHFOREexxQS+QAdr3wt9L5
         JTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=t6QzDZsrAt5FnuqyqbOX3MCEeiHQMmacgMlaJvv7TD0=;
        fh=x8NTJ6vNWvVKosfTKs6M2kCZ88nXtY12kvIQXU0QJbc=;
        b=EoP3HzpuT3nwhSVnEzoYCvwpYOV/FKVyuEb9EBQa2NeBTf0JkaNDjmYZb5Q1uKxt29
         gQTtpAO9IyrJdES4ShujC3T7rQrK7yy25Qx9+ikNMS5H3ZLFcMRheBowmOexR8oMlO9x
         QivovzRRwGD7FPg3nKF1IQgAkMEQd5es9QdGC+HQ4ON3JCHjdMhVshcxsbQlu1CKt4zN
         Js/h4He/wDMXMgjbNtrEIHGb+7QpDXPekLkaRMDNGK8wd/uuXWiP5yToJIb4G2VyasAN
         xSujaSa+CIrspS/VE1MJUKWRgGdmPcKnvE/gYiliUMRR6B03DViKBJJMXHEXb2F4Bm7e
         tQPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1774103606; x=1774708406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6QzDZsrAt5FnuqyqbOX3MCEeiHQMmacgMlaJvv7TD0=;
        b=Yar203OwAjCJUKCCOIssdm07Mlp2rkVszWgsFBN9VSBJub6CNYHqesgEnPeSvrir3a
         raLBIIgDaCS34dZe5scH2hTFJPbIvLXTQdNoqQ1rkXDR2fgJB6pKQqvrTGotBHlAaBTj
         EWAJ3Jy3X63wKUdm/49/YH5Rbe4LlCMvNa27w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774103606; x=1774708406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6QzDZsrAt5FnuqyqbOX3MCEeiHQMmacgMlaJvv7TD0=;
        b=mYpZEWbFmHl/9f+vjE6owBMEEi+QRda2/td6MbArB65PtnqCBwjNOc4pgTIOgxTIWQ
         8JX/V4gya5bZfVyOUbp5Dk9K6lMinAp58irWxvsw08eT/KuR8+qrVY194yaslYCzEQfi
         fZvKDnojfP8menJNaYp6Al1XObDqJNTDKqhpOE0S91LEpTA1Zi/foiLziD11y87rC/FC
         15OxdcbMzBNKq4MgZy/PiJlGB/p4UyOHaa8WqN1EoR8b1KDp4CwUOWFe0ueKxaH2bLUN
         9/QcgO46lccTpZ1gxZghGQqAB9ZbjV+dtTJZq0UZwnGuEdDO1xq2C/GakRaFd4nM7UOb
         +GCg==
X-Gm-Message-State: AOJu0Yw7yespaipucHpM8UG3Fsrmv49dyJp5c1fSLI49OWxob+3AMWRa
	d6Ly+wIIM6xlFqwvlvAsM3KLCQT8RAOMX89yDDqGu+uHxQECm1Imz86+VolI+cytP34BGtXftAy
	GqEMZodj7MEgL0d1y0AxKpP4UH3RxiAF9+OejCv5/molskEuWI3vj5Q==
X-Gm-Gg: ATEYQzxPwsgtxPMH9yzYjpRgfFdzx3sSo746oTWXb3plnZAxY5ZiF7G0AuUivgHmFNJ
	NAlc8SPvLTEqOSg0G7Ln4mgowWZo0C2xquvT8A7bR3Z4ctkWyv7wub6pFLAEGSGiMWBBM1VJrFS
	hmv0tuaMBTPYSO77KW21+V+03uLxati9rqbVdTK7dUl+4x19GCjmlLBjQxYwQFkD5Lcw0Id/5Ji
	AOqRT1AXXENq0MEiuFymhw6ZUUMK9is6Z/tqCPEfaqq/Gz9I1S363R754lsO3RBYI7ELG/NgIn/
	SuJTShlM
X-Received: by 2002:a05:7022:ea33:b0:12a:6a64:81fe with SMTP id
 a92af1059eb24-12a72647245mr3211448c88.8.1774103606235; Sat, 21 Mar 2026
 07:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Sat, 21 Mar 2026 15:32:59 +0100
X-Gm-Features: AaiRm53Q_yBx55C4eKc6HsAa25NQDi4z13AsxgT8870JqvcFdksAYcPpAkoxv-Y
Message-ID: <CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com>
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

=3D=3D Bisect result =3D=3D

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

=3D=3D=3D=3D Symptoms =3D=3D=3D=3D

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

=3D=3D=3D=3D Root cause (by AI analyze) =3D=3D=3D=3D

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

Best regards,
Jaroslav Pulchart
