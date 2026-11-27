Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795741970;
	b=0g676j4bjYYcwTqKGJ+15oZgm4m75TWI/aYpdFW9+8m2lx+4X8hKThVFiieHW/++LM+J
	 brNBW5fOyk3rieU+Qm6/iwV3+KujWgrqYuBSJGeL+a0P1oQbhPkpLpsg8pG4mpxS498Nn
	 CkiULk54vXKhiC76TVGvSPaQ+Oga3WWFUPIPEP+tmDBqVMi32PZJhoP09n/jfm5Y34eyF
	 N9CuAz6iE8ECRDqSVNDXAYlP4Rf0ia4kXTR4CE9o4uOpUvGD7cG/p31rT9SxbuZEwtmG3
	 aAsdpXZ5RQc4xkkaFrNgaBo1jGjsq9v7lYXMPTlMKsFyfwlNM4VUH9wpVWPH+DWd2Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795741970;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=WL6jcyaBgXtjlwf2xKoJMQ4E9Qb5FW6oej1sKLlt6UI=;
	b=wsZbegxHIkYzvhfeuDUaPQraEnytKs1DYJkpwjNG0rIslMb3e9xG9BgXGq9LSIl3xjIc
	 IN0dvcB84/4io/HWV4lQ8MAV2YYkq9Caam5mhPnX8ZoAbMhnqXiojuqvOCFPrcjwzNG6D
	 OJcSsJ0NeYNpZkRKGEpJpFzCfw55zZI1ZIGkt/eMNOK7A+FM1sLpMINL8H7ysJT0oXxKb
	 LfST45/abdfw7AqlGys0tIk818xi+DjASAclyWBhJz92M4jiUGRmr5cWCiDmHlGicXtuT
	 8946sJGY/bwOma6XzKfBK43jAAnjPTJ6lZ1GS/FvbS+V5sA/iWhlOqEMWRZo6t3AtGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF77606A327;
	Fri, 27 Nov 2026 01:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF77606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxLNAI2Qhr2WcjAA--.7030S3;
	Fri, 27 Nov 2026 09:12:40 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJCxf88F2Qhr3ac3AA--.46655S2;
	Fri, 27 Nov 2026 09:12:37 +0800 (CST)
Subject: Re: [PATCH v2 0/2] KVM: LoongArch: selftests: MAINTAINERS coverage
 and a VM leak
To: Gokul K <gokul02k@gmail.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org
References: <20261126050352.1957454-1-gokul02k@gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <b5d4b059-6561-a68c-e00d-247566a081f8@loongson.cn>
Date: Fri, 27 Nov 2026 09:13:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261126050352.1957454-1-gokul02k@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxf88F2Qhr3ac3AA--.46655S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF13KF4kurW5Cw48Gr1fZrc_yoW8Ar1kpa
	yfu3ZFyr1vgFs7Ga1qk34jg3ZxXFnrJF1xZ3Z0k34Uurs8Zry8Xrn29r4DXa4DZ39YgFWS
	ga1Ska4Fga1DXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=

On 2026/11/26 下午1:03, Gokul K wrote:
> Two small fixes to the LoongArch KVM selftests. Patch 2 frees the VM on
> the PMU test's skip path. Patch 1 came out of routing it:
> get_maintainer.pl did not name the LoongArch KVM maintainers for
> tools/testing/selftests/kvm/loongarch/, because the MAINTAINERS entry
> does not cover that directory, so this series would otherwise have
> gone to Paolo, Sean and Shuah only.
> 
> Based on loongarch-kvm in linux-loongson.git.
> 
> Patch 2's hunk sits next to the one in "KVM: selftests: Convert comma
> to semicolon" [1], which is not applied yet. They do not overlap and
> apply in either order.
> 
> Compile-tested only. Patch 2 builds: tools/testing/selftests/kvm/loongarch/
> pmu_test links for loongarch64 with a GCC 15.2.1 cross compiler, using
> glibc from Debian's loong64 port as the sysroot. The binary was not run.
> Patch 2 changes the PMU-not-enabled skip path, which only runs on a
> LoongArch host whose VM config leaves the PMU off.
> 
> Changes in v2:
> - 1/2: also drop the lib/loongarch/ line, which */loongarch/ already
>    covers, so the entry matches the other arches (Zenghui Yu)
> - 2/2: unchanged
> 
> v1: https://lore.kernel.org/all/20261123100701.1679376-1-gokul02k@gmail.com/
> 
> [1] https://lore.kernel.org/all/20260428053204.1018608-1-nichen@iscas.ac.cn/
> 
> Gokul K (2):
>    MAINTAINERS: Add the LoongArch KVM selftests directory
>    KVM: LoongArch: selftests: Free the VM when the PMU test skips
> 
>   MAINTAINERS                                      | 2 +-
>   tools/testing/selftests/kvm/loongarch/pmu_test.c | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
For this series.
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

