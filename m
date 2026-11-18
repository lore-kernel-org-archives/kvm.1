Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036329;
	b=IqVKd9mmT2QAgooF+Egwp+c88Qa1ykJWgstEB3Bl2Mplq3GH1M2Efzz0HIWmgEo9wWL6
	 jzpOVsNLICZsc8q7wZT9YXDepeEDZWOExLF2WceDac0JsXB89vXpkxC3Y3KZOEH5J78T+
	 KQJ6vsB4ShyOs2zxsGkFL4XzWWkhL+8CJLk+gcsxqJBQM4ODBY9Zmccqf+FDgqgP5cTxa
	 nvh51ZeS6cLblaFjw7qZM+uC3DCAGmnNHxEnbbE8SSOK6ONJup3xsBShybF4+ZXfbpsiA
	 7XonBLJwqrs8Gk3PI4CDBBcm0KpDFK0gfsvqpsnERSMjvvnYPN3UfEdsUsmMcZH9TlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036329;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=ptNudMj14/O/WqnyheECU889YGefgN27wQrKVJxxFdA=;
	b=j41OKZ7MAsRRsb730sluzY2BYmTEnxR3gkQv5jEXtp5l7/DOqMrL4mEt2at5L58lirrN
	 7DtCDsWmLxpBhnB5LcebjeZw49LfWbLCxjhecPss9xrBsrgbqvx4LolXJsV3FGS9Y7hRC
	 7f83mTcxCfRz55CsGgCGg7iSQyZ4WkxCcRO0QFfa1Ls2k43bNIVR7Q8CLBdnbefpB9vQx
	 vLrUx2ccOnqpPm6tYNDwzpj/mnCKwE2c5Xtf4vUf9kUdHvjcIOnoqhrtx3kztOdwWmcW2
	 P1j8s8/A5DLW24VdtuXtW11ccIc2ai0E1UgubZJvIg7PaTg2dj0CgFWD2XKZiL0F1kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=EUioNryy;
	arc=none smtp.remote-ip=173.37.86.72
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375F606A320;
	Wed, 18 Nov 2026 21:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A375F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=EUioNryy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1346; q=dns/txt;
  s=iport01; t=1795036328; x=1796245928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ptNudMj14/O/WqnyheECU889YGefgN27wQrKVJxxFdA=;
  b=EUioNryyAYd9QGM2LtvBwvMgm/amjVGC1PykAKlj920us2klYtKpH9DQ
   ADVVZNv4d1AcPZZmOoKrfo2DRBLqLu/Z6EUh0bs1mhtdboKlEcRbufWJ5
   t1mDNqS1uaaEr+r/HMvmH/Z0hczQaWN2eRjMxxxPSJLES/8hwir6kOPhV
   +Ik95IEBetPcWAvqRPQInoZcBmZUKrgv+kWtFF18oBof3XXGznxyywhfD
   6t/Elvcf0wCQRXMMqKOgI4l0yGWK7A+pezVDQJdSSFuRnnjl6k4P9nG7F
   bmQnEVw2QbwftbnXMJRV6lJ9EwERfKi8w7KfYimU2Y/fRhNgyAjJ1gd39
   w==;
X-CSE-ConnectionGUID: ckPlIeq7QOmK63ybsGSLXg==
X-CSE-MsgGUID: rqiRQBj+RMmJdFyPCM9VUw==
X-IPAS-Result: =?us-ascii?q?A0BbAwDvE/5q/5H/Ja1aglmELENJlkuBFp0VgX4PAQEBD?=
 =?us-ascii?q?1EEAQGFBQKOIAImNAkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBBwWBD?=
 =?us-ascii?q?hOGXJATAgEDMgFGEAtGVhmDAoJ1A7lhgiyBAd5JgXQVgTiFdIdyhXMnG4FJR?=
 =?us-ascii?q?IEVgnQHMT6BBQGECoV5BIIigQyBB5czSAqBFANZLAFVEw0KCwcFgSVDAzUSK?=
 =?us-ascii?q?hUjDzwFLR2BIzsXEXYbBgUSICpAQ1uBEoEDXYErKF0BAh9GLRWBdgKCUYEjX?=
 =?us-ascii?q?QIBSUEOB0VTCSVDEkckIggSCQETGiwKgRo1PAkmPxUMWwwIAxoFGiYCHwgCC?=
 =?us-ascii?q?wIMdCgREBMdHiQvBRomPhsKgQwnHx4bDgQYDUgRLBQjFRkEPm4Hk0aDFwJXA?=
 =?us-ascii?q?oF4RgYvH6VwoRGEK4Fon3YaM6pymQikCxk3hGqBaDyBWTMaCBsVgyJTGQ+OL?=
 =?us-ascii?q?gsLHNACJjI9AgcCBw4DC5NmAQE?=
