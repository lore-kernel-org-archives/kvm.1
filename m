Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08831EF39E
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903431; cv=none; b=f6KO13T5nfaP7WkUe4POlc0DicHhyZmbCMfkia6stX8CbgwyiS/GcjGfgqJr0TMMo9X/ikW7OuLot8ttbuCNNF/Q6j0ARU4rPUFfsXURIeNLD5I0zo+Bs8uqaAfia3+if4qSq9GeNs32DDoFBwCy+diYYysE88uZ7BY7I3cdZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903431; c=relaxed/simple;
	bh=jpHuujcW5pJIxOYvK+c6dXMCFGiTtjQVWbZjnUWHqQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1cP4e+XqMf3CEQQhKjkN+hA4LqUdpOD59X2EWqLlZoCH1FTwXODp0aQNNOwVn6G299YWm1MxL1Qn0jHih4U9cZgPCd1D8yQQy939pNIjCbO/otTvpcphyp3EKsA/8kxUOtCpZswvOgFpexstgPdkKaDHLSrZZV91cg47I90DX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+nKWTpw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OitUPpFH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+nKWTpw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OitUPpFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783903428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcmQ/kaPfeKQ7YJOUmwuqtIspVQgNQK5b+PB69aVoBY=;
	b=Q+nKWTpwVL4dGfJgpPQZrvo+3eVuvMDOY+ELfR0qvsHzxtewgEyJ0LZ9TQMz8iAmmGBlWw
	SLAfvDqmWknJ2+Fd2r4+KLsoNIGikW0Ab3n/XJAanT5Nat6anWl+8cq4Kf6RgeqfNRmi/N
	jU8RRGgSpEIjACDEGgyF4xske2/BPxM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-wBLIcssdOg2G1CHm8gVNlg-1; Sun, 12 Jul 2026 20:43:47 -0400
X-MC-Unique: wBLIcssdOg2G1CHm8gVNlg-1
X-Mimecast-MFC-AGG-ID: wBLIcssdOg2G1CHm8gVNlg_1783903426
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so1817440a91.0
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 17:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783903426; x=1784508226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZcmQ/kaPfeKQ7YJOUmwuqtIspVQgNQK5b+PB69aVoBY=;
        b=OitUPpFHDsdukY7h2MXGGv/bCdoe8R/kvazHj/SvsldGYsvxYXkyDWaCJR+BuEdQpy
         uviNcLLS1ekOUCqXqqtTfxOQJ0POso1cdmno3FeCyYq/5VGVzcsOIV7ZpMD9aukQpq9Z
         KTcM0E5MR5SGs9yAwxwnq1XCT4SE+HIdohLZ8W+x7mttfm7dIGOm9NdxLXoOwU1jfRoA
         lyTI4HhMZZA35LBNlF82mbgtW1AVr1p/4VotdDWGVHUNnDrdIXRRaBsWuHNYslaa4yIs
         Y9HJUlIqypZoui0r5B6OZY4zCoPCxNcs/tRPN17mgqc4vmtMLO1ExjE85EgMxJbXbJPy
         9QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783903426; x=1784508226;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZcmQ/kaPfeKQ7YJOUmwuqtIspVQgNQK5b+PB69aVoBY=;
        b=q899Gpq+sHifsx0T7IGrQqF/Dc2OW0jBkaUcFQ/2yYSSrECD6B1NGLf38V5aiJfZQe
         8UZRCZEpE4CdoU/wOkJx/wF/PjKHJiWPA03cnS4oSjs2cTBA5Q1hyxvE/x4AtdvFawki
         rXxZ194Iym4MfNqbCL1skPPH2bCvTTz7Kri8ieVOucl/COSli7weA2ss2WaVm5J02GxL
         lWykdRRcjqj0U0A83ceHgKFix5v/zLR2FlJHNAZt6xmF8LbxXHgjVbE/lagilgEgdEiy
         f1vFvbnAW6gUdI5VJX6J8BM1emnVitEjNaMDtI0iaDkWsfiFtNyAkyZVp6bd5BjrzbcL
         XBOQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoEZQ9a1tWVuy0pxQwpudsB0Io6H2rnvMjaHL8XYDrU+I6XQlWBb090pTThojmVeGs5Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LDbjmy9cBsyGmkAZ8BQ9XOKDJgyfNJwpcH49s50nV9QHHtwA
	w3CH/reiECoPCi5pJW3u6lgrs8IBxQMH6IEObKD3WPwaDFiB7GNwgU4lvjGq7/LPjH3r1wW4gGJ
	QXwsTwyV+gp40j7Zp1l097r0cZQklAbR0M2Nn3hNtEknmUxpg9f/8VA==
