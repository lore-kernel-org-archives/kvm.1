Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06DF3A453A;
	Tue, 17 Mar 2026 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742011; cv=none; b=Y6LSIOQmlNsMo+n2f3AQjWOQn95PyoMRdVqj7gsPTfUaedngSQ6iQRMXWqDiIWjDnsOWYGBcURiW7kPaU3/kJUQI1BJ0S0tfRpzvh9iWqSxGPlWGGgrDpD+XZcNnaa3yIWPcqu0sLwUdRn/UhBcXTV1oqmvZJwotNqxVyhvMzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742011; c=relaxed/simple;
	bh=IlINIddJqqAYz/BpDaCRSgtZsXvYH0mQoSyOjSILCqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siBFpa79oGtcNPHs3TghEgb6U8UyUc3BMWkGkTflqsn8sTAtM/O6nYWz9A1q3zNHnXYzmtFZ9Fbq9nMCkhMLlXlme7cPEw/eMw/wy77D4I9ea8p09ogPfFp2Ohr/IebNb7NvypIiHJVtAJ5QEN5A2uN6pID4vPWyy5s+PurRFtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VegtYA//; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VegtYA//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1CFC4AF0B;
	Tue, 17 Mar 2026 10:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773742010;
	bh=IlINIddJqqAYz/BpDaCRSgtZsXvYH0mQoSyOjSILCqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VegtYA//K8wItJHG9rBdcfjRtDYJS346JKuCK4jov61h6mjo0w1wdUUi1K9Q0dsBz
	 Mg3eAJoRH52m7ea6adu5zRGGU8Uuq55HvV9Wh86aJ8FSVeJxVmEAGpisW/+3IpbPsT
	 m4627eOQ0JUCE9Zyo92YihcFi9sDEzfgp+PRE5C3ZD8f/G68Va7JPe/pqqPPklMmvT
	 eXyPbkz19WNmFM2xR/Lsf6oWZ91XWn4WftFG6Xb7mQfzy6h0qqyoLljCBszHYerBBw
	 O1rULlA1lQD6bkZF2PYkq+RZLF5rgUoPXzlslUdiIk+5JbSj0t5TO5OQ6LJLZv6sh6
	 LMjT9hHAll6sw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2E060F40086;
	Tue, 17 Mar 2026 06:06:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 17 Mar 2026 06:06:49 -0400
X-ME-Sender: <xms:uSe5aUzgzIJSOyhbo8revzt3GtqHjrzwBM_YfcxV6QmbvfOSUCs2tw>
    <xme:uSe5aW68f-EZQGETjcWpTzlK7iMY9BTELWE3-Deo682nsyHDKKtQYLcCo5aNo764F
    cEP9HFaKx2HsQQjHyEVpqVcpGj_UDQ6b-VDG0RzvKGE9eNZnWX3mwE>
X-ME-Received: <xmr:uSe5aV-e0CQpP7GQD57QLdd6CU2thr8E87etyBq1XTwl_iQInZxIajCh-n1FFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeludettdeigfefhffhhfelveeludeuleduvefhgefgueeitedtleffudegfffg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopeegvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheptghhrghordhgrghosehinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhl
    ihhnuhigrdguvghvpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsihhnsghinhdrfihusehlihhnuhigrdhinhhtvghlrdgtohhmpd
    hrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghp
    thhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtph
    htthhopehirhgrrdifvghinhihsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:uSe5aYspOv2banA3odjQ14XSGUOYqpmhY8pe3840b5pQMdXMQhXB2w>
    <xmx:uSe5abQp4RgWg5WIDZayX1CUONaBjNvZWltVYhxXhvkoqejAzEo5xQ>
    <xmx:uSe5aV2PuJIYfrP6ynis-e5joeshZuN3gQHFXgo_tufa8_xxgBY-Tg>
    <xmx:uSe5aTyvvwsJW1YNimVT6aLMA5FrmAJjIC2sBb0C4yMPE87uQGfVqw>
    <xmx:uSe5aYGUCy7ygr977ExusyNkZ2vyFXg21FqjL6con8FIHaiMtllLhC-z>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 06:06:47 -0400 (EDT)
