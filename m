Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D14825AC
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992870; cv=none; b=JHlr8LKDQ1y+TPwhIIEipHvVC298FXRGeCJbuixjDlNR7fAePcLPdyHK/MXokl/VsjyFhkDtKpJni5x5AUubZpjPErPPa8bwIODYu+wxjwAZMdgaIoCW2tjQKVKBgDA3RVpxIBQdyUe68AeyAkKesOOkmx8BR940lbfPWrvUZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992870; c=relaxed/simple;
	bh=mqKexKRlmNDFLQEIvT7Y9z7FUD+hpM8xK3PiP7gpeMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peWWj+asuyaEpApOIre5LexpJGerAmoskMar4l3sSgoZS26hqTt6gQdqxgNzGUhqDFQo+po5UJfnG8QMl8G19Fzm/NUS0j6DvpPYc7z+4IHwtuwTCEd1phpO2s+AFAFpZgLFXFVHxoetC/lm0y/7B2um2WzngFrdqm7uGJI0tm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kh99ibga; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kh99ibga"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so624250a12.2
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788992867; x=1789597667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R5cPdTAC3boYVm13Avr5IgzIz8D8z9d9W6rfo2545Nc=;
        b=kh99ibgak5G4QcwI18d3owe7OazqpalonXOzIn1u7ixcsAtGPBuMJCV+wPTfPW93Zx
         5JksmleUaj1HYW/wzEHI2D7v9CmTZtfkIiSlyT80XG9h2rxjfb52L4g/WatVXsHrBLWG
         1WVAi7zbp75wITpZVE11ectc+xUDt80kn7K7i59MnZd04nCFZ14rkLjUqTV2MzN/a+WU
         E4ehGWy/30sShjczlgoS/41orH8pVxldORcj2zpMcG+Z69cojlCKBlwpbn8Hta4j598P
         nvSc/iOw2dto3nnFLL26kQY/IebWj9RYNDPGaHYsksBBDaIdjlVn9qTnJdhfn29zUrxP
         E2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992867; x=1789597667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R5cPdTAC3boYVm13Avr5IgzIz8D8z9d9W6rfo2545Nc=;
        b=bQrtacwqNr6LwPUvcazydL87miyC+Z45lExIlPafaJm+XmVTSHEhnk5uFzc/Ns2mR0
         bWiQ+DyXCXZI++1Sr0XZQZ+cj5daQqjwYgUKuxQXk2MW77lUX6LqXyX6/lAZg48Eu2t5
         vPI14vZMmcVoYIs2/SG01ugj2VFcVpGBk+eV4sIVsfb2SNv/6xJ8czoudH1iQK8k/xuU
         IqkVTyJyznaOIyr8THKiwppYfTH+IyYsMpXBpOZW7dneMCUhoS+7ROE+2OSD3ycFcgO8
         Ou1Gkzu/DXHhJs2+RDVYyMv1TtvvmyP8Q51Ju9i8AD6LAtYcy4p7BlQzosh+R8X9yHx4
         eY8A==
X-Forwarded-Encrypted: i=1; AKwUvBxhjMoIYYwxh5pCXCAAWcBCz/NEaNX704e4CSplIP6I43P6hcBdrTTk/lrOPR+yI4ycOeo=@vger.kernel.org
X-Gm-Message-State: AFuF++mH2InmG/nTcb8WQNciAj2B7PYn9oSHY7Qd5otCzyA7RNyZYRjw
	r1MxO/9j0w1YtMsAF94J7YIL78Ea23ow9yyozMVKzqAeih5noGRRl8fWdurFzgJ2kg==
X-Gm-Gg: AYBFou1KeFgu7L1rYY+ANHJU6OmM50jNunVO7TuFLgj+Yf+X1JSjZNOzczGSZeiL6r9
	tzH/QDZRn7T31NGewQ0xLy+TJb3T0KJ1hgH9ywWlMOwHKJCDS+WfBbJVcr6bPsHTs1GEQA4IqEe
	xyIwreJIiRl21Mxn/y2GEffKyqvQYqYUgsQVs6QPx00DnJ5Vpsyd+ys4H6USdNEbbUBbUicu5H+
	LvtwHyyFjYYl/cKSeD+agQiTqnUwxt0OIcpQ1c06ft+7buOXnFt1Uwrr2WuCqqcQY3Mwf4Q6zT+
	ZABVXbzDcnU4j/heELiPme/5LWBM6e/fPZr8XrCe92v64s0DUODJdEre+okF2ZqQTNv7ehlPjNs
	SpgmB8wr19pOOadsgF0MbbbddndcrDVGlNk2vU4Wb2QHyd/GPMh80hSeP01o72L65QOrbXmjcNN
	OGVLuX4YvZDLPYlHQErXPzNrRbGGVNssSTzlH+RQXLamDqBMY3BfiqSAjkoWAu69a8BjsQxcd5m
	5YJ7k595mpdaI0hjJZn0QZO0TXMtmQ82jDdcZlX
