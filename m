Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A643B9935
	for <kvm@vger.kernel.org>; Sat, 12 Sep 2026 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789221334; cv=none; b=h3W2qYY4FuBrYVJj15D32qatb9u1+SFwuQi+fTyRuz2QBeRjbZh7A6lN1FPsViuZKYDb1yO+yS2PJFsdf6ewz2bS5m9mKwfCh9dJ7KvADqPC4i6JJ+cx+w2LVA+Z+qkQqT5apcbMuvpz+0wvkGwv9y4cvNJQ6+DrfMmVgMbX/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789221334; c=relaxed/simple;
	bh=uVKfO6ncg/PGTTBfsU+Wi1xqY76vwNEhFuFMY8lh9ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGFtmFeGfwZrPF7zr9TcFsUJ2epsvTfYA7yOZeYiWWbTbmvXx37CsEViu4XK4VGx9PiA11BC1JXllo8DJl05gczyrpLXUH6M4CPoMaGyWnrpok9gIGGFg5Sg+1lVRDLaIoXg9cZrUXQNPlwelhiXkJneoSynvPbObkppz8mI32U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VdzPXd2O; arc=none smtp.client-ip=91.218.175.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VdzPXd2O"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uVKfO6ncg/PGTTBfsU+Wi1xqY76vwNEhFuFMY8lh9ck=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789221326; v=1; x=1789826126;
 b=VdzPXd2O3VUmG4UTmfvINC0aqFutBYhZIPApHvjwlQLb+YuCJo8ripwU1I3uSbXSfLR/Swq6
 AmFPD9EMRRXH25z6g08ebF3uR0zfX3zvtrLB2Vdli5MzFPfzdNpPsyc+BJt+MfDi5iKKTvyjeAD
 rbjZL5tLVCUfTe2wacIuQaAo=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b9075f94b0b0c740;
	Sat, 12 Sep 2026 13:55:26 +0000
X-Mizu-Trace-ID: b9075f94b0b0c740
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b17359so1989e87.0
        for <kvm@vger.kernel.org>; Sat, 12 Sep 2026 06:55:25 -0700 (PDT)
X-Gm-Message-State: AFuF++nT0L73JjayFjqUhA6oMKvBwP1aBE2T+AOt5zB2+apyJXZPNX96
	panULbn6dSGorn0CZ28X8dUI3p5Q0NSdkMnI+zwsfQhTdRKqQdsLK4qvTxttEfhGNrvIl7h2yB2
	q104icXRV/owm00RAtnoU4fooNVDtKinIckEYCLMw
X-Received: by 2002:a05:6512:640a:b0:5b7:6707:e44c with SMTP id
 2adb3069b0e04-5b8a7942a1cmr77184e87.12.1789221324429; Sat, 12 Sep 2026
 06:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831192406.1341841-1-fuad.tabba@linux.dev>
 <20260831192406.1341841-2-fuad.tabba@linux.dev> <3bb3d57a-1862-4645-a5e2-789d70e9fc73@arm.com>
In-Reply-To: <3bb3d57a-1862-4645-a5e2-789d70e9fc73@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Sat, 12 Sep 2026 14:54:48 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwCs8B4du2=rAdoTOpOfh64p5cbW902e5g0u6NZT=r=gA@mail.gmail.com>
X-Gm-Features: AcwNN1XXru80mbEi-flRa5yydU4FWkY-cYPHjVpGY3RKCxyPaNbWIT0oyGhQsoc
Message-ID: <CA+EHjTwCs8B4du2=rAdoTOpOfh64p5cbW902e5g0u6NZT=r=gA@mail.gmail.com>
Subject: Re: [PATCH kvmtool 1/5] arm64: Do not abort on register-dump failures
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Andre Przywara <andre.przywara@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Sat, 12 Sept 2026 at 08:33, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 31/08/2026 20:24, Fuad Tabba wrote:
> > kvm_cpu__show_registers() and kvm_cpu__show_code() read the vCPU's core
> > registers with KVM_GET_ONE_REG, and die() if the ioctl fails. Both are
> > diagnostics. They run from the KVM_EXIT_DEBUG case in kvm_cpu__start(),
> > from the "lkvm debug -d" dump path in handle_sigusr1(), and from the
> > panic dump in kvm_cpu_thread().
> >
> > Once a protected vCPU has run, its registers belong to the guest and
> > KVM_GET_ONE_REG returns -EPERM. Dying on that turns a diagnostic into a
> > VMM abort.
>
> Marc once suggested that these could always succeed with junk values for
> protected/Realm VMs. Do you think that is an option for pKVM ?

