Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D140BCB2
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429838; cv=none; b=kk9lFnUashamXYBAnOXFnjo2ldPTZRiD5KKp5gLb6u+IjiuN33zio+HdkpjnSh7BXrrgsZzUXfcV+n6/4MW1ORJHXyhZMCMWoA0V1qz4PODlfr23LhA5FGSetYwQlqiGF9m+tZhGeaKPo/L/cATnGOjiBeIo+daK+UNKB0yLd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429838; c=relaxed/simple;
	bh=CMyQ3eRUE+vU1AGZI4CJcp0I+EXlkC161HJj/M1H1ts=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JIIxXdg2Q1vzdiH1m5iczGvQxbTa3lf0XBdjKDSvBdvIQwHnYbuHg9WlPkk4dpWvjWLBaKH2HIROqLT5zLrJs54Kd3/h3dxz/jGKMdN68CDtzdEJGUmyXK5JSN57BKgsCIEmfqj1YHGRJX9iSSJ+ZWHK/SH1L8Mjwzf52EYCXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAq4w+p9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9YuHHbU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAq4w+p9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9YuHHbU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788429828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woT1+ZPOXiDcdwXTujdWlBy7LAoncL7qE/P/uU0ietQ=;
	b=dAq4w+p9ukRr+TzfKPNZIARV0Uj6ZIB65c99v5lkpCJlpc/P5yUyWTPDHgF9G5XFgZs+Yj
	4x6n5dSjm/Z02PCBmYVIWTKON+rpHHYjExZHkOGrolxyWsfcAYjFKpMIdEVEy0t1kV9+uB
	GscXFd61qbBvP4b9pWHUndeH1p9fHtk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-4Pbo9FO6MDW473MLywrgCQ-1; Thu, 03 Sep 2026 06:03:47 -0400
X-MC-Unique: 4Pbo9FO6MDW473MLywrgCQ-1
X-Mimecast-MFC-AGG-ID: 4Pbo9FO6MDW473MLywrgCQ_1788429826
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-399311947f6so3896161a91.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 03:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788429826; x=1789034626; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=woT1+ZPOXiDcdwXTujdWlBy7LAoncL7qE/P/uU0ietQ=;
        b=i9YuHHbUhdEyc473nr7fiuwPiXVbDUyE6nHwrBxR5pnJXu7BLz3fNkpRb9Y4G2bHf8
         N+Z+OjmThFkT4ioByrLULd1KLte0iGTW+Ez5Sg5dMSZEjeHNhwXUDb+tfZR2JErV2qoW
         +ETTMMKHzM82tNNye7+cGz0v3K6g7cWrg6XeSM85zHDJmrLcyf4nryIiob28qmFIW9ED
         B1ek5d5gwBahf9XjQyf+eL1l4yWQR4nxhQnfCnNljDPUOEL35jraGLqu1uBlp8U3Zs4a
         KxwMZCgJZssPwkHLtrhbAkZChivou415pucBgD5saPibYLLyTuza/FIH04bdO8N3NNkr
         XBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788429826; x=1789034626;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=woT1+ZPOXiDcdwXTujdWlBy7LAoncL7qE/P/uU0ietQ=;
        b=g8Hwurbs0gh59FRBpebq3WLGtbXVI8bF7x1RKWyFZYimcYkBhd/fhQ2GLxP0yvEXG1
         mYHd6Bz2KBIA3sWtwLAWmISE122TrEwzyVOfQxl8YP4yCEGV/K95zwZAJeztFCQGCfof
         eZwnX7NQcrrnqYxZ5CknfZPdNgDZ3xw1cmYFaneKiadjkFsw2hbL/dCiOX9QrVUlVIDg
         gF4DD2Zjd6Uf/4o50DSX3purxjQvhwMcXh/1f3OjxngDgWiJF738z/Mh+remjQ0PR2Ua
         vBs4MBVqAzdWSSGfOyD44Ycc17oqwR/+1ma4dM298BJ/Bifam6GthyjPPH72oKh54vNY
         LqnA==
