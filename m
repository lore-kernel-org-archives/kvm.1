Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5940627C
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541621; cv=none; b=elI1esEjJKZgkp4VnyM3UGprit/3tXh5JjxzazuMsSZEBjaQVIFkGZ9uYJNLJkkCcPhrYZXGfs4JvCoKJv4dkxiI/4baWBhB5sBtI4fMoEAHkzHD8Zr/0Y9l30n16Lv+7WCYpLm+LIhVzKd8Ugt2wq2s2lw4WAGsr9Muw9VhscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541621; c=relaxed/simple;
	bh=vHwSlD9/P3shMuKdtN2uo3VaT0321Z6u8H9M1BOMVXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=friFIz+7zk5OZ0cADBqO5WwQn0nwxHmdh8Tki9uqxhD/T3/hUmH8MriXW5Lt5uJlTyYq/WYP/alfpbd32XA2D/s77tNDTsCcmPIAMMFNewYUNybBw7GnbbzHViyQA/uQffl3rFMP/5OCS2KTU123opddFGTAH9Jn+Tz+z40Vzn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTEDuYzN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTEDuYzN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774541616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IcNdKFMqicaUbMZIA/K+36eC5oa2UieOgzSoD7f4QE0=;
	b=ZTEDuYzNd2ft/6PWNpI+FA3E0c5rQIGuYyyptmbLA3P6R3ZAIkD0wkelHuSUYSAYdUK/ld
	3dyE9SqEBSbnsup0XJDQP/usDITKaVqE7HbYFv6hABZMziMCMdbIUon56VEVKRaxM6834K
	9bOAHX1GjG7yIxei34PMGugtVn/j9QE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-hbMjby0pNeyL5I8hP6PzEQ-1; Thu,
 26 Mar 2026 12:13:33 -0400
X-MC-Unique: hbMjby0pNeyL5I8hP6PzEQ-1
X-Mimecast-MFC-AGG-ID: hbMjby0pNeyL5I8hP6PzEQ_1774541612
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C71B519560B1;
	Thu, 26 Mar 2026 16:13:31 +0000 (UTC)
Received: from [10.44.32.183] (unknown [10.44.32.183])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6EAA1955D84;
	Thu, 26 Mar 2026 16:13:29 +0000 (UTC)
Message-ID: <0c3f5ab5-05be-4ef4-b16f-84e5f27fe540@redhat.com>
Date: Thu, 26 Mar 2026 17:13:27 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-unit-tests 8/9] x86/vmx: run EPT tests with MBEC
 enabled when available
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Amit Shah <amit.shah@amd.com>, Sean Christopherson <seanjc@google.com>
References: <20260326145035.119519-1-pbonzini@redhat.com>
 <20260326145035.119519-9-pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260326145035.119519-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 3/26/26 15:50, Paolo Bonzini wrote:
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index 023512e6..bf03451a 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -1044,6 +1044,8 @@ static int insn_intercept_exit_handler(union exit_reason exit_reason)
>    */
>   static int __setup_ept(u64 hpa, bool enable_ad)
>   {
> +	u64 secondary;
> +
>   	if (!(ctrl_cpu_rev[0].clr & CPU_SECONDARY) ||
>   	    !(ctrl_cpu_rev[1].clr & CPU_EPT)) {
>   		printf("\tEPT is not supported\n");
> @@ -1067,9 +1069,13 @@ static int __setup_ept(u64 hpa, bool enable_ad)
>   	if (enable_ad)
>   		eptp |= EPTP_AD_FLAG;
>   
> +	secondary = vmcs_read(CPU_EXEC_CTRL1) | CPU_EPT;
> +	if (is_mbec_supported())
> +		secondary |= CPU_MODE_BASED_EPT_EXEC;
> +
>   	vmcs_write(EPTP, eptp);
>   	vmcs_write(CPU_EXEC_CTRL0, vmcs_read(CPU_EXEC_CTRL0)| CPU_SECONDARY);
> -	vmcs_write(CPU_EXEC_CTRL1, vmcs_read(CPU_EXEC_CTRL1)| CPU_EPT);
> +	vmcs_write(CPU_EXEC_CTRL1, secondary);
>   
>   	return 0;
>   }

This is missing a hunk:

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 023512e6..b5994719 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -4886,7 +4946,7 @@ static void test_ept_eptp(void)
                 report_prefix_pop();
         }
  
-       secondary &= ~(CPU_EPT | CPU_URG);
+       secondary &= ~(CPU_URG | CPU_EPT | CPU_MODE_BASED_EPT_EXEC);
         vmcs_write(CPU_EXEC_CTRL1, secondary);
         report_prefix_pushf("Enable-EPT disabled, unrestricted-guest disabled");
         test_vmx_valid_controls();

and possibly this as well for consistency:

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index b5994719..cf1022ba 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -5068,7 +5068,7 @@ static void test_pml(void)
  
  	primary |= CPU_SECONDARY;
  	vmcs_write(CPU_EXEC_CTRL0, primary);
-	secondary &= ~(CPU_PML | CPU_EPT);
+	secondary &= ~(CPU_PML | CPU_EPT | CPU_MODE_BASED_EPT_EXEC);
  	vmcs_write(CPU_EXEC_CTRL1, secondary);
  	report_prefix_pushf("enable-PML disabled, enable-EPT disabled");
  	test_vmx_valid_controls();

Paolo

