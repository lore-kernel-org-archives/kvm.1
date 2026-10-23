Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.90.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792719000;
	b=IWQXe4/Sjg+zZ4+fPInl5ddSeJyErEEwcn9e2FeBECeQgC9nnXTk5aMkHEgVM3r2Q6VZ
	 WaK7lOSn7lU74Cx9vYeVNE2uQYSGcIVW8GZdY8TRbPpUT9NOLLWxLHad5u2ruej2PMqoV
	 9OUUmEULDg/2uMsdYnSyjbs+RtUOQqZU8/gRDOH6JALhsyoz42mQZmzPUOclCFrujeNGf
	 bAL+Hh1K9kPYzXy4OXJG5vwsvMbAGNp0SF7sZzj6tetVWbiNw85ugBEwvp1DRsjsm9fGj
	 OD+i9Q5F5X0D2cNHX6UjxtYSWOZofZXppMavQHueVNDn47y9Y+haTCJV1oNNFvpNoiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792719000;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QpYlSLBOVm1TVBcENr8nj4ESG+L/sMY7eZTmrI06N0Q=;
	b=Pj8X3vquqLW3+14GKHKrT+JZ2pzV5FXGmpr5o7GZVSs5HXi51h7z3gZ5vMCVn8WtavCb
	 ru/pNAlFQyeDfAoTAYq0lrLWMMaCemu0BXjGCE0ywXRworx8K6zOoI49XPYStM3A/gzUz
	 Ka63/Hz8iVibgwsBlgUDzjyuNyqw9v6qfty9oHhjciB7H8OnBXhly/FB0qYSwyHqz3rJh
	 +2xK1CUM/0SgbX4Y6Esoz3F3KDXhXwkMZQ7annjhivzwrWlvjrPYyKsDsePlBcyWidnc8
	 dCNRCC4qEKHtWMuAAGTXuCaLIsaYXjwNn4uT96PAj+7Egz+nSYu7j98pS8eX4SXw0FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=fxRjOrlJ;
	arc=none smtp.remote-ip=207.54.90.47
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A6606A31A;
	Fri, 23 Oct 2026 01:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 913A6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=fxRjOrlJ
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1792719000; x=1824255000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q/43GhANLwexWUHi7sLp6rT3JtxS4Ij0uWILefHuoNU=;
  b=fxRjOrlJevb+4QMTs8610vLu2t8++jjmLPjpyxZYPt2mwgqM7bF3Trn3
   zksOuXj9AgDxYaeOcpkAT9J4/pney+KSBZUnyey6Eu6i90acoki2FsOE5
   61rYTvNzrNH/umUQZevn/f3C75VgHM5RtnzchFGK3SKeuEafIHSxn57R+
   gvqmcCNkFvKpc7ymwPZZd6w/vNxA10DUox0I+D5TkuuD6tzlVPC5Swz0y
   LDdszQsu/DCZ3mgGZEHTn6Qam+pnVdgBPu0dCFOPi6mxNbgaYIO1smoGg
   XCxGJZodT2aTTxF3VN5thPW1jX7/TFoI+HXoEJKSpCVCJxNKOfgUjgGmN
   Q==;
X-CSE-ConnectionGUID: FnuMEA50SMSw43tiQB4zpA==
X-CSE-MsgGUID: yMgtarldRQyAuQoo2JNCSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="259153887"
X-IronPort-AV: E=Sophos;i="6.27,173,1786978800"; 
   d="scan'208";a="259153887"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 10:29:58 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id C521240610B;
	Fri, 23 Oct 2026 01:29:57 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (unknown [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 77C731804174;
	Fri, 23 Oct 2026 01:29:57 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.10.127.164])
	by az2uksmom3.o.css.fujitsu.com (Postfix) with SMTP id 8C0B010003CB;
	Fri, 23 Oct 2026 01:29:46 +0000 (UTC)
Date: Fri, 23 Oct 2026 10:29:44 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org, 
	gshan@redhat.com, joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com, 
	linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com, 
	Soby Mathew <Soby.Mathew@arm.com>