IronPort-Data: A9a23:OCHZqaPhVFG6+EDvrR2llsFynXyQoLVcMsEvi/4bfWQNrUpx1GFRm
 zQbCG3SPvaJajD9f9x/atmy8R8PvpeHn4A1QXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeap1yFjmM/ErF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVzlV
 e/a+ZWFZgb8gm4saAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/5tNEUXMJRHw8FyIj8V5
 PYDBwspXh/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmJS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMXwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQsjOi9bYqIKoziqcN9hF+Zn
 Fvs/SfDJxQ4OPKO8RGgo0yRmbqa9c/8cMdIfFGizdZxjVSVxGc7BxoRWl+25/K+jyaWQ9hYL
 V4V/CsGt6U+9EW3CNL6WnWQo2CBlgATVsAWEOAg7gyJjK3O7G6xAmkCUy4Ea9E8ssIybSIl2
 0XPnN7zAzFr9rqPRhqgGqy8tzi+P20RaGQFfyJBFVtD6Nj4q4Z1hRXKJjp+LJOIYhTOMWmY6
 1i3QOIW3t3/UeZjO32HwG36
IronPort-HdrOrdr: A9a23:uEypbqM0el0+A8BcTuGjsMiBIKoaSvp037Dk7SxMoHtuA6ilfq
 +V8sjzuSWftN9VYgBCpTniAtjkfZq/z/9ICOAqVN/IYOClghrLEGgI1+TfKlPbdhEWjtQ86Y
 5QN45jFdb3EV92yez+4AW+DpIc5ePvytHOuQ8bpE0dND2DrMpbnmFENjo=
X-Talos-CUID: 9a23:CRS1w2xwXH+B10OTXZCkBgUfGfghU3DEk073JmzmUndjU5KubW+frfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A/7ibGA3Gprhe8h+f3QkA6u3XsTUj+b2vMnknk9Y?=
 =?us-ascii?q?8nsymOQJhAxy43QqKXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="548858588"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2026 21:12:01 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id 7522C180005AD;
	Wed, 18 Nov 2026 21:12:01 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: seanjc@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: Send reschedule IPIs instead of SMP function calls for non-waiting requests
Date: Wed, 18 Nov 2026 13:11:52 -0800
Message-ID: <20261118211152.3430478-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117205428.3717-1-seanjc@google.com>
References: <20261117205428.3717-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-08.cisco.com

Hi Sean,

I tested this in place of my IRQ-bypass patch. The latter was reverted in
the test source, and I loaded a kvm.ko built with your change against the
running test kernel.

On an Intel UCS C220 M7, a four-vCPU guest used an ENIC VF through VFIO.
With the other three vCPUs busy, reloading the guest VF driver traced
vfio_msi_set_vector_signal() through vt_pi_start_bypass() to
kvm_make_all_cpus_request() with local IRQs disabled. The trace then showed
three reschedule IPIs from kvm_make_vcpu_request(), with no SMP function
call in that callback and no warning. Posted-interrupt updates occurred.
Three more VF reload cycles passed bidirectional traffic after VF traffic
became ready.

On an Intel UCS C240 M6 with the same test kernel and patched kvm.ko,
irqfd_test, irq_test, vmx_posted_intr_test and smptest passed. I restored
the original KVM modules on both hosts after testing.

One source-review question: should the direct IPI path check
cpu_online(cpu), as __kvm_vcpu_kick() does? The old batched helper filters
offline CPUs, while x86 native_smp_send_reschedule() warns for one. A
target vCPU could leave guest mode and its CPU could go offline between
the request check and the IPI. I did not test CPU hotplug, and this would
not imply a lost request.

Tested-by: Satish Kharat <satishkh@cisco.com>
