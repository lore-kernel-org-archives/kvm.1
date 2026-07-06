Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546853D6CD9
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365716; cv=pass; b=FSyLJTs3q7OyZX0Vx2sXNSc2qaFEgZA/BLo3lixlzyVLUkIJ6kXvmgEWWBVEYjU8lWaH7nUiXJk1aQKafjk+MQJQ6utKq8695oLjX1qLnh3RQYIMlyW4yDOOR02+O4IfR/or5Z2gHzFbulYBwfUgsYsOcxZV1chtOIgOVJfpULE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365716; c=relaxed/simple;
	bh=OWqGJ2RXJX8lewCAqOdEDrfTZRegAiM0hVxCTzGD9RM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbJVcm630Kh/JyKbvFD+ez9YTz87r8a3ueIDGTqb+rlq+zQg0wWIl2o9hzwi96lM3Y67nU+P2pK3W3qQsU7va9X1k4bhXWRzj5eFPtZESW0A1xryfjqJ1oKIS+KAA7k13s5OYhuNxMvEHCyaqK2lZiKRJQ9NkOsWPZOW0acidGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDtUgk5g; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDtUgk5g"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-847d1e9db22so3740734b3a.2
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 12:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783365715; cv=none;
        d=google.com; s=arc-20260327;
        b=Sge7ERC2a6w82YNNQBbomMyXI77psukdvdjytCyywZyusNDdW3LUr/YNHq7dfo/3WD
         vBKDNAdpXiYsft4jQp5BeyoCS8hnD1ZF0AFpdyByeWf96d1QpHsr+QQoW4lYWw8S5gk6
         JyLJpoqUtaSYYRok6cndWSkPkk/RDiVXfc9puGDAKBVof1aloYwcmeA7/oHGAv4DQdNy
         35Q6fTJMIlAXguOICT9K3aKp8MP/HRJ8bYsSnvh23q1+LkGocn+UV5WHFs0/v+6I2c6h
         4RIElFVcCH4pXpkFiZU6f+gO0u2UimwkAw3pPSNrLh7/yOzSAgmHySJkQSO4GQpEcNA6
         nzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3V+CQWicM3KLCiA78W5fLi8JtVISekHIFvC89/oYT3Q=;
        fh=OPEMyfqj60DmtUL+HAzBSHXgQwcHEf08A1tLyujPLRg=;
        b=ZfgemC58HPFduQUvj4BoLULLYQNvcfZqUuekNzVzVSVN7wASBR6VF5mks7LId9sHvd
         OWJQj6FTNfEWtSFV9SW7pgtRATAMa2LzXJx9dBHN3ctuoQHTF5Z48EEd0CNceKSaxHI5
         f1d1ufYXqFeqUXsZTclPQlQJbO0ug+r9s50o1qEizCnxYAHW4qQkw/s405M8PTA36UR1
         rlto1Kp2VapofuyNZGJJBAJxy4SBhdoPI2JL9RGUlHI5L5qSkbazHznJEyw1IoAwA7jB
         KlLR0++yfh4iioVbE0tzceSfUde2iHk+CYd6hRmv7xHmIqCy0iQlfnWM87AA3Ciyg7Fv
         W8sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783365715; x=1783970515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3V+CQWicM3KLCiA78W5fLi8JtVISekHIFvC89/oYT3Q=;
        b=cDtUgk5grI4JivQMpngGR+G819QprS220QfFKY28LJilMW34JnPn6e82RXYUP1429S
         6Z+pmhzu+BO1YVay5kodS80Dm8cOieI8vLeE6bYe7nDjX7wHeZNEEKJe3Bz26N+dwif6
         75PJKFPv1KzOKCgB+eP1TyJeBdRanOnEmDD/do1OopRJALv5yChma/0gPcDaaqoUBE87
         vS11S/ukwfIFXUNUORBoP0X0IVqCE8pDFdJBkJHR7NVHVWRNR2yIOBHxnuQOj2DyMiuS
         kM3bkzJK70xC85wSsVeODBUW4P4gL072e/RmhAMLEuZWEdoQyeXV048kKehJlTh9FdP2
         p4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783365715; x=1783970515;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3V+CQWicM3KLCiA78W5fLi8JtVISekHIFvC89/oYT3Q=;
        b=qTWwgWx+lbE6i4smUqwjkFwoRMX8hGK4SJcMFX3fnb8/qY59IEhk/VLzxpRcf4M/WA
         1hI9+l1+RQbfhU05u9ta7xduGn1s2mLgaLHZQRrIxxeqgD9cQ8dUkG1qI2AqXx5mVt9s
         hlL8QTL/OOySDE4kS4xmc8Gj+yQGwFM2qm0cLhmWwQZmgV5OnZlptSHCfbk8FBjs678B
         UNtMeez+6qXOQAxR9Cispj8lc+GxZrTKVLjIjW4NMDw9eQxm3HOWOLwYpwaCW9Iu9vz0
         KKZ8oLoArn7KQeDm/1w6uiFeRqnRAPcd/VihPXeC+bfHoNqypAFK6/zkqLFd5GtcDzFn
         fz9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqx8pRYMYlsHakq6/aIJSkQFax2kC1LEoH7mUOmn4dHg8WmuFdG0kbcpFlSQdTRj7rVh9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5dYk66jVyFr8J1DIk4fCPQVHoE6De6en/Otp6S4ZU1E9ajGZ
	ISwKgyVDIyltd2tDs6vvCWB7fv1ZnNo7f3mz6n2raHe53C5SSz50mtniesG43Zv/oQxj3naiW++
	A5pI/MNpJMKS+hsSnWj0Nl9LeKjpaRSNT44hFOD6r
