Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB31A9FB7
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791004407; cv=pass; b=rI/oE1shhtFR45cbSDL26uOWjyNipvPoAraT8GB3coAfnqJV1ybt6RjFbma5/45VvtXL3nJg1IaRdvo5CqkTyamC8o54a0R8423GrK4b5veBqA/V0WlYLYXEe0KimKBt09WYsUJt6xCwISpikUEHhBlMX5aB9uIY18ceW6iT/UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791004407; c=relaxed/simple;
	bh=c21Wo+/2g/WjcHOxIjHfoI3SUBjaHXeuY4OLe6Mm0UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cqt2creYdD3Zzw+SgFRBZdn6NJnKBtMAJg4kVvncCbnzTewT3xnGy6C7k3kguI5qYmzc61uQqHa+W/vYkhi09t9F3upwwEfAckmzR6q0p5IipR5LBiI3KI/D4b7FaZ7ekx45qVFQpgUjGX2bq59MzO95f7/f2X489fqStHQ+tRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=isl6JP1E; arc=pass smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="isl6JP1E"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b03eb33b2so30045f8f.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 22:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791004404; cv=none;
        d=google.com; s=arc-20260327;
        b=YEIyOSdlxNcwO73s2tNFG/7x/EoF1uob07ao5r2dR5xTSdM6kJPO0843clwi2vnEhQ
         x+PMQpkutVR8uTHNY0NnHGWKZoyfO0zfD2BQz9WdjmWhhcaWcErziM+COO5CG4G9HKmt
         3ZWoV/zBGnuZCkHpoWOjgBp5p81VRC8+a20nShaOP4nc4ay212QxrCNzX091Az7Cyvbs
         ihUFmNqV8gzIb3MZkkhNKAwNAQmYNfM/7lxMob0qvY1Atlf4rbxdQAg0IyAdPwfS8BIl
         EXy98V8lwrwnAq7DO95wGCNLLNDRC5w5p6/gnHowR/J4XXtieEZG6csS+6QldtJ+40Je
         NE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ja5/K6y/ZwOjuHXyeMKgCswBU4BMbBpgHHGQKqQjNeY=;
        fh=ZjhwMn7ojW3/Hdv1FC5Kmeuj5gjJfBsqK1jp4ks5rs4=;
        b=PLdQ4jJErCSxJ73R5ZQF0sxoFbMoWYxw/buqIEFgrXsHKXQqdCYXDMeffIagOFFhRM
         AlP2B/6hzavaPK/3T7wXXhREuj59KgthR40nyJDWAgd4OwGYlpr695BSlfwSluS23FSS
         1Y6j7iTrBrzbctJ63dJyCQni1K+1y2KKzo4aEA9uGHHJu30ujxcSzmbwmbxsoH5PcjNq
         sYUdkVA18LpySaxObAC+FKETpe3kbtnkL+jJ46HWrTrZlxCNKrmJfFi3IfvTOv2fB3aB
         +gi4QuC2bjeu59icrmqFylKoy2nDByqee2qUkwnOxG91Iot/nYeByn3OUKwM/iMo4NDE
         FR7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791004404; x=1791609204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ja5/K6y/ZwOjuHXyeMKgCswBU4BMbBpgHHGQKqQjNeY=;
        b=isl6JP1EwEGsrR/nNYuwyLfCmUE0f09rU+Eg59ANFPx7W7MonD+MRPqA4q5WJvelXv
         g+Q+wfNNVcF0y1EUYfgW8JJt70wAnWaemUecBJb3BI0KzuUF+Lw3oAkqI8IYP4Tqr4ax
         Ndka/zWiWpecmCmjXRTGGX2o1IVwNd7LMIZBmY44icLva72sUT8kgsC/0AfrpvVJwX6e
         aB0s87pI6VMRxA+fKe5xJYO3E1srxPZl67/JRKoZhbHDdFne5MS2hmm0Ra40oMAcw0Za
         0XqQ5Xy7dOfSyalsColSFsEL2GRw61P84abjCN0/1j1VKj6embHdNXEOBLpoQkkyr/DG
         E1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791004404; x=1791609204;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ja5/K6y/ZwOjuHXyeMKgCswBU4BMbBpgHHGQKqQjNeY=;
        b=IR9084qzk9alsfQGA7U0fhbSSpGZW9B71nwaeMKuhzgTv6Dryygq58H9dByzOAQUez
         G6VmtF4txLe7hUitTKzQURa4tJ4JoxH5Y/bILJ/NCoeH7L+3ARilx5S1qA4l+Rbs+vw/
         3bIkaY0ojsMBLnS2ceNbrw5ILDN9oB1xQKh5KL0sQMRuFicuQiB6ZsCyuCDKie8ZGcZ5
         LEaHz/DJOdAkTvsqG8Op84LBHxtg70IhvjRovnug8Muz2bMjHG7lZ7rIxbLHomvYJMIF
         RHdCOyTHexyXfuzm0dh3hJQhZKqCd7oGEWvdgo/eC40cl8e74r8QyROrqEbZH0gmtRBh
         +wkA==
