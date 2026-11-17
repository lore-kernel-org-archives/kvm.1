Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918417;
	b=vjDTak9NQizRHcj+dfhbaXBpBCQlP3jdLhD4PrFJbtWJCO7C/Sl4VcxR0hQMrJ2+/kIt
	 6BrtAG0ukFE1qZffW0GE1rxoPti7Pe8hZWe0Ef/q8O1r+gup2m1H2e5sQMAC+jyMgFEsQ
	 3ouVfEB9juXU0amx7QLvpyUPB333QYNwfh9D5BBTuqAxDi8W9v8txvDzKl4Buxi9rPxMT
	 HKm0mB7DU2r4dSZXi+xABaZ+wYNhpSTSzFrLe2p83Pg2XwAKB1sxEYhKmPXYPXYlfxUi7
	 Csb4rnRlm+od0ms5elaFeH3zkGTwMyCOrsuAxGzCSBt+gZWu8vQDWwt2cWmN8TDrDpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918417;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Queue-Id;
	bh=j7oY28RdLZtDDQHfpOlL4ZKSrdCmfH4ZkKpc4rt79iI=;
	b=joQ4R1sgoxlTWPe5qs3g2+kp0xmHtz3/dPCQfHQzb17Ma49upsU9eMgAOzmiBMa1yjTm
	 45D/GpvyjozAoU8xYGohj189qVLX055gFsEPeEFjoKHJIrMesk7v1w0MfpFcyRbnfq4j/
	 mvAXtUczEkQGYMep0/xFFFg5sDbemrPKDcE8twU96einI7CoqJXA1jHBqOUhtRQqMWJn8
	 /GC0uHpItC1l/GLjMp1qxS0OjT9x6cCDW6JgbQNQGxcQ+2ZrOS0Po0WBD88QCODsd2cIU
	 76BCNCtDkidbY9ML/WDEGDCpHD05tPI91P6gnqkvjISl3ENXUFO9x2rSQ6jd4VMm02A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=M9kJX0yF;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C41606A330
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 12:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3C41606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=M9kJX0yF
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jTP9f3P3dzMllW;
	Tue, 17 Nov 2026 13:26:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1794918406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7oY28RdLZtDDQHfpOlL4ZKSrdCmfH4ZkKpc4rt79iI=;
	b=M9kJX0yF/y0YazhpqiBhxgDeA1j8FVHZSgM5Hne9xWufKwUuNRmz69zBlkmfrUS4Pomxa8
	UZStOx2BnusssXvQL4kqqdNe0tvtyClWKdhZ9IsFYPg2rPQ5rLb5NZ9i5jiFSf6VPTeBv6
	MFvLpI2RDMPdJhoJh2Yx7IFyP3o+DEwUgLbZtNbxGMEumwypTa/51vo7Gsg8giyVbPdDuB
	+a9WThAiCkaaVY00p8/y0THpw46BzZw6aE+BkIgqgV9NGrdZWwVhJ2OW1VQ5is82YXAEn3
	N+bTLW41kYDF4Z+LPrLLfK1+zwaRugNqiAXJpKZE+zuChfGP4r70g8wk58wWQQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=lists@steffen.cc
Message-ID: <70c638d283d4521a481b7aaf5889f87f679cab21.camel@dirkwinkel.cc>
Subject: Re: [PATCH 0/2] Support for Hyper-V's HvExtCallGetBootZeroedMemory()
From: Steffen Dirkwinkel <lists@steffen.cc>
To: Florian Schmidt <flosch@nutanix.com>, Cornelia Huck <cohuck@redhat.com>,
  Marcelo Tosatti <mtosatti@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: kvm@vger.kernel.org, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	 <philmd@mailo.com>, qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Date: Tue, 17 Nov 2026 13:26:43 +0100
In-Reply-To: <20260731095112.2975175-1-flosch@nutanix.com>
References: <20260731095112.2975175-1-flosch@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jTP9f3P3dzMllW