X-Gm-Gg: AfdE7cluVKfFgLfsJkb4H9qqLP1CFboV4xzuW/lkSwHTbWzFOBdUmzWY6B5X2OxJIN+
	vS3KN8t2RrbXp3EAlDAYEfewmKDQBUcoM1GZHCcExwAw473DP5aKBk8gSPl/ZQJVAui0fA4ZeXk
	kjybTuAVAmkLx/c8NbLWl1+PIsCMAFsBh8jNy4Hpg744B3KmCCeP/7IyL1wC9016YR2ReM0/npY
	cWRDcrrus5GEPGrm0OBB/5tjzHfzXJ4gKeC0U7PVyVeiRtjWjfTyi/KFZxIhyW+YA0qa3pftA6n
	WEsdcXpVKN32Z6T9IwWY+7AMG5vZnxZ7luQUTejs6sIj16NY9FFVOEgB9nw=
X-Received: by 2002:a05:6a20:d499:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3c08ed14337mr2309434637.3.1783365714229; Mon, 06 Jul 2026
 12:21:54 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 12:21:53 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 12:21:53 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-24-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-24-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 12:21:53 -0700
X-Gm-Features: AVVi8Cd9CK0d5hkj-fvDpFPP8e629cstUI2GaeEwDwzmHyMfLj4nBn8EKPgaG0Y
Message-ID: <CAEvNRgGg9YVnLzanueJrHyt9Ra3-q7CmRvP2Sg5dkdctaZpKqw@mail.gmail.com>
Subject: Re: [PATCH v2 23/31] coco/tdx-host: Setup all trusted IOMMUs on TDX
 Connect init
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Setup all trusted IOMMUs on TDX Connect initialization and clear all on
> TDX Connect removal.
>
> Trusted IOMMU setup is the pre-condition for all following TDX Connect
> operations such as SPDM/IDE setup. It is more of a platform
> configuration than a standalone IOMMU configuration, so put the
> implementation in tdx-host driver.
>

I was wondering about hotplug. There's dmar_device_hotplug(). Does it
make sense to do TDH.IOMMU.SETUP from there?

For boot, is the platform-level configuration due to dependencies? Is it
because TDX is set up after IOMMUs and hence TDH.IOMMU.SETUP is done
from the creation of the faux device?

