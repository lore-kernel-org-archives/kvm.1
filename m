Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA1139D
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742848; cv=none; b=CbbPdV1oEGHxjFS4V5A63zF/tpryfRxE/DqxJwFRmn+tMzhAWSe8uwihTAiAhPL2OCHzlVXILyIw3a0GpzWawsQ1j8RxNjSjffoler99JGwHst/ad2OR9NdcWXmgIfONj+LPdWit7CQgas5LgufHMFD9qQoJYsN6QbNCXQcaRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742848; c=relaxed/simple;
	bh=t9GAqyFmZVxKjxhA0thWU8YQM1b3keTE12rd7boA2NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDSAu/oVMhPsnCwwiYcOnH8w0zdrtY87/8i139+9TOgyNRb4+EzjXa+tlQjBLqzw1KzELZeXyG4N6pfbpkWpdxFrM7RAyK9sWzla2y9tpzzwl3hI19ntlGsVaWQUnRUQleP0JpFwl/jhApZStlDQVV4ElZ22a39jsnY1hyugJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bae9+jnI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bae9+jnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8520C2BCAF;
	Tue, 17 Mar 2026 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773742848;
	bh=t9GAqyFmZVxKjxhA0thWU8YQM1b3keTE12rd7boA2NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bae9+jnIBe3lwvTJiJG3sW/8NUEXx36+y+M9834rO6YU4b1lgUfUNtB6dNTQvj4eQ
	 2ff3okn79AT2jueiWaqzV25Iw/BgL5ECBJsy8H64xwF3HnkWUjHuz+rQ+QWOjMx0B0
	 BRHNDxjBE94EpQNeDNzMunJlJWrDXgyPIZ9JWopsJxwcmWXYQE3teHDOAF1/n423mD
	 99bVlQFvBPrmsuuTIJhyflLzckI+08J0D1uLorlCOLAciQkIaObREOhl/gRK9ctubt
	 8IO9DYKW05NHnuu0YjY65cz3ZtBntLYMRkOPGT62zX+OZQfp7HJB0qmZOEwUpnPxwl
	 UKqEfu9JWzliA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id CF035F40068;
	Tue, 17 Mar 2026 06:20:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 17 Mar 2026 06:20:46 -0400
X-ME-Sender: <xms:_iq5aYRvubzczvb8Ilc98PZ4VHwMGX-WQBzF37KXxiETIQWVyNL9Bw>
    <xme:_iq5aWd6zGlan-oUY18ijIbuPA-WdbV6U8dcKQYKuQpcXREgJl9xdKtoO6-SY044Q
    0kuWnSe6dDT_qeeGi7bI035iX7L35amg7xi2I7OsPPFI3nSP-gF-wg>
X-ME-Received: <xmr:_iq5aaV5zU3MLDRrcYuQb4Cza3aneaFInMzXUE6F-xBH4z0DA5ivZPhpF5jplQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdgtohgtoheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehkvhhmsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghinhgsihhnrdifuheslhhinhhu
    gidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesih
    hnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhi
    nhhtvghlrdgtohhmpdhrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomh
    dprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:_iq5aciSNQgMCRe5CiQP1kodnjJHxwMFpbgt55u2ZscVVgLgVMXTSA>
    <xmx:_iq5aYE6VGgbgbV7t3XvBs6LJkFNSyfFN3ZflzT38jXtLUvJ1Jh0xw>
    <xmx:_iq5aSLzdNj1GfJi_1Wj-zBZoFqHcUIZ6B4fXzHISMehiJLgm5DT9g>
    <xmx:_iq5aQtS3IFuq41twUfJNg-aiH7mIawC_zqxn6k50IRS3xYmHinxAw>
    <xmx:_iq5af78Mdrjs7TcYGSC1Uap_0f_4qO3hEiAaG7ro5roQFxPQubkGIVf>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 06:20:44 -0400 (EDT)
