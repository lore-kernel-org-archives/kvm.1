Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632C46AA6F
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426098; cv=none; b=jVF2/ts1VipYqDGUjuy9znTpFjKW6ISTfVPhX5bZ0h+Qt7ntiFsdEuUwKz2PWLGieNVtW2GwCCkfeOp3CcTz2CdMTVxGda6vB/sZZ/KgLWulWVVRnQmxDy6EtUtkn6+T+uTKbMthvTjvrWrgaXog0yhmwX69rFOHyESydwDLXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426098; c=relaxed/simple;
	bh=2nXT0f5RZLRaF743EggYbXpGuCAKYsn3JP143Xp+NtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fux9B3VHGzJ3a4R1bjf54Wojxp/doQ0Qm4dksLCsYfzgV8QE/0Pvu6Z+PsnOu/eu7pJWfoCmOemnQoX8fy+ygmdN2iNzCKXykmHIpRqTO0Fe1Js0kOvlS0Ad+/7fmDE00anmyb6gVJ60TTmeRr9ks9t4hYkraPYjW7sSNUHyrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWPHej1+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qYSCRBqb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWPHej1+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qYSCRBqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788426094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6zdnMxiwVoDJP+1f6BoagiRDK0hbRU1SKNVv/b+icQ=;
	b=PWPHej1+f/F1YGUyLqws42T2nXVROzyThGAwPtggQEuzI+LgsGM6YxvL24gj8/MFjjRTiN
	/dahgkaTukQMPf1uPZSorYA4XdyJXpOHwacLOFb9j2ACM6J7aXTkGLiz+pTq0nQG4Z829q
	z33dTuu5UePRtYAZrugI3PhNNpbYKzA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-YiguWcASOnyEQtlOIdsABQ-1; Thu, 03 Sep 2026 05:01:32 -0400
X-MC-Unique: YiguWcASOnyEQtlOIdsABQ-1
X-Mimecast-MFC-AGG-ID: YiguWcASOnyEQtlOIdsABQ_1788426091
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c25501f4aa2so113081866b.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788426091; x=1789030891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u6zdnMxiwVoDJP+1f6BoagiRDK0hbRU1SKNVv/b+icQ=;
        b=qYSCRBqbvhumrsqxTJk7g4PYlN18XACNPOjddk51XRhGY12UC6714pQku+GKV8sJ6U
         AXPy8E3UFb4vmpVFWef/LOy7PDoagFOW2cVQ8sIN+LIm6f5BoMIJQpq0qE/ZgU+pAwDy
         F8mcd75nrsEz0s8i4CmfEN5P3CC+Y6kq+JBw5Hse53Bbx7IUlm79vPvakyrbX2bYzDDI
         aCCEKZK1uSW7UTYo/gMekPkQleb3Z4EyWIk4SSvh9IzdwS4U1ZcdxbkzVkSEKsfCEwKN
         pZou9Ky9TH1G7M+iGOkisTnMnOw02a4HMo9FxkYYE7DviSSzWxworIUqhS4RMSR2bmQP
         cn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788426091; x=1789030891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u6zdnMxiwVoDJP+1f6BoagiRDK0hbRU1SKNVv/b+icQ=;
        b=jjEyZgMGcSSMf/zla838eCvBidxW6RelVrJq3zSW0cBl1QPbOG8fLTSBOEG43uTz+3
         pP1kvy7Ds1q92g51wWP4xxOObuad4Kjk6bwyjfMJWanXWeE0UpXjP+ASC4HnNazW12h/
         6Pw2vyfDxZZREPeWpdWKgOmi43ihjtztesZs5qGn/kQ8utjcUOu458oAa4xjjYPm2Rd8
         8fU5NLbrsPUykUJRsQDZZcR2u1FFQER3j7oNq4UQJfudprF5hvQBmy3eiOls2AWxtjJL
         b6oTJFGyB/vEtLhfAe2/24pRlPq+YhFbeHJh8W9WnjKapY8C2BLv7EDShPXxkONHYiVu
         0+Wg==
X-Forwarded-Encrypted: i=1; AKwUvBxkMOocYDNFH4ACCWx5PjXiIU0xMfqWQiQc0d63ve0s4QVt6IbCGS+JVY0Rm0p6QSbjo0Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mZZc0/qaCTw8kSEUoUqqh9FjGNjTcquEy5ZMABR9bBXQpTjaBz
	vzcisu7Xv71N0qyIz2CgmmIjw5f6oElnotHg9WZxAnmhW9he56/vDvpGTdJn2kRBweZQZF046Qi
	6WRegfeMk2eVUe7i4JHtNm324ZLDyIB5lpvL0cJ/qhJld6l9ssmTfLw==
X-Gm-Gg: AYBFou2nIpgnrKK6ktq5fq9VceJFjxBvuydYC/AzGdnrwmp0UO9v5mQ+BMHHB2Rmq2b
	fBfhGTGYSfx+Rwl4a7Kb36jnZr7SRUjU+hnnvGzRHh+rail8pgCqwNFt6aXS51/9ABOCGdlwSkH
	CWRquCtuGfW9NpYcC+OiGS0VMJJu6THlYPVyAfU2TMryiHw8uPvdrMPwAR7qzuokxz76bsARz1n
	MBtq7FOxFnhbjLdghP6PLb9yuoOGp6f4HncRLaT112GyP2n4HhRY8Sf0oPUZC13KONcHoPn22fk
	lmSmO4IJVfWWPNpXa8jCaUgkD8y/VZXR6SxucrrkD2PPzfDNsp5rXMAu96+yzKdhevzfjlV4tyu
	P+Z9j8b3TvoWcF7bEH1dRW0RNPmdrm0bfhPE=
