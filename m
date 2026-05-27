Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D323F8890;
	Wed, 27 May 2026 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881468; cv=none; b=B6HxLVJWQaNyp7k2dIhxtVag26mTK3I+iNcrvmO5nHnVZ00EbVmYU8YcUvKUxBpfokD2J/4Ftc3g6RafjHbh6oIPG4t3l/KAd+2wg/a/8Tj7fZ1+YRIDEr8rM6CqK3AvyalfNh/caUM8acWatXXmKAfkOaAZd//3SBbxy1bKdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881468; c=relaxed/simple;
	bh=OKmrucVVcu4QjGN6eFutScR/qQq8MmRZyvdymyGc7B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrt2BvyHUHLe/foUsUaSaKxoSk5hJITR6HuGYRqpB1HbWUMZetOWfMRG7EgwDPX14xhd0cO566g20I0oIJvtn/GgYQADILcH7OdBOj0J8p89JMTg3EpiqYUeaw1Kb2eXsafC/3ir3+JXR1xpYWp7/5FE6OK22WYynEF+j9PWGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdYdsSbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdYdsSbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1191F00A3C;
	Wed, 27 May 2026 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779881448;
	bh=FTXHPOatDDcWGGB6W0Vf7VqJWCXbqsNHTLsHcHwxoZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TdYdsSbp8PdVm0K57BKoAIoiHoH6SL+oGBBkHXu/8aY0h4XyE9a48z745pbByOk5H
	 IO0uCBGWYkOq165M3/K6mX/UUQLo8N7kb3MPdyY34Wg1PLoX3e7BiAmNdpaI7Pknpx
	 oTaQTwAJ1WlqJYYJhHOccp5TVhd9p5pjj32qIsg98HN66mA2PI1qrCgvEWkpSzw5PK
	 hiC02n2+HMzn56NIDajTwHiwidLpm8LDy8C8SSQquOfLPXhj4FxzPUkMUh+a0U18CJ
	 d0fmvL88ZnFMhIks9e3EpSKf3D7pRQOjnHjRErhyCLR9W26NTsJ20ykPhaR8BXrfpK
	 U/cd2YJIDrCYA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 950D5F40068;
	Wed, 27 May 2026 07:30:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 27 May 2026 07:30:46 -0400
X-ME-Sender: <xms:5tUWahzv44j7mhcQ4xVUm5LCC6-UYwlhWMIn_AO2M47LY5pNkBWZ2w>
    <xme:5tUWaoQeoO5Gsc3o5V_kVK7r4ypLUTOvgJ8c-gnFBVoNIFcDK9kNXYIet1DGYJ9VL
    iwcecFnFjBFSwS7RsOeTjwiuHDXvH6eA_boTX912q-213tJyBaSX62H>
X-ME-Received: <xmr:5tUWanrTsyze6ieSFrZHJJE_ilAf2Hvq2oBMfoUrS8bCuMrshKuDGFId5EXsVg>
X-ME-Proxy-Cause: dmFkZTEMOaTiBgT7f78eFlCxJeIsTZjfGfBptcMB3xwyDzhZzg+kTIbIuj8al78fOROUtJ
    WCMkbpeRXNXNCkQL8FgsUOWe5Gmb9y3L+oeKNIOe5m0b7NGf3nL4/SeWMtM5TjThtsIrD3
    +rdObsVs0B0lMIQyJhDdtsucjqkZNUUwQ27UNs4vCpoqTOwLTylMhSY5bQ/FmFL78FWBVU
    JXVHkrcQ2/WmMgHWO1szmWDf7GKqG5hErt+0qlCT+M2xHrkA+CIwanVBz0MQE6FFn6zUfN
    svPCvN6ZrvyJrkkcntBQgGGWvQzpJQV8bVd7p37R5u5ohTfJcaYoJfWgb7yQEUszVH1pWG
    kwZzTcw0lW7fwymtm4YBk4c1tR9oKZBD4wZvKKjFPmLs1WzCKOhroz9HpICGWJBX+cDzZS
    xxiw36JDNKBJnHbbiE/46H7b3d7kyJ+5NgKQf/PcqD1XF2m/AUg/vgEtjRqLsA34Ham5w3
    x5j4PBMYi4WuqsTEmYBonbgDmWVSa+KjqrEgHmq//a2+Q77ogkt3abhScePC1Rk/8hzfUN
    AJ15Stm+OFlSv9A8h8q0AxTamYX+mVuYflyNOh3lNfdA3HvqSi+m/rlOFVtwO58iLVubdz
    lBaSBjYQNOaHwKRosXAnCbMdeT1FHycfXim6FYuS02rEznkt8MJPOIxYU6cA