On Fri, 2026-07-31 at 09:51 +0000, Florian Schmidt wrote:
> This patch series implements two new Hyper-V hypercalls. The primary goal=
 is
> to support "zeroed memory" enlightenment via HvExtCallGetBootZeroedMemory=
().
> To do so, we also need to implement HvExtCallQueryCapabilities(). While
> HvExtCallQueryCapabilities() uses another bit in EBX on CPUID leaf
> 0x40000003, it then allows the guest to query for further "extended"
> hypercalls via the return value of that call.
>=20
> HvExtCallGetBootZeroedMemory() allows a Windows guest to enquire which ar=
eas
> of memory that were provided by the hypervisor are already zeroed out,
> meaning that there's no need for the guest to do so again. This has obvio=
us
> performance benefits.
>=20
> To get a rough idea of the performance benefit, looking at a 4-core, 64GB
> Windows 11 guest, we can see that an otherwise idle guest takes a bit les=
s
> than 90 seconds to finish zeroing and settle down from the time the qemu
> process is started. If we look at CPU usage for each vCPU task 90 seconds
> after starting, we get:
> 1559 498
> 1294 343
> 1451 314
> 4015 2729
> Conversely, after enabling HvExtCallGetBootZeroedMemory(), CPU usage is
> reduced:
> 1583 458
> 1441 361
> 1279 312
> 1337 264
> These are taken from the respective /proc/<pid>/task/<tid>/stat entries,
> denoting user and system time per "CPU X/KVM" task, in ticks.
> We can clearly see which to which vCPU fell the tasks of zeroing.
>=20
> It also has the benefit of not touching all pages at boot. This can be us=
eful
> if, for example, the VM is started with a balloon target already set to
> overcommit memory on the host. In this case, we don't risk memory usage s=
pikes
> on the host if the VM touches all memory before the balloon can catch up.
>=20
> Major changes since RFC v2:
> * integrated KVM ioctl (under review in parallel) into
>   HvExtCallBootZeroedMemory handler.

Hi Florian,

was there any result from the community call in September?

I was looking at this and found that windows only uses the hypercall in
winload.efi once and then passes the result on to the kernel. Maybe it woul=
d be
fine to track until this is called with userfaultfd UFFD_FEATURE_WP_ASYNC s=
etup
and PAGEMAP_SCAN in the first call of the hypercall and report/monitor noth=
ing
afterwards?

I also took a look at virtualbox. It seems to report all normal memory as
zeroed:
https://github.com/VirtualBox/virtualbox/blob/b6bea72111fcff48f31c57c9f6636=
5b1d3301bb9/src/VBox/VMM/VMMR3/PGMR3Phys.cpp#L1513
This seems wrong, but it is interesting that they have had it enabled for s=
ome
time (Looks like at least 06.2024 for the current version).

Thanks
Steffen

>=20
> Florian Schmidt (2):
>   Add HvExtCallQueryCapabilities
>   Add HvExtCallGetBootZeroedMemory
>=20
>  docs/system/i386/hyperv.rst      |  14 +++
>  hw/hyperv/hyperv.c               | 202 +++++++++++++++++++++++++++++++
>  include/hw/hyperv/hyperv-proto.h |  12 ++
>  include/hw/hyperv/hyperv.h       |  13 ++
>  include/system/physmem.h         |   8 ++
>  linux-headers/linux/kvm.h        |  15 +++
>  system/memory.c                  |   7 +-
>  system/physmem.c                 |  50 ++++++++
>  target/i386/cpu.c                |   4 +
>  target/i386/cpu.h                |   2 +
>  target/i386/kvm/hyperv-proto.h   |   6 +
>  target/i386/kvm/hyperv.c         |  14 +++
>  target/i386/kvm/kvm.c            |  91 ++++++++++++++
>  target/i386/kvm/kvm_i386.h       |   2 +
>  14 files changed, 438 insertions(+), 2 deletions(-)
