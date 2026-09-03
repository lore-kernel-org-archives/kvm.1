Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082244AF9F4
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442130; cv=none; b=CXCRfE4L5EhM4x3Dy3T1ZMY0SiBkbfTwrg4e3c8sAVu1JDxAGVmnWhJOTP4heEcrNm5gIWiAQ19YFP5L2aCIgkrm5pj/yuTcaFmJtbFxdBODH3gbcNHKZ6tT0FYilFe1BuTcuLI//1tp6VmSTUMlLmFfLJ21Bha3+lgSc+Xh5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442130; c=relaxed/simple;
	bh=Lrll82es5ns2K1+BtPFiMgHkdgBWMMZ6rFY2Gk+RYKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIgA1dza83l9ZryNeexEvyPVs4pCjb1QCuIRVX/SJhOW9GZdDJBIQUbUs5OPv2jFRIDJ8nlUdbWPEu2M7QF0T2IuHZ9wC9uF4baOJ7BsAxINiv+eQFSkeDyUe/E9LnBRnELeH8gxHrGpatJ+CFv732kIGlRp/7+3vTO8JzVxCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1YJwsv6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHko6JyI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1YJwsv6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHko6JyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788442120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1YQDulG6r6hFOLVcE9RErPq4iQ9rHI7teEokaBs1pM=;
	b=V1YJwsv6aWbh5TXBEXfouRru8uabcJxkB0wD1O1smUIeXVXPokNVzaKfCZQrRp+acowlOz
	+7wJvFKZ3lsyWaW1dB9evas/faDcp6In0GFLuf4jYRn2d190oZ9DNxSXsq3rjF5xL4kUYa
	BTIbJ1HnMrqkoiH0UITt3HOzWlbwzqk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-jijY78HUOfGySkgyN87IYQ-1; Thu, 03 Sep 2026 09:28:38 -0400
X-MC-Unique: jijY78HUOfGySkgyN87IYQ-1
X-Mimecast-MFC-AGG-ID: jijY78HUOfGySkgyN87IYQ_1788442117
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482e2541c30so719286f8f.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788442117; x=1789046917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c1YQDulG6r6hFOLVcE9RErPq4iQ9rHI7teEokaBs1pM=;
        b=gHko6JyICyuayOpCsvojp/yQgUWm5FJVxuYf0Pv1vdcJbSNampKCmKkNYej4wtTE6F
         qpw94oMY2XjSDi4+Wiu4UnxumW0ZgdqdjC48ljwnEi4rx/3q7bkbSW+4tDXuKMzdZSvl
         ceGzmNhitfnjESuoD35n9c9QOCB2L+mw1wQGUfJ4p4riguy+gJOOtLMfOtaw8Iy18NaC
         bWJqX5iKyD/naz+oTrUO/z9V34PczvzyTlFwhP9ZdpoPfE/JmlD6u07w0Qkyk8k0SXRc
         +wwdvWhScSg7+s0sEklhqS6VXWgVyNzgWxyv5KDrll6cn2ckOPg65HQ0NShjmSmSyEsg
         SnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442117; x=1789046917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c1YQDulG6r6hFOLVcE9RErPq4iQ9rHI7teEokaBs1pM=;
        b=pYmm7mc8LhcqvSFpo1rvLDI/tEWiBo/YhA4A4B8WzvUbduo4LLEErZtM1sIgfLE6l2
         u5Uf2EBIonAY14wHoq8SIyW0uchX+D4aswfCGbspS4e+63zz5M6El0TrYtYgscas6XwR
         xD1CZ3i4Wy1isqDdL+xAF9K6eJYzA0Fhc4hZCxh3Ke+r9IalLp12GuplVLZcTDEpYN1K
         orbuJa78NwRa2iCEXRGxLsoX25a3EsiPcxIfCv85CwMTrVZXuiLYzZPhcfqsuv4RcSla
         hA6e9I9nJIr2xr9GVPjp1yrGLY/K5nbgFVLVNnNd9Tr8nETIcNQI5PiPhWAtteKhjvBR
         oQpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxOE0wuwcHqhrQro05D6AbmKAIgFvexU3BQbef8eIf+BYdxjCFOJ5h6SILkGQ7za2KTnY=@vger.kernel.org
X-Gm-Message-State: AFuF++nc2QC56/Tj8L60N+jJeo8WSUEbE3XimSV5/4hlJ+m80bb+rEPc
	Odk5ZZiNBKPc2hZO/bv7jWZA2Gof+7Uol+WlLt98Ns3zql07je3hNr8043Ody3jTCpplYRY3XdY
	OBXh8bPbFw29sOuOMc5Kkl3FwQpmi/azWHEk955rFO9YpmYMutLRj3g==
