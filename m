Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82D4BC003
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985763; cv=none; b=i7e/rM9AosMnX9ziBssxSt7zElNKNWCciWGc0uslwavYTz//63FrKyUNcJFgjiYtXPZbvKKz2UL22Wa/+wC/ytkhhzneRmVFYsphR1xs9uY5VQfUJmryUCSgihL8d8wFiheL44svepD95TK6h6/m2mxbP47xjn7M9JE1Wqx2seM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985763; c=relaxed/simple;
	bh=AbYXd174owtLUH5oeD3O1F239WVF+qacUftI25VCH2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+szrle8Imq5jFZ0hLKxRVOwNyQWFsj5RYDfP7EBYEJFMkZ7TL895ZOl9/Ma4oMa07Gped+k7IAhaMoRWVsD4rqip/xuybFHMZqOIniNkncvDMQNeCRcT/skku/YIFKvXkY+gbqTGkxQDBlVZIrPY8HEPjQGe4g6ifLMeYB9K/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Utua5IQd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Utua5IQd"
Received: from example.com (unknown [167.220.208.73])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9550B20B7167;
	Thu,  2 Jul 2026 02:49:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9550B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782985758;
	bh=kLkylU6zCdWK6DFk7N+SawUDN3b6D/pxpOUEbBGRxhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Utua5IQdYG3LAfiztJNTN9CJkfEg3a86hguSfSv8ZkyorWwXP37EZxfluNBkN7UKj
	 UPI/+4/S2fTU/O51q4ktu+FEH6C6OUhUjJ+v4NlheVHc8hl3yJwVITWCqQQbs+bPXd
	 PQgu0+FfCNzhKDHLOCQq6sdYKTGMzA+OCIyksTfA=
Date: Thu, 2 Jul 2026 11:49:14 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
Message-ID: <akY0Gpd/GHj3Pdun@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
 <akUyiNahX3LnFPhn@example.com>
 <CABgObfbQTUOaiMYApABTettYa0D3WasGs1NjQrWvo4tmAZpazg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbQTUOaiMYApABTettYa0D3WasGs1NjQrWvo4tmAZpazg@mail.gmail.com>

On Thu, Jul 02, 2026 at 10:51:35AM +0200, Paolo Bonzini wrote:

> What are the additional fields that aren't covered (i.e. cannot be copied
> from hv_lapic_state to the struct and back) by the common APIC state?
>

that would be those:

    uint32_t apic_version;
    uint32_t apic_lvt_lint0;
    uint32_t apic_lvt_lint1;
    uint32_t apic_lvt_cmci;
    uint32_t apic_error_status;
    uint32_t apic_counter_value;
    uint32_t apic_remote_read;

Reference struct is this: hv_local_interrupt_controller_state

https://gitlab.com/qemu/qemu/-/blob/master/include/hw/hyperv/hvgdk_mini.h

Notably we have to do this for lvt_lint0+1. We cannot use the respective
fields in the common APIC state, because writing to those has a side effect
in QEMU: If unmasked, it will trigger a chain of events,

pic_irq_request() => apic_accept_pic_intr() => apic_deliver_pic_intr()

For MSHV (and WHPX afaiu) we're currently not able to trigger legacy
interrupts from userspace in this fashion. Hence we roundtrip
lint0/lint1 in a dedicated mshv struct.

best,

magnus
