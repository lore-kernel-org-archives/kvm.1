Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821568;
	b=mvYjoRer9ligOOQsyEnmoUgOClgivjq2+0OdbQP9hoKJYbvxJuQFO8xo6blkImVNf+O+
	 VDbhfHPz67T03XopZZcXYe//nbC2JCn5V2qO4X0lLfFMBIaRftyZrb03Vp0O39U9M+jp7
	 rzKP0Ifb2aMUSxZeZqhbHugP9kEuMFOQh+JFueiRZxtlGy2nv1cU/S5cudxtawjiAP2p7
	 VSHliZUfsPrb0fHbgsJHqIM0VhFhEIDpzdGf1ON1M5/Xpqrnan5Gwaxi2j508wI/f1aOx
	 C1ghYZMuGF013tE70LrJAyFgejMrn9f1sOWB9LMv06rUSDPbz+E2gmsyL6sHYW2LkmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821568;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=5zNZH5gF0F9PHO6LDGee0Ff5YHPWOdHKXFv7txFPopg=;
	b=rg9CeiV7KehnqoQOV4Yq0coIHlwrUT57e3vEtx9l2qDBApH5vYETOPYV+hUblUa7VQOW
	 57eDVYwV/4GalEluCLE7Qyi5HrY7d3yHWT+/sSbAsn/XEN1Z2uj55SBzY1Zm72dbFniGl
	 u6sILqY5/6YT/04hM8aP8Rwd04vUiRpFpyAkL/KEIRXWNTBR9axGaGgu8K7svucVfe44/
	 SqPEKffm6MdVXhwm3jVpjkIpMRugG63DRDndO+6S23DGwbqd0zwv4RHYLym51xKTH2nYS
	 +q0dfvs3e9pdx/n5k6i220+EmJOElIY8QGB8k7+4i5DCjV6AzzFenC03+8deiFD3jMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PshgEr8F;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247E606A335;
	Mon, 16 Nov 2026 09:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7247E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PshgEr8F
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5zNZH5gF0F9PHO6LDGee0Ff5YHPWOdHKXFv7txFPopg=;
	b=PshgEr8F21mMItvWLZDG7BAUZgYJYRYkCOw89EgxndjyQBAucXEmp3r6OY0NTg8LW4Bfifwda
	8iLmWt8BewUBehpANoBcGMYUdJ9F2tWBKCPD/uN2MKbSBYN9c0phcfqg9GxGZHfw7E09uPwb0wo
	xTryNRf0DkRvUIdcwvDHWGI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jSjMN1z35z12LHt;
	Mon, 16 Nov 2026 17:32:48 +0800 (CST)