Subject: Re: [PATCH v22 06/10] firmware: arm_rmm: Ensure the RMM has GPT
 entries for memory
Message-ID: <atq3Q7CBCmfzqzCL@FCCLS0092175.localdomain>
References: <20261002061507.1600269-1-suzuki.poulose@arm.com>
 <20261002061507.1600269-7-suzuki.poulose@arm.com>
 <atiyZ7_S7aBxowIQ@FCCLS0092175.localdomain>
 <34bf0c98-35b1-4402-842f-a100245cb9a7@arm.com>
 <atjEkyLimpQSL4d4@FCCLS0092175.localdomain>
 <0ab0d3a1-a225-4a88-91bf-04f8f0e42eb7@arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ab0d3a1-a225-4a88-91bf-04f8f0e42eb7@arm.com>

Hi Soby, Suzuki,

On 10/22 13:07, Suzuki K Poulose wrote:
> On 21/10/2026 15:00, Kohei Enju wrote:
> > On 10/21 14:35, Suzuki K Poulose wrote:
> > > Hi
> > > 
> > > On 21/10/2026 14:07, Kohei Enju wrote:
> > > > Hi Suzuki,
> > > > 
> > > > I've tested this series and found a possible TF-RMM issue.
> > > > Please  below.
> > > > 
> > > > On 10/02 07:15, Suzuki K Poulose wrote:
> > > > > From: Steven Price <steven.price@arm.com>
> > > > > 
> > > > > The RMM maintains the state of all the granules in the system to make
> > > > > sure that the host is abiding by the rules. This state can be maintained
> > > > > at different granularity, per page (TRACKING_FINE) or per region
> > > > > (TRACKING_COARSE or TRACKING_INTERMEDIATE). The region size depends on the
> > > > > underlying "RMI_GRANULE_SIZE". For a "coarse"/"intermediate" region,
> > > > > all pages in the region must be of the same state, this implies we need to
> > > > > have "fine" tracking for DRAM, so that we can delegate individual pages.
> > > > > 
> > > > > For now we only support a statically carved out memory for tracking
> > > > > granules for the "fine" regions. This can be extended in the future to
> > > > > allow modifying the tracking granularity and remove the need for a
> > > > > static allocation by the firmware.
> > > > > 
> > > > > Similarly, the firmware may create L0 GPT entries describing the total
> > > > > address space. But if we change the "PAS" (Physical Address Space) of a
> > > > > granule, then the firmware may need to create L1 tables to track the PAS
> > > > > at a finer granularity. Linux therefore checks if the platform firmware
> > > > > manages the PAR region. i.e., the firmware is in charge of managing the
> > > > > L1 GPTs (creation and the required memory for the GPT tables - via static
> > > > > carveouts) without host intervention. Support for dynamic GPT creation by
> > > > > the host will be added later.
> > > > > 
> > > > > If the firmware requires us to manage the tracking or GPT memory,
> > > > > deactivate the RMM and reclaim any memory donated at RMM activation.
> > > > > 
> > > > > Apply the same checks when hotplugged memory is brought online.
> > > > > 
> > > > > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > > > > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > > > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Tested-by: Gavin Shan <gshan@redhat.com>
> > > > > Signed-off-by: Steven Price <steven.price@arm.com>
> > > > > Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > > ---
> > > > [...]
> > > > > +/*
> > > > > + * We do not support creating L1 GPTs yet. So, make sure that all the regions
> > > > > + * are managed by the firmware.
> > > > > + */
> > > > > +static int rmi_verify_gpt_firmware_managed(phys_addr_t start, phys_addr_t end)
> > > > > +{
> > > > > +	unsigned long l0gpt_sz;
> > > > > +	unsigned long next, par_state;
> > > > > +
> > > > > +	l0gpt_sz = 1UL << (30 + FIELD_GET(RMI_FEATURE_REGISTER_1_L0GPTSZ,
> > > > > +					  rmi_feat_reg(1)));
> > > > > +	start = ALIGN_DOWN(start, l0gpt_sz);
> > > > > +	end = ALIGN(end, l0gpt_sz);
> > > > > +
> > > > > +	while (start < end) {
> > > > > +		long ret = rmi_gpt_info(start, end, &next, &par_state);
> > > > > +
> > > > > +		if (ret != RMI_SUCCESS) {
> > > > > +			pr_err("RMI_GPT_INFO failed for %llx-%llx: (%ld)\n",
> > > > > +				start, end, ret);
> > > > > +			return -ENXIO;
> > > > > +		}
> > > > > +
> > > > > +		if (WARN_ON(next <= start))
> > > > > +			return -ENXIO;
> > > > > +
> > > > > +		if (par_state != RMI_GPT_PAR_PLAT) {
> > > > > +			pr_err("GPT for the region is not managed by firmware %llx-%lx\n",
> > > > > +				start, next);
> > > > > +			return -ENODEV;
> > > > 
> > > > When system RAM starts at a non-L0GPTSZ-aligned address, the alignment
> > > > in rmi_verify_gpt_firmware_managed() may cause the queried L0GPT range
> > > > to include a memory hole.
> > > 
> > > > 
> > > > On out platform, the relevant memory layout is:
> > > > 
> > > >       800c0000000-800dc3fffff : memory hole
> > > >       800dc400000-82fffffffff : System RAM
> > > > 
> > > 
> > > Thanks for the report.
> > > 
> > > > Consequently, Linux queries the following L0GPT range:
> > > > 
> > > >       800c0000000-80100000000
> > > > 
> > > > The query fails with RMI_GPT_PAR_RESERVED:
> > > > 
> > > >       [    8.551855] GPT for the region is not managed by firmware 800c0000000-80100000000
> > > > 
> > > > and arm64_init_rmi() subsequently fails.
> > > > 
> > > > As I understand it, smc_gpt_info() in TF-RMM checks only the beginning
> > > > of the aligned L0GPT range. Since that address is in the hole, the whole
> > > > range is reported as RMI_GPT_PAR_RESERVED, even though it contains
> > > > platform-managed System RAM.
> > > > 
> > > > I believe this should be addressed in TF-RMM. Do you have any thoughts
> > > > on the expected RMI_GPT_INFO behavior in this case?
> > > 
> > > I believe the RMM should report a value that represents the situation
> > > better. In this case, there is a hole, and some conventional memory
> > > areas. For the conventional memory, the RMM has to manage the GPTs.
> > > (This applies to the tf-RMM implementation of TRACKING Granule state
> > > too. It only looks at the first granule and reports the type of memory.)
> > > 
> > > RMI_GPT_PAR_RESERVED is not accurate as the memory region is not
> > > reserved, unless it is reserved for firmware (in which case the
> > > memory description is wrong).
> > > 
> > > I would say RMI_GPT_PAR_PLAT  is accurate if the L1GPT exists, as the
> > >   region covered by the L0GPT has some memory that are delegable.
> > > 
> > > Otherwise it must be reported as RMI_GPT_HOST_NOT_CREATED.
> > > 
> > > The information that a given memory region is not "memory" (i.e. hole)
> > > is basically TRACKING_STATE returned as RMI_MEM_CATEGORY_NONE
> > 
> > Thanks for the clarification. Could you please raise this with the TF-RMM
> > team? Please let me know if I can help with testing or provide any
> > additional information.
> 
> [Duplicating Soby's response, which may have been filtered due to the HTML
> email]

Thanks for relaying Soby's response :)

> 
> --->8---
> 
> Thanks Kohei for reporting this issue. I have pushed a fix for this in
> TF-RMM which we hope to get merged soon.
> 
> https://review.trustedfirmware.org/c/TF-RMM/tf-rmm/+/55689/1

Thank you for the quick fix! I'll check the patch and give it a try on our
platform.

Thanks,
Kohei

> 
> Best Regards
> Soby Mathew
