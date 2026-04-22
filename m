Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53EB3E9F8B
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863679; cv=none; b=rm1ihfJ6ssf9rnftew2Ex3XMvYjCfvVWVbnVqUAGDqRhppUvEUGyYqWGEnDVYm8TN9gEwfUvTt5vZNWn3S7FwoapNVco5Widn63YYgpJwnsqHVGrUnI/XUYcyyI7UPELg6fuAzTT8VnDqNaHXJxiCuGucK/GN+SwAACqx94VrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863679; c=relaxed/simple;
	bh=DXWtlVkPOzmiBYtDp9HYbIc/G0f51h19oHhBbaJOPr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mp/xBJLj6L0G+Oc5fV3u1YGHAqTFqzVs9jn2zA9TeUdsrQDG9IV5TyvFInbodR4KHgjYJeaoVpEYVx+fXOW5Dvd2ZXfNJHbowFFMY7bSFTjBpYnbeMXI3n1tYmCalFxq0J8+5yC5l4ljyzHvjHMde50TCcmZrsLhLOy5rqkzga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLi7Vj+w; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLi7Vj+w"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso2978093b3a.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776863676; x=1777468476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdptR/OyRs4SIYm8Am4tpwhSMykd7DPRgYTUDop6DiQ=;
        b=KLi7Vj+wXLPyuzcGWap5PaoR3bQFSip6Im8Jxmz20x3Qp02kfLLC/FTUNVJ0wdMpUy
         zhcmMZrupzVxUELmlvcwHOBiUMmSpy9uUCfoMU97Fpi1Bod8imUs+BJYauvF3ntMYyGf
         jM2rj/n6Mx8Dl3lDci3E5NuugFV3e354E065+N1YdiXnoZKMNANYvtLevzInwKQQwj8+
         EG2spS3rA8BR4EncTzG2DXgAoYXSFo3HLTpeBZHIsNnxMws8BGIkJ6HXQBDGZYdQhDQO
         EbwDrFIMBIu5tArCTlApH8rkJypVypFEa+o9t56LACgxNOxo665nM4TLqOzON8/ikp9R
         ejWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863676; x=1777468476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdptR/OyRs4SIYm8Am4tpwhSMykd7DPRgYTUDop6DiQ=;
        b=rbU7136EHxkQ+qpt8H0HBz82oGxmzKwgheoHx/rlL039sx4ngR4mnnycqrhcQU0CbB
         n/o9GVI6GdfBDb/fE9um0oDrbY6kP10tSud/ltvcqJ13Zhakbyav3PV0ipVTOUQIGLOi
         KYDwBu/bk065zFz+pAiz7JgumAr/CZODLMTipydmqDojzfbvSGk4wViYQhawDCxLr3CE
         qPsoHzahMz0jbfOf/D9rnWNBfN9u5Qr6FfsF1ODlOj7mOalcQlkxatpx5bkc82RPNXIs
         V4ha+gk9WxsWUM9Wmf0tY15MnRnyvinvC+6wfiwXyiEWN+tHAW8dt3ccg69JCxdTVEnL
         f4+Q==
X-Gm-Message-State: AOJu0YyAtqQJEPqVcJ0RWnCDGRGaH6vmRmpQulpp4JVEPCJIw2Z1sNiS
	Mc8IPvG3SnGxA2ywyZhqs80ugL93GJZ1DEM8Uu/KzvjTkFCbK1krE/rNDc+QlZwBPACgaygc+7b
	PWwbOSQ==
X-Received: from pfkm9.prod.google.com ([2002:a05:6a00:809:b0:82f:7220:86e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e23:b0:829:88e7:c88b
 with SMTP id d2e1a72fcca58-82f8c869b8emr24120276b3a.19.1776863675752; Wed, 22
 Apr 2026 06:14:35 -0700 (PDT)
Date: Wed, 22 Apr 2026 06:14:34 -0700
In-Reply-To: <20260422124536.53756-1-robert.nowicki@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com> <20260422124536.53756-1-robert.nowicki@intel.com>
Message-ID: <aejJup_I4wM0Rb93@google.com>
Subject: Re: [PATCH] x86/tdx, KVM: fix HKID leak when kexec is initiated with
 active TDs
From: Sean Christopherson <seanjc@google.com>
To: Robert Nowicki <robert.nowicki@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vishal.l.verma@intel.com, pbonzini@redhat.com, Igor.Swierszcz@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 22, 2026, Robert Nowicki wrote:
> When kexec is initiated while TDs are running, vCPU threads can be
> mid-TDH.VP.ENTER on other CPUs when tdx_shutdown() fires. The TDX
> module rejects TDH.MNG.VPFLUSHDONE for a VP in RUNNING state, leaving
> the HKID in a leaked state:
> 
>   kvm_intel: tdh_mng_vpflushdone() failed. HKID 33 is leaked.
> 
> Fix this by introducing a quiescing flag set at the start of
> tdx_shutdown(). KVM's tdx_vcpu_run() checks the flag and returns
> EXIT_FASTPATH_NONE before attempting TDH.VP.ENTER. After setting the
> flag, tdx_shutdown() calls on_each_cpu(tdx_seam_sync) with wait=1 to
> ensure any CPU currently inside TDH.VP.ENTER has exited SEAM before
> tdx_sys_disable() is called.
> 
> Fixes: 58171ae22e11 ("x86/tdx: Disable the TDX module during kexec and kdump")

Please don't post seemingly standalone patches for code that hasn't yet been
merged, it's quite confusing.

>  u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
>  u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
> @@ -206,6 +207,7 @@ static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
>  static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
>  static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
>  static inline void tdx_sys_disable(void) { }
> +static inline bool tdx_kexec_quiescing(void) { return false; }
>  #endif	/* CONFIG_INTEL_TDX_HOST */
>  
>  #endif /* !__ASSEMBLER__ */
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 50a5cfdbd33e..2d658db7700d 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1053,6 +1053,9 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>  	struct vcpu_tdx *tdx = to_tdx(vcpu);
>  	struct vcpu_vt *vt = to_vt(vcpu);
>  
> +	if (unlikely(tdx_kexec_quiescing()))

Requiring KVM to check a global on every entry is pretty ugly, especially since
this is for a very rare scenario (in terms of number of entries).  And forcing
KVM to do a CALL+RET to check an almost-never-set flag is especially ugly.

Why not handle this entirely in tdx_shutdown_cpu()?  E.g. have the last CPU through
disable TDX, and hld all the CPUs hostage until that's done.  It's not the prettiest
thing in the world, but it's entirely self-contained.

static void tdx_shutdown_cpu(void *__nr_cpus_remaining)
{
	atomic_t *nr_cpus_remaining = __nr_cpus_remaining;

	if (!atomic_add_unless(nr_cpus_remaining, -1, 1)) {
		tdx_sys_disable();
		atomic_set(nr_cpus_remaining, 0);
	}

	x86_virt_put_ref(X86_FEATURE_VMX);

	while (!atomic_read(nr_cpus_remaining))
		cpu_relax();
}

static void tdx_shutdown(void *ign)
{
	atomic_t nr_cpus_remaining = ATOMIC_INIT(num_online_cpus());

	on_each_cpu(tdx_shutdown_cpu, &nr_cpus_remaining, 1);
}