X-Forwarded-Encrypted: i=1; AKwUvBwxaguRS4xjghOKXJO4+Z3pwpVKAhTXnr5hDkSZQfvBIUldExSlOfK7eSGqlwu7UYHO1cc=@vger.kernel.org
X-Gm-Message-State: AFuF++lXbsvtBA8H2IQNSIfeGdpySccL0EMErqgI1IMzn1+WturWN48J
	IW6QmmXYGFB5NR4ZAQ6kgIzOXU9vvwt9fzzUjznsBvknsGko7w5bN6tm4T4Nzr2AMwfwvVpm53J
	0zS1NIpyblwSkbFJLDzR9L69vA0I/LLJbA7w2wmu+4bgbSR4U0sWalXu0a3nMGA==
X-Gm-Gg: AYBFou1AJKJMkR/Y6+XFgPkznWImlo46MX0YgSvPfiih6BXEwP5Ttu8zlAZ/5FnvGP8
	c4eF6yAO6okkftrBAJT1nJp4OCZ7A6NQA+TA4oNXhkXRr1eL03g7PK+UcQDB31EjR+HAyGLk7Ww
	AMtjh2xaN0KFyqjQNABgJkJ0yCTrYR8FMzro5Jmokwfgezc3bLy6s7CGGxjMGbDZQjGYwaDsFxc
	rcxpXccSx+6KM6n8TCmSaXbDNBg7K0/zc76yzDRF5mC22yumVJwRUNEIXdOTngBrpfDPozi0B75
	Rl2CZh+6hkhkCngf1qa2MZgWZp5soZq4+9kZItwUrw1haP0/wCwQfkyJx8PmDESKw/tpg6ANhHi
	4A2T/XBbncDTYW/wfb1KBeHlwgNkiSACLvAoCkeO+gOmzsTvvF5HDbZE=
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39aee04acdamr18816777a91.14.1788429826023;
        Thu, 03 Sep 2026 03:03:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39aee04acdamr18816675a91.14.1788429825547;
        Thu, 03 Sep 2026 03:03:45 -0700 (PDT)
