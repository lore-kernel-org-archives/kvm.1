Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62163CC7EA;
	Wed, 29 Jul 2026 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354231; cv=none; b=mrLV2GE0Na0IOBc9wtQgIp3/mLs8WZNQW40o+syXxT8+rdNEUl9JrS8W8canN+KKyk7dBYmSGLODBCF1f8ujWnUbbAxR5dKpj0YGQCZCSBGs4onWSwnQSXyWfnrqhxmcRPimRF7VV8GjGVBS0Nh2V9Ihw/YODQ04ObAVqvKA2a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354231; c=relaxed/simple;
	bh=nLnUgJR6suWJ3SvggDnbh+c5djeq93+SfpwayxUJLaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyIEyKSv2jTp+0i7EZENFFqZ2ui2jXqfSUKqv+67u4WvY1HL80pUFJfaJs6x75probUCJlP2u2m295ru0TAX2ee+qTjpBm/xMr3Flv+xdXFr4bAdZcboh1NkmZgrUINQhZj6M7iKDaNWEobY40NkF+5394KFtauSUhCaCwTKcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=aLcEj4Yh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YJQXFH+V; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="aLcEj4Yh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YJQXFH+V"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD83814004C6;
	Wed, 29 Jul 2026 15:43:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jul 2026 15:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785354220;
	 x=1785440620; bh=/WZTYwj1pa14Adp3/TGnLpvZs3ITI9hsnPwlfGpTn0M=; b=
	aLcEj4Yhhu0aAQOY7MS1uIQATBSQ9cmONqHnxyMjN0bTzcig6JG0K+x1Ytpu1YVG
	8ucJdTZ0pSgDcm/fRm3xkxfKJ289kmNw0Ufasz7ipt+yiXfr3x9zVDtSSuh0FRUz
	EPu0ZXhRER3Gb+3aURveZ2WgFJF+GyixWdTMptN+cQNyoru+6NG9pTplqqAHcO2h
	yIt3btpXGltvSrnpTXiqv604XmxXfnmIzXbCmLG1UPw+BAPpKjDZZ1OU/gS/IXk5
	AzGBOxaxfjKP8eFUMU/NbTQb9P+k7HI0FP2hERfEX+12LgkCm6TxlhlKoBJIb/jT
	DBJ3bK2V4YavBTfpfg8jEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785354220; x=
	1785440620; bh=/WZTYwj1pa14Adp3/TGnLpvZs3ITI9hsnPwlfGpTn0M=; b=Y
	JQXFH+VbmDuuP07XTVoaMiiJRLKl48/K9EWdVeWllZ/7g7CbUKEYavq+AnUJWAWz
	xF/ds7AM07zSbCIoS6fza8D7dpj7BppXwvl5OGtW/yXhPd6mf72MTvaGiB5q75pP
	sl+lOiwWKbhxJBoBNALQa85bvvzTn5+ZbxOG1cAlv8qtSMdGsK+2668ecC9+76Qf
	Nuu23nbPxpdLqtEqS6tRPcRfBm4E1M5A8k3Nfmsf5pAVkAQOmY1Uj15bI60mHeAM
	sbVAnNLnrhkKE2s/lbq/IjomNVPHXNjuKPYDIGfktgZTvrhJ+EsYyXJ25rZkO+Th
	k470HucgnqGH/aRoDL8rQ==
X-ME-Sender: <xms:7FdqalPm44yloWrbNiFWBMSrUMd0p6r3rQHSztdwnjGfJA6EXL3WFw>
    <xme:7Fdqaj-hM-0ry4ly_VrBQNu0pY6Q72KpFJH6CRx3VWpsXfXsMXQ3Ut3Btd4R1QJA9
    BO38WzrMbxUYu5nuwzyDF5j7w_e-kaYL3HY0WRqqHRI8S8EwZopo7I>