X-Gm-Gg: AfdE7cn/SpoXENidACgoi9hZgge6257CduSXn0QnnqmuLfeT3NsLaSFWfy49hP+TKLD
	UMM30CAQkb9Ud9WmWyBbz3JVUFOvuE48PK2Hof/nG0krGEXvAbrDfUI83icJE4Ke3TS2UQsjtG1
	x82P7APwbNHA5LkOTMCT9/3JReiYC8rI82Ebv+WLtVgH7CLBiVSOLOFb1lmnoGE3CjCDU9kPngY
	rLqGYd7qe0vjipENA1N2A0punLArvZcTQ+cXMtBe49ua4glbIibLl0QnBtPAaAAW2T1ZGdG68ez
	oB4qi+3IFiWu3Tfns8KP+kSFGCSU/qPTuWCeDMSXrD3vgUQDDNFbCsFe/+bwcRLckDeOaB7pOTg
	dfOU9Gt1Vjnyrv3gaCVqABr7nYwkotAi34Lf+GTaPXcegxlekmFjCTA==
X-Received: by 2002:a17:90b:2248:b0:37f:fd70:6790 with SMTP id 98e67ed59e1d1-38dc81c1b09mr5083862a91.9.1783903426252;
        Sun, 12 Jul 2026 17:43:46 -0700 (PDT)
X-Received: by 2002:a17:90b:2248:b0:37f:fd70:6790 with SMTP id 98e67ed59e1d1-38dc81c1b09mr5083849a91.9.1783903425797;
        Sun, 12 Jul 2026 17:43:45 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38d2fdd777csm3075407a91.1.2026.07.12.17.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 17:43:45 -0700 (PDT)
Message-ID: <3ac5a5b7-e41d-499e-a4d2-e9a5a78f8c0c@redhat.com>
Date: Mon, 13 Jul 2026 10:43:37 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 08/25] target/arm/kvm: Use kvm_vm_check_extension() where
 necessary
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-9-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-9-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> The Arm KVM code can return different values from KVM_CHECK_EXTENSION
> depending on the VM type. Use kvm_vm_check_extension() where necessary
> to ensure we get the right response from KVM.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

I'm putting a note here so that we won't forget. The following changes are needed
so that capability KVM_CAP_ARM_NISV_TO_USER won't be enabled for realm guest since
it has been hidden from the realm guest in (v14) host series.

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3d5e16a21c..4c52ee7e1b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -623,7 +623,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
          return -EINVAL;
      }
  
-    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
          if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
              error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
          } else {

> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 6aa1cd04e484..c69b5310c184 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -328,7 +328,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>                                1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
>       }
>   
> -    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
> +    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
>           init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>           pmu_supported = true;
>           features |= 1ULL << ARM_FEATURE_PMU;
> @@ -654,11 +654,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           }
>       }
>   
> -    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
> +    max_hw_wps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
>       hw_watchpoints = g_array_sized_new(true, true,
>                                          sizeof(HWWatchpoint), max_hw_wps);
>   
> -    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
> +    max_hw_bps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
>       hw_breakpoints = g_array_sized_new(true, true,
>                                          sizeof(HWBreakpoint), max_hw_bps);
>   
> @@ -1905,7 +1905,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
>   
>   void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
>   {
> -    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
> +    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
>   
>       if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
>           if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {

