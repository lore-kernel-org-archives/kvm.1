Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2838239F
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984947; cv=none; b=r+e65Hjxo2Y1K4SK27txwhhkS0EKEd/o1YStC+Mb0aButF97aza1H7H6H3plbvRp84iI+cpxal/xjsEB8YhomEvZ+88/qOt56227Kn4XEoUfuQDuX1CcR+6sGp18jsD2+gapDtKjCG9BQxl4WtSQ5JTUu3Dul1QZ2IvJWubd11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984947; c=relaxed/simple;
	bh=MV24UBx1iZwlGLgfkmZNjBK9za5HvihxdoLsYgrQNdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c/RHU0psGR/POFsmH2BUtvcej3Ma7EQHiHfAhazvJlAG2ym1TIdjY55M8F+1mPcroQpmLB/8fiQtXa8hD9uGTrgBGhPLaCPp06wefWcuj+rB6gYL3Cad6xFszebv5uUKhrkGTvRcAsDWvZ4gWH1hWFj3V7c7NXMHXnI4AFmvbOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuRZAutX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuRZAutX"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c69a734a4so4645609b3a.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774984945; x=1775589745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RgviwJOYXSKWdLh3uc7LH1qbSAomaRwT7h2reEIozb0=;
        b=WuRZAutXb5SA7vjnhXxQXjzu5qcgrSvx93fdayyhxK68BlAvjFfOdxBQ6RfuU6kojT
         zni6eHKUt7eRBdkWGyQPyEfxVcD4xcktsS2JF0dJrtHWo949ijU/fAlICrIhRsrea+2I
         5aZ17Fea9dVJLOUX368tdgIiC5fnZhGCRM4DO1KtUha6AxJ+IvvsazeCOr/Ba/1IJH6z
         g1EhkmIY0ITWlPnSBCtwL/K/7zrAUmwxRM0kuyDyFtWOter//00p2Kli+QnXrhuzmJJS
         ak8b2FFBPcvsjoTsqwLEguiXh2Rjjh79FC3zvQZ4TSj51sy5t/TDYeo1+R36EtZNFJdh
         ouIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774984945; x=1775589745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgviwJOYXSKWdLh3uc7LH1qbSAomaRwT7h2reEIozb0=;
        b=dsNLMhreR74D5UwppijzYx3hDJiD0F9gl5fiwfuqu/UeJl3o69fYzjDQulDnBLZuVW
         igs5xDVz/WkidbNVctdtko8qwZiUiaTB7SQT30kl6wJnEND0VSyIOPq0mD/tl0ax+K0p
         J9m4zhL7QH9d9zc0k7kqezoUxV8l4Tvd1KfMQOOAE+CvHiW2T0qjsiEEjF014kanhAGR
         7QDvXfvJJzUL2w2IOaPbvsnuNcRP60Izwdw6Kd7PpFueuX04vc0i6J8aZU5CUXIaZmBf
         Rap2whpCvRB01BROwaSrkCgM+GJb4ATyP+70qMJcRSeozdbWFR2CaS9Dn4WNkjipTdNr
         amrA==
X-Forwarded-Encrypted: i=1; AJvYcCV0CztA7aG7k898bu18jr4fsXlPVqPiNb7NeeIEQQPkqAeifLbuA2FYPZiXgoJJIeOI5PU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94vcSq8sbJ2OdE3baHnNF2H51shGnqXlDYAI1UFfIM6+sJU69
	OpvoxUnhBaCHBq3uvuK8dl3RX5H78ZA7c1bQ3P4Xn6TfqkWZJwl/NkU8PCkM3hj08AgoEygQA/z
	TUiEAbg==
X-Received: from pfx38.prod.google.com ([2002:a05:6a00:a466:b0:829:8aa0:dc3c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e94:b0:81e:b2ba:5b3a
 with SMTP id d2e1a72fcca58-82ce8943f81mr765456b3a.8.1774984944418; Tue, 31
 Mar 2026 12:22:24 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:22:22 -0700
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com> <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com>
Message-ID: <acwe7kKyjfEQ0sIf@google.com>
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Pull kexec cache flush logic into arch/x86
From: Sean Christopherson <seanjc@google.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 23, 2026, Vishal Verma wrote:
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> KVM tries to take care of some required cache flushing earlier in the
> kexec path in order to be kind to some long standing races that can occur
> later in the operation. Until recently, VMXOFF was handled within KVM.
> Since VMX being enabled is required to make a SEAMCALL, it had the best
> per-cpu scoped operation to plug the flushing into. So it is kicked off
> from there.
> 
> This early kexec cache flushing in KVM happens via a syscore shutdown
> callback. Now that VMX enablement control has moved to arch/x86, which has
> grown its own syscore shutdown callback, it no longer make sense for it to
> live in KVM. It fits better with the TDX enablement managing code.
> 
> In addition, future changes will add a SEAMCALL that happens immediately
> before VMXOFF, which means the cache flush in KVM will be too late to
> flush the cache before the last SEAMCALL. So move it to the newly added TDX
> arch/x86 syscore shutdown handler.
> 
> Since tdx_cpu_flush_cache_for_kexec() is no longer needed by KVM, make it
> static and remove the export. Since it is also not part of an operation
> spread across disparate components, remove the redundant comments and
> verbose naming.
> 
> In the existing KVM based code, CPU offline also funnels through
> tdx_cpu_flush_cache_for_kexec(). So the centralization to the arch/x86
> syscore shutdown callback elides this CPU offline time behavior. However,
> WBINVD is already generally done at CPU offline as matter of course. So
> don't bother adding TDX specific logic for this, and rely on the normal
> WBINVD to handle it.
> 
> Acked-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Ingoring the potential fixup needed for the existing bug...

Acked-by: Sean Christopherson <seanjc@google.com>

> ---
>  arch/x86/include/asm/tdx.h  |  6 ------
>  arch/x86/kvm/vmx/tdx.c      | 10 ----------
>  arch/x86/virt/vmx/tdx/tdx.c | 39 ++++++++++++++++++++-------------------
>  3 files changed, 20 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 2917b3451491..7674fc530090 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -205,11 +205,5 @@ static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
>  static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
>  #endif	/* CONFIG_INTEL_TDX_HOST */
>  
> -#ifdef CONFIG_KEXEC_CORE
> -void tdx_cpu_flush_cache_for_kexec(void);
> -#else
> -static inline void tdx_cpu_flush_cache_for_kexec(void) { }
> -#endif
> -
>  #endif /* !__ASSEMBLER__ */
>  #endif /* _ASM_X86_TDX_H */
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b7264b533feb..50a5cfdbd33e 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -440,16 +440,6 @@ void tdx_disable_virtualization_cpu(void)
>  		tdx_flush_vp(&arg);
>  	}
>  	local_irq_restore(flags);
> -
> -	/*
> -	 * Flush cache now if kexec is possible: this is necessary to avoid
> -	 * having dirty private memory cachelines when the new kernel boots,
> -	 * but WBINVD is a relatively expensive operation and doing it during
> -	 * kexec can exacerbate races in native_stop_other_cpus().  Do it
> -	 * now, since this is a safe moment and there is going to be no more
> -	 * TDX activity on this CPU from this point on.
> -	 */
> -	tdx_cpu_flush_cache_for_kexec();
>  }
>  
>  #define TDX_SEAMCALL_RETRIES 10000
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index cb9b3210ab71..0802d0fd18a4 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -224,8 +224,28 @@ static int tdx_offline_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> +static void tdx_cpu_flush_cache(void)
> +{
> +	lockdep_assert_preemption_disabled();
> +
> +	if (!this_cpu_read(cache_state_incoherent))
> +		return;
> +
> +	wbinvd();
> +	this_cpu_write(cache_state_incoherent, false);
> +}
> +
>  static void tdx_shutdown_cpu(void *ign)
>  {
> +	/*
> +	 * Flush cache now if kexec is possible: this is necessary to avoid
> +	 * having dirty private memory cachelines when the new kernel boots,
> +	 * but WBINVD is a relatively expensive operation and doing it during
> +	 * kexec can exacerbate races in native_stop_other_cpus().  Do it
> +	 * now, since this is a safe moment and there is going to be no more
> +	 * TDX activity on this CPU from this point on.
> +	 */
> +	tdx_cpu_flush_cache();
>  	x86_virt_put_ref(X86_FEATURE_VMX);
>  }
>  
> @@ -1920,22 +1940,3 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
>  	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
> -
> -#ifdef CONFIG_KEXEC_CORE
> -void tdx_cpu_flush_cache_for_kexec(void)
> -{
> -	lockdep_assert_preemption_disabled();

Is there a pre-existing bug here that gets propagate to tdx_shutdown_cpu()?  When
called from kvm_offline_cpu(), preemption won't be fully disabled, but per-CPU
access are fine because the task is pinned to the target CPU.

See https://lore.kernel.org/all/aUVx20ZRjOzKgKqy@google.com

> -
> -	if (!this_cpu_read(cache_state_incoherent))
> -		return;
> -
> -	/*
> -	 * Private memory cachelines need to be clean at the time of
> -	 * kexec.  Write them back now, as the caller promises that
> -	 * there should be no more SEAMCALLs on this CPU.
> -	 */
> -	wbinvd();
> -	this_cpu_write(cache_state_incoherent, false);
> -}
> -EXPORT_SYMBOL_FOR_KVM(tdx_cpu_flush_cache_for_kexec);
> -#endif
> 
> -- 
> 2.53.0
> 