X-ME-Received: <xmr:7FdqameSsSzP9Mv817HGbrQ1h5ijSdGZN7GIaIayf9SjB9LnrT6vmQQXOLwRkg>
X-ME-Proxy-Cause: dmFkZTGu9NgC9buE7lFboILNhQgV1L3g2WrumCuUpsIMWqELc6X5+10ciExH4cOUmqfNXS
    n2aQO3jclx/10KahzZQ+JvnH1u0DHN/RBsijkXg4UOoynCoHrTcYj/zGVNngiJPQ8suzAY
    kR5Fb0jfQXGEdVjClKCsosiFUiSpjubNWOLlko2nLNcLw+lCX2leDmdu0f8b+HJWlb1VkC
    UcREpU7V/ZIbQwZp881SgSQ0tJ1hgxIqKv+OyMPO2cfvYE+kMxrVdE8cYNlYDoOntMmRxr
    weOndLHULoJFLZYZKPDgJEudxs1FLTiBnTpsr9P3u5V23JrPduYPir8JG2iGgQY7xTmub2
    KWU4hZH09rQQBkB3VR8//EA+qXqqaW3LJQ/h8EfVD2ZaOL+9PSpgsA1AsnHbmvjq9I4ODR
    7w50oiEecike5s/jKwEAPA+BqwuJSqE00aRtQ6DjXwslDdSvUcFePaVYFGH+XnS45WNA2j
    CQeEICkmDPcRXF1P1TPwrfeeb9FXtCDdxuoZrUukCbi5xdYt6R6nelJ38w9i0gB2RN884E
    CXhUpTZ6t0rbqmDjiUA8rhZJxEVDdY2edOupvIRpoP727hqddEQr3lBjjEd0SriY4gMogn
    6OIVlv+8gwIPF/J5XlAi9XCOycTOTvLcmAJil3hDe+iTTawXm/z7ckPlAp7A
X-ME-Proxy: <xmx:7FdqaizAywzeYNvbq0pcekB_1AjMAsdDslZ8IF9G177KwkjQY6PlGQ>
    <xmx:7FdqarIvFll9WzePJYrPynRYP2v4p96imkMrwtdlJcbBXmWbhs9gyQ>
    <xmx:7FdqakHw8D7N7AZOPcCe1fJfGyz9j9IzclU7A2TI58So6VtS-DsnOA>
    <xmx:7Fdqan_h3J8g62PHWqwP9Awf67e5V8Cx8ztoXwLGxNu0E_eOFd2CPw>
    <xmx:7FdqalhLMfO2LyJRNWzNwl3J0HPtml5M2lNb1PthAzcpFolsP34zGDVh>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 15:43:39 -0400 (EDT)
Date: Wed, 29 Jul 2026 13:43:37 -0600
From: Alex Williamson <alex@shazbot.org>
To: Josh Hilke <jrhilke@google.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>,
 alex@shazbot.org
Subject: Re: [PATCH v7 5/6] vfio: selftests: Retry on EAGAIN during device
 reset
Message-ID: <20260729134337.2ed84a99@shazbot.org>
In-Reply-To: <20260728-igb_v3_b4-v7-5-4616c3745796@google.com>
References: <20260728-igb_v3_b4-v7-0-4616c3745796@google.com>
	<20260728-igb_v3_b4-v7-5-4616c3745796@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 23:24:30 +0000
Josh Hilke <jrhilke@google.com> wrote:

> Add retry logic to vfio_pci_device_reset() to handle the case where PCI
> resets fail due to lock contention, in which case
> pci_try_reset_function() returns -EAGAIN.
> 
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>  .../vfio/lib/include/libvfio/vfio_pci_device.h          |  1 +
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c      | 17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index 2e67afc0d580..27bdf561925f 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -41,6 +41,7 @@ struct vfio_pci_device {
>  struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
>  void vfio_pci_device_cleanup(struct vfio_pci_device *device);
>  
> +int __vfio_pci_device_reset(struct vfio_pci_device *device);
>  void vfio_pci_device_reset(struct vfio_pci_device *device);
>  
>  void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 7b8394d0ac50..1b29cef96b04 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <dirent.h>
> +#include <errno.h>
>  #include <fcntl.h>
>  #include <libgen.h>
>  #include <stdint.h>
> @@ -221,9 +222,23 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
>  		       write ? "write to" : "read from", config);
>  }
>  
> +int __vfio_pci_device_reset(struct vfio_pci_device *device)
> +{
> +	if (ioctl(device->fd, VFIO_DEVICE_RESET, NULL))
> +		return -errno;
> +
> +	return 0;
> +}
> +
>  void vfio_pci_device_reset(struct vfio_pci_device *device)
>  {
> -	ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
> +	int r;
> +
> +	do {
> +		r = __vfio_pci_device_reset(device);
> +	} while (r == -EAGAIN);
> +
> +	VFIO_ASSERT_EQ(r, 0, "ioctl(device->fd, VFIO_DEVICE_RESET) failed\n");
>  }

This has roughly the same unbounded loop issue that Sashiko flagged
waiting for the register level reset to complete, shouldn't we also
introduce a retry cap here?  A delay would also help bound that retry
cap versus the instant retry here.

Also, please rebase to linux-next to keep the driver inclusion
consistent with the already merged nv_falcon driver (trivial) and
unblock Sashiko from applying the series for review (more important).
David's R-bs from v6 can also carry forward on the unmodified patches.
Thanks,

Alex