Date: Tue, 17 Mar 2026 10:20:38 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Message-ID: <abko0v2bYxNJtegT@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-8-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-8-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:27AM -0700, Chao Gao wrote:
> Linux kernel supports two primary firmware update mechanisms:
>   - request_firmware()
>   - firmware upload (or fw_upload)
> 
> The former is used by microcode updates, SEV firmware updates, etc. The
> latter is used by CXL and FPGA firmware updates.
> 
> One key difference between them is: request_firmware() loads a named
> file from the filesystem where the filename is kernel-controlled, while
> fw_upload accepts firmware data directly from userspace.
> 
> Use fw_upload for TDX module updates as loading a named file isn't
> suitable for TDX (see below for more reasons). Specifically, register
> TDX faux device with fw_upload framework to expose sysfs interfaces
> and implement operations to process data blobs supplied by userspace.
> 
> Implementation notes:
> 1. P-SEAMLDR processes the entire update at once rather than
>    chunk-by-chunk, so .write() is called only once per update; so the
>    offset should be always 0.
> 2. An update completes synchronously within .write(), meaning
>    .poll_complete() is only called after the update succeeds and so always
>    returns success
> 
> Why fw_upload instead of request_firmware()?
> ============================================
> The explicit file selection capabilities of fw_upload is preferred over
> the implicit file selection of request_firmware() for the following
> reasons:
> 
> a. Intel distributes all versions of the TDX module, allowing admins to
> load any version rather than always defaulting to the latest. This
> flexibility is necessary because future extensions may require reverting to
> a previous version to clear fatal errors.
> 
> b. Some module version series are platform-specific. For example, the 1.5.x
> series is for certain platform generations, while the 2.0.x series is
> intended for others.
> 
> c. The update policy for TDX module updates is non-linear at times. The
> latest TDX module may not be compatible. For example, TDX module 1.5.x
> may be updated to 1.5.y but not to 1.5.y+1. This policy is documented
> separately in a file released along with each TDX module release.
> 
> So, the default policy of "request_firmware()" of "always load latest", is
> not suitable for TDX. Userspace needs to deploy a more sophisticated policy
> check (e.g., latest may not be compatible), and there is potential
> operator choice to consider.
> 
> Just have userspace pick rather than add kernel mechanism to change the
> default policy of request_firmware().
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

One minor thing below.