It's possible, the host copy is still there, but I'd rather not. Once
the vCPU has run that copy is a mix rather than junk: the boot state
the VMM wrote, plus what the exit handlers copy out (the PSTATE mode,
x0 for an MMIO write, x0 to x2 for a forwarded PSCI call). A dump
would show a live PSTATE beside the PC from boot, and the VMM has no
way to distinguish them. With the error it prints that the state is
unavailable, which is what this patch does.

It's also what the tree does for protected state elsewhere: s390
returns -EINVAL from KVM_GET/SET_ONE_REG on a protected VM, and x86
does the same from the register ioctls for the SEV-ES VM type, SNP and
TDX. Legacy SEV-ES is the one place that succeeds silently, kept for
backwards compatibility, and the commit that added the errors
(517987e3fb19) describes that as a problem. Sean's rationale for TDX:
KVM can't provide sane data, so it's userspace's job not to ask for it
[1].

>
> If we go with this approach :
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks, I'll add the tag. :)

Cheers,
/fuad

[1] https://lore.kernel.org/all/482264f17fa0652faad9bd5364d652d11cb2ecb8.1625186503.git.isaku.yamahata@intel.com/

>
>
> >
> > Report that the register state is unavailable, with the errno, and
> > return instead of dying.
> >
> > Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> > ---
> >   arm64/kvm-cpu.c | 36 ++++++++++++++++++++++++------------
> >   1 file changed, 24 insertions(+), 12 deletions(-)
> >
> > diff --git a/arm64/kvm-cpu.c b/arm64/kvm-cpu.c
> > index 3aa7684..c58d61f 100644
> > --- a/arm64/kvm-cpu.c
> > +++ b/arm64/kvm-cpu.c
> > @@ -476,15 +476,19 @@ void kvm_cpu__show_code(struct kvm_cpu *vcpu)
> >
> >       dprintf(debug_fd, "\n*pc:\n");
> >       reg.id = ARM64_CORE_REG(regs.pc);
> > -     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
> > -             die("KVM_GET_ONE_REG failed (show_code @ PC)");
> > +     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
> > +             pr_err("register state unavailable (pc): %s", strerror(errno));
> > +             return;
> > +     }
>
> >
> >       kvm__dump_mem(vcpu->kvm, data, 32, debug_fd);
> >
> >       dprintf(debug_fd, "\n*lr:\n");
> >       reg.id = ARM64_CORE_REG(regs.regs[30]);
> > -     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
> > -             die("KVM_GET_ONE_REG failed (show_code @ LR)");
> > +     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
> > +             pr_err("register state unavailable (lr): %s", strerror(errno));
> > +             return;
> > +     }
> >
> >       kvm__dump_mem(vcpu->kvm, data, 32, debug_fd);
> >   }
> > @@ -499,23 +503,31 @@ void kvm_cpu__show_registers(struct kvm_cpu *vcpu)
> >       dprintf(debug_fd, "\n Registers:\n");
> >
> >       reg.id          = ARM64_CORE_REG(regs.pc);
> > -     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
> > -             die("KVM_GET_ONE_REG failed (pc)");
> > +     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
> > +             pr_err("register state unavailable (pc): %s", strerror(errno));
> > +             return;
> > +     }
> >       dprintf(debug_fd, " PC:    0x%lx\n", data);
> >
> >       reg.id          = ARM64_CORE_REG(regs.pstate);
> > -     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
> > -             die("KVM_GET_ONE_REG failed (pstate)");
> > +     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
> > +             pr_err("register state unavailable (pstate): %s", strerror(errno));
> > +             return;
> > +     }
> >       dprintf(debug_fd, " PSTATE:    0x%lx\n", data);
> >
> >       reg.id          = ARM64_CORE_REG(sp_el1);
> > -     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
> > -             die("KVM_GET_ONE_REG failed (sp_el1)");
> > +     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
> > +             pr_err("register state unavailable (sp_el1): %s", strerror(errno));
> > +             return;
> > +     }
> >       dprintf(debug_fd, " SP_EL1:    0x%lx\n", data);
> >
> >       reg.id          = ARM64_CORE_REG(regs.regs[30]);
> > -     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
> > -             die("KVM_GET_ONE_REG failed (lr)");
> > +     if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
> > +             pr_err("register state unavailable (lr): %s", strerror(errno));
> > +             return;
> > +     }
> >       dprintf(debug_fd, " LR:    0x%lx\n", data);
> >   }
> >
>
