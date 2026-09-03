Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DB47DFBC
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435295; cv=none; b=D5bhq9HPOIGlQNe/dtKJRDYuZezDovFMsmKy0TndLxswu4lnmD+8fWDBgfO0EaOotv4XoOaXC11/KnEsseQTBpik6bTJJUexY54i08mCIKujFO26taUM4wUzhxFjGa33jtgHOXxaujA/uVtv9lRzz5IipheMVY4SJVRipdrUD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435295; c=relaxed/simple;
	bh=O6ZA3roMGWV1p/SQHZPIhpW2EPnZLG2i/SvAKtUvf7Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cUR5cjZcdQAgsiFq0T/S7xv3E23Opbfzf0gDt2dzSJ/MHYKOJ+eOkzLCblHDJiJybI+JYmBqO7wolIeCOCRNvDuTd1E8c0iEB5HHZrJT0ktbZR/vv/Ffc5quVRDR/o1QvzLo7XjTvoHYxr9M7ovx2jPeYLph5fGsdzRRC7kA/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSKyBx2S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8vqFoNN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSKyBx2S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8vqFoNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788435289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hu98WTFEbJxJFng2Jtc6JRvUDNGb8+sjyS46BSeuqE=;
	b=eSKyBx2SPPCTjZ6074EVQVz3LsRGrxwX+t4Nf5pwIIwa7TosEvJ/PPu4JWbHxdRbSFQtEc
	8SbXFTYV3kNDHWJd0Sy/E7G/+44M+yG1IcPxrmxx+0sjC4KhBzhLsK1ElDIGoUxvQdNH8I
	9+9OCKdvOK2jI8BYl4ulAVnhsvyXV9Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Fz61fCeaPQupzqwWD0DgNA-1; Thu, 03 Sep 2026 07:34:48 -0400
X-MC-Unique: Fz61fCeaPQupzqwWD0DgNA-1
X-Mimecast-MFC-AGG-ID: Fz61fCeaPQupzqwWD0DgNA_1788435287
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-396638f9a18so3907265a91.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 04:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788435287; x=1789040087; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7hu98WTFEbJxJFng2Jtc6JRvUDNGb8+sjyS46BSeuqE=;
        b=L8vqFoNN90ZKVZwiCLdDFMfqvG9hnm3G+S4HVDvNx7DMzVcCJPf5W48IeJ//vCdz0/
         FVhMnqJKDQll8czPzewZL4NO5IpGED8rKkPgW2dTfjbJgbeFAfD9XKUCOFrdNuzTS/Y7
         fQFKtinqTMSOOBzfJuXe0fV2e/mldLkpwmdg6MbB1KpXn8Os6dOqxjbu+pRGe1x5M5CL
         0G/h2pst85fDoHBAYWV/l3yQQ55fubVf5ZoH7l36UA8P81w8HZS+p5SCRCfZx3WJCgTO
         sflrXoOgX8oGbNZVCI5DFmGBbYEllyTn3ksuaRJHr/dlAqO0MQZnaNKCJlbF31G2MuoV
         cZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788435287; x=1789040087;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7hu98WTFEbJxJFng2Jtc6JRvUDNGb8+sjyS46BSeuqE=;
        b=LoT1+h10i8pvzbG8sxs0oJIWlWD5tabXM7IRMZzXUsaKncBfntHwnAK5VCGNpbk/2/
         9LXRfgyscaDg6git3RXQPV7y6h/NWBvd4m9HVY37gR+jxzIOvrXRHl3ob+rU0tUSsELk
         esFElCD6dBrI33SiSP6KDI6SpG+F0AE+WqnVmhJ9WrlmNWvgZtc6RCsv4X+zJ7uHz2mB
         ck2ee64dnus9c34PLYC8MV9YDOnaw27CgSAtm3BS46ODJuY9BJfw0vQAAzODbScR/ZSJ
         20gLhpa6TrUgdRwbMI5GPGRCEewcV65oROj0p1aV35Od7g/VyctR8MfVe56xzDerp3cN
         WDuQ==
X-Forwarded-Encrypted: i=1; AKwUvBy333/bEirp4tTzJn594qwRMEcBbs35I3XV6CFFS3SB+9Hegrgzp3f+JQlKHgD6U/Cw5OE=@vger.kernel.org
X-Gm-Message-State: AFuF++lDSAQk1lTXq833VGtar5yrf9eErN1uAbk/M/vbOdbtGfx6DJt7
	8twUgLAo51jmvZ1qHQN7hVUEjs4eF9Zf7LRmTMVmOnPyaExlx6RxjGVsvxt/gXpmBcpNzojvSQG
	m0sHQh1HIKw9igh0rAr/N6JD5cWpyloJKq5t2kdL13iMN0+MrQcEH0A==