> There is no dedicated way to enumerate which IOMMU devices support
> trusted operations. The host has to call TDH.IOMMU.SETUP on all IOMMU
> devices and tell their trusted capability by the return value.
>
>
> [...snip...]
>
> @@ -119,6 +120,82 @@ static void unregister_link_tsm(void *link)
>  	tsm_unregister(link);
>  }
>
> +static DEFINE_XARRAY(tlink_iommu_xa);
> +
> +static void tdx_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
> +{
> +	u64 r;
> +
> +	r = tdh_iommu_clear(iommu_id, iommu_mt);
> +	if (r) {
> +		pr_err("fail to clear tdx iommu 0x%llx\n", r);
> +		goto leak;
> +	}
> +
> +	if (tdx_page_array_ctrl_release(iommu_mt, iommu_mt->nr_pages,
> +					virt_to_phys(iommu_mt->root))) {
> +		pr_err("fail to release iommu_mt pages\n");
> +		goto leak;
> +	}
> +
> +	return;
> +
> +leak:
> +	tdx_page_array_ctrl_leak(iommu_mt);
> +}
> +
> +static int tdx_iommu_enable_one(struct dmar_drhd_unit *drhd)
> +{
> +	unsigned int nr_pages = tdx_sysinfo->connect.iommu_mt_page_count;
> +	u64 r, iommu_id;
> +	int ret;
> +
> +	struct tdx_page_array *iommu_mt __free(tdx_page_array_free) =
> +		tdx_page_array_create_iommu_mt(1, nr_pages);
> +	if (!iommu_mt)
> +		return -ENOMEM;
> +
> +	r = tdh_iommu_setup(drhd->reg_base_addr, iommu_mt, &iommu_id);
> +	/* This drhd doesn't support tdx mode, skip. */
> +	if ((r & TDX_SEAMCALL_STATUS_MASK)  == TDX_OPERAND_INVALID)

Extra space here before ==.

Is there a chance that TDX_OPERAND_INVALID might be returned for some
other reason other than that the drhd doesn't support TDX? I'm concerned
that some drhd would be silently skipped for some other error.

> +		return 0;
> +
> +	if (r) {
> +		pr_err("fail to enable tdx mode for DRHD[0x%llx]\n",
> +		       drhd->reg_base_addr);
> +		return -EFAULT;
> +	}
> +
> +	ret = xa_insert(&tlink_iommu_xa, (unsigned long)iommu_id,
> +			no_free_ptr(iommu_mt), GFP_KERNEL);
> +	if (ret) {
> +		tdx_iommu_clear(iommu_id, iommu_mt);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tdx_iommu_disable_all(void *data)
> +{
> +	struct tdx_page_array *iommu_mt;
> +	unsigned long iommu_id;
> +
> +	xa_for_each(&tlink_iommu_xa, iommu_id, iommu_mt)
> +		tdx_iommu_clear(iommu_id, iommu_mt);
> +}
> +

Is there an equivalent teardown operation? Like on kexec, if TDX is torn
down, would tdx_iommu_disable_all() need to be called to undo
everything, so that after TDX is started again tdx_iommu_enable_all()
would be set up again?

For hot-unplug, would the TDX IOMMU config need to be disabled?

> +static int tdx_iommu_enable_all(void)
> +{
> +	int ret;
> +
> +	ret = do_for_each_drhd_unit(tdx_iommu_enable_one);
> +	if (ret)
> +		tdx_iommu_disable_all(NULL);
> +
> +	return ret;
> +}
> +
>  static int __maybe_unused tdx_connect_init(struct device *dev)
>  {
>  	struct tsm_dev *link;
> @@ -130,6 +207,14 @@ static int __maybe_unused tdx_connect_init(struct device *dev)
>  	if (!(tdx_sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
>  		return 0;
>
> +	ret = tdx_iommu_enable_all();
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Enable tdx iommu failed\n");
> +
> +	ret = devm_add_action_or_reset(dev, tdx_iommu_disable_all, NULL);
> +	if (ret)
> +		return ret;
> +
>  	link = tsm_register(dev, &tdx_tsm_link_ops);
>  	if (IS_ERR(link))
>  		return dev_err_probe(dev, PTR_ERR(link),
> --
> 2.25.1
