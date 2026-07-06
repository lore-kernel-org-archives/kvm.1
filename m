Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C23F889E
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374549; cv=none; b=KivipelieAOG3W62HlW0a+gNw9wRjgkkTXV4afbAkCqtEY77ra7RZCIDHIggwssUjK22KmQ0/1say9iY7ljfjfn8olF0B8npDyiDllAvGsRrmhNr2D7S3i2cPxEpX7onYZ+DPC5NMhm71AqP+3yWpcxeg07sK9+2IO3rhVFjvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374549; c=relaxed/simple;
	bh=e675eE0ZMFoT1AEyjyOTLomvpLfl+YMD+jiR6g7h4TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCsQLjUpr1XTKXqwQPhD8JVhzHziOZnzw33gtDlSurk/6kdzYHC/o+JuHiUW+4OVJPFt8u6PZM+FjCZ9DJr2RP+A2tGGFFPCA1rRijB2ewRIQISwRl2SveBpmXIjBZJa7UmcrnumOvvkB3p1Zu85KgtUe+QDD+SJI+RtJyeVGUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qzoi2T4k; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qzoi2T4k"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381ed661712so3096039a91.2
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783374548; x=1783979348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/fz4zBeCM+AKNVXg8StRUyGYLTlPNg6xC0itoPf18c=;
        b=Qzoi2T4k3Xt2ynqtGbHWJVq+JYc0ZL4SKpwcAPQBG5A+FHwgG3IMqBcDphrm5lBH2x
         EGHePMkrD+T3ai7TRwfbbt8OJEzqXLTWMXA22SRulPoFpqaWh8A5Y3As5cFCzW572UG3
         wBDY3E28rldwyQeY2nQzxF1ODDP0pDsB6lsoVDsbri/lFrAR0yWPopfTS4ZQFinZV8zu
         S3K2pHjcgL471gbeXWQpGpDa/RNdoX/c9T0D+2G6BKvJwVEu8PyVPt2MYlPxu0s8j08N
         18PGVulgJFawSDiDklP8vowR5X7YBvtkbYJN8ctbqOWU9yKV8e7kIT5A03HcIJtgkpf9
         2pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374548; x=1783979348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/fz4zBeCM+AKNVXg8StRUyGYLTlPNg6xC0itoPf18c=;
        b=OMgg4XwXS/7cirM0Dm2i3EXPHqpuCrL1EiZIIU4YVzCqKby8LVmZqSnMHccufT75B6
         /za2vf+ppJw0d8GW6QgACkdjfmELz7+Wk0kIwzquf2ayvOgezu/jMg2b0nZm8OIocBYl
         VV8wFFJnRpniEBMbxypFerBU6CIRvOPCZWZ7PS8+ap6na6Udjh293rML3lO8bhTWvmyD
         H14caqwt6MvufgY6LLLJXsb111mSu2xlogzPKhC776vKf1xkNHteFUos2/Rv6Mlkko0a
         Es8+QuSZHHWfuttrj2d+dGvfDABfSJ1v6qyZHipdUwiQbtGdezehFhb2+5Gb4c9f4ghD
         /5eg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3AwcE85NsdzaH9VShD/Dc9HpMB1XuLQgyK19ETWGLC5ZmzbPLdhpp1u6wn3Vwq5Ht/n8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2trLDUSaeVW9+FyjqkrvISgNpAg5fVWIEBapXJcNRCAOD9OMS
	RwWwbgL3fvSFoALPsxYrDq66IoPZnS6ebMPHzMqD+NFqQWCYqldOEP6NSrfQVcrgjQ==
X-Gm-Gg: AfdE7cmxGB2Z7r/4Fb9gaGSINn9Bn6YRPbFpeMb7j5X1ba9LBBtI9Ko2BrBGy5KVO5k
	dN2+AKyGvpmpf70vmULrVIvzI6ZPOVs1iwO7I4r8LDK4vOkc5pGcGK3swUYpmqxvZAZXhx7wDTL
	j43+59RgX9/dPTLbdEOQo66FIfNg3ND6QF444lbAJ4kG3cSEvqkmHtxtDz03VgfRB4JtnxnF1OL
	0sOboeXwqqJ/xOxvf5YQ1nDiRGA8JxbB1otCQoWXmgzIeHn3cZMQV28W9Y7j4OXhYWdprR0Dx+A
	2KFYZ8b5T0mbpKjoFUhMd/IXLlQCUg1uhsNnY8ZDpkF/I2grpINgg4UnnQvcSyXKSbgotRFlZif
	rNGBhhfpjskLXZUCijPXLv3obAJXZWEx8TnnLNA4WFY8SkBRdsX0MBgTozG8BWhPJufKb5jlYPH
	7EaGlNKKQZUdkvxaSCmPkwFmNRTCl2VwprfQ5FD9KCcN6EVnxYgL0=
X-Received: by 2002:a17:90a:d003:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-387555738ccmr2308385a91.4.1783374547192;
        Mon, 06 Jul 2026 14:49:07 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387ceb724b0sm44659a91.0.2026.07.06.14.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:49:06 -0700 (PDT)
Date: Mon, 6 Jul 2026 21:49:03 +0000
From: David Matlack <dmatlack@google.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: alex@shazbot.org, shuah@kernel.org, amastro@fb.com, rananta@google.com,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
	sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: Re: [RFC PATCH 1/6] selftests/vfio: allow selecting IOMMU backend
 from environment
Message-ID: <akwiz5fpVRSWQEBC@google.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <20260703032806.40946-2-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703032806.40946-2-nnmlinux@linux.ibm.com>

On 2026-07-02 11:28 PM, Narayana Murty N wrote:
> Add support for selecting the IOMMU mode through the environment
> variable VFIO_SELFTESTS_IOMMU_MODE. This allows tests to be run
> with different IOMMU backends without modifying test code.
> 
> The environment variable is validated against the list of supported
> modes. On PowerPC, this includes the sPAPR TCE v2 mode which will
> be added in a subsequent patch.
> 
> If the environment variable is not set, tests use their default
> mode, preserving existing behavior.
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>

> diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
> index 93c11fd5e081..45b8bf60527a 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
> @@ -29,7 +29,7 @@ FIXTURE(vfio_pci_device_test) {
>  
>  FIXTURE_SETUP(vfio_pci_device_test)
>  {
> -	self->iommu = iommu_init(default_iommu_mode);
> +	self->iommu = iommu_init(vfio_selftests_get_iommu_mode());
>  	self->device = vfio_pci_device_init(device_bdf, self->iommu);
>  }
>  
> @@ -121,7 +121,7 @@ FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msix) {
>  
>  FIXTURE_SETUP(vfio_pci_irq_test)
>  {
> -	self->iommu = iommu_init(default_iommu_mode);
> +	self->iommu = iommu_init(vfio_selftests_get_iommu_mode());
>  	self->device = vfio_pci_device_init(device_bdf, self->iommu);
>  }

Rather than forcing the user to pass in the mode via environment
variable, can vfio_selftests_get_iommu_mode() pick a reasonable default
based on what the host supports? i.e. Is it possible for
vfio_selftests_get_iommu_mode() to now when to pick
MODE_VFIO_SPAPR_TCE_V2_IOMMU as the default mode?

The new KVM device-posted interrupt test that uses the VFIO selftests
library also wants this to pick between MODE_IOMMUFD and
MODE_VFIO_TYPE1_IOMMU.

  https://lore.kernel.org/kvm/aiIG2L_KdPwuxYA1@google.com/

And this would also fix VFIO selftests that get run on kernels where
IOMMUFD is not enabled.