X-ME-Proxy: <xmx:5tUWaqY9hjeV2x9hRQx3fS4VIgLcvKM1cMGMsToTptZKzgzxyFVVlA>
    <xmx:5tUWappk3ndyXP2__illBmagt1pYh3iOFDUrX7qKOHi5zo_x02JgoQ>
    <xmx:5tUWaum58z2I7GIrsljf8Zf23MqvC4DfuPC8f31nhDVf5Erz44EvTA>
    <xmx:5tUWas-vuD0tWrdIMoWW84sNhRitBzzic_XzfkrA567W5cFkyHZh2Q>
    <xmx:5tUWavBRRbohE5HKMB6K6OVZzDwN375eMNOIoN7LD3FHSt4EopuUfwIa>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 07:30:45 -0400 (EDT)
Date: Wed, 27 May 2026 12:30:44 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, 
	djbw@kernel.org, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v10 21/25] x86/virt/tdx: Refresh TDX module version after
 update
Message-ID: <ahbVT1dD6Fl_DrL_@thinkstation>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-22-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520133909.409394-22-chao.gao@intel.com>

On Wed, May 20, 2026 at 06:38:24AM -0700, Chao Gao wrote:
> The kernel exposes the TDX module version through sysfs so userspace can
> check update compatibility. That information needs to remain accurate
> across runtime updates.
> 
> A runtime update may change the module's update_version, so refresh the
> cached version right after a successful update.
> 
> Drop __ro_after_init from tdx_sysinfo because it is now updated at runtime.

__read_mostly?

> Do not refresh the rest of tdx_sysinfo, even if some values change across
> updates. TDX module updates are backward compatible, so existing
> tdx_sysinfo consumers, such as KVM, can continue to operate without seeing
> the new values.
> 
> Refreshing the full structure would be risky. A tdx_sysinfo consumer may
> initialize its TDX support based on the features originally reported in
> tdx_sysinfo. If a runtime update adds new features and the full structure
> is refreshed, that consumer could observe and use the newly reported
> features without having performed the setup required to use them safely.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> v9:
> - don't print old and new version [Dave]
> - explain why it's OK to hide changes from the tdx_sysinfo users [Dave]
> - update versions in stop_machine context
> - don't mention major/minor versions are idential across updates. That fact is
>   not relevant here.
> ---
>  arch/x86/virt/vmx/tdx/tdx.c                 | 6 +++++-
>  arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index e3f5aa272850..55670365a388 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -67,7 +67,7 @@ static struct tdmr_info_list tdx_tdmr_list;
>  /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
>  static LIST_HEAD(tdx_memlist);
>  
> -static struct tdx_sys_info tdx_sysinfo __ro_after_init;
> +static struct tdx_sys_info tdx_sysinfo;
>  
>  static DEFINE_RAW_SPINLOCK(sysinit_lock);
>  
> @@ -1314,6 +1314,10 @@ int tdx_module_run_update(void)
>  	if (ret)
>  		return ret;
>  
> +	/* Shouldn't fail as the update has succeeded. */
> +	ret = get_tdx_sys_info_version(&tdx_sysinfo.version);
> +	WARN_ON_ONCE(ret);
> +

Warn, but pretend that everything is fine?

>  	tdx_module_state.initialized = true;
>  	return 0;
>  }
> diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> index e793dec688ab..e49c300f23d4 100644
> --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> @@ -7,7 +7,7 @@
>   * Include this file to other C file instead.
>   */
>  
> -static __init int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
> +static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
>  {
>  	int ret = 0;
>  	u64 val;
> -- 
> 2.52.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