X-Gm-Gg: AYBFou1dxce9CABnZFgTrt+20P6e6Nh55fs3m3+ha3S8W0RZPTXpvLJC3K/3QaaJcFp
	esHAIV7SGyzO7ijD7r5WxTbcW30kMpFDGcKVqksitUZq5zE2dzGjm0Dnyk7hJfPnzcVcscgH8A9
	g4fwn73slPgmgQytPORn9DRXrSczBtk4DEbvjIW+jGXR35scSUDor2h4z7OCr0Z0w0hLqyKiyGe
	xhE85Dg965GAatJv2ThTo3zAJ5g286oyn9ltbBZJ79tmNYby/GlAelhxCn77pHDdsl4N5Bk/ulZ
	Ou4mfPtZppVFdGWowiw+XrCnZ9ORYu9E34xM2ZoRCj6uKoTRyJGuBtSjE0f0GKBfRnT6lK0VU+k
	N6wQkAw5OTOEul3nvsf1D7nvgamBwApxcvBrkqFA9zIlp3Q==
X-Received: by 2002:a05:6000:bc2:b0:484:4779:bcd6 with SMTP id ffacd0b85a97d-4857e63715fmr6630033f8f.15.1788442117032;
        Thu, 03 Sep 2026 06:28:37 -0700 (PDT)
X-Received: by 2002:a05:6000:bc2:b0:484:4779:bcd6 with SMTP id ffacd0b85a97d-4857e63715fmr6629977f8f.15.1788442116445;
        Thu, 03 Sep 2026 06:28:36 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492ce236sm16215287f8f.35.2026.09.03.06.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:28:35 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:28:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
	qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <aplz6Wvb-IhgUJ59@sgarzare-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
 <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
 <aplQKjieyMHUoCWs@leonardi-redhat>
 <aplfB4L_WoFdpeBD@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aplfB4L_WoFdpeBD@redhat.com>

