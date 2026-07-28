Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55473B5843;
	Tue, 28 Jul 2026 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242360; cv=none; b=SBFHnOomqUIlhx8nPOgZ7DlCUWRSdYMrAHwlqT+igh7xMIunjiVoVD7kSR+ENsO4dl/LC1x9tuOnjNhXF4HaULRtPehC5vjCKDGM4qg1P8Yg6VzZnrG5vOx0udgpHX02oAT2mRoLmaXeJcd/zhx2Oo9s1bcmDlj+kF0lwMG9Kwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242360; c=relaxed/simple;
	bh=BB/iNYIWb4K37ubQH44SrWBVyo1MmDQe/KwE3U3XcKY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TnSINXmDzqGoNyb9Xwyh+o/C5bckEMo4xNUYG/jlLaRCptrcVszf0THeqVlZVnaBN1dcUCrM5QdCs0cxGD2eN1mcAgBkk5QXwO1XXkkMGzJ0sy2pXN7nAQdfms+iHz1VIrpOX23ux7GgrknaUgmSQDLY0k9E6APk0q8t94FSvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxGOvyomhqkh8IAA--.28372S3;
	Tue, 28 Jul 2026 20:39:14 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxb8fvomhqRJ4bAA--.18382S2;
	Tue, 28 Jul 2026 20:39:13 +0800 (CST)
Subject: Re: [PATCH 2/2] KVM: LoongArch: selftests: Add in-kernel MMIO read
 fast path test
To: Zeng Chi <zeng_chi911@163.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: zhaotianrui@loongson.cn, kernel@xen0n.name, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, zengchi@kylinos.cn,
 cui.tao@linux.dev
References: <20260723111605.1630027-1-zeng_chi911@163.com>
 <146b5e27-2ab0-da17-7b98-09235ef4f9c4@loongson.cn>
 <CAAhV-H7pLEUeKWGmCZqDdF+2vr=2aexOFVCMa_UxTrDpUY+gvA@mail.gmail.com>
 <92289f9a-67be-4839-8fe4-c6935871a349@163.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <2663aa71-f713-c458-368a-61fdb9634338@loongson.cn>
Date: Tue, 28 Jul 2026 20:38:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <92289f9a-67be-4839-8fe4-c6935871a349@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxb8fvomhqRJ4bAA--.18382S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF1UAw4UWFWrCF45tr4UJrc_yoWxAFc_uF
	WDC397Ca1DXF4rXa17KF10vrZ3C3yDX34rJw48Xr4aq343tr4kJFWfGrnavFsrtayrtFnI
	grnYvr4S93W29osvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8q2NtUUUUU==



On 2026/7/28 下午6:10, Zeng Chi wrote:
> On Sat, Jul 25, 2026 at 5:41 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>> I think the fist patch is just enough. :)
> Agreed. Please just take patch 1 and drop this one -- I will not
> resend the series.
> 
> Bibo is right that the test only asserts that the PC advances by one
> instruction, which is an implementation detail rather than observable
> guest behaviour. If a PCH-PIC selftest is still wanted, I will send it
> separately as one that injects an irq and verifies the guest actually
> takes it.
It is not necessary, just patch 1 is ok.

Regards
Bibo Mao
> 
> Bibo, Tao, thanks for the reviews.
> 
> Zeng Chi
> 

