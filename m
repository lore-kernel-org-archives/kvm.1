Received: from isrv.corpit.ru (isrv.corpit.ru [212.248.84.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0254A6CE5
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.248.84.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844132; cv=none; b=Gh30EyPzLoZO3a6Hp0Kk9hQyFAGrzcViwONf76G2IVWENHooX17iksIxuTXB8UwSYvJzZKTXdNHGS1wSG2Ip8jF8Xi5EKOzuIQ44tvoR2d056wKeh8loCa06Jzh+jwA37MQ3pI8VYPUpT0hV1Afk645JcSJ3bN+EhBVF0195hrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844132; c=relaxed/simple;
	bh=blwcTsKC+DBZq22o4sHu7IF+o3YodsW0Cq6OuhFW0Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNoptpLYaVXiEXn9Qt+FpiNVpP6YmNEhQ9wEcjm/ENs85Nh+eoFzGnPgiGU2hdiZ9JgFd9w6ARD7NX8yLvNbmQqNty7AS5yuxiUk/IGGNlC3jAgsHXp62DRAdKlrdlKPrkybQk01D9B/fg9CfFmCmi1C//JMV95gihuap1Gd/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b=OuML2p8T; arc=none smtp.client-ip=212.248.84.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b="OuML2p8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
	t=1790843535; bh=blwcTsKC+DBZq22o4sHu7IF+o3YodsW0Cq6OuhFW0Pc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OuML2p8TP1ZJjd2JyZ0rRxQJc17rQ8nAOWYyk2y1myVCOJWgwQioYa7Kt8EpWu8/k
	 buujzJQlI+EIKPoJOw9OC6Z+yz0UvNmgDWt+4UL5/3E4RyTsHZP5rryXTmYXhHcBGJ
	 qi9btg5HOX51uUJjKyDd8egtDpaG7+HLPhQbtz3Sr6m5BKdzqqh9xE0UpPvn1x05PB
	 +wKwBWi/uPWeKi3XE+ZutmYdL3QJirEojyu2vCRmuM3VKUsQ8wa7W7Eci6TDhSjBEs
	 lJshArdxPNvi+a+Bt78ToWtUxAPxHqVcPDwK3xVcQtpe3ilJpr1dHia4QJd3pUYINE
	 iNT3kegJWb15w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id A314D1DA1B4;
	Thu, 01 Oct 2026 11:32:15 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id 12366438136;
	Thu, 01 Oct 2026 11:32:14 +0300 (MSK)
Message-ID: <81a1f791-37ef-4d26-bcf7-024eab4cd810@tls.msk.ru>
Date: Thu, 1 Oct 2026 11:32:14 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-2-dongli.zhang@oracle.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20251230074354.88958-2-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/25 10:42, Dongli Zhang wrote:
> Although AMD PERFCORE and PerfMonV2 are removed when "-pmu" is configured,
> there is no way to fully disable KVM AMD PMU virtualization. Neither
> "-cpu host,-pmu" nor "-cpu EPYC" achieves this.
> 
> As a result, the following message still appears in the VM dmesg:
> 
> [    0.263615] Performance Events: AMD PMU driver.
> 
> However, the expected output should be:
> 
> [    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
> [    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled
> 
> This occurs because AMD does not use any CPUID bit to indicate PMU
> availability.
> 
> To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
> when "-pmu" is configured.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

This is commit 4f0dd09e61b080c27589fe35b575503783c5a256 (v10.2.0-1114-g4f0dd09e61b)
in the master branch now.

This change seem to broke booting windows 10/11 on an AMD host, in paticular
with -cpu EPYC-Rome-v4.  It were initially reported in debian qemu bug tracker,
and I verified and bisected the issue on my AMD desktop machine (which is AMD
Ryzen 7 5700G, Zen 3.

When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
guest enters tight CPU loop while displaying a boot screen, before
it starts showing up the rotating circle (which shows boot progress).

Before this patch, it boots ok.

There's no other fancy options, just

  qemu-system-x86_64 -m 2G -enable-kvm -cpu EPYC-Rome-v4 -smp 2

(I'm replying to the original email message with all original recipients,
hope it's okay).

Can someone please take a look?

Thanks,

/mjt

>   target/i386/kvm/kvm.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 7b9b740a8e..c98832f423 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -179,6 +179,8 @@ static int has_triple_fault_event;
>   
>   static bool has_msr_mcg_ext_ctl;
>   
> +static int pmu_cap;
> +
>   static struct kvm_cpuid2 *cpuid_cache;
>   static struct kvm_cpuid2 *hv_cpuid_cache;
>   static struct kvm_msr_list *kvm_feature_msrs;
> @@ -2080,6 +2082,33 @@ full:
>   
>   int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>   {
> +    static bool first = true;
> +    int ret;
> +
> +    if (first) {
> +        first = false;
> +
> +        /*
> +         * Since Linux v5.18, KVM provides a VM-level capability to easily
> +         * disable PMUs; however, QEMU has been providing PMU property per
> +         * CPU since v1.6. In order to accommodate both, have to configure
> +         * the VM-level capability here.
> +         *
> +         * KVM_PMU_CAP_DISABLE doesn't change the PMU
> +         * behavior on Intel platform because current "pmu" property works
> +         * as expected.
> +         */
> +        if ((pmu_cap & KVM_PMU_CAP_DISABLE) && !X86_CPU(cpu)->enable_pmu) {
> +            ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
> +                                    KVM_PMU_CAP_DISABLE);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret,
> +                                 "Failed to set KVM_PMU_CAP_DISABLE");
> +                return ret;
> +            }
> +        }
> +    }
> +
>       if (is_tdx_vm()) {
>           return tdx_pre_create_vcpu(cpu, errp);
>       }
> @@ -3391,6 +3420,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           }
>       }
>   
> +    pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
> +
>       return 0;
>   }
>   