Received: from whupemo200006.china.huawei.com (unknown [7.152.185.252])
	by mail.maildlp.com (Postfix) with ESMTPS id 70CB340679;
	Mon, 16 Nov 2026 17:32:40 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 whupemo200006.china.huawei.com (7.152.185.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 16 Nov 2026 17:32:38 +0800
Subject: Re: [PATCH 1/7] Documentation: KVM: Fix references to non-existent
 identifiers
To: Fuad Tabba <fuad.tabba@linux.dev>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
	<frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Huacai
 Chen <chenhuacai@kernel.org>, <linux-mips@vger.kernel.org>, Will Deacon
	<will@kernel.org>, Fuad Tabba <tabba@google.com>
References: <20261111085448.1130701-1-fuad.tabba@linux.dev>
 <20261111085448.1130701-2-fuad.tabba@linux.dev>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f2f36f67-a993-735e-39d3-70e22ce6c87f@huawei.com>
Date: Mon, 16 Nov 2026 17:32:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261111085448.1130701-2-fuad.tabba@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemo200006.china.huawei.com (7.152.185.252)

Hi Fuad,

On 2026/11/11 16:54, Fuad Tabba wrote:
> The KVM API documentation and the review checklist refer to
> non-existent ioctls, capabilities, structures, fields and constants.
> Use the names from the uAPI headers.
> 
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>  Documentation/virt/kvm/api.rst              | 40 ++++++++++-----------
>  Documentation/virt/kvm/review-checklist.rst |  2 +-
>  2 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e95c9cda085d9..ccdc210575e25 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -897,7 +897,7 @@ x86 allows the operating system to program the interrupt polarity
>  (active-low/active-high) for level-triggered interrupts, and KVM used
>  to consider the polarity.  However, due to bitrot in the handling of
>  active-low interrupts, the above convention is now valid on x86 too.
> -This is signaled by KVM_CAP_X86_IOAPIC_POLARITY_IGNORED.  Userspace
> +This is signaled by KVM_CAP_IOAPIC_POLARITY_IGNORED.  Userspace
>  should not present interrupts to the guest as active-low unless this
>  capability is present (or unless it is not using the in-kernel irqchip,
>  of course).
> @@ -941,7 +941,7 @@ be used for a userspace interrupt controller.
>    struct kvm_irq_level {
>  	union {
>  		__u32 irq;     /* GSI */
> -		__s32 status;  /* not used for KVM_IRQ_LEVEL */
> +		__s32 status;  /* not used for KVM_IRQ_LINE */
>  	};
>  	__u32 level;           /* 0 or 1 */
>    };
> @@ -3219,7 +3219,7 @@ With KVM_CAP_IRQFD_RESAMPLE, KVM_IRQFD supports a de-assert and notify
>  mechanism allowing emulation of level-triggered, irqfd-based
>  interrupts.  When KVM_IRQFD_FLAG_RESAMPLE is set the user must pass an
>  additional eventfd in the kvm_irqfd.resamplefd field.  When operating
> -in resample mode, posting of an interrupt through kvm_irq.fd asserts
> +in resample mode, posting of an interrupt through kvm_irqfd.fd asserts
>  the specified gsi in the irqchip.  When the irqchip is resampled, such
>  as from an EOI, the gsi is de-asserted and the user is notified via
>  kvm_irqfd.resamplefd.  It is the user's responsibility to re-queue
> @@ -4982,8 +4982,8 @@ Errors:
>    #define KVM_STATE_NESTED_VMX_VMCS_SIZE	0x1000
>    #define KVM_STATE_NESTED_SVM_VMCB_SIZE	0x1000
>  
> -  #define KVM_STATE_NESTED_VMX_SMM_GUEST_MODE	0x00000001
> -  #define KVM_STATE_NESTED_VMX_SMM_VMXON	0x00000002
> +  #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
> +  #define KVM_STATE_NESTED_SMM_VMXON		0x00000002
>  
>    #define KVM_STATE_NESTED_GIF_SET		0x00000100
>  
> @@ -5448,14 +5448,14 @@ KVM_PV_DISABLE
>    KVM_PV_ASYNC_CLEANUP_PERFORM, it will be torn down in this call
>    together with the current protected VM.
>  
> -KVM_PV_VM_SET_SEC_PARMS
> +KVM_PV_SET_SEC_PARMS
>    Pass the image header from VM memory to the Ultravisor in
>    preparation of image unpacking and verification.
>  
> -KVM_PV_VM_UNPACK
> +KVM_PV_UNPACK
>    Unpack (protect and decrypt) a page of the encrypted boot image.
>  
> -KVM_PV_VM_VERIFY
> +KVM_PV_VERIFY
>    Verify the integrity of the unpacked image. Only if this succeeds,
>    KVM is allowed to start protected VCPUs.
>  
> @@ -5951,7 +5951,7 @@ This ioctl (when supported) replaces the KVM_SET_SREGS.
>  4.133 KVM_GET_STATS_FD
>  ----------------------
>  
> -:Capability: KVM_CAP_STATS_BINARY_FD
> +:Capability: KVM_CAP_BINARY_STATS_FD
>  :Architectures: all
>  :Type: vm ioctl, vcpu ioctl
>  :Parameters: none
> @@ -6087,10 +6087,10 @@ Bits 0-3 of ``flags`` encode the type:
>    * ``KVM_STATS_TYPE_LINEAR_HIST``
>      The statistic is reported as a linear histogram. The number of
>      buckets is specified by the ``size`` field. The size of buckets is specified
> -    by the ``hist_param`` field. The range of the Nth bucket (1 <= N < ``size``)
> -    is [``hist_param``*(N-1), ``hist_param``*N), while the range of the last
> -    bucket is [``hist_param``*(``size``-1), +INF). (+INF means positive infinity
> -    value.)
> +    by the ``bucket_size`` field. The range of the Nth bucket
> +    (1 <= N < ``size``) is [``bucket_size``*(N-1), ``bucket_size``*N), while
> +    the range of the last bucket is [``bucket_size``*(``size``-1), +INF).
> +    (+INF means positive infinity value.)

Could we fix the broken reST while we're at it? I mean

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index ccdc210575e2..4c7fece10aa3 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6088,8 +6088,8 @@ Bits 0-3 of ``flags`` encode the type:
     The statistic is reported as a linear histogram. The number of
     buckets is specified by the ``size`` field. The size of buckets is specified
     by the ``bucket_size`` field. The range of the Nth bucket
-    (1 <= N < ``size``) is [``bucket_size``*(N-1), ``bucket_size``*N), while
-    the range of the last bucket is [``bucket_size``*(``size``-1), +INF).
+    (1 <= N < ``size``) is [``bucket_size`` * (N-1), ``bucket_size`` * N), while
+    the range of the last bucket is [``bucket_size`` * (``size``-1), +INF).
     (+INF means positive infinity value.)
   * ``KVM_STATS_TYPE_LOG_HIST``
     The statistic is reported as a logarithmic histogram. The number of

The patch itself looks good to me.

Thanks,
Zenghui
