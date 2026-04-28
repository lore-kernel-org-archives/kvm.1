Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9923DDDB4;
	Tue, 28 Apr 2026 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381180; cv=none; b=DTAh6wjfVqZ81Ssye+bg9HipD1NA0LOd5v4/zCnE9AP2OlbzHEBOGYuDMaTXmM00wP0Wp60pbJEpldPn87KfiX/nAQyPX9rBk19lShVXvJkZn13LmJTUxJz4HGx9lNB0xXZzmuUKDRkdw5O8+NdVOy4d7D9XMVR+7S/yYtLgkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381180; c=relaxed/simple;
	bh=2TXeI4uza2yiAl404XMONMb9qZBCxAkKly4i8bsSAxc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PL4WsUkoT0iryHeWCkKBcLDAyqnuZ2hylNzNZsSvEQNbFQg2yO3D7IVz14shcKeOCcvPTAvhH+EH15KSoJs9KXb29wxih0FppsoZDc61UYHWNWpDbhC2lPxeA/670v1e/wUP3Sf1+jO44Zd0vNazibr72WVJ8bqsJHpihl58RqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxDuo0r_BpusIEAA--.15595S3;
	Tue, 28 Apr 2026 20:59:32 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAx38Ixr_BpapJ2AA--.28242S3;
	Tue, 28 Apr 2026 20:59:31 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: KVM: Cap KVM_CAP_NR_VCPUS by
 KVM_CAP_MAX_VCPUS
To: Qiang Ma <maqianga@uniontech.com>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260428121813.296781-1-maqianga@uniontech.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <0b8db33a-6c26-d9f5-b78f-d9249dd02c1c@loongson.cn>
Date: Tue, 28 Apr 2026 20:56:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260428121813.296781-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx38Ixr_BpapJ2AA--.28242S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XF15Jr4DtF4rGrWrXF4kXwc_yoWDGrg_Ww
	1Ivwn8WrWkJan7Xr1jqryfG3Z3X3W8XFZ0vFn3AF17Wa45XrW5Zrn3Was8Ary8trWrur45
	ArZ8trZ0v3sFvosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
	UUUUU

On 2026/4/28 下午8:18, Qiang Ma wrote:
> It doesn't make sense to return the recommended maximum number of
> vCPUs which exceeds the maximum possible number of vCPUs.
> 
> Other architectures have already done this, such as Commit
> 57a2e13ebdda ("KVM: MIPS: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS")
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>   arch/loongarch/kvm/vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 8cc5ee1c53ef..1317c718f896 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -125,7 +125,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   		r = 1;
>   		break;
>   	case KVM_CAP_NR_VCPUS:
> -		r = num_online_cpus();
> +		r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
>   		break;
>   	case KVM_CAP_MAX_VCPUS:
>   		r = KVM_MAX_VCPUS;
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