Date: Tue, 17 Mar 2026 10:06:40 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com
Subject: Re: [PATCH v5 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Message-ID: <abkmceqUtMTnLI0V@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-7-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315135920.354657-7-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:26AM -0700, Chao Gao wrote:
> TDX module updates require userspace to select the appropriate module
> to load. Expose necessary information to facilitate this decision. Two
> values are needed:
> 
> - P-SEAMLDR version: for compatibility checks between TDX module and
> 		     P-SEAMLDR
> - num_remaining_updates: indicates how many updates can be performed
> 
> Expose them as tdx-host device attributes. Register these attributes
> during device probe rather than creation, making it easier to hide them
> when P-SEAMLDR calls are unsafe (due to CPU erratum).
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Few nitpicks below.

> ---
> v5:
>  - fix typos [Binbin]
>  - register seamldr_group during device probe
> v4:
>  - Make seamldr attribute permission "0400" [Dave]
>  - Don't include implementation details in OS ABI docs [Dave]
>  - Tag tdx_host_group as static [Kai]
> 
> v3:
>  - use #ifdef rather than .is_visible() to control P-SEAMLDR sysfs
>    visibility [Yilun]
> ---
>  .../ABI/testing/sysfs-devices-faux-tdx-host   | 23 +++++++
>  drivers/virt/coco/tdx-host/tdx-host.c         | 68 ++++++++++++++++++-
>  2 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
> index 2cf682b65acf..44b8356aed6b 100644
> --- a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
> +++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
> @@ -4,3 +4,26 @@ Description:	(RO) Report the version of the loaded TDX module. The TDX module
>  		version is formatted as x.y.z, where "x" is the major version,
>  		"y" is the minor version and "z" is the update version. Versions
>  		are used for bug reporting, TDX module updates etc.
> +
> +What:		/sys/devices/faux/tdx_host/seamldr/version
> +Contact:	linux-coco@lists.linux.dev
> +Description:	(RO) Report the version of the loaded SEAM loader. The SEAM
> +		loader version is formatted as x.y.z, where "x" is the major
> +		version, "y" is the minor version and "z" is the update version.
> +		Versions are used for bug reporting and compatibility checks.
> +
> +What:		/sys/devices/faux/tdx_host/seamldr/num_remaining_updates
> +Contact:	linux-coco@lists.linux.dev
> +Description:	(RO) Report the number of remaining updates. TDX maintains a
> +		log about each TDX module that has been loaded. This log has
> +		a finite size, which limits the number of TDX module updates
> +		that can be performed.
> +
> +		After each successful update, the number reduces by one. Once it
> +		reaches zero, further updates will fail until next reboot. The
> +		number is always zero if the P-SEAMLDR doesn't support updates.
> +
> +		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
> +		Interface Specification, Revision 343755-003, Chapter 3.3
> +		"SEAMLDR_INFO" and Chapter 4.2 "SEAMLDR.INSTALL" for more
> +		information.

Do you think revision and chapter numbers useful here?

> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> index 0424933b2560..8d46e3c039ba 100644
> --- a/drivers/virt/coco/tdx-host/tdx-host.c
> +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> @@ -11,6 +11,7 @@
>  #include <linux/sysfs.h>
>  
>  #include <asm/cpu_device_id.h>
> +#include <asm/seamldr.h>
>  #include <asm/tdx.h>
>  
>  static const struct x86_cpu_id tdx_host_ids[] = {
> @@ -42,6 +43,71 @@ static struct attribute *tdx_host_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(tdx_host);
>  
> +static ssize_t seamldr_version_show(struct device *dev, struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct seamldr_info info;
> +	int ret;
> +
> +	ret = seamldr_get_info(&info);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u.%u.%02u\n", info.major_version,
> +					       info.minor_version,
> +					       info.update_version);

Maybe a comment why %02u used for update_version?

> +}
> +
> +static ssize_t num_remaining_updates_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct seamldr_info info;
> +	int ret;
> +
> +	ret = seamldr_get_info(&info);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", info.num_remaining_updates);
> +}
> +
> +/*
> + * Open-code DEVICE_ATTR_ADMIN_RO to specify a different 'show' function
> + * for P-SEAMLDR version as version_show() is used for TDX module version.
> + *
> + * Admin-only readable as reading these attributes calls into P-SEAMLDR,
> + * which may have potential performance and system impact.
> + */
> +static struct device_attribute dev_attr_seamldr_version =
> +	__ATTR(version, 0400, seamldr_version_show, NULL);
> +static DEVICE_ATTR_ADMIN_RO(num_remaining_updates);
> +
> +static struct attribute *seamldr_attrs[] = {
> +	&dev_attr_seamldr_version.attr,
> +	&dev_attr_num_remaining_updates.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group seamldr_group = {
> +	.name = "seamldr",
> +	.attrs = seamldr_attrs,
> +};
> +
> +static int seamldr_init(struct device *dev)
> +{
> +	return devm_device_add_group(dev, &seamldr_group);
> +}
> +
> +static int tdx_host_probe(struct faux_device *fdev)
> +{
> +	return seamldr_init(&fdev->dev);
> +}
> +
> +static const struct faux_device_ops tdx_host_ops = {
> +	.probe		= tdx_host_probe,
> +};
> +
>  static struct faux_device *fdev;
>  
>  static int __init tdx_host_init(void)
> @@ -49,7 +115,7 @@ static int __init tdx_host_init(void)
>  	if (!x86_match_cpu(tdx_host_ids) || !tdx_get_sysinfo())
>  		return -ENODEV;
>  
> -	fdev = faux_device_create_with_groups(KBUILD_MODNAME, NULL, NULL, tdx_host_groups);
> +	fdev = faux_device_create_with_groups(KBUILD_MODNAME, NULL, &tdx_host_ops, tdx_host_groups);
>  	if (!fdev)
>  		return -ENODEV;
>  
> -- 
> 2.47.3
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