X-Received: by 2002:a17:90b:4cce:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-39b260dd4e9mr60322664a91.2.1788992866367;
        Wed, 09 Sep 2026 15:27:46 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7738ce41sm1598219a91.3.2026.09.09.15.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:27:45 -0700 (PDT)
Date: Wed, 9 Sep 2026 22:27:42 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/4] vfio: Reject a second cdev open before mutating
 shared device state
Message-ID: <aqHdXvfcfCJbLajM@google.com>
References: <20260901215358.2421359-1-alex.williamson@nvidia.com>
 <20260901215358.2421359-2-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901215358.2421359-2-alex.williamson@nvidia.com>

On 2026-09-01 03:53 PM, Alex Williamson wrote:
> The cdev single-open check lives in vfio_df_open(), which runs at the
> end of the bind ioctl, after vfio_df_ioctl_bind_iommufd() has already
> updated state shared across all opens: vfio_df_check_token() can set
> the PF vf_token and vfio_df_get_kvm_safe() records the caller's KVM
> pointer in device->kvm and takes a reference.
> 
> A second cdev bind of an already-open device runs both, only to be
> rejected in vfio_df_open().  The error path clears device->kvm and
> drops the reference, tearing down the current opener's KVM association
> and potentially resulting in an unbalanced reference on close or
> premature release, while the vf_token remains clobbered.
> 
> Move the single-open check into vfio_df_ioctl_bind_iommufd() ahead of
> both mutations, so a bind that cannot complete leaves the current
> opener's state untouched.  df->group is NULL on this path, so a
> non-zero open_count is exactly what vfio_df_open() rejected.  The test
> in vfio_df_open() becomes redundant and is removed.
> 
> Return -EBUSY rather than -EINVAL here.  The arguments are not invalid,
> the device is in use, which could be a transient condition due to a
> delayed fput if the prior user is terminated.  This provides
> compatibility with the group path, where a group open returns -EBUSY,
> and users may choose bounded polling to detect such a transient
> condition.
> 
> Fixes: 839e692fa4eb ("vfio: Make vfio_df_open() single open for device cdev path")
> Fixes: 5fcc26969a16 ("vfio: Add VFIO_DEVICE_BIND_IOMMUFD")
> Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD")
> Assisted-by: claude-opus-4-8
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Can you add a regression test for this?

The VF token clobbering can be reproduced in vfio_pci_sriov_uapi_test:

diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
index 19d657d00b75..de8408b90a25 100644
--- a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
@@ -157,6 +157,42 @@ TEST_F(vfio_pci_sriov_uapi_test, override_token)
        ASSERT_COND_VF_CREATION(ret);
 }

+TEST(failed_second_open_does_not_clobber_token)
+{
+       struct vfio_pci_device *pf = NULL, *pf_second_fd = NULL, *vf = NULL;
+       struct iommu *iommu;
+       int ret;
+
+       iommu = iommu_init("iommufd");
+       if (!iommu)
+               SKIP(return, "iommufd mode not supported");
+
+       /* Create and bind PF using UUID_1 */
+       ret = device_init(pf_bdf, iommu, UUID_1, &pf);
+       ASSERT_EQ(ret, 0);
+
+       /*
+        * Attempt to open the same PF again and bind it with a *different*
+        * token (UUID_2). This must fail with EBUSY because it's a second open.
+        */
+       ret = device_init(pf_bdf, iommu, UUID_2, &pf_second_fd);
+       ASSERT_EQ(ret, -EBUSY);
+
+       /*
+        * Attempt to initialize a VF using the original PF token (UUID_1).
+        * If the failed open above clobbered the PF's token (i.e. updated it to
+        * UUID_2), this VF initialization will fail.
+        */
+       ret = device_init(vf_bdf, iommu, UUID_1, &vf);
+       ASSERT_EQ(ret, 0);
+
+       device_cleanup(vf);
+       if (pf_second_fd)
+               device_cleanup(pf_second_fd);
+       device_cleanup(pf);
+       iommu_cleanup(iommu);
+}
+
 static void vf_teardown(void)
 {
        /*
