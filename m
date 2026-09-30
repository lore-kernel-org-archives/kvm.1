Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085944C4F58
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782000; cv=none; b=BrzH9MRsy9YcgQF30+nQiROxhztXLDr7rnibrpxJQddXhS1/QPy/s8iMXaHTKOC4w5rtJCnk7/jkcLg6lZHJXueUR9pBI1bsIoDnFQbQPs6cW9pnGTgBDSdFCng5/mS4R+IzPJszSgO+W7nIuzRFwWqvq6iKAckB7Jxt91XkOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782000; c=relaxed/simple;
	bh=CmJey6zW6gZQHUwSRtJfbdEySzFFefHFLUZjWb5UfHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3M6UQ2xLJ3W6xJHZnb9y4hz5iwu7hfba3PKdfekwv8RnfXHmUoorN5ygXwC7WLO76S+4UcGX3EqtDIvg7rnZTxwFxcLxODpV4TRXwwP6poMwPLtEEieZrIO4u2hLCJf3ZoOwP94ovdrKFjS5j8X66gBZk6kffR2RyMeQyNtZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kJjMe/Ew; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJjMe/Ew"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac768bda6aso5814735a12.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790781986; x=1791386786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jTz7JFysavVzx+3a8DoDd2wDpfretAnN3j2Hpag3BAM=;
        b=kJjMe/Ewi883Zr55hLAReTogAxTfTn9oA3HHmS2btoN6cAAiFHXJ151GyKOxyFOGpg
         IHOG2KUqY6476g4V6DPbRXC0XPHHiZ9a56P7CRDOltWqXs3aflIuuFCSFoJ3uP/ehfi/
         hhNpcDagGVTMzjl3ZEfg86hjUSjzc+WeKIAyA01Ie8gqa408VWLnN+dfU9LvzAnWEEDD
         KRx5IR9+i5myf1C1ixhQ349cV2QYlcCXs1y9BNWHD1AEFL296/+wzAjz6cquFxFxTBSG
         yDRzZ7tFyZKQe62/ERYBGv5qnSrtRDvFRnwhwvFP93gCO7hyBiLjQV/cVjbqOJdMql2i
         PanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781986; x=1791386786;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTz7JFysavVzx+3a8DoDd2wDpfretAnN3j2Hpag3BAM=;
        b=WZKy75DoJVlHsewdU/9kBoMJ7LwzNgbVGlVXtJWJYh494JKqxeb1nET7hM0Xi5Jwo5
         iXPO7dywmG5oZCVppI0g4g6QmVmA/RaQy4YqciX64nfw7M/4QFxCQWI3bfglKz0KCeTq
         0PTzG2jYaA82sTUJQjSIcz0Wl9rfF6jVQhEeKz6UHzUk/TBJ2Gd+VZwAf5Ql3NLI1iL+
         r9ZsTkfXrb5lkzUeSW79r/pbyy3KnJOJmQdPWYqfirhoTAM5xIfvJHmcYsgLeqVZZNMi
         ty7kw5psfXVO6fi1U4712AGq+sZOcn2dhV49CLZmvSHMl933+uWzaB32P5SxGlpWmMxp
         Uksw==
X-Forwarded-Encrypted: i=1; AKwUvBz1fLajtoJAnp3sxX6D76zbZwj4RrPcTPGPDTkWW+E8Ywg2OfDSwvI8vPF+HeNVT9PMJF4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIh6hKVqF/hXWoAPP2laxJVuw0krbDmefGkaQBPu4//vgUkSnBT
	YIE6IHJjQOTqQjFC/7xfBjDjvv6o7VNq1N/m6Pw/AdZHfqCG64kQ0ja+OVo3yyA0DdA=
X-Gm-Gg: AYBFou0NHgvBKkuwaBMMWFaNJpusA9bLfSQ3wyKi4om9vD7QCFgk76sXUrs8al05Apy
	DL6xtZXGQ7nAkYunpnhoeiQ54eHsNrztueWV2eBImHj5QyXDMYrvC6634mCPJDeqQzp0imOVSI4
	0SrsZDB+KnhQzzpJpoGFihLWKZ4HVQ8/YBH7+0750aCE5aURoMoR+7D6cHi3sU3fkr6NjIwORNc
	kzDnO7EYOJ4g+MmSxeXWprAXlQ4gcapIj8NWwYduaAzq22ywNtevBW2jPgJre+nTzxSDPnpXZ+y
	SY6ATFAmDqKc/RaM3rv7dJ692KoQS48t/lh3QTvCqMhEDpFVmmXQEqi90pCltIlK5a4u/AU+5WF
	Tmg8S7srL2Yn7tzxE9cwUvcvblGt1PGcQ47MplhGbMIiB+SCitGcHs4JwFOezC8N0Pz1F0jO5dE
	DSiE0mLCgVqOYqic8xYxmdimWL5qcLkVv9fZEsIBuQ9/k0EI4CMa2MvC+zQSZ8mHz/OIkwNRicf
	XI=
X-Received: by 2002:a05:6402:46d0:b0:6aa:f187:26b8 with SMTP id 4fb4d7f45d1cf-6ae1994fe10mr1077601a12.37.1790781985959;
        Wed, 30 Sep 2026 08:26:25 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1568e8b2sm954439a12.19.2026.09.30.08.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 08:26:25 -0700 (PDT)
Message-ID: <5750151d-cb99-4f9d-b469-12a7b7796985@linaro.org>
Date: Wed, 30 Sep 2026 16:26:23 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/22] ARM64 PMU Partitioning
To: Colton Lewis <coltonlewis@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Zide Chen <zide.chen@intel.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Mingwei Zhang <mizhang@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20260924172928.2110956-1-coltonlewis@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/09/2026 18:29, Colton Lewis wrote:
> This series creates a new PMU scheme on ARM, a partitioned PMU that
> allows reserving a subset of counters for more direct guest access,
> significantly reducing overhead. More details, including performance
> benchmarks, can be read in the v1 cover letter linked below.
> 
> There is no longer a kernel command line parameter
> (`arm_pmuv3.reserved_host_counters`); PMU partitioning is now completely
> controlled via the KVM API using `KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION`
> and `KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS` vCPU device attributes. When

As far as I know there isn't a straightforward way to get the number of 
hw counters from userspace. You have to either parse dmesg or attempt to 
open incrementally more counters in a group until it fails.

This makes doing things like "use all counters for guest" or "reserve 
two for the host" difficult. Maybe it's time to add a file to the PMU 
that userspace can use query this.

