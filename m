Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698B34EEEE;
	Tue,  7 Apr 2026 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775602161; cv=none; b=Em7dopytkdPdk3J/UOxMWvyrtEq8VBrSPCD55Wwq+OAXoScoGLPhfClKhSv1IvgPqRUCVpGEPEOR7wZBNkV++EFT0BvVKwbIM64//BTGQTGH+2QMz9mQff+hcaEoN9j5W2KfQ6mNLC3u+qlgtZ57gpENBVwN0GmzjW6cDR+WkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775602161; c=relaxed/simple;
	bh=Vv5ZDKyUsLhX29PYoBNivl45MosV3IPSAUi/GzogTyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjMUbhom2EJq3QtiQx58yAQmqQKdUwsa9qJbX723cagZQMCx1du+P6JjxgzMe8FFBxl3ax09kfdhX8m3X9VZ9FFGPCtLkW9ns99I4FWIl5yyFg4WbJmRVSsauRhoNxTdOfvD1rLSBuDvaPENdxpIjByhADEnHDM8ZLcw3pLAff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=P2LSmUJv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBTwAse2; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="P2LSmUJv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBTwAse2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D699014000AD;
	Tue,  7 Apr 2026 18:49:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 07 Apr 2026 18:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775602157;
	 x=1775688557; bh=pz1pAYT78kMctiOJp5ypRQPPcH3kpbMpa3OPQ4kRhvA=; b=
	P2LSmUJvwFEj4LaXVx+Rhwb7VICub/mJEe3Z5ewzrtNjH4VgylX3AbVX/n8fshBR
	QMaOXeU4iXqe3jQnmmIdokCN4B30Vrj/sVPkGIQQvN8/5RzWJhzGrLLFAekS3NEh
	/qIpBZogehWxFThcCNxRoM8z/TZg85rJV7/xzfQR7s2mk3aqIHmnf463fAyOisH/
	gOIYUeOdwfmNpxHy6AFsSCZq9lWfWhEab+zG8/lcGxw7MmkQ6lVUWFF7dmRlX8TU
	/rcWKhvN//X2Dn2gbj/jBpC8QEpXWtdVYc7gkDDa/2jDy/IKlNztcKzS2uYNXS4p
	2CZPiLLARw/YuQLp94riWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775602157; x=
	1775688557; bh=pz1pAYT78kMctiOJp5ypRQPPcH3kpbMpa3OPQ4kRhvA=; b=k
	BTwAse2737PhYdgfApQQ7pfbX1G0kOfuDswmqEY6Ei7A/tSlHl/zM1XBsTB7gGa6
	h1okTLqhavS+mzLIEKvKRx7tf0eI8GoRjo3obg9ufWhwmsCW0ZLlQiEVX3AnQjsh
	SqORQcS5oT6Wzitx671aTrVIoNzgxnC7SuVDW26nhnTkQ2L4jh0wlXl+TS71o1FR
	TVXw+kQl4BU/ktSkgcJ9Bru1rif5l2xvSpIZ0aZf/OI7t4ox0+DAJWE2kVIiB79O
	MOHaRlYJxQF5bp3yTuSSQvG9Iv6niedVojOL9QF23ztIrtFTzDs45wNOgBQkSMlf
	PMdPVw1w9Jze5lDrh+Rlw==
X-ME-Sender: <xms:7YnVaWT7FAU8GtIy09Bk-ynFAsZuusMUdsE8QhtvTDvYR300XBbSkA>
    <xme:7YnVaV1BSM5Pj12rk_IKm9kjfa5KjWVRlHTndqD9WaB9RRaGzn0a593BtV8AgCWT7
    JQceA8xUpINcR-R4WvaySSrT-dkvg9Gogshd0m0Ub15D3W9LzBwSQ>
X-ME-Received: <xmr:7YnVaTu-ExuLE_5JPw6JLkhrkMV485qGjdjKj_AeZNls4yS03c6GpcCRhlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepffegteekhefgvdehjeehkeelffdtffethfelvdettdffieefheejgfffvddt
    iedunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpshgrshhhihhkohdruggvvhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgies
    shhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehruhgsihhnugesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:7YnVaTj8HVuqbPsmCdR64o9k0AhYqHW_-aaGcEVGnOBCm4ygEcbKAQ>
    <xmx:7YnVac9xi2Ph-RtPa5wkCVr7pxFrSomBFfr3MoythexuakdHJO0lpw>
    <xmx:7YnVaeuMXIxmPip5JlL8ZlvB9u5x6qPQsXJNK1gUx2DOcdrnp253hQ>
    <xmx:7YnVaYqw5cQq2RcpHthGjm9H9aGPwwz92UomCe7aVxKWGQIRz7h_bg>
    <xmx:7YnVaRQncKaJEieOfcLP_golZHOBXO1XzgamgVW4C8pdF7gDFAsImbT1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 18:49:16 -0400 (EDT)
Date: Tue, 7 Apr 2026 16:49:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Rubin Du <rubind@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v12 4/4] selftests/vfio: Add NVIDIA Falcon driver for
 DMA testing
Message-ID: <20260407164915.08c2de1f@shazbot.org>
In-Reply-To: <adRF7clGId7Wuiik@google.com>
References: <20260403234444.350867-1-rubind@nvidia.com>
	<20260403234444.350867-5-rubind@nvidia.com>
	<adRF7clGId7Wuiik@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Apr 2026 23:46:53 +0000
David Matlack <dmatlack@google.com> wrote:

> On 2026-04-03 04:44 PM, Rubin Du wrote:
> > Add a new VFIO PCI driver for NVIDIA GPUs that enables DMA testing
> > via the Falcon (Fast Logic Controller) microcontrollers. This driver
> > extracts and adapts the DMA test functionality from NVIDIA's
> > gpu-admin-tools project and integrates it into the existing VFIO
> > selftest framework.
> > 
> > Falcons are general-purpose microcontrollers present on NVIDIA GPUs
> > that can perform DMA operations between system memory and device
> > memory. By leveraging Falcon DMA, this driver allows NVIDIA GPUs to
> > be tested alongside Intel IOAT and DSA devices using the same
> > selftest infrastructure.
> > 
> > The driver is named 'nv_falcon' to reflect that it specifically
> > controls the Falcon microcontrollers for DMA operations, rather
> > than exposing general GPU functionality.
> > 
> > Reference implementation:
> > https://github.com/NVIDIA/gpu-admin-tools
> > 
> > Signed-off-by: Rubin Du <rubind@nvidia.com>  
> 
> Will anyone from Nvidia be able to help review the correctness of the
> driver?

You can tell by the versioning snafu that we've seen a bunch of
versions of this internally, so we think it's correct.  We also have
the reference implementation in the above link if anyone else wants to
compare.
 
> > +static int gpu_poll_register(struct vfio_pci_device *device,
> > +			     const char *name, u32 offset,
> > +			     u32 expected, u32 mask, u32 timeout_ms)
> > +{
> > +	struct gpu_device *gpu = to_gpu_device(device);
> > +	struct timespec start, now;
> > +	u64 elapsed_ms;
> > +	u32 value;
> > +
> > +	clock_gettime(CLOCK_MONOTONIC, &start);
> > +
> > +	for (;;) {
> > +		value = gpu_read32(gpu, offset);
> > +		if ((value & mask) == expected)
> > +			return 0;
> > +
> > +		clock_gettime(CLOCK_MONOTONIC, &now);
> > +		elapsed_ms = (now.tv_sec - start.tv_sec) * 1000
> > +			     + (now.tv_nsec - start.tv_nsec) / 1000000;
> > +
> > +		if (elapsed_ms >= timeout_ms)
> > +			break;
> > +
> > +		usleep(1000);
> > +	}
> > +
> > +	dev_err(device,
> > +		"Timeout polling %s (0x%x): value=0x%x expected=0x%x mask=0x%x after %llu ms\n",
> > +		name, offset, value, expected, mask,
> > +		(unsigned long long)elapsed_ms);  
> 
> nit: You can replace ll with l in the format string and drop the cast to
> unsigned long long.
> 
> We only support VFIO selftests on 64-bit architectures, and that matches
> what existing printfs for u64 use in VFIO selftests.

Yup

> > +static bool fsp_check_ofa_dma_support(struct vfio_pci_device *device)
> > +{
> > +	struct gpu_device *gpu = to_gpu_device(device);
> > +	u32 val = gpu_read32(gpu, NV_OFA_DMA_SUPPORT_CHECK_REG);
> > +
> > +	return (val >> 16) != 0xbadf;
> > +}
> > +
> > +static int size_to_dma_encoding(u64 size)
> > +{
> > +	size = min_t(u64, size, NV_FALCON_DMA_MAX_TRANSFER_SIZE);  
> 
> It should be impossible for size to be greater than
> NV_FALCON_DMA_MAX_TRANSFER_SIZE. This should be dropped or converted
> into a VFIO_ASSERT_LE().

Ok, I think the below tests can also become asserts.

> > +
> > +	if (!size || (size & 0x3))
> > +		return -EINVAL;
> > +
> > +	return ffs(size) - 3;  
> 
> Sashiko pointed out that this can lead to partial memcpys:
> 
> . If a non-power-of-two size is passed (for example, 24 bytes), ffs(size) will
> . return the lowest set bit (bit 4, yielding an encoding for 8 bytes).
> .
> . Because nv_gpu_memcpy_wait() performs exactly one chunk transfer and does not
> . loop over the remainder, could this silently drop the remaining bytes and
> . cause a partial data copy? Should this check if the size is a power of 2, or
> . should the caller loop to handle remainders?
> 
> https://sashiko.dev/#/patchset/20260403234444.350867-1-rubind%40nvidia.com?part=4
> 
> I think this nuance needs to be handled within the nv_falcon driver.
> vfio_pci_driver_memcpy_start() just guarantees that size <=
> NV_FALCON_DMA_MAX_TRANSFER_SIZE.
> 
> Perhaps this is why you had the loop in an earlier version of the
> patchset, in which case it was my mistake to ask you to remove it!
> 
> When you add the loop back please add a comment to the loop to explain
> that it is necessary since the region needs to be sliced up into
> power-of-2 sizes for Falcon.

Yes, shouldn't have been removed.  We can't do arbitrary sizes, only
power-of-2 down to 4-bytes.  We can make this more self documenting and
assert on memcpy_start for the size alignment requirement.

> > +const struct vfio_pci_driver_ops nv_falcon_ops = {
> > +	.name = "nv_falcon",
> > +	.probe = nv_gpu_probe,
> > +	.init = nv_gpu_init,
> > +	.remove = nv_gpu_remove,
> > +	.memcpy_start = nv_gpu_memcpy_start,
> > +	.memcpy_wait = nv_gpu_memcpy_wait,
> > +};  
> 
> Any particular reason these functions are named nv_gpu_*() instead of
> nv_falcon_*()

Yes, these can be made more consistent.  Thanks,

Alex