X-Forwarded-Encrypted: i=1; AKwUvBxZLF7Q3n17A7PsjK4iqiSnvlAvyQRIhEe+nZICzL015mXGL8nUzF2zROkqHYFT0KonlaI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIP9rzDj7N7yE4nzeHVd9CcbcHanSFRM4GjKInF01jXZV3peYRo
	hv8JLP/Ad//cRJ5VDOEtWbqxGCQKhwDR1DTSZPsE+15TqED3EwYPTfX2Qgk6tZy2/iibSp9qlmU
	CxvODxqi0g8WaEOoCv0Y2qRfaFCIpcp77qAluOQaJQw==
X-Gm-Gg: AYBFou3EwyAznaMi/yi3Ac7mSlIx4B74237JpFIDdrrMGKcrweVvf5U3UdARu5gdYNq
	DXHVFKzfYg5JrbxQGtphd1OZNNPnQuN4kafhItK4lPceqSYcwf1y9Km5MFBDFZbibMDhpyh2ebd
	r7rEzBSILBxPi5NltNG2NYzGxsFNzuIDk8nbYdoZTBYhSnKZbfpYPVIbMs5ThwpVD0s/l9UudNT
	hLL2ADyGVR5MB+Z4innm84eZWN8Ir+Aza/jkIlrtymdqP7eVAx1H67WPIWpyFUKBPCjY3VVuQzO
	BqTzJbuJjy+4LmGGkJm9FM9Jzhj2GUf+++ULZiEogUsbwHLLGgW2CwmxE/0OG5NkCdDtvmgk/Xt
	ZuwSLYacgdgjykw+8faOxgnPn0H7DLzV5hNMDX/PKsNO86cJ7EbJMYXfteHU8nbak1pnt/OxQok
	8=
X-Received: by 2002:a05:6000:61a:b0:48c:4a62:9b31 with SMTP id
 ffacd0b85a97d-48c4a62a7b5mr1221302f8f.5.1791004403595; Fri, 02 Oct 2026
 22:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807053227.341700-1-yhchen312@gmail.com> <20260807053227.341700-2-yhchen312@gmail.com>
