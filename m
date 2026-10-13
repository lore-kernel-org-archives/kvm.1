Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34545FFA7
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901997; cv=none; b=ruhzQq+sOF3auzHgl4oTyZrnSitPe9iigFLjbABIsVKrHmaUUGnUnHgKUJLaeP7LR8fk5vDG2+N962R7zz8luEwum1HAd3S4z6baEfcKBI7W/3FAUd/Q4z6HtLn412m6Mam0UlJeQTC3nq9hiE+1pusIYD+aXDN0daecd5A3X+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901997; c=relaxed/simple;
	bh=yNua8yZyfzKx9mMiFfakVIbxsbgf7Q5tUSx+K4z679A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=R67/Szq9fAFMBXCJHyDgAWIi0m/noNWUvZOYbZw+jZ0+4MPzdozciBqI0l1XNBLRO0BPj8ul/+pJnUeG9/H06PAxZnItsPxhqdv73rD08nxKSWbpJqbWXtVA0L3ltEm4VuLcyki6IvyvRndh8IyoUPGQRTclNcVNc4TYycpc0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pveBdzoi; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pveBdzoi"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33fb4680717so679013eec.1
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791901995; x=1792506795; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2D70tRlN9hXWyqkkdtTDdIyLlgX6luaffedR+k/mZw4=;
        b=pveBdzoi54w414rTy9xKGgrsNzjwoRTWZT+OltmK6JUPwPnNfsHWtalKsGRbW4FOG8
         xFZZd/UIBXWiTjA/cSXIJkPsq4NlTpMRXwPwUUWNwDlCZ0dS3vcaN2UqaVu/yK5VOwAq
         VT7o2H2OyjbYYCMJo00aXd6JdTwJmqheCiMG13orSqvKdNiZMUDuHK8sv8EpqO4PqyE3
         x2t3Uw75FhqSV1pLy+oDg24zw6y4A+WX8CepBzGZjOo6Qi5f/DaGn5bHeKQNmRtfJmuM
         wcixDgdR6SiqcxvNfbrRDHvOzXaYHelS4HxSEn39/U6/w72Qm6XMDgynXr5+QqVh95uz
         U+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901995; x=1792506795;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2D70tRlN9hXWyqkkdtTDdIyLlgX6luaffedR+k/mZw4=;
        b=MFPcq5kA/Y5zNMciSDfJL3AUtIBUOqu9ZZWZRp1VSPgUaou2tJNgqKaCm8PfX2eCoU
         2iqG0e31957SvRXJ5RpzFcFvJRRgwbf4+5yL6qzGBuoEecTvop71xTOoDzLnqK+0iDxI
         WrjQ8jeEPRCY2d8PjMyesHh/qmejMf/C/PT4P14uf18qCZ9MrFb5bu6XDhRhMBoX72aw
         PrCyHGprosE3QnoMASNXPZXSKoG1nQbETge2yJsvN5gvqlOYfkJaz4wQAE84qjcTYb5A
         j/DlwWyy5EMkiEo503y78rupmhZikK/dmk2XR3tXfpF4Co2I36rBc7NfSZUOrC+COMbl
         IXkA==
X-Forwarded-Encrypted: i=1; AKwUvByfSOyhH+D81tqZOeFEXcv+1rSOjaStrM9ErYbXEbU9eONrGFuyXdaCVID2kYhdXsBUt0U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRgE6hFi8XlWeCn0mCnYedZKDBF57w11Pqk2flHDnID4Cv6wbW
	n3k4snQNWMr01YMh+zd9gIdpSRl+pnvQBVmghCNCa6qouV42aGU0b6EaYJ3vH91O