X-Gm-Gg: AYBFou1DbBnufx5uwRRSmg3aFV4120vS/nt4+nDAmxzNseGUMpqSHH2ZLIuVwhbD5oz
	TxIbROVx8p63hOhmVs44xRzbp3WvfZ26DznaeAfvaAXIXPdPFKmacsmbeNN/R2NG44CsZDlpe14
	WU78EwwulQgbktLIB7N1UAdV/d9QcnPTHPA9fGZuBu+RkXnWt1wzmzijuQImchL55NNNlQn6rVr
	gl4x+FqZ4oh8HipmxdM92dskYcKS0fpSqTcDg6hh0sKmConQoryydFMw6oWChdfn3NfeHzhP9xP
	B26neiVe3ig2kqlYcUByCJ6+UqeG9hFYJXfFtm+8/umgW875MgxFWNAl5DsLxJWhArAPxW2z6+7
	WiNF+rCvC5/tkvY2SACpLvmqs67+gHwypyffCNFkEUbehMPOHkF7JGGo=
X-Received: by 2002:a17:90b:33c4:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-39aedf644damr15748641a91.5.1788435286984;
        Thu, 03 Sep 2026 04:34:46 -0700 (PDT)
X-Received: by 2002:a17:90b:33c4:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-39aedf644damr15748545a91.5.1788435286319;
        Thu, 03 Sep 2026 04:34:46 -0700 (PDT)
