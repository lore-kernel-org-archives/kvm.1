Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC2378D76
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425212; cv=none; b=LCt/MVWYIy1ZT0G8mBRE7V6C+nphyf6coLk5L+Ug5fkSdhIJ2ULgzTzDVopMy/AAd5kbuDb4PwvNmpbQD74W3LeXPBFRS9wITyLZBxHpMxuaaLIhErqTGr5mzt0AU+AxJADwMUJfz8rSWJJLxklwvWeyP5QuWojMnK6VMOueLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425212; c=relaxed/simple;
	bh=PbC9xQ9Vd4YRFCMXukFOOHWg4SsbcMiZ1ju7Bgw9xIg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mhkaEY1oKTtx6bM9Okee5DLG0B29rmFX1DMawFU1EgMs/rBF2wywoCdaf+zycCliu/3UJc7y//wZNhdBHuatuP1715l3f7bFi2KdknDCDgvnc8DUs39eWEMugQZdd+Oa1qdrbRSmn89eoThUDNDW2hg6mMqauxG7P17YVvKu3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKclnHos; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIuiZXTE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKclnHos";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIuiZXTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788425209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MPh5BUyxyhI23NIB/sy11jij1C7QLXGKYRtAtt8boU=;
	b=VKclnHos0qL4r68O8QJ8OTKuVuhkXbracrl0Rcc7qyzMfRxp3iznCwSPnFv/GS/CT0xrBt
	9m54f9z9rzPXLr9bOW2MVRxvgu2D/GJRlRsIqxEoJdnmDh/2VbD8hiBtDlAjecXvs2okO7
	ztYeFR/dO7AEUoe/AkBrCIq+lVZVJmg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-2NbZVGvoN4ubsWQL4H_-iQ-1; Thu, 03 Sep 2026 04:46:48 -0400
X-MC-Unique: 2NbZVGvoN4ubsWQL4H_-iQ-1
X-Mimecast-MFC-AGG-ID: 2NbZVGvoN4ubsWQL4H_-iQ_1788425207
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-399311947f6so3792137a91.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788425207; x=1789030007; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/MPh5BUyxyhI23NIB/sy11jij1C7QLXGKYRtAtt8boU=;
        b=gIuiZXTEx+j4ILzvXu7YdFY39b/x6CXFB/M5rphtflQOnPrbiZ+H0NwnrAaHlfgng7
         eq3K4WrCRa1L8aUi6FmxeLKTmHVfvjU5PeXpGv0JfpExmHqkZV+tHUjGwm1a9NLa7HBc
         yyjhmvVeF2MRpVRC6JAL1ywJmCTuqsyjI3GGHv/0mJ5GQ+jkJA8sTxaW6WCPAQTiOT2B
         vJjE+ozjrbeqovfn3KtnGgzGxwmounWyhK3s4fwieSV7cRPxeOr/stTBkuOA4FnRvxWW
         CMUsEJavWLCRdaEHQVga4B2Hh2v5mIUGwR4j4tw3LK+j/bbzwg+5yW+UvHwvl3N5PY9B
         nUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425207; x=1789030007;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MPh5BUyxyhI23NIB/sy11jij1C7QLXGKYRtAtt8boU=;
        b=mpIoMEMBMykXrgrHM9uoQnXdoT8U25EOLDlfu2Vhdpxrw22KGgZz15XPfk9Tx1qXD6
         cZ5+aR3hjA6Z3SNUA7p3N5oI1lVH3kLsq+8TWyIF8zjL5kmOj5Zx77dU2Ir8VI/5gNdP
         2+kPsUPZ7V0Ifhp0pArTY1bFZWXD8jCSpxG4vUJnCjScTcCeKRxujBKnXY8ADqvp1VMS
         rmg8LTaRStaChajm2uIkAMk8+U5//tZq1dL3+F3tX1UQ2UlG8dojG3VxLm40VqqblVl4
         j8CjX9uvzeYTFBn2KXvSyy2g8qp6nRP3Dh9Bj/3BrvqfDx1FWNI72A3lrWTXPNc/aKW4
         x21Q==
