Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4224AF9CE
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442883; cv=none; b=NVCEv8QUPd7WHEaZCFIMvi7lP6OFBnE89zkuG0THBSGpNEX8uQoJqqRPhCPVMsjtNOLiJyClQ9LRX5TV+GtzIbRgL/BYKPcvi6ZNGoPznTbU/u2ja8wVqEE0GcSAzA3nR6cB+1ml4iNLtAokJeXD0FFdQ2LJ3gGbPAVrfGZzZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442883; c=relaxed/simple;
	bh=snxdgPkYxiN0wklIAHduYOsmdCYXteOdOw/4HjbAsJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM8AG381x7TbD6ZZ5tXkaipAnJdCGJ217Ii0iZlmHowhhHKxKLpOQlhlphwMpexFEuDv35XhU5nnSVS+Dc7O0nmkvxEiBRfN11IQ97gBR9ZFHmIx3KStUl+8B3kiDxDynMnj+s6rxmouH0JGpHou3vxJKz6J1uLHYFqzp9q37Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqqgL+zF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKZiAfA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqqgL+zF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKZiAfA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788442863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8x6S+9/rnrnEQ8TizwcXd1P0Fsb5Qz8XY4KENCYeYjs=;
	b=PqqgL+zFMSMbZPx1xXpc2TcmKRfxL/s3Y9TwwRIjja8NjQg0EEHhQLYtblJOdUZ0lqP9Mx
	3USk8Cu6WF+C6XS7Wx5OQqAoN+DlTG3iunObvku/gMpgsJ1xakzVI1Kn1hpXkkAbXKP82u
	e0nQhcn6U8itC4BDL+tO54811hP+N7M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-KusDzqVNM9mjoS6S89ALlA-1; Thu, 03 Sep 2026 09:41:02 -0400
X-MC-Unique: KusDzqVNM9mjoS6S89ALlA-1
X-Mimecast-MFC-AGG-ID: KusDzqVNM9mjoS6S89ALlA_1788442861
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495569acf8dso14228115e9.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788442861; x=1789047661; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8x6S+9/rnrnEQ8TizwcXd1P0Fsb5Qz8XY4KENCYeYjs=;
        b=XKZiAfA445zNgBgzAZbRGJikqpMN0LPeWGwxLQGMyaXz6+TYoSAR6DAMvzMIPV8bgz
         yhQopLPSE533J8K4BxNrnLRiYRP3ZZgCwEMN4h4B2p3Iv71U5r9oXTB+T04dyLF/p/d5
         rfsMcHIgDJadkhS9JQ/DYLNI4vdCaoh3uj5FyIyufinU3ZGWyAy45HAhimGSb6GAIIRI
         vCUqQAy9J9R/CQR5LBnHmhB8vPase14Sov89GMzRDJsFolmFL3jRcKOGCDfl1DkcUiOn
         8et9sOk2lPGqPY+GzJanpDsbdZlsDtbYFdlf2FQaExrn7tGpAEGHXqr1Vgcs5gE4lfv1
         LzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442861; x=1789047661;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8x6S+9/rnrnEQ8TizwcXd1P0Fsb5Qz8XY4KENCYeYjs=;
        b=EkCin2+wjXvU7KvJlUXT485fXLh2RTefk4SIsON8YOV11OGsNcHD47JpX2JVQFqgTn
         jsfjJJ/E4u0YVB+M1wNB+usfSvcjXgRiXjHQtsx1tepDfG0JgMerfUd13aqm5Iidr2zA
         V6qUE0waWKesZJ1c2cHVenEymhDjQKGi/KGRcG/jtca/e0s7PBMInbACtd6nvclYoZpi
         8+mqv/Sxfbxr4OW/PTx7y10RbqNjFmVM9z2i8HZbJr+0duGgKhT3f49AYb/bh4++wmaX
         KFj0YJnCek9uumNxcht6WjfDkJs9xeqe6qHwVn6vTcR/QRxfCzY8EOqMjTKVP0x/UlFH
         5Bww==
X-Forwarded-Encrypted: i=1; AKwUvBwunMdNu334/Fy1g2lipIkmDZog3OEtYJW7haDnww02EfKrRUvKvuEScX3v+Hr1BL78k/A=@vger.kernel.org
X-Gm-Message-State: AFuF++nWoGpupQJr6i6Xg4j+FiQW36l3L3yx7wtSXtTmX0iy/rLZPbl6
	yTVBfWO7l6x/F85eFlMDLCL0iPpgykEFLRQ4AkXLeTjtdf+H9gvzMOtBxrbC/m/Z1lldcLXYxTa
	Whmnh3MEUjJwMDBcPkYvtlp45cWKZI7Jt3xhZwlcpQ4eiHkgKGhxU6g==
