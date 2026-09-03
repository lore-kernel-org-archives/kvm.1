Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C43FDBE8
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433354; cv=none; b=P2y65Qtzg2UdklMDhmSF/FBm4dEvef1x8gSQ2Q6DBqjKCYVYnUYsAqfITvJFGRFtuYQldY1gu3XEuGWNQkbeXKNTZMiZQsF51OWEluutcJ8qpALYCAZMmRSRi8M+eAFipQNlelcQjuYTqOmLraHTrt0AWGCrY6EwOTbqcRZqGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433354; c=relaxed/simple;
	bh=B99OP/oISbfJkdzm7enQxx2AHCVtmTArFm/51NTc/Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqVw8GAxgOJRUCYMIyz5s7crs/OItPsbMrJrULTGbiLRm/GMyocqFoDfJioS9NQPQSLSFkAF13Xo7+xqHIC8VHgL/rYlj0xvPwjEhVj9WZ1ANVt+PUK6TQQ1KnhJod6BJ3cETEeZDeC7XpietHGzU1EKcXwNK6iuE5cxkgIKykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEW5Sx0/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pV3wyZ5H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEW5Sx0/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pV3wyZ5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788433351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82nGEyjblHhHI3MrDMVBXgTcu8gABpUQwBchRyQe4V0=;
	b=cEW5Sx0/4nuh9B+ZY9/rshIxrONpDlSFKwGP4tlE1KHDr21scfFxrFgMAbcoIpuadw6Hku
	PRdzjYNgA8hx++BYPGN6Kvz9o0K0alsbzcvQT9+JzZu281IbRnSUhxdRFHsJaTNkkoGZvA
	9YBaKGh3LmzbRUjM7owjHbCDn9pIpQM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-FIHwBFKcOhGSpwE06Ry60w-1; Thu, 03 Sep 2026 07:02:30 -0400
X-MC-Unique: FIHwBFKcOhGSpwE06Ry60w-1
X-Mimecast-MFC-AGG-ID: FIHwBFKcOhGSpwE06Ry60w_1788433349
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49991beee7aso20330005e9.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788433349; x=1789038149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=82nGEyjblHhHI3MrDMVBXgTcu8gABpUQwBchRyQe4V0=;
        b=pV3wyZ5HoeuXqlKLeVZxukAfawif6mkB/mLZQ19fzpSLXKK2FGO1L7LwMm2EbDoiIC
         wXktRyEJj80bmRkImXnhRdsxeMaQoDjgHD45JU1kX3mXLelZjoB8CH/3k2A7VuCDtepV
         E+M3KTqXVDcOn8c3zwJ6Wxua5E08hdDz/Lw63RbGQ8mJDQ4JJT8YJLL86an0bpojaWNR
         bStnjUaBwW9ilQooaEU5QIYbRI4kfQPAKy/gZ2eyNwL2CZvuNCq37v6z+GsZQdq3wzF6
         mTs9BEkFFwmKdqg5gMFpgk1RRLJYFbu6OMh/FdbPoCZMnR/x85yoJfqZVou0+joPq7Q9
         bP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788433349; x=1789038149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=82nGEyjblHhHI3MrDMVBXgTcu8gABpUQwBchRyQe4V0=;
        b=it/iIq40eYjggJI2Ksr8SdZlidv8RCyFMPMlcbw0cdRZ3SThD/m3k80zD1BBlUi+Lg
         X4awDNtSuWm5XdcTnCUGHHOURYV9rzS11iZmEj9vWrb9FPMkks5i20dPlTeuQJ9nZggU
         5LK/p5wzrxV9hZw7dfG+043al7kB5gE051a/E0aHNmQ9KAHWuVRbsqrD9zry9tVdIQj8
         gaAHndppf8AA1e3uqIr1qPPST89YrADtwxIHPSwKtawCo0Xar/s6ehGHuPyYfoQhNv/a
         g6hOU5VBBLC7UkwpYlJPZtmC+0IqtAUztWl+PPX+gCqejHira++mTrj7fOz/jjuwM3G2
         y2Dw==
X-Forwarded-Encrypted: i=1; AKwUvBylrFJaXOrbjbVLqJofJ7a8GVjlQ3mh58sCPolutyyz8DUpaQDF6ODklP5QLSq9vdq0jlg=@vger.kernel.org
X-Gm-Message-State: AFuF++kJ04LCFz/7gQekvapkWZjMk7zv3lGLWGMwFhjDB75oj1o76AAk
	KG9Xcoz61BWzI0Pt3MRbjzNfMg3YgDcSL3Dn3MdAfEMY+MCIrdYoZxgtojhONge1GbW3q/S7QHS
	iSY0EmcKHW01LrESPO0lEB05c3+ZcnXaboNnKWRLZhX8UquRPgqJBHA==
X-Gm-Gg: AYBFou31j3LZmTAOQNQHiLgVSBkaV1Imp/OrVSY0Ya+un7wWn63/f5nCb5yq7amDHFw
	evm3CFAD/t4ASJsLPnm3Tj26aTraVAvrXUKgFKh63dh7fPz4FtIGca0hyjS1VqXJSzxlUM0bR8f
	sTZG9MZj1CxfMPqqGgMZRMye2ICB5lV3RhcZt0ExdvaPpugnHJXtwLvlNNRk8TrTpAgFpx/HilH
	sAFhaJ/0xyekYHB2k+wDi+mhfSyZDgpBJPvVXvM7e1RxOa4LDpI/jbHlJANXlVTmOEgfmiMn42k
	XoNZ1GfA7C16bVBB7A9l2M8x7wMWk7YoVTJRi7WX4UJwOAaEi6fol8ut+sX8biZq8l8v76Odx2S
	gWGA1UCdaeVmWi1SuR2/APGAADiyP9s6S03k=