X-Forwarded-Encrypted: i=1; AKwUvBzSUxGh93JZlwftHCwxGavj0xp9EnULmS4z1mdjpvopGD2W1vDEefgHAcLbOhyhItwifZk=@vger.kernel.org
X-Gm-Message-State: AFuF++nCWncZoJ8bcqZ5ls/ugP2IC4y5K6J4rF4ktm2Nw7RIMNx4WoHN
	gzo4Rhy3sEhDRKbIDnqRjh94A/qikGN3hQpMRT5zpPaPFexAIM8N/+qmaMrt6rGpwSx/SjXy/Y0
	agPDpfFoCuHT+Wh7lhTElskJy4PCy+Vv+eofHyyMn+8fkhSa699XkoQ==
X-Gm-Gg: AYBFou1WphtSgxYDNDZUgiZ5xPxIeWj6g3xLm+Qx45Xzv2Evct7efkeb+4RYXxaaKSI
	YGRz0IyhRmePPFoQyBbawn/jjvZwemnM92ASu9ilqsjID3OpUBtnv8FfFK0K05SUHE4tdFIbM71
	auOfAs8LfKQqjHElJK5BENUto5MarCcFQURoL4IbRNK9Ob9Ke5KnYdhQUiutkbyiPDhATT1RWea
	AGkcll/ze/iAaGz9c6xu7F7az/Ep3OzPzmThQCgUhL8HThXPMJvaZeFqcx1xSHUoIT1HBebygia
	R/3oylXpLatlD0wcIqu4yyEI9iNmdW/SDVEzZ69VmRava1kuSGiHY5aI/qyJCcv46DbnE3K4ST+
	6safyAzpf9jnq/q5gAUvs/wWa/1B6sX7SQ/egSHho5wRT9H1oPxuUn+o=
X-Received: by 2002:a17:90b:548c:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39aede9368amr17337787a91.1.1788425207005;
        Thu, 03 Sep 2026 01:46:47 -0700 (PDT)
X-Received: by 2002:a17:90b:548c:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39aede9368amr17337711a91.1.1788425206463;
        Thu, 03 Sep 2026 01:46:46 -0700 (PDT)