Received: from smtpclient.apple ([106.219.132.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325621af3bsm5020819eec.21.2026.09.03.03.03.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 03:03:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <apk1djopa9z3tfYR@leonardi-redhat>
Date: Thu, 3 Sep 2026 15:33:30 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On 3 Sep 2026, at 2:31=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> Hi Ani,
>=20
> On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 1 Sep 2026, at 3:39=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>>>=20
>>> The guest policy carried in the IGVM guest-policy initialization =
header
>>> was parsed into QIgvm but never forwarded to the confidential guest
>>> platform: the previous callback ran at the end of =
qigvm_process_file,
>>> after LAUNCH_START had already been issued, so writing the policy =
had
>>> no effect.
>>>=20
>>> Add a set_guest_policy callback and invoke it from the guest-policy
>>> initialization handler, so the policy reaches the platform before
>>> LAUNCH_START.
>>>=20
>>> The guest policy can also be set on the command line. As it is part =
of
>>> the attestation report, silently overriding it would cause =
attestation
>>> to fail, so return an error if the command-line value differs from =
the
>>> one supplied by the IGVM file.
>>>=20
>>> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>>> Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>> ---
>>> backends/confidential-guest-support.c |  9 ++++++++
>>> backends/igvm.c                       |  4 ++++
>>> target/i386/sev.c                     | 39 =
+++++++++++++++++++++++++++++++++++
>>> 3 files changed, 52 insertions(+)
>>>=20
>>> diff --git a/backends/confidential-guest-support.c =
b/backends/confidential-guest-support.c
>>> index a0b36d2da5..c0d15b4a76 100644
>>> --- a/backends/confidential-guest-support.c
>>> +++ b/backends/confidential-guest-support.c
>>> @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t =
*ptr, uint64_t len,
>>>    return -1;
>>> }
>>>=20
>>> +static int set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
>>> +                            uint64_t policy, Error **errp)
>>> +{
>>> +    error_setg(errp,
>>> +               "Setting guest policy is not supported for this =
platform");
>>> +    return -1;
>>> +}
>>> +
>>> static int set_id_block(void *id_block, uint32_t id_block_size,
>>>                        void *id_auth, uint32_t id_auth_size,
>>>                        Error **errp)
>>> @@ -62,6 +70,7 @@ static void =
confidential_guest_support_class_init(ObjectClass *oc,
>>>    ConfidentialGuestSupportClass *cgsc =3D =
CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>>    cgsc->check_support =3D check_support;
>>>    cgsc->set_guest_state =3D set_guest_state;
>>> +    cgsc->set_guest_policy =3D set_guest_policy;
>>>    cgsc->set_id_block =3D set_id_block;
>>>    cgsc->get_mem_map_entry =3D get_mem_map_entry;
>>> }
>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>> index 6545382546..5131ee7829 100644
>>> --- a/backends/igvm.c
>>> +++ b/backends/igvm.c
>>> @@ -868,6 +868,10 @@ static int =
qigvm_initialization_guest_policy(QIgvm *ctx,
>>>=20
>>>    if (guest->compatibility_mask & ctx->compatibility_mask) {
>>>        ctx->sev_policy =3D guest->policy;
>>> +        if (ctx->cgsc) {
>>> +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>>> +                                               guest->policy, =
errp);
>>> +        }
>>>    }
>>>    return 0;
>>> }
>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>> index c76cdba8d2..533ea4b54e 100644
>>> --- a/target/i386/sev.c
>>> +++ b/target/i386/sev.c
>>> @@ -128,6 +128,8 @@ struct SevCommonState {
>>>    bool kernel_hashes;
>>>    uint64_t sev_features;
>>>    uint64_t supported_sev_features;
>>> +    /* whether the guest policy was explicitly set on the command =
line */
>>> +    bool policy_set;
>>>=20
>>>    /* runtime state */
>>>    uint8_t api_major;
>>> @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>>>    return 0;
>>> }
>>>=20
>>> +static int cgs_set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
>>> +                                uint64_t policy, Error **errp)
>>> +{
>>> +    SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>>> +
>>> +    if (policy_type !=3D GUEST_POLICY_SEV) {
>>> +        error_setg(errp, "SEV: Invalid guest policy type provided =
for SEV: %d",
>>> +                   policy_type);
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (sev_snp_enabled()) {
>>> +        SevSnpGuestState *sev_snp_guest =3D =
SEV_SNP_GUEST(sev_common);
>>> +
>>> +        if (sev_common->policy_set &&
>>> +            sev_snp_guest->kvm_start_conf.policy !=3D policy) {
>>> +            error_setg(errp, "SNP: policy mismatch between IGVM and =
CLI");
>>> +            return -1;
>>> +        }
>>> +
>>> +        sev_snp_guest->kvm_start_conf.policy =3D policy;
>=20
> Thanks for you review!
>=20
>>=20
>> I had fixed a bug initially here where we need to check if the policy =
passed is not 0. I am not sure if that fix is still needed here.
>> Please test this scenario:
>> a) Generate an IGVM file with policy set to 0.
>=20
> 0 is not a valid sev-snp guest policy: bit 17 is reserved and must be =
1.
> It's a valid sev/sev-es policy though.
>=20
>> b) Start a confidential SEV-SNP guest with policy set in command line =
and with this IGVM.
>> I think with your patch this will fail as the policies won=E2=80=99t =
match.
>=20
> Correct: this was suggested by Gerd, as this is something unexpected. =
I
> think it would break launch measurement.

Yes I think the right thing to do is that if the policy is correctly set =
by IGVM, override the one set in the cli with the one in IGVM. Otherwise =
ignore IGVM policy.

>=20
>> This potentially breaks some tests. For example, with your patch, =
does my FUKI confidential tests still pass?
>=20
> To be fair, guest policy set via igvm _never_ worked. Only the =
policies
> set from CLI worked.
>=20
> That said, I'll try to run your tests.
>=20
> Luigi


