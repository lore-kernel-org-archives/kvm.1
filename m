Received: from isrv.corpit.ru (isrv.corpit.ru [212.248.84.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697923E3178
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.248.84.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848812; cv=none; b=ipcfB8Swoc46bYQbhdagj9nY01Wim0YpPqLen6bHCGGpw3b8Prygv+aY3awLjP/Cl64IuO4P2WP6opptuAynuxRHEzGsWnMXpE7VyUA4w/pc9PluplfFNgalkqp4NnaNiceflBDFlIabHovCxytT7j2A2bs8kvcFn8DsacLuRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848812; c=relaxed/simple;
	bh=QBZ6t4yffJ51hIWvfXtARjGTROZJoGAvjy+m2Mb/sds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5zj7ElVA7upLbcP2uC5NfkcNwjjETJ0NPniWHS/IzlWXi3G6WWiHQCond6UD6nI9N+qY1JQ3hn57cXpHjNndrSd4C77yDIymECWi2cNKOAXExlhZqm40nFW5S3msUc+LpiS1fSTANJ34OtX3YezgHatXxr9uwvA3DUQQzcPaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b=t1aoSkc2; arc=none smtp.client-ip=212.248.84.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b="t1aoSkc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
	t=1790848804; bh=QBZ6t4yffJ51hIWvfXtARjGTROZJoGAvjy+m2Mb/sds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=t1aoSkc2lFMiTYLe6hblQqQZM/8yR31xVXzUURIDkDLz7nM8Wa8EvvcJT7MRoTqWS
	 KtT+xZ+6Rhn8Qlr071FraP36k0Uqs5DFOFMqswOQB66rQUa/aEADkyR+6vuwaJ8YIK
	 fGQcnB9ddDQrEx4Ifingv7j18fBkL1jgg+931rQUMFVw4K5v/Q76wAOEgS4hNVSrK6
	 1tFABmGWj238fi2pcIB1svQJAreGUB3jbZ4ANQ3AIlAayFAekR+9u4BaQjgKKlE2WV
	 YMjcdFPnziYs982ig+up6wvzbh08EE8xYe9NB+XJCMPknzSwM/5dqbzStnd8EQAF8t
	 Tv4EmyihPIiwA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id D04D51DA207;
	Thu, 01 Oct 2026 13:00:04 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id 009784381AA;
	Thu, 01 Oct 2026 13:00:03 +0300 (MSK)
Message-ID: <18ff5158-a515-4659-8388-5bcc074afb94@tls.msk.ru>
Date: Thu, 1 Oct 2026 13:00:03 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
To: Sandipan Das <sandipan.das@amd.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-2-dongli.zhang@oracle.com>
 <81a1f791-37ef-4d26-bcf7-024eab4cd810@tls.msk.ru>
 <fa8b40df-a35c-4ae3-8eaa-b4b65c546a91@amd.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <fa8b40df-a35c-4ae3-8eaa-b4b65c546a91@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 11:54, Sandipan Das wrote:
> On 01-10-2026 14:02, Michael Tokarev wrote:
...

>> When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
>> guest enters tight CPU loop while displaying a boot screen, before
>> it starts showing up the rotating circle (which shows boot progress).


> What happens if you use "-cpu EPYC-Rome-v4,+pmu"?

With that, it boots fine, just like before this patch.
I checked current master too - same, +pmu fixes it.

Thanks,

/mjt