X-Received: by 2002:a17:907:9491:b0:c12:8a:7d7b with SMTP id a640c23a62f3a-c25efb67d56mr228286366b.1.1788426089051;
        Thu, 03 Sep 2026 02:01:29 -0700 (PDT)
X-Received: by 2002:a17:907:9491:b0:c12:8a:7d7b with SMTP id a640c23a62f3a-c25efb67d56mr228276366b.1.1788426088146;
        Thu, 03 Sep 2026 02:01:28 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eeabbfsm11621531f8f.31.2026.09.03.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:01:26 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:01:22 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <apk1djopa9z3tfYR@leonardi-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>

Hi Ani,

On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
>
>
>> On 1 Sep 2026, at 3:39 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>>
>> The guest policy carried in the IGVM guest-policy initialization header
>> was parsed into QIgvm but never forwarded to the confidential guest
>> platform: the previous callback ran at the end of qigvm_process_file,
>> after LAUNCH_START had already been issued, so writing the policy had
>> no effect.
>>
>> Add a set_guest_policy callback and invoke it from the guest-policy
>> initialization handler, so the policy reaches the platform before
>> LAUNCH_START.
>>
>> The guest policy can also be set on the command line. As it is part of
>> the attestation report, silently overriding it would cause attestation
>> to fail, so return an error if the command-line value differs from the
>> one supplied by the IGVM file.
>>
>> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>> Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>> ---
>> backends/confidential-guest-support.c |  9 ++++++++
>> backends/igvm.c                       |  4 ++++
>> target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
>> 3 files changed, 52 insertions(+)
>>
>> diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>> index a0b36d2da5..c0d15b4a76 100644
>> --- a/backends/confidential-guest-support.c
>> +++ b/backends/confidential-guest-support.c
>> @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>>     return -1;
>> }
>>
>> +static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>> +                            uint64_t policy, Error **errp)
>> +{
>> +    error_setg(errp,
>> +               "Setting guest policy is not supported for this platform");
>> +    return -1;
>> +}
>> +
>> static int set_id_block(void *id_block, uint32_t id_block_size,
>>                         void *id_auth, uint32_t id_auth_size,
>>                         Error **errp)
>> @@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>>     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>     cgsc->check_support = check_support;
>>     cgsc->set_guest_state = set_guest_state;
>> +    cgsc->set_guest_policy = set_guest_policy;
>>     cgsc->set_id_block = set_id_block;
>>     cgsc->get_mem_map_entry = get_mem_map_entry;
>> }
>> diff --git a/backends/igvm.c b/backends/igvm.c
>> index 6545382546..5131ee7829 100644
>> --- a/backends/igvm.c
>> +++ b/backends/igvm.c
>> @@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>>
>>     if (guest->compatibility_mask & ctx->compatibility_mask) {
>>         ctx->sev_policy = guest->policy;
>> +        if (ctx->cgsc) {
>> +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>> +                                               guest->policy, errp);
>> +        }
>>     }
>>     return 0;
>> }
>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index c76cdba8d2..533ea4b54e 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -128,6 +128,8 @@ struct SevCommonState {
>>     bool kernel_hashes;
>>     uint64_t sev_features;
>>     uint64_t supported_sev_features;
>> +    /* whether the guest policy was explicitly set on the command line */
>> +    bool policy_set;
>>
>>     /* runtime state */
>>     uint8_t api_major;
>> @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>>     return 0;
>> }
>>
>> +static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>> +                                uint64_t policy, Error **errp)
>> +{
>> +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>> +
>> +    if (policy_type != GUEST_POLICY_SEV) {
>> +        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
>> +                   policy_type);
>> +        return -1;
>> +    }
>> +
>> +    if (sev_snp_enabled()) {
>> +        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
>> +
>> +        if (sev_common->policy_set &&
>> +            sev_snp_guest->kvm_start_conf.policy != policy) {
>> +            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
>> +            return -1;
>> +        }
>> +
>> +        sev_snp_guest->kvm_start_conf.policy = policy;

Thanks for you review!

>
>I had fixed a bug initially here where we need to check if the policy passed is not 0. I am not sure if that fix is still needed here.
>Please test this scenario:
>a) Generate an IGVM file with policy set to 0.

0 is not a valid sev-snp guest policy: bit 17 is reserved and must be 1.
It's a valid sev/sev-es policy though.

>b) Start a confidential SEV-SNP guest with policy set in command line and with this IGVM.
>I think with your patch this will fail as the policies won’t match.

Correct: this was suggested by Gerd, as this is something unexpected. I
think it would break launch measurement.

>This potentially breaks some tests. For example, with your patch, does my FUKI confidential tests still pass?

To be fair, guest policy set via igvm _never_ worked. Only the policies
set from CLI worked.

That said, I'll try to run your tests.

Luigi