X-Received: by 2002:a05:600c:1385:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-49ce583e8c8mr187091745e9.9.1788433348885;
        Thu, 03 Sep 2026 04:02:28 -0700 (PDT)
X-Received: by 2002:a05:600c:1385:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-49ce583e8c8mr187091045e9.9.1788433348416;
        Thu, 03 Sep 2026 04:02:28 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d4938sm62531375e9.2.2026.09.03.04.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:02:20 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:02:17 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <aplQKjieyMHUoCWs@leonardi-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
 <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>

On Thu, Sep 03, 2026 at 03:33:30PM +0530, Ani Sinha wrote:
>
>
>> On 3 Sep 2026, at 2:31 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>>
>> Hi Ani,
>>
>> On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
>>>
>>>
>>>> On 1 Sep 2026, at 3:39 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>>>>
>>>> The guest policy carried in the IGVM guest-policy initialization header
>>>> was parsed into QIgvm but never forwarded to the confidential guest
>>>> platform: the previous callback ran at the end of qigvm_process_file,
>>>> after LAUNCH_START had already been issued, so writing the policy had
>>>> no effect.
>>>>
>>>> Add a set_guest_policy callback and invoke it from the guest-policy
>>>> initialization handler, so the policy reaches the platform before
>>>> LAUNCH_START.
>>>>
>>>> The guest policy can also be set on the command line. As it is part of
>>>> the attestation report, silently overriding it would cause attestation
>>>> to fail, so return an error if the command-line value differs from the
>>>> one supplied by the IGVM file.
>>>>
>>>> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>>>> Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>>>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>> ---
>>>> backends/confidential-guest-support.c |  9 ++++++++
>>>> backends/igvm.c                       |  4 ++++
>>>> target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
>>>> 3 files changed, 52 insertions(+)
>>>>
>>>> diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>>>> index a0b36d2da5..c0d15b4a76 100644
>>>> --- a/backends/confidential-guest-support.c
>>>> +++ b/backends/confidential-guest-support.c
>>>> @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>>>>    return -1;
>>>> }
>>>>
>>>> +static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>>> +                            uint64_t policy, Error **errp)
>>>> +{
>>>> +    error_setg(errp,
>>>> +               "Setting guest policy is not supported for this platform");
>>>> +    return -1;
>>>> +}
>>>> +
>>>> static int set_id_block(void *id_block, uint32_t id_block_size,
>>>>                        void *id_auth, uint32_t id_auth_size,
>>>>                        Error **errp)
>>>> @@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>>>>    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>>>    cgsc->check_support = check_support;
>>>>    cgsc->set_guest_state = set_guest_state;
>>>> +    cgsc->set_guest_policy = set_guest_policy;
>>>>    cgsc->set_id_block = set_id_block;
>>>>    cgsc->get_mem_map_entry = get_mem_map_entry;
>>>> }
>>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>>> index 6545382546..5131ee7829 100644
>>>> --- a/backends/igvm.c
>>>> +++ b/backends/igvm.c
>>>> @@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>>>>
>>>>    if (guest->compatibility_mask & ctx->compatibility_mask) {
>>>>        ctx->sev_policy = guest->policy;
>>>> +        if (ctx->cgsc) {
>>>> +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>>>> +                                               guest->policy, errp);
>>>> +        }
>>>>    }
>>>>    return 0;
>>>> }
>>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>>> index c76cdba8d2..533ea4b54e 100644
>>>> --- a/target/i386/sev.c
>>>> +++ b/target/i386/sev.c
>>>> @@ -128,6 +128,8 @@ struct SevCommonState {
>>>>    bool kernel_hashes;
>>>>    uint64_t sev_features;
>>>>    uint64_t supported_sev_features;
>>>> +    /* whether the guest policy was explicitly set on the command line */
>>>> +    bool policy_set;
>>>>
>>>>    /* runtime state */
>>>>    uint8_t api_major;
>>>> @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>>>>    return 0;
>>>> }
>>>>
>>>> +static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>>> +                                uint64_t policy, Error **errp)
>>>> +{
>>>> +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>>>> +
>>>> +    if (policy_type != GUEST_POLICY_SEV) {
>>>> +        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
>>>> +                   policy_type);
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    if (sev_snp_enabled()) {
>>>> +        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
>>>> +
>>>> +        if (sev_common->policy_set &&
>>>> +            sev_snp_guest->kvm_start_conf.policy != policy) {
>>>> +            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
>>>> +            return -1;
>>>> +        }
>>>> +
>>>> +        sev_snp_guest->kvm_start_conf.policy = policy;
>>
>> Thanks for you review!
>>
>>>
>>> I had fixed a bug initially here where we need to check if the policy passed is not 0. I am not sure if that fix is still needed here.
>>> Please test this scenario:
>>> a) Generate an IGVM file with policy set to 0.
>>
>> 0 is not a valid sev-snp guest policy: bit 17 is reserved and must be 1.
>> It's a valid sev/sev-es policy though.
>>
>>> b) Start a confidential SEV-SNP guest with policy set in command line and with this IGVM.
>>> I think with your patch this will fail as the policies won’t match.
>>
>> Correct: this was suggested by Gerd, as this is something unexpected. I
>> think it would break launch measurement.
>
>Yes I think the right thing to do is that if the policy is correctly set by IGVM, override the one set in the cli with the one in IGVM. Otherwise ignore IGVM policy.
>

mmh why? I might be missing something, but for now I'm not really convinced:
if we have a policy set in IGVM we should use that one. Overriding it using the
CLI, may cause measurement failure. If we have an IGVM image with a wrong policy
set, then the problem should be fixed there.

@Gerd @Stefano WDYT?

Luigi