X-Gm-Gg: AYBFou0MGvnm5nWwc05tYrh8fgv2+P36jXuM7FR+9yn8wW9FgbkdQpJqWOqz0xVN4eE
	anPu3WOG4nUs147CnwehXbN58RJ0cSqlWx4h0C9cW+dO40PXficDmkPtM95XN+GrGb85XI229ze
	QF0DkszJpufLT0/dP01iUbsZpLoznIjJLbfmIwYKK6kAzIO6qqOhfGeo0FqV9qYfZIZgPg7qsJl
	v+DkPAysGMq2gsQEZ1RKB8dLwCNjUcw5t7hWcQ9N+l6HGjB1zQ6RaP+aeLC5H6LEExehqzFRD3i
	ZF7rJfdXhhj0h40MilwXRPODhiCU4W/aWpuP7sgFKEm88c97IPb5qeD+E0QVvPbJ/hJQZJ/nS/8
	NhZcObeVoG8ppK/cjRREUxwXk9IUTpcjciSw=
X-Received: by 2002:a05:600c:6209:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49ce582039fmr236993355e9.7.1788442860953;
        Thu, 03 Sep 2026 06:41:00 -0700 (PDT)
X-Received: by 2002:a05:600c:6209:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49ce582039fmr236992585e9.7.1788442860569;
        Thu, 03 Sep 2026 06:41:00 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm88636585e9.9.2026.09.03.06.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:40:59 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:40:57 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <apl3wnsHORCNP4k-@leonardi-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
 <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
 <aplQKjieyMHUoCWs@leonardi-redhat>
 <aplfB4L_WoFdpeBD@redhat.com>
 <aplz6Wvb-IhgUJ59@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aplz6Wvb-IhgUJ59@sgarzare-redhat>

