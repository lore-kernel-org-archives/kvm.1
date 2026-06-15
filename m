Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98793D9689
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515150; cv=none; b=gqcmaO76agqYfxIlsGXDYRvHIDXxMSpfS4ibGs3GGWrXYLUqN3STT7Lh/E9ovSJQt653i/YjAU488bCDaoMxv4fiD9N6lkEcuByUiGa6raTbpHQ6mUanOLfyxVR9u5l93bXgqLMMUvRJUGS1ab9lLR7AUH1m7YVYfUZkTmg133M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515150; c=relaxed/simple;
	bh=h2P8X9WQjmvg4Ib1tLmvEjiv+0EZjlvFPrzeyo3Sy9g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BAQNsrFWUDi91UAixaVGaPlZ4Vdl3+iRP0A3sZjjEC9Ol0vANqhbDxOyntc7i2XxPvTTvTnoHuqjtt2jDxp4Zl4j1wXfj88z8XQ2X4hHbgvMrTer+0zcwcXAufQR5N/fIar28xA6O/Z91EMQM9OVAwJpdFzElYZprhglKmOrXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8Bxt3iFwy9q50gUAA--.28515S3;
	Mon, 15 Jun 2026 17:19:01 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by front1 (Coremail) with SMTP id qMiowJAx28GBwy9qLPumAA--.53901S3;
	Mon, 15 Jun 2026 17:18:59 +0800 (CST)
Subject: Re: [PATCH 0/2] target/loongarch: PV TLB flush advertisement
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>, bibo mao <maobibo@loongson.cn>
References: <20260615085214.44526-1-cui.tao@linux.dev>
From: gaosong <gaosong@loongson.cn>
Message-ID: <636afc5b-968a-3027-8683-21df1c14838a@loongson.cn>
Date: Mon, 15 Jun 2026 17:20:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260615085214.44526-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJAx28GBwy9qLPumAA--.53901S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrZF4kAFy3WFyDXFykZF1DArc_yoW8Jry3p3
	y7ZF15Ka4rtr97C3Z3ta17WrZ8ZrWxGFsFva4Sk348ArsrWr1I9ryxKrn7XF1DA34rWryI
	gF1rAryY9F9rZ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOa93UUU
	UU=


在 2026/6/15 下午4:52, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
>
> Advertise the LoongArch paravirtual TLB flush feature (KVM_FEATURE_PV_TLB_FLUSH)
> to the guest when the host KVM supports it.  This pairs with the corresponding
> KVM/guest-kernel PV TLB flush series posted to the kernel.
>
> Patch 1 syncs the UAPI definitions into linux-headers.
Hi, you should use scripts/update-linux-headers.sh  to update the 
linux-headers.

Thanks.
Song Gao
> Patch 2 adds the probe, the CPUCFG feature advertisement, and a
> kvm-pv-tlb-flush CPU property (on/off/auto, default auto).
>
> The feature is only advertised when the host actually supports it, so a
> guest never observes KVM_FEATURE_PV_TLB_FLUSH on a host that cannot
> service PV TLB flush requests.
> Tao Cui (2):
>    linux-headers: Add LoongArch PV TLB flush definitions
>    target/loongarch: Enable PV TLB flush advertisement to the guest
>
>   linux-headers/asm-loongarch/kvm.h      |  1 +
>   linux-headers/asm-loongarch/kvm_para.h |  1 +
>   target/loongarch/cpu.h                 |  2 ++
>   target/loongarch/kvm/kvm.c             | 38 ++++++++++++++++++++++++++
>   target/loongarch/loongarch-qmp-cmds.c  |  4 +--
>   5 files changed, 44 insertions(+), 2 deletions(-)
>