X-Gm-Gg: AYBFou1ED6a2BMI3diTY8MFSOtYzlp/vnrFFGeA/ZKvV2rgrxh2H/339kxT3XR/qkS4
	KY5jyRgW0/8CsPN8cy+ld2pSwqWkU7LlX37/f58o5sXIVt8uIWDo/aed8sxivKek2fbzVOAe7ZZ
	sImjYxZTIXdVaaF5fk2weqlLfVEPaB/u8uqQoHcsGMLCp7sAp5kXjAmNVOETfGKwAKan/hJFaSh
	bfIm7VyKeqPCBZA/RFR6jZqaq8VlOBqAiCMGn1szAeJOvqcRHOiofNBLBt4eiYPFafgJxQ2HGaF
	6VwAA09T9qQhKE8h6m7/6lsVMWn2s4dDCn0WqKterfjdo8iVKyW+ZsWjdtLD9Z5xe67GNrGdYM1
	Yb0lczM9wZdAcS7ILq+7avS8jSQIH6I8N+HQjEYKjXbbisH+RXq9UykuTgzhKVom4dJMUQgJNtG
	PgiESR4gnwTuPraIAk2ACfNBKus59wYHjdbQj2W98nVE1P+sMIpCz+4jkcxXS4x4e0n0kuFIF1q
	f8X3V/0
X-Received: by 2002:a05:693c:821a:b0:35c:813a:1c81 with SMTP id 5a478bee46e88-35c813a23b6mr2871023eec.18.1791901995288;
        Tue, 13 Oct 2026 07:33:15 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d20dsm47942824eec.12.2026.10.13.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:33:13 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] KVM: PPC: Book3S HV: Take SRCU read lock around kvmppc_h_page_init() call
In-Reply-To: <20261012082922.218799-5-gautam@linux.ibm.com>
Date: Tue, 13 Oct 2026 20:01:51 +0530
Message-ID: <y0c1r7s8.ritesh.list@gmail.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com> <20261012082922.218799-5-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Gautam Menghani <gautam@linux.ibm.com> writes:

> Since there is no srcu read lock around kvmppc_h_page_init(), a
> "suspicious rcu_dereference_check() usage" can be triggered by running
> host linux with CONFIG_PROVE_RCU=y and the following code in the guest:
>
> plpar_hcall_norets(H_PAGE_INIT, H_ZERO_PAGE, phys_addr, 0);
>
>  =============================
>  WARNING: suspicious RCU usage
>  7.0.0-dirty #227 Not tainted
>  -----------------------------
> ./include/linux/kvm_host.h:1074 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by qemu-system-ppc/2093:
>  #0: c000000354197ab0 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x10c/0xaf0
>
> stack backtrace:
> CPU: 30 UID: 0 PID: 2093 Comm: qemu-system-ppc Not tainted 7.0.0-dirty #227 PREEMPT(full)
> Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.60 (NH1060_158) hv:phyp pSeries
> Call Trace:
> [c00000033e1bf430] [c000000001b3dbd4] dump_stack_lvl+0xc8/0x130 (unreliable)
> [c00000033e1bf470] [c0000000003da964] lockdep_rcu_suspicious+0x1f4/0x290
> [c00000033e1bf520] [c000000000231424] gfn_to_memslot+0x1b4/0x1c0
> [c00000033e1bf560] [c00000000023637c] kvm_clear_guest+0x9c/0x110
> [c00000033e1bf5c0] [c0000000002714a4] kvmppc_h_page_init+0x160/0x1a0
> [c00000033e1bf610] [c00000000026c040] kvmppc_pseries_do_hcall+0x1930/0x1940
> [c00000033e1bf6d0] [c00000000026fb18] kvmppc_vcpu_run_hv+0x268/0x800
> [c00000033e1bf7a0] [c000000000246b30] kvmppc_vcpu_run+0x30/0x50
> [c00000033e1bf7c0] [c000000000241ed4] kvm_arch_vcpu_ioctl_run+0x364/0x530
> [c00000033e1bf860] [c00000000022b870] kvm_vcpu_ioctl+0x1b0/0xaf0
> [c00000033e1bfa50] [c0000000009b4514] sys_ioctl+0x144/0x190
> [c00000033e1bfab0] [c000000000034330] system_call_exception+0x170/0x370
> [c00000033e1bfe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
>
> Fix this by taking a srcu read lock around kvmppc_h_page_init().

Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