In-Reply-To: <20260807053227.341700-2-yhchen312@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 3 Oct 2026 10:43:12 +0530
X-Gm-Features: AclHuK_pQRRoDWZRfANFMjdOjJ21LWi5Ny6ywTR26TEbK6g2y0ccg6Q7CWbAjRc
Message-ID: <CAAhSdy3Zfdv3WzFZPPQqjR6_VPvfAGzirx=sXcy1G76TEdJYfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] RISC-V: KVM: Add PMU event filter support
To: "Yuhang.chen" <yhchen312@gmail.com>
Cc: atish.patra@linux.dev, palmer@dabbelt.com, pjw@kernel.org, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, pbonzini@redhat.com, shuah@kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 11:02=E2=80=AFAM Yuhang.chen <yhchen312@gmail.com> w=
rote:
>
> Allow userspace to restrict which SBI PMU events a guest is permitted
> to program via the new VM ioctl KVM_SET_PMU_EVENT_FILTER.  It takes a
> struct kvm_pmu_event_filter whose events[] array holds SBI PMU event
> indices encoded as (type << 16) | code.  The action field selects ALLOW
> (only listed events may be programmed) or DENY (listed events are
> rejected); nevents =3D=3D 0 clears any active filter.
>
> The filter is enforced in kvm_riscv_vcpu_pmu_ctr_cfg_match(), where a
> disallowed event fails configuration with SBI_ERR_NOT_SUPPORTED.  It
> governs new counter configuration only and is not retroactive.  The
> filter lives in struct kvm_arch, read via SRCU on the vCPU run path and
> replaced under kvm->lock with synchronize_srcu_expedited().  Event
> indices are masked to their valid bits before comparison, so reserved
> high bits cannot bypass a DENY filter.
>
> Advertise the feature with KVM_CAP_PMU_EVENT_FILTER.
>
> Assisted-by: YuanSheng:deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
> ---
>  arch/riscv/include/asm/kvm_host.h |  3 ++
>  arch/riscv/include/uapi/asm/kvm.h | 20 +++++++++
>  arch/riscv/kvm/vcpu_pmu.c         | 31 ++++++++++++++
>  arch/riscv/kvm/vm.c               | 69 ++++++++++++++++++++++++++++++-
>  4 files changed, 122 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 60017ceec9d2..1cd3d6a11057 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -95,6 +95,9 @@ struct kvm_arch {
>
>         /* KVM_CAP_RISCV_MP_STATE_RESET */
>         bool mp_state_reset;
> +
> +       /* KVM_SET_PMU_EVENT_FILTER */
> +       struct kvm_pmu_event_filter __rcu *pmu_event_filter;
>  };
>
>  struct kvm_cpu_trap {
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 504e73305343..da4f639fa89f 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -12,6 +12,7 @@
>  #ifndef __ASSEMBLER__
>
>  #include <linux/types.h>
> +#include <linux/stddef.h>
>  #include <asm/bitsperlong.h>
>  #include <asm/ptrace.h>
>
> @@ -396,6 +397,25 @@ struct kvm_riscv_sbi_fwft {
>  /* One single KVM irqchip, ie. the AIA */
>  #define KVM_NR_IRQCHIPS                        1
>
> +/* for KVM_CAP_PMU_EVENT_FILTER */
> +#define KVM_PMU_EVENT_ALLOW    0
> +#define KVM_PMU_EVENT_DENY     1
> +
> +/*
> + * For KVM_SET_PMU_EVENT_FILTER: restrict which SBI PMU events a guest m=
ay
> + * configure.  Each @events entry is a SBI PMU event index (type in bits
> + * 19:16, code in bits 15:0).  %KVM_PMU_EVENT_ALLOW permits only listed
> + * events; %KVM_PMU_EVENT_DENY rejects them.  Enforced at counter
> + * configuration (SBI PMU COUNTER_CFG_MATCH), not retroactively.
> + */
> +struct kvm_pmu_event_filter {
> +       __u32 action;
> +       __u32 nevents;
> +       __u32 flags;
> +       __u32 pad;
> +       __DECLARE_FLEX_ARRAY(__u64, events);
> +};
> +

This definition of kvm_pmu_event_filter does not cover SBI PMU
RAW and RAWv2 events.

Maybe you can go with something like below:

struct kvm_pmu_event {
       __u32 pad;
       __u32 event_idx;
       __u64 event_data;
};

struct kvm_pmu_event_filter {
#define KVM_PMU_EVENT_ACTION_ALLOW    0
#define KVM_PMU_EVENT_ACTION_DENY      1
       __u32 action;
       __u32 nevents;
       __u32 pad[2];
       __DECLARE_FLEX_ARRAY(struct kvm_pmu_event, events);
};

>  #endif
>
>  #endif /* __LINUX_KVM_RISCV_H */
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index bb46dcbfb24d..756040913468 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -733,6 +733,32 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcp=
u, unsigned long ctr_base,
>         return 0;
>  }
>
> +static bool kvm_riscv_pmu_event_allowed(struct kvm *kvm, unsigned long e=
idx)
> +{
> +       struct kvm_pmu_event_filter *filter;
> +       bool in_list =3D false;
> +       unsigned int i;
> +
> +       /* Reserved high bits must not bypass the filter. */
> +       eidx &=3D SBI_PMU_EVENT_IDX_MASK;
> +
> +       filter =3D srcu_dereference(kvm->arch.pmu_event_filter, &kvm->src=
u);
> +       if (!filter)
> +               return true;
> +
> +       for (i =3D 0; i < filter->nevents; i++) {
> +               if ((unsigned long)filter->events[i] =3D=3D eidx) {
> +                       in_list =3D true;
> +                       break;
> +               }
> +       }
> +
> +       /* ALLOW: permit only listed events; DENY: reject them. */
> +       if (filter->action =3D=3D KVM_PMU_EVENT_ALLOW)
> +               return in_list;
> +       return !in_list;
> +}
> +
>  int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned lon=
g ctr_base,
>                                      unsigned long ctr_mask, unsigned lon=
g flags,
>                                      unsigned long eidx, u64 evtdata,
> @@ -773,6 +799,11 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu=
 *vcpu, unsigned long ctr_ba
>                 goto out;
>         }
>
> +       if (!kvm_riscv_pmu_event_allowed(vcpu->kvm, eidx)) {
> +               sbiret =3D SBI_ERR_NOT_SUPPORTED;
> +               goto out;
> +       }
> +
>         /*
>          * SKIP_MATCH flag indicates the caller is aware of the assigned =
counter
>          * for this event. Just do a sanity check if it already marked us=
ed.
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index a9f083feeb76..a5a3a2182d1e 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -53,6 +53,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
>         kvm_destroy_vcpus(kvm);
>
> +       kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->sr=
cu, 1));
> +
>         kvm_riscv_aia_destroy_vm(kvm);
>  }
>
> @@ -187,6 +189,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>         case KVM_CAP_MP_STATE:
>         case KVM_CAP_IMMEDIATE_EXIT:
>         case KVM_CAP_SET_GUEST_DEBUG:
> +       case KVM_CAP_PMU_EVENT_FILTER:
>                 r =3D 1;
>                 break;
>         case KVM_CAP_NR_VCPUS:
> @@ -265,7 +268,71 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct =
kvm_enable_cap *cap)
>         }
>  }
>
> +#define KVM_PMU_EVENT_FILTER_MAX_EVENTS        256
> +
> +static int kvm_riscv_vm_ioctl_set_pmu_event_filter(struct kvm *kvm,
> +                                                  void __user *argp)
> +{
> +       struct kvm_pmu_event_filter __user *user_filter =3D argp;
> +       struct kvm_pmu_event_filter *filter, tmp;
> +       size_t size;
> +       int r =3D 0;
> +
> +       if (copy_from_user(&tmp, user_filter, sizeof(tmp)))
> +               return -EFAULT;
> +
> +       if (tmp.action !=3D KVM_PMU_EVENT_ALLOW &&
> +           tmp.action !=3D KVM_PMU_EVENT_DENY)
> +               return -EINVAL;
> +
> +       if (tmp.flags)
> +               return -EINVAL;
> +
> +       if (tmp.pad)
> +               return -EINVAL;
> +
> +       if (tmp.nevents > KVM_PMU_EVENT_FILTER_MAX_EVENTS)
> +               return -E2BIG;
> +
> +       size =3D struct_size(filter, events, tmp.nevents);
> +       filter =3D kzalloc(size, GFP_KERNEL_ACCOUNT);
> +       if (!filter)
> +               return -ENOMEM;
> +
> +       filter->action =3D tmp.action;
> +       filter->nevents =3D tmp.nevents;
> +       filter->flags =3D tmp.flags;
> +
> +       if (copy_from_user(filter->events, user_filter->events,
> +                          flex_array_size(filter, events, filter->nevent=
s))) {
> +               r =3D -EFAULT;
> +               goto cleanup;
> +       }
> +
> +       mutex_lock(&kvm->lock);
> +       filter =3D rcu_replace_pointer(kvm->arch.pmu_event_filter, filter=
,
> +                                    mutex_is_locked(&kvm->lock));
> +       mutex_unlock(&kvm->lock);
> +       synchronize_srcu_expedited(&kvm->srcu);
> +
> +cleanup:
> +       kfree(filter);
> +       return r;
> +}
> +
>  int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned lo=
ng arg)
>  {
> -       return -EINVAL;
> +       struct kvm *kvm =3D filp->private_data;
> +       void __user *argp =3D (void __user *)arg;
> +       int r;
> +
> +       switch (ioctl) {
> +       case KVM_SET_PMU_EVENT_FILTER:
> +               r =3D kvm_riscv_vm_ioctl_set_pmu_event_filter(kvm, argp);
> +               break;
> +       default:
> +               r =3D -EINVAL;
> +       }
> +
> +       return r;
>  }
> --
> 2.34.1
>

Regards,
Anup
