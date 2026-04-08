Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D0033F8C6;
	Wed,  8 Apr 2026 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610599; cv=none; b=CAwdlIG4VhamkrN2AqIcoc2yjwFmxteB+ef8s1ptLTSR/gSl/I3cqhvIy1oAxXMZ2BbZixl8hlo8hKlpqWtaJWqFVFTBL81/ATKc4zr5x8cEVyhlQTPOGPY4wr3Me8mdWYCwG6++VRXz83QSoiMDQm4mncW19K/+YU3FtZh707c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610599; c=relaxed/simple;
	bh=1gsHnvKU9KJGYeO7GZF01k53Y8+2UNSa12/qjCAOAHk=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=L3MH64V+6E0t32aM5vYurOQCZWF/mYEpFTF68AHOdxnbXqAhlw+SO16LGLov/IMwsaMwQoxZxZ4MiRRhlA2QFLjc6at7qbakBTtLJ+lYxMxqlpX56Dy3M5VIVpLu9iastejHiQWn2aAFqSFnOzV15NxWSD5odw40hFKV5LbERUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxksDiqtVppfoiAA--.38120S3;
	Wed, 08 Apr 2026 09:09:54 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCx+8HfqtVphAFoAA--.1503S3;
	Wed, 08 Apr 2026 09:09:54 +0800 (CST)
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>
From: Bibo Mao <maobibo@loongson.cn>
Subject: Apply LoongArch KVM merge permission
Message-ID: <e82d080b-2616-201e-9e9a-bd56d1bf70d4@loongson.cn>
Date: Wed, 8 Apr 2026 09:07:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJCx+8HfqtVphAFoAA--.1503S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g
	43UUUUU==

Hi Paolo,

I almost submit the whole LoongArch KVM code for more than one year. 
Huacai is focus on LoongArch kernel, he is maintainer of LoongArch 
kernel, Loongson GPU, MIPS etc, and he is too busy and maybe cannot take 
much care about LoongArch KVM.

Could I apply merge permission for LoongArch KVM directly?

Regards
Bibo Mao