Received: from smtpclient.apple ([106.219.132.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1431994db8csm4119845c88.9.2026.09.03.01.46.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:46:46 -0700 (PDT)
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
In-Reply-To: <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
Date: Thu, 3 Sep 2026 14:16:30 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On 1 Sep 2026, at 3:39=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> The guest policy carried in the IGVM guest-policy initialization =
header
> was parsed into QIgvm but never forwarded to the confidential guest
> platform: the previous callback ran at the end of qigvm_process_file,
> after LAUNCH_START had already been issued, so writing the policy had
> no effect.
>=20
> Add a set_guest_policy callback and invoke it from the guest-policy
> initialization handler, so the policy reaches the platform before
> LAUNCH_START.
>=20
> The guest policy can also be set on the command line. As it is part of
> the attestation report, silently overriding it would cause attestation
> to fail, so return an error if the command-line value differs from the
> one supplied by the IGVM file.
>=20
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
> Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
> backends/confidential-guest-support.c |  9 ++++++++
> backends/igvm.c                       |  4 ++++
> target/i386/sev.c                     | 39 =
+++++++++++++++++++++++++++++++++++
> 3 files changed, 52 insertions(+)
>=20
> diff --git a/backends/confidential-guest-support.c =
b/backends/confidential-guest-support.c
> index a0b36d2da5..c0d15b4a76 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t =
*ptr, uint64_t len,
>     return -1;
> }
>=20
> +static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
> +                            uint64_t policy, Error **errp)
> +{
> +    error_setg(errp,
> +               "Setting guest policy is not supported for this =
platform");
> +    return -1;
> +}
> +
> static int set_id_block(void *id_block, uint32_t id_block_size,
>                         void *id_auth, uint32_t id_auth_size,
>                         Error **errp)
> @@ -62,6 +70,7 @@ static void =
confidential_guest_support_class_init(ObjectClass *oc,
>     ConfidentialGuestSupportClass *cgsc =3D =
CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>     cgsc->check_support =3D check_support;
>     cgsc->set_guest_state =3D set_guest_state;
> +    cgsc->set_guest_policy =3D set_guest_policy;
>     cgsc->set_id_block =3D set_id_block;
>     cgsc->get_mem_map_entry =3D get_mem_map_entry;
> }
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 6545382546..5131ee7829 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -868,6 +868,10 @@ static int =
qigvm_initialization_guest_policy(QIgvm *ctx,
>=20
>     if (guest->compatibility_mask & ctx->compatibility_mask) {
>         ctx->sev_policy =3D guest->policy;
> +        if (ctx->cgsc) {
> +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
> +                                               guest->policy, errp);
> +        }
>     }
>     return 0;
> }
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index c76cdba8d2..533ea4b54e 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -128,6 +128,8 @@ struct SevCommonState {
>     bool kernel_hashes;
>     uint64_t sev_features;
>     uint64_t supported_sev_features;
> +    /* whether the guest policy was explicitly set on the command =
line */
> +    bool policy_set;
>=20
>     /* runtime state */
>     uint8_t api_major;
> @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>     return 0;
> }
>=20
> +static int cgs_set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
> +                                uint64_t policy, Error **errp)
> +{
> +    SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +
> +    if (policy_type !=3D GUEST_POLICY_SEV) {
> +        error_setg(errp, "SEV: Invalid guest policy type provided for =
SEV: %d",
> +                   policy_type);
> +        return -1;
> +    }
> +
> +    if (sev_snp_enabled()) {
> +        SevSnpGuestState *sev_snp_guest =3D =
SEV_SNP_GUEST(sev_common);
> +
> +        if (sev_common->policy_set &&
> +            sev_snp_guest->kvm_start_conf.policy !=3D policy) {
> +            error_setg(errp, "SNP: policy mismatch between IGVM and =
CLI");
> +            return -1;
> +        }
> +
> +        sev_snp_guest->kvm_start_conf.policy =3D policy;

I had fixed a bug initially here where we need to check if the policy =
passed is not 0. I am not sure if that fix is still needed here.
Please test this scenario:
a) Generate an IGVM file with policy set to 0.
b) Start a confidential SEV-SNP guest with policy set in command line =
and with this IGVM.
I think with your patch this will fail as the policies won=E2=80=99t =
match. This potentially breaks some tests. For example, with your patch, =
does my FUKI confidential tests still pass?
c) If b) works, reset the guest and check if the guest is still a =
SEV-SNP guest.
=20

> +    } else {
> +        SevGuestState *sev_guest =3D SEV_GUEST(sev_common);
> +
> +        if (sev_common->policy_set && sev_guest->policy !=3D policy) =
{
> +            error_setg(errp, "SEV: policy mismatch between IGVM and =
CLI");
> +            return -1;
> +        }
> +
> +        sev_guest->policy =3D policy;
> +    }
> +    return 0;
> +}
> +
> static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
>                             void *id_auth, uint32_t id_auth_size,
>                             Error **errp)
> @@ -2848,6 +2884,7 @@ sev_common_instance_init(Object *obj)
>     cgs->check_support =3D cgs_check_support;
>     cgs->set_guest_state =3D cgs_set_guest_state;
>     cgs->get_mem_map_entry =3D cgs_get_mem_map_entry;
> +    cgs->set_guest_policy =3D cgs_set_guest_policy;
>     cgs->set_id_block =3D cgs_set_id_block;
>     cgs->can_rebuild_guest_state =3D true;
>=20
> @@ -2970,6 +3007,7 @@ sev_guest_set_policy(Object *obj, Visitor *v, =
const char *name,
>     if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
>         return;
>     }
> +    SEV_COMMON(obj)->policy_set =3D true;
> }
>=20
> static void
> @@ -3027,6 +3065,7 @@ sev_snp_guest_set_policy(Object *obj, Visitor =
*v, const char *name,
>                            errp)) {
>         return;
>     }
> +    SEV_COMMON(obj)->policy_set =3D true;
> }
>=20
> static char *
>=20
> --=20
> 2.55.0
>=20