Received: from smtpclient.apple ([106.219.132.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1431991f777sm5247192c88.6.2026.09.03.04.34.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 04:34:45 -0700 (PDT)
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
In-Reply-To: <aplQKjieyMHUoCWs@leonardi-redhat>
Date: Thu, 3 Sep 2026 17:04:30 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C703FA43-1512-44C2-8096-DC97ACA40692@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
 <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
 <aplQKjieyMHUoCWs@leonardi-redhat>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On 3 Sep 2026, at 4:32=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> On Thu, Sep 03, 2026 at 03:33:30PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 3 Sep 2026, at 2:31=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>>>=20
>>> Hi Ani,
>>>=20
>>> On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
>>>>=20
>>>>=20
>>>>> On 1 Sep 2026, at 3:39=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>>>>>=20
>>>>> The guest policy carried in the IGVM guest-policy initialization =
header
>>>>> was parsed into QIgvm but never forwarded to the confidential =
guest
>>>>> platform: the previous callback ran at the end of =
qigvm_process_file,
>>>>> after LAUNCH_START had already been issued, so writing the policy =
had
>>>>> no effect.
>>>>>=20
>>>>> Add a set_guest_policy callback and invoke it from the =
guest-policy
>>>>> initialization handler, so the policy reaches the platform before
>>>>> LAUNCH_START.
>>>>>=20
>>>>> The guest policy can also be set on the command line. As it is =
part of
>>>>> the attestation report, silently overriding it would cause =
attestation
>>>>> to fail, so return an error if the command-line value differs from =
the
>>>>> one supplied by the IGVM file.
>>>>>=20
>>>>> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>>>>> Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>>>>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>>> ---
>>>>> backends/confidential-guest-support.c |  9 ++++++++
>>>>> backends/igvm.c                       |  4 ++++
>>>>> target/i386/sev.c                     | 39 =
+++++++++++++++++++++++++++++++++++
>>>>> 3 files changed, 52 insertions(+)
>>>>>=20
>>>>> diff --git a/backends/confidential-guest-support.c =
b/backends/confidential-guest-support.c
>>>>> index a0b36d2da5..c0d15b4a76 100644
>>>>> --- a/backends/confidential-guest-support.c
>>>>> +++ b/backends/confidential-guest-support.c
>>>>> @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t =
*ptr, uint64_t len,
>>>>>   return -1;
>>>>> }
>>>>>=20
>>>>> +static int set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
>>>>> +                            uint64_t policy, Error **errp)
>>>>> +{
>>>>> +    error_setg(errp,
>>>>> +               "Setting guest policy is not supported for this =
platform");
>>>>> +    return -1;
>>>>> +}
>>>>> +
>>>>> static int set_id_block(void *id_block, uint32_t id_block_size,
>>>>>                       void *id_auth, uint32_t id_auth_size,
>>>>>                       Error **errp)
>>>>> @@ -62,6 +70,7 @@ static void =
confidential_guest_support_class_init(ObjectClass *oc,
>>>>>   ConfidentialGuestSupportClass *cgsc =3D =
CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>>>>   cgsc->check_support =3D check_support;
>>>>>   cgsc->set_guest_state =3D set_guest_state;
>>>>> +    cgsc->set_guest_policy =3D set_guest_policy;
>>>>>   cgsc->set_id_block =3D set_id_block;
>>>>>   cgsc->get_mem_map_entry =3D get_mem_map_entry;
>>>>> }
>>>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>>>> index 6545382546..5131ee7829 100644
>>>>> --- a/backends/igvm.c
>>>>> +++ b/backends/igvm.c
>>>>> @@ -868,6 +868,10 @@ static int =
qigvm_initialization_guest_policy(QIgvm *ctx,
>>>>>=20
>>>>>   if (guest->compatibility_mask & ctx->compatibility_mask) {
>>>>>       ctx->sev_policy =3D guest->policy;
>>>>> +        if (ctx->cgsc) {
>>>>> +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>>>>> +                                               guest->policy, =
errp);
>>>>> +        }
>>>>>   }
>>>>>   return 0;
>>>>> }
>>>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>>>> index c76cdba8d2..533ea4b54e 100644
>>>>> --- a/target/i386/sev.c
>>>>> +++ b/target/i386/sev.c
>>>>> @@ -128,6 +128,8 @@ struct SevCommonState {
>>>>>   bool kernel_hashes;
>>>>>   uint64_t sev_features;
>>>>>   uint64_t supported_sev_features;
>>>>> +    /* whether the guest policy was explicitly set on the command =
line */
>>>>> +    bool policy_set;
>>>>>=20
>>>>>   /* runtime state */
>>>>>   uint8_t api_major;
>>>>> @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>>>>>   return 0;
>>>>> }
>>>>>=20
>>>>> +static int cgs_set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
>>>>> +                                uint64_t policy, Error **errp)
>>>>> +{
>>>>> +    SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>>>>> +
>>>>> +    if (policy_type !=3D GUEST_POLICY_SEV) {
>>>>> +        error_setg(errp, "SEV: Invalid guest policy type provided =
for SEV: %d",
>>>>> +                   policy_type);
>>>>> +        return -1;
>>>>> +    }
>>>>> +
>>>>> +    if (sev_snp_enabled()) {
>>>>> +        SevSnpGuestState *sev_snp_guest =3D =
SEV_SNP_GUEST(sev_common);
>>>>> +
>>>>> +        if (sev_common->policy_set &&
>>>>> +            sev_snp_guest->kvm_start_conf.policy !=3D policy) {
>>>>> +            error_setg(errp, "SNP: policy mismatch between IGVM =
and CLI");
>>>>> +            return -1;
>>>>> +        }
>>>>> +
>>>>> +        sev_snp_guest->kvm_start_conf.policy =3D policy;
>>>=20
>>> Thanks for you review!
>>>=20
>>>>=20
>>>> I had fixed a bug initially here where we need to check if the =
policy passed is not 0. I am not sure if that fix is still needed here.
>>>> Please test this scenario:
>>>> a) Generate an IGVM file with policy set to 0.
>>>=20
>>> 0 is not a valid sev-snp guest policy: bit 17 is reserved and must =
be 1.
>>> It's a valid sev/sev-es policy though.
>>>=20
>>>> b) Start a confidential SEV-SNP guest with policy set in command =
line and with this IGVM.
>>>> I think with your patch this will fail as the policies won=E2=80=99t =
match.
>>>=20
>>> Correct: this was suggested by Gerd, as this is something =
unexpected. I
>>> think it would break launch measurement.
>>=20
>> Yes I think the right thing to do is that if the policy is correctly =
set by IGVM, override the one set in the cli with the one in IGVM. =
Otherwise ignore IGVM policy.
>>=20
>=20
> mmh why? I might be missing something, but for now I'm not really =
convinced:
> if we have a policy set in IGVM we should use that one.

That is what I said. =E2=80=9COverride the one set in cli with the one =
in IGVM=E2=80=9D. The exception is that if the policy in igvm is wrong =
(say set to 0 for sev-snp case). In that case, ignore igvm one.

> Overriding it using the
> CLI, may cause measurement failure. If we have an IGVM image with a =
wrong policy
> set, then the problem should be fixed there.
>=20
> @Gerd @Stefano WDYT?
>=20
> Luigi


