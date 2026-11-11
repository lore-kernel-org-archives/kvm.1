Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387401;
	b=SmTcaHVDhIMA7fnkBKXhw8PQyxYpmXAgppDE5pGR0D36aAJBu69g9oqjw/zifrCNWwjG
	 tvkjKT0WCxshqjTYwYgOTDMmRX7El9C80JJ7fXAumzwyZdH8K5tShUcdhzeSO1gVNL2ij
	 5/HOUobKkYrV1wBrf8DGGggYCewdrNe46a5j5QHvuk5aOc+9usuG7GkZ+92zp2GEO5yN4
	 E2XGPCv09RZL08DwJriLp7xYjyI6HCmlTxy8px7GsrJo+UzV337/d9yQAh388l2GmFpH/
	 Vmrb06+OvqlzN6m1zF2gOocQ99MWsLkw8z7cfE8aJuJ5sAf/pK/0hX9WRfgVkKL64EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387401;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zUh7BgdIOFpLEpkJ6X2Y9nJLJ8KSFfxW3Xf7xe5ENoY=;
	b=tuFN2pT0ykw+aLYk3qhXb9tPzMJvpFvKTPpMB7d0cs7Qe3hefVD/PCENOHBpyqWOiIzJ
	 8hWGhFkrGGNcVyuneEHNHH+limX4rHJc6bnW4MeYqHLUz+fGsjlVo675B0rSVewEwn3fS
	 8/WrVm+ai+8cBf7iI4ffpcTKVhv0W8HpeUbvmStLy1VbLMYOPJJIPf6+INanYMTReqUyC
	 x1gvOpNQHmok37i5qhb3D7tjQoGfbm3vkGUOde+aY3BwsmS6KLT3n+l3WXYFvDSBsURvk
	 J8F5mxFP16cpqj+vw3QYiQtKV0l1XaRySSM/EzQqtfT2Ryke9r5a8nPkwDOLVPBs0EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJ5gna+V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE992606A321
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJ5gna+V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE8E1F00A05;
	Wed, 11 Nov 2026 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794387400;
	bh=zUh7BgdIOFpLEpkJ6X2Y9nJLJ8KSFfxW3Xf7xe5ENoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EJ5gna+VKb86Kmp0EGZj5IHZMcmi4MejLRiKsBvAQbzepsFmsLSNpmrwMMM6AdEaC
	 QlHVCPW7pDYHvlIe8LU7SJtw9LUdeB7+TPTw0BNycMdHKdiupqiPyUVnaPunJ8CuXn
	 zn2aB7b6d+A2dVFa63tbudtxJb2UZcYLAmcivh7wUltnAQcnyILsnVgc+GHvagXBp6
	 Fwq8Toah26nMkY1kZIDu7jkcRrMxGVwNWiPn0/u7OGzFscYxrDm7ZwZZXKHOHpYK7k
	 CvxbExJ0KSQV9/qob3xAPuGqOtClh6C50Sm1gDaAVS6Ut9yPJhOHiAoKvE+8E2Ky8K
	 4X1kyQ6UY6L8A==
Date: Wed, 11 Nov 2026 09:56:34 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Gavin Shan <gshan@redhat.com>, berrange@redhat.com,
	kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
	lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 00/24] Add Realm support to QEMU-VMM
Message-ID: <avQtwvArH3we5GBp@lpieralisi>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>
 <atkokvqTHygpI8dt@p14s>
 <5dba456f-26b4-4f05-9271-fb784736d581@redhat.com>
 <atvCNKxpCRRSFL58@p14s>
 <avLM3UdwUcgUHLgP@FCCLS0092175.localdomain>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avLM3UdwUcgUHLgP@FCCLS0092175.localdomain>

On Tue, Nov 10, 2026 at 05:01:14PM +0900, Kohei Enju wrote:

[...]

> > > > > (1) qemu is terminiated on qmp command 'dump-guest-memory'
> > > > > 
> > > > > (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
> > > > > **
> > > > > ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> > > > > Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> > > > > 
> > > > 
> > > > On my side this command causes the Realm to abort, as I expected it to be.
> 
> Hi Mathieu, Gavin.
> 
> I've tested RFC v5, and I reproduced issue (1) on my side as well:
> 
>     (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
>     Failed to set KVM_REG_ARM_TIMER_CNT
>     ./qemu-ram-realm.sh: line 21: 77580 Aborted                 (core dumped) $QEMU -no-reboot -M confidential-guest-support=rme0,memory-backend=ram0 ...
> 
> This was resolved by adding kvm-no-adjvtime=on.
> 
> > > > Realm memory should not be observable from the host.  There may be a debug mode
> > > > to enable this kind of operation but I will have to look at the documentation
> > > > for details.
> > > > > (2) qemu emulation can't be stopped and resumed
> > > > > 
> > > > > (qemu) stop
> > > > > (qemu) cont
> > > > > Failed to set KVM_REG_ARM_TIMER_CNT
> > > > > 
> > > > 
> > > > That too I was expecting.  Anything that can comprimise a Realm will cause the
> > > > HW to abort.  I'll investigate the "Failed to set KVM_REG_ARM_TIMER_CNT" error
> > > > message though.
> 
> kvm-no-adjvtime=on also resolved issue (2) above.
> 
> Setting KVM_REG_ARM_TIMER_CNT for Realm VMs is not allowed, so we should
> either add this option or consider making it the default for Realm VMs
> in the future. What do you think?

I think that we should do something like we do for *put_registers(),
where we detect whether we are running a Realm VM or not, regardless
of the command line parameter or default that param to on for Realms.

Lorenzo