On Thu, Sep 03, 2026 at 12:50:31PM +0100, Daniel P. Berrangé wrote:
>On Thu, Sep 03, 2026 at 01:02:17PM +0200, Luigi Leonardi wrote:
>> On Thu, Sep 03, 2026 at 03:33:30PM +0530, Ani Sinha wrote:
>> >
>> >
>> > > On 3 Sep 2026, at 2:31 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>> > >
>> > > Hi Ani,
>> > >
>> > > On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
>> > > >
>> > > >
>> > > > > On 1 Sep 2026, at 3:39 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>> > > > >
>> > > > > The guest policy carried in the IGVM guest-policy initialization header
>> > > > > was parsed into QIgvm but never forwarded to the confidential guest
>> > > > > platform: the previous callback ran at the end of qigvm_process_file,
>> > > > > after LAUNCH_START had already been issued, so writing the policy had
>> > > > > no effect.
>> > > > >
>> > > > > Add a set_guest_policy callback and invoke it from the guest-policy
>> > > > > initialization handler, so the policy reaches the platform before
>> > > > > LAUNCH_START.
>> > > > >
>> > > > > The guest policy can also be set on the command line. As it is part of
>> > > > > the attestation report, silently overriding it would cause attestation
>> > > > > to fail, so return an error if the command-line value differs from the
>> > > > > one supplied by the IGVM file.
>> > > > >
>> > > > > Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>> > > > > Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>> > > > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>> > > > > ---
>> > > > > backends/confidential-guest-support.c |  9 ++++++++
>> > > > > backends/igvm.c                       |  4 ++++
>> > > > > target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
>> > > > > 3 files changed, 52 insertions(+)
>> > > > >
>> > > > > diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>> > > > > index a0b36d2da5..c0d15b4a76 100644
>> > > > > --- a/backends/confidential-guest-support.c
>> > > > > +++ b/backends/confidential-guest-support.c
>> > > > > @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>> > > > >    return -1;
>> > > > > }
>> > > > >
>> > > > > +static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>> > > > > +                            uint64_t policy, Error **errp)
>> > > > > +{
>> > > > > +    error_setg(errp,
>> > > > > +               "Setting guest policy is not supported for this platform");
>> > > > > +    return -1;
>> > > > > +}
>> > > > > +
>> > > > > static int set_id_block(void *id_block, uint32_t id_block_size,
>> > > > >                        void *id_auth, uint32_t id_auth_size,
>> > > > >                        Error **errp)
>> > > > > @@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>> > > > >    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>> > > > >    cgsc->check_support = check_support;
>> > > > >    cgsc->set_guest_state = set_guest_state;
>> > > > > +    cgsc->set_guest_policy = set_guest_policy;
>> > > > >    cgsc->set_id_block = set_id_block;
>> > > > >    cgsc->get_mem_map_entry = get_mem_map_entry;
>> > > > > }
>> > > > > diff --git a/backends/igvm.c b/backends/igvm.c
>> > > > > index 6545382546..5131ee7829 100644
>> > > > > --- a/backends/igvm.c
>> > > > > +++ b/backends/igvm.c
>> > > > > @@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>> > > > >
>> > > > >    if (guest->compatibility_mask & ctx->compatibility_mask) {
>> > > > >        ctx->sev_policy = guest->policy;
>> > > > > +        if (ctx->cgsc) {
>> > > > > +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>> > > > > +                                               guest->policy, errp);
>> > > > > +        }
>> > > > >    }
>> > > > >    return 0;
>> > > > > }
>> > > > > diff --git a/target/i386/sev.c b/target/i386/sev.c
>> > > > > index c76cdba8d2..533ea4b54e 100644
>> > > > > --- a/target/i386/sev.c
>> > > > > +++ b/target/i386/sev.c
>> > > > > @@ -128,6 +128,8 @@ struct SevCommonState {
>> > > > >    bool kernel_hashes;
>> > > > >    uint64_t sev_features;
>> > > > >    uint64_t supported_sev_features;
>> > > > > +    /* whether the guest policy was explicitly set on the command line */
>> > > > > +    bool policy_set;
>> > > > >
>> > > > >    /* runtime state */
>> > > > >    uint8_t api_major;
>> > > > > @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>> > > > >    return 0;
>> > > > > }
>> > > > >
>> > > > > +static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>> > > > > +                                uint64_t policy, Error **errp)
>> > > > > +{
>> > > > > +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>> > > > > +
>> > > > > +    if (policy_type != GUEST_POLICY_SEV) {
>> > > > > +        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
>> > > > > +                   policy_type);
>> > > > > +        return -1;
>> > > > > +    }
>> > > > > +
>> > > > > +    if (sev_snp_enabled()) {
>> > > > > +        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
>> > > > > +
>> > > > > +        if (sev_common->policy_set &&
>> > > > > +            sev_snp_guest->kvm_start_conf.policy != policy) {
>> > > > > +            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
>> > > > > +            return -1;
>> > > > > +        }
>> > > > > +
>> > > > > +        sev_snp_guest->kvm_start_conf.policy = policy;
>> > >
>> > > Thanks for you review!
>> > >
>> > > >
>> > > > I had fixed a bug initially here where we need to check if the policy passed is not 0. I am not sure if that fix is still needed here.
>> > > > Please test this scenario:
>> > > > a) Generate an IGVM file with policy set to 0.
>> > >
>> > > 0 is not a valid sev-snp guest policy: bit 17 is reserved and must be 1.
>> > > It's a valid sev/sev-es policy though.
>> > >
>> > > > b) Start a confidential SEV-SNP guest with policy set in command line and with this IGVM.
>> > > > I think with your patch this will fail as the policies won’t match.
>> > >
>> > > Correct: this was suggested by Gerd, as this is something unexpected. I
>> > > think it would break launch measurement.
>> >
>> > Yes I think the right thing to do is that if the policy is correctly set by IGVM, override the one set in the cli with the one in IGVM. Otherwise ignore IGVM policy.
>
>As a general rule, if the user passes a parameter to QEMU, it should
>always either be honoured, or result in an error. Selectively ignoring
>user input has proved to be a generally bad idea, as it tends to mask
>user configuration mistakes.
>
>> mmh why? I might be missing something, but for now I'm not really convinced:
>> if we have a policy set in IGVM we should use that one. Overriding it using the
>> CLI, may cause measurement failure. If we have an IGVM image with a wrong policy
>> set, then the problem should be fixed there.
>
>If the user choose to override policy on the CLI, isn't it now just
>their problem to also figure out what the new expected measurement
>will be ?
>
>Why wouldn't we just honour the IGVM by default, and if the CLI
>has further customizations let them override the IGVM, and leave
>the user to figure out the implications.

I also slightly prefer this behaviour too, I see some advantages, 
especially for testing and debugging, where you don't want to regenerate 
the IGVM. But I don't have a strong opinion on this; if there is a 
mismatch, though, I agree that it's better to get an error than to 
ignore the CLI.

Thanks,
Stefano