On Thu, Sep 03, 2026 at 03:28:29PM +0200, Stefano Garzarella wrote:
>On Thu, Sep 03, 2026 at 12:50:31PM +0100, Daniel P. Berrangé wrote:
>>On Thu, Sep 03, 2026 at 01:02:17PM +0200, Luigi Leonardi wrote:
>>>On Thu, Sep 03, 2026 at 03:33:30PM +0530, Ani Sinha wrote:
>>>>
>>>>
>>>> > On 3 Sep 2026, at 2:31 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>>>> >
>>>> > Hi Ani,
>>>> >
>>>> > On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
>>>> > >
>>>> > >
>>>> > > > On 1 Sep 2026, at 3:39 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>>>> > > >
>>>> > > > The guest policy carried in the IGVM guest-policy initialization header
>>>> > > > was parsed into QIgvm but never forwarded to the confidential guest
>>>> > > > platform: the previous callback ran at the end of qigvm_process_file,
>>>> > > > after LAUNCH_START had already been issued, so writing the policy had
>>>> > > > no effect.
>>>> > > >
>>>> > > > Add a set_guest_policy callback and invoke it from the guest-policy
>>>> > > > initialization handler, so the policy reaches the platform before
>>>> > > > LAUNCH_START.
>>>> > > >
>>>> > > > The guest policy can also be set on the command line. As it is part of
>>>> > > > the attestation report, silently overriding it would cause attestation
>>>> > > > to fail, so return an error if the command-line value differs from the
>>>> > > > one supplied by the IGVM file.
>>>> > > >
>>>> > > > Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>>>> > > > Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>>>> > > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>> > > > ---
>>>> > > > backends/confidential-guest-support.c |  9 ++++++++
>>>> > > > backends/igvm.c                       |  4 ++++
>>>> > > > target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
>>>> > > > 3 files changed, 52 insertions(+)
>>>> > > >
>>>> > > > diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>>>> > > > index a0b36d2da5..c0d15b4a76 100644
>>>> > > > --- a/backends/confidential-guest-support.c
>>>> > > > +++ b/backends/confidential-guest-support.c
>>>> > > > @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>>>> > > >    return -1;
>>>> > > > }
>>>> > > >
>>>> > > > +static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>>> > > > +                            uint64_t policy, Error **errp)
>>>> > > > +{
>>>> > > > +    error_setg(errp,
>>>> > > > +               "Setting guest policy is not supported for this platform");
>>>> > > > +    return -1;
>>>> > > > +}
>>>> > > > +
>>>> > > > static int set_id_block(void *id_block, uint32_t id_block_size,
>>>> > > >                        void *id_auth, uint32_t id_auth_size,
>>>> > > >                        Error **errp)
>>>> > > > @@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>>>> > > >    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>>> > > >    cgsc->check_support = check_support;
>>>> > > >    cgsc->set_guest_state = set_guest_state;
>>>> > > > +    cgsc->set_guest_policy = set_guest_policy;
>>>> > > >    cgsc->set_id_block = set_id_block;
>>>> > > >    cgsc->get_mem_map_entry = get_mem_map_entry;
>>>> > > > }
>>>> > > > diff --git a/backends/igvm.c b/backends/igvm.c
>>>> > > > index 6545382546..5131ee7829 100644
>>>> > > > --- a/backends/igvm.c
>>>> > > > +++ b/backends/igvm.c
>>>> > > > @@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>>>> > > >
>>>> > > >    if (guest->compatibility_mask & ctx->compatibility_mask) {
>>>> > > >        ctx->sev_policy = guest->policy;
>>>> > > > +        if (ctx->cgsc) {
>>>> > > > +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>>>> > > > +                                               guest->policy, errp);
>>>> > > > +        }
>>>> > > >    }
>>>> > > >    return 0;
>>>> > > > }
>>>> > > > diff --git a/target/i386/sev.c b/target/i386/sev.c
>>>> > > > index c76cdba8d2..533ea4b54e 100644
>>>> > > > --- a/target/i386/sev.c
>>>> > > > +++ b/target/i386/sev.c
>>>> > > > @@ -128,6 +128,8 @@ struct SevCommonState {
>>>> > > >    bool kernel_hashes;
>>>> > > >    uint64_t sev_features;
>>>> > > >    uint64_t supported_sev_features;
>>>> > > > +    /* whether the guest policy was explicitly set on the command line */
>>>> > > > +    bool policy_set;
>>>> > > >
>>>> > > >    /* runtime state */
>>>> > > >    uint8_t api_major;
>>>> > > > @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>>>> > > >    return 0;
>>>> > > > }
>>>> > > >
>>>> > > > +static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>>> > > > +                                uint64_t policy, Error **errp)
>>>> > > > +{
>>>> > > > +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>>>> > > > +
>>>> > > > +    if (policy_type != GUEST_POLICY_SEV) {
>>>> > > > +        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
>>>> > > > +                   policy_type);
>>>> > > > +        return -1;
>>>> > > > +    }
>>>> > > > +
>>>> > > > +    if (sev_snp_enabled()) {
>>>> > > > +        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
>>>> > > > +
>>>> > > > +        if (sev_common->policy_set &&
>>>> > > > +            sev_snp_guest->kvm_start_conf.policy != policy) {
>>>> > > > +            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
>>>> > > > +            return -1;
>>>> > > > +        }
>>>> > > > +
>>>> > > > +        sev_snp_guest->kvm_start_conf.policy = policy;
>>>> >
>>>> > Thanks for you review!
>>>> >
>>>> > >
>>>> > > I had fixed a bug initially here where we need to check if the policy passed is not 0. I am not sure if that fix is still needed here.
>>>> > > Please test this scenario:
>>>> > > a) Generate an IGVM file with policy set to 0.
>>>> >
>>>> > 0 is not a valid sev-snp guest policy: bit 17 is reserved and must be 1.
>>>> > It's a valid sev/sev-es policy though.
>>>> >
>>>> > > b) Start a confidential SEV-SNP guest with policy set in command line and with this IGVM.
>>>> > > I think with your patch this will fail as the policies won’t match.
>>>> >
>>>> > Correct: this was suggested by Gerd, as this is something unexpected. I
>>>> > think it would break launch measurement.
>>>>
>>>> Yes I think the right thing to do is that if the policy is correctly set by IGVM, override the one set in the cli with the one in IGVM. Otherwise ignore IGVM policy.
>>
>>As a general rule, if the user passes a parameter to QEMU, it should
>>always either be honoured, or result in an error. Selectively ignoring
>>user input has proved to be a generally bad idea, as it tends to mask
>>user configuration mistakes.
>>
>>>mmh why? I might be missing something, but for now I'm not really convinced:
>>>if we have a policy set in IGVM we should use that one. Overriding it using the
>>>CLI, may cause measurement failure. If we have an IGVM image with a wrong policy
>>>set, then the problem should be fixed there.
>>
>>If the user choose to override policy on the CLI, isn't it now just
>>their problem to also figure out what the new expected measurement
>>will be ?
>>
>>Why wouldn't we just honour the IGVM by default, and if the CLI
>>has further customizations let them override the IGVM, and leave
>>the user to figure out the implications.
>
>I also slightly prefer this behaviour too, I see some advantages, 
>especially for testing and debugging, where you don't want to 
>regenerate the IGVM. But I don't have a strong opinion on this; if 
>there is a mismatch, though, I agree that it's better to get an error 
>than to ignore the CLI.
>

In this series, if there is a mismatch between IGVM and CLI, QEMU returns an error.
Debugging sounds very reasonable to me, so I'm fine on letting the CLI override IGVM.

Luigi