> ---
> v5:
>  - remove a tail comment [Yan]
>  - remove is_vmalloc_addr() check [Dave]
>  - use devm_add_action_or_reset() for deinit [Yilun]
>  - remove global tdx_fwl [Yilun]
>  - clarify request_firmware() doesn't take filename from userspace
>    [Rick]
> 
> v4:
>  - make tdx_fwl static [Kai]
>  - don't support update canceling [Yilun]
>  - explain why seamldr_init() doesn't return an error [Kai]
>  - bail out if TDX module updates are not supported [Kai]
>  - name the firmware "tdx_module" instead of "seamldr_upload" [Cedric]
> 
> v3:
>  - clear "cancel_request" in the "prepare" phase [Binbin]
>  - Don't fail the whole tdx-host device if seamldr_init() met an error
>  [Yilun]
>  - Add kdoc for seamldr_install_module() and verify that the input
>    buffer is vmalloc'd. [Yilun]
> ---
>  arch/x86/include/asm/seamldr.h        |  1 +
>  arch/x86/include/asm/tdx.h            |  6 ++
>  arch/x86/virt/vmx/tdx/seamldr.c       | 15 +++++
>  drivers/virt/coco/tdx-host/Kconfig    |  2 +
>  drivers/virt/coco/tdx-host/tdx-host.c | 87 +++++++++++++++++++++++++++
>  5 files changed, 111 insertions(+)
> 
> diff --git a/arch/x86/include/asm/seamldr.h b/arch/x86/include/asm/seamldr.h
> index c67e5bc910a9..ac6f80f7208b 100644
> --- a/arch/x86/include/asm/seamldr.h
> +++ b/arch/x86/include/asm/seamldr.h
> @@ -32,5 +32,6 @@ struct seamldr_info {
>  static_assert(sizeof(struct seamldr_info) == 256);
>  
>  int seamldr_get_info(struct seamldr_info *seamldr_info);
> +int seamldr_install_module(const u8 *data, u32 size);
>  
>  #endif /* _ASM_X86_SEAMLDR_H */
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index cb2219302dfc..b3a7301e77c6 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -103,6 +103,12 @@ int tdx_enable(void);
>  const char *tdx_dump_mce_info(struct mce *m);
>  const struct tdx_sys_info *tdx_get_sysinfo(void);
>  
> +static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
> +{
> +	 /* To be enabled when kernel is ready. */
> +	return false;
> +}
> +
>  int tdx_guest_keyid_alloc(void);
>  u32 tdx_get_nr_guest_keyids(void);
>  void tdx_guest_keyid_free(unsigned int keyid);
> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
> index 7c0cbab2c4c0..7114326d7569 100644
> --- a/arch/x86/virt/vmx/tdx/seamldr.c
> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
> @@ -6,6 +6,7 @@
>   */
>  #define pr_fmt(fmt)	"seamldr: " fmt
>  
> +#include <linux/mm.h>
>  #include <linux/spinlock.h>
>  
>  #include <asm/seamldr.h>
> @@ -39,3 +40,17 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
>  	return seamldr_call(P_SEAMLDR_INFO, &args);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
> +
> +/**
> + * seamldr_install_module - Install a new TDX module.
> + * @data: Pointer to the TDX module update blob.
> + * @size: Size of the TDX module update blob.
> + *
> + * Returns 0 on success, negative error code on failure.
> + */
> +int seamldr_install_module(const u8 *data, u32 size)
> +{
> +	/* TODO: Update TDX module here */
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");
> diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
> index d35d85ef91c0..ca600a39d97b 100644
> --- a/drivers/virt/coco/tdx-host/Kconfig
> +++ b/drivers/virt/coco/tdx-host/Kconfig
> @@ -1,6 +1,8 @@
>  config TDX_HOST_SERVICES
>  	tristate "TDX Host Services Driver"
>  	depends on INTEL_TDX_HOST
> +	select FW_LOADER
> +	select FW_UPLOAD
>  	default m
>  	help
>  	  Enable access to TDX host services like module update and
> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> index 8d46e3c039ba..1b93d20406c1 100644
> --- a/drivers/virt/coco/tdx-host/tdx-host.c
> +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/device/faux.h>
> +#include <linux/firmware.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/sysfs.h>
> @@ -94,8 +95,94 @@ static const struct attribute_group seamldr_group = {
>  	.attrs = seamldr_attrs,
>  };
>  
> +static enum fw_upload_err tdx_fw_prepare(struct fw_upload *fwl,
> +					 const u8 *data, u32 size)
> +{
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
> +				       u32 offset, u32 size, u32 *written)
> +{
> +	int ret;
> +
> +	/*
> +	 * tdx_fw_write() always processes all data on the first call with
> +	 * offset == 0. Since it never returns partial success (it either
> +	 * succeeds completely or fails), there is no subsequent call with
> +	 * non-zero offsets.
> +	 */
> +	WARN_ON_ONCE(offset);
> +	ret = seamldr_install_module(data, size);
> +	switch (ret) {
> +	case 0:
> +		*written = size;
> +		return FW_UPLOAD_ERR_NONE;
> +	case -EBUSY:
> +		return FW_UPLOAD_ERR_BUSY;
> +	case -EIO:
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +	case -ENOSPC:
> +		return FW_UPLOAD_ERR_WEAROUT;
> +	case -ENOMEM:
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	default:
> +		return FW_UPLOAD_ERR_FW_INVALID;
> +	}
> +}
> +
> +static enum fw_upload_err tdx_fw_poll_complete(struct fw_upload *fwl)
> +{
> +	/*
> +	 * TDX module updates are completed in the previous phase
> +	 * (tdx_fw_write()). If any error occurred, the previous phase
> +	 * would return an error code to abort the update process. In
> +	 * other words, reaching this point means the update succeeded.
> +	 */
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +/*
> + * TDX module updates cannot be cancelled. Provide a stub function since
> + * the firmware upload framework requires a .cancel operation.
> + */
> +static void tdx_fw_cancel(struct fw_upload *fwl)
> +{
> +}
> +
> +static const struct fw_upload_ops tdx_fw_ops = {
> +	.prepare	= tdx_fw_prepare,
> +	.write		= tdx_fw_write,
> +	.poll_complete	= tdx_fw_poll_complete,
> +	.cancel		= tdx_fw_cancel,
> +};
> +
> +static void seamldr_deinit(void *tdx_fwl)
> +{
> +	firmware_upload_unregister(tdx_fwl);
> +}
> +
>  static int seamldr_init(struct device *dev)
>  {
> +	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
> +	struct fw_upload *tdx_fwl;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!tdx_sysinfo))
> +		return -EIO;
> +
> +	if (!tdx_supports_runtime_update(tdx_sysinfo))
> +		return 0;

Hm. Do we still want to register seamldr_group for this case?

Maybe move it up before the check?

> +
> +	tdx_fwl = firmware_upload_register(THIS_MODULE, dev, "tdx_module",
> +					   &tdx_fw_ops, NULL);
> +	if (IS_ERR(tdx_fwl))
> +		return PTR_ERR(tdx_fwl);
> +
> +	ret = devm_add_action_or_reset(dev, seamldr_deinit, tdx_fwl);
> +	if (ret)
> +		return ret;
> +
>  	return devm_device_add_group(dev, &seamldr_group);
>  }
>  
> -- 
> 2.47.3
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
